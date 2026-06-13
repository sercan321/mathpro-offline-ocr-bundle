#!/usr/bin/env node
import fs from 'node:fs';

function read(path) { return fs.readFileSync(path, 'utf8'); }
function check(condition, message) {
  if (!condition) {
    console.error(`[Q389R6O][FAIL] ${message}`);
    process.exit(1);
  }
}

const pubspec = read('pubspec.yaml').toLowerCase();
const graphHistoryTest = read('test/graph_history_regression_test.dart');
const q387Test = read('test/v172_q387r7d_paddle_lite_nb_flutter_test_legacy_successor_repair_test.dart');
const q389r6mTest = read('test/q389r6m_analyze_test_hardening_round2_contract_test.dart');
const policy = read('lib/features/workspace/workspace_analyze_test_hardening_policy_q389r6o.dart');

check(graphHistoryTest.includes("find.widgetWithText(ElevatedButton, 'Apply')"), 'graph settings regression test must tap the actual ElevatedButton Apply control.');
check(graphHistoryTest.includes('tester.widget<ElevatedButton>(applyButton).onPressed?.call();'), 'graph settings test must directly invoke Apply callback after Q389R6P hit-test hardening while still asserting onApply state.');
check(!pubspec.includes('onnx'), 'pubspec must not contain ONNX because legacy Q276/Q277 guards scan the entire pubspec.');
check(!pubspec.includes('onnxruntime'), 'pubspec must not contain ONNX Runtime wording or dependency.');
check(!pubspec.includes('paddle'), 'pubspec must not contain Paddle runtime dependency wording.');
check(q387Test.includes("expect(pubspec.toLowerCase(), isNot(contains('onnx')))"), 'Q387R7D successor test must no longer require pubspec-level ONNX wording.');
check(q389r6mTest.includes("find.widgetWithText(ElevatedButton, 'Apply')"), 'Q389R6M contract test must track the updated Apply button tap strategy.');
check(q389r6mTest.includes("expect(pubspec, isNot(contains('onnx')))"), 'Q389R6M contract test must keep pubspec free of ONNX wording.');
check(policy.includes('Q389R6O-FLUTTER-TEST-REMAINING-HOTFIX'), 'Q389R6O policy marker missing.');
check(policy.includes('flutterTestPassClaimedByPackage = false'), 'Q389R6O must not claim flutter test PASS.');

console.log('[Q389R6O][PASS] remaining user-side test hotfix static verifier passed.');
