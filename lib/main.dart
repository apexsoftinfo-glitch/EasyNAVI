import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'core/config/api_keys.dart';
import 'core/config/app_config.dart';

import 'core/di/injection.dart';

void main() async {
  // ignore: avoid_print
  print('🚀 [main] starting app');
  WidgetsFlutterBinding.ensureInitialized();

  if (AppConfig.hasSupabaseKeys) {
    // ignore: avoid_print
    print('ℹ️ [main] initializing Supabase');
    try {
      await Supabase.initialize(
        url: ApiKeys.supabaseUrl,
        anonKey: ApiKeys.supabaseAnonKey,
      ).timeout(const Duration(seconds: 10));
      // ignore: avoid_print
      print('✅ [main] Supabase initialized');
    } catch (e) {
      // ignore: avoid_print
      print('❌ [main] Supabase initialization failed: $e');
    }
  }

  // ignore: avoid_print
  print('ℹ️ [main] configuring dependencies');
  await configureDependencies();
  // ignore: avoid_print
  print('✅ [main] initialization complete, running app');
  runApp(App(hasSupabaseKeys: AppConfig.hasSupabaseKeys));
}
