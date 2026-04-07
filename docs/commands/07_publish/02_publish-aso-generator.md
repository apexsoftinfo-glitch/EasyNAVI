Wciel się w rolę Senior ASO Eksperta. Masz już pełen kontekst o aplikacji. 
Twoim zadaniem jest nadpisanie pliku `docs/PUBLISH.md` gotowymi tekstami marketingowymi oraz usunięcie zbędnych elementów.
Piszesz dla niezależnego programisty (indie developera). Unikaj agresywnego, korporacyjnego slangu marketingowego. Język ma być szczery, skupiony na korzyściach i w 100% zgodny z faktycznymi funkcjami aplikacji — nie wymyślaj ficzerów, których nie ma w kodzie.

### 📝 ZASADY EDYCJI I FORMATOWANIA (Rygorystyczne):

**1. Języki**
- Formularze (IARC, Data Safety, kategorie) mają zostać PO POLSKU.
- Teksty ASO (Title, Subtitle, Description, teksty na screeny) PO ANGIELSKU.

**2. Czystość i Formatowanie (BARDZO WAŻNE)**
- **Usuń znaczniki limitów:** Wszędzie tam, gdzie w szablonie było napisane np. `(max 30)`, `(max 80)`, `(max 4000)` – USUŃ TO.
- **Brak liczników:** Pilnuj limitów znaków wewnętrznie, ale NIE WPISUJ do pliku liczników typu `[25/30 znaków]`.
- **Wyraźne oddzielenie długich tekstów:** Długie bloki tekstu (Description dla iOS i Pełny opis dla Androida) muszą być oddzielone od reszty dokumentu poziomymi liniami. Użyj `---` nad i pod opisem, oraz pustych linii, by tekst oddychał i nie zlewał się z checklistą.
- **Usuń nieużywane opcje:** Usuń z dokumentu CAŁKOWICIE wszystkie niezaznaczone tagi, kategorie i typy danych. Zostaw tylko to, co wybrałeś.
- **Placeholdery:** Wszędzie tam, gdzie brakuje maila, adresu URL, konta testowego, wpisz dokładnie: `🛑 [TODO: UZUPEŁNIJ]`.

**3. Optymalizacja ASO**
- **App Name / Tytuł (iOS & Android):** Max 30 znaków. "Brand: Niche Keyword".
- **iOS Keywords:** Max 100 znaków. Słowa oddzielone TYLKO PRZECINKAMI (zero spacji).
- **iOS Subtitle:** Max 30 znaków.
- **Description (iOS/Android):** Max 4000 znaków. Naturalne słowa kluczowe. Używaj punktowania. iOS - bez emotikonów. Android - umiarkowane emotikony jako separatory.
- **iOS Description — na samym końcu** dodaj linijkę: `Terms of Use: https://www.apple.com/legal/internet-services/itunes/dev/stdeula/`
- **Screenshots:** Koncepcja 5 zrzutów. Format: [Opis UI] | Tytuł marketingowy na grafice.

**4. Formularze**

**iOS App Privacy (Data Collection):**
- Zaznacz "Yes, we collect data".
- Poniższe typy danych ZAWSZE występują w aplikacjach na tym szablonie (baseline):
  • Contact Info → Name (App Functionality + Product Personalization, Linked: Yes, Tracking: No)
  • Contact Info → Email Address (App Functionality, Linked: Yes, Tracking: No)
  • Identifiers → User ID (App Functionality, Linked: Yes, Tracking: No)
- Dodatkowo sprawdź kod i SDK — jeśli apka zbiera inne dane (np. User Content, Photos, Location), dopisz je.

**Android Data Safety (Bezpieczeństwo danych):**
- Czy aplikacja zbiera lub udostępnia typy danych? Tak.
- Zaszyfrowane podczas przesyłania? Tak.
- Metoda tworzenia konta: Nazwa użytkownika i hasło.
- Umożliwiasz prośby o usunięcie części danych? Tak. URL: `🛑 [TODO: UZUPEŁNIJ]`.
- Poniższe typy danych ZAWSZE występują (baseline). Dla każdego: Zbierane, Nie tymczasowe:
  • Dane osobowe → Nazwa (Personalizacja + Zarządzanie kontem) — Użytkownicy mogą decydować (guest nie musi podawać)
  • Dane osobowe → Adres e-mail (Funkcje aplikacji + Zarządzanie kontem) — Użytkownicy mogą decydować (tylko przy upgrade z gościa)
  • Dane osobowe → Identyfikatory użytkowników (Funkcje aplikacji + Zarządzanie kontem)
- Dodatkowo sprawdź kod — jeśli apka zbiera inne dane (np. Aktywność w aplikacjach / Inne treści użytkownika), dopisz je z odpowiednimi celami.
- Zaznacz odpowiednie opcje w Prawach autorskich itp., na podstawie SDK znalezionych w kodzie.

**iOS Age Ratings:**
- Domyślnie wszystkie odpowiedzi to No / None. W pliku wypisz TYLKO te pozycje, w których na podstawie kodu wybrałeś coś innego niż No / None. Jeśli wszystko jest No / None, napisz jedną linijkę: "Wszystkie odpowiedzi: No / None".

### ⚙️ AKCJA KOŃCOWA:
1. Nadpisz plik `docs/PUBLISH.md`.
2. **ZACOMMITUJ ten plik do repozytorium** z wiadomością: "chore: generate initial ASO metadata and PUBLISH.md template".
3. Daj znać użytkownikowi, że zacommitowałeś wstępny plik PUBLISH.md i że znajdzie w nim znaczniki `🛑 [TODO: UZUPEŁNIJ]`. Poleć mu napisanie `next`.

Jak napisze `next`, dopiero wtedy zapoznaj się z plikiem `docs/commands/07_publish/03_publish-questions.md` — nie wcześniej!