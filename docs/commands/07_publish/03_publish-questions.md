Wciel się w asystenta publikacji. W poprzednim kroku wygenerowałeś plik `docs/PUBLISH.md`, w którym znajdują się placeholdery oznaczone jako `🛑[TODO: UZUPEŁNIJ]`.

Twoim celem jest dokończenie pliku na podstawie odpowiedzi użytkownika.

### 🛠 KROK 1: ZAPYTAJ UŻYTKOWNIKA
1. Przeskanuj plik `docs/PUBLISH.md` w poszukiwaniu wystąpień tekstu `🛑 [TODO: UZUPEŁNIJ]`.
2. Wypisz je w formie ponumerowanej listy w czacie.
**WAŻNE WYJĄTKI:**
- **Delete Account URL** może występować w pliku w kilku miejscach (np. Universal Info i Android Data Safety). Pytaj o niego TYLKO RAZ — użytkownik podaje jeden URL, a ty wpisujesz go wszędzie gdzie jest placeholder.
- **Konto Testowe**: NIE PYTAJ o email, hasło ani Notes. Aplikacje na tym szablonie mają guest mode — recenzent użyje "Continue as guest". Sam uzupełnij: Email i Hasło usuń (lub wpisz "N/A"), a w Notes wpisz że recenzent powinien użyć "Continue as guest" na Welcome Screen.

3. Poinformuj użytkownika, że jeśli nie ma jeszcze niektórych danych, może napisać "pomiń" — zostawisz placeholdery. Gdy odpowie, zaktualizujesz plik i zacommitujesz zmiany.

ZATRZYMAJ SIĘ I CZEKAJ NA MOJĄ ODPOWIEDŹ.

### 🛠 KROK 2: AKTUALIZACJA I COMMIT (Po mojej odpowiedzi)
Gdy podam Ci dane (lub napiszę "pomiń"):
1. Otwórz `docs/PUBLISH.md` i podmień odpowiednie placeholdery. Delete Account URL wpisz we wszystkie miejsca, gdzie był placeholder.
2. Konto testowe uzupełnij sam (bez pytania): Email i Hasło → "N/A", Notes → informacja że recenzent powinien użyć "Continue as guest" na Welcome Screen.
3. **ZACOMMITUJ plik do repozytorium** z wiadomością: `chore: update PUBLISH.md with missing administrative data`.
4. Daj znać użytkownikowi, że plik został zaktualizowany i poleć mu napisanie `next`.

Jak napisze `next`, dopiero wtedy zapoznaj się z plikiem `docs/commands/07_publish/04_publish-aso-image-prompts.md` — nie wcześniej!