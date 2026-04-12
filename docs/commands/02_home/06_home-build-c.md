# ZADANIE: 06_home_build_c

## PLAN IMPLEMENTACJI

1. Skonfiguruj `Scaffold` z `Stack` jako głównym elementem.
2. Warstwa dolna: `Placeholder` lub `Image` symulujący mapę z kilkoma pinezkami.
3. Warstwa górna: `DraggableScrollableSheet`.
4. Zawartość sheetu: `ListView` z listą punktów posortowaną wg dystansu (np. "200m", "1.5km").
5. Dodaj pasek wyszukiwania (`TextField`) "przyklejony" do góry wysuwanego arkusza.
6. Zaimplementuj animację rozwijania arkusza przy przesunięciu w górę.
7. Dodaj interakcję: kliknięcie w punkt na liście centruje "mapę" na tym punkcie.
8. Dodaj `Drawer` (hamburger menu) do `Scaffold` dla profilu i narzędzi.

## CEL
Zaimplementuj wariant C ekranu startowego w pliku `lib/features/home/ui/temporary_widgets/variants/home_variant_c.dart`.

## KROKI DO WYKONANIA:
1. Zaimplementuj wariant C według planu powyżej.
2. Uruchom `flutter analyze`. Jeśli są błędy — napraw je.
3. Wykonaj commit.
4. Poinformuj użytkownika, że wariant C jest gotowy. Poleć mu napisanie `next`.

## FINISH
Gdy użytkownik odpowie `next`, przejdź do `docs/commands/02_home/07_home-choose.md`.
