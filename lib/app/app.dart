import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../features/connectivity/presentation/cubit/connectivity_cubit.dart';
import '../features/connectivity/presentation/widgets/connectivity_banner.dart';
import '../l10n/l10n.dart';
import 'locale/presentation/cubit/app_locale_cubit.dart';
import 'navigation/session_navigation_observer.dart';
import 'router/app_gate.dart';
import 'session/presentation/cubit/session_cubit.dart';
import 'ui/missing_supabase_keys_screen.dart';

class App extends StatelessWidget {
  const App({required this.hasSupabaseKeys, super.key});

  final bool hasSupabaseKeys;

  @override
  Widget build(BuildContext context) {
    // ConnectivityCubit is provided above MaterialApp so every screen in the
    // app can read the current connectivity state and the ConnectivityBanner
    // (placed inside MaterialApp) can show/hide the offline strip.
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppLocaleCubit>.value(value: GetIt.I<AppLocaleCubit>()),
        BlocProvider<ConnectivityCubit>.value(
          value: GetIt.I<ConnectivityCubit>(),
        ),
      ],
      child: BlocBuilder<AppLocaleCubit, AppLocaleState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'XII',
            debugShowCheckedModeBanner: false,
            locale: state.localeOrNull,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            // ConnectivityBanner sits between MaterialApp and the shell.
            // It shows a red strip at the top when offline and hides it
            // when the connection is restored. Does not block interaction.
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
    return hasSupabaseKeys
        ? BlocProvider<SessionCubit>.value(
            value: GetIt.I<SessionCubit>(),
            child: const SessionNavigationObserver(child: AppGate()),
          )
        : const MissingSupabaseKeysScreen();
  }
}
