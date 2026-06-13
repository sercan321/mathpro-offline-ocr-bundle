import fs from 'node:fs';

const read = (path) => fs.readFileSync(path, 'utf8');
const fail = (message) => {
  console.error(`Q389R6F FAIL: ${message}`);
  process.exit(1);
};
const expect = (condition, message) => {
  if (!condition) fail(message);
};

const policyPath = 'lib/features/workspace/workspace_expression_compact_scale_audit_q389r6f.dart';
const testPath = 'test/q389r6f_workspace_expression_scale_preflight_audit_contract_test.dart';
const reportPath = 'Q389R6F_WORKSPACE_EXPRESSION_SCALE_PREFLIGHT_AUDIT.md';
const htmlPath = 'assets/mathlive/main_editor_prod.html';
const bridgePath = 'assets/mathlive/mathlive_prod_bridge.js';
const workspacePath = 'lib/features/workspace/workspace_panel.dart';

const policy = read(policyPath);
const test = read(testPath);
const report = read(reportPath);
const html = read(htmlPath);
const bridge = read(bridgePath);
const workspace = read(workspacePath);

expect(policy.includes('runtimeBehaviorChanged = false'), 'Q389R6F must be a non-mutating audit phase.');
expect(policy.includes('visualScaleChanged = false'), 'Q389R6F must not change expression scale yet.');
expect(policy.includes('cursorDragChanged = false'), 'Q389R6F must not change cursor drag yet.');
expect(policy.includes('longExpressionScrollChanged = false'), 'Q389R6F must not change long-expression scroll yet.');
expect(policy.includes("productionHtmlPath = 'assets/mathlive/main_editor_prod.html'"), 'Policy must identify production HTML scale surface.');
expect(policy.includes("productionBridgePath = 'assets/mathlive/mathlive_prod_bridge.js'"), 'Policy must identify the bridge as a red-line surface.');
expect(policy.includes('keyboardLayoutMutationAllowed = false'), 'Keyboard must remain a red line.');
expect(policy.includes('mathLiveBridgeMutationAllowedInQ389R6G = false'), 'Q389R6G must not mutate the MathLive bridge.');
expect(policy.includes('legacyFlutterCursorAllowed = false'), 'Legacy Flutter cursor must remain forbidden.');

expect(test.includes('Q389R6F workspace expression scale preflight audit contract'), 'Contract test must exist.');
expect(test.includes('runtimeBehaviorChanged'), 'Contract test must cover no behavior change.');
expect(test.includes('legacyFlutterCursorAllowed'), 'Contract test must cover legacy cursor prohibition.');

expect(report.includes('Q389R6F — WORKSPACE EXPRESSION SCALE PREFLIGHT AUDIT'), 'Audit report must exist.');
expect(report.includes('Dokunulmayacak kırmızı çizgiler'), 'Audit report must list red lines.');
expect(report.includes('Q389R6G'), 'Audit report must define next scale phase.');
expect(report.includes('Q389R6H'), 'Audit report must define long expression scroll phase.');
expect(report.includes('Q389R6I'), 'Audit report must define long-press cursor drag phase.');

const q389r6gCompactScaleApplied = html.includes('data-mathpro-workspace-compact-expression-scale="Q389R6G"');
if (!q389r6gCompactScaleApplied) {
  expect(html.includes('font-size: clamp(28px, 7.8vw, 38px);'), 'Audit baseline must still show current oversized MathLive font clamp before Q389R6G edits it.');
  expect(html.includes('padding: 9px 11px;'), 'Audit baseline must still show current host padding before Q389R6G edits it.');
} else {
  expect(html.includes('font-size: clamp(23px, 6.35vw, 31px);'), 'After Q389R6G, preflight verifier must recognize the approved compact font clamp.');
  expect(html.includes('padding: 7px 10px;'), 'After Q389R6G, preflight verifier must recognize the approved compact host padding.');
}
expect(bridge.includes('pointerdown') && bridge.includes('selection-change'), 'Bridge must still own native pointer/selection events.');
expect(bridge.includes('keepNativeCaretInView'), 'Native caret visibility helper must remain present.');
expect(workspace.includes('class _PremiumQuestionAnswerCard'), 'Workspace premium card must remain present.');
expect(workspace.includes('_Q382R30ExpressionFrameSection'), 'Hot expression frame section must remain present.');

console.log('Q389R6F PASS: workspace expression scale/cursor/scroll preflight audit is packaged without runtime behavior mutations.');
