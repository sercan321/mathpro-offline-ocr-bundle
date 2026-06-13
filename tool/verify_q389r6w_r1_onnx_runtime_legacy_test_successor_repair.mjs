#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const failures = [];
const assert = (ok, message) => { if (!ok) failures.push(message); };

const buildGradle = read('android/app/build.gradle');
const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
const helper = read('test/v172_q389r6w_onnx_runtime_successor_test_helper.dart');

assert(buildGradle.includes("implementation 'com.microsoft.onnxruntime:onnxruntime-android:1.20.0'"), 'ONNX Runtime Android dependency is missing');
assert(buildGradle.toLowerCase().includes('pp-formulanet_plus-s .onnx stays user-downloaded/app-private'), 'download-only ONNX marker is missing');
assert(helper.includes('expectQ389R6WOnnxRuntimeDependencySurface'), 'Q389R6W successor helper missing');
assert(helper.includes('q389R6WAllowsOnnxRuntimeDependency'), 'Q389R6W successor predicate missing');
assert(read('test/v172_q384r1_camera_ocr_deferred_model_download_activation_test.dart').includes("<String>{'nb', 'onnx-runtime-model'}"), 'Q384R1 runtime kind test is not ONNX successor-aware');
assert(read('test/v172_q384r2_camera_ocr_runtime_model_format_binding_preflight_test.dart').includes("<String>{'nb', 'onnx-runtime-model'}"), 'Q384R2 runtime kind test is not ONNX successor-aware');
assert(manager.includes('ana model dosyası SHA256 kontrolünden geçti'), 'legacy primary SHA wording missing');
assert(manager.includes('ONNX runtime model doğrulaması aktif'), 'ONNX ready copy wording missing');

const forbiddenModelFiles = [];
function walk(dir) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, entry.name);
    const rel = path.relative(root, p).replaceAll('\\\\', '/');
    if (rel.startsWith('build/') || rel.includes('/build/') || rel.startsWith('.dart_tool/') || rel.includes('/.dart_tool/')) continue;
    if (entry.isDirectory()) walk(p);
    else if (/\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors)$/i.test(entry.name)) forbiddenModelFiles.push(rel);
  }
}
walk(root);
assert(forbiddenModelFiles.length === 0, `model artifacts are bundled: ${forbiddenModelFiles.join(', ')}`);

const report = {
  phase: 'V172-Q389R6W-R1-ONNX-RUNTIME-LEGACY-TEST-SUCCESSOR-REPAIR',
  onnxRuntimeDependencyPresent: buildGradle.includes('onnxruntime-android'),
  modelArtifactsBundled: forbiddenModelFiles,
  successorHelperPresent: helper.includes('expectQ389R6WOnnxRuntimeDependencySurface'),
  q384RuntimeKindSuccessorAware: read('test/v172_q384r1_camera_ocr_deferred_model_download_activation_test.dart').includes("<String>{'nb', 'onnx-runtime-model'}") && read('test/v172_q384r2_camera_ocr_runtime_model_format_binding_preflight_test.dart').includes("<String>{'nb', 'onnx-runtime-model'}"),
  legacyReadyCopyPreserved: manager.includes('ana model dosyası SHA256 kontrolünden geçti'),
  failures,
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/q389r6w_r1_onnx_runtime_legacy_test_successor_repair_report.json'), JSON.stringify(report, null, 2));
if (failures.length) {
  console.error(JSON.stringify(report, null, 2));
  process.exit(1);
}
console.log(JSON.stringify(report, null, 2));
