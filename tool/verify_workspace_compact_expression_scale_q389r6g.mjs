import fs from 'node:fs';
import crypto from 'node:crypto';

const read = (path) => fs.readFileSync(path, 'utf8');
const fail = (message) => {
  console.error(`Q389R6G FAIL: ${message}`);
  process.exit(1);
};
const expect = (condition, message) => {
  if (!condition) fail(message);
};
const sha = (path) => crypto.createHash('sha256').update(fs.readFileSync(path)).digest('hex');

const htmlPath = 'assets/mathlive/main_editor_prod.html';
const bridgePath = 'assets/mathlive/mathlive_prod_bridge.js';
const keyboardPath = 'lib/features/keyboard/math_keyboard.dart';
const graphSurface3dPath = 'lib/features/graph/graph_surface_3d.dart';
const appShellPath = 'lib/app/app_shell.dart';
const policyPath = 'lib/features/workspace/workspace_expression_compact_scale_policy_q389r6g.dart';
const testPath = 'test/q389r6g_workspace_compact_expression_scale_contract_test.dart';
const notesPath = 'Q389R6G_WORKSPACE_COMPACT_EXPRESSION_SCALE_DELIVERY_NOTES.md';

const html = read(htmlPath);
const bridge = read(bridgePath);
const keyboard = read(keyboardPath);
const graph3d = read(graphSurface3dPath);
const appShell = read(appShellPath);
const policy = read(policyPath);
const test = read(testPath);
const notes = read(notesPath);

expect(html.includes('data-mathpro-workspace-compact-expression-scale="Q389R6G"'), 'Production HTML must carry the Q389R6G compact-scale marker.');
expect(html.includes('font-size: clamp(23px, 6.35vw, 31px);'), 'Production MathLive field must use the compact Q389R6G font clamp.');
expect(!html.includes('font-size: clamp(28px, 7.8vw, 38px);'), 'Old oversized Q389R6F baseline font clamp must not remain active.');
expect(html.includes('min-height: 84px;'), 'Host min-height must be compacted to 84px.');
expect(html.includes('padding: 7px 10px;'), 'Host padding must be compacted to 7px 10px.');
expect(html.includes('min-height: 62px;'), 'Math field min-height must be compacted to 62px.');
expect(html.includes('line-height: 1.20;'), 'Math field line-height must be compacted to 1.20.');
expect(html.includes('padding: 5px 3px;'), 'Math field padding must be compacted to 5px 3px.');
expect(html.includes('min-height: 54px;'), 'MathLive editable/root/container min-height must be compacted to 54px.');
expect(html.includes('native MathLive caret remains authoritative'), 'CSS comment must document that MathLive native caret remains authoritative.');

expect(bridge.includes('pointerdown') && bridge.includes('selection-change'), 'MathLive bridge pointer/selection behavior must remain present.');
expect(bridge.includes('keepNativeCaretInView'), 'MathLive native caret visibility helper must remain present.');
expect(!bridge.includes('Q389R6G'), 'Q389R6G must not mutate the production bridge.');
expect(!keyboard.includes('Q389R6G'), 'Q389R6G must not mutate keyboard layout file.');
expect(graph3d.includes('Q389R6C') || graph3d.includes('360') || graph3d.includes('rotation'), 'Existing Q389R6C 3D graph work must still be present.');
expect(appShell.includes('Q389R6E') || appShell.includes('GraphExpressionRefreshPolicy'), 'Existing Q389R6E graph refresh work must still be present.');

expect(policy.includes('compactFontClamp = \'clamp(23px, 6.35vw, 31px)\''), 'Dart policy must freeze compact font clamp.');
expect(policy.includes('mathLiveBridgeChanged = false'), 'Dart policy must freeze bridge as unchanged.');
expect(policy.includes('keyboardLayoutChanged = false'), 'Dart policy must freeze keyboard as unchanged.');
expect(policy.includes('cursorDragChanged = false'), 'Dart policy must freeze cursor drag as unchanged in Q389R6G.');
expect(policy.includes('longExpressionScrollChanged = false'), 'Dart policy must freeze long-expression scroll as unchanged in Q389R6G.');
expect(policy.includes('legacyFlutterCursorAllowed = false'), 'Legacy Flutter cursor must remain forbidden.');
expect(test.includes('Q389R6G workspace compact expression scale contract'), 'Q389R6G Flutter contract test must exist.');
expect(notes.includes('Q389R6G — WORKSPACE COMPACT EXPRESSION SCALE'), 'Delivery notes must exist.');
expect(notes.includes('Q389R6H'), 'Delivery notes must defer long-expression scroll to Q389R6H.');

console.log(`Q389R6G PASS: compact workspace expression scale is applied surgically. html_sha256=${sha(htmlPath)}`);
