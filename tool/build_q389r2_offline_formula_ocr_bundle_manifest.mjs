#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';

const args = process.argv.slice(2);
const get = (name) => {
  const index = args.indexOf(`--${name}`);
  if (index === -1 || index + 1 >= args.length) return '';
  return args[index + 1];
};
const required = (name) => {
  const value = get(name);
  if (!value) throw new Error(`Missing --${name}`);
  return value;
};
const sha256 = (file) => crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');
const modelDir = path.resolve(required('model-dir'));
const baseUrl = required('base-url').replace(/\/+$/, '');
const sourceRevision = required('source-revision');
const conversionProvenance = required('conversion-provenance');
const out = path.resolve(get('out') || 'tool/reports/q389r2_offline_formula_ocr_bundle_manifest.json');
if (!fs.existsSync(modelDir) || !fs.statSync(modelDir).isDirectory()) throw new Error(`model-dir not found: ${modelDir}`);
const entries = fs.readdirSync(modelDir).filter((name) => fs.statSync(path.join(modelDir, name)).isFile());
const nb = entries.find((name) => name.toLowerCase().endsWith('.nb'));
if (!nb) throw new Error('No .nb file found in model-dir');
const sidecarNames = new Set([
  'pp_formulanet_plus_l_vocab.txt', 'pp_formulanet_plus_l_tokens.txt',
  'pp_formulanet_plus_vocab.txt', 'pp_formulanet_plus_tokens.txt',
  'vocab.txt', 'tokens.txt', 'latex_vocab.txt', 'tokenizer.json', 'preprocess.json', 'model_metadata.json',
]);
const files = [];
for (const name of entries) {
  if (name.startsWith('.')) continue;
  if (name !== nb && !sidecarNames.has(name)) continue;
  const file = path.join(modelDir, name);
  const role = name === nb ? 'paddle-lite-nb-model' : (name.includes('vocab') || name.includes('token') ? 'decoder-vocabulary' : 'runtime-metadata');
  files.push({
    role,
    fileName: name,
    downloadUrl: `${baseUrl}/${encodeURIComponent(name)}`,
    sha256: sha256(file),
    sizeBytes: fs.statSync(file).size,
    required: name === nb || role === 'decoder-vocabulary',
  });
}
const manifest = {
  phase: 'V172-Q389R2_OFFLINE-DEVICE-ONLY-FORMULA-OCR-FULL-CLOSURE',
  modelId: 'pp_formulanet_plus_device_only',
  modelDisplayName: 'PP-FormulaNet_plus offline formula OCR',
  sourceRevision,
  conversionProvenance,
  files,
  backendAllowed: false,
  mlKitAllowed: false,
  textOcrFallbackAllowed: false,
  modelBundledInBaseApp: false,
};
fs.mkdirSync(path.dirname(out), {recursive: true});
fs.writeFileSync(out, `${JSON.stringify(manifest, null, 2)}\n`);
console.log(`Wrote ${out}`);
