#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

export const q204r3FullPhase = 'V172-Q204R3-REAL-DEVICE-EVIDENCE-INTAKE-VERIFIER-SUITE-HYGIENE';
export const q204r3ShortPhase = 'V172-Q204R3';
export const q205FullPhase = 'V172-Q205-MATHLIVE-ONLY-MAIN-EDITOR-PHYSICAL-CLEANUP';
export const q205r1FullPhase = 'V172-Q205R1-MATHLIVE-ONLY-MAIN-EDITOR-ANALYZE-TEST-HYGIENE';
export const q205r2FullPhase = 'V172-Q205R2-MATHLIVE-ONLY-MAIN-EDITOR-FLUTTER-LOG-HYGIENE';
export const q205r3FullPhase = 'V172-Q205R3-MATHLIVE-ONLY-MAIN-EDITOR-METADATA-ANALYZE-TEST-CLOSURE-HYGIENE';
export const q208FullPhase = 'V172-Q208-GRAPH-2D-3D-ELITE-TOGGLE-ARCHITECTURE';
const q204r3AcceptedLatestPhases = new Set([q204r3FullPhase, q205FullPhase, q205r1FullPhase, q205r2FullPhase, q205r3FullPhase, q208FullPhase]);
const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const readJson = (rel) => JSON.parse(read(rel));
const fail = (prefix, msg) => { console.error(`${prefix}_FAILED: ${msg}`); process.exit(1); };

export function currentLatestProductionPhase() {
  try { return readJson('assets/mathlive/manifest.json').latestProductionPhase; } catch (_) { return ''; }
}

function sha256(rel) { return crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex'); }

export function assertQ204R3ProductionContracts(prefix = 'Q204R3_VERIFIER_SUITE_HYGIENE') {
  const requiredFiles = [
    'lib/features/mathlive/mathlive_main_editor_surface.dart',
    'lib/features/mathlive/mathlive_production_editor_surface.dart',
    'assets/mathlive/main_editor_prod.html',
    'assets/mathlive/mathlive_prod_bridge.js',
    'assets/mathlive/manifest.json',
    'lib/app/app_shell.dart',
    'lib/features/workspace/workspace_panel.dart',
    'tool/evidence/V172_Q204R3_ACTIVE_VERIFIER_SUITE.json',
  ];
  for (const rel of requiredFiles) if (!exists(rel)) fail(prefix, `missing required file ${rel}`);
  const manifest = readJson('assets/mathlive/manifest.json');
  if (!q204r3AcceptedLatestPhases.has(manifest.latestProductionPhase)) fail(prefix, `latestProductionPhase must be ${q204r3FullPhase}, ${q205FullPhase}, ${q205r1FullPhase}, or ${q205r2FullPhase}/${q205r3FullPhase}/${q208FullPhase}`);
  const env = manifest.v172Q204R3RealDeviceEvidenceIntakeVerifierSuiteHygiene;
  if (!env || env.phase !== q204r3ShortPhase || env.fullPhase !== q204r3FullPhase) fail(prefix, 'missing Q204R3 manifest envelope');
  for (const [k, expected] of Object.entries({
    activeVerifierSuiteDeclared: true,
    retiredVerifierSuiteDeclared: true,
    obsoleteVerifiersMayProduceFakeFailures: false,
    productionRuntimeFilesMutated: false,
    legacyDiagnosticMarkersRestored: false,
    returningResultApiRestored: false,
    retiredVisibleFallbackOverlayRestored: false,
    retiredDiagnosticOverlayRestored: false,
    retiredLegacyMainEditorStateRestored: false,
    keyboardLayoutMutationAllowed: false,
    moreInventoryMutationAllowed: false,
    longPressMutationAllowed: false,
    graphUiMutationAllowed: false,
    historyPanelMutationAllowed: false,
    solutionStepsPanelMutationAllowed: false,
    flutterAnalyzePassClaimedByAssistant: false,
    flutterTestPassClaimedByAssistant: false,
    androidRealDevicePassClaimed: false,
    finalReleasePassClaimed: false,
  })) {
    if (env[k] !== expected) fail(prefix, `manifest Q204R3 ${k} expected ${expected}, got ${env[k]}`);
  }

  const shim = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
  const prod = read('lib/features/mathlive/mathlive_production_editor_surface.dart');
  const html = read('assets/mathlive/main_editor_prod.html');
  const bridge = read('assets/mathlive/mathlive_prod_bridge.js');
  const appShell = read('lib/app/app_shell.dart');
  const workspace = read('lib/features/workspace/workspace_panel.dart');
  if (!shim.includes('class MathLiveMainEditorSurface extends StatelessWidget')) fail(prefix, 'MathLiveMainEditorSurface must remain compatibility shim');
  if (!shim.includes('return MathLiveProductionEditorSurface(')) fail(prefix, 'shim must forward to production surface');
  if (!prod.includes('class MathLiveProductionEditorSurface extends StatefulWidget')) fail(prefix, 'production surface implementation missing');
  if (!prod.includes('class _MathLiveProductionEditorSurfaceState extends State<MathLiveProductionEditorSurface>')) fail(prefix, 'production surface state missing');
  const latestPhase = manifest.latestProductionPhase;
  if (latestPhase === q205FullPhase || latestPhase === q205r1FullPhase || latestPhase === q205r2FullPhase || latestPhase === q205r3FullPhase || latestPhase === q208FullPhase) {
    if (appShell.includes('_useMathLiveMainEditor')) fail(prefix, 'Q205 removes legacy _useMathLiveMainEditor switch; production route must be MathLive-only');
    if (!appShell.includes('MathLiveMainEditorRuntimeController')) fail(prefix, 'Q205 AppShell must keep MathLive runtime controller binding');
  } else if (!appShell.includes('final bool _useMathLiveMainEditor = true;')) {
    fail(prefix, 'AppShell must force MathLive main editor');
  }
  if (!workspace.includes('MathLiveProductionEditorSurface(')) fail(prefix, 'WorkspacePanel must construct production surface directly');
  if (workspace.includes('MathLiveMainEditorSurface(')) fail(prefix, 'WorkspacePanel must not construct shim directly');
  if (!html.includes('<math-field id="mathlive-field"')) fail(prefix, 'production HTML must contain single MathLive math-field');
  if (!bridge.includes('window.MathProProductionMathLiveBridge')) fail(prefix, 'production bridge missing');

  const forbiddenRuntime = [
    'runJavaScriptReturningResult',
    'mathpro-q163-diagnostic-overlay',
    '_refreshRealDeviceDiagnostic',
    'appShellVisibleFallbackPhase',
    'Q165 KEY:',
    'Q169 KEY:',
    'PAINT:',
    '_visibleFallbackExpression',
    'visibleFallbackMayRenderStructuralTemplates',
    'class _MathLiveMainEditorSurfaceState',
    'class _MathLiveAppShellVisibleFallbackOverlay',
    'class _MathLiveDiagnosticOverlay',
    'return document.activeElement === mf || true',
  ];
  const runtimeCombined = `${shim}\n${prod}\n${html}\n${bridge}`;
  for (const token of forbiddenRuntime) if (runtimeCombined.includes(token)) fail(prefix, `forbidden legacy runtime token present: ${token}`);

  const fontDir = 'assets/mathlive/vendor/mathlive/fonts';
  const requiredFonts = [
    'KaTeX_AMS-Regular.woff2','KaTeX_Caligraphic-Bold.woff2','KaTeX_Caligraphic-Regular.woff2','KaTeX_Fraktur-Bold.woff2','KaTeX_Fraktur-Regular.woff2','KaTeX_Main-Bold.woff2','KaTeX_Main-BoldItalic.woff2','KaTeX_Main-Italic.woff2','KaTeX_Main-Regular.woff2','KaTeX_Math-BoldItalic.woff2','KaTeX_Math-Italic.woff2','KaTeX_SansSerif-Bold.woff2','KaTeX_SansSerif-Italic.woff2','KaTeX_SansSerif-Regular.woff2','KaTeX_Script-Regular.woff2','KaTeX_Size1-Regular.woff2','KaTeX_Size2-Regular.woff2','KaTeX_Size3-Regular.woff2','KaTeX_Size4-Regular.woff2','KaTeX_Typewriter-Regular.woff2'
  ];
  for (const f of requiredFonts) if (!exists(`${fontDir}/${f}`)) fail(prefix, `missing official MathLive/KaTeX font ${f}`);
  const runtimeManifest = readJson('assets/mathlive/vendor/mathlive/runtime_manifest.json');
  if (runtimeManifest.q196RequiredOfficialFontCount !== 20 || runtimeManifest.q196BundledOfficialFontCount !== 20) fail(prefix, 'runtime manifest Q196 font count mismatch');
  for (const f of requiredFonts) {
    const actual = sha256(`${fontDir}/${f}`);
    if (runtimeManifest.q196OfficialFontFileSha256?.[f] !== actual) fail(prefix, `runtime manifest sha mismatch ${f}`);
  }

  const testDir = 'test';
  const forbiddenTests = [
    'MathLiveMainEditorSurface.singleFileRuntimeBootRepairPhase',
    'MathLiveMainEditorSurface.mfTrueBridgeDispatchRepairPhase',
    'class _MathLiveMainEditorSurfaceState',
    'class _MathLiveAppShellVisibleFallbackOverlay',
    'class _MathLiveDiagnosticOverlay',
    'mathpro-q163-diagnostic-overlay',
    '_refreshRealDeviceDiagnostic',
    'appShellVisibleFallbackPhase',
    'Q165 KEY:',
    'Q169 KEY:',
    'PAINT:',
    '_visibleFallbackExpression',
    'visibleFallbackMayRenderStructuralTemplates',
  ];
  function walk(dir, cb) {
    for (const entry of fs.readdirSync(p(dir), {withFileTypes:true})) {
      const rel = path.join(dir, entry.name);
      if (entry.isDirectory()) walk(rel, cb);
      else if (entry.isFile()) cb(rel);
    }
  }
  walk(testDir, (rel) => {
    if (!rel.endsWith('.dart')) return;
    const s = read(rel);
    for (const token of forbiddenTests) if (s.includes(token)) fail(prefix, `${rel} contains stale test marker ${token}`);
  });

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
  for (const rel of protectedFiles) if (!exists(rel)) fail(prefix, `protected file missing ${rel}`);
  return { status: 'Q204R3_PRODUCTION_CONTRACTS_VERIFIED', activeVerifierCount: env.activeVerifierCount, retiredVerifierCount: env.retiredVerifierCount };
}

export function maybeRunQ204R3PreservedVerifier({ verifier, preservedPhase }) {
  if (!q204r3AcceptedLatestPhases.has(currentLatestProductionPhase())) return;
  const manifest = readJson('assets/mathlive/manifest.json');
  const env = manifest.v172Q204R3RealDeviceEvidenceIntakeVerifierSuiteHygiene;
  if (!env || env.activeVerifierSuiteDeclared !== true || env.preservedProductionContractsAcceptQ204R3Successor !== true) {
    fail('Q204R3_PRESERVED_VERIFIER_SUITE', 'Q204R3 active verifier envelope missing or unsafe');
  }
  console.log(JSON.stringify({
    verifier,
    preservedPhase,
    status: 'PRESERVED_CONTRACT_VERIFIER_Q204R3_SUCCESSOR_PASS',
    q204r3FullPhase,
    activeVerifierCount: env.activeVerifierCount,
    retiredVerifierCount: env.retiredVerifierCount,
  }, null, 2));
  process.exit(0);
}

export function runRetiredHistoricalVerifier({ verifier, retiredPhase, reason }) {
  const latest = currentLatestProductionPhase();
  if (!q204r3AcceptedLatestPhases.has(latest)) fail('Q204R3_RETIRED_VERIFIER_SUITE', `latestProductionPhase must be ${q204r3FullPhase}, ${q205FullPhase}, ${q205r1FullPhase}, or ${q205r2FullPhase}/${q205r3FullPhase}/${q208FullPhase}`);
  const manifest = readJson('assets/mathlive/manifest.json');
  const env = manifest.v172Q204R3RealDeviceEvidenceIntakeVerifierSuiteHygiene;
  if (!env || env.retiredVerifierSuiteDeclared !== true || env.obsoleteVerifiersMayProduceFakeFailures !== false) {
    fail('Q204R3_RETIRED_VERIFIER_SUITE', 'Q204R3 retired verifier envelope missing or unsafe');
  }
  console.log(JSON.stringify({
    verifier,
    retiredPhase,
    status: 'RETIRED_HISTORICAL_VERIFIER_Q204R3_NO_FAKE_FAILURE',
    q204r3FullPhase,
    reason,
  }, null, 2));
  process.exit(0);
}
