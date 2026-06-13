import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { throw new Error(msg); };
const requireText = (file, needle) => {
  const text = read(file);
  if (!text.includes(needle)) fail(`${file} missing ${needle}`);
};

const main = 'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt';
const gradle = 'android/app/build.gradle';
const bundle = 'lib/features/camera/gauss_device_only_formula_ocr_bundle_q389r2_offline.dart';
const manager = 'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart';

for (const file of [main, gradle, bundle, manager]) {
  if (!exists(file)) fail(`missing ${file}`);
}

requireText(gradle, "com.microsoft.onnxruntime:onnxruntime-android:1.20.0");
requireText(main, 'import java.nio.FloatBuffer');
requireText(main, 'V172-Q389R6B-ONNX-RUNTIME-MOBILE-DOWNLOAD-ONLY-INTEGRATION');
requireText(main, 'pp_formulanet_plus_s.onnx');
requireText(main, '575353f72a804215329b128ed1b85e8de65fdb4b06730ac8e7954bae5c44e64d');
requireText(main, '333913240L');
requireText(main, 'q389R6BOnnxModelLoadSmoke');
requireText(main, 'q389R6BRealOnnxFormulaInference');
requireText(main, 'FloatBuffer.wrap(tensorValues)');
requireText(main, 'directOcrToWorkspaceImportBlocked');
requireText(main, 'directOcrToSolveGraphSolutionHistoryBlocked');
requireText(main, 'ocrPassClaimed" to false');
requireText(bundle, 'class GaussDeviceOnlyFormulaOcrBundleQ389R6BPolicy');
requireText(bundle, 'q389r6b-onnx-runtime-mobile-bundle-manifest-v1');
requireText(bundle, 'onnx-runtime-model');
requireText(bundle, 'modelBundledInBaseApp = false');
requireText(manager, 'PP-FormulaNet_plus-S ONNX Runtime Mobile bundle manifest');
requireText(manager, 'ONNX Runtime Mobile Formula OCR');

const forbiddenExtensions = ['.onnx', '.pdiparams', '.pdmodel', '.nb'];
const heavy = [];
const rejectFiles = [];
function walk(dir) {
  for (const ent of fs.readdirSync(dir, { withFileTypes: true })) {
    const abs = path.join(dir, ent.name);
    const rel = path.relative(root, abs).replaceAll(path.sep, '/');
    if (ent.isDirectory()) {
      if (['.git', 'build', '.dart_tool'].includes(ent.name)) continue;
      walk(abs);
    } else {
      if (rel.endsWith('.rej')) rejectFiles.push(rel);
      const lower = rel.toLowerCase();
      if (forbiddenExtensions.some((ext) => lower.endsWith(ext))) heavy.push(rel);
    }
  }
}
walk(root);
if (rejectFiles.length) fail(`reject files remain: ${rejectFiles.join(', ')}`);
if (heavy.length) fail(`model/runtime artifact bytes must not be bundled: ${heavy.join(', ')}`);

const reportDir = path.join(root, 'tool/reports');
fs.mkdirSync(reportDir, { recursive: true });
const report = {
  phase: 'V172-Q389R6W-ONNX-RUNTIME-MOBILE-INTEGRATION-ADAPTATION',
  pass: true,
  checks: {
    onnxRuntimeDependencyPresent: true,
    ppFormulaNetPlusSConstantsPresent: true,
    noModelBytesBundled: true,
    noRejectFiles: true,
    reviewFirstGuardPresent: true,
    noPackagePassClaimed: true,
  },
  note: 'Static verifier only. Flutter analyze/test, Android build, and real-device OCR PASS are not claimed by this verifier.'
};
fs.writeFileSync(path.join(reportDir, 'q389r6w_onnx_runtime_mobile_integration_adaptation_report.json'), JSON.stringify(report, null, 2));
console.log(JSON.stringify(report, null, 2));
