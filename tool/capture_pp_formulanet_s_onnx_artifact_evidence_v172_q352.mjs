#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const defaultOnnxPath = path.resolve(projectRoot, '..', 'MathProOcrArtifacts', 'PP-FormulaNet-S-ONNX-Exact', 'pp_formulanet_s.onnx');
const evidenceRoot = path.resolve(projectRoot, '..', 'MathProOcrArtifacts', 'PP-FormulaNet-S-ONNX-Exact');
const evidencePath = path.join(evidenceRoot, 'q352_onnx_artifact_evidence.json');
const onnxPath = process.argv[2] ? path.resolve(process.argv[2]) : defaultOnnxPath;
const expectedSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
const expectedSizeBytes = 308743097;
const phase = 'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE';

function sha256(filePath) { return crypto.createHash('sha256').update(fs.readFileSync(filePath)).digest('hex'); }
function insideProject(filePath) {
  const rel = path.relative(projectRoot, filePath);
  return rel && !rel.startsWith('..') && !path.isAbsolute(rel);
}
const exists = fs.existsSync(onnxPath);
const stat = exists ? fs.statSync(onnxPath) : null;
const digest = exists ? sha256(onnxPath) : '';
const evidence = {
  phase,
  sourcePhase: 'V172-Q351-OPTIMIZED-MODEL-EVIDENCE-ACCEPTANCE-REAL-MODEL-LOAD-UNLOCK-GATE',
  runtimeStrategy: 'ONNX_RUNTIME_MOBILE_CANDIDATE_DEFAULT_OFF',
  onnxPath,
  expectedSha256,
  actualSha256: digest,
  sha256MatchesExpected: digest === expectedSha256,
  expectedSizeBytes,
  actualSizeBytes: stat ? stat.size : 0,
  sizeMatchesExpected: stat ? stat.size === expectedSizeBytes : false,
  onnxArtifactExists: exists,
  onnxArtifactStoredOutsideProjectRoot: exists ? !insideProject(onnxPath) : false,
  onnxConversionEvidenceAcceptedByPackage: exists && digest === expectedSha256 && stat.size === expectedSizeBytes && !insideProject(onnxPath),
  paddleLiteNbArtifactAvailable: false,
  androidModelLoadAttempted: false,
  ocrPassClaimed: false,
  note: 'Q352 captures external ONNX artifact evidence only. It does not bundle the ONNX model into the Flutter project, add ONNX Runtime, load a model, or run OCR.',
  capturedAt: new Date().toISOString(),
  projectRoot,
};
fs.mkdirSync(evidenceRoot, { recursive: true });
fs.writeFileSync(evidencePath, `${JSON.stringify(evidence, null, 2)}
`);
console.log(JSON.stringify(evidence, null, 2));
if (process.argv.includes('--require-evidence') && !evidence.onnxConversionEvidenceAcceptedByPackage) {
  console.error(`[${phase}] ONNX artifact evidence is missing or does not match expected SHA/size/outside-project policy.`);
  process.exit(1);
}
