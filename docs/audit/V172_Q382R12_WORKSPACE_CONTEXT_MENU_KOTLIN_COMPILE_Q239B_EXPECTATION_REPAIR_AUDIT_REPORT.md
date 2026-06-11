# V172-Q382R12 Workspace Context Menu Kotlin Compile / Q239B Expectation Repair Audit

## Scope
- Repair user-side Android Kotlin compile blocker at `MainActivity.kt:4765`.
- Repair stale Q239B camera test expectation that treated Q382 context-menu `Icons.more_horiz_rounded` safe-zone as the old removed MORE placeholder button.

## Intentional changes
- `MainActivity.kt`: parenthesized the boolean expression in the `vocabularySidecarsReady` map entry.
- `test/v172_q239b_camera_permission_capture_shell_test.dart`: allows `Icons.more_horiz_rounded` only when paired with `mathpro-q382-expression-context-menu-safe-hit-zone`; still blocks `mathpro-more-placeholder-button`.
- Q382 policy/test/manifest/README/verifier/audit metadata updated.

## Non-goals
- No runtime feature expansion.
- No fake OCR, no fake solver, no Solve/Graph/Solution/History auto-trigger.
- No keyboard/MORE/long-press/MathLive production asset mutation.
- No pubspec/Gradle/AndroidManifest changes.

## Assistant-side limitation
Flutter/Android SDK is unavailable in the assistant environment, so no `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.
