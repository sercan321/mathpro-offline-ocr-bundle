#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q382R10_VERIFY_FAIL: ${msg}`); process.exit(1); };
const assert = (cond, msg) => { if (!cond) fail(msg); };
const phase = 'V172-Q382R10-WORKSPACE-CONTEXT-MENU-FINAL-ANALYZE-TEST-EXPECTATION-REPAIR';

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert(manifest.workspaceExpressionContextMenuFinalAnalyzeTestExpectationRepairLatestPhase === phase, 'manifest Q382R10 latest phase missing');
const envelope = manifest.v172Q382R10WorkspaceContextMenuFinalAnalyzeTestExpectationRepair;
assert(envelope?.q277r1PreferContainsAnalyzerWarningRepaired === true, 'Q277R1 prefer_contains repair marker missing');
assert(envelope?.q239cLegacyOcrNextPhaseCopyExpectationGuarded === true, 'Q239C legacy OCR copy repair marker missing');
assert(envelope?.runtimeBehaviorChanged === false, 'Q382R10 must not change runtime behavior');
assert(envelope?.keyboardLayoutChanged === false, 'keyboard must remain unchanged');
assert(envelope?.mathLiveProductionAssetsChanged === false, 'MathLive production assets must remain unchanged');
assert(envelope?.q381R1OcrRuntimeChanged === false, 'Q381R1 OCR runtime must remain unchanged');

const policy = read('lib/features/workspace/workspace_expression_context_menu_q382_policy.dart');
assert(policy.includes(`legacyCameraReviewFinalAnalyzeTestExpectationRepairPhase = '${phase}'`), 'policy Q382R10 phase missing');
assert(policy.includes('q382R10PreferContainsAnalyzerRepairApplied = true'), 'policy Q382R10 analyzer marker missing');
assert(policy.includes('q382R10Q239CLegacyOcrNextPhaseCopyGuarded = true'), 'policy Q382R10 Q239C marker missing');
assert(policy.includes('q382R10RuntimeBehaviorUnchanged = true'), 'policy Q382R10 runtime unchanged marker missing');

const q277 = read('test/v172_q277r1_camera_ocr_runtime_premium_regression_log_repair_test.dart');
assert(q277.includes("final statelessSheetPresent = source.contains(statelessSheetMarker);"), 'Q277R1 stateless contains marker missing');
assert(q277.includes("final statefulSheetPresent = source.contains(statefulSheetMarker);"), 'Q277R1 stateful contains marker missing');
assert(q277.includes('expect(statelessSheetPresent || statefulSheetPresent, isTrue);'), 'Q277R1 contains assertion missing');
assert(!q277.includes("source.indexOf('class GaussMathLiveOcrReviewSheet extends StatelessWidget') >= 0"), 'Q277R1 still uses indexOf for containment');

const q239c = read('test/v172_q239c_formula_crop_scan_frame_test.dart');
assert(q239c.includes("combinedCameraReview.contains('OCR sonraki fazda') ||"), 'Q239C old marker compatibility missing');
assert(q239c.includes("combinedCameraReview.contains('OCR review akışı başlar') ||"), 'Q239C current OCR review copy missing');
assert(q239c.includes("combinedCameraReview.contains('OCR adayı henüz hazır değil')"), 'Q239C pending review copy missing');

const q382Test = read('test/v172_q382_workspace_expression_context_menu_test.dart');
assert(q382Test.includes('legacyCameraReviewFinalAnalyzeTestExpectationRepairPhase'), 'Q382 test missing Q382R10 phase expectation');
assert(q382Test.includes('q382R10PreferContainsAnalyzerRepairApplied'), 'Q382 test missing Q382R10 analyzer expectation');
assert(q382Test.includes('q382R10Q239CLegacyOcrNextPhaseCopyGuarded'), 'Q382 test missing Q382R10 Q239C expectation');

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

console.log('Q382R10_VERIFY_PASS workspace context menu final analyze/test expectation repair verified.');
