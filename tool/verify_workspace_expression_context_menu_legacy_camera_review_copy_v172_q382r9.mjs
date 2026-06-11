#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q382R9_VERIFY_FAIL: ${msg}`); process.exit(1); };
const assert = (cond, msg) => { if (!cond) fail(msg); };
const phase = 'V172-Q382R9-WORKSPACE-CONTEXT-MENU-LEGACY-CAMERA-REVIEW-COPY-EXPECTATION-REPAIR';

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert(manifest.workspaceExpressionContextMenuLegacyCameraReviewCopyExpectationRepairLatestPhase === phase, 'manifest Q382R9 latest phase missing');
const envelope = manifest.v172Q382R9WorkspaceContextMenuLegacyCameraReviewCopyExpectationRepair;
assert(envelope?.q239bCameraCaptureCopyExpectationGuarded === true, 'Q239B copy guard missing');
assert(envelope?.q239cCropReviewCopyExpectationGuarded === true, 'Q239C copy guard missing');
assert(envelope?.q239dDeferredModelReviewCopyExpectationGuarded === true, 'Q239D copy guard missing');
assert(envelope?.q239eMathLiveReviewStatefulWidgetAndCopyExpectationGuarded === true, 'Q239E stateful/copy guard missing');
assert(envelope?.q243CameraUxPremiumCopyExpectationGuarded === true, 'Q243 copy guard missing');
assert(envelope?.q277r1StatefulReviewSheetExpectationGuarded === true, 'Q277R1 stateful guard missing');
assert(envelope?.runtimeBehaviorChanged === false, 'Q382R9 must not change runtime behavior');
assert(envelope?.keyboardLayoutChanged === false, 'keyboard must remain unchanged');
assert(envelope?.mathLiveProductionAssetsChanged === false, 'MathLive production assets must remain unchanged');
assert(envelope?.q381R1OcrRuntimeChanged === false, 'Q381R1 OCR runtime must remain unchanged');

const policy = read('lib/features/workspace/workspace_expression_context_menu_q382_policy.dart');
assert(policy.includes(`legacyCameraReviewCopyExpectationRepairPhase = '${phase}'`), 'policy Q382R9 phase missing');
assert(policy.includes('q382R9LegacyCameraReviewCopyExpectationsGuarded = true'), 'policy Q382R9 guard marker missing');
assert(policy.includes('q382R9Q239Q243Q277LegacyTestsSuccessorAware = true'), 'policy Q382R9 successor marker missing');
assert(policy.includes('q382R9RuntimeBehaviorUnchanged = true'), 'policy Q382R9 runtime unchanged marker missing');

const q239b = read('test/v172_q239b_camera_permission_capture_shell_test.dart');
assert(q239b.includes("cameraShell.contains('Fotoğraf doğrudan çözüme gönderilmedi') ||"), 'Q239B old copy compatibility missing');
assert(q239b.includes("cameraShell.contains('OCR review akışı başlar')"), 'Q239B current copy compatibility missing');

const q239c = read('test/v172_q239c_formula_crop_scan_frame_test.dart');
assert(q239c.includes("combinedCameraReview.contains('MathLive OCR review')"), 'Q239C current MathLive review copy missing');
assert(q239c.includes("combinedCameraReview.contains('Düzenlenebilir OCR adayı')"), 'Q239C current editable OCR copy missing');
assert(q239c.includes("combinedCameraReview.contains('OCR review akışı başlar')"), 'Q239C current camera OCR review copy missing');

const q239d = read('test/v172_q239d_deferred_math_ocr_model_manager_test.dart');
assert(q239d.includes("combinedCameraReview.contains('OCR adayı henüz hazır değil. Workspace aktarımı, çözüm ve grafik kapalı kalır.')"), 'Q239D pending review copy missing');
assert(q239d.includes("combinedCameraReview.contains('OCR adayı yok: workspace aktarımı, çözüm ve grafik kapalı')"), 'Q239D blocked review copy missing');
assert(q239d.includes("combinedCameraReview.contains('OCR review akışı başlar')"), 'Q239D camera review copy missing');

const q239e = read('test/v172_q239e_mathlive_ocr_review_surface_test.dart');
assert(q239e.includes("reviewSurface.contains('class GaussMathLiveOcrReviewSheet extends StatefulWidget')"), 'Q239E stateful review sheet compatibility missing');
assert(q239e.includes("reviewSurface.contains('MathLive OCR review')"), 'Q239E current title copy missing');
assert(q239e.includes("reviewSurface.contains('Düzenlenebilir OCR adayı')"), 'Q239E current editable copy missing');
assert(q239e.includes("reviewSurface.contains('OCR adayı henüz hazır değil. Workspace aktarımı, çözüm ve grafik kapalı kalır.')"), 'Q239E pending copy missing');

const q243 = read('test/v172_q243_camera_ux_premium_polish_test.dart');
assert(q243.includes("cameraShell.contains('Formülü çerçeve içine al. Çerçeveyi kullanınca OCR review akışı başlar.')"), 'Q243 current camera guidance copy missing');

const q277 = read('test/v172_q277r1_camera_ocr_runtime_premium_regression_log_repair_test.dart');
assert(q277.includes("statefulSheetMarker = 'class GaussMathLiveOcrReviewSheet extends StatefulWidget'") || q277.includes("source.indexOf('class GaussMathLiveOcrReviewSheet extends StatefulWidget')"), 'Q277R1 stateful sheet guard missing');
assert(q277.includes("source.contains('OCR adayı henüz hazır değil. Workspace aktarımı, çözüm ve grafik kapalı kalır.')"), 'Q277R1 current pending copy guard missing');

const q382Test = read('test/v172_q382_workspace_expression_context_menu_test.dart');
assert(q382Test.includes('legacyCameraReviewCopyExpectationRepairPhase'), 'Q382 test missing Q382R9 phase expectation');
assert(q382Test.includes('q382R9LegacyCameraReviewCopyExpectationsGuarded'), 'Q382 test missing Q382R9 guard expectation');

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

console.log('Q382R9_VERIFY_PASS workspace context menu legacy camera/review copy expectation repair verified.');
