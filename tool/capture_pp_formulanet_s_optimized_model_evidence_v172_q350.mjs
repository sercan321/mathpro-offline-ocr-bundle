#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const phase = 'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE';
const intakeRoot = path.resolve(projectRoot, '..', 'MathProOcrArtifacts', 'PP-FormulaNet-S-PaddleLite-Optimized');
const verify = process.argv.includes('--verify') || process.argv.includes('--require-evidence');
function sha256(file) { return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex'); }
function walk(dir, out=[]) {
  if (!fs.existsSync(dir)) return out;
  for (const ent of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, ent.name);
    if (ent.isDirectory()) walk(full, out); else out.push(full);
  }
  return out;
}
const allFiles = walk(intakeRoot);
const modelExt = /\.(nb|pdmodel|pdiparams|pdparams|bin)$/i;
const logExt = /(^|[\/])(conversion|optimize|paddle_lite).*\.(txt|log|json)$/i;
const modelFiles = allFiles.filter(f => modelExt.test(f)).map(f => ({
  relativePath: path.relative(intakeRoot, f).replaceAll(path.sep, '/'),
  sizeBytes: fs.statSync(f).size,
  sha256: sha256(f),
}));
const logFiles = allFiles.filter(f => logExt.test(f) || path.basename(f).toLowerCase().includes('conversion')).map(f => ({
  relativePath: path.relative(intakeRoot, f).replaceAll(path.sep, '/'),
  sizeBytes: fs.statSync(f).size,
  sha256: sha256(f),
}));
const hasOptimizedModelArtifact = modelFiles.some(f => f.relativePath.toLowerCase().endsWith('.nb')) || modelFiles.length > 1;
const hasConversionLog = logFiles.length > 0;
const acceptedForModelLoad = false;
const evidence = {
  phase,
  sourcePhase: 'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED',
  intakeRoot,
  modelFiles,
  logFiles,
  hasOptimizedModelArtifact,
  hasConversionLog,
  acceptedForModelLoad,
  modelLoaderPathApproved: false,
  modelLoadAttempted: false,
  modelLoaded: false,
  note: 'Q350 captures optimized model/conversion evidence only. It does not bundle model files into the Flutter project and does not accept model-load/runtime use by itself.',
  capturedAt: new Date().toISOString(),
  projectRoot,
};
fs.mkdirSync(intakeRoot, { recursive: true });
const out = path.join(intakeRoot, 'q350_optimized_model_conversion_evidence.json');
fs.writeFileSync(out, JSON.stringify(evidence, null, 2));
console.log(JSON.stringify(evidence, null, 2));
if (verify && (!hasOptimizedModelArtifact || !hasConversionLog)) {
  console.error(`[${phase}] missing optimized model artifact or conversion log evidence; modelFiles=${modelFiles.length}, logFiles=${logFiles.length}`);
  process.exit(1);
}
