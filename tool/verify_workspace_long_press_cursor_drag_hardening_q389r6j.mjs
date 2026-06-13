import fs from 'node:fs';

const read = (path) => fs.readFileSync(path, 'utf8');
const mustContain = (path, needle) => {
  const text = read(path);
  if (!text.includes(needle)) {
    throw new Error(`Missing required marker in ${path}: ${needle}`);
  }
};
const mustNotContain = (path, needle) => {
  const text = read(path);
  if (text.includes(needle)) {
    throw new Error(`Forbidden marker in ${path}: ${needle}`);
  }
};

const html = 'assets/mathlive/main_editor_prod.html';
const bridge = 'assets/mathlive/mathlive_prod_bridge.js';
const policy = 'lib/features/workspace/workspace_long_press_cursor_drag_hardening_policy_q389r6j.dart';
const test = 'test/q389r6j_workspace_long_press_cursor_drag_hardening_contract_test.dart';

// Q389R6I must remain intact.
mustContain(html, 'data-mathpro-long-press-cursor-drag="Q389R6I"');
mustContain(bridge, "const LONG_PRESS_CURSOR_DRAG_PHASE = 'Q389R6I';");
mustContain(bridge, 'q389r6iInstallLongPressCaretDrag');
mustContain(bridge, 'mf.getOffsetFromPoint(clientX, clientY)');
mustContain(bridge, "if (typeof mf.setPosition === 'function') mf.setPosition(offset);");

// Q389R6J audit hardening markers.
mustContain(html, 'data-mathpro-long-press-cursor-drag-hardening="Q389R6J"');
mustContain(html, '-webkit-touch-callout: none;');
mustContain(bridge, "const LONG_PRESS_CURSOR_DRAG_HARDENING_PHASE = 'Q389R6J';");
mustContain(bridge, 'const LONG_PRESS_CURSOR_DRAG_EDGE_TICK_MS = 72;');
mustContain(bridge, 'q389r6jLongPressCursorDragHardeningPhase: LONG_PRESS_CURSOR_DRAG_HARDENING_PHASE');
mustContain(bridge, 'q389r6jContinuousEdgeAutoscrollActive: true');
mustContain(bridge, 'q389r6jContinuousEdgeAutoscrollTickCount');
mustContain(bridge, 'q389r6jPointerCaptureCleanupHardened: true');
mustContain(bridge, 'function q389r6jPointerIsInsideEdgeZone');
mustContain(bridge, 'function clearEdgeAutoscrollLoop()');
mustContain(bridge, 'function startEdgeAutoscrollLoop()');
mustContain(bridge, 'window.setInterval(function ()');
mustContain(bridge, "q389r6iSetCaretFromPoint(mf, lastX, lastY, 'q389r6j-continuous-edge-autoscroll')");
mustContain(bridge, 'clearEdgeAutoscrollLoop();');
mustContain(bridge, 'mf.releasePointerCapture(pointerId)');
mustContain(bridge, 'function onLostPointerCapture()');
mustContain(bridge, "finish('q389r6j-lost-pointer-capture-cleanup')");
mustContain(bridge, "mf.addEventListener('lostpointercapture', onLostPointerCapture");

// Protected red lines.
mustNotContain(bridge, 'LegacyFlutterCursor');
mustNotContain(bridge, 'flutterCaretOverlayAllowed: true');
mustContain(policy, "static const String phase = 'Q389R6J';");
mustContain(policy, 'static const bool continuousEdgeAutoscrollLoopImplemented = true;');
mustContain(policy, 'static const bool edgeAutoscrollNoLongerRequiresPointerMove = true;');
mustContain(policy, 'static const bool pointerCaptureCleanupHardened = true;');
mustContain(policy, 'static const bool keyboardLayoutChanged = false;');
mustContain(policy, 'static const bool graphChanged = false;');
mustContain(policy, 'static const bool ocrChanged = false;');
mustContain(policy, 'static const bool androidNativeChanged = false;');
mustContain(test, 'WorkspaceLongPressCursorDragHardeningPolicyQ389R6J');

console.log('Q389R6J workspace long-press cursor drag audit hardening verifier: PASS');
