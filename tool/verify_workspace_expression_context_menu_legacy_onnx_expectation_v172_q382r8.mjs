#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q382R8_VERIFY_FAIL: ${msg}`); process.exit(1); };
const assert = (cond, msg) => { if (!cond) fail(msg); };
const phase = 'V172-Q382R8-WORKSPACE-CONTEXT-MENU-LEGACY-ONNX-EXPECTATION-REPAIR';

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert(manifest.workspaceExpressionContextMenuLegacyOnnxExpectationRepairLatestPhase === phase, 'manifest Q382R8 latest phase missing');
const envelope = manifest.v172Q382R8WorkspaceContextMenuLegacyOnnxExpectationRepair;
assert(envelope?.q352LegacyOnnxTensorAndRunInferenceExpectationsGuarded === true, 'manifest Q352 legacy guard marker missing');
assert(envelope?.q353LegacyOnnxTensorExpectationGuarded === true, 'manifest Q353 legacy guard marker missing');
assert(envelope?.q354LegacyOnnxTensorExpectationGuarded === true, 'manifest Q354 legacy guard marker missing');
assert(envelope?.runtimeBehaviorChanged === false, 'Q382R8 must not change runtime behavior');
assert(envelope?.keyboardLayoutChanged === false, 'keyboard must remain unchanged');
assert(envelope?.mathLiveProductionAssetsChanged === false, 'MathLive production assets must remain unchanged');
assert(envelope?.q381R1OcrRuntimeChanged === false, 'Q381R1 OCR runtime must remain unchanged');

const policy = read('lib/features/workspace/workspace_expression_context_menu_q382_policy.dart');
assert(policy.includes(`legacyOnnxExpectationRepairPhase = '${phase}'`), 'policy Q382R8 phase missing');
assert(policy.includes('q382R8LegacyOnnxRuntimeExpectationsGuarded = true'), 'policy Q382R8 guard marker missing');
assert(policy.includes('q382R8Q352Q353Q354SuccessorAwarenessRepaired = true'), 'policy Q382R8 successor marker missing');
assert(policy.includes('q382R8RuntimeBehaviorUnchanged = true'), 'policy Q382R8 runtime unchanged marker missing');

const q352 = read('test/v172_q352_onnx_conversion_evidence_acceptance_runtime_strategy_pivot_gate_test.dart');
assert(q352.includes("if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {\n      expect(mainActivity, isNot(contains('OnnxTensor')));"), 'Q352 OnnxTensor expectation is not successor-aware');
assert(q352.includes("if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {\n      expect(mainActivity, isNot(contains('runInference(')));"), 'Q352 runInference expectation is not successor-aware');
assert(q352.includes("if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {\n      expect(mainActivity, isNot(contains('pp_formulanet_s.onnx')));"), 'Q352 model filename expectation is not successor-aware');

const q353 = read('test/v172_q353_onnx_runtime_mobile_dependency_feasibility_gate_test.dart');
assert(q353.includes("if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {\n      expect(mainActivity, isNot(contains('OnnxTensor')));"), 'Q353 OnnxTensor expectation is not successor-aware');

const q354 = read('test/v172_q354_onnx_runtime_android_dependency_abi_build_trial_test.dart');
assert(q354.includes("if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {\n      expect(mainActivity, isNot(contains('OnnxTensor')));"), 'Q354 OnnxTensor expectation is not successor-aware');
assert(q354.includes("if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {\n      expect(mainActivity, isNot(contains('OrtEnvironment')));"), 'Q354 OrtEnvironment expectation guard missing');

const q382Test = read('test/v172_q382_workspace_expression_context_menu_test.dart');
assert(q382Test.includes('legacyOnnxExpectationRepairPhase'), 'Q382 test missing Q382R8 phase expectation');
assert(q382Test.includes('q382R8LegacyOnnxRuntimeExpectationsGuarded'), 'Q382 test missing Q382R8 guard expectation');

for (const protectedFile of [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'assets/mathlive/mathlive_bridge.js',
  'assets/mathlive/main_editor.html',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
  'android/app/build.gradle',
  'pubspec.yaml',
  'android/app/src/main/AndroidManifest.xml',
]) assert(exists(protectedFile), `${protectedFile} missing`);

console.log('Q382R8_VERIFY_PASS workspace context menu legacy ONNX expectation repair verified.');
