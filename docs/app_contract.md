# Implementation contract — Tiabella Production Hub (Android / Flutter)

This document is the authoritative **implementation contract** for a real **Flutter Android** app derived from the final design source **`artifacts/design/0027.pen`**. It does **not** add product scope beyond that design.

**Contract document set:** `docs/app_contract.md` (this file), `docs/routes.yaml`, `docs/action_map.yaml`, `docs/test_matrix.yaml`.

---

## 1. Project identifiers

| Item | Value |
|------|--------|
| Android application ID / Dart package name | `uk.co.tiabellavideo.hub` (requirement alias: `<PACKAGE_NAME>`) |
| Target repository name | `0027-uk.co.tiabellavideo.hub` |
| Privacy policy URL (external, fixed) | `https://tiabellavideo.co.uk/privacy-policy` (requirement alias: `<PRIVACY_POLICY_URL>`; same value as key `PRIVACY_POLICY_URL` in YAML) |

**Non-negotiable (Settings):** On **Screen 13 — Settings**, the row **“Privacy Policy”** MUST open the system browser (or in-app WebView) at a URL that is **byte-for-byte identical** to **`<PRIVACY_POLICY_URL>`** (i.e. exactly):

`https://tiabellavideo.co.uk/privacy-policy`

No redirects substituted in app code, no query-string variants, no “pretty” shortening — unless the platform opens an equivalent user-visible URL, the **intent URI** the app launches MUST still be exactly that string (see `docs/routes.yaml` constant `PRIVACY_POLICY_URL`).

---

## 2. Design source of truth

- **Primary:** `artifacts/design/0027.pen` (Pencil), all frames whose name matches `Screen …`.
- **Secondary (assets):** Raster assets under `app/assets/images/` (and contract-listed store assets under `artifacts/store-assets/`). The app MUST ship these assets (or byte-equivalent replacements) so **no Pencil.dev** runtime is required.

---

## 3. Screen inventory (complete — 17)

Every row is a **real screen** in the final design. **None may be omitted** or merged for “simplicity.”

| screen_id | # | Design name | Stable route name | Notes |
|-----------|---|-------------|-------------------|--------|
| S01 | 1 | Screen 01 — Splash | `/splash` | No explicit button in design; see §6.1 |
| S02 | 2 | Screen 02 — Onboarding Intro | `/onboarding/intro` | |
| S03 | 3 | Screen 03 — Onboarding Workflow | `/onboarding/workflow` | |
| S04 | 4 | Screen 04 — Dashboard | `/dashboard` | Home tab selected |
| S05 | 5 | Screen 05 — Portfolio | `/portfolio` | “All” category selected |
| S05B | 6 | Screen 05b — Portfolio: Production | `/portfolio/category/production` | |
| S05C | 7 | Screen 05c — Portfolio: Post-Production | `/portfolio/category/post-production` | |
| S05D | 8 | Screen 05d — Portfolio: Corporate | `/portfolio/category/corporate` | |
| S06 | 9 | Screen 06 — Portfolio Image Preview | `/portfolio/preview` | Shows sample project “Corporate Campaign — Brand Launch” |
| S07 | 10 | Screen 07 — Quote Tool | `/quote` | Quote tab selected |
| S08 | 11 | Screen 08 — Service Detail | `/service/detail` | “Full-Service Video Production” |
| S09 | 12 | Screen 09 — Workflow | `/workflow` | |
| S10 | 13 | Screen 10 — Contact | `/contact` | |
| S11 | 14 | Screen 11 — About Us | `/about` | |
| S12 | 15 | Screen 12 — Order Status | `/orders/status` | Sample order `TPH-2024-0112` |
| S13 | 16 | Screen 13 — Settings | `/settings` | Privacy row → **`<PRIVACY_POLICY_URL>`** exactly |
| S14 | 17 | Screen 14 — Legal Information | `/legal` | |

---

## 4. Navigation model

### 4.1 Internal routes

- Use **named routes** or an equivalent router (e.g. `go_router`) with paths **exactly** as listed in `docs/routes.yaml`.
- **Bottom tab bar** (HOME / PORTFOLIO / QUOTE / STATUS / MORE): in **`artifacts/design/0027.pen`**, the pill navigator appears on **S04, S05, S05b, S05c, S05d, S07, S09, S10, S11, S12, S13**. It does **not** appear on **S01, S02, S03, S06 (preview), S08 (service detail), or S14 (legal)** — do not add a tab bar to those frames.
- Tab taps are **internal** route changes (reuse stable keys `TK_TAB_HOME` … `TK_TAB_MORE` on every tab-hosting screen; see `docs/action_map.yaml` conventions):
  - HOME → `/dashboard`
  - PORTFOLIO → `/portfolio`
  - QUOTE → `/quote`
  - STATUS → `/orders/status`
  - MORE → `/settings` (design uses “MORE”; route is Settings)

### 4.2 External actions

Classify as **external** (platform intents). Summary (details and test keys in `docs/action_map.yaml`):

| Kind | Where (screens) | Mechanism |
|------|-----------------|-----------|
| Phone | S10 | `tel:` / dial — +447388750289 |
| Email | S10, S11 | `mailto:` — info@tiabellavideo.co.uk |
| Website | S01 (footer), S10, S11 | `https://tiabellavideo.co.uk` |
| Privacy policy | S13 | `https://tiabellavideo.co.uk/privacy-policy` **exactly** (`PRIVACY_POLICY_URL`) |
| Maps | S11 | Maps search intent — query `Tiabella` (no invented address; see `routes.yaml` `maps_search_query`) |
| Share | S06 | Android share sheet for preview content |

### 4.3 Internal vs external (contract rule)

- **Internal:** any navigation to a route under `docs/routes.yaml`, plus **local-only** UI (carousel, toggles, form validation) that does not leave the app.
- **External:** any action that opens another app or system UI (browser, phone, email client, maps, share sheet).

---

## 5. Forms, fields, validation, states

### 5.1 Contact — “Send a Message” (Screen 10)

| Field | Label (design) | Placeholder (design) | Type | Required |
|-------|----------------|----------------------|------|----------|
| full_name | Full Name | Your full name | text | yes |
| email | Email Address | your@email.com | email | yes |
| message | Message | Describe your project or enquiry... | multiline text | yes |

**Validators (client-side, honest without backend):**

- `full_name`: non-empty after trim; reasonable max length (e.g. 120).
- `email`: non-empty + valid email format.
- `message`: non-empty after trim; min length (e.g. 10) optional; max length (e.g. 4000).

**States:**

- **Empty:** placeholders visible as in design; submit disabled OR submit shows inline errors (choose one; document in QA).
- **Populated:** user text replaces placeholders.
- **Submitting:** button disabled, progress indicator (design does not specify — keep minimal).
- **Success:** non-blocking confirmation (snackbar/dialog) + optionally clear form; **no** claim that message was delivered to server unless backend exists.
- **Error:** network/storage failure only if app persists locally; otherwise success path is “queued locally” or “copied to clipboard” — **do not fake** server delivery.

### 5.2 Quote Tool (Screen 07) — not a classic form

The design uses **selectable cards and rows**, not free-text fields:

- **Project type:** Video Production | Post Production | Photography (single selection).
- **Project duration:** 1 Day | 2–3 Days | 1 Week+ (single selection; design shows **2–3 Days** as selected).
- **Add-ons:** Colour Grading | Motion Graphics | Voiceover & Audio (multi-toggle; design shows **Colour Grading** checked, others unchecked).

**Submit Quote Request** (red button in design):

- **Success (no backend):** show honest confirmation (“Request saved on this device” / “We’ll contact you…” only if same copy exists in design — design says they respond within 1 business day; treat as **static copy** + local persistence or share/export, not as API guarantee).
- **Error:** only for local persistence failure.

### 5.3 Settings toggles (Screen 13)

- **Notifications** — row + switch (design implies toggle).
- **Email Updates** — row + switch.

**Without backend:** persist in `SharedPreferences` (or equivalent); no server sync.

---

## 6. Tappable elements — rules

### 6.1 Splash (Screen 01)

Design shows **no** explicit button. Contract options (pick **one** in implementation; do not add new UI chrome):

- **A)** Auto-advance to `/onboarding/intro` after a short delay, or  
- **B)** Treat tap anywhere on safe content as continue to `/onboarding/intro`.

Document chosen option in README.

### 6.2 Onboarding

- **Screen 02:** `Skip` → `/dashboard` (or `/onboarding/workflow` if product requires linear flow — design suggests Skip skips ahead; use **`/dashboard`** as “entered app”). `Next` → `/onboarding/workflow`.
- **Screen 03:** `Back` → `/onboarding/intro`. `Get Started` → `/dashboard`.

### 6.3 Dashboard quick tiles

Six tiles: Services, Portfolio, Quote, Workflow, Order Status, Contact → routes in `action_map.yaml`.

### 6.4 Portfolio

- **Filter chips** (where shown): All, Production, Post-Production, Corporate → internal category routes or filter state on `/portfolio` **plus** dedicated routes for 05b/05c/05d screens.
- **Slider icon** (header): design-only filter affordance — wire to same filter behavior **or** no-op with accessibility label “Filter” (prefer wiring if behavior exists in design).
- **Grid cells:** each image+title cell → `/portfolio/preview` with **project key** matching the label text in the design for that cell (see `action_map.yaml`).

### 6.5 Portfolio preview (Screen 06)

- Back (chevron + “Portfolio”) → pop or `/portfolio`.
- Share → external share intent.
- Image nav chevrons / dots → local UI state only (carousel).
- **Request a Quote** → `/quote`.

### 6.6 Quote header `X`

- Closes quote flow → **pop** if modal stack, else `/dashboard`.

### 6.7 Service detail (Screen 08)

- Back (“Services”) → pop or `/dashboard` (match navigation stack from entry).
- **Get a Quote for This Service** → `/quote` (pre-select project type **Video Production** if arriving from this screen).

### 6.8 Contact quick actions

- Call / Email / Website → external intents using the same values as the detail rows.

### 6.9 About (Screen 11)

- **Open in Maps** → external maps intent (geo URI or maps search — no invented address if not in design; use generic “Tiabella” query only if design lacks coordinates — **design shows map image only**; use **label-based** maps search “Tiabella” or company name from screen copy to avoid inventing address).
- Email / website lines → same as Contact external actions.

### 6.10 Order status (Screen 12)

- **Refresh** (header icon): reload from **local** store or re-fetch stub — without backend, refresh re-applies static sample data (honest).

### 6.11 Settings (Screen 13)

- **Privacy Policy** → external URL **exactly** `PRIVACY_POLICY_URL`.
- **Legal Information** → `/legal`.
- **Sign Out** → clear local session/preferences; navigate to `/splash` or `/onboarding/intro` (choose one; no backend).

### 6.12 Legal (Screen 14)

- Back (“Settings”) → `/settings`.

---

## 7. Minimum honest local mechanics (no backend)

1. **Asset bundle:** all images referenced by the shipped design implementation.
2. **Local persistence:** `SharedPreferences` (or Hive) for: quote selections, contact draft, settings toggles, “last viewed” portfolio item.
3. **Static content screens:** Workflow, Legal, About body text matches design copy.
4. **Order status:** static **sample** project `Corporate Brand Video` / ref `TPH-2024-0112` / milestones as in design — labeled as sample in developer docs only, not necessarily in UI (do not add “demo” badge unless in design).

---

## 8. Testability

Stable keys for widgets are defined in `docs/test_matrix.yaml` and referenced from `docs/action_map.yaml` where applicable.

---

## 9. Out of scope (for this contract)

- Backend APIs, authentication servers, push notification delivery.
- Building the app (implementation code) — contract only.

---

## 10. References

- Design: `artifacts/design/0027.pen` — frames named `Screen 01 …` through `Screen 14 …` and `Screen 05b/c/d …`.
