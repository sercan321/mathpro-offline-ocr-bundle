#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_legacy_fallback_isolation_v172_q190r7.mjs', preservedPhase: 'verify_mathlive_production_legacy_fallback_isolation_v172_q190r7' });

const files = {
  policy: 'lib/features/mathlive/mathlive_production_legacy_fallback_isolation_policy.dart',
  appShellPolicy: 'lib/features/mathlive/mathlive_appshell_command_bus_hard_binding_policy.dart',
  singleBusPolicy: 'lib/features/mathlive/mathlive_single_command_bus_authority_policy.dart',
  test: 'test/v172_q190r7_production_legacy_fallback_isolation_test.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  appShell: 'lib/app/app_shell.dart',
  workspace: 'lib/features/workspace/workspace_panel.dart',
  prodSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurfacePart: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  prodHtml: 'assets/mathlive/main_editor_prod.html',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  audit: 'docs/audit/V172_Q190R7_PRODUCTION_LEGACY_FALLBACK_ISOLATION_AUDIT_REPORT.md',
  changed: 'docs/audit/V172_Q190R7_PRODUCTION_LEGACY_FALLBACK_ISOLATION_CHANGED_FILES_MANIFEST.md',
  hash: 'docs/audit/V172_Q190R7_PROTECTED_FILE_HASH_MANIFEST.md',
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

has('policy', "phase = 'V172-Q190R7'");
has('policy', "baseline = 'V172-Q190R6_NO_FREEZE_RUNTIME_INVARIANT'");
has('policy', "repairScope = 'production-legacy-fallback-isolation'");
has('policy', 'appShellVisibleFallbackFeedsSurface = false');
has('policy', 'singleCommandBusBlocksFlutterOverlay = true');
has('policy', 'productionSurfaceIgnoresVisibleLatexMirror = true');
has('policy', 'productionStateMustComeFromBridgePush = true');
has('policy', 'legacySurfacePhysicalCleanupCompleted = false');
has('policy', 'keyboardLayoutMutationAllowed = false');
has('policy', 'moreInventoryMutationAllowed = false');
has('policy', 'longPressOrderMutationAllowed = false');
has('policy', 'graphUiMutationAllowed = false');
has('policy', 'historyPanelMutationAllowed = false');
has('policy', 'solutionStepsPanelMutationAllowed = false');
has('policy', 'androidRealDevicePassClaimed = false');
has('policy', 'premiumSymbolVisualPassClaimed = false');
has('policy', 'caretRealDevicePassClaimed = false');

has('appShellPolicy', "phase = 'V172-Q167'");
has('appShellPolicy', 'visibleFallbackFeedsSurface = false');
has('singleBusPolicy', 'blocksFlutterVisibleFallbackOverlay = true');
has('test', 'MathLiveProductionLegacyFallbackIsolationPolicy.phase');
has('test', 'MathLiveAppShellCommandBusHardBindingPolicy.visibleFallbackFeedsSurface, isFalse');
has('test', 'blocksFlutterVisibleFallbackOverlay, isTrue');

has('appShell', '_useMathLiveMainEditor = true');
has('appShell', 'MathLiveAppShellCommandBusHardBindingPolicy.visibleFallbackFeedsSurface');
has('workspace', 'MathLiveProductionEditorSurface(');
has('prodSurfaceCombined', 'class MathLiveProductionEditorSurface');
has('prodSurfaceCombined', 'assets/mathlive/main_editor_prod.html');
has('prodSurfaceCombined', 'assets/mathlive/mathlive_prod_bridge.js');
has('prodSurfaceCombined', 'void _noteFlutterKeyboardTap(String label, {String visibleLatex = \'\'})');
has('prodSurfaceCombined', '_lastProductionCommandTrace');
has('prodHtml', '<math-field id="mathlive-field"');
has('prodBridge', 'NO_FREEZE_RUNTIME_INVARIANT_PHASE');

const surface = text.prodSurfaceCombined || '';
const productionState = sliceBetween(surface, 'class _MathLiveProductionEditorSurfaceState', 'class _RuntimeBlockedPanel');
const legacyState = sliceBetween(surface, 'class _MathLiveMainEditorSurfaceState', 'class MathLiveProductionEditorSurface');
if (!productionState) failures.push('production _MathLiveProductionEditorSurfaceState slice not found');
if (!legacyState && !surface.includes('legacyImplementationPhysicallyRemoved = true')) failures.push('legacy state absent before Q194 cleanup marker');
if (productionState.includes('_appShellVisibleExpression')) failures.push('production state must not use _appShellVisibleExpression');
if (productionState.includes('_documentLatexForVisibleFallback')) failures.push('production state must not call legacy visible fallback sanitizer');
if (productionState.includes('_MathLiveAppShellVisibleFallbackOverlay')) failures.push('production build slice must not instantiate fallback overlay');
if (surface.includes('class _MathLiveAppShellVisibleFallbackOverlay')) {
  failures.push('Q194 cleanup successor must physically remove fallback overlay class');
}

has('manifest', 'v172Q190R7ProductionLegacyFallbackIsolation');
has('manifest', 'V172-Q190R7-PRODUCTION-LEGACY-FALLBACK-ISOLATION');
has('manifest', 'appShellVisibleFallbackFeedsSurface');
has('manifest', 'productionSurfaceIgnoresVisibleLatexMirror');
has('readme', 'V172-Q190R7 — Production Legacy Fallback Isolation');
has('audit', 'V172-Q190R7 Production Legacy Fallback Isolation Audit Report');
has('changed', 'V172-Q190R7 Production Legacy Fallback Isolation Changed Files Manifest');
has('hash', 'V172-Q190R7 Protected File Hash Manifest');
has('hash', 'PROTECTED_HASH_UNCHANGED');

for (const protectedName of ['keyConfig', 'mathKeyboard', 'bottomDock', 'premiumKey', 'longPressPopup', 'templateTray', 'graphCard', 'graphController', 'historyController', 'historyPanel', 'solutionPanel']) {
  lacks(protectedName, 'V172-Q190R7');
  lacks(protectedName, 'Production Legacy Fallback Isolation');
}

try {
  const manifest = JSON.parse(text.manifest ?? '{}');
  const q190r7 = manifest.v172Q190R7ProductionLegacyFallbackIsolation;
  if (!q190r7) failures.push('manifest missing v172Q190R7ProductionLegacyFallbackIsolation object');
  else {
    if (q190r7.phase !== 'V172-Q190R7') failures.push('manifest q190r7 phase mismatch');
    if (q190r7.newFeatureAllowed !== false) failures.push('q190r7 must not allow new features');
    if (q190r7.appShellVisibleFallbackFeedsSurface !== false) failures.push('q190r7 fallback feed must be false');
    if (q190r7.productionStateMustComeFromBridgePush !== true) failures.push('q190r7 bridge-push state gate missing');
    if (q190r7.legacySurfacePhysicalCleanupCompleted !== false) failures.push('q190r7 must not claim physical legacy cleanup');
    if (q190r7.androidRealDevicePassClaimed !== false) failures.push('q190r7 must not claim Android PASS');
  }
  if (!['V172-Q190R7-PRODUCTION-LEGACY-FALLBACK-ISOLATION', 'V172-Q190R8-PRODUCTION-STATIC-ASSET-TRUTH-CLOSURE', 'V172-Q190R9-STATIC-PRE-ANALYZE-HYGIENE-CLOSURE', 'V172-Q191-RUNTIME-RENDER-CONTRACT-CLOSURE', 'V172-Q192-CARET-FOCUS-SLOT-CONTRACT-CLOSURE', 'V172-Q193-REAL-MATHLIVE-FONT-BUNDLE-CLOSURE', 'V172-Q194-PHYSICAL-LEGACY-CLEANUP', 'V172-Q195-FINAL-STATIC-RELEASE-FREEZE', 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) {
    failures.push('manifest latestProductionPhase must point at Q190R7 or a verified Q190R7-preserving successor phase');
  }
} catch (error) {
  failures.push(`manifest JSON parse failed: ${error.message}`);
}

if (failures.length) {
  console.error('MATHLIVE_PRODUCTION_LEGACY_FALLBACK_ISOLATION_Q190R7_VERIFICATION_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_PRODUCTION_LEGACY_FALLBACK_ISOLATION_Q190R7_STATIC_READY_BUT_FLUTTER_ANALYZE_AND_ANDROID_RETEST_REQUIRED');
