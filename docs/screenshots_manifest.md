# Play Store screenshots manifest

**Application ID:** `uk.co.tiabellavideo.hub`  
**Repository:** `0027-uk.co.tiabellavideo.hub`  
**Privacy policy (reference):** https://tiabellavideo.co.uk/privacy-policy  

All captures are **existing in-app screens** (no mock “marketing” layouts). Generator: widget golden tests only (no `flutter drive`).

## Output location

| Item | Path |
|------|------|
| PNG files | `app/test/screenshots/goldens/` |
| Golden test | `app/test/screenshots/store_screenshot_golden_test.dart` |
| Harness (1080×1920, prefs, fonts) | `app/test/screenshots/store_screenshot_harness.dart` |

## Files and captured states

| # | File name | Route | Screen (design) | Stable state notes |
|---|-----------|-------|-----------------|-------------------|
| 1 | `store_01_splash.png` | `/splash` | S01 Splash | Initial frame; splash auto-advance timer **not** waited — static branding frame. |
| 2 | `store_02_onboarding_intro.png` | `/onboarding/intro` | S02 Onboarding Intro | First onboarding screen; asset uses `errorBuilder` if image missing (deterministic placeholder). |
| 3 | `store_03_dashboard.png` | `/dashboard` | S04 Dashboard | Home / “Production Hub” + quick access; banner uses asset or placeholder. |
| 4 | `store_04_portfolio.png` | `/portfolio` | S05 Portfolio | Main portfolio grid (“All” chip selected on this route). |
| 5 | `store_05_quote.png` | `/quote` | S07 Quote Tool | Default quote selections (no saved draft in seeded prefs). |
| 6 | `store_06_contact.png` | `/contact` | S10 Contact | Empty message fields; quick actions row visible. |
| 7 | `store_07_settings.png` | `/settings` | S13 Settings | Notifications **on**, email updates **off** (seeded prefs). |
| 8 | `store_08_portfolio_preview.png` | `/portfolio/preview?project_id=corporate_campaign` | S06 Portfolio Preview | Default preview project from `docs/routes.yaml` id list for S05. |

## Not included (still real screens; optional future goldens)

If you need more Play slots later, these routes exist but are **not** in the current manifest: `/onboarding/workflow`, `/portfolio/category/*`, `/service/detail`, `/workflow`, `/about`, `/orders/status`, `/legal`.

## Naming for Play Console

Upload the PNGs from `app/test/screenshots/goldens/` to Google Play **Phone screenshots** (portrait). Ordering above matches a typical story: brand → onboarding → core journeys → portfolio detail.
