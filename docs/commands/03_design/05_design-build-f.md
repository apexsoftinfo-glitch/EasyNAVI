# ZADANIE: 05_design_build_f

## PLAN IMPLEMENTACJI

1. Skonfiguruj lokalny `ThemeData` wewnątrz widgetu VariantF:
   - Paleta: Pure Monochrome (Black #000000, White #FFFFFF) + Action Red (#E63946).
   - Fonty: `Montserrat` (Extra Bold).
2. Tło: Czysta biel.
3. Implementacja "Editorial Button":
   - Brak zaokrągleń (radius 0).
   - Grube obramowania (outline 2-3px).
   - Typografia jako główny element wizualny (bardzo duże napisy).
4. Gesty: Natychmiastowa reakcja wizualna (Invert colors on press).
5. Animacja: "Staggered reveal" – szybkie pojawianie się elementów jeden po drugim (delay 40ms).

## CEL
Zaimplementuj wariant wizualny F w pliku `lib/features/home/ui/temporary_widgets/variants/home_variant_f.dart`.

Wariant powinien mieć własne `ThemeData` i wyglądać jak finalny ekran startowy. Nawigacja do kolejnych ekranów (placeholder / snackbar) oraz podstawowe interakcje muszą działać.

## KROKI DO WYKONANIA:
1. Zaimplementuj wariant F według planu powyżej.
2. Uruchom `flutter analyze`. Jeśli są błędy — napraw je.
3. Wykonaj commit.
4. Poinformuj użytkownika, że wariant F jest gotowy. Poleć mu napisanie `next`.

## FINISH
Gdy użytkownik odpowie `next`, przejdź do `docs/commands/03_design/06_design-choose.md`.
