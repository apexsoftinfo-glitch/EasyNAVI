import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../core/config/revenuecat_config.dart';
import '../../../profiles/data/datasources/shared_user_apps_data_source.dart';
import '../../models/auth_principal_model.dart';
import '../datasources/auth_data_source.dart';

abstract class AuthRepository {
  Stream<AuthPrincipalModel?> watchPrincipal();

  AuthPrincipalModel? get currentPrincipal;

  Future<void> continueAsGuest();

  Future<void> loginWithEmail({
    required String email,
    required String password,
  });

  Future<void> upgradeAnonymousWithEmail({
    required String email,
    required String password,
  });

  Future<void> deleteAccount();

  Future<void> signOut();
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authDataSource, this._sharedUserAppsDataSource);

  final AuthDataSource _authDataSource;
  final SharedUserAppsDataSource _sharedUserAppsDataSource;

  @override
  Stream<AuthPrincipalModel?> watchPrincipal() {
    return _authDataSource.watchPrincipal().map((rawPrincipal) {
      final principal = _mapPrincipal(rawPrincipal);
      debugPrint(
        'ℹ️ [AuthRepository] principal emission ${_describePrincipal(principal)}',
      );
      return principal;
    });
  }

  @override
  AuthPrincipalModel? get currentPrincipal =>
      _mapPrincipal(_authDataSource.currentPrincipal);

  @override
  Future<void> continueAsGuest() async {
    try {
      debugPrint('ℹ️ [AuthRepository] continueAsGuest started');
      await _authDataSource.signInAnonymously();
      debugPrint('✅ [AuthRepository] continueAsGuest succeeded');
    } catch (error) {
      debugPrint('❌ [AuthRepository] continueAsGuest error: $error');
      rethrow;
    }
  }

  @override
  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('ℹ️ [AuthRepository] loginWithEmail started email=$email');
      await _authDataSource.signInWithEmail(email: email, password: password);
      debugPrint('✅ [AuthRepository] loginWithEmail succeeded email=$email');
      _registerCurrentApp();
    } catch (error) {
      debugPrint('❌ [AuthRepository] loginWithEmail error: $error');
      rethrow;
    }
  }

  @override
  Future<void> upgradeAnonymousWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint(
        'ℹ️ [AuthRepository] upgradeAnonymousWithEmail started email=$email',
      );
      await _authDataSource.upgradeAnonymousWithEmail(
        email: email,
        password: password,
      );
      debugPrint(
        '✅ [AuthRepository] upgradeAnonymousWithEmail succeeded email=$email',
      );
      _registerCurrentApp();
    } catch (error) {
      debugPrint('❌ [AuthRepository] upgradeAnonymousWithEmail error: $error');
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      debugPrint('ℹ️ [AuthRepository] deleteAccount started');
      await _logOutRevenueCat();
      await _authDataSource.deleteAccount();
      debugPrint('✅ [AuthRepository] deleteAccount succeeded');
    } catch (error) {
      debugPrint('❌ [AuthRepository] deleteAccount error: $error');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      debugPrint('ℹ️ [AuthRepository] signOut started');
      await _logOutRevenueCat();
      await _authDataSource.signOut();
      debugPrint('✅ [AuthRepository] signOut succeeded');
    } catch (error) {
      debugPrint('❌ [AuthRepository] signOut error: $error');
      rethrow;
    }
  }

  /// Registers the current app in shared_user_apps. Fire-and-forget.
  void _registerCurrentApp() {
    if (!_sharedUserAppsDataSource.isConfigured) return;

    final principal = currentPrincipal;
    if (principal == null) return;

    _sharedUserAppsDataSource
        .upsertCurrentApp(userId: principal.userId)
        .catchError((Object error) {
      debugPrint(
        '⚠️ [AuthRepository] registerCurrentApp error (non-blocking): $error',
      );
    });
  }

  /// Clears RevenueCat identity so the next session starts fresh.
  /// Errors are logged but do not block the sign-out flow.
  Future<void> _logOutRevenueCat() async {
    if (!RevenueCatConfig.isEnabled) return;

    try {
      await Purchases.logOut();
      debugPrint('ℹ️ [AuthRepository] RC logOut succeeded');
    } catch (error) {
      // logOutWithAnonymousUserError is expected if RC has no identified user.
      // Non-blocking — RC cleanup failure must not prevent sign-out.
      debugPrint('⚠️ [AuthRepository] RC logOut error (non-blocking): $error');
    }
  }

  AuthPrincipalModel? _mapPrincipal(Map<String, dynamic>? raw) {
    if (raw == null) return null;

    return AuthPrincipalModel(
      userId: raw['user_id'] as String,
      email: raw['email'] as String?,
      isAnonymous: raw['is_anonymous'] as bool? ?? false,
    );
  }

  String _describePrincipal(AuthPrincipalModel? principal) {
    if (principal == null) return 'none';

    return 'userId=${principal.userId} email=${principal.email ?? "-"} anonymous=${principal.isAnonymous}';
  }
}
