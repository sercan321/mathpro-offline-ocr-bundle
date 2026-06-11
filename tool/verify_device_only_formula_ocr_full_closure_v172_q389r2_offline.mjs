#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_device_only_formula_ocr_full_closure_v172_q389r2_offline: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };
check(!exists('backend'), 'backend directory must not be present in offline-only package');
check(!exists('lib/features/camera/gauss_formula_ocr_backend_client_q389r2.dart'), 'backend client must be removed');
const q378 = read('lib/features/camera/gauss_real_camera_ocr_user_flow_binding_q378.dart');
check(!q378.includes('GaussFormulaOcrBackendClientQ389R2'), 'Q378 must not call backend client');
check(q378.includes('backend/endpoint image upload is forbidden'), 'Q378 must document offline-only camera flow');
const policy = read('lib/features/camera/gauss_real_camera_ocr_user_flow_binding_q378_policy.dart');
check(policy.includes('q389R2FormulaOcrBackendFirst = false'), 'Q378 policy must disable backend-first path');
check(policy.includes('q389R2DeviceOnlyFormulaOcrPrimary = true'), 'Q378 policy must enable device-only formula OCR primary');
const worker = read('lib/features/camera/gauss_device_only_formula_ocr_bundle_q389r2_offline.dart');
for (const marker of [
  'DEVICE_ONLY_FORMULA_OCR_BUNDLE_INSTALLER_READY_PRODUCTION_BUNDLE_SOURCE_REQUIRED',
  'backendAllowed = false',
  'mlKitAllowed = false',
  'textOcrFallbackAllowed = false',
  'fakeLatexCandidateAllowed = false',
  'installProductionBundle',
  'q387r1_paddle_lite_nb_manifest.json',
]) check(worker.includes(marker), `offline worker missing ${marker}`);
const capture = read('lib/features/camera/gauss_camera_capture_shell.dart');
check(capture.includes('installDeviceOnlyFormulaOcrBundleQ389R4Offline') || capture.includes('installDeviceOnlyFormulaOcrBundleQ389R3Offline') || capture.includes('installDeviceOnlyFormulaOcrBundleQ389R2Offline'), 'Modeli indir must use Q389R2/Q389R3/Q389R4 offline bundle installer');
const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
check(manager.includes('installDeviceOnlyFormulaOcrBundleQ389R2Offline'), 'manager must expose Q389R2 offline installer');
const main = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
check(main.includes('(paddleInferenceDirectoryReady || q387PaddleLiteNbModelReady)'), 'native bridge must allow verified .nb path without legacy inference directory');
check(main.includes('pp_formulanet_plus_l_vocab.txt'), 'native decoder must know plus-L vocabulary sidecar names');
check(main.includes('JSONArray'), 'native decoder must support JSON/array vocab formats');
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
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
check(['V172-Q389R2_OFFLINE','V172-Q389R3_OFFLINE','V172-Q389R4_OFFLINE','V172-Q389R5A_OFFLINE'].includes(manifest.cameraOcrFormulaOcrPrimaryEngineLatestPhase), 'manifest latest phase must be Q389R2_OFFLINE, Q389R3_OFFLINE, Q389R4_OFFLINE, or Q389R5A_OFFLINE successor');
const entry = manifest.v172Q389R2OfflineDeviceOnlyFormulaOcrFullClosure;
check(entry?.backendAllowed === false && entry?.mlKitAllowed === false && entry?.textOcrFallbackAllowed === false, 'manifest must record backend/mlkit/text fallback disabled');
check(entry?.modelBinaryBundledInBaseApp === false && entry?.fakeLatexCandidateAllowed === false, 'manifest must block bundled model and fake candidate');
check(entry?.offlineAfterInstallRequired === true, 'manifest must require offline-after-install behavior');
console.log('PASS verify_device_only_formula_ocr_full_closure_v172_q389r2_offline');
