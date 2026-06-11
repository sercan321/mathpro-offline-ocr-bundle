# V118.1 — Windows Root / Analyze Repair Audit

## Scope
Targeted repair after the user ran commands from the parent extraction folder and `flutter analyze` reported one `prefer_const_declarations` info.

## Changes
- Updated `pubspec.yaml` to `0.118.1+1181`.
- Changed `final caretWidth = 2.0;` to `const caretWidth = 2.0;` in `editor_interaction_layer.dart`.

## Not Changed
- Keyboard layout, tabs, MORE, Ans, ↵, =.
- Long-press option lists/order.
- Graph, History, Solution panel UI.
- MathJax/WebView render surface files.

## Important Run Instruction
The ZIP contains a root folder named `MathProFlutterPhase17`. After extraction, run commands inside that inner project folder, not the parent folder created by Windows extraction.

Example:
```powershell
cd "C:\Users\user\Downloads\MathProFlutterPhase17 (16)\MathProFlutterPhase17"
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Local Limitation
Flutter/Dart were not available in the assistant environment, so no local Flutter PASS is claimed.
