# Operations

- Optional Node script: `node ops/scripts/download-assets.mjs` (repo root; reads `artifacts/design/0027.pen`).
- From repository root: `cd app`
- Ensure `app/android/local.properties` exists (copy `app/android/local.properties.example` and set `sdk.dir` and `flutter.sdk`).
- Debug: `flutter run`
- Release APK: `flutter build apk --release` (configure signing separately; do not commit keystores).
