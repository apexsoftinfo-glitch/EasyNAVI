# Intro

Twoim zadaniem jako agenta AI jest zrealizowanie poniższych poleceń.

CEL: Sprawdzić poprawność wykonanych kroków z `docs/commands/01_start/`.

# Task

Sprawdź poprawność wszystkich kroków.

# Checklista

## Krok 1. Zebranie danych o użytkowniku

- Endpoint `GET /apps-api/user` zwraca dane użytkownika
- Pole `agent_interview_about` jest wypełnione i zatwierdzone przez użytkownika

## Krok 2. Zapoznanie się ze strukturą `docs/IDEA.md`

- Agent zapoznał się ze strukturą pliku `docs/IDEA.md`

## Krok 3. Ustalenie pomysłu na aplikację

- Użytkownik zatwierdził pomysł na aplikację
- Użytkownik zaakceptował nazwę aplikacji

## Krok 4. Zawężenie grupy docelowej

- Użytkownik wybrał konkretną grupę docelową lub świadomie zdecydował się na wersję globalną

## Krok 5. Ustalenie long-tail keyword

- Użytkownik wybrał long-tail keyword
- Keyword istnieje w wersji angielskiej i polskiej
- Keyword ma 3-5 słów i jest niszowy (nie ogólny)
- Keyword brzmi jak naturalne wyszukiwanie użytkownika w App Store

## Krok 6. Utworzenie pliku `docs/IDEA.md`

- Plik `docs/IDEA.md` istnieje i jest wypełniony
- Sekcja `Identity` zawiera realne dane (nie placeholdery)
- Sekcja `Long-Tail Keyword` zawiera frazę EN i PL z uzasadnieniem
- Sekcje `Elevator Pitch`, `Description`, `Product Summary`, `Niche`, `Value Proposition` są wypełnione
- Sekcja `Must-Have vs Nice-to-Have` jasno oddziela główną funkcję od dalszej wizji
- Sekcja `Screens` zawiera opis funkcjonalnych ekranów dla aplikacji
- Sekcja `Store Screenshots Plan` zawiera 5 ekranów z komunikatem i tekstem EN na grafice
- Plik jest zacommitowany

## Krok 7. Ustawienie App Bundle ID

- `APP_BUNDLE_ID` w `docs/IDEA.md` nie zawiera `com.imienazwisko.appname` ani `com.example`
- `android/app/build.gradle.kts` zawiera poprawny `namespace` i `applicationId`
- `MainActivity.kt` ma poprawny `package` i leży we właściwym folderze
- `ios/Runner.xcodeproj/project.pbxproj` zawiera poprawny `PRODUCT_BUNDLE_IDENTIFIER`
- Zmiany są zacommitowane

## Krok 8. Ustawienie nazwy aplikacji

- `CFBundleDisplayName` i `CFBundleName` w `ios/Runner/Info.plist` mają nową nazwę
- `android:label` w `android/app/src/main/AndroidManifest.xml` ma nową nazwę
- `MaterialApp(title:)` w `lib/app/app.dart` ma nową nazwę
- Stara nazwa `XII` nie występuje w tych plikach
- Zmiany są zacommitowane

## Krok 9. Aktualizacja AGENTS.md i CLAUDE.md

- Sekcja `## App Context` w `AGENTS.md` zawiera opis aplikacji (nie placeholder)
- Placeholder `<supabase_table_prefix>` jest podmieniony na właściwy prefix
- Zmiany są zacommitowane

## Krok 10. Tożsamość aplikacji w `shared_user_apps`

- Plik `lib/features/profiles/data/datasources/shared_user_apps_data_source.dart` ma podmienione placeholdery `<app_id>` i `<app_name>`
- Wartości odpowiadają `__SUPABASE_TABLE_PREFIX__` i `__APP_DISPLAY_NAME__` z `docs/IDEA.md`
- Zmiany są zacommitowane

## Krok 11. Dodanie aplikacji do platformy

- Endpoint `POST /apps-api/user/apps` zwrócił `id`
- Plik `.env` zawiera pole `APP_PLATFORM_ID` z wartością zwróconą przez endpoint

# Podsumowanie

Poinformuj użytkownika o stanie. Jeżeli czegoś brakuje, spróbuj razem z użytkownikiem naprawić to za pomocą poleceń dostępnych w `docs/commands/01_start/`.

Jeżeli w trakcie tego flow zostały zmienione pliki, upewnij się, że odpowiednie zmiany zostały zapisane w commicie. Pliki z sekretami i pliki objęte `.gitignore` nie powinny trafiać do commita.

Jeżeli wszystko jest okej, zaleć mu przejście do kolejnego etapu jakim jest `home` poprzez wywołanie polecenia zawartego w `docs/commands/02_home.md`.
