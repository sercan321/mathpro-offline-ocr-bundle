#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const fail = (m) => { console.error(`FAIL verify_q389r5c_offline_test_regression_and_cloud_bundle_pipeline: ${m}`); process.exit(1); };
const check = (condition, message) => { if (!condition) fail(message); };
const read = (p) => fs.readFileSync(p, 'utf8');
const exists = (p) => fs.existsSync(p);
const json = (p) => JSON.parse(read(p));

const workflowPath = '.github/workflows/q389r5c_offline_formula_ocr_bundle.yml';
check(exists(workflowPath), 'Q389R5C workflow missing');
const workflow = read(workflowPath);
check(workflow.includes('PaddlePaddle/PP-FormulaNet_plus-L'), 'workflow must default to PP-FormulaNet_plus-L');
check(workflow.includes('snapshot_download'), 'workflow must use Hugging Face snapshot_download');
check(workflow.includes('api.github.com/repos/PaddlePaddle/Paddle-Lite/releases/latest'), 'workflow must auto-discover Paddle-Lite release assets');
check(workflow.includes('paddle_lite_opt_url'), 'workflow must provide explicit paddle_lite_opt override input');
check(workflow.includes('tool/q389r5a_offline_formula_ocr_bundle_factory.mjs'), 'workflow must reuse Q389R5A bundle factory');
check(workflow.includes('actions/upload-artifact@v4'), 'workflow must upload bundle artifact');
check(workflow.includes('softprops/action-gh-release@v2'), 'workflow must optionally publish release files');
check(workflow.includes('backendAllowed') && workflow.includes('False'), 'workflow evidence must keep backend forbidden');
check(workflow.includes('mlKitAllowed') && workflow.includes('False'), 'workflow evidence must keep ML Kit forbidden');
check(!workflow.includes('fastapi') && !workflow.includes('uvicorn') && !workflow.includes('mlkit'), 'workflow must not reintroduce backend/ML Kit path');

const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
check(manager.includes('ana model dosyası SHA256'), 'ready product copy must preserve Q385R2 primary SHA wording');
check(manager.includes('PP-FormulaNet_plus'), 'manager must remain on FormulaNet_plus successor family');
check(!manager.includes('ML Kit') || manager.includes('fallback yoktur'), 'manager must not reintroduce ML Kit fallback');

const q327 = read('test/v172_q327_native_library_source_package_approval_abi_matrix_lock_test.dart');
const q328 = read('test/v172_q328_native_library_package_file_hash_intake_no_bundle_evidence_gate_test.dart');
const q347 = read('test/v172_q347_paddle_lite_predictor_instantiate_smoke_test.dart');
for (const [name, text] of [['q327', q327], ['q328', q328], ['q347', q347]]) {
  check(!text.includes("isNot(contains('MobileConfig'))"), `${name} must not hard-forbid successor MobileConfig evidence strings`);
  check(text.includes("isNot(contains('MobileConfig('))"), `${name} must still forbid direct MobileConfig constructor usage`);
  check(text.includes("isNot(contains('PaddlePredictor('))"), `${name} must still forbid direct PaddlePredictor constructor usage`);
}

const q384r1 = read('test/v172_q384r1_camera_ocr_deferred_model_download_activation_test.dart');
const q384r2 = read('test/v172_q384r2_camera_ocr_runtime_model_format_binding_preflight_test.dart');
check(q384r1.includes("contains('plus')"), 'Q384R1 test must be successor-aware for PP-FormulaNet_plus manifest');
check(q384r2.includes("contains('plus')"), 'Q384R2 test must be successor-aware for PP-FormulaNet_plus manifest');
check(q384r1.includes('productionPaddleLiteNbAcquiredForAndroidRuntime, isFalse'), 'Q384R1 test must not claim nb acquired');
check(q384r2.includes('productionPaddleLiteNbAcquiredForAndroidRuntime, isFalse'), 'Q384R2 test must not claim nb acquired');

const q387r7e = read('test/v172_q387r7e_paddle_lite_nb_flutter_test_legacy_nb_marker_repair_test.dart');
check(q387r7e.includes('projectRoot'), 'Q387R7E must normalize relative paths before build exclusion');
check(q387r7e.includes("replaceAll('\\\\', '/')"), 'Q387R7E must normalize Windows path separators');
check(q387r7e.includes("!path.startsWith('build/')"), 'Q387R7E must exclude Flutter build directory');
check(q387r7e.includes("AssetManifest.bin") === false, 'Q387R7E must not whitelist one file by name; it must fix path normalization');

const manifest = json('assets/mathlive/manifest.json');
const entry = manifest.v172Q389R5COfflineCloudModelBundleBuilder;
check(Boolean(entry), 'manifest Q389R5C entry missing');
check(entry.phase === 'V172-Q389R5C_OFFLINE', 'manifest Q389R5C phase mismatch');
check(entry.workflow === workflowPath, 'manifest workflow pointer mismatch');
check(entry.defaultModelId === 'PaddlePaddle/PP-FormulaNet_plus-L', 'manifest default model mismatch');
check(entry.usesQ389R5ABundleFactory === true, 'manifest must state Q389R5A factory reuse');
for (const key of ['backendAllowed', 'mlKitAllowed', 'textOcrFallbackAllowed', 'modelBundledInBaseApp', 'fakeLatexCandidateAllowed', 'ocrPassClaimedByPackage', 'androidRealDevicePassClaimedByPackage', 'flutterAnalyzePassClaimedByPackage', 'flutterTestPassClaimedByPackage']) {
  check(entry[key] === false, `manifest ${key} must be false`);
}

check(exists('docs/audit/V172_Q389R5C_OFFLINE_CLOUD_MODEL_BUNDLE_BUILDER.md'), 'Q389R5C audit doc missing');
check(exists('docs/audit/V172_Q389R5C_CHANGED_FILES.md'), 'Q389R5C changed files doc missing');
const readme = read('README.md');
check(readme.includes('V172-Q389R5C'), 'README Q389R5C section missing');
check(readme.includes('flutter analyze') && readme.includes('flutter test'), 'README must include local Flutter hygiene commands');

console.log('PASS verify_q389r5c_offline_test_regression_and_cloud_bundle_pipeline');
