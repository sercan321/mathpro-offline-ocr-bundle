#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const phase = 'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE';
const intakeRoot = path.resolve(projectRoot, '..', 'MathProOcrArtifacts', 'PP-FormulaNet-S-PaddleLite-Optimized');
const modelDir = path.join(intakeRoot, 'model');
const logsDir = path.join(intakeRoot, 'logs');
fs.mkdirSync(modelDir, { recursive: true });
fs.mkdirSync(logsDir, { recursive: true });
const instructions = {
  phase,
  sourcePhase: 'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED',
  intakeRoot,
  modelDir,
  logsDir,
  expectedInputEvidence: {
    knownQ315ArtifactFileName: 'inference.pdiparams',
    knownQ315ArtifactSha256: 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489',
    knownQ315ArtifactSizeBytes: 231675001,
    note: 'Q315 inference.pdiparams alone is not accepted for Android Paddle Lite model load. Place converted/optimized Paddle Lite model artifacts and conversion logs here.'
  },
  acceptedEvidenceExamples: [
    'model/*.nb or a complete Paddle Lite optimized model directory if produced by the conversion tool',
    'logs/conversion_command.txt',
    'logs/conversion_log.txt or logs/conversion_log.json',
    'any model-loader path notes needed by Android runtime'
  ],
  nextCommandAfterFilesArePlaced: 'node tool/capture_pp_formulanet_s_optimized_model_evidence_v172_q350.mjs --verify',
  projectRoot,
  intakeRootOutsideProjectRoot: !intakeRoot.startsWith(projectRoot),
  modelBundledIntoProject: false,
  modelLoadAccepted: false,
  runtimeAccepted: false,
};
const out = path.join(intakeRoot, 'q350_optimized_model_intake_instructions.json');
fs.writeFileSync(out, JSON.stringify(instructions, null, 2));
console.log(JSON.stringify(instructions, null, 2));
