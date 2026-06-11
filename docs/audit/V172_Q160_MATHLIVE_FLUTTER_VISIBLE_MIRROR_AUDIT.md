# V172-Q160 MathLive Flutter Visible Mirror Audit

Q160 is a real-device visibility safety repair after Q159 still produced a blank editor on phone even though keyboard taps visually fired.

## Scope
- Adds a non-interactive Flutter math mirror over the MathLive WebView card.
- Mirrors accepted keyboard insert/delete/clear commands immediately in Flutter.
- Converts MathLive placeholders `#@`, `#0`, and `#?` to visible square placeholders for fallback rendering.
- Keeps the MathLive WebView path and bridge intact.

## Non-goals
- Does not change keyboard layout or key order.
- Does not change MORE inventory or long-press order.
- Does not change MathLive template mappings.
- Does not mutate Graph, History, Solution UI, or solver behavior.
- Does not claim real-device, caret, or Photomath-level PASS without screenshots/device evidence.
