# ZADANIE: 08_home_clean_up

## CEL
Uporządkuj kod po wyborze wireframe'a — przenieś wybrany wariant do slotu A, usuń odrzucone.

## KROKI DO WYKONANIA:
1. Przenieś kod wybranego wariantu do `lib/features/home/ui/temporary_widgets/variants/home_variant_a.dart` (jeśli wybrany to nie A — nadpisz A kodem wybranego wariantu i zmień nazwę klasy na `HomeVariantAScreen`).
2. Usuń pliki odrzuconych wariantów (np. `home_variant_b.dart`, `home_variant_c.dart`) — ale **nie modyfikuj** `home_preview_shell.dart`. Switcher wariantów musi pozostać nienaruszony, bo będzie używany w kolejnym etapie (design).
3. Uruchom `flutter analyze`. Jeśli są błędy — napraw je.
4. Wykonaj commit.
5. Poinformuj użytkownika, że wireframe jest gotowy i przechodzimy do fazy designu — nadawania mu stylu wizualnego (kolory, typografia, branding). Poleć mu napisanie `next`.

## FINISH
Gdy użytkownik odpowie `next`, przejdź do `docs/commands/03_design.md`.
