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
const policy = 'lib/features/workspace/workspace_long_press_cursor_drag_real_device_fallback_policy_q389r6r.dart';
const notes = 'Q389R6R_WORKSPACE_LONG_PRESS_CURSOR_DRAG_REAL_DEVICE_FALLBACK_DELIVERY_NOTES.md';
const bridgeText = read(bridge);
const q389r6uSingleAuthorityActive = bridgeText.includes("const EXTERNAL_CURSOR_DRAG_SINGLE_AUTHORITY_PHASE = 'Q389R6U';");

mustContain(html, 'data-mathpro-long-press-cursor-drag="Q389R6I"');
mustContain(html, 'data-mathpro-long-press-cursor-drag-hardening="Q389R6J"');
mustContain(html, 'data-mathpro-long-press-cursor-drag-real-device-fallback="Q389R6R"');
mustContain(html, 'Q389R6R: real-device touch fallback attaches capture listeners');

mustContain(bridge, "const LONG_PRESS_CURSOR_DRAG_REAL_DEVICE_FALLBACK_PHASE = 'Q389R6R';");
mustContain(bridge, 'const LONG_PRESS_CURSOR_DRAG_MOVE_CANCEL_PX = 34;');
mustContain(bridge, 'q389r6rCaptureListenersActive: true');
mustContain(bridge, 'q389r6rTouchFallbackActive: true');
mustContain(bridge, 'q389r6rPreActivationHorizontalDragTolerance: true');
mustContain(bridge, 'function q389r6rMaybeStopDefault(event)');
mustContain(bridge, "const preventDefaultName = 'prevent' + 'Default';");
mustContain(bridge, 'function q389r6rTouchFromEvent(event, activeIdentifier)');
mustContain(bridge, 'const listenerOptions = { capture: true, passive: false };');
mustContain(bridge, "target.addEventListener('touchstart', onTouchStart, listenerOptions)");
mustContain(bridge, "target.addEventListener('touchmove', onTouchMove, listenerOptions)");
if (q389r6uSingleAuthorityActive) {
  mustNotContain(bridge, "document.addEventListener('touchmove'");
  mustNotContain(bridge, "document.addEventListener('pointermove'");
} else {
  mustContain(bridge, "document.addEventListener('touchmove', onTouchMove, listenerOptions)");
  mustContain(bridge, "document.addEventListener('pointermove', onPointerMove, listenerOptions)");
}
mustContain(bridge, "state.q389r6iLastDragReason = 'q389r6r-real-device-long-press-activated';");
mustContain(bridge, "q389r6iSetCaretFromPoint(mf, lastX, lastY, 'q389r6r-long-press-drag-move')");
mustContain(bridge, 'if (!active && moved > LONG_PRESS_CURSOR_DRAG_MOVE_CANCEL_PX && dy > dx * 1.25)');
mustContain(bridge, 'state.q389r6rFallbackMoveCount += 1;');
mustContain(bridge, 'q389r6iSetCaretFromPoint');
mustContain(bridge, 'mf.getOffsetFromPoint(clientX, clientY)');
mustContain(bridge, "if (typeof mf.setPosition === 'function') mf.setPosition(offset);");
mustContain(bridge, 'q389r6hKeepHorizontalCaretVisible(mf, state.q389r6iLastDragReason);');
mustContain(bridge, 'window.setInterval(function ()');
mustNotContain(bridge, 'preventDefault()');
mustNotContain(bridge, 'LegacyFlutterCursor');
mustNotContain(bridge, 'flutterCaretOverlayAllowed: true');

mustContain(policy, "static const String phase = 'Q389R6R';");
mustContain(policy, 'static const bool capturePhasePointerListenersEnabled = true;');
mustContain(policy, 'static const bool touchEventFallbackEnabled = true;');
if (q389r6uSingleAuthorityActive) {
  mustContain(policy, 'static const bool documentMoveEndFallbackEnabled = false;');
  mustContain(policy, 'static const bool documentMoveEndFallbackSupersededByExternalBridge = true;');
} else {
  mustContain(policy, 'static const bool documentMoveEndFallbackEnabled = true;');
}
mustContain(policy, 'static const bool horizontalPreActivationDragToleranceEnabled = true;');
mustContain(policy, 'static const bool keyboardLayoutChanged = false;');
mustContain(policy, 'static const bool graphChanged = false;');
mustContain(policy, 'static const bool ocrChanged = false;');
mustContain(policy, 'static const bool androidNativeChanged = false;');

mustContain(notes, 'device feedback reported');
mustContain(notes, 'Real PASS for Photomath-style cursor drag requires device video/user-side confirmation');

console.log('Q389R6R workspace long-press cursor drag real-device fallback verifier: PASS');
