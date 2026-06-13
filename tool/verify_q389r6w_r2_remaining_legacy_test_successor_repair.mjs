#!/usr/bin/env node
import fs from 'node:fs';

const q357 = fs.readFileSync('test/v172_q357_onnx_real_model_load_smoke_bridge_preflight_execution_test.dart', 'utf8');
const q384r1 = fs.readFileSync('test/v172_q384r1_camera_ocr_deferred_model_download_activation_test.dart', 'utf8');
const buildGradle = fs.readFileSync('android/app/build.gradle', 'utf8');
const manifest = fs.readFileSync('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart', 'utf8');

const failures = [];
function requireContains(label, haystack, needle) {
  if (!haystack.includes(needle)) failures.push(`${label} missing: ${needle}`);
}

requireContains('q357 successor size guard', q357, "q389R6BExpectedOnnxSizeBytes = 333913240L");
requireContains('q357 legacy size guard preserved', q357, "q357ExpectedOnnxSizeBytes = 308743097L");
requireContains('q384r1 primary sha successor guard', q384r1, 'GaussDeferredMathOcrModelManifest.sha256');
requireContains('q384r1 plus-s sha guard', q384r1, '575353f72a804215329b128ed1b85e8de65fdb4b06730ac8e7954bae5c44e64d');
requireContains('onnx dependency still present', buildGradle, 'com.microsoft.onnxruntime:onnxruntime-android:1.20.0');
requireContains('onnx runtime model kind still present', manifest, 'primaryRuntimeArtifactKind');

if (failures.length) {
  console.error(JSON.stringify({phase:'V172-Q389R6W-R2-REMAINING-LEGACY-TEST-SUCCESSOR-REPAIR', passed:false, failures}, null, 2));
  process.exit(1);
}

const report = {
  phase: 'V172-Q389R6W-R2-REMAINING-LEGACY-TEST-SUCCESSOR-REPAIR',
  passed: true,
  repairs: [
    'q357 accepts legacy ONNX smoke size and Q389R6B plus-S ONNX successor size without weakening model-artifact bundling guard',
    'q384r1 accepts legacy PP-FormulaNet-S primary SHA and Q389R6B plus-S ONNX manifest SHA while preserving download-only/no direct-solve guard',
  ],
  flutterAnalyzeClaimed: false,
  flutterTestClaimed: false,
  devicePassClaimed: false,
};
fs.mkdirSync('tool/reports', {recursive:true});
fs.writeFileSync('tool/reports/q389r6w_r2_remaining_legacy_test_successor_repair_report.json', JSON.stringify(report, null, 2));
console.log(JSON.stringify(report, null, 2));
