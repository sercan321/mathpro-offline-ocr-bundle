# V172-Q169R36 Shadow Observer Feedback Loop Repair Audit

Q169R36 repairs the browser-level boot risk found in Q169R35: the MathLive shadow-root chrome observer watched attribute mutations while the chrome-suppression callback wrote style and data attributes. That allowed a self-triggering MutationObserver feedback loop during MathLive boot.

## Surgical change

- Keep Q169R35 single-file runtime boot.
- Keep official MathLive runtime inline and vendor-bundled.
- Keep the static `<math-field id="mathlive-field">` host.
- Replace the shadow-root observer with a child-list-only observer.
- Debounce chrome suppression with `setTimeout`.
- Install the observer once per math-field using a `WeakSet`.
- Do not let fallback rendering claim runtime, insert, value, or paint success.

## Protected surfaces

Keyboard layout, MORE, long-press, BottomDock, AppShell, Graph, History, and Solution UI files are not changed by this phase.

## Evidence status

Package-side verifier and browser-level probe can verify boot/insert/value/paint in Chromium. Real Android device evidence is still required before claiming release-level PAINT PASS.

## Browser-level package probe summary

A Chromium DevTools Protocol package probe loaded `assets/mathlive/main_editor.html` with the Q169R36 bridge and executed a real bridge command payload `{ action: 'insertLatex', label: '5', latex: '5' }`.

Observed package-side browser result:

```json
{
  "readyState": "complete",
  "hasMathLive": true,
  "customDefined": true,
  "hasBridge": true,
  "fieldExists": true,
  "mountResult": true,
  "value": "5",
  "rect": { "width": 756, "height": 72 },
  "lastInsertSucceeded": true,
  "lastInsertCommitted": true,
  "lastValueNonEmpty": true,
  "lastJsCommandStatus": "ok",
  "nativePaintState": "ok",
  "nativePaintOwner": "mathlive-native-field",
  "nativePaintProofValuePath": "native-getValue-latex-expanded",
  "nativeMathfieldValue": "5",
  "q169FailureReason": "none",
  "lastPaintRectState": "rect-756x72"
}
```

This is package/browser evidence only. It is not an Android real-device PASS claim.
