# V172-Q165 MathLive AppShell Visible Fallback / Diagnostic Tap Bus

Q165 responds to real-device evidence that Q164R1 could remain visually stuck at `Q163 bekleniyor` even after MathPro keyboard taps. It adds an AppShell-level diagnostic tap bus and sanitized Flutter fallback overlay for the MathLive main editor when Android WebView/MathLive remains visually blank.

No keyboard layout, key order, MORE inventory, long-press order, Graph UI, History UI, Solution UI, or solver behavior was intentionally changed.

The fallback never exposes raw MathLive insert-control tokens `#0`, `#?`, or `#@`.
