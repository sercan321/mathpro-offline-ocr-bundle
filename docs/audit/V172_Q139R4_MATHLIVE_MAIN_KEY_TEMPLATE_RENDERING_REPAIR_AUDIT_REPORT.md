# V172-Q139R4 — MathLive Main Key Template Rendering Repair

Real-device evidence showed that the MathLive main editor mounted, but MathPro keyboard keys such as calculus/root/fraction templates rendered as raw captions (`∫`, `dx`, `√x`) instead of MathLive structures.

Q139R4 keeps the legacy Q85 lab mapping intact for historical tests and isolated lab compatibility, while adding a main-editor-only mapping layer that converts device-visible MathPro key faces (`a/b`, `√x`, `x^y`, `∫dx`, etc.) into MathLive LaTeX templates using `\placeholder{}`.

It also forces `mathfield.insert(..., { format: 'latex' })` when the runtime supports that option.

Protected keyboard layout, MORE, long-press source, Graph UI, History UI, and Solution UI were not modified. No cursor/release PASS is claimed.
