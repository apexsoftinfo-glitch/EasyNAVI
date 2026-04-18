// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get localizationBootstrap => 'App localization is configured.';

  @override
  String get errorInvalidCredentials => 'Invalid email or password.';

  @override
  String get errorAnonymousAuthDisabled =>
      'Guest sign-in is currently disabled.';

  @override
  String get errorEmail => 'Check the email address and try again.';

  @override
  String get errorPassword => 'Check the password and try again.';

  @override
  String get errorNetwork => 'Connection problem. Try again.';

  @override
  String get errorDeleteAccountSetupRequired =>
      'Delete account still requires additional Supabase setup.';

  @override
  String get errorDeleteAccountFailed =>
      'Could not delete the account. Try again.';

  @override
  String get errorSharedUsersSetupRequired =>
      'The shared_users table is missing or its schema does not match the template.';

  @override
  String get errorDeleteAccountNotImplemented =>
      'Delete account is not ready yet.';

  @override
  String get errorUnknown => 'An unexpected error occurred.';

  @override
  String errorWithKey(Object errorKey) {
    return 'An error occurred: $errorKey';
  }

  @override
  String get guestDisplayName => 'Guest';

  @override
  String get registeredUserDisplayName => 'User';

  @override
  String get loadingLabel => 'Loading...';

  @override
  String get sessionErrorTitle => 'Session error';

  @override
  String get accountTypeGuest => 'guest';

  @override
  String get accountTypeRegistered => 'signed in';

  @override
  String get commonYes => 'yes';

  @override
  String get commonNo => 'no';

  @override
  String get userTierGuest => 'guest';

  @override
  String get userTierRegistered => 'account';

  @override
  String get userTierPro => 'Pro';

  @override
  String get homeTitle => 'Home';

  @override
  String get currentSessionTitle => 'Current session';

  @override
  String sessionUserId(Object value) {
    return 'User ID: $value';
  }

  @override
  String sessionAccountType(Object value) {
    return 'Account type: $value';
  }

  @override
  String sessionPlan(Object value) {
    return 'Plan: $value';
  }

  @override
  String sessionPro(Object value) {
    return 'Pro: $value';
  }

  @override
  String sessionEmail(Object value) {
    return 'Email: $value';
  }

  @override
  String sessionDisplayNameValue(Object value) {
    return 'Display name: $value';
  }

  @override
  String sessionFirstName(Object value) {
    return 'First name: $value';
  }

  @override
  String get developerToolsTitle => 'Developer tools';

  @override
  String get retryButtonLabel => 'Try again';

  @override
  String get welcomeTitle => 'Welcome';

  @override
  String get welcomeBody =>
      'Continue as a guest or sign in to an existing account.';

  @override
  String get continueAsGuestButtonLabel => 'Continue as guest';

  @override
  String get loginButtonLabel => 'Log in';

  @override
  String get loginScreenTitle => 'Log in';

  @override
  String get loginExistingAccountTitle => 'Log in to an existing account';

  @override
  String get loginExistingAccountBody =>
      'Use your email address and password to switch to an existing account.';

  @override
  String get emailFieldLabel => 'Email';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get switchAccountWarningTitle => 'You\'re switching accounts';

  @override
  String get switchAccountWarningBody =>
      'Logging in here will switch you from the current guest account to another account. Guest data and Pro access are not merged automatically.';

  @override
  String get registerScreenTitle => 'Sign up';

  @override
  String get secureGuestAccountTitle => 'Secure this guest account';

  @override
  String get secureGuestAccountBody =>
      'This will keep your current data and connect this guest account to an email address and password.';

  @override
  String get registerButtonLabel => 'Sign up';

  @override
  String get profileSavedSnackbar => 'Profile saved';

  @override
  String get proEnabledSnackbar => 'Pro enabled';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileLanguageSectionTitle => 'App language';

  @override
  String get profileLanguageSectionDescription =>
      'Choose whether the app should use the device language, Polish, or English.';

  @override
  String get firstNameFieldLabel => 'First name';

  @override
  String get languageOptionSystem => 'Automatic';

  @override
  String get languageOptionSystemDescription =>
      'Uses the device language. For unsupported languages, the app falls back to English.';

  @override
  String get languageOptionPolish => 'Polski';

  @override
  String get languageOptionEnglish => 'English';

  @override
  String get saveFirstNameButtonLabel => 'Save first name';

  @override
  String get accountSecuredSnackbar => 'Account secured';

  @override
  String get logoutButtonLabel => 'Log out';

  @override
  String get buyProButtonLabel => 'Buy Pro';

  @override
  String get deleteAccountButtonLabel => 'Delete account';

  @override
  String get discardChangesTitle => 'Discard changes?';

  @override
  String get discardChangesBody =>
      'You have unsaved changes. If you leave now, they will be lost.';

  @override
  String get stayButtonLabel => 'Stay';

  @override
  String get discardButtonLabel => 'Discard';

  @override
  String get closeButtonLabel => 'Close';

  @override
  String get protectProBannerTitle => 'Protect access to Pro';

  @override
  String get protectProBannerBody =>
      'This guest account already has Pro. Register this account so you do not lose access in the future.';

  @override
  String get developerDiagnosticsTitle => 'Debug-only diagnostics';

  @override
  String get developerDiagnosticsBody =>
      'Use this screen to inspect the local app configuration and integration status.';

  @override
  String get revenueCatDisconnectedTitle => 'RevenueCat is not connected';

  @override
  String get revenueCatDisconnectedBody =>
      'Add RevenueCat keys to config/api-keys.json when you\'re ready to test subscriptions.';

  @override
  String get sessionSectionTitle => 'Session';

  @override
  String get loggedInLabel => 'Signed in';

  @override
  String get anonymousLabel => 'Anonymous';

  @override
  String get planLabel => 'Plan';

  @override
  String get proLabel => 'Pro';

  @override
  String get userIdLabel => 'User ID';

  @override
  String get emailLabel => 'Email';

  @override
  String get displayNameLabel => 'Display name';

  @override
  String get supabaseSectionTitle => 'Supabase';

  @override
  String get keysConfiguredLabel => 'Keys configured';

  @override
  String get supabaseUrlLabel => 'Supabase URL';

  @override
  String get revenueCatSectionTitle => 'RevenueCat';

  @override
  String get supportedPlatformLabel => 'Supported platform';

  @override
  String get sdkActiveLabel => 'SDK active';

  @override
  String get currentKeySourceLabel => 'Current key source';

  @override
  String get proSourceLabel => 'Pro source';

  @override
  String get proSourceRevenueCat => 'RevenueCat';

  @override
  String get proSourceDeveloperOverride => 'Developer override';

  @override
  String get missingValueLabel => 'missing';

  @override
  String get debugForceProTitle => 'Debug: force Pro status';

  @override
  String get debugForceProSubtitle =>
      'Works only without active RevenueCat and only in the debug tool.';

  @override
  String get missingSupabaseAgentPrompt =>
      'Connect `Supabase MCP` to my Supabase project and fill `config/api-keys.json` with `SUPABASE_URL` and `SUPABASE_ANON_KEY`.';

  @override
  String get missingSupabaseTitle => 'Supabase keys are missing';

  @override
  String get missingSupabaseBody =>
      'Add Supabase keys to the config file and restart the app.';

  @override
  String get missingSupabaseFileLabel => 'Fill in this file';

  @override
  String get missingSupabaseFilePath => 'config/api-keys.json';

  @override
  String get missingSupabaseStep1Title => 'Step 1: install `Supabase MCP`';

  @override
  String get missingSupabaseStep1Body =>
      'First add `Supabase MCP` to your AI agent.';

  @override
  String get missingSupabaseStep2Title =>
      'Step 2: paste this prompt into the agent';

  @override
  String get copyPromptButtonLabel => 'Copy prompt';

  @override
  String get promptCopiedSnackbar => 'Prompt copied';

  @override
  String get missingSupabaseStep3Title => 'Step 3: close and reopen the app';

  @override
  String get missingSupabaseStep3Body =>
      'When the agent fills in the keys file, close the app and launch it again.';

  @override
  String get sharedUsersAgentPrompt =>
      'Run task `docs/tasks/02_SUPABASE_SHARED_USERS_SETUP.md` and bring the `shared_users` table to minimal compatibility with this project using `Supabase MCP`.';

  @override
  String get sharedUsersSetupTitle =>
      'The `shared_users` table is missing in Supabase';

  @override
  String get sharedUsersSetupBody =>
      'The app cannot load additional user data, such as the first name, because the `shared_users` table does not exist or its structure does not match the minimal assumptions.';

  @override
  String get sharedUsersGuideLabel => 'Use the prepared guide:';

  @override
  String get sharedUsersGuideFile => '02_SUPABASE_SHARED_USERS_SETUP.md';

  @override
  String get sharedUsersAiPromptTitle => 'Paste this prompt into your AI agent';

  @override
  String get sharedUsersAiHelpBody =>
      'If your AI agent has access to Supabase MCP, it can configure everything for you automatically using the prepared guide.';

  @override
  String get deleteAccountConfirmationTitle => 'Delete account';

  @override
  String get deleteAccountPermanentWarning =>
      'Your account will be permanently deleted along with all your data. This action cannot be undone.';

  @override
  String get deleteAccountOtherAppsWarning =>
      'You will also lose access to the following apps:';

  @override
  String get deleteAccountCheckboxLabel =>
      'I understand that my data in all apps will be deleted';

  @override
  String get deleteAccountCheckboxLabelSimple =>
      'I understand that this action is irreversible';

  @override
  String get deleteAccountSuccessSnackbar => 'Account deleted';

  @override
  String get deleteAccountConfirmButton => 'Delete my account';

  @override
  String get connectivityLabel => 'Internet';

  @override
  String get connectivityStatusConnected => 'connected';

  @override
  String get connectivityStatusDisconnected => 'disconnected';

  @override
  String get connectivityStatusChecking => 'checking...';

  @override
  String get connectivityOfflineBanner => 'No internet connection';

  @override
  String get addressesTitle => 'Addresses';

  @override
  String get searchAddressesHint => 'Search addresses...';

  @override
  String get noAddressesFound => 'No addresses found';

  @override
  String get addressDetails => 'Address details';

  @override
  String get saveAddressButton => 'Save address';

  @override
  String get streetField => 'Street and number';

  @override
  String get cityField => 'City';

  @override
  String get zipCodeField => 'Zip code';

  @override
  String get nameField => 'Name';

  @override
  String get editLabel => 'Edit';

  @override
  String get deleteLabel => 'Delete';

  @override
  String get startNavigation => 'Start navigation';

  @override
  String get mainMenu => 'Main menu';

  @override
  String get alreadyBehindYou => 'Already behind you';

  @override
  String get recalculatingRoute => 'Recalculating route';

  @override
  String get speedCameraAlert =>
      'Caution, speed camera in three hundred meters!';

  @override
  String get destinationReached => 'You have arrived!';

  @override
  String get homeAddressesTile => 'ADDRESSES';

  @override
  String get homeSettingsTile => 'SETTINGS';

  @override
  String get homeGoTile => 'GO';

  @override
  String get settingsProfile => 'Profile';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsSync => 'Synchronization';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsVoice => 'Voice';

  @override
  String get guestStatusTitle => 'Logged in as Guest';

  @override
  String get guestStatusSubtitle => 'Your data is not yet fully secured.';

  @override
  String get guestRegisterPrompt =>
      'Sign up to save your addresses in the cloud. We guarantee no ads and 100% privacy – we don\'t pass your email to anyone.';

  @override
  String get registerUpper => 'SIGN UP';

  @override
  String get loginUpper => 'LOG IN';

  @override
  String get logoutTitle => 'Log out';

  @override
  String get deleteAccountTitle => 'Delete account';

  @override
  String get confirmTitle => 'Are you sure?';

  @override
  String get confirmDeleteBody =>
      'Your account and ALL saved addresses will be permanently deleted. Do you want to continue?';

  @override
  String get cancelUpper => 'CANCEL';

  @override
  String get deleteEverythingUpper => 'DELETE EVERYTHING';

  @override
  String get accountDeletedTitle => 'Account deleted';

  @override
  String get accountDeletedBody =>
      'All your data has been successfully removed from our system.';

  @override
  String get aboutDescription1 =>
      'EasyNAVI is a simple app designed for people who travel for work between fixed points – clients, service centers, or delivery addresses.';

  @override
  String get aboutDescription2 =>
      'It allows you to instantly save your own address base and immediately start navigation with a preview of current road changes, without having to type the destination every time.';

  @override
  String get aboutAuthorLabel => 'App written by';

  @override
  String get syncBackupTitle => 'Local Backup';

  @override
  String get syncBackupSubtitle =>
      'Save all addresses to a single file or load them back.';

  @override
  String get syncExportButton => 'CREATE FILE BACKUP';

  @override
  String get syncImportButton => 'LOAD FROM FILE';

  @override
  String get appearanceBrightnessTitle => 'Screen brightness';

  @override
  String get appearanceBrightnessSubtitle =>
      'Adjust the backlight level to match visibility to road conditions.';

  @override
  String get appearanceVehicleTitle => 'Your vehicle';

  @override
  String get appearanceVehicleSubtitle =>
      'Choose the model that will represent you during navigation.';

  @override
  String get soonLabel => 'Available soon...';

  @override
  String get voiceSpeedTitle => 'Speech rate';

  @override
  String get voiceSpeedSubtitle =>
      'Adjust the rate at which the assistant gives navigation directions.';

  @override
  String get voicePitchTitle => 'Voice pitch';

  @override
  String get voicePitchSubtitle =>
      'Change the tone of the assistant\'s speech – from low to high.';

  @override
  String get voiceTestButton => 'TEST VOICE';

  @override
  String get voiceTestGreeting =>
      'Hello! The EasyNAVI assistant is ready for the road.';

  @override
  String syncImportSuccess(int count) {
    return 'Imported $count addresses';
  }

  @override
  String get syncExportSuccess => 'Backup saved successfully';

  @override
  String get appearanceLocaleSystem => 'System';

  @override
  String get homePlanningTile => 'PLANNING';

  @override
  String get planningTitle => 'Route Planning';

  @override
  String get planRouteButton => 'PLAN ROUTE';

  @override
  String get planningModeTitle => 'Choose planning mode';

  @override
  String get planningModeSequence => 'By selection order';

  @override
  String get planningModeClosest => 'Closest from current';

  @override
  String get planningModeFarthest => 'Starting from farthest';

  @override
  String get nextDestinationButton => 'NEXT ADDRESS';

  @override
  String get routeFinished => 'Route Finished';

  @override
  String get addressesSelected => 'addresses selected';

  @override
  String get planNow => 'PLAN';
}
