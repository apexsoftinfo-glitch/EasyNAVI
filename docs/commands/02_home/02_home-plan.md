# ZADANIE: 02_home_plan

## CEL
Zaprojektuj **3 radykalnie różne koncepty** głównego ekranu startowego aplikacji. Nie pisz jeszcze kodu na tym etapie.

## ZASADY UI/UX:
- **Wireframe, ale żywy**: bez kolorów, fontów, brandingu ani finalnego designu — ale z realnymi gestami, stanami, mikrointerakcjami i przejściami. Ekran ma reagować na dotyk. Nie zadowalaj się statycznym układem.
- **Gesty i interakcje**: zaproponuj interakcje dopasowane do treści — swipe, drag, expand/collapse, dismiss, pull-to-refresh, long-press. Rozważ uzycie przykładowych technik: haptic feedback przy akcjach, squish effect (scale 0.95 on press), staggered reveals na listach (50-100ms delay między elementami), `Hero` transitions między ekranami, `Dismissable` do usuwania/archiwizacji itp. Zastosuj wg uznania.
- **Bez Cubitów, Repository ani backendu**: tymczasowa logika stanu (`setState`, lokalne zmienne) jest OK do pokazania interakcji. Chodzi o to, żeby ekran wyglądał jak wypełniona aplikacja stałego użytkownika, nie puste demo.
- **Domyślne widgety Fluttera**: korzystaj głównie z wbudowanych widgetów. Nie twórz custom widgetów jeżeli nie trzeba.
- **Fake data**: wypełnij ekran realistycznymi, sensownymi przykładowymi danymi (konkretne nazwy, liczby, daty). Żadnego lorem ipsum, żadnych pustych widgetów. Ekran ma wyglądać jak działająca aplikacja z prawdziwą zawartością.
- **Bez lokalizacji**: to są temporary widgets — używaj hardcoded stringów, bez `context.l10n` i bez dodawania kluczy do ARB.
- **Zasada nawigacji (Placeholdery):** Budujesz szkielet, ale główny nacisk kładziesz na zawartość ekranu startowego. Jeśli wariant zakłada dodatkowe zakładki/strony (np. z BottomNavigationBar lub Drawer), wejście w nie ma wyświetlać tylko prosty `Center(child: Text('Placeholder'))` lub podepnij `SnackBar`.
- **Istotne sub-ekrany (max 2-3):** Jeżeli ekran startowy prowadzi do sub-ekranów kluczowych dla zrozumienia UX (np. ekran szczegółów, formularz dodawania), przygotuj ich wstępną wersję z fake data — ale nie buduj połowy aplikacji. Chodzi o to, żeby user mógł poczuć vibe ekranu głównego.
- **Profil:** Koniecznie zapewnij działający dostęp do `lib/features/profiles/presentation/ui/profile_screen.dart`.

## KROKI DO WYKONANIA:
1. Zaproponuj **3 radykalnie różne koncepty** ekranu startowego (warianty A, B, C). Każdy musi się fundamentalnie różnić — inny układ, inna nawigacja, inne gesty, inna gęstość treści. Dla każdego opisz: układ i gęstość, nawigację (BottomBar, Drawer, PageView, FAB etc.), jedno główne CTA, oraz jakie gesty i mikrointerakcje proponujesz i dlaczego pasują do tego typu aplikacji.
2. Wyświetl propozycje użytkownikowi. Nie rekomenduj żadnego — za chwilę i tak będziemy implementować wszystkie i dopiero po implementacji user wybierze jeden.
3. ZATRZYMAJ SIĘ i czekaj na `next`.

## FINISH
Gdy otrzymasz `next`, przejdź do `docs/commands/02_home/03_home-prepare.md`.
