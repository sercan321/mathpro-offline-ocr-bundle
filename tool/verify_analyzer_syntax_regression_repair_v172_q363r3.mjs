#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const phase = 'V172-Q363R3-ANALYZER-SYNTAX-REGRESSION-REPAIR';
const sourcePhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const errors = [];
const check = (condition, message) => { if (!condition) errors.push(message); };

check(manifest.cameraOcrLatestPhase === sourcePhase, 'cameraOcrLatestPhase must remain Q363');
check(manifest.activeProductDevelopmentLatestPhase === sourcePhase, 'activeProductDevelopmentLatestPhase must remain Q363');
check(manifest.q363R3AnalyzerSyntaxRegressionRepairLatestPhase === phase, 'Q363R3 latest hygiene phase missing');
const q363r3 = manifest.v172Q363R3AnalyzerSyntaxRegressionRepair || {};
check(q363r3.phase === phase, 'Q363R3 manifest phase mismatch');
check(q363r3.sourcePhase === sourcePhase, 'Q363R3 manifest source phase mismatch');
check(q363r3.repairsMalformedQ363R2DartInsertions === true, 'Q363R3 must declare malformed Q363R2 insertion repair');
check(q363r3.repairsLeadingCommaSyntaxErrors === true, 'Q363R3 must declare leading comma syntax repair');
check(q363r3.repairsMalformedManifestIndexing === true, 'Q363R3 must declare malformed manifest indexing repair');
check(q363r3.repairsLegacySuccessorAwarenessWithoutRuntimeChanges === true, 'Q363R3 must preserve runtime while repairing successor awareness');

for (const rel of [
  'lib/features/camera/gauss_q363r3_analyzer_syntax_regression_repair_policy.dart',
  'lib/features/camera/gauss_q363r3_analyzer_syntax_regression_repair.dart',
  'test/v172_q363r3_analyzer_syntax_regression_repair_test.dart',
]) check(exists(rel), `${rel} missing`);

const testFiles = fs.readdirSync(path.join(root, 'test')).filter((name) => name.endsWith('.dart'));
for (const name of testFiles) {
  const rel = `test/${name}`;
  const content = read(rel);
  check(!content.includes("manifest['cameraOcrLatestPhase',"), `${rel} contains malformed cameraOcrLatestPhase map access`);
  check(!content.includes("manifest['activeProductDevelopmentLatestPhase',"), `${rel} contains malformed activeProductDevelopmentLatestPhase map access`);
  check(!content.includes("\n    ,\n"), `${rel} contains standalone leading comma line`);
  check(!content.includes("\n      ,\n"), `${rel} contains standalone indented leading comma line`);
  check(!content.includes("\n    , '${sourcePhase}"), `${rel} contains leading comma before Q363 phase`);
  check(!content.includes("\n      , '${sourcePhase}"), `${rel} contains indented leading comma before Q363 phase`);
  if (content.includes("contains(manifest['cameraOcrLatestPhase'])") ||
      content.includes("contains(manifest['activeProductDevelopmentLatestPhase'])")) {
    check(
      content.includes(sourcePhase) ||
        content.includes('q363StorePrivacyFinalReleaseGatePhase') ||
        content.includes('q363SuccessorPhase'),
      `${rel} has active-phase contains checks without Q363 acceptance`,
    );
  }
}

const helper = read('test/v172_q344_binary_bundle_successor_test_helper.dart');
check(helper.includes('q363StorePrivacyFinalReleaseGatePhase'), 'successor helper must define Q363 phase');
check(!helper.includes("manifest['cameraOcrLatestPhase',"), 'successor helper contains malformed camera phase access');
check(!helper.includes("manifest['activeProductDevelopmentLatestPhase',"), 'successor helper contains malformed active product phase access');

const q342Test = read('test/v172_q342_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_test.dart');
check(q342Test.includes(sourcePhase), 'Q342 pending evidence test must accept Q363 active phase');
const q352Test = read('test/v172_q352_onnx_conversion_evidence_acceptance_runtime_strategy_pivot_gate_test.dart');
check(!q352Test.includes("\n    , '${sourcePhase}"), 'Q352 test still has malformed leading comma Q363 insertion');
const q353Test = read('test/v172_q353_onnx_runtime_mobile_dependency_feasibility_gate_test.dart');
check(!q353Test.includes("\n    , '${sourcePhase}"), 'Q353 test still has malformed leading comma Q363 insertion');

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
check(!mainActivity.includes('q363r3'), 'Q363R3 must not modify MainActivity/runtime bridge');
const gradle = read('android/app/build.gradle');
check(gradle.includes("implementation 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0'"), 'Q354 ONNX Runtime dependency must remain preserved');
const pubspec = read('pubspec.yaml').toLowerCase();
check(!pubspec.includes('onnxruntime'), 'pubspec must not gain ONNX Runtime dependency');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
check(!androidManifest.includes('ONNX'), 'AndroidManifest must not be modified for ONNX');

const forbiddenModelExtensions = /\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors)$/i;
const walk = (dir) => {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    const rel = path.relative(root, full).replaceAll(path.sep, '/');
    if (rel.startsWith('build/') || rel.includes('/build/') || rel.startsWith('.dart_tool/') || rel.includes('/.dart_tool/')) continue;
    if (entry.isDirectory()) walk(full);
    if (entry.isFile() && forbiddenModelExtensions.test(entry.name) && !rel.startsWith('docs/evidence/')) {
      errors.push(`model artifact must not be bundled: ${rel}`);
    }
  }
};
walk(root);

if (errors.length) {
  console.error('Q363R3_ANALYZER_SYNTAX_REGRESSION_REPAIR_FAILED');
  for (const error of errors) console.error(` - ${error}`);
  process.exit(1);
}
console.log('Q363R3_ANALYZER_SYNTAX_REGRESSION_REPAIR_PASS');
