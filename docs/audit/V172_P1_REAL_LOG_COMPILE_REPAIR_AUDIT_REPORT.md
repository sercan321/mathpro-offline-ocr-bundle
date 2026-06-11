# V172-P1 Real-Log Compile Repair Audit Report

## Trigger
User-side Flutter test log reported compile-breaking failures:
- nullable `CursorAnchor?` property access in `editor_controller.dart`
- duplicate `integralDifferential` key in `slot_priority_policy.dart`
- stale package metadata source-of-truth still pinned to V171
- V98 source-scan contract rejected literal `source: 'tap-up'`
- analyzer warning for unused `mildUp` in renderer sync geometry policy

## Repair
- Promoted nullable cursor anchor through a local non-null variable before reading fields.
- Removed duplicate `integralDifferential` const map entry.
- Kept tap-up behavior routed through `EditorGestureRouterPolicy.tapUpSelectionSource` instead of the legacy literal source string.
- Updated `MathProPackageContract` / `pubspec.yaml` / README top metadata to V172-P1.
- Relaxed stale V171 exact version test to use the package metadata contract instead of pinning to V171.
- Removed unused `mildUp`.

## Preserved
- Keyboard layout
- MORE / Ans / = / ↵ contracts
- long-press maps/order
- Graph / History / Solution
- no-loupe editor policy
- green overlay disabled policy

## Not claimed
Flutter analyze/test/run were not executed in this environment.
