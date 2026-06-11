# MathPro Final UI / Editor Repair + History Removal Audit

## Scope

This delivery targets the five reported UI/editor issues and the explicit request to remove the History section:

1. Expression editor area too narrow.
2. Expression input should start centered and expand outward.
3. Bottom keyboard must not overlap Android navigation/gesture area.
4. Tap-to-caret movement and cursor baseline alignment must be improved.
5. Integral long-press must not expose double integral; definite integral must be a true upper/lower slot template.
6. History must be removed from the current runtime surface.

## Runtime changes

- `WorkspacePanel` no longer reserves a History handle area.
- The editor viewport receives more height and no longer uses `FittedBox(scaleDown)` as the main expression surface wrapper.
- `EditorViewport` uses a larger centered canvas and keeps the inline caret visible when a linear caret is selected.
- `MathProCaretController` raises caret baseline alignment and improves centered linear caret metrics.
- `BottomDock` uses the real Android bottom inset instead of clamping it to 34 px.
- `MathProAppShell` no longer creates or displays History state/drawer/persistence.
- The History runtime files were removed from `lib/`.
- `shared_preferences` was removed because the history store was the only runtime consumer.

## Preserved product contracts

- Tabs remain: `Temel`, `Cebir`, `Kalkülüs`, `Kompleks`, `Lineer Cebir`.
- `MORE` remains visible and unchanged as text.
- `Ans` remains a direct key.
- `↵` remains the evaluate/enter key.
- `=` remains literal equality, not evaluate.
- Basic 20-key core remains unchanged.
- Expanded 8×5 keyboard structure remains unchanged.
- Integral long-press remains free of `∬`.
- Definite integral remains `∫_{□}^{□}(□)d□` with lower/upper/body/differential slots.

## Honest verification status

The delivery environment did not include Flutter/Dart SDK, so these commands were not executed here:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Static checks performed here:

- no missing Dart import targets under `lib/` / `test/`,
- no runtime `HistoryStore`, `HistoryDrawer`, `history_handle`, or `shared_preferences` imports,
- package hygiene scan before ZIP creation,
- keyboard-contract text scan,
- integral long-press text scan.

## Manual real-device checks still required

Run on the Android device:

1. Type `ln(tan(tan(tan(9))))` and verify the editor surface feels spacious.
2. Type the first symbol into an empty editor and verify centered start.
3. Verify the bottom row `MORE 0 . Ans` sits immediately above Android navigation/gesture area without overlap.
4. Type `tan(cos(ln(9)))`, tap inside the expression, and verify caret movement and baseline.
5. Long-press `∫`; verify `∬` is absent and `∫ₐᵇ` appears as bounded upper/lower-slot integral.
6. Verify there is no History handle/drawer/runtime surface.
