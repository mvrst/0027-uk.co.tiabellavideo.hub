# Codemagic setup — Tiabella Production Hub

**Repository:** `0027-uk.co.tiabellavideo.hub` (GitHub)  
**Application ID:** `uk.co.tiabellavideo.hub`  
**Flutter root in repo:** `app/`  
**Keystore reference in YAML:** `0027_upload` (must match the name in Codemagic → Code signing identities)

## 1. Connect the app

1. In [Codemagic](https://codemagic.io), add the GitHub app and select **`mvrst/0027-uk.co.tiabellavideo.hub`** (or your fork).
2. Ensure **`codemagic.yaml`** at the **repository root** is detected (root is clean; Flutter lives under `app/` only).

## 2. Instance types

Workflows in `codemagic.yaml` use **`mac_mini_m2`** (adjust `instance_type` only if your Codemagic plan requires a different machine class).

## 3. Android code signing (`0027_upload`)

1. Codemagic → **Teams** → **Global variables & secrets** (or app **Environment variables**) as required by your plan.
2. **Code signing identities** → **Android keystores** → upload the **upload keystore** (see `ops/README-android-keystore.md`).
3. Set the keystore **reference name** to exactly **`0027_upload`** so it matches:

   ```yaml
   android_signing:
     - 0027_upload
   ```

4. Codemagic injects **`CM_KEYSTORE_PATH`**, **`CM_KEYSTORE_PASSWORD`**, **`CM_KEY_ALIAS`**, **`CM_KEY_PASSWORD`** during release workflows. `app/android/app/build.gradle.kts` uses these when `CM_KEYSTORE_PATH` is set.

**`store_screenshots`** does **not** list `android_signing` — no keystore required.

**`qa_apk`** lists **`0027_upload`** like release workflows: same signing env vars and `app/android/app/build.gradle.kts` behavior, but builds a **device-installable APK** (not an AAB).

## 4. Manual-first builds

Workflows are intended to be **started manually** from the Codemagic UI (pick workflow → **Start new build**). To avoid accidental spend from Git webhooks, disable or narrow automatic builds in the Codemagic **application settings** if your team enables them globally.

## 5. What each workflow does

| Workflow | Signing | Main output |
|----------|---------|-------------|
| `store_screenshots` | No | PNG goldens under `app/test/screenshots/goldens/` |
| `qa_apk` | `0027_upload` | Signed **`app-release.apk`** under `app/build/app/outputs/apk/release/` (Gradle `assembleRelease`, not `flutter build apk`) |
| `closed_release` | `0027_upload` | `app-release.aab` |
| `open_release` | `0027_upload` | `app-release.aab` |
| `production_release` | `0027_upload` | `app-release.aab` |

Release workflows **do not** run `flutter build apk` or `flutter build appbundle`; they run **`./gradlew bundleRelease`** from `app/android/` after `flutter pub get` and `flutter test --exclude-tags store_listing`.

**`qa_apk`** (manual QA on a physical device) runs **`./gradlew assembleRelease`** from `app/android/` after `flutter pub get` only — **no** `flutter test`, **no** AAB. Primary Play uploads stay **AAB** via `closed_release` / `open_release` / `production_release`.

## 6. Gradle wrapper

`app/android/gradlew` (and wrapper JAR) are committed so CI does not depend on `flutter build` to generate them. `.gitattributes` keeps `gradlew` with **LF** line endings for Linux.

## Related docs

- [secrets_checklist.md](secrets_checklist.md)
- [release_trigger_instructions.md](release_trigger_instructions.md)
- [screenshots_workflow.md](screenshots_workflow.md)
