# MathPro Premium Keyboard V28 — Mobile Premium Visual Repair

## Scope

V28 is a visual and interaction-polish repair after real-device screenshots. It does not add a new math engine feature and does not change the accepted keyboard key distribution.

## Implemented repairs

### 1. MORE panel scroll reset and clipping repair

- Added stable scroll keys per MORE category for category row and chip row.
- This prevents horizontal scroll offset from leaking between categories, which caused first/last chips to appear half clipped in the real-device screenshots.
- Added horizontal padding inside MORE category and chip scroll rows.
- Removed the redundant right-side active-tab pill from the MORE header.
- Header now reads as a compact `MORE · <category>` title.

### 2. Tab row mobile repair

- Kept internal tab name `Lineer Cebir` unchanged for product and test contracts.
- Display label is shortened to `Lineer` on the tab chip to reduce right-edge clipping on mobile screens.
- Added small horizontal padding to the tab scroll view.

### 3. Long-press indicator noise reduction

- Reduced indicator dot size and opacity.
- Indicators are now shown only for structural/template families, operators, and selected function keys.
- Simple variable/constant labels are less visually noisy.

### 4. Long-press popup width repair

- Long-press popup now computes a desired width from actual option chips.
- The popup no longer remains unnecessarily wide for short option lists after V27 removed the dismiss `×` chip.
- Existing constants are preserved:
  - `panelMinHeight >= 116`
  - `chipHeight >= 88`
  - `boundedIntegralChipWidth >= 104`

### 5. Math glyph compactness repair

- Refined fraction, system, matrix, and vector glyph sizing for compact mobile keycaps.
- Kept invisible `□⁄□` compatibility text in the fraction glyph so existing widget finders remain stable.
- System glyph still avoids raw `Text("=")` to prevent `=` finder collisions.

### 6. Test contract update for removed close chip

- Updated the standalone LongPressPopup test to expect no `×` dismiss chip.
- This reflects the user-approved V27 UX change.

## Preserved contracts

- Visible key distribution is unchanged from V27.
- `KeyConfig.tabs` still contains `Lineer Cebir`.
- `√□` long-press contract remains `['√□', '∛□', '□√□']`.
- `∫□dx` Kalkülüs long-press contract remains `['∫□dx', '∫ₐᵇ', '∬', '∭', '∮']`.
- Cebir integral long-press still filters `∬`, `∭`, `∮`.
- MORE Turkish labels remain: `Kalan`, `EBOB`, `EKOK`, `Asal mı?`, `Yuvarla`, `İşaret`, `Özdeğer`, `Çöz`.
- Graph, history, solver, and Android files were not touched.

## Verification status

Local container does not include Flutter/Dart, so no local `flutter analyze` / `flutter test` PASS is claimed. Static checks were run and recorded in the V28 static check file. User-side Flutter verification is required.
