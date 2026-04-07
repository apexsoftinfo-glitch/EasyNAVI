import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../features/profiles/models/shared_user_app_model.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/error_messages.dart';
import '../cubit/account_actions_cubit.dart';
import '../cubit/delete_account_preflight_cubit.dart';

class DeleteAccountConfirmationScreen extends StatelessWidget {
  const DeleteAccountConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeleteAccountPreflightCubit>(
          create: (_) => getIt<DeleteAccountPreflightCubit>(),
        ),
        BlocProvider<AccountActionsCubit>(
          create: (_) => getIt<AccountActionsCubit>(),
        ),
      ],
      child: const _ConfirmationView(),
    );
  }
}

class _ConfirmationView extends StatefulWidget {
  const _ConfirmationView();

  @override
  State<_ConfirmationView> createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<_ConfirmationView> {
  bool _checkboxChecked = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<AccountActionsCubit, AccountActionsState>(
      listener: (context, state) {
        if (state.successKey == 'account_deleted') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.deleteAccountSuccessSnackbar)),
          );
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.deleteAccountConfirmationTitle)),
        body: SafeArea(
          child: BlocBuilder<DeleteAccountPreflightCubit,
              DeleteAccountPreflightState>(
            builder: (context, preflightState) {
              return switch (preflightState) {
                DeleteAccountPreflightLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                // P1: On error, degrade to empty list — don't block deletion.
                DeleteAccountPreflightError() => _DeleteContent(
                    otherApps: const [],
                    checkboxChecked: _checkboxChecked,
                    onCheckboxChanged: (value) {
                      setState(() => _checkboxChecked = value ?? false);
                    },
                  ),
                DeleteAccountPreflightLoaded(:final otherApps) =>
                  _DeleteContent(
                    otherApps: otherApps,
                    checkboxChecked: _checkboxChecked,
                    onCheckboxChanged: (value) {
                      setState(() => _checkboxChecked = value ?? false);
                    },
                  ),
              };
            },
          ),
        ),
      ),
    );
  }
}

class _DeleteContent extends StatelessWidget {
  const _DeleteContent({
    required this.otherApps,
    required this.checkboxChecked,
    required this.onCheckboxChanged,
  });

  final List<SharedUserAppModel> otherApps;
  final bool checkboxChecked;
  final ValueChanged<bool?> onCheckboxChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasOtherApps = otherApps.isNotEmpty;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.deleteAccountPermanentWarning,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (hasOtherApps) ...[
                const SizedBox(height: 24),
                Text(
                  l10n.deleteAccountOtherAppsWarning,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ...otherApps.map(
                  (app) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        const Text('  \u2014  '),
                        Expanded(child: Text(app.appName)),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              CheckboxListTile(
                value: checkboxChecked,
                onChanged: onCheckboxChanged,
                title: Text(
                  hasOtherApps
                      ? l10n.deleteAccountCheckboxLabel
                      : l10n.deleteAccountCheckboxLabelSimple,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),
              BlocBuilder<AccountActionsCubit, AccountActionsState>(
                builder: (context, accountState) {
                  final isDeleting =
                      accountState.activeAction == AccountAction.deleteAccount;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FilledButton(
                        onPressed: checkboxChecked && !isDeleting
                            ? () => context
                                .read<AccountActionsCubit>()
                                .deleteAccount()
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.error,
                          foregroundColor:
                              Theme.of(context).colorScheme.onError,
                        ),
                        child: isDeleting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(l10n.deleteAccountConfirmButton),
                      ),
                      if (accountState.errorKey != null) ...[
                        const SizedBox(height: 16),
                        SelectableText(
                          messageForErrorKey(l10n, accountState.errorKey),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
