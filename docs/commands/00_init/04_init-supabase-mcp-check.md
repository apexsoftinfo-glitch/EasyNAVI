# Intro

Twoim zadaniem jako agenta AI jest zrealizowanie poniższych poleceń.

CEL: Sprawdzenie połączenia z Supabase MCP.

# Task

1. Sprawdź czy istnieją pliki: `.mcp.json`, `opencode.json`, `.codex/config.toml`.
2. Sprawdź czy mają wartości `SUPABASE_PROJECT_ID` oraz `SUPABASE_ACCOUNT_ACCESS_TOKEN` z pliku `.env`.
3. Jeżeli tak, spróbuj połączyć się z Supabase MCP. Pobierz listę projektów / tabel. Zobacz czy otrzymujesz wyniki.

Jeżeli pliki istniały, a nie masz połączenia: poproś go o weryfikację `SUPABASE_PROJECT_ID` i `SUPABASE_ACCOUNT_ACCESS_TOKEN` w `.env`, a następnie o restart sesji z powrotem do **tej samej rozmowy**. Podaj mu konkretną komendę resume dla narzędzia, w którym aktualnie pracujecie:

- OpenCode: zamknij sesję → `opencode --continue`
- Codex: zamknij sesję → `codex resume --last`
- Claude Code: `/exit` → `claude --continue`
Jeżeli połączenie nadal nie istnieje, poproś użytkownika o cofnięcie się do poprzednich kroków.

Gdy skończysz, poinformuj użytkownika o rezultacie.

Gdy odpowie "next", przejdź do wykonania polecenia zawartego w `docs/commands/00_init/05_init-supabase-auth-providers.md`.

