# Google Play — three-stage release progression

**Application ID (must stay constant):** `uk.co.tiabellavideo.hub`  
**Repository:** `0027-uk.co.tiabellavideo.hub`  
**Dart package name:** `hub` (Flutter `pubspec.yaml`); **Android `applicationId` / Play package** = `uk.co.tiabellavideo.hub` only.

This document defines **exactly three** shipped builds in order, **one signing lineage**, and **strictly increasing `versionCode`**. Track names map to Google Play’s **Closed testing**, **Open testing**, and **Production**.

---

## Signing (one lineage)

1. Use **one upload keystore** for all builds in this progression (same key alias / certificate chain Google Play already trusts for this app).
2. Prefer **Play App Signing**: Google holds the app signing key; you sign AABs with the **upload key** only. Do **not** rotate upload keys between these three builds unless you follow Play’s key upgrade flow (otherwise you break the lineage).
3. **Release builds:** sign release AABs with that upload keystore; keep `applicationId` unchanged (`uk.co.tiabellavideo.hub`).

Android version fields are driven from Flutter `pubspec.yaml`:

```yaml
version: <versionName>+<versionCode>
```

---

## Version table (canonical)

| Stage | Play track | versionName | versionCode | `pubspec.yaml` `version` |
|-------|------------|-------------|-------------|---------------------------|
| 1 | Closed testing | `1.0.0` | **1** | `1.0.0+1` |
| 2 | Open testing | `1.0.1` | **2** | `1.0.1+2` |
| 3 | Production | `1.0.2` | **3** | `1.0.2+3` |

Rules:

- **`versionCode` must increase** for every upload (1 → 2 → 3). Never reuse or downgrade.
- **`versionName`** is user-visible; patch bumps reflect the two small in-app copy refinements below.

---

## Build 1 — Closed testing

**Purpose:** Internal / small tester group, first store-quality artifact.

**Version:** `1.0.0+1`

**Code baseline:** Success snackbars use the generic wording *“…not sent to a server.”* (see code-level deltas section).

**Minimal changelog (Play “Release notes” / internal):**

- Initial closed-testing build for `uk.co.tiabellavideo.hub`.
- Local-only contact and quote drafts; no backend submission.

**Play Console:** Create closed track release → upload AAB built with `1.0.0+1` → roll out to closed testers.

---

## Build 2 — Open testing

**Purpose:** Wider tester audience; first **minimal** UX copy improvement.

**Version:** `1.0.1+2`

**Code change vs build 1:** Contact form success snackbar only — clarifies that the message is not sent to **our** servers (see exact diff below).

**Minimal changelog:**

- Clarified contact save confirmation copy (still device-only; no server upload).

**Play Console:** Promote or upload new AAB to **Open testing** with `versionCode` 2. Ensure closed track is superseded or aligned per your rollout policy.

---

## Build 3 — Production

**Purpose:** Public production release; second **minimal** UX copy improvement.

**Version:** `1.0.2+3`

**Code change vs build 2:** Quote tool success snackbar only — same clarification pattern as contact (see exact diff below).

**Minimal changelog:**

- Clarified quote save confirmation copy (still device-only; no server upload).

**Play Console:** Create **Production** release (staged rollout as you prefer) with `versionCode` 3. Complete required declarations (Data safety, content rating, etc.) independently of this doc.

---

## Code-level deltas (minimal, between builds)

Repository **HEAD** is intended to match **build 3 (production)**.

### Build 1 → Build 2

**File:** `app/lib/pages/s10_contact_page.dart`  
**Widget:** success `SnackBar` after `saveContactDraft` succeeds.

| Build 1 | Build 2 |
|---------|---------|
| `Message saved on this device only — not sent to a server.` | `Message saved on this device only — not sent to our servers.` |

No layout, navigation, or package changes.

### Build 2 → Build 3

**File:** `app/lib/pages/s07_quote_tool_page.dart`  
**Widget:** success `SnackBar` after `saveQuoteDraft` succeeds.

| Build 2 (unchanged from build 1) | Build 3 |
|----------------------------------|---------|
| `Quote request saved on this device only — not sent to a server.` | `Quote request saved on this device only — not sent to our servers.` |

Build 3 **includes** the build 2 contact change plus this quote change.

---

## Practical workflow (short)

1. **Branch/tag** each store upload (e.g. `release/1.0.0+1-closed`, `release/1.0.1+2-open`, `release/1.0.2+3-prod`) so artifacts are reproducible.
2. For each stage, set `pubspec.yaml` `version` to the row in the table, then `flutter build appbundle`.
3. Upload the AAB to the matching Play track; never upload a lower `versionCode`.
4. Keep **the same** `applicationId` and signing keys throughout.

---

## Out of scope (by design)

- No UI redesign, no new screens, no new features beyond the two snackbar string tweaks for builds 2 and 3.
- No change to privacy policy URL or package name.
