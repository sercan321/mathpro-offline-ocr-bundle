# V172-Q159 MathLive Real Device Input Visibility Repair

Q159 is a targeted real-device repair after Q157/Q158 still showed the same symptom on phone: MathPro keys visually pressed, but no visible expression appeared in the main editor.

## Scope

- Flush queued keyboard commands after the WebView page finishes loading.
- Keep fallback WebView host visible when the official MathLive `math-field` has not mounted yet.
- Add DOM-level visible fallback for command payloads if the bridge is unavailable or returns no state.
- Preserve MathLive template mapping, frozen keyboard layout, long-press order, MORE inventory, Graph/History/Solution UI, and solver behavior.

## No fake claims

This package does not claim real-device PASS, cursor PASS, or Photomath-level PASS. It repairs the runtime visibility path and requires user-side device verification.
