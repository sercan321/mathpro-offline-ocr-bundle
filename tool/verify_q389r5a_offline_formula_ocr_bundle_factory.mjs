#!/usr/bin/env node
import fs from 'fs';
import os from 'os';
import path from 'path';
import crypto from 'crypto';
import {spawnSync} from 'child_process';

const fail = (m) => { console.error(`FAIL verify_q389r5a_offline_formula_ocr_bundle_factory: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };
const read = (p) => fs.readFileSync(p, 'utf8');
const exists = (p) => fs.existsSync(p);
const sha256 = (file) => crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');

check(exists('tool/q389r5a_offline_formula_ocr_bundle_factory.mjs'), 'Q389R5A node factory missing');
check(exists('tool/q389r5a_offline_formula_ocr_bundle_factory.ps1'), 'Q389R5A PowerShell factory wrapper missing');
check(exists('docs/audit/V172_Q389R5A_OFFLINE_MODEL_BUNDLE_FACTORY.md'), 'Q389R5A audit doc missing');
check(exists('docs/audit/V172_Q389R5A_CHANGED_FILES.md'), 'Q389R5A changed-files doc missing');

const factory = read('tool/q389r5a_offline_formula_ocr_bundle_factory.mjs');
for (const marker of [
  'V172-Q389R5A_OFFLINE-MODEL-BUNDLE-FACTORY',
  '--model_file=',
  '--param_file=',
  '--optimize_out=',
  '--optimize_out_type=',
  '--valid_targets=',
  'q389r5_offline_formula_ocr_production_manifest.json',
  'requiresDecoderSidecar',
  'requiresPreprocessMetadata',
  'backendAllowed: false',
  'mlKitAllowed: false',
  'textOcrFallbackAllowed: false',
]) {
  check(factory.includes(marker), `factory missing marker: ${marker}`);
}
check(!factory.includes('google_mlkit'), 'factory must not reference google_mlkit');
check(!factory.includes('formula_ocr_service'), 'factory must not reference backend service');

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
check(manifest.cameraOcrFormulaOcrPrimaryEngineLatestPhase === 'V172-Q389R5A_OFFLINE', 'manifest latest phase must be Q389R5A_OFFLINE');
const entry = manifest.v172Q389R5AOfflineModelBundleFactory;
check(entry?.phase === 'V172-Q389R5A_OFFLINE', 'manifest Q389R5A entry missing');
check(entry.backendAllowed === false && entry.mlKitAllowed === false && entry.textOcrFallbackAllowed === false, 'Q389R5A entry must keep backend/MLKit/text fallback disabled');
check(entry.ocrPassClaimedByPackage === false && entry.androidRealDevicePassClaimedByPackage === false, 'Q389R5A must not claim OCR/device PASS');

const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'mathpro-q389r5a-'));
try {
  const nb = path.join(tmp, 'fake.nb');
  fs.writeFileSync(nb, Buffer.alloc(1024 * 1024 + 17, 7));
  const sidecar = path.join(tmp, 'sidecars');
  fs.mkdirSync(sidecar);
  fs.writeFileSync(path.join(sidecar, 'tokenizer.json'), JSON.stringify({tokens: ['\\int', 'x', '^', '2']}, null, 2));
  fs.writeFileSync(path.join(sidecar, 'preprocess_metadata.json'), JSON.stringify({imageShape: [1, 3, 384, 384], note: 'factory smoke metadata only'}, null, 2));
  const out = path.join(tmp, 'out');
  const result = spawnSync(process.execPath, [
    'tool/q389r5a_offline_formula_ocr_bundle_factory.mjs',
    '--prebuilt-nb', nb,
    '--sidecar-dir', sidecar,
    '--out-dir', out,
    '--base-url', 'https://example.com/mathpro/q389r5a',
    '--source-revision', 'verifier-smoke-revision',
    '--conversion-provenance', 'verifier smoke run; not production OCR evidence',
  ], {encoding: 'utf8'});
  if (result.status !== 0) {
    console.error(result.stdout);
    console.error(result.stderr);
    fail('factory prebuilt-nb smoke run failed');
  }
  const producedManifest = path.join(out, 'bundle', 'q389r5_offline_formula_ocr_production_manifest.json');
  check(exists(producedManifest), 'factory smoke did not create production manifest');
  const produced = JSON.parse(read(producedManifest));
  check(produced.manifestFormatVersion === 'q389r4-offline-bundle-manifest-v1', 'factory manifest must remain app-compatible with Q389R4 format');
  check(produced.phase === 'V172-Q389R5A_OFFLINE-MODEL-BUNDLE-FACTORY', 'factory manifest phase mismatch');
  check(produced.files.some((f) => f.role === 'paddle-lite-nb-model' && f.sha256 === sha256(path.join(out, 'bundle', 'pp_formulanet_plus_android_arm64.nb'))), 'factory manifest missing verified nb entry');
  check(produced.files.some((f) => /decoder|token|vocab/.test(f.role)), 'factory manifest missing decoder sidecar');
  check(produced.files.some((f) => /preprocess|metadata/.test(f.role)), 'factory manifest missing preprocess sidecar');
} finally {
  fs.rmSync(tmp, {recursive: true, force: true});
}

const forbiddenProjectArtifacts = [];
function walk(dir) {
  for (const name of fs.readdirSync(dir)) {
    const full = path.join(dir, name);
    const rel = path.relative(process.cwd(), full).replaceAll('\\', '/');
    if (rel.startsWith('build/') || rel.startsWith('.dart_tool/')) continue;
    const st = fs.statSync(full);
    if (st.isDirectory()) walk(full);
    else if (/\.(nb|onnx|pdmodel|pdiparams|tflite|apk|aab)$/i.test(name)) forbiddenProjectArtifacts.push(rel);
  }
}
walk(process.cwd());
check(forbiddenProjectArtifacts.length === 0, `project must not contain bundled model/release artifacts: ${forbiddenProjectArtifacts.join(', ')}`);

console.log('PASS verify_q389r5a_offline_formula_ocr_bundle_factory');
