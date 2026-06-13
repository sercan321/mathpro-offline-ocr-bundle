#!/usr/bin/env node
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
const policy = 'lib/features/workspace/workspace_long_press_cursor_drag_external_bridge_hardening_policy_q389r6t.dart';
const notes = 'Q389R6T_WORKSPACE_LONG_PRESS_CURSOR_DRAG_EXTERNAL_BRIDGE_HARDENING_DELIVERY_NOTES.md';

mustContain(dart, 'behavior: HitTestBehavior.opaque,');
mustContain(dart, 'onPointerDown: _q389r6sHandlePointerDown');
mustContain(dart, 'externalCursorDragStart');
mustContain(dart, 'externalCursorDragMove');
mustContain(dart, 'externalCursorDragEnd');
mustContain(dart, 'flutter-listener-parent-of-production-webview');

mustContain(bridge, 'q389r6sExternalCursorDragStart');
mustContain(bridge, 'q389r6sExternalCursorDragMove');
mustContain(bridge, 'q389r6sExternalCursorDragEnd');
mustContain(bridge, 'externalCursorDragStart: q389r6sExternalCursorDragStart');
mustContain(bridge, 'externalCursorDragMove: q389r6sExternalCursorDragMove');
mustContain(bridge, 'externalCursorDragEnd: q389r6sExternalCursorDragEnd');
mustContain(bridge, 'q389r6iSetCaretFromPoint');
mustContain(bridge, 'mf.getOffsetFromPoint(clientX, clientY)');
mustContain(bridge, "if (typeof mf.setPosition === 'function') mf.setPosition(offset);");

mustNotContain(bridge, "document.addEventListener('touchmove'");
mustNotContain(bridge, 'direct-pan');
mustNotContain(bridge, 'host-scrollport-force');
mustNotContain(bridge, 'preventDefault()');
mustNotContain(bridge, 'LegacyFlutterCursor');

mustContain(policy, "static const String phase = 'Q389R6T';");
mustContain(policy, 'flutterExternalCursorDragBridgeIsPrimary = true');
mustContain(policy, 'parentListenerUsesOpaqueHitTesting = true');
mustContain(policy, 'documentLevelTouchMoveFallbackRemoved = true');
mustContain(policy, 'keyboardLayoutChanged = false');
mustContain(policy, 'keyboardDispatchQueueChanged = false');
mustContain(policy, 'legacyFlutterCursorOverlayRevived = false');

mustContain(notes, 'Q389R6T');
mustContain(notes, 'document-level `touchmove` fallback');

console.log('PASS q389r6t workspace long-press cursor drag external bridge hardening verifier');
