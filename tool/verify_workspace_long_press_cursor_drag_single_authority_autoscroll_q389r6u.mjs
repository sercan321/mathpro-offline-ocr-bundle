import fs from 'node:fs';

const read = (path) => fs.readFileSync(path, 'utf8');
const mustContain = (path, needle) => {
  const text = read(path);
  if (!text.includes(needle)) throw new Error(`Missing marker in ${path}: ${needle}`);
};
const mustNotContain = (path, needle) => {
  const text = read(path);
  if (text.includes(needle)) throw new Error(`Forbidden marker in ${path}: ${needle}`);
};

const dart = 'lib/features/mathlive/mathlive_production_editor_surface.dart';
const bridge = 'assets/mathlive/mathlive_prod_bridge.js';
const html = 'assets/mathlive/main_editor_prod.html';
const policy = 'lib/features/workspace/workspace_long_press_cursor_drag_external_single_authority_policy_q389r6u.dart';
const rPolicy = 'lib/features/workspace/workspace_long_press_cursor_drag_real_device_fallback_policy_q389r6r.dart';
const notes = 'Q389R6U_WORKSPACE_LONG_PRESS_CURSOR_DRAG_SINGLE_AUTHORITY_AUTOSCROLL_DELIVERY_NOTES.md';

mustContain(dart, "static const String _q389r6uExternalCursorDragRepairPhase = 'Q389R6U';");
mustContain(dart, 'static const Duration _q389r6uExternalDragMoveCoalesceDelay = Duration(milliseconds: 16);');
mustContain(dart, 'void _q389r6uScheduleExternalCursorDragMove(Offset localPosition)');
mustContain(dart, "reason: 'q389r6u-flutter-drag-move-coalesced'");
mustContain(dart, "'surfaceWidth': surfaceSize.width");
mustContain(dart, "'surfaceHeight': surfaceSize.height");
mustContain(dart, 'flutter-listener-parent-of-production-webview-q389r6u-coalesced-single-authority');
mustContain(dart, 'onPointerDown: _q389r6sHandlePointerDown');
mustContain(dart, 'onPointerMove: _q389r6sHandlePointerMove');

mustContain(bridge, "const EXTERNAL_CURSOR_DRAG_SINGLE_AUTHORITY_PHASE = 'Q389R6U';");
mustContain(bridge, 'q389r6uExternalCursorDragSingleAuthorityEnabled: true');
mustContain(bridge, 'q389r6uInternalJsLongPressSuppressed: false');
mustContain(bridge, 'function q389r6uResolveClientPointFromFlutterPayload');
mustContain(bridge, 'function q389r6uStartExternalEdgeAutoscrollLoop');
mustContain(bridge, 'function q389r6uScheduleExternalCursorDragMove');
mustContain(bridge, 'state.q389r6uExternalContinuousEdgeAutoscrollTickCount += 1;');
mustContain(bridge, "q389r6iSetCaretFromPoint(mf, x, y, 'q389r6u-external-continuous-edge-autoscroll')");
mustContain(bridge, 'if (state.q389r6uExternalCursorDragSingleAuthorityEnabled)');
mustContain(bridge, 'state.q389r6uInternalJsLongPressSuppressed = true;');
mustContain(bridge, "document.body.setAttribute('data-mathpro-flutter-external-cursor-dragging-q389r6u', EXTERNAL_CURSOR_DRAG_SINGLE_AUTHORITY_PHASE)");
mustContain(bridge, "q389r6uApplyExternalCursorDragPoint(mf, point, 'q389r6u-flutter-external-drag-start')");

// Q389R6V successor repair intentionally avoids drag-end re-hit-testing so a
// very-long edge-walked caret is not overwritten by a stale edge coordinate.
const bridgeText = read(bridge);
if (!bridgeText.includes("q389r6uApplyExternalCursorDragPoint(mf, point, 'q389r6u-flutter-external-drag-end')")
  && !bridgeText.includes("q389r6v-flutter-external-drag-end-no-rehit-test")) {
  throw new Error('Missing Q389R6U drag-end handling or Q389R6V successor no-rehit-test handling.');
}
mustContain(bridge, 'q389r6uExternalMoveCoalescedCount += 1;');
mustContain(bridge, 'mf.getOffsetFromPoint(clientX, clientY)');
mustContain(bridge, "if (typeof mf.setPosition === 'function') mf.setPosition(offset);");

mustContain(html, 'data-mathpro-external-cursor-drag-single-authority="Q389R6U"');
mustContain(policy, "static const String phase = 'Q389R6U';");
mustContain(policy, 'flutterParentListenerIsSingleAuthority = true');
mustContain(policy, 'jsInternalLongPressPathSuppressedInProduction = true');
mustContain(policy, 'externalContinuousEdgeAutoscrollEnabled = true');
mustContain(policy, 'documentLevelTouchMoveFallbackAllowed = false');
mustContain(rPolicy, 'static const bool documentMoveEndFallbackEnabled = false;');
mustContain(rPolicy, 'static const bool documentMoveEndFallbackSupersededByExternalBridge = true;');
mustContain(notes, 'single cursor-drag authority');
mustContain(notes, 'No keyboard layout/key-order changes.');

mustNotContain(bridge, "document.addEventListener('touchmove'");
mustNotContain(bridge, "document.addEventListener('pointermove'");
mustNotContain(bridge, 'direct-pan');
mustNotContain(bridge, 'host-scrollport-force');
mustNotContain(bridge, 'LegacyFlutterCursor');
mustNotContain(bridge, 'flutterCaretOverlayAllowed: true');

console.log('PASS q389r6u workspace long-press cursor drag single-authority autoscroll verifier');
