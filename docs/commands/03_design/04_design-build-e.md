# ZADANIE: 04_design_build_e

## PLAN IMPLEMENTACJI

1. Skonfiguruj lokalny `ThemeData` wewnątrz widgetu VariantE:
   - Primary: Indigo (#3F51B5), Accent: Sky Blue.
   - Fonty: `Outfit`.
2. Tło: Subtelny gradient siatkowy (mesh) z użyciem `Stack` i rozmytych kształtów.
3. Implementacja "Glass Button":
   - Duże zaokrąglenia (32px).
   - Wielowarstwowe, miękkie cienie (ambient occlusion style).
   - Półprzezroczyste powierzchnie (white with low opacity).
4. Gesty: `HapticFeedback.lightImpact()` i animacja `elasticOut` przy zwolnieniu przycisku.
5. Animacja: "Floating entrance" – przyciski płynnie rozjaśniają się (fade + scale).

## CEL
Zaimplementuj wariant wizualny E w pliku `lib/features/home/ui/temporary_widgets/variants/home_variant_e.dart`.

Wariant powinien mieć własne `ThemeData` i wyglądać jak finalny ekran startowy. Nawigacja do kolejnych ekranów (placeholder / snackbar) oraz podstawowe interakcje muszą działać.

## KROKI DO WYKONANIA:
1. Zaimplementuj wariant E według planu powyżej.
2. Uruchom `flutter analyze`. Jeśli są błędy — napraw je.
3. Wykonaj commit.
4. Poinformuj użytkownika, że wariant E jest gotowy. Poleć mu napisanie `next`.

## FINISH
Gdy użytkownik odpowie `next`, przejdź do `docs/commands/03_design/05_design-build-f.md`.
