# INC-20260405-001 — Flutter/Dart not on PATH

| Field | Value |
|-------|--------|
| **Package** | `uk.co.tiabellavideo.hub` (unchanged) |
| **Date** | 2026-04-05 |
| **Area** | workflow |
| **Severity** | low |
| **Status** | mitigated |

## Summary

Local and agent shells sometimes lack `flutter` / `dart` on `PATH`, so `flutter test` and `dart analyze` could not be executed in that environment.

## Symptoms

- `CommandNotFoundException` / `'flutter' is not recognized` when running tests or analyzer from PowerShell.

## Root cause

SDK installed but not exposed globally, or CI/agent image without Flutter.

## Fix / workaround

- Install Flutter and add `bin` to `PATH`, or use FVM/`asdf` with shims on PATH.
- Run tests from `app/` per `docs/flutter_testing.md`.
- Use `ops/run_flutter_tests.ps1` once Flutter is available.

## Prevention

`FP-01`

## References

- `docs/flutter_testing.md`
