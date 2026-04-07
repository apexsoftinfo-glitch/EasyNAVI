import 'package:flutter/widgets.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/config/app_config.dart';
import 'subscription_data_source.dart';

/// Real RevenueCat implementation of [SubscriptionDataSource].
///
/// Activated automatically when RevenueCat API keys are configured in
/// `config/api-keys.json`. When no keys are present, DI falls back to
/// [FakeSubscriptionDataSource].
///
/// Entitlement flow:
/// 1. [watchIsPro] seeds from [Purchases.getCustomerInfo] on first call.
/// 2. [Purchases.addCustomerInfoUpdateListener] pushes real-time updates
///    (purchase, renewal, expiry, billing issue).
/// 3. [AppLifecycleListener] refetches on foreground resume — catches
///    purchases made outside the app (e.g. App Store, family sharing).
///
/// Identity is managed externally by [SessionRepository] via
/// [Purchases.logIn] / [Purchases.logOut]. This data source only reads
/// entitlement state — it never calls logIn/logOut itself.
class RevenueCatSubscriptionDataSource implements SubscriptionDataSource {
  RevenueCatSubscriptionDataSource() {
    // Global listener — fires on any CustomerInfo change (purchase, restore,
    // renewal, expiry, billing issue). We update the current user's stream.
    Purchases.addCustomerInfoUpdateListener(_onCustomerInfoUpdated);

    // Refetch entitlements when app returns to foreground. This catches
    // purchases completed in the App Store or Google Play while the app
    // was backgrounded.
    _lifecycleListener = AppLifecycleListener(
      onStateChange: _onAppLifecycleStateChanged,
    );
  }

  /// The RevenueCat entitlement identifier to check for Pro status.
  /// Configured via REVENUECAT_ENTITLEMENT_ID in config/api-keys.json.
  /// Must match the entitlement ID in the RevenueCat dashboard
  /// (e.g. "chess_openings_pro", "app2_pro").
  static String get _entitlementId => AppConfig.revenueCatEntitlementId;

  // Stored to prevent garbage collection — listener must stay alive.
  // ignore: unused_field
  late final AppLifecycleListener _lifecycleListener;

  /// One BehaviorSubject per userId. When the user switches, old controllers
  /// are closed and removed — mirrors the pattern in FakeSubscriptionDataSource.
  final _controllers = <String, BehaviorSubject<bool>>{};

  /// Tracks the currently active userId so the global listener knows which
  /// controller to update.
  String? _activeUserId;

  // ---------------------------------------------------------------------------
  // SubscriptionDataSource interface
  // ---------------------------------------------------------------------------

  @override
  Stream<bool> watchIsPro(String userId) {
    debugPrint(
      'ℹ️ [RC SubscriptionDataSource] watchIsPro subscribed userId=$userId',
    );

    final controller = _controllerFor(userId);
    _activeUserId = userId;

    // Seed the stream with the current entitlement state from RevenueCat.
    _fetchAndEmitProStatus(userId);

    return controller.stream.distinct();
  }

  @override
  Future<bool> getIsPro(String userId) async {
    final customerInfo = await Purchases.getCustomerInfo();
    final isPro = _hasPro(customerInfo);
    debugPrint(
      'ℹ️ [RC SubscriptionDataSource] getIsPro userId=$userId isPro=$isPro',
    );
    return isPro;
  }

  @override
  Future<void> purchasePro(String userId) async {
    debugPrint(
      'ℹ️ [RC SubscriptionDataSource] purchasePro started userId=$userId',
    );

    // Present the RevenueCat paywall UI. It shows available packages with
    // prices and handles the entire purchase flow. If the user already has
    // the entitlement, the paywall is not shown.
    //
    // The CustomerInfo listener will automatically update the isPro stream
    // when the purchase is processed by RevenueCat.
    final result = await RevenueCatUI.presentPaywallIfNeeded(
      _entitlementId,
      displayCloseButton: true,
    );

    switch (result) {
      case PaywallResult.purchased:
      case PaywallResult.restored:
        debugPrint(
          '✅ [RC SubscriptionDataSource] purchasePro succeeded '
          'result=$result userId=$userId',
        );
      case PaywallResult.notPresented:
        debugPrint(
          'ℹ️ [RC SubscriptionDataSource] paywall not presented — '
          'user already has entitlement userId=$userId',
        );
      case PaywallResult.cancelled:
        debugPrint(
          'ℹ️ [RC SubscriptionDataSource] paywall cancelled by user',
        );
        throw StateError('purchase_cancelled');
      case PaywallResult.error:
        debugPrint(
          '❌ [RC SubscriptionDataSource] paywall error userId=$userId',
        );
        throw StateError('purchase_error');
    }
  }

  @override
  Future<void> setDeveloperProOverride({
    required String userId,
    required bool isPro,
  }) async {
    // No-op when RevenueCat is active — Pro status is driven by real purchases.
    debugPrint(
      'ℹ️ [RC SubscriptionDataSource] setDeveloperProOverride ignored '
      '(RevenueCat is active) userId=$userId isPro=$isPro',
    );
  }

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------

  /// Creates or retrieves the BehaviorSubject for [userId], closing any
  /// controller belonging to a different user.
  BehaviorSubject<bool> _controllerFor(String userId) {
    return _controllers.putIfAbsent(userId, () {
      // Clean up previous user's controller to avoid stale listeners.
      for (final entry in _controllers.entries.toList()) {
        if (entry.key != userId) {
          entry.value.close();
          _controllers.remove(entry.key);
        }
      }
      debugPrint(
        'ℹ️ [RC SubscriptionDataSource] Creating controller '
        'userId=$userId initialIsPro=false',
      );
      return BehaviorSubject<bool>.seeded(false);
    });
  }

  /// Fetches the latest [CustomerInfo] from RevenueCat and emits the Pro
  /// status to the controller for [userId]. On failure, propagates the error
  /// through the stream so the Cubit/UI layer can display it.
  Future<void> _fetchAndEmitProStatus(String userId) async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      final isPro = _hasPro(customerInfo);
      final controller = _controllers[userId];
      if (controller != null && !controller.isClosed) {
        controller.add(isPro);
      }
      debugPrint(
        'ℹ️ [RC SubscriptionDataSource] seeded isPro=$isPro userId=$userId',
      );
    } catch (error) {
      debugPrint(
        '❌ [RC SubscriptionDataSource] seed fetch error: $error',
      );
      final controller = _controllers[userId];
      if (controller != null && !controller.isClosed) {
        controller.addError(error);
      }
    }
  }

  /// Called by [Purchases.addCustomerInfoUpdateListener] whenever entitlements
  /// change. Updates the active user's stream.
  void _onCustomerInfoUpdated(CustomerInfo customerInfo) {
    final userId = _activeUserId;
    if (userId == null) return;

    final isPro = _hasPro(customerInfo);
    final controller = _controllers[userId];
    if (controller != null && !controller.isClosed) {
      controller.add(isPro);
      debugPrint(
        'ℹ️ [RC SubscriptionDataSource] listener update '
        'isPro=$isPro userId=$userId',
      );
    }
  }

  /// Refetch entitlements when the app returns to the foreground.
  void _onAppLifecycleStateChanged(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final userId = _activeUserId;
      if (userId != null) {
        debugPrint(
          'ℹ️ [RC SubscriptionDataSource] foreground resume — refetching',
        );
        _fetchAndEmitProStatus(userId);
      }
    }
  }

  /// Checks whether [customerInfo] has an active "pro" entitlement.
  bool _hasPro(CustomerInfo customerInfo) {
    return customerInfo.entitlements.active.containsKey(_entitlementId);
  }
}
