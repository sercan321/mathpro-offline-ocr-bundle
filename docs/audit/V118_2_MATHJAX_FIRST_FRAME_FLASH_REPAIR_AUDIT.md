# V118.2 MathJax First-Frame Flash Repair Audit

## Scope
This release keeps the V118 local MathJax/WebView render surface and repairs the real-device issue where the editor briefly painted the old/static math surface before MathJax finished rendering.

## Product constraint
Only the visible editor math render path was changed. Keyboard layout, tab order, MORE, Ans, ↵, =, long-press mappings, Graph, History, and Solution panel contracts remain out of scope and unchanged.

## Repair summary
- Runtime WebView no longer shows `_StaticMathJaxFallback` while the controller is bootstrapping.
- First frame now shows only a neutral premium ghost surface until MathJax has finished typesetting.
- WebView is kept at opacity 0 until MathJax posts a rendered signal through `MathProReady`.
- MathJax renders new TeX in a hidden staging node first, then swaps the fully rendered SVG into the visible node.
- Raw TeX/text is not written to the visible math node during render failures.
- Existing rendered math remains visible during later updates until the newly staged SVG is ready, avoiding raw TeX/update flicker.

## Expected result
The user should no longer see the old bad expression surface first and then the corrected MathJax output. The initial editor frame should be neutral/blank-premium, then the final MathJax render should appear.

## Not claimed
Flutter analyze/test/run were not executed in this environment because Flutter/Dart SDK is unavailable here. Real-device PASS is not claimed.
