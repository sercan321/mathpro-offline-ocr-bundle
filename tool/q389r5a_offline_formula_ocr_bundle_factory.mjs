#!/usr/bin/env node
import fs from 'fs';
import os from 'os';
import path from 'path';
import crypto from 'crypto';
import {spawnSync} from 'child_process';

const PHASE = 'V172-Q389R5A_OFFLINE-MODEL-BUNDLE-FACTORY';
const MANIFEST_FORMAT = 'q389r4-offline-bundle-manifest-v1';
const DEFAULT_NB_NAME = 'pp_formulanet_plus_android_arm64.nb';
const MIN_NB_BYTES = 1024 * 1024;

function parseArgs(argv) {
  const parsed = { include: [], extraPaddleLiteArgs: [] };
  for (let i = 0; i < argv.length; i += 1) {
    const raw = argv[i];
    if (!raw.startsWith('--')) continue;
    const eq = raw.indexOf('=');
    let key;
    let value;
    if (eq !== -1) {
      key = raw.slice(2, eq);
      value = raw.slice(eq + 1);
    } else {
      key = raw.slice(2);
      value = argv[i + 1]?.startsWith('--') || argv[i + 1] == null ? 'true' : argv[++i];
    }
    if (key === 'include') parsed.include.push(value);
    else if (key === 'extra-paddle-lite-arg') parsed.extraPaddleLiteArgs.push(value);
    else parsed[key] = value;
  }
  return parsed;
}

const args = parseArgs(process.argv.slice(2));
const get = (name, fallback = '') => `${args[name] ?? fallback}`.trim();
const required = (name) => {
  const value = get(name);
  if (!value) throw new Error(`Missing --${name}`);
  return value;
};
const bool = (name) => ['true', '1', 'yes', 'y'].includes(get(name).toLowerCase());
const safeFileName = (name) => Boolean(name) && !name.includes('/') && !name.includes('\\') && !name.includes('..') && name !== '.' && name !== '..';
const sha256 = (file) => crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');
const ensureDir = (dir) => fs.mkdirSync(dir, {recursive: true});
const copy = (src, dst) => {
  ensureDir(path.dirname(dst));
  fs.copyFileSync(src, dst);
};
const statSize = (file) => fs.statSync(file).size;
const writeJson = (file, data) => {
  ensureDir(path.dirname(file));
  fs.writeFileSync(file, `${JSON.stringify(data, null, 2)}\n`);
};
const findFirst = (dir, names) => {
  for (const name of names) {
    const file = path.join(dir, name);
    if (fs.existsSync(file) && fs.statSync(file).isFile()) return file;
  }
  return '';
};
const collectFiles = (roots) => {
  const out = [];
  for (const root of roots.filter(Boolean)) {
    const resolved = path.resolve(root);
    if (!fs.existsSync(resolved)) continue;
    const st = fs.statSync(resolved);
    if (st.isFile()) out.push(resolved);
    if (st.isDirectory()) {
      for (const name of fs.readdirSync(resolved)) {
        const file = path.join(resolved, name);
        if (fs.statSync(file).isFile() && !name.startsWith('.')) out.push(file);
      }
    }
  }
  return out;
};
const isDecoderSidecar = (file) => /tokenizer|tokens?|vocab|dict|latex/i.test(path.basename(file));
const isPreprocessSidecar = (file) => /preprocess|shape|metadata|config|inference\.(yml|yaml|json)|pipeline/i.test(path.basename(file));
const roleFor = (fileName) => {
  const lower = fileName.toLowerCase();
  if (lower.endsWith('.nb')) return 'paddle-lite-nb-model';
  if (/tokenizer|tokens?|vocab|dict|latex/.test(lower)) return 'decoder-tokenizer-vocabulary';
  if (/preprocess|shape|metadata|config|inference\.(yml|yaml|json)|pipeline/.test(lower)) return 'preprocess-metadata';
  return 'runtime-sidecar';
};
const help = () => `
${PHASE}

Creates the production upload directory expected by the MathPro offline Formula OCR installer.
It does NOT fake OCR output and it does NOT bundle model bytes into the Flutter APK/ZIP.

Required common args:
  --out-dir <directory>
  --base-url <https directory URL where the generated bundle files will be hosted>
  --source-revision <immutable official model revision/tag/commit>
  --conversion-provenance <who/where/how conversion was produced>

Conversion mode:
  --source-dir <official Paddle inference model directory>
  --paddle-lite-opt <path to paddle_lite_opt or paddle_lite_opt.exe>

Prebuilt mode:
  --prebuilt-nb <already converted .nb file>

Sidecar args:
  --sidecar-dir <directory containing tokenizer/vocab/preprocess metadata>
  --decoder-sidecar <tokenizer/vocab/tokens file>
  --preprocess-sidecar <preprocess/shape/metadata file>
  --include <extra required sidecar file>          (repeatable)

Optional:
  --nb-name ${DEFAULT_NB_NAME}
  --model-id pp_formulanet_plus_l_device_only
  --model-display-name "PP-FormulaNet_plus-L offline formula OCR"
  --valid-targets arm
  --optimize-out-type naive_buffer
  --extra-paddle-lite-arg <arg>                   (repeatable)

Examples are documented in docs/audit/V172_Q389R5A_OFFLINE_MODEL_BUNDLE_FACTORY.md
`;

if (bool('help') || bool('h')) {
  console.log(help());
  process.exit(0);
}

const outDir = path.resolve(required('out-dir'));
const bundleDir = path.join(outDir, 'bundle');
const reportsDir = path.join(outDir, 'reports');
const conversionDir = path.join(outDir, 'conversion');
const baseUrl = required('base-url').replace(/\/+$/, '');
const sourceRevision = required('source-revision');
const conversionProvenance = required('conversion-provenance');
const nbName = get('nb-name', DEFAULT_NB_NAME);
const modelId = get('model-id', 'pp_formulanet_plus_l_device_only');
const modelDisplayName = get('model-display-name', 'PP-FormulaNet_plus-L offline formula OCR');

if (!/^https:\/\//.test(baseUrl)) throw new Error('--base-url must be HTTPS');
if (!safeFileName(nbName) || !nbName.toLowerCase().endsWith('.nb')) throw new Error(`unsafe or non-.nb --nb-name: ${nbName}`);
if (!/formulanet/i.test(modelId) && !/formulanet/i.test(modelDisplayName)) throw new Error('model-id or model-display-name must identify FormulaNet');
ensureDir(bundleDir);
ensureDir(reportsDir);
ensureDir(conversionDir);

let nbSource = '';
const prebuiltNb = get('prebuilt-nb');
if (prebuiltNb) {
  nbSource = path.resolve(prebuiltNb);
  if (!fs.existsSync(nbSource) || !fs.statSync(nbSource).isFile()) throw new Error(`--prebuilt-nb not found: ${nbSource}`);
} else {
  const sourceDir = path.resolve(required('source-dir'));
  const paddleLiteOpt = path.resolve(required('paddle-lite-opt'));
  if (!fs.existsSync(sourceDir) || !fs.statSync(sourceDir).isDirectory()) throw new Error(`--source-dir not found: ${sourceDir}`);
  if (!fs.existsSync(paddleLiteOpt) || !fs.statSync(paddleLiteOpt).isFile()) throw new Error(`--paddle-lite-opt not found: ${paddleLiteOpt}`);
  const modelFile = findFirst(sourceDir, ['inference.pdmodel', 'model.pdmodel', 'model.pdmodel', '__model__']);
  const paramFile = findFirst(sourceDir, ['inference.pdiparams', 'model.pdiparams', 'params.pdiparams']);
  if (!modelFile || !paramFile) {
    throw new Error(`source-dir must contain inference.pdmodel/model.pdmodel and inference.pdiparams/model.pdiparams: ${sourceDir}`);
  }
  const optimizeBase = path.join(conversionDir, nbName.replace(/\.nb$/i, ''));
  const commandArgs = [
    `--model_file=${modelFile}`,
    `--param_file=${paramFile}`,
    `--optimize_out=${optimizeBase}`,
    `--optimize_out_type=${get('optimize-out-type', 'naive_buffer')}`,
    `--valid_targets=${get('valid-targets', 'arm')}`,
    ...args.extraPaddleLiteArgs,
  ];
  const startedAt = new Date().toISOString();
  const result = spawnSync(paddleLiteOpt, commandArgs, {encoding: 'utf8'});
  fs.writeFileSync(path.join(reportsDir, 'q389r5a_paddle_lite_opt_stdout.log'), result.stdout ?? '');
  fs.writeFileSync(path.join(reportsDir, 'q389r5a_paddle_lite_opt_stderr.log'), result.stderr ?? '');
  writeJson(path.join(reportsDir, 'q389r5a_paddle_lite_opt_command.json'), {
    phase: PHASE,
    startedAt,
    finishedAt: new Date().toISOString(),
    paddleLiteOpt,
    args: commandArgs,
    exitCode: result.status,
    signal: result.signal,
    conversionPassClaimed: result.status === 0,
  });
  if (result.status !== 0) throw new Error(`paddle_lite_opt failed with exit code ${result.status}; see ${reportsDir}`);
  const candidates = [optimizeBase, `${optimizeBase}.nb`, path.join(conversionDir, nbName)];
  nbSource = candidates.find((candidate) => fs.existsSync(candidate) && fs.statSync(candidate).isFile()) ?? '';
  if (!nbSource) throw new Error(`paddle_lite_opt did not produce .nb output. Checked: ${candidates.join(', ')}`);
}

if (statSize(nbSource) < MIN_NB_BYTES) throw new Error(`.nb is too small for production acceptance: ${statSize(nbSource)} bytes`);

const sourceDirForSidecars = get('source-dir') ? path.resolve(get('source-dir')) : '';
const sidecarRoots = [
  get('sidecar-dir') ? path.resolve(get('sidecar-dir')) : '',
  sourceDirForSidecars,
  path.dirname(nbSource),
];
let sidecars = collectFiles(sidecarRoots);
for (const key of ['decoder-sidecar', 'preprocess-sidecar']) {
  const value = get(key);
  if (value) sidecars.push(path.resolve(value));
}
sidecars.push(...args.include.map((item) => path.resolve(item)));
sidecars = Array.from(new Set(sidecars))
  .filter((file) => fs.existsSync(file) && fs.statSync(file).isFile())
  .filter((file) => path.resolve(file) !== path.resolve(nbSource))
  .filter((file) => isDecoderSidecar(file) || isPreprocessSidecar(file));

if (!sidecars.some(isDecoderSidecar)) throw new Error('No decoder/tokenizer/vocab sidecar found. Provide --decoder-sidecar or --sidecar-dir.');
if (!sidecars.some(isPreprocessSidecar)) throw new Error('No preprocess/shape/metadata sidecar found. Provide --preprocess-sidecar or --sidecar-dir.');

const bundleNb = path.join(bundleDir, nbName);
copy(nbSource, bundleNb);
const bundled = [bundleNb];
for (const file of sidecars) {
  const name = path.basename(file);
  if (!safeFileName(name)) throw new Error(`unsafe sidecar filename: ${name}`);
  const target = path.join(bundleDir, name);
  if (path.resolve(target) === path.resolve(bundleNb)) continue;
  copy(file, target);
  bundled.push(target);
}

const files = Array.from(new Set(bundled.map((file) => path.resolve(file)))).map((file) => {
  const fileName = path.basename(file);
  return {
    role: roleFor(fileName),
    fileName,
    downloadUrl: `${baseUrl}/${encodeURIComponent(fileName)}`,
    sha256: sha256(file),
    sizeBytes: statSize(file),
    required: true,
  };
});

const manifest = {
  phase: PHASE,
  appAcceptedManifestFormatVersion: MANIFEST_FORMAT,
  manifestFormatVersion: MANIFEST_FORMAT,
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
  generatedAtIso: new Date().toISOString(),
};

const manifestFile = path.join(bundleDir, 'q389r5_offline_formula_ocr_production_manifest.json');
writeJson(manifestFile, manifest);
writeJson(path.join(reportsDir, 'q389r5a_offline_formula_ocr_bundle_factory_report.json'), {
  phase: PHASE,
  status: 'BUNDLE_FACTORY_COMPLETED_UPLOAD_AND_APP_DART_DEFINE_STILL_REQUIRED',
  outDir,
  bundleDir,
  manifestFile,
  manifestUrlToUseInApp: `${baseUrl}/q389r5_offline_formula_ocr_production_manifest.json`,
  generatedFiles: fs.readdirSync(bundleDir).sort(),
  ocrPassClaimed: false,
  androidDevicePassClaimed: false,
  backendAllowed: false,
  mlKitAllowed: false,
  textOcrFallbackAllowed: false,
});
fs.writeFileSync(path.join(bundleDir, 'README_UPLOAD_Q389R5A.txt'), [
  'Q389R5A offline Formula OCR production bundle',
  '',
  'Upload every file in this directory to the HTTPS directory used as --base-url.',
  'Then run Flutter with:',
  `--dart-define=MATHPRO_OFFLINE_FORMULA_OCR_BUNDLE_MANIFEST_URL=${baseUrl}/q389r5_offline_formula_ocr_production_manifest.json`,
  '',
  'Do not modify file names, file bytes, SHA256 values, or sizeBytes after this manifest is generated.',
  'This bundle is for device-only offline Formula OCR after Modeli indir completes.',
  '',
].join('\n'));

console.log('PASS q389r5a_offline_formula_ocr_bundle_factory');
console.log(`Bundle directory: ${bundleDir}`);
console.log(`Manifest: ${manifestFile}`);
console.log(`App dart-define URL: ${baseUrl}/q389r5_offline_formula_ocr_production_manifest.json`);
