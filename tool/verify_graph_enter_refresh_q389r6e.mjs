import fs from 'node:fs';

const read = (path) => fs.readFileSync(path, 'utf8');
const fail = (message) => {
  console.error(`Q389R6E FAIL: ${message}`);
  process.exit(1);
};
const expect = (condition, message) => {
  if (!condition) fail(message);
};

const app = read('lib/app/app_shell.dart');
const policy = read('lib/features/graph/graph_expression_refresh_policy.dart');
const test = read('test/q389r6e_graph_enter_refresh_audit_hardening_contract_test.dart');

expect(app.includes("import '../features/graph/graph_expression_refresh_policy.dart';"), 'AppShell must import the graph expression refresh policy.');
expect(app.includes('_recordEvaluationIfNeeded();\n    _refreshOpenGraphAfterEvaluation(envelope);'), 'Evaluate flow must refresh an already-open graph after Enter/evaluate.');
expect(app.includes('void _refreshOpenGraphAfterEvaluation(MathLiveProductionGraphHistorySolutionStateEnvelope envelope)'), 'Refresh method must exist.');
expect(app.includes('if (!_graphPreviewVisible || _activeGraph == null) return;'), 'Refresh must only run for an already-visible graph preview.');
expect(app.includes('GraphEligibility.classify('), 'Refresh must re-classify the current MathLive graph expression.');
expect(app.includes('GraphEligibility.expressionFromEligibility('), 'Refresh must rebuild the GraphExpression from the new expression.');
expect(app.includes('renderMode: _graphRenderMode'), 'Refresh must preserve the current 2D/3D render mode.');
expect(app.includes('final sameGraphExpression = rebuilt.historyIdentityKey == previous.historyIdentityKey;'), 'Refresh must detect unchanged graph expression.');
expect(app.includes('xMin: previous.xMin'), 'Unchanged Enter refresh must preserve current xMin.');
expect(app.includes('yMax: previous.yMax'), 'Unchanged Enter refresh must preserve current yMax.');
expect(policy.includes('preserveViewportWhenExpressionUnchanged = true'), 'Policy must preserve viewport when expression is unchanged.');
expect(app.includes('traceEnabled: previous.traceEnabled'), 'Refresh must preserve trace setting.');
expect(app.includes('showCriticalPoints: previous.showCriticalPoints'), 'Refresh must preserve critical-point setting.');
expect(app.includes('graphColor: previous.graphColor'), 'Refresh must preserve graph color.');
expect(app.includes('void _clearOpenGraphAfterFailedRefresh(String message)'), 'Invalid expressions must clear stale graph state.');
expect(app.includes('_activeGraph = null;'), 'Invalid refresh must not leave old graph data active.');
expect(app.includes('Açık slotlar doldurulmadan grafik güncellenmedi.'), 'Open slot failure message must be explicit.');

expect(policy.includes('evaluateEnterRefreshesVisibleGraph = true'), 'Policy must enable visible-graph Enter refresh.');
expect(policy.includes('perKeystrokeGraphRefreshAllowed = false'), 'Policy must forbid hot per-keystroke graph refresh.');
expect(policy.includes('keyboardLayoutMutationAllowed = false'), 'Policy must keep keyboard as a red line.');
expect(policy.includes('mathLiveBridgeMutationAllowed = false'), 'Policy must keep MathLive bridge as a red line.');
expect(policy.includes('ocrMutationAllowed = false'), 'Policy must keep OCR as a red line.');
expect(policy.includes('workspaceLayoutMutationAllowed = false'), 'Policy must keep workspace layout as a red line.');

expect(test.includes('Q389R6E graph Enter refresh contract'), 'Contract test must exist.');
expect(test.includes('evaluateEnterRefreshesVisibleGraph'), 'Contract test must cover the refresh flag.');
expect(test.includes('perKeystrokeGraphRefreshAllowed'), 'Contract test must cover no per-keystroke refresh.');

console.log('Q389R6E PASS: visible graph Enter refresh is wired without keyboard/MathLive/OCR/workspace red-line mutations.');
