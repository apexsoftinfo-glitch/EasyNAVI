# ZADANIE: 04_home_build_a

## PLAN IMPLEMENTACJI

1. Skonfiguruj `Scaffold` z `AppBar` ("EasyNAVI") oraz `FloatingActionButton`.
2. Przygotuj listę testowych danych adresowych (np. "Serwis Klimatyzacji", "Klient: Kowalski", "Magazyn Centralny").
3. Zaimplementuj górną sekcję "Ostatnio używane" jako horyzontalną listę małych kafelków.
4. Zaimplementuj główną listę (`ListView.separated`) z kartami adresów.
5. Każda karta powinna zawierać: `Leading` (ikona typu miejsca), `Title` (nazwa), `Subtitle` (adres) oraz `Trailing` (duży, niebieski przycisk akcji "JEDŹ").
6. Dodaj `Dismissible` do każdego elementu listy, aby pokazać gest usuwania.
7. Dodaj efekt "squish" (naciśnięcie zmniejsza skalę do 0.95) za pomocą `GestureDetector` i `TweenAnimationBuilder`.
8. Podepnij nawigację do profilu i ekranu deweloperskiego.
<!-- Ten plan zostanie wypełniony przez krok 03_home-prepare -->

## CEL
Zaimplementuj wariant A ekranu startowego w pliku `lib/features/home/ui/temporary_widgets/variants/home_variant_a.dart`.

## KROKI DO WYKONANIA:
1. Zaimplementuj wariant A według planu powyżej.
2. Uruchom `flutter analyze`. Jeśli są błędy — napraw je.
3. Wykonaj commit.
4. Poinformuj użytkownika, że wariant A jest gotowy. Poleć mu napisanie `next`.

## FINISH
Gdy użytkownik odpowie `next`, przejdź do `docs/commands/02_home/05_home-build-b.md`.
