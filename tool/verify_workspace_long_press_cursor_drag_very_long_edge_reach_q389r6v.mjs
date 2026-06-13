import fs from 'node:fs';

const js = fs.readFileSync('assets/mathlive/mathlive_prod_bridge.js', 'utf8');
const html = fs.readFileSync('assets/mathlive/main_editor_prod.html', 'utf8');
const policy = fs.readFileSync('lib/features/workspace/workspace_long_press_cursor_drag_external_edge_reach_policy_q389r6v.dart', 'utf8');

const requiredJs = [
  "const EXTERNAL_CURSOR_DRAG_EDGE_REACH_PHASE = 'Q389R6V'",
  'LONG_PRESS_CURSOR_DRAG_EDGE_MIN_OFFSET_STEP',
  'LONG_PRESS_CURSOR_DRAG_EDGE_MAX_OFFSET_STEP',
  'q389r6vDirectionalEdgeOffsetWalkActive: true',
  'q389r6vExternalDragEndDoesNotReHitTest: true',
  'function q389r6vEdgeDirection(mf, clientX)',
  'function q389r6vDirectionalEdgeOffsetStep(mf)',
  'function q389r6vDirectionalEdgeOffsetTarget(mf, baseOffset, clientX, reason)',
  "tag.indexOf('q389r6u-external-continuous-edge-autoscroll') >= 0",
  "tag.indexOf('q389r6u-flutter-external-drag-move') >= 0",
  'Math.round(current + direction * step)',
  'state.q389r6vDirectionalEdgeOffsetWalkCount += 1',
  "q389r6vFlushExternalPendingMoveBeforeEnd(mf)",
  "q389r6v-flutter-external-drag-end-no-rehit-test",
  "q389r6v-flutter-external-drag-end-keep-current-caret-visible",
];

const forbiddenJs = [
  "document.addEventListener('touchmove'",
  "document.addEventListener('pointermove'",
  "document.addEventListener('mousemove'",
  'host-scrollport-force',
  'direct-pan'
];

for (const marker of requiredJs) {
  if (!js.includes(marker)) {
    throw new Error(`Missing required Q389R6V marker in mathlive_prod_bridge.js: ${marker}`);
  }
}
for (const marker of forbiddenJs) {
  if (js.includes(marker)) {
    throw new Error(`Forbidden Q389R6V regression marker found in mathlive_prod_bridge.js: ${marker}`);
  }
}

if (!html.includes('data-mathpro-external-cursor-drag-edge-reach="Q389R6V"')) {
  throw new Error('Missing Q389R6V HTML phase marker.');
}

for (const marker of [
  "static const String phase = 'Q389R6V'",
  'edgeAutoscrollUsesDirectionalCaretOffsetWalk = true',
  'veryLongExpressionCanReachAbsoluteStartAndEnd = true',
  'dragEndDoesNotReHitTestAndJump = true',
]) {
  if (!policy.includes(marker)) {
    throw new Error(`Missing Q389R6V policy marker: ${marker}`);
  }
}

console.log('Q389R6V workspace long-press cursor drag very-long edge reach verifier: PASS');
