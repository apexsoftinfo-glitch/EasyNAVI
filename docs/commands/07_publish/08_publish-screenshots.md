Wciel się w rolę doświadczonego programisty Flutter. Twoim zadaniem jest przygotowanie ekranów aplikacji z przykładowymi danymi po angielsku, gotowych do zrobienia screenshotów do App Store i Google Play.

**WAŻNE:** Zmiany z tego kroku NIE BĘDĄ COMMITOWANE. Użytkownik zrobi screenshoty, a potem cały kod zostanie wycofany. Dlatego możesz śmiało modyfikować istniejące ekrany, hackować navigation params, hardcodować dane — cokolwiek potrzeba, żeby ekrany wyglądały dobrze na screenshotach.

### 🛠 KROK 1: ANALIZA

1. Przeczytaj sekcję `Store Screenshots Plan` z `docs/IDEA.md` — znajdziesz tam 5 ekranów, które mają być na screenshotach, wraz z komunikatami i tekstami marketingowymi.
2. Przeczytaj sekcję `Description` i `Elevator Pitch` z `docs/IDEA.md`, żeby zrozumieć kontekst aplikacji.
3. Znajdź w kodzie widgety odpowiadające tym 5 ekranom. Zrozum jakich cubitów i danych potrzebują.

### 🛠 KROK 2: PRZYGOTOWANIE EKRANÓW

W pliku `lib/app/developer/ui/developer_screen.dart` dodaj nową sekcję `_SectionCard` o tytule "Store Screenshots" na dole listy widgetów (przed zamknięciem `Column`).

W tej sekcji umieść 5 przycisków (po jednym na każdy screenshot z planu). Każdy przycisk ma:
- Nazwę odpowiadającą ekranowi ze Store Screenshots Plan
- Po kliknięciu otwierać odpowiedni ekran aplikacji z przykładowymi danymi po angielsku

**Jak przygotować ekran ze screenshota:**
- **Preferowane podejście:** Otwórz prawdziwy ekran aplikacji opakowany w `BlocProvider.value` z cubitem wyemitowanym w stanie `loaded` z hardcoded fake danymi po angielsku. Dzięki temu screenshot wygląda identycznie jak prawdziwa aplikacja.
- **Fallback:** Jeśli ekran jest zbyt skomplikowany (wymaga wielu zagnieżdżonych cubitów, navigation params, streamsów itp.), stwórz uproszczony widget który odwzorowuje UI tego ekranu z hardcoded danymi. Umieść go w tym samym pliku `developer_screen.dart`.
- Ekrany muszą wyglądać jak normalna aplikacja z prawdziwymi danymi — żadnych elementów debugowych, ramek, napisów "demo".
- Dane muszą być realistyczne, spójne ze sobą i po angielsku.
- Jeśli cubit w konstruktorze automatycznie ładuje dane i nadpisuje fake state, wyemituj fake state po buildzie albo zmodyfikuj cubit żeby nie ładował danych gdy dostanie gotowy state (pamiętaj — te zmiany i tak zostaną wycofane).

### 🛠 KROK 3: WERYFIKACJA

1. Uruchom `flutter analyze` i napraw ewentualne błędy.
2. **NIE COMMITUJ ZMIAN.**

### ⚙️ AKCJA KOŃCOWA
Daj znać użytkownikowi, że ekrany do screenshotów są gotowe w sekcji "Store Screenshots" na DeveloperScreen. Niech uruchomi aplikację, przejdzie do DeveloperScreen i zrobi screenshoty tych 5 ekranów. Poleć mu napisanie `next`.

Jak napisze `next`, dopiero wtedy zapoznaj się z plikiem `docs/commands/07_publish/09_publish-screenshots-cleanup.md` — nie wcześniej!
