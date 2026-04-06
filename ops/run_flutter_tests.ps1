# Run widget + integration smoke tests from repo root (requires Flutter on PATH).
$ErrorActionPreference = "Stop"
$app = (Resolve-Path (Join-Path $PSScriptRoot "..\app")).Path
Set-Location $app
flutter pub get
flutter test
Push-Location integration_test
try {
  flutter pub get
  flutter test hub_ci_smoke_test.dart
} finally {
  Pop-Location
}
