# ZADANIE: 08_design_clean_up

## CEL
Przenieś wybrany design do docelowych plików i posprzątaj tymczasowe warianty.

## KROKI DO WYKONANIA:
1. Zaimplementuj wybrany design w `lib/features/home/ui/home_screen.dart`. Najważniejsze, aby był dostęp do Profilu — reszta to mogą być snackbary / placeholdery, bo wciąż pracujemy tylko nad UI.
2. Przenieś `ThemeData` wybranego wariantu do `lib/app/app.dart`, aby było ustawione globalnie dla całej aplikacji.
3. Usuń cały folder `lib/features/home/ui/temporary_widgets`.
4. Uruchom `flutter analyze`. Jeśli są błędy — napraw je.
5. Wykonaj commit.
6. Poinformuj użytkownika o zmianach. Poleć mu napisanie `next`.

## FINISH
Gdy odpowie `next`, przejdź do `docs/commands/03_design/09_design-refactor.md`.
