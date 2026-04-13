import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/user_settings_model.dart';

abstract class UserSettingsDataSource {
  Future<UserSettingsModel?> fetchSettings(String userId);
  Future<void> saveSettings(String userId, UserSettingsModel settings);
}

@LazySingleton(as: UserSettingsDataSource)
class SupabaseUserSettingsDataSource implements UserSettingsDataSource {
  final SupabaseClient _supabaseClient;

  SupabaseUserSettingsDataSource(this._supabaseClient);

  static const _tableName = 'easynavi_settings';

  @override
  Future<UserSettingsModel?> fetchSettings(String userId) async {
    try {
      final response = await _supabaseClient
          .from(_tableName)
          .select()
          .eq('user_id', userId)
          .maybeSingle();

      if (response == null) return null;
      
      return UserSettingsModel.fromJson(response['settings'] as Map<String, dynamic>);
    } catch (e) {
      // If table doesn't exist or other error, return null
      return null;
    }
  }

  @override
  Future<void> saveSettings(String userId, UserSettingsModel settings) async {
    await _supabaseClient.from(_tableName).upsert({
      'user_id': userId,
      'settings': settings.toJson(),
      'updated_at': DateTime.now().toIso8601String(),
    });
  }
}
