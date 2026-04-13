import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl'),
  ];

  /// Technical placeholder used to bootstrap Flutter localization before migrating existing UI strings.
  ///
  /// In pl, this message translates to:
  /// **'Lokalizacja aplikacji jest skonfigurowana.'**
  String get localizationBootstrap;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In pl, this message translates to:
  /// **'Nieprawidłowy email lub hasło.'**
  String get errorInvalidCredentials;

  /// No description provided for @errorAnonymousAuthDisabled.
  ///
  /// In pl, this message translates to:
  /// **'Logowanie jako gość jest obecnie wyłączone.'**
  String get errorAnonymousAuthDisabled;

  /// No description provided for @errorEmail.
  ///
  /// In pl, this message translates to:
  /// **'Sprawdź adres email i spróbuj ponownie.'**
  String get errorEmail;

  /// No description provided for @errorPassword.
  ///
  /// In pl, this message translates to:
  /// **'Sprawdź hasło i spróbuj ponownie.'**
  String get errorPassword;

  /// No description provided for @errorNetwork.
  ///
  /// In pl, this message translates to:
  /// **'Problem z połączeniem. Spróbuj ponownie.'**
  String get errorNetwork;

  /// No description provided for @errorDeleteAccountSetupRequired.
  ///
  /// In pl, this message translates to:
  /// **'Delete account wymaga jeszcze dokończenia setupu w Supabase.'**
  String get errorDeleteAccountSetupRequired;

  /// No description provided for @errorDeleteAccountFailed.
  ///
  /// In pl, this message translates to:
  /// **'Nie udało się usunąć konta. Spróbuj ponownie.'**
  String get errorDeleteAccountFailed;

  /// No description provided for @errorSharedUsersSetupRequired.
  ///
  /// In pl, this message translates to:
  /// **'Brakuje tabeli shared_users albo jej schema nie zgadza się z template.'**
  String get errorSharedUsersSetupRequired;

  /// No description provided for @errorDeleteAccountNotImplemented.
  ///
  /// In pl, this message translates to:
  /// **'Usuwanie konta nie jest jeszcze gotowe.'**
  String get errorDeleteAccountNotImplemented;

  /// No description provided for @errorUnknown.
  ///
  /// In pl, this message translates to:
  /// **'Wystąpił nieoczekiwany błąd.'**
  String get errorUnknown;

  /// Fallback error message for unknown error keys.
  ///
  /// In pl, this message translates to:
  /// **'Wystąpił błąd: {errorKey}'**
  String errorWithKey(Object errorKey);

  /// No description provided for @guestDisplayName.
  ///
  /// In pl, this message translates to:
  /// **'Gość'**
  String get guestDisplayName;

  /// No description provided for @registeredUserDisplayName.
  ///
  /// In pl, this message translates to:
  /// **'Użytkownik'**
  String get registeredUserDisplayName;

  /// No description provided for @loadingLabel.
  ///
  /// In pl, this message translates to:
  /// **'Ładowanie...'**
  String get loadingLabel;

  /// No description provided for @sessionErrorTitle.
  ///
  /// In pl, this message translates to:
  /// **'Błąd sesji'**
  String get sessionErrorTitle;

  /// No description provided for @accountTypeGuest.
  ///
  /// In pl, this message translates to:
  /// **'gość'**
  String get accountTypeGuest;

  /// No description provided for @accountTypeRegistered.
  ///
  /// In pl, this message translates to:
  /// **'zalogowany'**
  String get accountTypeRegistered;

  /// No description provided for @commonYes.
  ///
  /// In pl, this message translates to:
  /// **'tak'**
  String get commonYes;

  /// No description provided for @commonNo.
  ///
  /// In pl, this message translates to:
  /// **'nie'**
  String get commonNo;

  /// No description provided for @userTierGuest.
  ///
  /// In pl, this message translates to:
  /// **'gość'**
  String get userTierGuest;

  /// No description provided for @userTierRegistered.
  ///
  /// In pl, this message translates to:
  /// **'konto'**
  String get userTierRegistered;

  /// No description provided for @userTierPro.
  ///
  /// In pl, this message translates to:
  /// **'Pro'**
  String get userTierPro;

  /// No description provided for @homeTitle.
  ///
  /// In pl, this message translates to:
  /// **'Start'**
  String get homeTitle;

  /// No description provided for @currentSessionTitle.
  ///
  /// In pl, this message translates to:
  /// **'Aktualna sesja'**
  String get currentSessionTitle;

  /// No description provided for @sessionUserId.
  ///
  /// In pl, this message translates to:
  /// **'ID użytkownika: {value}'**
  String sessionUserId(Object value);

  /// No description provided for @sessionAccountType.
  ///
  /// In pl, this message translates to:
  /// **'Typ konta: {value}'**
  String sessionAccountType(Object value);

  /// No description provided for @sessionPlan.
  ///
  /// In pl, this message translates to:
  /// **'Plan: {value}'**
  String sessionPlan(Object value);

  /// No description provided for @sessionPro.
  ///
  /// In pl, this message translates to:
  /// **'Pro: {value}'**
  String sessionPro(Object value);

  /// No description provided for @sessionEmail.
  ///
  /// In pl, this message translates to:
  /// **'E-mail: {value}'**
  String sessionEmail(Object value);

  /// No description provided for @sessionDisplayNameValue.
  ///
  /// In pl, this message translates to:
  /// **'Nazwa wyświetlana: {value}'**
  String sessionDisplayNameValue(Object value);

  /// No description provided for @sessionFirstName.
  ///
  /// In pl, this message translates to:
  /// **'Imię: {value}'**
  String sessionFirstName(Object value);

  /// No description provided for @developerToolsTitle.
  ///
  /// In pl, this message translates to:
  /// **'Narzędzia deweloperskie'**
  String get developerToolsTitle;

  /// No description provided for @retryButtonLabel.
  ///
  /// In pl, this message translates to:
  /// **'Spróbuj ponownie'**
  String get retryButtonLabel;

  /// No description provided for @welcomeTitle.
  ///
  /// In pl, this message translates to:
  /// **'Witaj'**
  String get welcomeTitle;

  /// No description provided for @welcomeBody.
  ///
  /// In pl, this message translates to:
  /// **'Kontynuuj jako gość albo zaloguj się na istniejące konto.'**
  String get welcomeBody;

  /// No description provided for @continueAsGuestButtonLabel.
  ///
  /// In pl, this message translates to:
  /// **'Kontynuuj jako gość'**
  String get continueAsGuestButtonLabel;

  /// No description provided for @loginButtonLabel.
  ///
  /// In pl, this message translates to:
  /// **'Zaloguj się'**
  String get loginButtonLabel;

  /// No description provided for @loginScreenTitle.
  ///
  /// In pl, this message translates to:
  /// **'Logowanie'**
  String get loginScreenTitle;

  /// No description provided for @loginExistingAccountTitle.
  ///
  /// In pl, this message translates to:
  /// **'Zaloguj się na istniejące konto'**
  String get loginExistingAccountTitle;

  /// No description provided for @loginExistingAccountBody.
  ///
  /// In pl, this message translates to:
  /// **'Użyj adresu e-mail i hasła, aby przełączyć się na istniejące konto.'**
  String get loginExistingAccountBody;

  /// No description provided for @emailFieldLabel.
  ///
  /// In pl, this message translates to:
  /// **'E-mail'**
  String get emailFieldLabel;

  /// No description provided for @passwordFieldLabel.
  ///
  /// In pl, this message translates to:
  /// **'Hasło'**
  String get passwordFieldLabel;

  /// No description provided for @switchAccountWarningTitle.
  ///
  /// In pl, this message translates to:
  /// **'Przełączasz konto'**
  String get switchAccountWarningTitle;

  /// No description provided for @switchAccountWarningBody.
  ///
  /// In pl, this message translates to:
  /// **'Logowanie w tym miejscu przełączy Cię z obecnego konta gościa na inne konto. Dane gościa i Pro nie łączą się automatycznie.'**
  String get switchAccountWarningBody;

  /// No description provided for @registerScreenTitle.
  ///
  /// In pl, this message translates to:
  /// **'Rejestracja'**
  String get registerScreenTitle;

  /// No description provided for @secureGuestAccountTitle.
  ///
  /// In pl, this message translates to:
  /// **'Zabezpiecz to konto gościa'**
  String get secureGuestAccountTitle;

  /// No description provided for @secureGuestAccountBody.
  ///
  /// In pl, this message translates to:
  /// **'To zachowa Twoje obecne dane i połączy to konto gościa z adresem e-mail oraz hasłem.'**
  String get secureGuestAccountBody;

  /// No description provided for @registerButtonLabel.
  ///
  /// In pl, this message translates to:
  /// **'Zarejestruj się'**
  String get registerButtonLabel;

  /// No description provided for @profileSavedSnackbar.
  ///
  /// In pl, this message translates to:
  /// **'Profil zapisany'**
  String get profileSavedSnackbar;

  /// No description provided for @proEnabledSnackbar.
  ///
  /// In pl, this message translates to:
  /// **'Pro aktywowane'**
  String get proEnabledSnackbar;

  /// No description provided for @profileTitle.
  ///
  /// In pl, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// No description provided for @profileLanguageSectionTitle.
  ///
  /// In pl, this message translates to:
  /// **'Język aplikacji'**
  String get profileLanguageSectionTitle;

  /// No description provided for @profileLanguageSectionDescription.
  ///
  /// In pl, this message translates to:
  /// **'Wybierz, czy aplikacja ma używać języka urządzenia, polskiego czy angielskiego.'**
  String get profileLanguageSectionDescription;

  /// No description provided for @firstNameFieldLabel.
  ///
  /// In pl, this message translates to:
  /// **'Imię'**
  String get firstNameFieldLabel;

  /// No description provided for @languageOptionSystem.
  ///
  /// In pl, this message translates to:
  /// **'Automatyczny'**
  String get languageOptionSystem;

  /// No description provided for @languageOptionSystemDescription.
  ///
  /// In pl, this message translates to:
  /// **'Używa języka urządzenia. Dla nieobsługiwanych języków aplikacja wraca do English.'**
  String get languageOptionSystemDescription;

  /// No description provided for @languageOptionPolish.
  ///
  /// In pl, this message translates to:
  /// **'Polski'**
  String get languageOptionPolish;

  /// No description provided for @languageOptionEnglish.
  ///
  /// In pl, this message translates to:
  /// **'English'**
  String get languageOptionEnglish;

  /// No description provided for @saveFirstNameButtonLabel.
  ///
  /// In pl, this message translates to:
  /// **'Zapisz imię'**
  String get saveFirstNameButtonLabel;

  /// No description provided for @accountSecuredSnackbar.
  ///
  /// In pl, this message translates to:
  /// **'Konto zabezpieczone'**
  String get accountSecuredSnackbar;

  /// No description provided for @logoutButtonLabel.
  ///
  /// In pl, this message translates to:
  /// **'Wyloguj się'**
  String get logoutButtonLabel;

  /// No description provided for @buyProButtonLabel.
  ///
  /// In pl, this message translates to:
  /// **'Kup Pro'**
  String get buyProButtonLabel;

  /// No description provided for @deleteAccountButtonLabel.
  ///
  /// In pl, this message translates to:
  /// **'Usuń konto'**
  String get deleteAccountButtonLabel;

  /// No description provided for @discardChangesTitle.
  ///
  /// In pl, this message translates to:
  /// **'Odrzucić zmiany?'**
  String get discardChangesTitle;

  /// No description provided for @discardChangesBody.
  ///
  /// In pl, this message translates to:
  /// **'Masz niezapisane zmiany. Jeśli wyjdziesz teraz, zostaną utracone.'**
  String get discardChangesBody;

  /// No description provided for @stayButtonLabel.
  ///
  /// In pl, this message translates to:
  /// **'Zostań'**
  String get stayButtonLabel;

  /// No description provided for @discardButtonLabel.
  ///
  /// In pl, this message translates to:
  /// **'Odrzuć'**
  String get discardButtonLabel;

  /// No description provided for @closeButtonLabel.
  ///
  /// In pl, this message translates to:
  /// **'Zamknij'**
  String get closeButtonLabel;

  /// No description provided for @protectProBannerTitle.
  ///
  /// In pl, this message translates to:
  /// **'Zabezpiecz dostęp do Pro'**
  String get protectProBannerTitle;

  /// No description provided for @protectProBannerBody.
  ///
  /// In pl, this message translates to:
  /// **'To konto gościa ma już Pro. Zarejestruj to konto, aby nie stracić dostępu w przyszłości.'**
  String get protectProBannerBody;

  /// No description provided for @developerDiagnosticsTitle.
  ///
  /// In pl, this message translates to:
  /// **'Diagnostyka tylko dla debug'**
  String get developerDiagnosticsTitle;

  /// No description provided for @developerDiagnosticsBody.
  ///
  /// In pl, this message translates to:
  /// **'Użyj tego ekranu, aby sprawdzić lokalną konfigurację aplikacji i status integracji.'**
  String get developerDiagnosticsBody;

  /// No description provided for @revenueCatDisconnectedTitle.
  ///
  /// In pl, this message translates to:
  /// **'RevenueCat nie jest podłączony'**
  String get revenueCatDisconnectedTitle;

  /// No description provided for @revenueCatDisconnectedBody.
  ///
  /// In pl, this message translates to:
  /// **'Dodaj klucze RevenueCat do config/api-keys.json, gdy będziesz gotowy testować subskrypcje.'**
  String get revenueCatDisconnectedBody;

  /// No description provided for @sessionSectionTitle.
  ///
  /// In pl, this message translates to:
  /// **'Sesja'**
  String get sessionSectionTitle;

  /// No description provided for @loggedInLabel.
  ///
  /// In pl, this message translates to:
  /// **'Zalogowany'**
  String get loggedInLabel;

  /// No description provided for @anonymousLabel.
  ///
  /// In pl, this message translates to:
  /// **'Anonimowy'**
  String get anonymousLabel;

  /// No description provided for @planLabel.
  ///
  /// In pl, this message translates to:
  /// **'Plan'**
  String get planLabel;

  /// No description provided for @proLabel.
  ///
  /// In pl, this message translates to:
  /// **'Pro'**
  String get proLabel;

  /// No description provided for @userIdLabel.
  ///
  /// In pl, this message translates to:
  /// **'ID użytkownika'**
  String get userIdLabel;

  /// No description provided for @emailLabel.
  ///
  /// In pl, this message translates to:
  /// **'E-mail'**
  String get emailLabel;

  /// No description provided for @displayNameLabel.
  ///
  /// In pl, this message translates to:
  /// **'Nazwa wyświetlana'**
  String get displayNameLabel;

  /// No description provided for @supabaseSectionTitle.
  ///
  /// In pl, this message translates to:
  /// **'Supabase'**
  String get supabaseSectionTitle;

  /// No description provided for @keysConfiguredLabel.
  ///
  /// In pl, this message translates to:
  /// **'Klucze skonfigurowane'**
  String get keysConfiguredLabel;

  /// No description provided for @supabaseUrlLabel.
  ///
  /// In pl, this message translates to:
  /// **'Supabase URL'**
  String get supabaseUrlLabel;

  /// No description provided for @revenueCatSectionTitle.
  ///
  /// In pl, this message translates to:
  /// **'RevenueCat'**
  String get revenueCatSectionTitle;

  /// No description provided for @supportedPlatformLabel.
  ///
  /// In pl, this message translates to:
  /// **'Wspierana platforma'**
  String get supportedPlatformLabel;

  /// No description provided for @sdkActiveLabel.
  ///
  /// In pl, this message translates to:
  /// **'SDK aktywne'**
  String get sdkActiveLabel;

  /// No description provided for @currentKeySourceLabel.
  ///
  /// In pl, this message translates to:
  /// **'Aktualne źródło klucza'**
  String get currentKeySourceLabel;

  /// No description provided for @proSourceLabel.
  ///
  /// In pl, this message translates to:
  /// **'Źródło Pro'**
  String get proSourceLabel;

  /// No description provided for @proSourceRevenueCat.
  ///
  /// In pl, this message translates to:
  /// **'RevenueCat'**
  String get proSourceRevenueCat;

  /// No description provided for @proSourceDeveloperOverride.
  ///
  /// In pl, this message translates to:
  /// **'Developer override'**
  String get proSourceDeveloperOverride;

  /// No description provided for @missingValueLabel.
  ///
  /// In pl, this message translates to:
  /// **'brak'**
  String get missingValueLabel;

  /// No description provided for @debugForceProTitle.
  ///
  /// In pl, this message translates to:
  /// **'Debug: wymuś status Pro'**
  String get debugForceProTitle;

  /// No description provided for @debugForceProSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Działa tylko bez aktywnego RevenueCat i tylko w debugowym narzędziu.'**
  String get debugForceProSubtitle;

  /// No description provided for @missingSupabaseAgentPrompt.
  ///
  /// In pl, this message translates to:
  /// **'Połącz `Supabase MCP` z moim projektem Supabase i uzupełnij `config/api-keys.json` wartościami `SUPABASE_URL` oraz `SUPABASE_ANON_KEY`.'**
  String get missingSupabaseAgentPrompt;

  /// No description provided for @missingSupabaseTitle.
  ///
  /// In pl, this message translates to:
  /// **'Brakuje kluczy Supabase'**
  String get missingSupabaseTitle;

  /// No description provided for @missingSupabaseBody.
  ///
  /// In pl, this message translates to:
  /// **'Dodaj klucze Supabase do pliku konfiguracyjnego i uruchom aplikację ponownie.'**
  String get missingSupabaseBody;

  /// No description provided for @missingSupabaseFileLabel.
  ///
  /// In pl, this message translates to:
  /// **'Uzupełnij ten plik'**
  String get missingSupabaseFileLabel;

  /// No description provided for @missingSupabaseFilePath.
  ///
  /// In pl, this message translates to:
  /// **'config/api-keys.json'**
  String get missingSupabaseFilePath;

  /// No description provided for @missingSupabaseStep1Title.
  ///
  /// In pl, this message translates to:
  /// **'Krok 1: zainstaluj `Supabase MCP`'**
  String get missingSupabaseStep1Title;

  /// No description provided for @missingSupabaseStep1Body.
  ///
  /// In pl, this message translates to:
  /// **'Najpierw dodaj `Supabase MCP` do swojego agenta AI.'**
  String get missingSupabaseStep1Body;

  /// No description provided for @missingSupabaseStep2Title.
  ///
  /// In pl, this message translates to:
  /// **'Krok 2: wklej ten prompt agentowi'**
  String get missingSupabaseStep2Title;

  /// No description provided for @copyPromptButtonLabel.
  ///
  /// In pl, this message translates to:
  /// **'Kopiuj prompt'**
  String get copyPromptButtonLabel;

  /// No description provided for @promptCopiedSnackbar.
  ///
  /// In pl, this message translates to:
  /// **'Prompt skopiowany'**
  String get promptCopiedSnackbar;

  /// No description provided for @missingSupabaseStep3Title.
  ///
  /// In pl, this message translates to:
  /// **'Krok 3: zamknij i otwórz aplikację ponownie'**
  String get missingSupabaseStep3Title;

  /// No description provided for @missingSupabaseStep3Body.
  ///
  /// In pl, this message translates to:
  /// **'Gdy agent uzupełni plik z kluczami, zamknij aplikację i uruchom ją jeszcze raz.'**
  String get missingSupabaseStep3Body;

  /// No description provided for @sharedUsersAgentPrompt.
  ///
  /// In pl, this message translates to:
  /// **'Uruchom task `docs/tasks/02_SUPABASE_SHARED_USERS_SETUP.md` i doprowadź tabelę `shared_users` do minimalnej zgodności z tym projektem używając `Supabase MCP`.'**
  String get sharedUsersAgentPrompt;

  /// No description provided for @sharedUsersSetupTitle.
  ///
  /// In pl, this message translates to:
  /// **'Brakuje tabeli `shared_users` w Supabase'**
  String get sharedUsersSetupTitle;

  /// No description provided for @sharedUsersSetupBody.
  ///
  /// In pl, this message translates to:
  /// **'Aplikacja nie może wczytać dodatkowych danych użytkowników (takich jak np. imię), bo tabela `shared_users` nie istnieje albo jej struktura nie zgadza się z założeniami minimalnymi.'**
  String get sharedUsersSetupBody;

  /// No description provided for @sharedUsersGuideLabel.
  ///
  /// In pl, this message translates to:
  /// **'Skorzystaj z gotowej instrukcji:'**
  String get sharedUsersGuideLabel;

  /// No description provided for @sharedUsersGuideFile.
  ///
  /// In pl, this message translates to:
  /// **'02_SUPABASE_SHARED_USERS_SETUP.md'**
  String get sharedUsersGuideFile;

  /// No description provided for @sharedUsersAiPromptTitle.
  ///
  /// In pl, this message translates to:
  /// **'Wklej ten prompt agentowi AI'**
  String get sharedUsersAiPromptTitle;

  /// No description provided for @sharedUsersAiHelpBody.
  ///
  /// In pl, this message translates to:
  /// **'Jeżeli Twój agent AI ma dostęp do Supabase MCP, ustawi wszystko wg. przygotowanej instrukcji za Ciebie autmatycznie.'**
  String get sharedUsersAiHelpBody;

  /// No description provided for @deleteAccountConfirmationTitle.
  ///
  /// In pl, this message translates to:
  /// **'Usuń konto'**
  String get deleteAccountConfirmationTitle;

  /// No description provided for @deleteAccountPermanentWarning.
  ///
  /// In pl, this message translates to:
  /// **'Twoje konto zostanie trwale usunięte wraz ze wszystkimi danymi. Tej operacji nie można cofnąć.'**
  String get deleteAccountPermanentWarning;

  /// No description provided for @deleteAccountOtherAppsWarning.
  ///
  /// In pl, this message translates to:
  /// **'Stracisz również dostęp do następujących aplikacji:'**
  String get deleteAccountOtherAppsWarning;

  /// No description provided for @deleteAccountCheckboxLabel.
  ///
  /// In pl, this message translates to:
  /// **'Rozumiem, że dane we wszystkich aplikacjach zostaną usunięte'**
  String get deleteAccountCheckboxLabel;

  /// No description provided for @deleteAccountCheckboxLabelSimple.
  ///
  /// In pl, this message translates to:
  /// **'Rozumiem, że ta operacja jest nieodwracalna'**
  String get deleteAccountCheckboxLabelSimple;

  /// No description provided for @deleteAccountSuccessSnackbar.
  ///
  /// In pl, this message translates to:
  /// **'Konto usunięte'**
  String get deleteAccountSuccessSnackbar;

  /// No description provided for @deleteAccountConfirmButton.
  ///
  /// In pl, this message translates to:
  /// **'Usuń moje konto'**
  String get deleteAccountConfirmButton;

  /// No description provided for @connectivityLabel.
  ///
  /// In pl, this message translates to:
  /// **'Internet'**
  String get connectivityLabel;

  /// No description provided for @connectivityStatusConnected.
  ///
  /// In pl, this message translates to:
  /// **'połączony'**
  String get connectivityStatusConnected;

  /// No description provided for @connectivityStatusDisconnected.
  ///
  /// In pl, this message translates to:
  /// **'brak połączenia'**
  String get connectivityStatusDisconnected;

  /// No description provided for @connectivityStatusChecking.
  ///
  /// In pl, this message translates to:
  /// **'sprawdzanie...'**
  String get connectivityStatusChecking;

  /// Persistent banner shown at the top of the screen when the device has no internet access.
  ///
  /// In pl, this message translates to:
  /// **'Brak połączenia z internetem'**
  String get connectivityOfflineBanner;

  /// No description provided for @addressesTitle.
  ///
  /// In pl, this message translates to:
  /// **'Adresy'**
  String get addressesTitle;

  /// No description provided for @searchAddressesHint.
  ///
  /// In pl, this message translates to:
  /// **'Szukaj adresu...'**
  String get searchAddressesHint;

  /// No description provided for @noAddressesFound.
  ///
  /// In pl, this message translates to:
  /// **'Brak szukanych adresów'**
  String get noAddressesFound;

  /// No description provided for @addressDetails.
  ///
  /// In pl, this message translates to:
  /// **'Szczegóły adresu'**
  String get addressDetails;

  /// No description provided for @saveAddressButton.
  ///
  /// In pl, this message translates to:
  /// **'Zapisz adres'**
  String get saveAddressButton;

  /// No description provided for @streetField.
  ///
  /// In pl, this message translates to:
  /// **'Ulica i numer'**
  String get streetField;

  /// No description provided for @cityField.
  ///
  /// In pl, this message translates to:
  /// **'Miasto'**
  String get cityField;

  /// No description provided for @zipCodeField.
  ///
  /// In pl, this message translates to:
  /// **'Kod pocztowy'**
  String get zipCodeField;

  /// No description provided for @nameField.
  ///
  /// In pl, this message translates to:
  /// **'Nazwa'**
  String get nameField;

  /// No description provided for @editLabel.
  ///
  /// In pl, this message translates to:
  /// **'Edytuj'**
  String get editLabel;

  /// No description provided for @deleteLabel.
  ///
  /// In pl, this message translates to:
  /// **'Usuń'**
  String get deleteLabel;

  /// No description provided for @startNavigation.
  ///
  /// In pl, this message translates to:
  /// **'Start nawigacji'**
  String get startNavigation;

  /// No description provided for @mainMenu.
  ///
  /// In pl, this message translates to:
  /// **'Menu główne'**
  String get mainMenu;

  /// No description provided for @alreadyBehindYou.
  ///
  /// In pl, this message translates to:
  /// **'Już za tobą'**
  String get alreadyBehindYou;

  /// No description provided for @recalculatingRoute.
  ///
  /// In pl, this message translates to:
  /// **'Przeliczam trasę'**
  String get recalculatingRoute;

  /// No description provided for @speedCameraAlert.
  ///
  /// In pl, this message translates to:
  /// **'Uwaga, fotoradar za trzysta metrów!'**
  String get speedCameraAlert;

  /// No description provided for @destinationReached.
  ///
  /// In pl, this message translates to:
  /// **'Jesteś u celu!'**
  String get destinationReached;

  /// No description provided for @homeAddressesTile.
  ///
  /// In pl, this message translates to:
  /// **'ADRESY'**
  String get homeAddressesTile;

  /// No description provided for @homeSettingsTile.
  ///
  /// In pl, this message translates to:
  /// **'USTAWIENIA'**
  String get homeSettingsTile;

  /// No description provided for @homeGoTile.
  ///
  /// In pl, this message translates to:
  /// **'JEDZIEMY'**
  String get homeGoTile;

  /// No description provided for @settingsProfile.
  ///
  /// In pl, this message translates to:
  /// **'Profil'**
  String get settingsProfile;

  /// No description provided for @settingsAppearance.
  ///
  /// In pl, this message translates to:
  /// **'Wygląd'**
  String get settingsAppearance;

  /// No description provided for @settingsSync.
  ///
  /// In pl, this message translates to:
  /// **'Synchronizacja'**
  String get settingsSync;

  /// No description provided for @settingsAbout.
  ///
  /// In pl, this message translates to:
  /// **'O programie'**
  String get settingsAbout;

  /// No description provided for @settingsVoice.
  ///
  /// In pl, this message translates to:
  /// **'Głos'**
  String get settingsVoice;

  /// No description provided for @guestStatusTitle.
  ///
  /// In pl, this message translates to:
  /// **'Zalogowany jako Gość'**
  String get guestStatusTitle;

  /// No description provided for @guestStatusSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Twoje dane nie są jeszcze w pełni zabezpieczone.'**
  String get guestStatusSubtitle;

  /// No description provided for @guestRegisterPrompt.
  ///
  /// In pl, this message translates to:
  /// **'Zarejestruj się, aby zapisać swoje adresy w chmurze. Gwarantujemy brak reklam i 100% prywatności – nie przekazujemy Twojego e-maila nikomu.'**
  String get guestRegisterPrompt;

  /// No description provided for @registerUpper.
  ///
  /// In pl, this message translates to:
  /// **'ZAREJESTRUJ SIĘ'**
  String get registerUpper;

  /// No description provided for @loginUpper.
  ///
  /// In pl, this message translates to:
  /// **'ZALOGUJ'**
  String get loginUpper;

  /// No description provided for @logoutTitle.
  ///
  /// In pl, this message translates to:
  /// **'Wyloguj się'**
  String get logoutTitle;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In pl, this message translates to:
  /// **'Usuń konto'**
  String get deleteAccountTitle;

  /// No description provided for @confirmTitle.
  ///
  /// In pl, this message translates to:
  /// **'Czy na pewno?'**
  String get confirmTitle;

  /// No description provided for @confirmDeleteBody.
  ///
  /// In pl, this message translates to:
  /// **'Twoje konto oraz WSZYSTKIE zapisane adresy zostaną nieodwracalnie usunięte. Czy chcesz kontynuować?'**
  String get confirmDeleteBody;

  /// No description provided for @cancelUpper.
  ///
  /// In pl, this message translates to:
  /// **'ANULUJ'**
  String get cancelUpper;

  /// No description provided for @deleteEverythingUpper.
  ///
  /// In pl, this message translates to:
  /// **'USUŃ WSZYSTKO'**
  String get deleteEverythingUpper;

  /// No description provided for @accountDeletedTitle.
  ///
  /// In pl, this message translates to:
  /// **'Konto usunięte'**
  String get accountDeletedTitle;

  /// No description provided for @accountDeletedBody.
  ///
  /// In pl, this message translates to:
  /// **'Wszystkie Twoje dane zostały pomyślnie usunięte z naszego systemu.'**
  String get accountDeletedBody;

  /// No description provided for @aboutDescription1.
  ///
  /// In pl, this message translates to:
  /// **'EasyNAVI to prosta aplikacja stworzona z myślą o osobach poruszających się służbowo po stałych punktach – klientach, serwisach czy adresach dostaw.'**
  String get aboutDescription1;

  /// No description provided for @aboutDescription2.
  ///
  /// In pl, this message translates to:
  /// **'Pozwala ona na błyskawiczne zapisanie własnej bazy adresów i natychmiastowe uruchomienie nawigacji z podglądem aktualnych utrudnień na drodze, bez konieczności każdorazowego wpisywania celu.'**
  String get aboutDescription2;

  /// No description provided for @aboutAuthorLabel.
  ///
  /// In pl, this message translates to:
  /// **'Program napisany przez'**
  String get aboutAuthorLabel;

  /// No description provided for @syncBackupTitle.
  ///
  /// In pl, this message translates to:
  /// **'Lokalna Kopia Zapasowa'**
  String get syncBackupTitle;

  /// No description provided for @syncBackupSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Zapisz wszystkie adresy do jednego pliku lub wczytaj je z powrotem.'**
  String get syncBackupSubtitle;

  /// No description provided for @syncExportButton.
  ///
  /// In pl, this message translates to:
  /// **'UTWÓRZ KOPIĘ PLIKOWĄ'**
  String get syncExportButton;

  /// No description provided for @syncImportButton.
  ///
  /// In pl, this message translates to:
  /// **'WCZYTAJ Z PLIKU'**
  String get syncImportButton;

  /// No description provided for @appearanceBrightnessTitle.
  ///
  /// In pl, this message translates to:
  /// **'Jasność ekranu'**
  String get appearanceBrightnessTitle;

  /// No description provided for @appearanceBrightnessSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Reguluj poziom podświetlenia, aby dopasować widoczność do warunków na drodze.'**
  String get appearanceBrightnessSubtitle;

  /// No description provided for @appearanceVehicleTitle.
  ///
  /// In pl, this message translates to:
  /// **'Twój pojazd'**
  String get appearanceVehicleTitle;

  /// No description provided for @appearanceVehicleSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Wybierz model, który będzie Cię reprezentował podczas nawigacji.'**
  String get appearanceVehicleSubtitle;

  /// No description provided for @soonLabel.
  ///
  /// In pl, this message translates to:
  /// **'Dostępne wkrótce...'**
  String get soonLabel;

  /// No description provided for @voiceSpeedTitle.
  ///
  /// In pl, this message translates to:
  /// **'Szybkość mowy'**
  String get voiceSpeedTitle;

  /// No description provided for @voiceSpeedSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Reguluj tempo, w jakim asystent podaje wskazówki nawigacyjne.'**
  String get voiceSpeedSubtitle;

  /// No description provided for @voicePitchTitle.
  ///
  /// In pl, this message translates to:
  /// **'Barwa głosu'**
  String get voicePitchTitle;

  /// No description provided for @voicePitchSubtitle.
  ///
  /// In pl, this message translates to:
  /// **'Zmień ton mowy asystenta – od niskiego po wysoki.'**
  String get voicePitchSubtitle;

  /// No description provided for @voiceTestButton.
  ///
  /// In pl, this message translates to:
  /// **'TEST GŁOSU'**
  String get voiceTestButton;

  /// No description provided for @voiceTestGreeting.
  ///
  /// In pl, this message translates to:
  /// **'Dzień dobry! Asystent EasyNAVI jest gotowy do drogi.'**
  String get voiceTestGreeting;

  /// No description provided for @syncImportSuccess.
  ///
  /// In pl, this message translates to:
  /// **'Zaimportowano {count} adresów'**
  String syncImportSuccess(int count);

  /// No description provided for @syncExportSuccess.
  ///
  /// In pl, this message translates to:
  /// **'Pomyślnie utworzono kopię zapasową'**
  String get syncExportSuccess;

  /// No description provided for @appearanceLocaleSystem.
  ///
  /// In pl, this message translates to:
  /// **'Automatyczny'**
  String get appearanceLocaleSystem;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
