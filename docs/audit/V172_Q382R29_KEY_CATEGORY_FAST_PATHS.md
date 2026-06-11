# V172-Q382R29 — KEY CATEGORY FAST PATHS

## Result

Q382R29 centralizes MathPro/Gauss keyboard latency behavior into a single category fast-path policy.  It is not a broad UI rewrite and it does not expand optimistic echo.

## Scope

Added:

- `lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart`
- `test/v172_q382r29_key_category_fast_paths_test.dart`
- `tool/verify_key_category_fast_paths_v172_q382r29.mjs`

Modified:

- `lib/features/keyboard/keyboard_latency_closure_q382r24_policy.dart`
- `lib/app/app_shell.dart`
- `lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart`

## What changed

Q382R29 defines explicit key categories:

- `linearSafe`
- `operatorText`
- `textSymbol`
- `structureTemplate`
- `wrapperTemplate`
- `postfixTemplate`
- `functionTemplate`
- `longPressParent`
- `longPressChild`
- `moreTemplate`
- `moreCategory`
- `deleteRepeat`
- `clearPriority`
- `evaluateAction`
- `answerRecall`
- `uiCommand`

These categories now drive:

1. tap-down dispatch safety,
2. downstream MathLive-to-controller sync debounce,
3. Q382R25 latency court category labels,
4. documented JS-side queue eligibility.

## Safety decisions

- Linear/text labels can use tap-down dispatch when they have no long-press inventory.
- Structural templates, wrappers, postfix templates, MORE, long-press options, delete, clear and evaluate do not use tap-down dispatch.
- Template/long-press/MORE entries remain fast through the Q382R28 JS-side command queue and category-aware downstream debounce, not through unsafe tap-down insertion.
- Clear remains priority/direct and is never deferred.
- Optimistic echo remains limited to Q382R27 linear-safe labels only.

## Protected areas

Untouched:

- Keyboard layout/order/labels
- Long-press inventory/order
- MORE/template tray inventory/order
- MathLive JS bridge implementation
- Graph
- Solution
- History
- OCR/camera
- AndroidManifest
- MainActivity
- Gradle
- Splash/icon
- Pan/drag-scroll

## Honest limits

This phase can be verified statically and by Flutter tests.  It does not claim real-device PASS or WhatsApp-level latency without user-side device logs.
