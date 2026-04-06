# Release trigger instructions (Codemagic)

**Repository:** `0027-uk.co.tiabellavideo.hub`  
**Default Git branch:** `main` (recommended for production builds)

## Manual-first policy

All workflows in `codemagic.yaml` are designed to be **started from the Codemagic dashboard**, not implied by a special branch name. This keeps spend predictable.

## Branch mapping (recommended)

| Workflow | Suggested branch | Purpose |
|----------|------------------|---------|
| `store_screenshots` | `main` or `store-assets/*` | Regenerate Play phone screenshots (PNG artifacts) |
| `qa_apk` | `main` or any feature branch | Signed **APK** for manual install on a device (QA / reality check; not the Play release path) |
| `closed_release` | `main` or `release/closed-*` | Build signed AAB for **Closed testing** |
| `open_release` | `main` or `release/open-*` | Build signed AAB for **Open testing** |
| `production_release` | **`main` only** (recommended) | Build signed AAB for **Production** |

You may start any workflow from **any** branch Codemagic allows; the table is **policy**, not enforced in YAML.

## How to trigger a build

1. Open the app in Codemagic.
2. **Start new build**.
3. Select the **workflow** (`store_screenshots`, `qa_apk`, `closed_release`, `open_release`, or `production_release`).
4. Choose the **branch** and commit (usually `main`).
5. Confirm **Android code signing** is available for release workflows (keystore reference **`0027_upload`**).

## After the build

- **Screenshots:** Download the **Artifacts** archive; upload PNGs to Play Console **Phone screenshots**.
- **QA APK:** Download **`app-release.apk`** from  
  `app/android/app/build/outputs/apk/release/`  
  Install on a device via `adb install` or sideload. Same signing as release builds (`0027_upload`). Does **not** replace AAB uploads to Play. (`qa_apk` runs Gradle from **`app/android/`**; the `:app` module writes APKs under **`app/android/app/build/…`**, not `app/build/app/…`.)
- **Releases:** Download **`app-release.aab`** from  
  `app/build/app/outputs/bundle/release/`  
  Upload the same artifact type to the matching Play track (Closed / Open / Production).  
  Version **code/name** come from `app/pubspec.yaml` — bump before building if needed.

## What runs in `qa_apk` (order)

1. Print branch + commit + repo root; write `app/android/local.properties` with `sdk.dir` and **`flutter.sdk` verified** against `which flutter`
2. `flutter pub get` (in `app/`)
3. **`./gradlew assembleRelease`** from **`app/android/`** (working directory for Gradle is `app/android/`; wrapper is **`./gradlew`** only — not repo root)
4. Fail the build if **no** `*.apk` exists under **`app/android/app/build/outputs/apk/release/`** (Android `:app` module when Gradle cwd is `app/android/`)
5. Artifact glob: **`app/android/app/build/outputs/apk/release/*.apk`**

## What runs in release workflows (order)

1. `flutter pub get` (in `app/`)
2. `flutter test --exclude-tags store_listing` (skips Play listing widget goldens)
3. `./gradlew bundleRelease` from `app/android/` (**not** `flutter build appbundle` / **not** `flutter build apk`)
4. Log + publish **`app/build/app/outputs/bundle/release/*.aab`**

## Related

- [codemagic_setup.md](codemagic_setup.md)  
- [secrets_checklist.md](secrets_checklist.md)  
- [release_progression.md](release_progression.md)
