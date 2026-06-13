#!/usr/bin/env node
import fs from 'node:fs';

const dart = fs.readFileSync('lib/features/mathlive/mathlive_production_editor_surface.dart', 'utf8');
const js = fs.readFileSync('assets/mathlive/mathlive_prod_bridge.js', 'utf8');
const html = fs.readFileSync('assets/mathlive/main_editor_prod.html', 'utf8');
const policy = fs.readFileSync('lib/features/workspace/workspace_long_press_cursor_drag_external_bridge_policy_q389r6s.dart', 'utf8');

const requiredDart = [
  "static const String _q389r6sFlutterExternalCursorDragPhase = 'Q389R6S';",
  'Listener(',
  'onPointerDown: _q389r6sHandlePointerDown',
  'onPointerMove: _q389r6sHandlePointerMove',
  'onPointerUp: _q389r6sHandlePointerUp',
  'onPointerCancel: _q389r6sHandlePointerCancel',
  'externalCursorDragStart',
  'externalCursorDragMove',
  'externalCursorDragEnd',
  'flutter-listener-parent-of-production-webview',
];
const requiredJs = [
  "const FLUTTER_EXTERNAL_CURSOR_DRAG_BRIDGE_PHASE = 'Q389R6S';",
  'q389r6sExternalCursorDragStart',
  'q389r6sExternalCursorDragMove',
  'q389r6sExternalCursorDragEnd',
  'externalCursorDragStart: q389r6sExternalCursorDragStart',
  'externalCursorDragMove: q389r6sExternalCursorDragMove',
  'externalCursorDragEnd: q389r6sExternalCursorDragEnd',
  'q389r6sFlutterExternalCursorDragBridgeActive: true',
];
const requiredHtml = [
  'data-mathpro-flutter-external-cursor-drag-bridge="Q389R6S"',
  'body[data-mathpro-flutter-external-cursor-dragging="Q389R6S"]',
];
const requiredPolicy = [
  "static const String phase = 'Q389R6S';",
  'flutterParentPointerStreamObserved = true',
  'forwardsCoordinatesToMathLiveProductionBridge = true',
  'nativeMathLiveCaretRemainsAuthoritative = true',
  'legacyFlutterCursorOverlayRevived = false',
];

for (const needle of requiredDart) {
  if (!dart.includes(needle)) throw new Error(`Q389R6S Dart marker missing: ${needle}`);
}
for (const needle of requiredJs) {
  if (!js.includes(needle)) throw new Error(`Q389R6S JS marker missing: ${needle}`);
}
for (const needle of requiredHtml) {
  if (!html.includes(needle)) throw new Error(`Q389R6S HTML marker missing: ${needle}`);
}
for (const needle of requiredPolicy) {
  if (!policy.includes(needle)) throw new Error(`Q389R6S policy marker missing: ${needle}`);
}

console.log('PASS q389r6s workspace long-press cursor drag external bridge verifier');
