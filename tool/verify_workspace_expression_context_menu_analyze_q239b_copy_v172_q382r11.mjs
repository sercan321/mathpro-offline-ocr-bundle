#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q382R11_VERIFY_FAIL: ${msg}`); process.exit(1); };
const assert = (cond, msg) => { if (!cond) fail(msg); };
const phase = 'V172-Q382R11-WORKSPACE-CONTEXT-MENU-ANALYZE-Q239B-COPY-EXPECTATION-REPAIR';

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert(manifest.workspaceExpressionContextMenuAnalyzeQ239BCopyExpectationRepairLatestPhase === phase, 'manifest Q382R11 latest phase missing');
const envelope = manifest.v172Q382R11WorkspaceContextMenuAnalyzeQ239BCopyExpectationRepair;
assert(envelope?.q277r1ConstDeclarationAnalyzerInfoRepaired === true, 'Q277R1 const analyzer repair marker missing');
assert(envelope?.q239bWorkspaceCameraInvocationExpectationGuarded === true, 'Q239B invocation guard marker missing');
assert(envelope?.q239cLegacyOcrCopyExpectationGuarded === true, 'Q239C copy guard marker missing');
assert(envelope?.runtimeBehaviorChanged === false, 'Q382R11 must not change runtime behavior');
assert(envelope?.keyboardLayoutChanged === false, 'keyboard must remain unchanged');
assert(envelope?.mathLiveProductionAssetsChanged === false, 'MathLive production assets must remain unchanged');
assert(envelope?.q381R1OcrRuntimeChanged === false, 'Q381R1 OCR runtime must remain unchanged');

const policy = read('lib/features/workspace/workspace_expression_context_menu_q382_policy.dart');
assert(policy.includes(`analyzeQ239BCopyExpectationRepairPhase = '${phase}'`), 'policy Q382R11 phase missing');
assert(policy.includes('q382R11ConstDeclarationAnalyzerInfoRepaired = true'), 'policy Q382R11 analyzer marker missing');
assert(policy.includes('q382R11Q239BWorkspaceCameraInvocationGuarded = true'), 'policy Q382R11 Q239B marker missing');
assert(policy.includes('q382R11Q239CLegacyOcrCopyExpectationGuarded = true'), 'policy Q382R11 Q239C marker missing');
assert(policy.includes('q382R11RuntimeBehaviorUnchanged = true'), 'policy Q382R11 runtime unchanged marker missing');

const q277 = read('test/v172_q277r1_camera_ocr_runtime_premium_regression_log_repair_test.dart');
assert(q277.includes('const statelessSheetMarker ='), 'Q277R1 stateless marker must be const');
assert(q277.includes('const statefulSheetMarker ='), 'Q277R1 stateful marker must be const');
assert(!q277.includes('final statelessSheetMarker ='), 'Q277R1 stateless marker still final');
assert(!q277.includes('final statefulSheetMarker ='), 'Q277R1 stateful marker still final');

const q239b = read('test/v172_q239b_camera_permission_capture_shell_test.dart');
assert(q239b.includes("workspace.contains('_openCameraCaptureShell(context)') ||"), 'Q239B old direct invocation compatibility missing');
assert(q239b.includes("workspace.contains('_openCameraCaptureShell(\\n            context,')"), 'Q239B multiline invocation compatibility missing');

const q239c = read('test/v172_q239c_formula_crop_scan_frame_test.dart');
assert(q239c.includes("combinedCameraReview.contains('OCR adayı yok: workspace aktarımı, çözüm ve grafik kapalı')"), 'Q239C current blocked review copy missing');
assert(q239c.includes("combinedCameraReview.contains('OCR review akışı başlar')"), 'Q239C OCR review copy missing');

const q382Test = read('test/v172_q382_workspace_expression_context_menu_test.dart');
assert(q382Test.includes('analyzeQ239BCopyExpectationRepairPhase'), 'Q382 test missing Q382R11 phase expectation');
assert(q382Test.includes('q382R11ConstDeclarationAnalyzerInfoRepaired'), 'Q382 test missing Q382R11 analyzer expectation');
assert(q382Test.includes('q382R11Q239BWorkspaceCameraInvocationGuarded'), 'Q382 test missing Q382R11 Q239B expectation');

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

console.log('Q382R11_VERIFY_PASS workspace context menu analyze/Q239B copy expectation repair verified.');
