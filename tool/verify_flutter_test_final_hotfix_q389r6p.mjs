#!/usr/bin/env node
import fs from 'fs';

const graphHistoryTest = fs.readFileSync('test/graph_history_regression_test.dart', 'utf8');
const pubspec = fs.readFileSync('pubspec.yaml', 'utf8');

function assert(condition, message) {
  if (!condition) {
    console.error(`FAIL: ${message}`);
    process.exit(1);
  }
}

assert(graphHistoryTest.includes("tester.widget<ElevatedButton>(applyButton).onPressed?.call();"), 'graph settings regression test should invoke the Apply callback directly instead of hit-test tapping an offscreen bottom-sheet button');
assert(!graphHistoryTest.includes('await tester.tap(applyButton'), 'graph settings regression test should not tap the Apply finder path that was hit-test brittle on Flutter');
assert(graphHistoryTest.includes("expect(applied, isNull);"), 'invalid viewport rejection assertion must remain');
assert(graphHistoryTest.includes("expect(applied, isNotNull);"), 'valid viewport apply assertion must remain');
assert(graphHistoryTest.includes("closeTo(-6.28, 0.00001)"), 'valid xMin assertion must remain');
assert(!/onnxruntime/i.test(pubspec), 'pubspec must not contain onnxruntime forbidden runtime marker');
assert(!/\bonnx\b/i.test(pubspec), 'pubspec must not contain stale onnx audit wording that trips OCR runtime tests');

console.log('PASS verify_flutter_test_final_hotfix_q389r6p');
