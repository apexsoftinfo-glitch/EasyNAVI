// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:myapp/app/locale/data/datasources/app_locale_data_source.dart'
    as _i634;
import 'package:myapp/app/locale/data/repositories/app_locale_repository.dart'
    as _i910;
import 'package:myapp/app/locale/presentation/cubit/app_locale_cubit.dart'
    as _i686;
import 'package:myapp/app/profile/presentation/cubit/account_actions_cubit.dart'
    as _i639;
import 'package:myapp/app/profile/presentation/cubit/delete_account_preflight_cubit.dart'
    as _i833;
import 'package:myapp/app/session/data/repositories/session_repository.dart'
    as _i526;
import 'package:myapp/app/session/presentation/cubit/session_cubit.dart'
    as _i934;
import 'package:myapp/core/di/app_module.dart' as _i832;
import 'package:myapp/features/addresses/data/datasources/addresses_data_source.dart'
    as _i174;
import 'package:myapp/features/addresses/domain/repositories/addresses_repository.dart'
    as _i19;
import 'package:myapp/features/addresses/presentation/cubit/address_form_cubit.dart'
    as _i30;
import 'package:myapp/features/addresses/presentation/cubit/addresses_cubit.dart'
    as _i1042;
import 'package:myapp/features/auth/data/datasources/auth_data_source.dart'
    as _i538;
import 'package:myapp/features/auth/data/repositories/auth_repository.dart'
    as _i37;
import 'package:myapp/features/auth/presentation/cubit/login_cubit.dart'
    as _i918;
import 'package:myapp/features/auth/presentation/cubit/register_cubit.dart'
    as _i27;
import 'package:myapp/features/auth/presentation/cubit/welcome_cubit.dart'
    as _i491;
import 'package:myapp/features/connectivity/data/datasources/connectivity_data_source.dart'
    as _i895;
import 'package:myapp/features/connectivity/data/repositories/connectivity_repository.dart'
    as _i220;
import 'package:myapp/features/connectivity/presentation/cubit/connectivity_cubit.dart'
    as _i165;
import 'package:myapp/features/profiles/data/datasources/shared_user_apps_data_source.dart'
    as _i842;
import 'package:myapp/features/profiles/data/datasources/shared_user_data_source.dart'
    as _i381;
import 'package:myapp/features/profiles/data/repositories/shared_user_apps_repository.dart'
    as _i504;
import 'package:myapp/features/profiles/data/repositories/shared_user_repository.dart'
    as _i636;
import 'package:myapp/features/profiles/presentation/cubit/profile_cubit.dart'
    as _i463;
import 'package:myapp/features/subscription/data/datasources/subscription_data_source.dart'
    as _i138;
import 'package:myapp/features/subscription/data/repositories/subscription_repository.dart'
    as _i894;
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
    gh.lazySingleton<_i138.SubscriptionDataSource>(
      () => appModule.subscriptionDataSource,
    );
    gh.lazySingleton<_i174.AddressesDataSource>(
      () => _i174.AddressesDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i894.SubscriptionRepository>(
      () =>
          _i894.SubscriptionRepositoryImpl(gh<_i138.SubscriptionDataSource>()),
    );
    gh.lazySingleton<_i634.AppLocaleDataSource>(
      () => _i634.SharedPreferencesAppLocaleDataSource(
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i381.SharedUserDataSource>(
      () => _i381.SupabaseSharedUserDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i895.ConnectivityDataSource>(
      () => _i895.InternetConnectionDataSource(gh<_i161.InternetConnection>()),
    );
    gh.lazySingleton<_i538.AuthDataSource>(
      () => _i538.SupabaseAuthDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i910.AppLocaleRepository>(
      () => _i910.AppLocaleRepositoryImpl(gh<_i634.AppLocaleDataSource>()),
    );
    gh.lazySingleton<_i19.AddressesRepository>(
      () => _i19.AddressesRepositoryImpl(gh<_i174.AddressesDataSource>()),
    );
    gh.lazySingleton<_i842.SharedUserAppsDataSource>(
      () => _i842.SupabaseSharedUserAppsDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i30.AddressFormCubit>(
      () => _i30.AddressFormCubit(
        gh<_i19.AddressesRepository>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i220.ConnectivityRepository>(
      () =>
          _i220.ConnectivityRepositoryImpl(gh<_i895.ConnectivityDataSource>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i636.SharedUserRepository>(
      () => _i636.SharedUserRepositoryImpl(gh<_i381.SharedUserDataSource>()),
    );
    gh.factory<_i463.ProfileCubit>(
      () => _i463.ProfileCubit(gh<_i636.SharedUserRepository>()),
    );
    gh.lazySingleton<_i686.AppLocaleCubit>(
      () => _i686.AppLocaleCubit(gh<_i910.AppLocaleRepository>()),
    );
    gh.lazySingleton<_i504.SharedUserAppsRepository>(
      () => _i504.SharedUserAppsRepositoryImpl(
        gh<_i842.SharedUserAppsDataSource>(),
      ),
    );
    gh.factory<_i1042.AddressesCubit>(
      () => _i1042.AddressesCubit(gh<_i19.AddressesRepository>()),
    );
    gh.lazySingleton<_i37.AuthRepository>(
      () => _i37.AuthRepositoryImpl(
        gh<_i538.AuthDataSource>(),
        gh<_i842.SharedUserAppsDataSource>(),
      ),
    );
    gh.lazySingleton<_i165.ConnectivityCubit>(
      () => _i165.ConnectivityCubit(gh<_i220.ConnectivityRepository>()),
    );
    gh.factory<_i833.DeleteAccountPreflightCubit>(
      () => _i833.DeleteAccountPreflightCubit(
        gh<_i504.SharedUserAppsRepository>(),
      ),
    );
    gh.factory<_i918.LoginCubit>(
      () => _i918.LoginCubit(gh<_i37.AuthRepository>()),
    );
    gh.factory<_i27.RegisterCubit>(
      () => _i27.RegisterCubit(gh<_i37.AuthRepository>()),
    );
    gh.factory<_i491.WelcomeCubit>(
      () => _i491.WelcomeCubit(gh<_i37.AuthRepository>()),
    );
    gh.factory<_i639.AccountActionsCubit>(
      () => _i639.AccountActionsCubit(
        gh<_i37.AuthRepository>(),
        gh<_i894.SubscriptionRepository>(),
      ),
    );
    gh.lazySingleton<_i526.SessionRepository>(
      () => _i526.SessionRepositoryImpl(
        gh<_i37.AuthRepository>(),
        gh<_i636.SharedUserRepository>(),
        gh<_i894.SubscriptionRepository>(),
      ),
    );
    gh.lazySingleton<_i934.SessionCubit>(
      () => _i934.SessionCubit(gh<_i526.SessionRepository>()),
    );
    return this;
  }
}

class _$AppModule extends _i832.AppModule {}
