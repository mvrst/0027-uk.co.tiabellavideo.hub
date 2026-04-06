# INC-20260405-007 — Release build uses debug signing

| Field | Value |
|-------|--------|
| **Package** | `uk.co.tiabellavideo.hub` (unchanged) |
| **Date** | 2026-04-05 |
| **Area** | signing |
| **Severity** | medium |
| **Status** | open |

## Summary

`release` build type in Android Gradle still references the **debug** signing config, which is invalid for real Play uploads under your upload key policy.

## Symptoms

- Play Console may reject the AAB or you ship with a non-production key lineage if unchanged before store submission.

## Root cause

Template / local-dev placeholder not replaced with `release` signing backed by keystore + `key.properties` (or CI secrets).

## Fix / workaround

- Define `signingConfigs.release` (keystore path, passwords from env or `key.properties` excluded from git).
- Set `buildTypes.release.signingConfig` to that config.
- Align with `docs/release_progression.md` (single upload-key lineage).

## Prevention

`FP-07`

## References

- `app/android/app/build.gradle.kts` (`signingConfig = signingConfigs.getByName("debug")`)
- `docs/release_progression.md`
