# V172-Q45 Real Device Pixel QA Court

## Scope
Q45 does not claim a real-device PASS. It defines the physical-device acceptance court for the P6-locked cursor engine after Q44 renderer-sync upgrade.

## Locked red lines
The following P6 visual/UI files must remain byte-identical: keyboard config, keyboard widget, bottom dock, long-press popup, premium key, math label, template tray, app shell, solution panel, graph card, history controller, and history panel.

## Acceptance threshold
- 20 attempts per scenario.
- 19 correct attempts minimum per scenario.
- Overall success rate minimum: 0.95.
- Required device: 23106RN0DA.

## Court cases
1. √□ placeholder-safe radicand.
2. x^□ / x^12 exponent compact cursor.
3. x_□ / x_89 subscript compact cursor.
4. 9/6, 12/345, 123/4567 fraction lanes.
5. log₂(500), log_□(□) log base/argument lanes.
6. ³√27, ⁿ√x, √123 root index/radicand lanes.
7. 123456789, cos(99666655), sin(300), ln(123456) digit caret stops.
8. ln(ln(8)), sin(cos(300)), √(sin(x)+log₂(500)) nested depth.
9. sin(300)+cos(400)+log₂(500)+√(600) drag stability.
10. Structural insert/delete cases such as sin(3|00), log₂(5|00), x^(1|2), and 12/3|45.

## Honesty lock
- finalPlus95CursorPassClaimed remains false.
- photomathWolframLevelClaimed remains false.
- Renderer per-slot SVG identity is not claimed in Q45.
