#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_legacy_marker_policy_verifier_cleanup_v172_q198.mjs', preservedPhase: 'verify_mathlive_legacy_marker_policy_verifier_cleanup_v172_q198' });

const root = process.cwd();
const exists = (p) => fs.existsSync(path.join(root, p));
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const fail = (m) => { console.error(`Q198_LEGACY_MARKER_POLICY_VERIFIER_CLEANUP_FAIL: ${m}`); process.exit(1); };
const must = (p, s) => { if (!exists(p) || !read(p).includes(s)) fail(`${p} missing ${s}`); };
const mustNot = (p, s) => { if (exists(p) && read(p).includes(s)) fail(`${p} contains forbidden ${s}`); };

const phaseFull = 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP';
const files = {
  main: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prod: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  bridge: 'assets/mathlive/mathlive_prod_bridge.js',
  html: 'assets/mathlive/main_editor_prod.html',
  manifest: 'assets/mathlive/manifest.json',
  cleanupPolicy: 'lib/features/mathlive/mathlive_legacy_marker_policy_verifier_cleanup_policy.dart',
  platformPolicy: 'lib/features/mathlive/mathlive_production_platform_view_policy.dart',
  tracePolicy: 'lib/features/mathlive/mathlive_production_command_trace_policy.dart',
  verifier: 'tool/verify_mathlive_legacy_marker_policy_verifier_cleanup_v172_q198.mjs',
  test: 'test/v172_q198_legacy_marker_policy_verifier_cleanup_test.dart',
};
for (const p of Object.values(files)) if (!exists(p)) fail(`missing required file ${p}`);

const main = read(files.main);
const prod = read(files.prod);
const bridge = read(files.bridge);
const active = `${main}\n${prod}\n${bridge}`;

must(files.cleanupPolicy, "static const String phase = 'V172-Q198'");
must(files.cleanupPolicy, 'activeProductionSourceImportsHistoricalLabPolicy = false');
must(files.cleanupPolicy, 'activeProductionSourceImportsHistoricalDiagnosticPolicy = false');
must(files.cleanupPolicy, 'activeProductionSourceImportsHistoricalCourtPolicy = false');
must(files.cleanupPolicy, 'activeProductionSourceContainsHistoricalMarkerWall = false');
must(files.cleanupPolicy, 'compatibilityShimMayRenderFallback = false');
must(files.cleanupPolicy, 'compatibilityShimForwardsToProductionSurface = true');
must(files.platformPolicy, 'usesLabPolicyForProductionWebView = false');
must(files.platformPolicy, 'canUseProductionWebView');
must(files.tracePolicy, "static const String phase = 'V172-Q198'");
must(files.tracePolicy, 'traceStateIntoSelectionDescription = true');
must(files.tracePolicy, 'visualDebugOverlayAllowed = false');

// Active production source must not depend on historical lab/diagnostic/court policy imports.
for (const forbidden of [
  "import 'mathlive_lab_screen_policy.dart';",
  "import 'mathlive_real_device_diagnostic_bridge_policy.dart';",
  "import 'mathlive_final_self_test_court_policy.dart';",
  "import 'mathlive_channel_push_self_test_hard_binding_policy.dart';",
  "import 'mathlive_production_command_bus_court_policy.dart';",
  'MathLiveLabScreenPolicy',
  'MathLiveRealDeviceDiagnosticBridgePolicy',
  'MathLiveFinalSelfTestCourtPolicy',
  'MathLiveChannelPushSelfTestHardBindingPolicy',
  'MathLiveProductionCommandBusCourtPolicy',
  'commandBusCourtPhase',
  'runQ169FinalSelfTestCourt',
  '_q169',
  '_noteQ169',
  'Q169R',
  'q169r',
]) {
  if (active.includes(forbidden)) fail(`active production source still contains historical marker/dependency: ${forbidden}`);
}

must(files.main, "import 'mathlive_production_platform_view_policy.dart';");
must(files.main, "import 'mathlive_production_command_trace_policy.dart';");
must(files.main, "import 'mathlive_legacy_marker_policy_verifier_cleanup_policy.dart';");
must(files.main, 'class MathLiveMainEditorSurface extends StatelessWidget');
must(files.main, 'return MathLiveProductionEditorSurface(');
must(files.main, 'staleCompatibilityShimMayRenderFallback = false');
must(files.main, 'webViewAssetPath = MathLiveProductionEditorSurface.webViewAssetPath');
must(files.main, '_productionMayFlushQueuedCommands');
must(files.main, '_noteProductionQueueFlush');
must(files.main, '_noteProductionQueueFlushCompleted');
mustNot(files.main, 'class _MathLiveMainEditorSurfaceState');
mustNot(files.main, 'class _MathLiveAppShellVisibleFallbackOverlay');
mustNot(files.main, 'class _MathLiveDiagnosticOverlay');

must(files.prod, 'MathLiveProductionPlatformViewPolicy.canUseProductionWebView');
must(files.prod, 'MathLiveProductionCommandTracePolicy.phase');
must(files.prod, "'commandTracePhase': MathLiveProductionCommandTracePolicy.phase");
must(files.prod, 'MathLiveProductionCommandTracePolicy.traceStateIntoSelectionDescription');
mustNot(files.prod, 'runJavaScriptReturningResult');
mustNot(files.prod, 'MathLiveLabScreenPolicy');
mustNot(files.prod, 'MathLiveProductionCommandBusCourtPolicy');

must(files.bridge, 'commandTracePhase: COMMAND_TRACE_PHASE');
must(files.bridge, "const COMMAND_TRACE_PHASE = 'V172-Q190R3'");
mustNot(files.bridge, 'commandBusCourtPhase');
mustNot(files.bridge, 'COMMAND_BUS_COURT_PHASE');

const manifest = JSON.parse(read(files.manifest));
if (![phaseFull, 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) fail(`latestProductionPhase must be ${phaseFull} or verified Q199 successor`);
const env = manifest.v172Q198LegacyMarkerPolicyVerifierCleanup;
if (!env) fail('missing Q198 manifest envelope');
for (const [key, expected] of Object.entries({
  phase: 'V172-Q198',
  fullPhase: phaseFull,
  activeProductionSourceImportsHistoricalLabPolicy: false,
  activeProductionSourceImportsHistoricalDiagnosticPolicy: false,
  activeProductionSourceImportsHistoricalCourtPolicy: false,
  activeProductionSourceContainsQ169MarkerWall: false,
  compatibilityShimForwardsToProductionSurface: true,
  compatibilityShimMayRenderFallback: false,
  productionPlatformViewPolicyOwnsWebViewAvailability: true,
  productionCommandTraceReplacesCommandCourtTerminology: true,
  keyboardLayoutMutationAllowed: false,
  moreInventoryMutationAllowed: false,
  longPressMutationAllowed: false,
  graphUiMutationAllowed: false,
  historyPanelMutationAllowed: false,
  solutionStepsPanelMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  flutterRunPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
  finalReleasePassClaimed: false,
})) {
  if (env[key] !== expected) fail(`manifest Q198 ${key} expected ${expected}`);
}

const workspace = read('lib/features/workspace/workspace_panel.dart');
const appShell = read('lib/app/app_shell.dart');
if (!appShell.includes('final bool _useMathLiveMainEditor = true;')) fail('AppShell does not force MathLive main editor');
if (!workspace.includes('MathLiveProductionEditorSurface(')) fail('WorkspacePanel does not construct production surface');
if (workspace.includes('MathLiveMainEditorSurface(')) fail('WorkspacePanel constructs compatibility shim directly');

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
for (const p of protectedFiles) {
  if (!exists(p)) fail(`protected file missing ${p}`);
  const text = read(p);
  for (const marker of ['Q198', 'LegacyMarkerPolicyVerifierCleanup', 'ProductionCommandTracePolicy']) {
    if (text.includes(marker)) fail(`protected file polluted by Q198 marker ${marker}: ${p}`);
  }
}

// Static Dart import/part resolution without Dart SDK.
const dartFiles = [];
function walkDart(dir) {
  for (const entry of fs.readdirSync(path.join(root, dir), { withFileTypes: true })) {
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
      const libRel = spec.replace('package:mathpro_flutter_phase17/', 'lib/');
      if (!exists(libRel)) fail(`${file} imports missing package target ${spec}`);
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

const forbiddenDirs = ['build', '.dart_tool', '.gradle', '.idea', 'node_modules', '__pycache__', '.pytest_cache'];
function walk(rel) {
  for (const entry of fs.readdirSync(path.join(root, rel), { withFileTypes: true })) {
    const p = path.join(rel, entry.name);
    if (entry.isDirectory()) {
      if (forbiddenDirs.includes(entry.name)) fail(`forbidden directory present: ${p}`);
      walk(p);
    } else if (entry.isFile()) {
      if (entry.name.endsWith('.pyc')) fail(`forbidden pyc present: ${p}`);
      if (entry.name.endsWith('.zip') || entry.name.endsWith('.apk') || entry.name.endsWith('.aab')) fail(`forbidden nested artifact present: ${p}`);
    }
  }
}
walk('.');

must('README.md', 'V172-Q198 — Legacy Marker / Policy / Verifier Cleanup');
must('docs/audit/V172_Q198_LEGACY_MARKER_POLICY_VERIFIER_CLEANUP_AUDIT_REPORT.md', 'V172-Q198 — Legacy Marker / Policy / Verifier Cleanup');
must('docs/audit/V172_Q198_LEGACY_MARKER_POLICY_VERIFIER_CLEANUP_CHANGED_FILES_MANIFEST.md', 'V172-Q198 changed files');
must('docs/audit/V172_Q198_PROTECTED_FILE_HASH_MANIFEST.md', 'PROTECTED_HASH_UNCHANGED');

console.log('MATHLIVE_LEGACY_MARKER_POLICY_VERIFIER_CLEANUP_Q198_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
