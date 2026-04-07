# Intro

Twoim zadaniem jako agenta AI jest zrealizowanie poniższych poleceń.

CEL: Zaktualizować tożsamość aplikacji w `shared_user_apps` repository

# Task

## Krok 1. Ustal wartości

Na podstawie `docs/IDEA.md` ustal:

- `app_id` — krótki, unikalny identyfikator aplikacji, np. `fitness_tracker`, `daily_habits`. Użyj `__SUPABASE_TABLE_PREFIX__` z `docs/IDEA.md` (to ten sam prefix, który jest używany w tabelach Supabase).
- `app_name` — nazwa aplikacji widoczna dla użytkownika, np. `FitTracker`, `Daily Habits`. Użyj `__APP_DISPLAY_NAME__` z `docs/IDEA.md`.

## Krok 2. Podmień placeholdery

Otwórz plik `lib/features/profiles/data/datasources/shared_user_apps_data_source.dart`.

Znajdź:
```dart
static const _appId = '<app_id>';
static const _appName = '<app_name>';
```

Podmień `<app_id>` na ustaloną wartość i `<app_name>` na ustaloną nazwę.

## Krok 3. Zweryfikuj

- Uruchom `flutter analyze` i napraw ewentualne problemy.
- Uruchom `flutter test` i napraw ewentualne problemy.

## Krok 4. Zacommituj

Zacommituj zmianę z opisem: `build: set app identity for shared_user_apps`

# Finish

Gdy odpowie "next", przejdź do wykonania polecenia zawartego w `docs/commands/01_start/11_start-platform-app-id.md`.
