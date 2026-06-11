#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_device_only_formula_ocr_production_bundle_closure_v172_q389r4_offline: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

check(!exists('backend'), 'backend directory must not exist in device-only offline package');
check(!exists('lib/features/camera/gauss_formula_ocr_backend_client_q389r2.dart'), 'backend client must not exist');

const pubspec = read('pubspec.yaml');
const gradle = read('android/app/build.gradle');
const main = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const capture = read('lib/features/camera/gauss_camera_capture_shell.dart');
const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
const bundle = read('lib/features/camera/gauss_device_only_formula_ocr_bundle_q389r2_offline.dart');
const q378 = read('lib/features/camera/gauss_real_camera_ocr_user_flow_binding_q378.dart');

for (const forbidden of [
  'google_mlkit_text_recognition:',
  'google_mlkit_commons:',
  'com.google.mlkit',
  'TextRecognition.getClient',
  'MATHPRO_FORMULA_OCR_ENDPOINT',
  'FormulaOcrBackendClient',
  'backend/formula_ocr_service',
]) {
  check(!pubspec.includes(forbidden), `forbidden marker in pubspec: ${forbidden}`);
  check(!gradle.includes(forbidden), `forbidden marker in Gradle: ${forbidden}`);
  check(!main.includes(forbidden), `forbidden marker in MainActivity: ${forbidden}`);
  check(!capture.includes(forbidden), `forbidden marker in capture shell: ${forbidden}`);
  check(!manager.includes(forbidden), `forbidden marker in manager: ${forbidden}`);
  check(!q378.includes(forbidden), `forbidden marker in Q378: ${forbidden}`);
}

check(capture.includes('installDeviceOnlyFormulaOcrBundleQ389R4Offline'), 'camera Modeli indir path must call Q389R4 offline installer');
check(manager.includes('installDeviceOnlyFormulaOcrBundleQ389R4Offline'), 'manager must expose Q389R4 offline installer');
check(manager.includes('installDeviceOnlyFormulaOcrBundleQ389R3Offline') && manager.includes('return installDeviceOnlyFormulaOcrBundleQ389R4Offline'), 'Q389R3 alias must forward to Q389R4');
check(manager.includes('installDeviceOnlyFormulaOcrBundleQ389R2Offline') && manager.includes('return installDeviceOnlyFormulaOcrBundleQ389R4Offline'), 'Q389R2 alias must forward to Q389R4');

for (const marker of [
  'GaussDeviceOnlyFormulaOcrBundleQ389R4OfflinePolicy',
  'V172-Q389R4_OFFLINE-PRODUCTION-BUNDLE-COMPLETENESS-CLOSURE',
  'q389r4-offline-bundle-manifest-v1',
  'q389r4-offline-decoder-sidecar-missing',
  'q389r4-offline-preprocess-metadata-missing',
  'q389r4-offline-unsafe-bundle-file-name',
  'q389r4-offline-unsupported-model-family',
  'requiresDecoderSidecar = true',
  'requiresPreprocessMetadata = true',
  'requiresExactSha256 = true',
  'requiresExactSizeBytes = true',
  'fileName.contains',
  'file.required && file.isDecoderSidecar',
  'file.required && file.isPreprocessMetadata',
  'length != source.sizeBytes',
  'downloaded != source.sizeBytes',
  'q389r4ProductionBundleCompletenessVerified',
]) check(bundle.includes(marker), `bundle installer missing ${marker}`);

check(main.includes('q389r4-offline-formula-ocr-production-bundle-not-ready'), 'native bridge must expose Q389R4 bundle-not-ready reason');
check(main.includes('q389r4-offline-formula-ocr-production-bundle-source-missing'), 'native bridge must expose Q389R4 source-missing reason');
check(main.includes('q387R1ValidateNbManifestEvidence'), 'native bridge must validate .nb manifest evidence');
check(main.includes('setModelFromFile'), 'native bridge must keep Paddle Lite setModelFromFile path');
check(main.includes('tokenizer.json') && main.includes('formula_tokenizer.json'), 'native decoder sidecar inventory must include tokenizer JSON files');
check(q378.includes('backend/endpoint image upload is forbidden'), 'Q378 must explicitly block backend/endpoint upload path');

check(exists('tool/build_q389r4_offline_formula_ocr_production_bundle_manifest.mjs'), 'Q389R4 production bundle manifest builder missing');
const builder = read('tool/build_q389r4_offline_formula_ocr_production_bundle_manifest.mjs');
for (const marker of [
  "required('model-dir')",
  "required('base-url')",
  "required('source-revision')",
  "required('conversion-provenance')",
  'No .nb file found in model-dir',
  'No decoder/tokenizer/vocab sidecar found in model-dir',
  'No preprocess/shape/metadata sidecar found in model-dir',
  'base-url must be HTTPS',
  'q389r4-offline-bundle-manifest-v1',
]) check(builder.includes(marker), `manifest builder missing ${marker}`);

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
check(['V172-Q389R4_OFFLINE','V172-Q389R5A_OFFLINE'].includes(manifest.cameraOcrFormulaOcrPrimaryEngineLatestPhase), 'manifest latest phase must be Q389R4_OFFLINE or Q389R5A_OFFLINE successor');
const entry = manifest.v172Q389R4OfflineProductionBundleCompletenessClosure;
check(entry?.backendAllowed === false && entry?.mlKitAllowed === false && entry?.textOcrFallbackAllowed === false, 'manifest must block backend/MLKit/text fallback');
check(entry?.requiresNbModel === true && entry?.requiresDecoderSidecar === true && entry?.requiresPreprocessMetadata === true, 'manifest must require full OCR bundle components');
check(entry?.requiresExactSha256 === true && entry?.requiresExactSizeBytes === true, 'manifest must require exact evidence checks');
check(entry?.keyboardQ382Touched === false && entry?.graphHistorySolutionSolverTouched === false, 'protected surface markers must remain false');
check(entry?.ocrPassClaimedByPackage === false && entry?.androidRealDevicePassClaimedByPackage === false, 'package must not claim real OCR/device PASS');

const forbiddenArtifacts = [];
const walk = (dir) => {
  for (const name of fs.readdirSync(dir)) {
    const full = path.join(dir, name);
    const rel = path.relative(root, full).replace(/\\/g, '/');
    if (rel.startsWith('build/') || rel.startsWith('.dart_tool/')) continue;
    const st = fs.statSync(full);
    if (st.isDirectory()) walk(full);
    else if (/\.(nb|onnx|pdmodel|pdiparams|tflite|apk|aab|zip)$/i.test(name)) forbiddenArtifacts.push(rel);
  }
};
walk(root);
check(forbiddenArtifacts.length === 0, `forbidden model/release artifact bundled: ${forbiddenArtifacts.join(', ')}`);

console.log('PASS verify_device_only_formula_ocr_production_bundle_closure_v172_q389r4_offline');
