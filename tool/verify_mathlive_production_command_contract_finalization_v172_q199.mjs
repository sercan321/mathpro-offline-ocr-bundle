#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_command_contract_finalization_v172_q199.mjs', preservedPhase: 'verify_mathlive_production_command_contract_finalization_v172_q199' });

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const fail = (msg) => { console.error(`Q199_PRODUCTION_COMMAND_CONTRACT_FINALIZATION_FAIL: ${msg}`); process.exit(1); };
const must = (rel, token) => { if (!exists(rel) || !read(rel).includes(token)) fail(`${rel} missing ${token}`); };
const mustNot = (rel, token) => { if (exists(rel) && read(rel).includes(token)) fail(`${rel} contains forbidden ${token}`); };
const sha256 = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');

const phase = 'V172-Q199';
const fullPhase = 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION';
const files = {
  commandPolicy: 'lib/features/mathlive/mathlive_production_command_contract_policy.dart',
  keyboardPolicy: 'lib/features/mathlive/mathlive_keyboard_bridge_policy.dart',
  appShell: 'lib/app/app_shell.dart',
  mainSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurface: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  prodHtml: 'assets/mathlive/main_editor_prod.html',
  manifest: 'assets/mathlive/manifest.json',
  test: 'test/v172_q199_production_command_contract_finalization_test.dart',
  verifier: 'tool/verify_mathlive_production_command_contract_finalization_v172_q199.mjs',
};
for (const [name, rel] of Object.entries(files)) if (!exists(rel)) fail(`missing ${name}: ${rel}`);

must(files.commandPolicy, "static const String phase = 'V172-Q199'");
must(files.commandPolicy, "static const String fullPhase = 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION'");
must(files.commandPolicy, 'rawInsertTokensMayCrossProductionBridge = false');
must(files.commandPolicy, 'rawVisibleLabelsMayCrossProductionBridgeForCriticalTemplates = false');
must(files.commandPolicy, 'graphHistorySolutionImpact');
must(files.commandPolicy, 'expectedPostCommandStateBehavior');
must(files.commandPolicy, 'documentPlaceholderCount');
must(files.commandPolicy, 'criticalContractsByLabel');

const criticalLabels = [
  'lim', 'lim x→□', 'lim x→∞', '□/□', 'a/b', '□⁄□', '√□', '√x', 'x^y', '□^□',
  'Σ', 'Π', '∫', '∫dx', '∫□dx', '∫ₐᵇ', 'Taylor', 'Maclaurin', 'C', '⌫', '↵', 'Ans', '='
];
const policy = read(files.commandPolicy);
for (const label of criticalLabels) {
  if (!policy.includes(`label: '${label}'`)) fail(`missing critical contract label ${label}`);
}
for (const forbidden of ["documentLatex: r'#", "documentLatex: r'lim'", "documentLatex: 'Taylor'", "documentLatex: 'Maclaurin'"]) {
  if (policy.includes(forbidden)) fail(`forbidden raw document latex pattern ${forbidden}`);
}

must(files.keyboardPolicy, "import 'mathlive_production_command_contract_policy.dart';");
must(files.keyboardPolicy, 'mainEditorProductionCommandContractPhase = MathLiveProductionCommandContractPolicy.phase');
must(files.keyboardPolicy, 'MathLiveProductionCommandContractPolicy.contractForLabel(label)');
must(files.keyboardPolicy, 'contract.documentLatex');
must(files.keyboardPolicy, "case 'clear'");
must(files.keyboardPolicy, "case 'deleteBackward'");
must(files.keyboardPolicy, "case 'evaluate'");
must(files.keyboardPolicy, "case 'insertLastAnswer'");
must(files.keyboardPolicy, "case 'insertLatex'");
must(files.keyboardPolicy, "'productionCommandContractPhase': MathLiveKeyboardBridgePolicy.mainEditorProductionCommandContractPhase");

must(files.appShell, "import '../features/mathlive/mathlive_production_platform_view_policy.dart';");
mustNot(files.appShell, "import '../features/mathlive/mathlive_lab_screen_policy.dart';");
must(files.appShell, '!MathLiveProductionPlatformViewPolicy.canUseProductionWebView');
mustNot(files.appShell, 'MathLiveLabScreenPolicy.canUseRuntimeWebView');

must(files.mainSurface, "import 'mathlive_production_command_contract_policy.dart';");
must(files.prodSurface, 'productionCommandContractPhase');
must(files.prodSurface, "q199-production-command-contract-not-started");
must(files.prodBridge, "const COMMAND_CONTRACT_PHASE = 'V172-Q199';");
must(files.prodBridge, 'productionCommandContractPhase: COMMAND_CONTRACT_PHASE');
must(files.prodBridge, "const COMMAND_TRACE_PHASE = 'V172-Q190R3';");
mustNot(files.prodBridge, 'commandBusCourtPhase');
mustNot(files.prodBridge, 'COMMAND_BUS_COURT_PHASE');
must(files.prodHtml, '<math-field');

const bridgePublicNames = [...read(files.prodBridge).matchAll(/\bfunction\s+([A-Za-z0-9_]+)\s*\(/g)].map((m) => m[1]);
const bridgeText = read(files.prodBridge);
for (const api of ['mount', 'insertLatex', 'deleteBackward', 'clear', 'setLatex', 'getLatex', 'focus', 'keepCaretVisible', 'notifyFlutterState']) {
  if (!bridgeText.includes(`${api}: ${api}`) && !bridgeText.includes(`${api},`) && !bridgeText.includes(`\n    ${api}\n`)) fail(`production bridge public API missing ${api}`);
}
for (const forbiddenApi of ['runQ169FinalSelfTestCourt', 'showDiagnosticOverlay', 'mountLabRuntimeSmokeCourt']) {
  if (read(files.prodBridge).includes(forbiddenApi)) fail(`forbidden production bridge API ${forbiddenApi}`);
}

const manifest = JSON.parse(read(files.manifest));
if (![fullPhase, 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE', 'V172-Q204R2-REAL-DEVICE-EVIDENCE-INTAKE-FULL-TEST-SUITE-HYGIENE'].includes(manifest.latestProductionPhase)) fail(`latestProductionPhase expected ${fullPhase} or verified Q200 successor, got ${manifest.latestProductionPhase}`);
const env = manifest.v172Q199ProductionCommandContractFinalization;
if (!env) fail('missing manifest Q199 envelope');
for (const [key, expected] of Object.entries({
  phase,
  fullPhase,
  commandContractPolicy: files.commandPolicy,
  keyboardLayoutMutationAllowed: false,
  moreInventoryMutationAllowed: false,
  longPressOrderMutationAllowed: false,
  graphUiMutationAllowed: false,
  historyUiMutationAllowed: false,
  solutionUiMutationAllowed: false,
  rawInsertTokensMayCrossProductionBridge: false,
  rawVisibleLabelsMayCrossProductionBridgeForCriticalTemplates: false,
  appShellUsesProductionPlatformPolicy: true,
  appShellUsesLabPolicyForProductionFallback: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  flutterRunPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
  finalReleasePassClaimed: false,
})) {
  if (env[key] !== expected) fail(`manifest Q199 ${key} expected ${expected}, got ${env[key]}`);
}
if (!Array.isArray(env.criticalLabels) || env.criticalLabels.length !== criticalLabels.length) fail('manifest criticalLabels length mismatch');
for (const label of criticalLabels) if (!env.criticalLabels.includes(label)) fail(`manifest criticalLabels missing ${label}`);

const protectedFiles = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/workspace/template_tray.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/graph/graph_controller.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart',
  'lib/features/solution/solution_steps_panel.dart',
];
const hashManifest = read('docs/audit/V172_Q199_PROTECTED_FILE_HASH_MANIFEST.md');
for (const rel of protectedFiles) {
  if (!exists(rel)) fail(`protected file missing ${rel}`);
  const h = sha256(rel);
  if (!hashManifest.includes(`${rel}: UNCHANGED \`${h}\``)) fail(`protected hash manifest mismatch for ${rel}`);
  const text = read(rel);
  for (const marker of ['Q199', 'ProductionCommandContractPolicy', 'productionCommandContractPhase']) {
    if (text.includes(marker)) fail(`protected file polluted by ${marker}: ${rel}`);
  }
}

// Static Dart import/part resolution without Dart SDK.
const dartFiles = [];
function walkDart(dir) {
  for (const entry of fs.readdirSync(p(dir), { withFileTypes: true })) {
    const rel = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      if (['build', '.dart_tool', '.gradle', '.idea', 'node_modules'].includes(entry.name)) continue;
      walkDart(rel);
    } else if (entry.isFile() && entry.name.endsWith('.dart')) dartFiles.push(rel);
  }
}
for (const dir of ['lib', 'test']) if (exists(dir)) walkDart(dir);
const importRe = /^\s*import\s+['"]([^'"]+)['"]/gm;
const partRe = /^\s*part\s+['"]([^'"]+)['"]/gm;
for (const file of dartFiles) {
  const src = read(file);
  let m;
  while ((m = importRe.exec(src)) !== null) {
    const spec = m[1];
    if (spec.startsWith('dart:') || spec.startsWith('package:flutter') || spec.startsWith('package:flutter_test') || spec.startsWith('package:webview_flutter') || spec.startsWith('package:provider') || spec.startsWith('package:shared_preferences')) continue;
    if (spec.startsWith('package:mathpro_flutter_phase17/')) {
      const target = spec.replace('package:mathpro_flutter_phase17/', 'lib/');
      if (!exists(target)) fail(`${file} imports missing package target ${spec}`);
      continue;
    }
    if (spec.startsWith('.')) {
      const target = path.normalize(path.join(path.dirname(file), spec));
      if (!exists(target)) fail(`${file} imports missing relative target ${spec} -> ${target}`);
    }
  }
  while ((m = partRe.exec(src)) !== null) {
    const target = path.normalize(path.join(path.dirname(file), m[1]));
    if (!exists(target)) fail(`${file} has missing part target ${m[1]} -> ${target}`);
  }
}

// Package hygiene.
const forbiddenDirs = ['build', '.dart_tool', '.gradle', '.idea', 'node_modules', '__pycache__', '.pytest_cache'];
function walk(rel) {
  for (const entry of fs.readdirSync(p(rel), { withFileTypes: true })) {
    const child = path.join(rel, entry.name);
    if (entry.isDirectory()) {
      if (forbiddenDirs.includes(entry.name)) fail(`forbidden directory present: ${child}`);
      walk(child);
    } else if (entry.isFile()) {
      if (entry.name.endsWith('.pyc')) fail(`forbidden pyc present: ${child}`);
      if (entry.name.endsWith('.zip') || entry.name.endsWith('.apk') || entry.name.endsWith('.aab')) fail(`forbidden nested artifact present: ${child}`);
    }
  }
}
walk('.');

must('README.md', 'V172-Q199 — Production Command Contract Finalization');
must('docs/audit/V172_Q199_PRODUCTION_COMMAND_CONTRACT_FINALIZATION_AUDIT_REPORT.md', 'V172-Q199 — Production Command Contract Finalization');
must('docs/audit/V172_Q199_PRODUCTION_COMMAND_CONTRACT_FINALIZATION_CHANGED_FILES_MANIFEST.md', 'V172-Q199 changed files');
must('docs/audit/V172_Q199_PROTECTED_FILE_HASH_MANIFEST.md', 'PROTECTED_HASH_UNCHANGED');

console.log('MATHLIVE_PRODUCTION_COMMAND_CONTRACT_FINALIZATION_Q199_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
