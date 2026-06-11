#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const fail = (m) => { console.error(`FAIL verify_q389r5b_offline_dependency_acquisition: ${m}`); process.exit(1); };
const check = (c,m) => { if(!c) fail(m); };
const root = process.cwd();
const exists = (p) => fs.existsSync(path.join(root,p));
const read = (p) => fs.readFileSync(path.join(root,p),'utf8');

check(exists('tool/q389r5b_acquire_offline_formula_ocr_prerequisites.ps1'), 'Q389R5B acquisition PowerShell script missing');
const ps = read('tool/q389r5b_acquire_offline_formula_ocr_prerequisites.ps1');
for (const marker of [
  'PaddlePaddle/PP-FormulaNet_plus-L',
  'huggingface_hub',
  'snapshot_download',
  'paddle_lite_opt',
  'q389r5a_offline_formula_ocr_bundle_factory.ps1',
  'q389r5b_offline_prerequisites_report.json',
  'backendAllowed=$false',
  'mlKitAllowed=$false',
  'textOcrFallbackAllowed=$false',
]) check(ps.includes(marker), `acquisition script missing marker: ${marker}`);
check(!ps.includes('google_mlkit'), 'ML Kit marker must not be reintroduced');
check(!ps.includes('FastAPI') && !ps.includes('backend/formula_ocr_service'), 'backend marker must not be reintroduced');
check(exists('docs/audit/V172_Q389R5B_OFFLINE_DEPENDENCY_ACQUISITION.md'), 'Q389R5B audit doc missing');
check(exists('docs/audit/V172_Q389R5B_CHANGED_FILES.md'), 'Q389R5B changed files doc missing');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
check(manifest.v172Q389R5BOfflineDependencyAcquisition, 'manifest Q389R5B entry missing');
check(manifest.v172Q389R5BOfflineDependencyAcquisition.backendAllowed === false, 'backend must remain forbidden');
check(manifest.v172Q389R5BOfflineDependencyAcquisition.mlKitAllowed === false, 'ML Kit must remain forbidden');
check(manifest.v172Q389R5BOfflineDependencyAcquisition.modelBundledInBaseApp === false, 'model bundling must remain forbidden');
check(manifest.v172Q389R5BOfflineDependencyAcquisition.acquisitionScript === 'tool/q389r5b_acquire_offline_formula_ocr_prerequisites.ps1', 'acquisition script manifest pointer mismatch');
const forbidden = [];
const walk = (dir) => {
  for (const name of fs.readdirSync(dir)) {
    const p = path.join(dir,name); const rel = path.relative(root,p).replaceAll('\\','/');
    const st = fs.statSync(p);
    if (st.isDirectory()) { if (!['.dart_tool','build','.git'].includes(name)) walk(p); continue; }
    if (/\.(nb|onnx|pdmodel|pdiparams|tflite|apk|aab|zip)$/i.test(name)) forbidden.push(rel);
  }
};
walk(root);
check(forbidden.length === 0, `forbidden model/release artifacts in project: ${forbidden.join(', ')}`);
console.log('PASS verify_q389r5b_offline_dependency_acquisition');
