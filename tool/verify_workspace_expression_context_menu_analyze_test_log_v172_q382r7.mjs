#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q382R7_VERIFY_FAIL: ${msg}`); process.exit(1); };
const assert = (cond, msg) => { if (!cond) fail(msg); };
const phase = 'V172-Q382R7-WORKSPACE-CONTEXT-MENU-ANALYZE-TEST-LOG-REPAIR';

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert(manifest.workspaceExpressionContextMenuAnalyzeTestLogRepairLatestPhase === phase, 'manifest Q382R7 latest phase missing');
const envelope = manifest.v172Q382R7WorkspaceContextMenuAnalyzeTestLogRepair;
assert(envelope?.flutterAnalyzeWarningFixesApplied === true, 'manifest analyze warning repair marker missing');
assert(envelope?.q381UnnecessaryCastRemoved === true, 'manifest Q381 unnecessary-cast marker missing');
assert(envelope?.workspaceMathActionUnnecessaryImportRemoved === true, 'manifest workspace import marker missing');
assert(envelope?.q381TestPreferConstDeclarationWarningRemoved === true, 'manifest Q381 test lint marker missing');
assert(envelope?.q355LegacyOnnxRuntimeExpectationGuarded === true, 'manifest Q355 successor-aware marker missing');
assert(envelope?.q378LegacyOcrReviewCopyExpectationSuccessorAware === true, 'manifest Q378 expectation marker missing');
assert(envelope?.q382UnsupportedIntentNoFakeResultCopyPreserved === true, 'manifest Q382 no-fake copy marker missing');
assert(envelope?.q381R1OcrRuntimeChanged === false, 'Q381R1 OCR runtime must remain unchanged');
assert(envelope?.keyboardLayoutChanged === false, 'keyboard must remain unchanged');
assert(envelope?.mathLiveProductionAssetsChanged === false, 'MathLive production assets must remain unchanged');

const policy = read('lib/features/workspace/workspace_expression_context_menu_q382_policy.dart');
assert(policy.includes(`analyzeTestLogRepairPhase = '${phase}'`), 'policy Q382R7 phase missing');
assert(policy.includes('q382R7AnalyzerWarningsRepaired = true'), 'policy analyzer warning repair marker missing');
assert(policy.includes('q382R7LegacyTestExpectationsRepaired = true'), 'policy legacy test repair marker missing');
assert(policy.includes('q382R7UnsupportedIntentNoFakeResultCopyPreserved = true'), 'policy Q382 no-fake copy marker missing');

const q381 = read('lib/features/camera/gauss_camera_ocr_runtime_finalization_q381.dart');
assert(q381.includes("vocabularySidecarProvisionSupported: evidence['modelVocabularySidecarEvidence'] != null"), 'Q381 unnecessary cast still present or expected replacement missing');
assert(!q381.includes("(evidence['modelVocabularySidecarEvidence'] as Object?)"), 'Q381 unnecessary cast still present');

const actionModel = read('lib/features/workspace/workspace_math_action.dart');
assert(!actionModel.includes("import 'package:flutter/foundation.dart';"), 'workspace math action redundant foundation import still present');
assert(actionModel.includes("import 'package:flutter/material.dart';"), 'workspace math action material import missing');

const q381Test = read('test/v172_q381_camera_ocr_runtime_finalization_test.dart');
assert(q381Test.includes('expect(GaussRealCameraOcrUserFlowBindingQ378.captureAndPrepareReview, isA<Function>());'), 'Q381 test still uses unnecessary local final function tear-off');
assert(!q381Test.includes('final mirror = GaussRealCameraOcrUserFlowBindingQ378.captureAndPrepareReview'), 'Q381 test prefer_const_declarations regression still present');

const q355Test = read('test/v172_q355_onnx_model_private_storage_sha_verification_test.dart');
assert(q355Test.includes("expect(mainActivity, isNot(contains('OnnxTensor')));"), 'Q355 OnnxTensor expectation missing entirely');
assert(q355Test.includes("if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {\n      expect(mainActivity, isNot(contains('OnnxTensor')));"), 'Q355 OnnxTensor expectation is not successor-aware');
assert(q355Test.includes("if (!q357OrLaterOnnxBridgeActivePhases.contains(manifest['cameraOcrLatestPhase'])) {\n      expect(mainActivity, isNot(contains('runInference(')));"), 'Q355 runInference expectation is not successor-aware');

const q378Test = read('test/v172_q378_real_camera_ocr_user_flow_binding_test.dart');
assert(q378Test.includes("reviewSurface.contains('Solve/Graph/Solution/History otomatik çalışmaz')"), 'Q378 legacy copy branch missing');
assert(q378Test.includes("reviewSurface.contains('çözüm, grafik, Solution ve History otomatik çalışmaz')"), 'Q378 current copy branch missing');

const solution = read('lib/features/solution/solution_step_models.dart');
assert(solution.includes('handler kanıtlanmadığı için mevcut sonuç değiştirilmedi ve sahte sonuç gösterilmiyor'), 'Q382 unsupported action no-fake-result copy missing');
assert(solution.includes("final cleanResult = selectedActionUnsupported ? '—'"), 'Q382 stale result suppression missing');

const q382Test = read('test/v172_q382_workspace_expression_context_menu_test.dart');
assert(q382Test.includes('q382R7AnalyzerWarningsRepaired'), 'Q382 test missing Q382R7 analyzer repair marker');
assert(q382Test.includes("step.description.contains('sahte sonuç gösterilmiyor')"), 'Q382 test missing no-fake-result copy expectation');

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

console.log('Q382R7_VERIFY_PASS workspace context menu analyze/test log repair verified.');
