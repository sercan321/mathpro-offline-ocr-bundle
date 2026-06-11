#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const fail = (message) => { console.error(`FAIL verify_formula_ocr_primary_no_text_fallback_v172_q389r1: ${message}`); process.exit(1); };
const check = (condition, message) => { if (!condition) fail(message); };
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));

for (const required of [
  'android/app/build.gradle',
  'pubspec.yaml',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
  'assets/mathlive/manifest.json',
  'README.md',
  'docs/audit/V172_Q389R1_FORMULA_OCR_PRIMARY_NO_TEXT_FALLBACK_CONTRACT.md',
  'docs/audit/V172_Q389R1_CHANGED_FILES.md',
]) check(exists(required), `missing required file: ${required}`);

const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml');
const main = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const readme = read('README.md');
const audit = read('docs/audit/V172_Q389R1_FORMULA_OCR_PRIMARY_NO_TEXT_FALLBACK_CONTRACT.md');

for (const marker of [
  'com.google.mlkit',
  'text-recognition:',
  'TextRecognition.getClient',
  'TextRecognizerOptions',
  'InputImage.fromFilePath',
  'google_mlkit_text_recognition:',
  'google_mlkit_commons:',
]) {
  check(!buildGradle.includes(marker), `Android build.gradle must not contain Text OCR fallback marker: ${marker}`);
  check(!pubspec.includes(marker), `pubspec.yaml must not contain Text OCR fallback marker: ${marker}`);
  check(!main.includes(marker), `MainActivity.kt must not contain plain text OCR runtime marker: ${marker}`);
}

for (const marker of [
  'M' + 'L Kit text fallback',
  'ml' + 'KitFallbackOnly',
  'missingFallbackPlanOrPrimary' + 'Ml' + 'KitRisk',
  'missingFallbackPlanOr' + 'Ml' + 'KitFallbackOnlyRule',
]) {
  for (const rel of ['lib', 'test', 'tool', 'assets/mathlive/manifest.json']) {
    const target = path.join(root, rel);
    if (!exists(rel)) continue;
    const hit = [];
    const walk = (abs) => {
      const stat = fs.statSync(abs);
      if (stat.isDirectory()) {
        for (const name of fs.readdirSync(abs)) {
          if (name === 'build' || name === '.dart_tool') continue;
          walk(path.join(abs, name));
        }
        return;
      }
      if (!/\.(dart|mjs|json|md|kt|gradle|yaml|yml|txt)$/i.test(abs)) return;
      const text = fs.readFileSync(abs, 'utf8');
      if (text.includes(marker)) hit.push(path.relative(root, abs));
    };
    walk(target);
    check(hit.length === 0, `active project files still contain deprecated plain text OCR fallback marker ${marker}: ${hit.slice(0, 8).join(', ')}`);
  }
}

check(['V172-Q389R1', 'V172-Q389R2', 'V172-Q389R2_OFFLINE', 'V172-Q389R3_OFFLINE', 'V172-Q389R4_OFFLINE', 'V172-Q389R5A_OFFLINE'].includes(manifest.cameraOcrFormulaOcrPrimaryEngineLatestPhase), 'manifest latest phase must be Q389R1 or approved Q389R2/Q389R2_OFFLINE/Q389R3_OFFLINE/Q389R4_OFFLINE/Q389R5A_OFFLINE successor');
const q389r1 = manifest.v172Q389R1FormulaOcrPrimaryNoTextFallbackContract;
check(q389r1?.phase === 'V172-Q389R1', 'manifest Q389R1 phase mismatch');
check(q389r1?.plainTextOcrFallbackRuntimeDependencyPresent === false, 'manifest must record plain text OCR runtime absent');
check(q389r1?.plainTextOcrFallbackFlutterDependencyPresent === false, 'manifest must record Flutter plain text OCR dependency absent');
check(q389r1?.plainTextOcrFallbackAndroidDependencyPresent === false, 'manifest must record Android plain text OCR dependency absent');
check(q389r1?.ppFormulaNetPlusLRemoved === true, 'manifest must record text fallback removed');
check(q389r1?.formulaOcrPrimaryEngineOnly === true, 'manifest must record PP-FormulaNet_plus-L only');
check(q389r1?.fallbackTextOcrEnabled === false, 'manifest must record text OCR fallback disabled');
check(q389r1?.workspaceImportRequiresEditableReview === true, 'workspace import must remain review-first');
check(q389r1?.explicitUserApprovalRequiredBeforeWorkspaceImport === true, 'workspace import must require explicit approval');
check(q389r1?.directSolveGraphSolutionHistoryBlocked === true, 'camera OCR must not auto solve/graph/history');
check(q389r1?.modelBinaryBundledInBaseApp === false, 'model binary must remain unbundled');
check(q389r1?.onnxRuntimeReintroducedInBaseApk === false, 'ONNX runtime must remain absent');
check(q389r1?.ocrPassClaimed === false, 'Q389R1 must not claim OCR pass');
check(q389r1?.androidRealDevicePassClaimed === false, 'Q389R1 must not claim Android device pass');
check(q389r1?.keyboardQ382Touched === false, 'Q389R1 must not touch Q382 keyboard ordering');
check(q389r1?.graphHistorySolutionSolverTouched === false, 'Q389R1 must not touch graph/history/solution/solver');

for (const marker of [
  'Q389R1 removes plain text OCR fallback from the active camera OCR direction',
  'formula-recognition / image-to-LaTeX',
  'Android text-recognition dependency: absent',
  'Plain-text OCR fallback behavior: disabled',
  'Workspace import remains review-first',
]) check(audit.includes(marker), `audit marker missing: ${marker}`);

check(readme.includes('V172-Q389R1 — Formula OCR Primary / No Plain-Text Fallback Contract'), 'README Q389R1 section missing');
check(readme.includes('does not add an Android text-recognition dependency'), 'README must document Android plain text OCR absence');

const forbiddenModelExt = /\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors|apk|aab)$/i;
const forbiddenArtifacts = [];
const walkArtifacts = (rel) => {
  for (const entry of fs.readdirSync(path.join(root, rel), { withFileTypes: true })) {
    const child = path.posix.join(rel, entry.name);
    if (child.includes('/build/') || child.includes('/.dart_tool/')) continue;
    if (entry.isDirectory()) walkArtifacts(child);
    else if (forbiddenModelExt.test(child)) forbiddenArtifacts.push(child);
  }
};
walkArtifacts('.');
check(forbiddenArtifacts.length === 0, `forbidden bundled model/release artifacts found: ${forbiddenArtifacts.join(', ')}`);

console.log('PASS verify_formula_ocr_primary_no_text_fallback_v172_q389r1');
