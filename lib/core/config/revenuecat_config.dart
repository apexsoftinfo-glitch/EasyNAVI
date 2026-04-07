import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'app_config.dart';

abstract class RevenueCatConfig {
  static bool isEnabled = false;
  static bool isTestStore = false;
}

Future<bool> configureRevenueCat() async {
  if (AppConfig.isRevenueCatSupportedPlatform) {
    // In debug mode, prefer Test Store key if available.
    // In release mode, always use real platform keys.
    final useTestStore =
        kDebugMode && AppConfig.hasRevenueCatTestStoreKey;
    final rcApiKey = useTestStore
        ? AppConfig.revenueCatTestStoreApiKey
        : AppConfig.currentRevenueCatApiKey;
    if (rcApiKey.isNotEmpty) {
      await Purchases.configure(PurchasesConfiguration(rcApiKey));
      RevenueCatConfig.isEnabled = true;
      RevenueCatConfig.isTestStore = useTestStore;
      if (useTestStore) {
        debugPrint('ℹ️ [RC] Using Test Store key (debug mode)');
      }
      return true;
    }
  }
  debugPrint(
    '⚠️ [RC] RevenueCat disabled (web=$kIsWeb, platform=$defaultTargetPlatform, emptyApiKey=${AppConfig.currentRevenueCatApiKey.isEmpty})',
  );
  return false;
}
