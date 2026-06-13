#!/usr/bin/env node
import fs from 'node:fs';

function read(path) {
  return fs.readFileSync(path, 'utf8');
}
function assert(condition, message) {
  if (!condition) {
    console.error(`FAIL: ${message}`);
    process.exit(1);
  }
}

const test = read('test/q389r6m_analyze_test_hardening_round2_contract_test.dart');
const pubspec = read('pubspec.yaml').toLowerCase();
const notes = read('Q389R6N_ANALYZE_COMPILE_HOTFIX_DELIVERY_NOTES.md').toLowerCase();

assert(test.includes('contains(r"\'$sign$absNπ\'")'), 'Q389R6M test must use a raw string for $sign/$absN literal expectation.');
assert(test.includes('contains(r"\'$absNπ\'")'), 'Q389R6M test must use a raw string for $absN literal expectation.');
assert(!pubspec.includes('onnx'), 'pubspec must not contain stale ONNX wording.');
assert(!pubspec.includes('onnxruntime'), 'pubspec must not contain the forbidden legacy runtime keyword.');
assert(!notes.includes('onnxruntime'), 'delivery notes must not contain the forbidden legacy runtime keyword.');
assert(pubspec.includes('http: ^'), 'deferred model download http dependency must remain present.');
assert(notes.includes('flutter analyze/test/build/run are not claimed'), 'delivery notes must not claim Flutter PASS.');

console.log('PASS verify_analyze_compile_hotfix_q389r6n');
