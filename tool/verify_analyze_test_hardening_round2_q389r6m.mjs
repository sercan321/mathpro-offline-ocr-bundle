#!/usr/bin/env node
import fs from 'node:fs';

function read(path) { return fs.readFileSync(path, 'utf8'); }
function expect(condition, message) {
  if (!condition) {
    console.error(`[Q389R6M][FAIL] ${message}`);
    process.exit(1);
  }
}

const overlay = read('lib/features/graph/graph_interaction_overlay.dart');
const criticalPoints = read('lib/features/graph/graph_critical_points.dart');
const graphHistoryTest = read('test/graph_history_regression_test.dart');
const q208Test = read('test/v172_q208_graph_2d_3d_elite_toggle_architecture_test.dart');
const auditDoc = read('docs/audit/V172_Q382R24R1_STALE_TEST_EXPECTATION_REPAIR.md');
const pubspec = read('pubspec.yaml').toLowerCase();
const policy = read('lib/features/workspace/workspace_analyze_test_hardening_policy_q389r6m.dart');

expect(overlay.includes("'$sign$absNπ'"), 'graph interaction overlay must remove unnecessary braces in pi label interpolation.');
expect(overlay.includes("'$absNπ'"), 'graph interaction overlay must remove unnecessary braces in pi prefix interpolation.');
expect(!overlay.includes("'${absN}π'"), 'graph interaction overlay must not keep stale ${absN}π interpolation.');
expect(criticalPoints.includes('ySpan * 0.000001'), 'quadratic extremum detection tolerance must be tightened for x^2 - 4.');
expect(graphHistoryTest.includes("find.widgetWithText(ElevatedButton, 'Apply')"), 'graph settings regression test must target the actual ElevatedButton Apply control.');
expect(q208Test.includes('font-size: clamp(23px, 6.35vw, 31px);'), 'Q208 stale test must accept Q389R6G compact expression scale.');
expect(!auditDoc.includes('flutter analyze PASS'), 'audit docs must not contain fake flutter analyze PASS wording.');
expect(!auditDoc.includes('flutter test PASS'), 'audit docs must not contain fake flutter test PASS wording.');
expect(!pubspec.includes('onnx'), 'pubspec must not contain ONNX wording because Q276/Q277 reject pubspec-wide OCR runtime markers.');
expect(!/^\s*onnxruntime\s*:/m.test(pubspec), 'pubspec must not add onnxruntime dependency.');
expect(policy.includes("Q389R6M-ANALYZE-TEST-HARDENING-ROUND-2"), 'Q389R6M policy marker must be present.');

console.log('[Q389R6M][PASS] analyze/test round-2 hardening static verifier passed.');
