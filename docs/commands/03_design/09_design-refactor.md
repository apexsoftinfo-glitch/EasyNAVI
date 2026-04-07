# ZADANIE: 09_design_refactor

## CEL
Do tej pory jakość kodu nie miała znaczenia — testowaliśmy warianty. Teraz mamy wybrany, finalny ekran startowy i musi być napisany produkcyjnie, zgodnie z zasadami z `AGENTS.md`. Ten ekran będzie wzorcem do budowania kolejnych ekranów aplikacji.

## KROKI DO WYKONANIA:
1. Przeczytaj `AGENTS.md` — szczególnie sekcje `Critical Rules` i `Conventions`.
2. Zrefaktoruj `lib/features/home/ui/home_screen.dart` i powiązane pliki. Popraw ogólną jakość kodu. Ładnie wydziel zahardcodowane fake data, żeby w przyszłości łatwo było je wyciąć i podpiąć Cubit.
3. Uruchom `flutter analyze`. Napraw wszelkie błędy, warningi i info.
4. Wykonaj commit.
5. Poinformuj użytkownika o zmianach. Poleć mu napisanie `next`.

## FINISH
Gdy odpowie `next`, przejdź do `docs/commands/03_design/10_design-verify.md`.
