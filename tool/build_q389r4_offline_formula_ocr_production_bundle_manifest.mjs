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
  const value = get(name).trim();
  if (!value) throw new Error(`Missing --${name}`);
  return value;
};
const sha256 = (file) => crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');
const safeFileName = (name) => name && !name.includes('/') && !name.includes('\\') && !name.includes('..') && name !== '.' && name !== '..';
const roleFor = (name, nbName) => {
  const lower = name.toLowerCase();
  if (name === nbName) return 'paddle-lite-nb-model';
  if (lower.includes('tokenizer') || lower.includes('token') || lower.includes('vocab')) return 'decoder-tokenizer-vocabulary';
  if (lower.includes('preprocess') || lower.includes('shape') || lower.includes('metadata') || lower.includes('config')) return 'preprocess-metadata';
  return 'runtime-sidecar';
};
const isDecoder = (name) => /tokenizer|tokens?|vocab/i.test(name);
const isPreprocess = (name) => /preprocess|shape|metadata|config/i.test(name);

const modelDir = path.resolve(required('model-dir'));
const baseUrl = required('base-url').replace(/\/+$/, '');
const sourceRevision = required('source-revision');
const conversionProvenance = required('conversion-provenance');
const modelId = get('model-id') || 'pp_formulanet_plus_device_only';
const modelDisplayName = get('model-display-name') || 'PP-FormulaNet_plus offline formula OCR';
const out = path.resolve(get('out') || 'tool/reports/q389r4_offline_formula_ocr_production_bundle_manifest.json');

if (!/^https:\/\//.test(baseUrl)) throw new Error('--base-url must be HTTPS');
if (!/formulanet/i.test(modelId) && !/formulanet/i.test(modelDisplayName)) {
  throw new Error('model-id or model-display-name must identify a FormulaNet model family');
}
if (!fs.existsSync(modelDir) || !fs.statSync(modelDir).isDirectory()) throw new Error(`model-dir not found: ${modelDir}`);
const entries = fs.readdirSync(modelDir).filter((name) => fs.statSync(path.join(modelDir, name)).isFile() && !name.startsWith('.'));
for (const name of entries) {
  if (!safeFileName(name)) throw new Error(`unsafe file name rejected: ${name}`);
}
const nb = entries.find((name) => name.toLowerCase().endsWith('.nb'));
if (!nb) throw new Error('No .nb file found in model-dir');
const decoderEntries = entries.filter(isDecoder);
const preprocessEntries = entries.filter(isPreprocess);
if (decoderEntries.length === 0) throw new Error('No decoder/tokenizer/vocab sidecar found in model-dir');
if (preprocessEntries.length === 0) throw new Error('No preprocess/shape/metadata sidecar found in model-dir');

const accepted = entries.filter((name) => name === nb || isDecoder(name) || isPreprocess(name));
const files = accepted.map((name) => {
  const file = path.join(modelDir, name);
  const role = roleFor(name, nb);
  return {
    role,
    fileName: name,
    downloadUrl: `${baseUrl}/${encodeURIComponent(name)}`,
    sha256: sha256(file),
    sizeBytes: fs.statSync(file).size,
    required: true,
  };
});
const manifest = {
  phase: 'V172-Q389R4_OFFLINE-PRODUCTION-BUNDLE-COMPLETENESS-CLOSURE',
  manifestFormatVersion: 'q389r4-offline-bundle-manifest-v1',
  modelId,
  modelDisplayName,
  sourceRevision,
  conversionProvenance,
  files,
  requiredContracts: {
    backendAllowed: false,
    mlKitAllowed: false,
    textOcrFallbackAllowed: false,
    modelBundledInBaseApp: false,
    fakeLatexCandidateAllowed: false,
    requiresNbModel: true,
    requiresDecoderSidecar: true,
    requiresPreprocessMetadata: true,
    requiresExactSha256: true,
    requiresExactSizeBytes: true,
    offlineAfterVerifiedInstallRequired: true,
  },
  backendAllowed: false,
  mlKitAllowed: false,
  textOcrFallbackAllowed: false,
  modelBundledInBaseApp: false,
};
fs.mkdirSync(path.dirname(out), {recursive: true});
fs.writeFileSync(out, `${JSON.stringify(manifest, null, 2)}\n`);
console.log(`Wrote ${out}`);
console.log(`Files: ${files.map((f) => `${f.role}:${f.fileName}`).join(', ')}`);
