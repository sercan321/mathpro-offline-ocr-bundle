#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_device_only_formula_ocr_real_artifact_binding_v172_q389r3_offline: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

check(!exists('backend'), 'backend directory must not exist in offline-only line');
check(!exists('lib/features/camera/gauss_formula_ocr_backend_client_q389r2.dart'), 'backend client must not exist');

const capture = read('lib/features/camera/gauss_camera_capture_shell.dart');
check(capture.includes('installDeviceOnlyFormulaOcrBundleQ389R3Offline') || capture.includes('installDeviceOnlyFormulaOcrBundleQ389R4Offline'), 'camera Modeli indir path must use Q389R3 offline installer or Q389R4 successor');
check(!capture.includes('backgroundColor: MathProColors.bg,\n      backgroundColor: MathProColors.bg'), 'camera shell must not contain duplicate backgroundColor argument');

const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
check(manager.includes('installDeviceOnlyFormulaOcrBundleQ389R3Offline') && manager.includes('installDeviceOnlyFormulaOcrBundleQ389R4Offline'), 'manager must expose Q389R3 offline installer and Q389R4 successor');
check(manager.includes('installDeviceOnlyFormulaOcrBundleQ389R2Offline') && (manager.includes('return installDeviceOnlyFormulaOcrBundleQ389R3Offline') || manager.includes('return installDeviceOnlyFormulaOcrBundleQ389R4Offline')), 'Q389R2 compatibility alias must forward to Q389R3 or Q389R4 successor');

const bundle = read('lib/features/camera/gauss_device_only_formula_ocr_bundle_q389r2_offline.dart');
for (const marker of [
  'GaussDeviceOnlyFormulaOcrBundleQ389R3OfflinePolicy',
  'V172-Q389R3_OFFLINE-REAL-MODEL-ARTIFACT-DOWNLOAD-BINDING',
  'backendAllowed = false',
  'mlKitAllowed = false',
  'textOcrFallbackAllowed = false',
  'fakeLatexCandidateAllowed = false',
  'modelDownloadButtonMustInstallCompleteBundle = true',
  'offlineAfterVerifiedInstallRequired = true',
]) check(bundle.includes(marker), `bundle contract missing ${marker}`);

const main = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
check(main.includes('!(paddleInferenceDirectoryReady || q387PaddleLiteNbModelReady)'), 'native blocked reason must accept verified .nb readiness');
check(main.includes('q389r3-offline-formula-ocr-artifact-not-ready') || main.includes('q389r4-offline-formula-ocr-production-bundle-not-ready'), 'native must expose Q389R3 artifact-not-ready blocked reason or Q389R4 successor');
check(main.includes('q389r3-offline-formula-ocr-model-source-path-missing') || main.includes('q389r4-offline-formula-ocr-production-bundle-source-missing'), 'native must expose Q389R3 source-path blocked reason or Q389R4 successor');
check(main.includes('"PP-FormulaNet_plus / Paddle Lite"'), 'native engine label must use PP-FormulaNet_plus');
check(main.includes('"tokenizer.json"') && main.includes('"formula_tokenizer.json"'), 'native decoder sidecar list must include tokenizer JSON names');
check(main.includes('setModelFromFile'), 'native must keep Paddle Lite .nb setModelFromFile path');
check(main.includes('q387R1ValidateNbManifestEvidence'), 'native must validate .nb manifest evidence');

const q378 = read('lib/features/camera/gauss_real_camera_ocr_user_flow_binding_q378.dart');
check(q378.includes('backend/endpoint image upload is forbidden'), 'Q378 must remain backend-free');
check(!q378.includes('FormulaOcrBackendClient'), 'Q378 must not call backend client');

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
check(['V172-Q389R3_OFFLINE','V172-Q389R4_OFFLINE','V172-Q389R5A_OFFLINE'].includes(manifest.cameraOcrFormulaOcrPrimaryEngineLatestPhase), 'manifest latest phase must be Q389R3_OFFLINE, Q389R4, or Q389R5A successor');
const entry = manifest.v172Q389R3OfflineRealModelArtifactDownloadBinding;
check(entry?.backendAllowed === false && entry?.mlKitAllowed === false && entry?.textOcrFallbackAllowed === false, 'manifest must keep backend/MLKit/text fallback disabled');
const successor = manifest.v172Q389R4OfflineProductionBundleCompletenessClosure;
if (['V172-Q389R4_OFFLINE', 'V172-Q389R5A_OFFLINE'].includes(manifest.cameraOcrFormulaOcrPrimaryEngineLatestPhase)) {
  check(successor?.backendAllowed === false && successor?.mlKitAllowed === false && successor?.textOcrFallbackAllowed === false, 'Q389R4 successor must preserve backend/MLKit/text fallback disabled');
}
check(entry?.modelDownloadButtonInstallsCompleteBundle === true && entry?.offlineAfterVerifiedInstallRequired === true, 'manifest must record complete bundle/offline-after-install contract');
check(entry?.keyboardQ382Touched === false && entry?.graphHistorySolutionSolverTouched === false, 'manifest must record protected surfaces untouched');

for (const forbidden of ['com.google.mlkit', 'TextRecognition.getClient', 'MATHPRO_FORMULA_OCR_ENDPOINT', 'FormulaOcrBackendClient']) {
  const hits = [];
  const walk = (dir) => {
    for (const name of fs.readdirSync(dir)) {
      const full = path.join(dir, name);
      const rel = path.relative(root, full).replace(/\\/g, '/');
      if (rel.startsWith('build/') || rel.startsWith('.dart_tool/') || rel.startsWith('tool/verify_')) continue;
      const st = fs.statSync(full);
      if (st.isDirectory()) walk(full);
      else if (/\.(dart|kt|gradle|json|md|yaml|yml|mjs|py)$/.test(name)) {
        const t = fs.readFileSync(full, 'utf8');
        if (t.includes(forbidden)) hits.push(rel);
      }
    }
  };
  walk(root);
  check(hits.length === 0, `forbidden marker ${forbidden} found in ${hits.join(', ')}`);
}

console.log('PASS verify_device_only_formula_ocr_real_artifact_binding_v172_q389r3_offline');
