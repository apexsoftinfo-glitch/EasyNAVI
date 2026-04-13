// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:easynavi/app/appearance/data/repositories/app_appearance_repository.dart'
    as _i604;
import 'package:easynavi/app/appearance/presentation/cubit/app_appearance_cubit.dart'
    as _i635;
import 'package:easynavi/app/locale/data/datasources/app_locale_data_source.dart'
    as _i617;
import 'package:easynavi/app/locale/data/repositories/app_locale_repository.dart'
    as _i1055;
import 'package:easynavi/app/locale/presentation/cubit/app_locale_cubit.dart'
    as _i1019;
import 'package:easynavi/app/session/data/repositories/session_repository.dart'
    as _i913;
import 'package:easynavi/app/session/presentation/cubit/session_cubit.dart'
    as _i825;
import 'package:easynavi/app/settings/data/datasources/user_settings_data_source.dart'
    as _i531;
import 'package:easynavi/app/settings/data/repositories/user_settings_repository.dart'
    as _i228;
import 'package:easynavi/app/voice/data/repositories/app_voice_repository.dart'
    as _i1030;
import 'package:easynavi/app/voice/presentation/cubit/app_voice_cubit.dart'
    as _i516;
import 'package:easynavi/core/di/app_module.dart' as _i1039;
import 'package:easynavi/core/services/device_service.dart' as _i307;
import 'package:easynavi/core/services/location_service.dart' as _i690;
import 'package:easynavi/core/services/voice_navigation_service.dart' as _i244;
import 'package:easynavi/features/addresses/data/datasources/addresses_data_source.dart'
    as _i916;
import 'package:easynavi/features/addresses/domain/repositories/addresses_repository.dart'
    as _i47;
import 'package:easynavi/features/addresses/domain/repositories/maps_repository.dart'
    as _i578;
import 'package:easynavi/features/addresses/presentation/cubit/address_form_cubit.dart'
    as _i770;
import 'package:easynavi/features/addresses/presentation/cubit/addresses_cubit.dart'
    as _i105;
import 'package:easynavi/features/addresses/presentation/cubit/maps_search_cubit.dart'
    as _i362;
import 'package:easynavi/features/auth/data/datasources/auth_data_source.dart'
    as _i873;
import 'package:easynavi/features/auth/data/repositories/auth_repository.dart'
    as _i723;
import 'package:easynavi/features/auth/presentation/cubit/login_cubit.dart'
    as _i394;
import 'package:easynavi/features/auth/presentation/cubit/register_cubit.dart'
    as _i717;
import 'package:easynavi/features/auth/presentation/cubit/welcome_cubit.dart'
    as _i644;
import 'package:easynavi/features/connectivity/data/datasources/connectivity_data_source.dart'
    as _i426;
import 'package:easynavi/features/connectivity/data/repositories/connectivity_repository.dart'
    as _i459;
import 'package:easynavi/features/connectivity/presentation/cubit/connectivity_cubit.dart'
    as _i570;
import 'package:easynavi/features/drive/domain/repositories/directions_repository.dart'
    as _i807;
import 'package:easynavi/features/drive/presentation/cubit/drive_cubit.dart'
    as _i181;
import 'package:easynavi/features/profiles/data/datasources/shared_user_apps_data_source.dart'
    as _i977;
import 'package:easynavi/features/profiles/data/datasources/shared_user_data_source.dart'
    as _i559;
import 'package:easynavi/features/profiles/data/repositories/shared_user_apps_repository.dart'
    as _i201;
import 'package:easynavi/features/profiles/data/repositories/shared_user_repository.dart'
    as _i677;
import 'package:easynavi/features/profiles/presentation/cubit/profile_cubit.dart'
    as _i747;
import 'package:easynavi/features/profiles/presentation/cubit/sync_cubit.dart'
    as _i129;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i454.SupabaseClient>(() => appModule.supabaseClient);
    gh.lazySingleton<_i161.InternetConnection>(
      () => appModule.internetConnection,
    );
    gh.lazySingleton<_i361.Dio>(() => appModule.dio);
    gh.lazySingleton<_i807.DirectionsRepository>(
      () => _i807.DirectionsRepositoryImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i307.DeviceService>(() => _i307.DeviceServiceImpl());
    gh.lazySingleton<_i916.AddressesDataSource>(
      () => _i916.AddressesDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i690.LocationService>(() => _i690.LocationServiceImpl());
    gh.lazySingleton<_i578.MapsRepository>(
      () => _i578.MapsRepositoryImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i559.SharedUserDataSource>(
      () => _i559.SupabaseSharedUserDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i977.SharedUserAppsDataSource>(
      () => _i977.SupabaseSharedUserAppsDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i873.AuthDataSource>(
      () => _i873.SupabaseAuthDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i426.ConnectivityDataSource>(
      () => _i426.InternetConnectionDataSource(gh<_i161.InternetConnection>()),
    );
    gh.lazySingleton<_i617.AppLocaleDataSource>(
      () => _i617.SharedPreferencesAppLocaleDataSource(
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i1030.AppVoiceRepository>(
      () => _i1030.AppVoiceRepositoryImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i531.UserSettingsDataSource>(
      () => _i531.SupabaseUserSettingsDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i723.AuthRepository>(
      () => _i723.AuthRepositoryImpl(
        gh<_i873.AuthDataSource>(),
        gh<_i977.SharedUserAppsDataSource>(),
      ),
    );
    gh.factory<_i362.MapsSearchCubit>(
      () => _i362.MapsSearchCubit(gh<_i578.MapsRepository>()),
    );
    gh.lazySingleton<_i604.AppAppearanceRepository>(
      () => _i604.AppAppearanceRepositoryImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i47.AddressesRepository>(
      () => _i47.AddressesRepositoryImpl(gh<_i916.AddressesDataSource>()),
    );
    gh.factory<_i770.AddressFormCubit>(
      () => _i770.AddressFormCubit(
        gh<_i47.AddressesRepository>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i459.ConnectivityRepository>(
      () =>
          _i459.ConnectivityRepositoryImpl(gh<_i426.ConnectivityDataSource>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i1055.AppLocaleRepository>(
      () => _i1055.AppLocaleRepositoryImpl(gh<_i617.AppLocaleDataSource>()),
    );
    gh.lazySingleton<_i677.SharedUserRepository>(
      () => _i677.SharedUserRepositoryImpl(gh<_i559.SharedUserDataSource>()),
    );
    gh.lazySingleton<_i201.SharedUserAppsRepository>(
      () => _i201.SharedUserAppsRepositoryImpl(
        gh<_i977.SharedUserAppsDataSource>(),
      ),
    );
    gh.lazySingleton<_i913.SessionRepository>(
      () => _i913.SessionRepositoryImpl(
        gh<_i723.AuthRepository>(),
        gh<_i677.SharedUserRepository>(),
      ),
    );
    gh.lazySingleton<_i244.NavigationVoiceService>(
      () => _i244.NavigationVoiceService(gh<_i1030.AppVoiceRepository>()),
    );
    gh.factory<_i394.LoginCubit>(
      () => _i394.LoginCubit(gh<_i723.AuthRepository>()),
    );
    gh.factory<_i717.RegisterCubit>(
      () => _i717.RegisterCubit(gh<_i723.AuthRepository>()),
    );
    gh.factory<_i644.WelcomeCubit>(
      () => _i644.WelcomeCubit(gh<_i723.AuthRepository>()),
    );
    gh.lazySingleton<_i228.UserSettingsRepository>(
      () => _i228.UserSettingsRepositoryImpl(
        gh<_i531.UserSettingsDataSource>(),
        gh<_i454.SupabaseClient>(),
        gh<_i604.AppAppearanceRepository>(),
        gh<_i1030.AppVoiceRepository>(),
      ),
    );
    gh.factory<_i105.AddressesCubit>(
      () => _i105.AddressesCubit(
        gh<_i47.AddressesRepository>(),
        gh<_i578.MapsRepository>(),
      ),
    );
    gh.lazySingleton<_i825.SessionCubit>(
      () => _i825.SessionCubit(gh<_i913.SessionRepository>()),
    );
    gh.factory<_i181.DriveCubit>(
      () => _i181.DriveCubit(
        gh<_i807.DirectionsRepository>(),
        gh<_i244.NavigationVoiceService>(),
        gh<_i690.LocationService>(),
        gh<_i307.DeviceService>(),
      ),
    );
    gh.lazySingleton<_i1019.AppLocaleCubit>(
      () => _i1019.AppLocaleCubit(gh<_i1055.AppLocaleRepository>()),
    );
    gh.factory<_i129.SyncCubit>(
      () => _i129.SyncCubit(
        gh<_i47.AddressesRepository>(),
        gh<_i228.UserSettingsRepository>(),
      ),
    );
    gh.lazySingleton<_i570.ConnectivityCubit>(
      () => _i570.ConnectivityCubit(gh<_i459.ConnectivityRepository>()),
    );
    gh.factory<_i747.ProfileCubit>(
      () => _i747.ProfileCubit(
        gh<_i677.SharedUserRepository>(),
        gh<_i723.AuthRepository>(),
      ),
    );
    gh.lazySingleton<_i516.AppVoiceCubit>(
      () => _i516.AppVoiceCubit(
        gh<_i1030.AppVoiceRepository>(),
        gh<_i228.UserSettingsRepository>(),
      ),
    );
    gh.singleton<_i635.AppAppearanceCubit>(
      () => _i635.AppAppearanceCubit(
        gh<_i604.AppAppearanceRepository>(),
        gh<_i228.UserSettingsRepository>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i1039.AppModule {}
