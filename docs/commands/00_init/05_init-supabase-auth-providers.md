# Intro

Twoim zadaniem jako agenta AI jest zrealizowanie poniższych poleceń.

CEL: Upewnienie się, że użytkownik skonfigurował providery autentykacji w dashboardzie Supabase.

# Task

1. Poproś użytkownika, aby wszedł do dashboardu Supabase dla tego projektu: **Authentication → Sign In / Providers**.
2. Poproś go o sprawdzenie i ustawienie trzech przełączników:
   - **Allow manual linking** → ON
   - **Allow anonymous sign-ins** → ON
   - **Confirm email** → OFF
3. Poczekaj, aż użytkownik potwierdzi, że ustawienia są poprawne.

Gdy odpowie "next", przejdź do wykonania polecenia zawartego w `docs/commands/00_init/06_init-api-keys-create.md`.
