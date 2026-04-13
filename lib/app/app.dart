import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../features/connectivity/presentation/cubit/connectivity_cubit.dart';
import '../features/connectivity/presentation/widgets/connectivity_banner.dart';
import '../l10n/l10n.dart';
import 'appearance/presentation/cubit/app_appearance_cubit.dart';
import 'navigation/session_navigation_observer.dart';
import 'router/app_gate.dart';
import 'session/presentation/cubit/session_cubit.dart';
import 'ui/missing_supabase_keys_screen.dart';

class App extends StatelessWidget {
  const App({required this.hasSupabaseKeys, super.key});

  final bool hasSupabaseKeys;

  @override
  Widget build(BuildContext context) {
    debugPrint('🏗️ [App] building');
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppAppearanceCubit>.value(
          value: GetIt.I<AppAppearanceCubit>(),
        ),
        BlocProvider<ConnectivityCubit>.value(
          value: GetIt.I<ConnectivityCubit>(),
        ),
      ],
      child: BlocBuilder<AppAppearanceCubit, AppAppearanceState>(
        builder: (context, state) {
          debugPrint('🏗️ [App] MaterialApp building locale=${state.selectedLocale}');
          return MaterialApp(
            title: 'EasyNAVI',
            debugShowCheckedModeBanner: false,
            locale: state.localeOrNull,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            home: ConnectivityBanner(
              child: _AppShell(hasSupabaseKeys: hasSupabaseKeys),
            ),
          );
        },
      ),
    );
  }
}

class _AppShell extends StatelessWidget {
  const _AppShell({required this.hasSupabaseKeys});

  final bool hasSupabaseKeys;

  @override
  Widget build(BuildContext context) {
    debugPrint('🏗️ [_AppShell] building hasSupabaseKeys=$hasSupabaseKeys');
    return hasSupabaseKeys
        ? BlocProvider<SessionCubit>.value(
            value: GetIt.I<SessionCubit>(),
            child: const SessionNavigationObserver(child: AppGate()),
          )
        : const MissingSupabaseKeysScreen();
  }
}
