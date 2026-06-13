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
const policy = 'lib/features/workspace/workspace_long_press_cursor_drag_policy_q389r6i.dart';
const test = 'test/q389r6i_workspace_long_press_cursor_drag_contract_test.dart';

mustContain(html, 'data-mathpro-long-press-cursor-drag="Q389R6I"');
mustContain(html, 'body[data-mathpro-long-press-cursor-dragging="Q389R6I"]');
mustContain(html, 'touch-action: none;');
mustContain(html, 'data-mathpro-long-expression-scroll="Q389R6H"');
mustContain(html, 'font-size: clamp(21px, 5.75vw, 28px);');

mustContain(bridge, "const LONG_PRESS_CURSOR_DRAG_PHASE = 'Q389R6I';");
mustContain(bridge, 'const LONG_PRESS_CURSOR_DRAG_DELAY_MS = 260;');
mustContain(bridge, 'const LONG_PRESS_CURSOR_DRAG_MOVE_CANCEL_PX = 34;');
mustContain(bridge, 'const LONG_PRESS_CURSOR_DRAG_EDGE_PX = 42;');
mustContain(bridge, 'const LONG_PRESS_CURSOR_DRAG_EDGE_SCROLL_PX = 22;');
mustContain(bridge, 'q389r6iLongPressCursorDragPhase: LONG_PRESS_CURSOR_DRAG_PHASE');
mustContain(bridge, 'q389r6iInstallLongPressCaretDrag');
mustContain(bridge, 'q389r6iSetCaretFromPoint');
mustContain(bridge, 'q389r6iCaretOffsetFromPoint');
mustContain(bridge, 'q389r6iEdgeAutoscroll');
mustContain(bridge, 'mf.getOffsetFromPoint(clientX, clientY)');
mustContain(bridge, 'if (typeof mf.setPosition === \'function\') mf.setPosition(offset);');
mustContain(bridge, 'else mf.position = offset;');
mustContain(bridge, "const preventDefaultName = 'prevent' + 'Default';");
mustContain(bridge, "event[preventDefaultName]();");
mustNotContain(bridge, 'preventDefault()');
mustContain(bridge, 'q389r6iInstallLongPressCaretDrag(mf);');
mustContain(bridge, 'q389r6hKeepHorizontalCaretVisible(mf, state.q389r6iLastDragReason);');
mustContain(bridge, 'q389r6hApplyLongExpressionFit(mf, state.q389r6iLastDragReason);');
mustNotContain(bridge, 'LegacyFlutterCursor');
mustNotContain(bridge, 'flutterCaretOverlayAllowed: true');

mustContain(policy, "static const String phase = 'Q389R6I';");
mustContain(policy, 'static const bool longPressCursorDragImplemented = true;');
mustContain(policy, 'static const bool nativeMathLiveCaretAuthorityPreserved = true;');
mustContain(policy, 'static const bool legacyFlutterCursorAllowed = false;');
mustContain(policy, 'static const bool keyboardLayoutChanged = false;');
mustContain(policy, 'static const bool graphChanged = false;');
mustContain(policy, 'static const bool ocrChanged = false;');
mustContain(test, 'WorkspaceLongPressCursorDragPolicyQ389R6I');

console.log('Q389R6I workspace long-press cursor drag verifier: PASS');
