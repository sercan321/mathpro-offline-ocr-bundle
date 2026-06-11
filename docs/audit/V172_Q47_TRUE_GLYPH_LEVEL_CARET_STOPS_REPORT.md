# V172-Q47 True Glyph-Level Caret Stops Report

Outcome: CONDITIONAL PASS (static/source).

Scope: renderer-assisted glyph-level caret stops for filled numeric/function arguments.

Hard boundary: this phase does not claim stable AST-character -> SVG-node identity. It uses MathJax/SVG element rect telemetry when available and falls back to Q40 digit-run midpoint selection when renderer glyph candidates are unavailable.

P6-locked surfaces remain protected: keyboard, premium key, math label, MORE/template tray, long-press popup, app shell, Graph, History, and Solution.

Target scenarios for physical-device QA:
- 123456789
- cos(99666655)
- sin(300)
- ln(123456)

Acceptance target: 20 attempts per scenario, 19 correct minimum, with screenshots/video required before any +95 claim.
