# Q389R6T — Workspace Long-Press Cursor Drag External Bridge Hardening

Q389R6T starts from Q389R6S and keeps the deterministic Flutter parent-pointer
stream to MathLive production bridge as the active drag architecture.

## Runtime decision

The Q389R6R document-level `touchmove` fallback conflicted with the Q382
keyboard latency courts that explicitly forbid reintroducing document-level
pan/drag listeners. Q389R6T removes those document-level move/end listeners and
keeps:

- Flutter `Listener` around the production WebView.
- Opaque parent hit testing so the parent pointer stream is observed.
- JS bridge methods: `externalCursorDragStart`, `externalCursorDragMove`,
  `externalCursorDragEnd`.
- MathLive native caret APIs as the only caret authority.

## Red lines

No keyboard layout, keyboard dispatch queue, graph runtime, OCR runtime, Android
native/Kotlin, solver/CAS, or legacy Flutter cursor overlay change is introduced.
