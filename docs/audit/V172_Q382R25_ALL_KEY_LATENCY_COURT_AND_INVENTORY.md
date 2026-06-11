# V172-Q382R25 — ALL KEY LATENCY COURT AND INVENTORY

## Scope

Q382R25 is a measurement and inventory phase only. It does not optimize input,
does not alter keyboard layout, does not alter MORE/template tray inventory,
does not alter long-press option order, and does not change MathLive command
semantics.

## Why this phase exists

The Q382R23 real-device log showed that a manual one-key-at-a-time phone sweep is
not scalable. The next performance work must know the full entry surface before
any more fast paths are added:

- main keyboard keys across all tabs,
- long-press child options,
- MORE/template tray categories and chips,
- template/function/postfix/wrapper families,
- destructive/UI commands that must not be auto-dispatched.

## Added instrumentation

Q382R25 adds a debug-only court under:

- `lib/debug/latency/mathpro_all_key_latency_court_q382r25_policy.dart`
- `lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart`

The court builds inventory from the real sources:

- `KeyConfig.tabs`
- `KeyConfig.buildKeyboardSections(tab)`
- `KeyConfig.longPressMap`
- `KeyConfig.getLongPressOptions(parent, tab)`
- `ActionUtils.morePanelCategories`

It exports JSON and, when explicitly enabled, runs a direct bridge sweep through
the existing MathLive key path.

## Debug-only activation

The court is inert by default. It only activates in debug when launched with:

```powershell
flutter run -d 23106RN0DA --dart-define=MATHPRO_LATENCY_COURT=true
```

When enabled, the app prints:

- `[Q382R25_COURT] INVENTORY ...`
- `[Q382R25_COURT] INVENTORY_JSON ...`
- `[Q382R25_COURT] DIRECT_BRIDGE_ENTRY ...`
- `[Q382R25_COURT] DIRECT_BRIDGE_END ...`

The existing Q382R23 latency probe is also enabled during the court run so the
same T0-T8 style log can be collected without permanently turning the overlay
back on.

## Dispatch safety

Q382R25 does not auto-dispatch destructive/UI commands by default:

- `C`
- `⌫`
- `↵`
- `MORE`
- `Ans`
- MORE category selectors

They remain in inventory, but are not part of the direct bridge dispatch sweep.
This avoids destructive or navigation state changes during the automatic court.

## Protected areas

No changes were made to:

- keyboard layout/order/labels,
- long-press list contents/order,
- MORE/template tray contents/order,
- Graph,
- Solution,
- History,
- OCR/camera,
- AndroidManifest,
- MainActivity,
- Gradle,
- splash/icon,
- MathLive template semantics.

## What this phase does not claim

Q382R25 does not claim:

- performance improvement,
- WhatsApp-level latency,
- Flutter test PASS without user-side Flutter evidence,
- real-device latency PASS without Q382R25 court logs.

This phase only creates coverage and measurement infrastructure for the later
safe fast-path phases.
