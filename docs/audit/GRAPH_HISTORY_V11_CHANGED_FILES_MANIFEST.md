# Graph / Premium History V11 — Changed Files Manifest

## Runtime files changed

- `lib/app/app_shell.dart`
  - Added AnimatedSwitcher-based keyboard dock choreography for history open/close.
  - Added custom fade/slide/scale fullscreen graph route transition.
  - Strengthened workspace/history transition with scale/fade choreography.

- `lib/features/graph/graph_card.dart`
  - Converted graph preview card to a stateful premium motion surface.
  - Added fade/slide/scale entry, keyed graph surface transitions, glass sheen, press-scale graph controls, and active trace glow.

- `lib/features/graph/graph_fullscreen_page.dart`
  - Added fullscreen graph motion shell, animated surface swap, glass sheen, and trace overlay transition.
  - Preserved existing pan/pinch/zoom/reset/settings state return behavior.

- `lib/features/history/history_panel.dart`
  - Added elastic upward dismiss feedback through opacity/scale/translation.
  - Preserved hidden-by-default and close-button behavior.

- `lib/features/history/history_item_card.dart`
  - Converted history item cards to stateful press-feedback surfaces.
  - Added animated graph preview reveal and stronger pinned/active visual feedback.

- `lib/features/history/history_style.dart`
  - Tuned drawer/micro animation durations for premium motion consistency.

- `test/graph_history_regression_test.dart`
  - Added V11 premium motion checks for graph preview and fullscreen graph motion shell.

- `README.md`
  - Updated package description and V11 scope.

## Keyboard files deliberately unchanged

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
