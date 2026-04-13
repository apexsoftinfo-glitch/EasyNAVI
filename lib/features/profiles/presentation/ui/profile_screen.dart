import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/locale/presentation/cubit/app_locale_cubit.dart';
import '../../../../app/developer/ui/developer_screen.dart';
import '../../../../app/profile/presentation/cubit/account_actions_cubit.dart';
import '../../../../app/appearance/presentation/cubit/app_appearance_cubit.dart';
import '../../../../app/appearance/models/car_icon_model.dart';
import '../../../../app/locale/models/app_locale_option_model.dart';
import '../../../../app/session/presentation/cubit/session_cubit.dart';
import '../../../../app/voice/presentation/cubit/app_voice_cubit.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/voice_navigation_service.dart';
import '../../../../features/auth/presentation/ui/login_screen.dart';
import '../../../../features/auth/presentation/ui/register_screen.dart';
import '../../../../l10n/l10n.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/sync_cubit.dart';
import '../cubit/sync_state.dart' as sync;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppLocaleCubit>.value(value: getIt<AppLocaleCubit>()),
        BlocProvider<SessionCubit>.value(value: getIt<SessionCubit>()),
        BlocProvider<ProfileCubit>(create: (_) => getIt<ProfileCubit>()),
        BlocProvider<SyncCubit>(create: (_) => getIt<SyncCubit>()),
        BlocProvider<AccountActionsCubit>(
          create: (_) => getIt<AccountActionsCubit>(),
        ),
        BlocProvider<AppVoiceCubit>.value(value: getIt<AppVoiceCubit>()),
      ],
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          context.l10n.profileTitle.toUpperCase(),
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Background Road Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/home_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Dark Overlay & Blur
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
          ),
          // Grid Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        _SettingsTile(
                          title: context.l10n.settingsProfile,
                          icon: Icons.account_circle_outlined,
                          onTap: () => _showProfileSettings(context),
                        ),
                        _SettingsTile(
                          title: context.l10n.settingsAppearance,
                          icon: Icons.palette_outlined,
                          onTap: () => _showAppearanceSettings(context),
                        ),
                        _SettingsTile(
                          title: context.l10n.settingsSync,
                          icon: Icons.cloud_sync_outlined,
                          onTap: () => _showSyncSettings(context),
                        ),
                        _SettingsTile(
                          title: context.l10n.settingsAbout,
                          icon: Icons.info_outline_rounded,
                          onTap: () => _showAboutSettings(context),
                        ),
                        _SettingsTile(
                          title: context.l10n.settingsVoice,
                          icon: Icons.record_voice_over_outlined,
                          onTap: () => _showVoiceSettings(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showProfileSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<SessionCubit>()),
          BlocProvider.value(value: context.read<ProfileCubit>()),
          BlocProvider.value(value: context.read<AccountActionsCubit>()),
        ],
        child: _ModernSettingsPanel(title: context.l10n.settingsProfile),
      ),
    );
  }

  void _showAppearanceSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<AppAppearanceCubit>(),
        child: _ModernSettingsPanel(title: context.l10n.settingsAppearance),
      ),
    );
  }

  void _showSyncSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => BlocProvider<SyncCubit>(
        create: (_) => getIt<SyncCubit>(),
        child: _ModernSettingsPanel(title: context.l10n.settingsSync),
      ),
    );
  }

  void _showAboutSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _ModernSettingsPanel(title: context.l10n.settingsAbout),
    );
  }

  void _showVoiceSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<AppVoiceCubit>(),
        child: _ModernSettingsPanel(title: context.l10n.settingsVoice),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 40),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModernSettingsPanel extends StatelessWidget {
  const _ModernSettingsPanel({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (title == context.l10n.settingsProfile) 
                    const _ProfileSettingsContent()
                  else if (title == context.l10n.settingsAbout)
                    const _AboutSettingsContent()
                  else if (title == context.l10n.settingsSync)
                    const _SyncSettingsContent()
                  else if (title == context.l10n.settingsAppearance)
                    const _AppearanceSettingsContent()
                  else if (title == context.l10n.settingsVoice)
                    const _VoiceSettingsContent()
                  else
                    const Center(
                      child: Text(
                        'Dostępne wkrótce...',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          if (kDebugMode && title == context.l10n.settingsAbout)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: OutlinedButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DeveloperScreen()),
                ),
                icon: const Icon(Icons.developer_mode),
                label: Text(context.l10n.developerToolsTitle),
                style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
              ),
            ),
        ],
      ),
        ),
      ),
    );
  }
}

class _ProfileSettingsContent extends StatelessWidget {
  const _ProfileSettingsContent();

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionCubit>().state;
    final isGuest = session.isAnonymousUser;
    final sharedUser = session.sharedUserOrNull;
    
    if (isGuest) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoCard(
            title: context.l10n.guestStatusTitle,
            subtitle: context.l10n.guestStatusSubtitle,
            icon: Icons.no_accounts_rounded,
            color: Colors.orange.shade800,
          ),
          const SizedBox(height: 20),
          Text(
            context.l10n.guestRegisterPrompt,
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const RegisterScreen()),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(context.l10n.registerUpper, style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white24),
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(context.l10n.loginUpper, style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white10,
              child: Icon(Icons.person_rounded, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sharedUser?.firstName ?? context.l10n.registeredUserDisplayName,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    session.emailOrNull ?? '-',
                    style: GoogleFonts.inter(color: Colors.white54, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        _ActionTile(
          title: context.l10n.logoutTitle,
          icon: Icons.logout_rounded,
          onTap: () => context.read<AccountActionsCubit>().signOut(),
        ),
        const SizedBox(height: 12),
        _ActionTile(
          title: context.l10n.deleteAccountTitle,
          icon: Icons.delete_forever_rounded,
          color: Colors.red.shade400,
          onTap: () => _confirmAccountDeletion(context),
        ),
      ],
    );
  }

  Future<void> _confirmAccountDeletion(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: Text(context.l10n.confirmTitle, style: const TextStyle(color: Colors.white)),
        content: Text(
          context.l10n.confirmDeleteBody,
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.cancelUpper, style: const TextStyle(color: Colors.white54)),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: Text(context.l10n.deleteEverythingUpper),
          ),
        ],
      ),
    );

    if (result == true && context.mounted) {
      await context.read<AccountActionsCubit>().deleteAccount();
      if (context.mounted) {
        Navigator.of(context).pop(); // Close sheet
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey.shade900,
            title: Text(context.l10n.accountDeletedTitle, style: const TextStyle(color: Colors.white)),
            content: Text(
              context.l10n.accountDeletedBody,
              style: const TextStyle(color: Colors.white70),
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  // SessionCubit will automatically trigger screen change via session stream
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.subtitle, required this.icon, required this.color});
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(color: color, fontWeight: FontWeight.w700)),
                Text(subtitle, style: GoogleFonts.inter(color: color.withValues(alpha: 0.7), fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.title, required this.icon, required this.onTap, this.color});
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Colors.white;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: effectiveColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: effectiveColor.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Icon(icon, color: effectiveColor, size: 24),
            const SizedBox(width: 16),
            Text(title, style: GoogleFonts.inter(color: effectiveColor, fontWeight: FontWeight.w600, fontSize: 15)),
            const Spacer(),
            Icon(Icons.chevron_right_rounded, color: effectiveColor.withValues(alpha: 0.3)),
          ],
        ),
      ),
    );
  }
}

class _AboutSettingsContent extends StatelessWidget {
  const _AboutSettingsContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.aboutDescription1,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 16, height: 1.6, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Text(
          context.l10n.aboutDescription2,
          style: GoogleFonts.inter(color: Colors.white70, fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 48),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            children: [
              Text(
                context.l10n.aboutAuthorLabel,
                style: GoogleFonts.inter(color: Colors.white54, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Text(
                'Apex Software',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 1),
              ),
              const SizedBox(height: 24),
              TextButton.icon(
                onPressed: () => launchUrl(Uri.parse('https://apex-software.web.app'), mode: LaunchMode.externalApplication),
                icon: const Icon(Icons.language_rounded, size: 20),
                label: const Text('apex-software.web.app'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue.shade400,
                  textStyle: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SyncSettingsContent extends StatelessWidget {
  const _SyncSettingsContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SyncCubit, sync.SyncState>(
      listener: (context, state) {
        if (state is sync.ImportSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.syncImportSuccess(state.count)),
              backgroundColor: Colors.green.shade700,
            ),
          );
          context.read<SyncCubit>().reset();
        } else if (state is sync.ExportSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.syncExportSuccess),
              backgroundColor: Colors.green.shade700,
            ),
          );
          context.read<SyncCubit>().reset();
        } else if (state is sync.Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${context.l10n.errorUnknown}: ${state.errorKey}'), backgroundColor: Colors.red.shade700),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is sync.Loading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoCard(
              title: context.l10n.syncBackupTitle,
              subtitle: context.l10n.syncBackupSubtitle,
              icon: Icons.storage_rounded,
              color: Colors.blue.shade400,
            ),
            const SizedBox(height: 32),
            _ActionTile(
              title: context.l10n.syncExportButton,
              icon: Icons.save_alt_rounded,
              onTap: isLoading ? () {} : () => context.read<SyncCubit>().exportBackup(),
            ),
            const SizedBox(height: 12),
            _ActionTile(
              title: context.l10n.syncImportButton,
              icon: Icons.file_open_rounded,
              onTap: isLoading ? () {} : () => context.read<SyncCubit>().importBackup(),
            ),
            if (isLoading) ...[
              const SizedBox(height: 32),
              const Center(child: CircularProgressIndicator(color: Colors.white)),
            ],
          ],
        );
      },
    );
  }
}

class _AppearanceSettingsContent extends StatelessWidget {
  const _AppearanceSettingsContent();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    
    return BlocBuilder<AppAppearanceCubit, AppAppearanceState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brightness Section
            _InfoCard(
              title: context.l10n.appearanceBrightnessTitle,
              subtitle: context.l10n.appearanceBrightnessSubtitle,
              icon: Icons.brightness_6_rounded,
              color: Colors.orange.shade400,
            ),
            const SizedBox(height: 16),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.orange.shade400,
                inactiveTrackColor: Colors.white10,
                thumbColor: Colors.white,
                overlayColor: Colors.orange.withValues(alpha: 0.2),
              ),
              child: Slider(
                value: state.brightness,
                onChanged: (val) => context.read<AppAppearanceCubit>().setBrightness(val),
              ),
            ),
            const SizedBox(height: 48),

            // Car Icon Section
            _InfoCard(
              title: context.l10n.appearanceVehicleTitle,
              subtitle: context.l10n.appearanceVehicleSubtitle,
              icon: Icons.directions_car_rounded,
              color: Colors.blue.shade400,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: CarIconType.values.length,
                separatorBuilder: (_, _) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final type = CarIconType.values[index];
                  final isSelected = state.carIcon == type;
                  
                  return GestureDetector(
                    onTap: () => context.read<AppAppearanceCubit>().setCarIcon(type),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 100,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Colors.blue.shade400 : Colors.white12,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (type == CarIconType.classic)
                            Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 10)],
                              ),
                            )
                          else
                            Image.asset(
                              type.assetPath,
                              height: 48,
                              fit: BoxFit.contain,
                            ),
                          const SizedBox(height: 8),
                          Text(
                            type.name,
                            style: GoogleFonts.inter(
                              color: isSelected ? Colors.white : Colors.white54,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 48),
            
            // Language Section
            _InfoCard(
              title: l10n.profileLanguageSectionTitle,
              subtitle: l10n.profileLanguageSectionDescription,
              icon: Icons.translate_rounded,
              color: Colors.teal.shade400,
            ),
            const SizedBox(height: 24),
            ...AppLocaleOptionModel.values.map((option) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _LanguageOptionTile(
                option: option,
                isSelected: state.selectedLocale == option,
                onTap: () => context.read<AppAppearanceCubit>().setLocale(option),
              ),
            )),
          ],
        );
      },
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final AppLocaleOptionModel option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.teal.shade400 : Colors.white12,
          ),
        ),
        child: Row(
          children: [
            Text(
              option == AppLocaleOptionModel.system ? '📱' : (option == AppLocaleOptionModel.polish ? '🇵🇱' : '🇺🇸'),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option == AppLocaleOptionModel.system ? context.l10n.appearanceLocaleSystem : (option == AppLocaleOptionModel.polish ? 'Polski' : 'English'),
                    style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: Colors.teal.shade400),
          ],
        ),
      ),
    );
  }
}

class _VoiceSettingsContent extends StatelessWidget {
  const _VoiceSettingsContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppVoiceCubit, AppVoiceState>(
      builder: (context, state) {
        if (state is! Loaded) return const SizedBox();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Speech Rate
            _InfoCard(
              title: context.l10n.voiceSpeedTitle,
              subtitle: context.l10n.voiceSpeedSubtitle,
              icon: Icons.speed_rounded,
              color: Colors.blue.shade400,
            ),
            const SizedBox(height: 16),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.blue.shade400,
                inactiveTrackColor: Colors.white10,
                thumbColor: Colors.white,
                overlayColor: Colors.blue.withValues(alpha: 0.2),
              ),
              child: Slider(
                value: state.speechRate,
                min: 0.1,
                max: 1.0,
                onChanged: (val) => context.read<AppVoiceCubit>().setSpeechRate(val),
              ),
            ),
            const SizedBox(height: 48),

            // Speech Pitch
            _InfoCard(
              title: context.l10n.voicePitchTitle,
              subtitle: context.l10n.voicePitchSubtitle,
              icon: Icons.graphic_eq_rounded,
              color: Colors.purple.shade400,
            ),
            const SizedBox(height: 16),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.purple.shade400,
                inactiveTrackColor: Colors.white10,
                thumbColor: Colors.white,
                overlayColor: Colors.purple.withValues(alpha: 0.2),
              ),
              child: Slider(
                value: state.speechPitch,
                min: 0.5,
                max: 2.0,
                onChanged: (val) => context.read<AppVoiceCubit>().setSpeechPitch(val),
              ),
            ),
            const SizedBox(height: 48),

            // Test Button
            FilledButton.icon(
              onPressed: () => getIt<NavigationVoiceService>().speak(context.l10n.voiceTestGreeting),
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(context.l10n.voiceTestButton),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white10,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Colors.white24),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
