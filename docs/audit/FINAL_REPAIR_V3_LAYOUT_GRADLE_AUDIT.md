# MathPro Final Repair V3 — Layout / Navigation / Popup / Gradle Audit

## Trigger
User log showed:
- `flutter analyze` passed.
- `flutter test` failed with `RenderFlex overflowed by 5.0 pixels on the bottom` in `workspace_panel.dart`.
- `flutter run` failed before producing/installing an APK with `'""' is not recognized as an internal or external command`.
- `adb` was not available from PowerShell PATH, so the previous uninstall command could not run.

## Root causes found
1. WorkspacePanel allowed a fixed minimum editor height larger than the actual remaining height when the MORE tray or toolbar consumed space.
2. Keyboard dock was too tall for the available app shell, especially in widget-test and short-device profiles.
3. Android bottom inset fallback was safer than before, but the keyboard content height remained too large.
4. Integral bounded glyph in the long-press popup could be clipped by the popup/list viewport.
5. Function argument slots were still not forgiving enough for real finger tapping.
6. `gradlew.bat` trusted a defined but malformed/quoted `JAVA_HOME`, which can produce the `'""' is not recognized` failure.

## Changes
- WorkspacePanel height calculation now never allocates editor height beyond the true remaining panel height.
- MORE/template tray and result/status reserved heights were made compact-safe.
- Keyboard content heights were reduced to target a more professional screen ratio.
- Keyboard vertical gaps reduced from 8 to 6 dp to preserve key usability while lowering total dock height.
- Bottom inset now uses `viewPadding`, `padding`, and `systemGestureInsets`, with a 48 dp fallback and 44–88 dp clamp.
- LongPressPopup height/chip envelope increased so `∫ₐᵇ` is not clipped.
- Bounded integral glyph envelope increased for chip rendering.
- `functionArgument` minimum touch target increased to 82 dp with larger slop and priority.
- `gradlew.bat` now strips quotes from JAVA_HOME and falls back to `java.exe` when JAVA_HOME is malformed.

## Not changed
- Keyboard order.
- Keyboard tab names.
- `MORE` text.
- `Ans` key location.
- `↵` command behavior.
- `=` literal text behavior.
- Integral long-press remains free of `∬`.
- History runtime remains removed.

## Verification available in this environment
- Static import target check: PASS.
- Runtime history/shared_preferences check: PASS.
- Dirty ZIP artifact check: PASS.
- Keyboard contract grep check: PASS.
- Integral long-press contract grep check: PASS.
- Gradle batch robustness grep check: PASS.

## Verification not run here
Flutter SDK is not installed in this environment, so `flutter analyze`, `flutter test`, and `flutter run` were not executed here. User must run them locally.
