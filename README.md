# 0027-uk.co.tiabellavideo.hub

**Primary remote:** https://github.com/mvrst/0027-uk.co.tiabellavideo.hub  

Tiabella Production Hub — Flutter Android app (**applicationId** / `<PACKAGE_NAME>`: `uk.co.tiabellavideo.hub`).

## Layout

| Path | Contents |
|------|----------|
| [`app/`](app/) | Flutter project (run commands from here) |
| [`docs/`](docs/) | Contract, routes, testing, screenshots, release docs |
| [`ops/`](ops/) | Scripts, incidents, runbooks |
| [`artifacts/`](artifacts/) | Design file, store listing assets, release notes, web handoff |
| [`codemagic.yaml`](codemagic.yaml) | CI (e.g. `store_screenshots`) |

Privacy policy URL (Settings → Privacy Policy): `https://tiabellavideo.co.uk/privacy-policy` (see `app/lib/core/constants.dart`).

## Quick start

```bash
cd app
flutter pub get
flutter run
```

Android SDK paths: copy `app/android/local.properties.example` → `local.properties` (gitignored).
