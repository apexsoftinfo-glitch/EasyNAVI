# ZADANIE: 06_publish_codemagic

## CEL
Użytkownik konfiguruje Codemagic CI/CD dla swojej aplikacji.

## KROKI DO WYKONANIA:

1. Powiedz użytkownikowi, że teraz pora skonfigurować Codemagic, żeby buildy iOS i Android działały automatycznie.

2. Poproś go, żeby w terminalu wygenerował base64 z pliku `config/api-keys.json`:

   macOS:
   ```sh
   base64 -i config/api-keys.json | pbcopy
   ```

   Windows:
   ```powershell
   [Convert]::ToBase64String([IO.File]::ReadAllBytes("config\api-keys.json")) | Set-Clipboard
   ```

3. Poproś, żeby w dashboardzie Codemagic wykonał następujące kroki:

   - W **Environment Variables** dodał zmienną `API_KEYS_BASE64` i wkleił wygenerowaną wartość.
   - W **Pre-build script** dodał:
     ```sh
     #!/bin/sh
     mkdir -p config
     echo "$API_KEYS_BASE64" | base64 --decode > config/api-keys.json
     ```
   - W **Post-clone script** dodał:
     ```sh
     flutter pub get
     ```
   - W **Build -> Build arguments** dodał dla iOS i Android:
     ```sh
     --dart-define-from-file=config/api-keys.json --build-name=0.0.$(($PROJECT_BUILD_NUMBER + 9)) --build-number=$(($PROJECT_BUILD_NUMBER + 9))
     ```

4. ZATRZYMAJ SIĘ i czekaj aż użytkownik potwierdzi, że skonfigurował Codemagic.

## FINISH
Gdy użytkownik potwierdzi, poleć mu napisanie `next`.

Jak napisze `next`, dopiero wtedy zapoznaj się z plikiem `docs/commands/07_publish/08_publish-screenshots.md` — nie wcześniej!
