# ZADANIE: 03_design_build_d

## PLAN IMPLEMENTACJI

1. Skonfiguruj lokalny `ThemeData` wewnątrz widgetu VariantD:
   - Primary: Slate (#2C3E50), Accent: Safety Orange (#FF8C00).
   - Fonty: `Oswald` (nagłówki), `Inter` (body).
2. Tło: Ciemny grafitowy gradient.
3. Implementacja "Industrial Button":
   - Grube obramowanie (bevel effect).
   - Cienie symulujące fizyczne wciśnięcie.
   - Kolor pomarańczowy tylko dla JEDZIEMY, reszta slate/white.
4. Gesty: `HapticFeedback.heavyImpact()` przy każdym dotknięciu przycisku.
5. Animacja: "Mechanical entrance" – elementy wjeżdżają pionowo z dużą bezwładnością.
<!-- Ten plan zostanie wypełniony przez krok 02_design-prepare -->

## CEL
Zaimplementuj wariant wizualny D w pliku `lib/features/home/ui/temporary_widgets/variants/home_variant_d.dart`.

Wariant powinien mieć własne `ThemeData` i wyglądać jak finalny ekran startowy. Nawigacja do kolejnych ekranów (placeholder / snackbar) oraz podstawowe interakcje muszą działać.

## KROKI DO WYKONANIA:
1. Zaimplementuj wariant D według planu powyżej.
2. Uruchom `flutter analyze`. Jeśli są błędy — napraw je.
3. Wykonaj commit.
4. Poinformuj użytkownika, że wariant D jest gotowy. Poleć mu napisanie `next`.

## FINISH
Gdy użytkownik odpowie `next`, przejdź do `docs/commands/03_design/04_design-build-e.md`.
