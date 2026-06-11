#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const phase = 'V172-Q351-OPTIMIZED-MODEL-EVIDENCE-ACCEPTANCE-REAL-MODEL-LOAD-UNLOCK-GATE';
const sourcePhase = 'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE';
const intakeRoot = path.resolve(projectRoot, '..', 'MathProOcrArtifacts', 'PP-FormulaNet-S-PaddleLite-Optimized');
const evidencePath = path.join(intakeRoot, 'q350_optimized_model_conversion_evidence.json');
const requireEvidence = process.argv.includes('--require-evidence');
function safeReadJson(file) {
  try { return { exists: fs.existsSync(file), parseError: '', value: fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : null }; }
  catch (error) { return { exists: true, parseError: String(error), value: null }; }
}
const evidenceRead = safeReadJson(evidencePath);
const evidence = evidenceRead.value || {};
const modelFiles = Array.isArray(evidence.modelFiles) ? evidence.modelFiles : [];
const logFiles = Array.isArray(evidence.logFiles) ? evidence.logFiles : [];
const modelFilesWithSha256 = modelFiles.filter((file) => typeof file.sha256 === 'string' && file.sha256.length === 64).map((file) => file.relativePath);
const logFilesWithSha256 = logFiles.filter((file) => typeof file.sha256 === 'string' && file.sha256.length === 64).map((file) => file.relativePath);
const hasOptimizedModelArtifact = evidence.hasOptimizedModelArtifact === true && modelFilesWithSha256.length > 0;
const hasConversionLog = evidence.hasConversionLog === true && logFilesWithSha256.length > 0;
const optimizedModelEvidenceAccepted = hasOptimizedModelArtifact && hasConversionLog;
const modelLoaderPathApproved = false;
const realModelLoadUnlockGranted = optimizedModelEvidenceAccepted && modelLoaderPathApproved;
const review = {
  phase,
  sourcePhase,
  intakeRoot,
  evidenceFileName: 'q350_optimized_model_conversion_evidence.json',
  evidencePath,
  evidenceExists: evidenceRead.exists,
  evidenceParseError: evidenceRead.parseError,
  q350OptimizedModelEvidenceJsonProvided: evidenceRead.exists,
  q350OptimizedModelEvidenceJsonReviewed: evidenceRead.exists && !evidenceRead.parseError,
  modelFilesWithSha256,
  logFilesWithSha256,
  hasOptimizedModelArtifact,
  hasConversionLog,
  optimizedModelEvidenceAccepted,
  modelLoaderPathApproved,
  realModelLoadUnlockGranted,
  modelLoaderAvailable: false,
  modelLoadAttempted: false,
  modelLoaded: false,
  runtimeStartupExecuted: false,
  dummyRuntimeCallExecuted: false,
  realImageToLatexInferenceExecuted: false,
  editableMathLiveReviewOpened: false,
  workspaceImportExecuted: false,
  note: 'Q351 reviews Q350 optimized model/conversion evidence only. It does not bundle model files, approve a model-loader path, load a model, or run OCR.',
  reviewedAt: new Date().toISOString(),
  projectRoot,
};
console.log(JSON.stringify(review, null, 2));
if (requireEvidence && !optimizedModelEvidenceAccepted) {
  console.error(`[${phase}] optimized model evidence is not accepted yet; modelFilesWithSha256=${modelFilesWithSha256.length}, logFilesWithSha256=${logFilesWithSha256.length}`);
  process.exit(1);
}
