# Intro

Twoim zadaniem jako agenta AI jest zrealizowanie poniższych poleceń.

CEL: Wykonanie konfiguracji tabel współdzielonych w Supabase (`shared_users` i `shared_user_apps`).

# Task

## Część A: `shared_users`

1. Sprawdź, czy masz działające połączenie z `Supabase MCP`.
2. Sprawdź, czy w bazie istnieje tabela `public.shared_users`.
3. Sprawdź, czy tabela spełnia minimalne wymagania template:
- kolumny `id` oraz `first_name`
- relacja 1:1 z `auth.users` przez `shared_users.id`
- trigger `on_auth_user_created`
- `RLS`
- policies do własnego `select`, `insert`, `update`
- obecność w publikacji `supabase_realtime`
4. Jeżeli czegoś brakuje, zastosuj tylko brakujące migracje z:
- `supabase/migrations/0001_shared_users_table.sql`
- `supabase/migrations/0002_shared_users_triggers.sql`
- `supabase/migrations/0003_shared_users_rls_policies.sql`
- `supabase/migrations/0004_shared_users_realtime.sql`
5. Jeżeli wszystko jest już poprawnie skonfigurowane, nie rób żadnych zmian.

## Część B: `shared_user_apps`

1. Sprawdź, czy w bazie istnieje tabela `public.shared_user_apps`.
2. Sprawdź, czy tabela spełnia wymagania:
- kolumny `user_id`, `app_id`, `app_name`, `registered_at`, `last_seen_at`
- klucz główny `(user_id, app_id)`
- relacja `user_id` → `auth.users(id)` z `ON DELETE CASCADE`
- `RLS` włączony
- policies: `select`, `insert`, `update` tylko dla własnych wierszy
3. Jeżeli czegoś brakuje, zastosuj migrację z:
- `supabase/migrations/0005_shared_user_apps.sql`
4. Jeżeli wszystko jest już poprawnie skonfigurowane, nie rób żadnych zmian.

Gdy skończysz, poinformuj użytkownika o rezultacie.

Gdy odpowie "next", przejdź do wykonania polecenia zawartego w `docs/commands/00_init/12_init-supabase-delete-account-setup.md`.
