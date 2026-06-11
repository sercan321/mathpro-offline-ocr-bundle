# Phase 17 Static Verification

## Checks performed in ChatGPT container
- Full project ZIP can be created.
- Meta ZIP can be created.
- Local Dart relative import check found no missing imports.
- `legacy-deriveSlotRects-size-marker:)` regression string not found.
- Old `legacy evaluator phase marker` user-facing message not found.
- `withOpacity` not found in `lib/` or `test/`.
- Keyboard source files were intentionally left untouched.

## Checks not performed here
Flutter SDK is not installed in the ChatGPT container, so these must be run on the user's machine.
