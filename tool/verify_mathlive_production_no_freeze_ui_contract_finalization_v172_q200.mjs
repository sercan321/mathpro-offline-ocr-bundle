import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_no_freeze_ui_contract_finalization_v172_q200.mjs', preservedPhase: 'verify_mathlive_production_no_freeze_ui_contract_finalization_v172_q200' });

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const exists = (rel) => fs.existsSync(p(rel));
const fail = (msg) => { console.error(`Q200_PRODUCTION_NO_FREEZE_UI_CONTRACT_FINALIZATION_FAIL: ${msg}`); process.exit(1); };
const must = (rel, needle) => { if (!read(rel).includes(needle)) fail(`${rel} missing ${needle}`); };
const mustNot = (rel, needle) => { if (read(rel).includes(needle)) fail(`${rel} contains forbidden ${needle}`); };
const sha256 = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');

const phase = 'V172-Q200';
const fullPhase = 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION';
const files = {
  q200Policy: 'lib/features/mathlive/mathlive_production_no_freeze_ui_contract_policy.dart',
  q199Policy: 'lib/features/mathlive/mathlive_production_command_contract_policy.dart',
  mainSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurface: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  manifest: 'assets/mathlive/manifest.json',
  test: 'test/v172_q200_production_no_freeze_ui_contract_finalization_test.dart',
  verifier: 'tool/verify_mathlive_production_no_freeze_ui_contract_finalization_v172_q200.mjs',
};
for (const [name, rel] of Object.entries(files)) if (!exists(rel)) fail(`missing ${name}: ${rel}`);

must(files.q200Policy, "static const String phase = 'V172-Q200'");
must(files.q200Policy, "static const String fullPhase = 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION'");
must(files.q200Policy, 'controllerSendKeyMayAwaitProductionDispatch = false');
must(files.q200Policy, 'productionSendKeyMayAwaitWebViewJavascript = false');
must(files.q200Policy, 'productionCommandSchedulingReturnsSynchronously = true');
must(files.q200Policy, 'webViewJavascriptRunsOnlyInsideFireAndForgetTail = true');
must(files.q200Policy, 'runJavaScriptReturningResultAllowedInProductionPath = false');
must(files.q200Policy, 'pressedStateMayDependOnJsCompletion = false');
must(files.q200Policy, 'bridgeFailureMayBlockFlutterKeyFlow = false');
must(files.q200Policy, 'timeoutMayBlockFlutterKeyFlow = false');
must(files.q200Policy, 'clearCommandResetsTailEpochAndOptimisticLatex = true');
must(files.q200Policy, 'commandTailDepthBounded = true');
must(files.q200Policy, 'maxScheduledProductionTailDepth = 64');
must(files.q200Policy, 'productionTailErrorsMustBeCaught = true');
must(files.q200Policy, 'commandResultDeliveredByAsyncStatePush = true');
for (const redLine of ['keyboardLayoutMutationAllowed = false', 'moreInventoryMutationAllowed = false', 'longPressOrderMutationAllowed = false', 'graphUiMutationAllowed = false', 'historyUiMutationAllowed = false', 'solutionUiMutationAllowed = false']) {
  must(files.q200Policy, redLine);
}

must(files.mainSurface, "import 'mathlive_production_no_freeze_ui_contract_policy.dart';");
must(files.mainSurface, "Future<bool> sendKey(String label, {String lastAnswer = ''}) {");
must(files.mainSurface, 'state.scheduleMathProKey(label, lastAnswer: lastAnswer)');
must(files.mainSurface, 'return Future<bool>.value(sent);');
must(files.mainSurface, 'return Future<bool>.value(false);');
mustNot(files.mainSurface, 'final sent = await state.sendMathProKey');
mustNot(files.mainSurface, "Future<bool> sendKey(String label, {String lastAnswer = ''}) async");

must(files.prodSurface, 'int _scheduledProductionTailDepth = 0;');
must(files.prodSurface, "q200-production-no-freeze-ui-contract-not-started");
must(files.prodSurface, 'Future<bool> sendMathProKey(String label, {String lastAnswer = \'\'\}) =>');
must(files.prodSurface, 'bool scheduleMathProKey(String label, {String lastAnswer = \'\'\})');
must(files.prodSurface, "unawaited(_emitState(reason: 'q200-evaluate-requested-nonblocking'");
must(files.prodSurface, "'productionNoFreezeUiContractPhase': MathLiveProductionNoFreezeUiContractPolicy.phase");
must(files.prodSurface, "'productionCommandSchedulingReturnsSynchronously': MathLiveProductionNoFreezeUiContractPolicy.productionCommandSchedulingReturnsSynchronously");
must(files.prodSurface, "'webViewJavascriptRunsOnlyInsideFireAndForgetTail': MathLiveProductionNoFreezeUiContractPolicy.webViewJavascriptRunsOnlyInsideFireAndForgetTail");
must(files.prodSurface, "'pressedStateMayDependOnJsCompletion': MathLiveProductionNoFreezeUiContractPolicy.pressedStateMayDependOnJsCompletion");
must(files.prodSurface, 'bool _enqueueProductionCommand({');
mustNot(files.prodSurface, 'Future<bool> _enqueueProductionCommand({');
must(files.prodSurface, '_productionCommandTail = Future<void>.value();');
must(files.prodSurface, '_scheduledProductionTailDepth = 0;');
must(files.prodSurface, "_lastLatex = '';");
must(files.prodSurface, "_lastExternalLatex = '';");
must(files.prodSurface, "_lastProductionStateJson = '';");
must(files.prodSurface, "q200-dart-priority-clear-nonblocking-tail-reset");
must(files.prodSurface, '_scheduledProductionTailDepth >= MathLiveProductionNoFreezeUiContractPolicy.maxScheduledProductionTailDepth');
must(files.prodSurface, "q200-dart-dispatch-rejected-tail-depth-bound");
must(files.prodSurface, "q200-dart-command-accepted-nonblocking");
must(files.prodSurface, "q200-production-command-timeout-or-exception-released");
must(files.prodSurface, "q200-production-tail-error-released");
must(files.prodSurface, "q200-production-command-refresh");
must(files.prodSurface, 'finally {');
must(files.prodSurface, 'if (_scheduledProductionTailDepth > 0) _scheduledProductionTailDepth -= 1;');
mustNot(files.prodSurface, 'runJavaScriptReturningResult');

must(files.prodBridge, "const NO_FREEZE_UI_CONTRACT_PHASE = 'V172-Q200';");
must(files.prodBridge, 'productionNoFreezeUiContractPhase: NO_FREEZE_UI_CONTRACT_PHASE');
must(files.prodBridge, 'productionSendKeyMayAwaitWebViewJavascript: false');
must(files.prodBridge, 'productionCommandSchedulingReturnsSynchronously: true');
must(files.prodBridge, 'webViewJavascriptRunsOnlyInsideFireAndForgetTail: true');
must(files.prodBridge, 'pressedStateMayDependOnJsCompletion: false');
must(files.prodBridge, 'bridgeFailureMayBlockFlutterKeyFlow: false');
must(files.prodBridge, 'timeoutMayBlockFlutterKeyFlow: false');
must(files.prodBridge, "commandCompletionMode: 'q200-schedule-now-fire-and-state-push'");
must(files.prodBridge, "trace('q200-js-command-queued-bounded'");
must(files.prodBridge, "trace('q200-js-queue-overflow-drop-oldest-released'");
must(files.prodBridge, "trace('q200-js-queue-flush-request-nonblocking'");
must(files.prodBridge, "resetPendingCommands('q200-js-clear-reset-pending-queue')");
mustNot(files.prodBridge, 'runJavaScriptReturningResult');

const manifest = JSON.parse(read(files.manifest));
if (![fullPhase, 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE', 'V172-Q204R2-REAL-DEVICE-EVIDENCE-INTAKE-FULL-TEST-SUITE-HYGIENE'].includes(manifest.latestProductionPhase)) fail(`latestProductionPhase expected ${fullPhase} or verified Q201 successor, got ${manifest.latestProductionPhase}`);
const env = manifest.v172Q200ProductionNoFreezeUiContractFinalization;
if (!env) fail('missing manifest Q200 envelope');
for (const [key, expected] of Object.entries({
  phase,
  fullPhase,
  baseline: 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION',
  policy: files.q200Policy,
  controllerSendKeyMayAwaitProductionDispatch: false,
  productionSendKeyMayAwaitWebViewJavascript: false,
  productionCommandSchedulingReturnsSynchronously: true,
  webViewJavascriptRunsOnlyInsideFireAndForgetTail: true,
  runJavaScriptReturningResultAllowedInProductionPath: false,
  pressedStateMayDependOnJsCompletion: false,
  bridgeFailureMayBlockFlutterKeyFlow: false,
  timeoutMayBlockFlutterKeyFlow: false,
  clearCommandResetsTailEpochAndOptimisticLatex: true,
  commandTailDepthBounded: true,
  maxScheduledProductionTailDepth: 64,
  productionTailErrorsMustBeCaught: true,
  commandResultDeliveredByAsyncStatePush: true,
  keyboardLayoutMutationAllowed: false,
  moreInventoryMutationAllowed: false,
  longPressOrderMutationAllowed: false,
  graphUiMutationAllowed: false,
  historyUiMutationAllowed: false,
  solutionUiMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  flutterRunPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
  finalReleasePassClaimed: false,
})) {
  if (env[key] !== expected) fail(`manifest Q200 ${key} expected ${expected}, got ${env[key]}`);
}

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
const hashManifest = read('docs/audit/V172_Q200_PROTECTED_FILE_HASH_MANIFEST.md');
for (const rel of protectedFiles) {
  if (!exists(rel)) fail(`protected file missing ${rel}`);
  const h = sha256(rel);
  if (!hashManifest.includes(`${rel}: UNCHANGED \`${h}\``)) fail(`protected hash manifest mismatch for ${rel}`);
  const text = read(rel);
  for (const marker of ['Q200', 'ProductionNoFreezeUiContractPolicy', 'productionNoFreezeUiContractPhase']) {
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

must('README.md', 'V172-Q200 — Production No-Freeze UI Contract Finalization');
must('docs/audit/V172_Q200_PRODUCTION_NO_FREEZE_UI_CONTRACT_FINALIZATION_AUDIT_REPORT.md', 'V172-Q200 — Production No-Freeze UI Contract Finalization');
must('docs/audit/V172_Q200_PRODUCTION_NO_FREEZE_UI_CONTRACT_FINALIZATION_CHANGED_FILES_MANIFEST.md', 'V172-Q200 changed files');
must('docs/audit/V172_Q200_PROTECTED_FILE_HASH_MANIFEST.md', 'PROTECTED_HASH_UNCHANGED');

console.log('MATHLIVE_PRODUCTION_NO_FREEZE_UI_CONTRACT_FINALIZATION_Q200_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
