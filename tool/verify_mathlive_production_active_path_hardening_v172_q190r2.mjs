#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_active_path_hardening_v172_q190r2.mjs', preservedPhase: 'verify_mathlive_production_active_path_hardening_v172_q190r2' });

const files = {
  policy: 'lib/features/mathlive/mathlive_production_active_path_hardening_policy.dart',
  test: 'test/v172_q190r2_production_active_path_hardening_test.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  appShell: 'lib/app/app_shell.dart',
  workspace: 'lib/features/workspace/workspace_panel.dart',
  prodSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurfacePart: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  prodHtml: 'assets/mathlive/main_editor_prod.html',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  q190r2Audit: 'docs/audit/V172_Q190R2_PRODUCTION_ACTIVE_PATH_HARDENING_AUDIT_REPORT.md',
  q190r2Changed: 'docs/audit/V172_Q190R2_PRODUCTION_ACTIVE_PATH_HARDENING_CHANGED_FILES_MANIFEST.md',
  q190r2Hash: 'docs/audit/V172_Q190R2_PROTECTED_FILE_HASH_MANIFEST.md',
  keyConfig: 'lib/features/keyboard/key_config.dart',
  mathKeyboard: 'lib/features/keyboard/math_keyboard.dart',
  bottomDock: 'lib/features/keyboard/bottom_dock.dart',
  premiumKey: 'lib/features/keyboard/premium_key.dart',
  longPressPopup: 'lib/features/keyboard/long_press_popup.dart',
  templateTray: 'lib/features/workspace/template_tray.dart',
  graphCard: 'lib/features/graph/graph_card.dart',
  graphController: 'lib/features/graph/graph_controller.dart',
  historyController: 'lib/features/history/history_controller.dart',
  historyPanel: 'lib/features/history/history_panel.dart',
  solutionPanel: 'lib/features/solution/solution_steps_panel.dart',
};

const failures = [];
const text = {};
for (const [name, path] of Object.entries(files)) {
  if (!fs.existsSync(path)) failures.push(`missing required file: ${path}`);
  else text[name] = fs.readFileSync(path, 'utf8');
}
text.prodSurfaceCombined = `${text.prodSurface || ''}\n${text.prodSurfacePart || ''}`;
const has = (name, needle) => {
  if (!text[name]?.includes(needle)) failures.push(`${files[name]} missing ${needle}`);
};
const lacks = (name, needle) => {
  if (text[name]?.includes(needle)) failures.push(`${files[name]} must not contain ${needle}`);
};
function sliceBetween(source, startNeedle, endNeedle) {
  const start = source.indexOf(startNeedle);
  if (start < 0) return '';
  if (!endNeedle) return source.slice(start);
  const end = source.indexOf(endNeedle, start + startNeedle.length);
  return source.slice(start, end < 0 ? source.length : end);
}

has('policy', "phase = 'V172-Q190R2'");
has('policy', "baseline = 'V172-Q190R1_REAL_DEVICE_DEFECT_REPAIR_COMPILE_FIX'");
has('policy', "repairScope = 'production-active-path-css-and-raw-token-commit-hardening'");
has('policy', 'productionSurfaceMustInlineMathLiveCss = true');
has('policy', 'productionBridgeMustRejectRawInsertTokenCommit = true');
has('policy', 'productionBridgeMustRollbackRawInsertTokenLeak = true');
has('policy', 'legacySurfacePhysicalCleanupCompleted = false');
has('policy', 'mathLiveFontsBundledAndVerified = false');
has('policy', 'androidRealDevicePassClaimed = false');
has('policy', 'flutterAnalyzePassClaimedByAssistant = false');

has('test', 'MathLiveProductionActivePathHardeningPolicy.phase');
has('test', 'productionBridgeMustRejectRawInsertTokenCommit');
has('test', 'legacySurfacePhysicalCleanupCompleted');

has('appShell', 'final bool _useMathLiveMainEditor = true;');
has('workspace', 'MathLiveProductionEditorSurface(');
has('workspace', 'useMathLiveMainEditor');

has('prodSurfaceCombined', "import 'mathlive_production_active_path_hardening_policy.dart';");
has('prodSurfaceCombined', "static const String webViewAssetPath = 'assets/mathlive/main_editor_prod.html';");
has('prodSurfaceCombined', "static const String bridgeAssetPath = 'assets/mathlive/mathlive_prod_bridge.js';");
has('prodSurfaceCombined', "static const String runtimeAssetPath = 'assets/mathlive/vendor/mathlive/mathlive.min.js';");
has('prodSurfaceCombined', "static const String fontsCssAssetPath = 'assets/mathlive/vendor/mathlive/mathlive-fonts.css';");
has('prodSurfaceCombined', "static const String staticCssAssetPath = 'assets/mathlive/vendor/mathlive/mathlive-static.css';");
has('prodSurfaceCombined', "rootBundle.loadString(MathLiveProductionEditorSurface.fontsCssAssetPath)");
has('prodSurfaceCombined', "rootBundle.loadString(MathLiveProductionEditorSurface.staticCssAssetPath)");
has('prodSurfaceCombined', "replaceFirst('__MATHPRO_INLINE_MATHLIVE_FONTS_CSS__', fontsCss)");
has('prodSurfaceCombined', "replaceFirst('__MATHPRO_INLINE_MATHLIVE_STATIC_CSS__', staticCss)");
has('prodSurfaceCombined', 'MathLiveProductionActivePathHardeningPolicy.phase');

const surface = text.prodSurfaceCombined || '';
const legacyState = sliceBetween(surface, 'class _MathLiveMainEditorSurfaceState', 'class MathLiveProductionEditorSurface');
const productionState = sliceBetween(surface, 'class _MathLiveProductionEditorSurfaceState', '');
if (!legacyState && !surface.includes('legacyImplementationPhysicallyRemoved = true')) failures.push('legacy state absent before Q194 cleanup marker');
if (!productionState) failures.push('production _MathLiveProductionEditorSurfaceState slice not found');
for (const forbidden of ['_enqueueProductionCommand', '_productionCommandTail', '_runProductionJavascript', '_refreshProductionStateDeferred', '_emitState(']) {
  if (legacyState.includes(forbidden)) failures.push(`legacy _MathLiveMainEditorSurfaceState must not reference ${forbidden}`);
}
for (const required of ['_enqueueProductionCommand', '_productionCommandTail', '_runProductionJavascript', '_refreshProductionStateDeferred', '_emitState(']) {
  if (!productionState.includes(required)) failures.push(`production _MathLiveProductionEditorSurfaceState must contain ${required}`);
}
const productionBuild = sliceBetween(productionState, 'Widget build(BuildContext context)', '// Q140:');
if (productionBuild.includes('_MathLiveAppShellVisibleFallbackOverlay')) failures.push('production build must not use Flutter visible fallback overlay');
if (productionBuild.includes('_MathLiveDiagnosticOverlay')) failures.push('production build must not use Q169 diagnostic overlay');

has('prodHtml', 'data-mathpro-production-html="V172-Q185"');
has('prodHtml', 'V172-Q190R2: production active-path hardening');
has('prodHtml', '__MATHPRO_INLINE_MATHLIVE_FONTS_CSS__');
has('prodHtml', '__MATHPRO_INLINE_MATHLIVE_STATIC_CSS__');
has('prodHtml', 'font-family: KaTeX_Main, KaTeX_Math');

has('prodBridge', "ACTIVE_PATH_HARDENING_PHASE = 'V172-Q190R2'");
has('prodBridge', 'activePathHardeningPhase: ACTIVE_PATH_HARDENING_PHASE');
has('prodBridge', 'rawInsertTokenLeaked: false');
has('prodBridge', 'function containsRawInsertToken(value)');
has('prodBridge', 'function insertResultCommitted(before)');
has('prodBridge', 'q190r2-raw-insert-token-leaked-to-mathfield-value');
has('prodBridge', 'function rollbackRawInsertTokenLeak(mf, before, reason)');
has('prodBridge', 'function safeAppendDocumentLatex(mf, before, latex)');
has('prodBridge', "rollbackRawInsertTokenLeak(mf, before, 'q190r2-raw-token-after-mathfield-insert')");
has('prodBridge', "rollbackRawInsertTokenLeak(mf, before, 'q190r2-raw-token-after-execute-command-insert')");
has('prodBridge', 'committed = insertResultCommitted(before);');
has('prodBridge', 'ok = safeAppendDocumentLatex(mf, before, latex) || ok;');
has('prodBridge', "mf.style.fontFamily = 'KaTeX_Main, KaTeX_Math");
has('prodBridge', 'window.MathProProductionMathLiveBridge = Object.freeze({');
for (const api of ['mount', 'insertLatex', 'deleteBackward', 'clear', 'setLatex', 'getLatex', 'focus', 'keepCaretVisible', 'notifyFlutterState']) has('prodBridge', api);
lacks('prodBridge', 'executeMathProCommand');
lacks('prodBridge', 'getRealDeviceDiagnosticReport');
lacks('prodBridge', 'runQ169FinalSelfTestCourt');

has('manifest', 'v172Q190R2ProductionActivePathHardening');
has('manifest', 'V172-Q190R2-PRODUCTION-ACTIVE-PATH-HARDENING');
has('manifest', 'latestProductionPhase');
has('readme', 'V172-Q190R2 — Production Active Path Hardening');
has('readme', 'legacy cleanup tamamlandı denmedi');
has('q190r2Audit', 'V172-Q190R2 Production Active Path Hardening Audit Report');
has('q190r2Changed', 'V172-Q190R2 Production Active Path Hardening Changed Files Manifest');
has('q190r2Hash', 'V172-Q190R2 Protected File Hash Manifest');
has('q190r2Hash', 'PROTECTED_HASH_UNCHANGED');

for (const protectedName of ['keyConfig', 'mathKeyboard', 'bottomDock', 'premiumKey', 'longPressPopup', 'templateTray', 'graphCard', 'graphController', 'historyController', 'historyPanel', 'solutionPanel']) {
  lacks(protectedName, 'V172-Q190R2');
  lacks(protectedName, 'Production Active Path Hardening');
}

try {
  const manifest = JSON.parse(text.manifest ?? '{}');
  const q190r2 = manifest.v172Q190R2ProductionActivePathHardening;
  if (!q190r2) failures.push('manifest missing v172Q190R2ProductionActivePathHardening object');
  else {
    if (q190r2.phase !== 'V172-Q190R2') failures.push('manifest q190r2 phase mismatch');
    if (q190r2.newFeatureAllowed !== false) failures.push('q190r2 must not allow new features');
    if (q190r2.productionSurfaceMustInlineMathLiveCss !== true) failures.push('q190r2 must inline MathLive CSS');
    if (q190r2.productionBridgeMustRejectRawInsertTokenCommit !== true) failures.push('q190r2 must reject raw insert token commits');
    if (q190r2.legacySurfacePhysicalCleanupCompleted !== false) failures.push('q190r2 must not claim legacy physical cleanup');
    if (q190r2.mathLiveFontsBundledAndVerified !== false) failures.push('q190r2 must not claim font bundle closure');
    if (q190r2.androidRealDevicePassClaimed !== false) failures.push('q190r2 must not claim Android PASS');
  }
  if (![
    'V172-Q190R2-PRODUCTION-ACTIVE-PATH-HARDENING',
    'V172-Q190R3-PRODUCTION-COMMAND-BUS-COURT',
    'V172-Q190R4-PRODUCTION-BRIDGE-QUEUE-FOCUS-REPAIR',
    'V172-Q190R5-TEMPLATE-PAYLOAD-SURGICAL-REPAIR',
    'V172-Q190R6-NO-FREEZE-RUNTIME-INVARIANT',
    'V172-Q190R7-PRODUCTION-LEGACY-FALLBACK-ISOLATION',
    'V172-Q190R8-PRODUCTION-STATIC-ASSET-TRUTH-CLOSURE',
    'V172-Q190R9-STATIC-PRE-ANALYZE-HYGIENE-CLOSURE',
  , 'V172-Q191-RUNTIME-RENDER-CONTRACT-CLOSURE', 'V172-Q192-CARET-FOCUS-SLOT-CONTRACT-CLOSURE', 'V172-Q193-REAL-MATHLIVE-FONT-BUNDLE-CLOSURE', 'V172-Q194-PHYSICAL-LEGACY-CLEANUP', 'V172-Q195-FINAL-STATIC-RELEASE-FREEZE', 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) {
    failures.push('manifest latestProductionPhase must point at Q190R2 or a verified successor phase');
  }
} catch (error) {
  failures.push(`manifest JSON parse failed: ${error.message}`);
}

if (failures.length) {
  console.error('MATHLIVE_PRODUCTION_ACTIVE_PATH_HARDENING_Q190R2_VERIFICATION_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_PRODUCTION_ACTIVE_PATH_HARDENING_Q190R2_STATIC_READY_BUT_FLUTTER_ANALYZE_AND_ANDROID_RETEST_REQUIRED');
