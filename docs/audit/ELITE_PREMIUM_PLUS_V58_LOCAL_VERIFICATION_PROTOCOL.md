# V58 Local Verification Protocol

Run from the project root after extracting the full ZIP.

## Required commands

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Profile/performance check

```bash
flutter run --profile -d 23106RN0DA
```

## Visual checklist

- Normal state shows workspace + tabs + keyboard only.
- Solution Steps are hidden by default.
- Solution Steps open only from top action icon.
- MORE closes Solution Steps and Graph preview.
- History opens without stacking MORE/Solution panels.
- Fullscreen Graph opens without keyboard mutation.
- No bottom overflow on the target Android device.
- Keyboard keys, tabs, MORE, Ans, `=`, and `↵` remain in the expected places.
- Long-press popups still open and preserve their option lists.

## Performance checklist

In profile mode / DevTools Performance, inspect:

- key press response
- MORE open/close
- Solution Steps open/close
- History open/close
- Graph preview paint
- Fullscreen Graph pan/zoom/trace/reset/settings

Target: avoid visible jank and keep ordinary transitions within a 60 FPS-oriented frame budget.
