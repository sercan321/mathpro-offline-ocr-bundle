#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_surface_file_separation_v172_q197.mjs', preservedPhase: 'verify_mathlive_production_surface_file_separation_v172_q197' });

const root = process.cwd();
const exists = (p) => fs.existsSync(path.join(root, p));
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const fail = (m) => { console.error(`Q197_PRODUCTION_SURFACE_FILE_SEPARATION_FAIL: ${m}`); process.exit(1); };
const must = (p, s) => { if (!exists(p) || !read(p).includes(s)) fail(`${p} missing ${s}`); };
const mustNot = (p, s) => { if (exists(p) && read(p).includes(s)) fail(`${p} contains forbidden ${s}`); };

const main = 'lib/features/mathlive/mathlive_main_editor_surface.dart';
const prod = 'lib/features/mathlive/mathlive_production_editor_surface.dart';
const policy = 'lib/features/mathlive/mathlive_production_surface_file_separation_policy.dart';
const manifestPath = 'assets/mathlive/manifest.json';
const required = [
  main,
  prod,
  policy,
  'test/v172_q197_production_surface_file_separation_test.dart',
  'tool/verify_mathlive_production_surface_file_separation_v172_q197.mjs',
  'docs/audit/V172_Q197_PRODUCTION_SURFACE_FILE_SEPARATION_AUDIT_REPORT.md',
  'docs/audit/V172_Q197_PRODUCTION_SURFACE_FILE_SEPARATION_CHANGED_FILES_MANIFEST.md',
  'docs/audit/V172_Q197_PROTECTED_FILE_HASH_MANIFEST.md',
  manifestPath,
  'README.md',
  'assets/mathlive/main_editor_prod.html',
  'assets/mathlive/mathlive_prod_bridge.js',
];
for (const p of required) if (!exists(p)) fail(`missing required file ${p}`);

must(policy, "static const String phase = 'V172-Q197'");
must(policy, 'productionImplementationPhysicallySeparated = true');
must(policy, "productionSurfacePartPath = 'lib/features/mathlive/mathlive_production_editor_surface.dart'");
must(policy, 'compatibilityShimMustForwardToProductionSurface = true');
must(policy, 'legacyStateImplementationMayReturn = false');
must(policy, 'fallbackOverlayMayReturn = false');
must(policy, 'diagnosticOverlayMayReturn = false');
must(policy, 'keyboardLayoutMutationAllowed = false');
must(policy, 'moreInventoryMutationAllowed = false');
must(policy, 'longPressMutationAllowed = false');
must(policy, 'graphUiMutationAllowed = false');
must(policy, 'historyPanelMutationAllowed = false');
must(policy, 'solutionStepsPanelMutationAllowed = false');

const mainSrc = read(main);
const prodSrc = read(prod);
const combined = `${mainSrc}\n${prodSrc}`;
if (!mainSrc.includes("part 'mathlive_production_editor_surface.dart';")) fail('main file missing production part directive');
if (!prodSrc.startsWith("part of 'mathlive_main_editor_surface.dart';")) fail('production file must be part of main editor library for private runtime controller contract');
if (mainSrc.includes('class _MathLiveProductionEditorSurfaceState')) fail('production state implementation still lives in main editor file');
if (mainSrc.includes('class MathLiveProductionEditorSurface extends StatefulWidget')) fail('production widget implementation still lives in main editor file');
if (!prodSrc.includes('class MathLiveProductionEditorSurface extends StatefulWidget')) fail('production widget missing from separated file');
if (!prodSrc.includes('class _MathLiveProductionEditorSurfaceState extends State<MathLiveProductionEditorSurface>')) fail('production state missing from separated file');
if (!prodSrc.includes('productionSurfaceFileSeparationPhase = MathLiveProductionSurfaceFileSeparationPolicy.phase')) fail('production widget missing Q197 phase marker');
if (!prodSrc.includes("'productionSurfaceFileSeparationPhase': MathLiveProductionSurfaceFileSeparationPolicy.phase")) fail('production payload missing Q197 phase marker');
if (!mainSrc.includes("import 'mathlive_production_surface_file_separation_policy.dart';")) fail('main library missing Q197 policy import');

if (!mainSrc.includes('class MathLiveMainEditorSurface extends StatelessWidget')) fail('compatibility shim missing');
if (!mainSrc.includes('return MathLiveProductionEditorSurface(')) fail('compatibility shim does not forward to production surface');
for (const forbidden of [
  'class _MathLiveMainEditorSurfaceState',
  'class _MathLiveAppShellVisibleFallbackOverlay',
  'class _MathLiveDiagnosticOverlay',
  '_visibleFallbackExpression',
  'mathpro-q165-appshell-visible-fallback-overlay',
]) {
  if (combined.includes(forbidden)) fail(`forbidden legacy runtime artifact present: ${forbidden}`);
}
if (prodSrc.includes('runJavaScriptReturningResult')) fail('separated production state reintroduced runJavaScriptReturningResult');
for (const requiredMarker of [
  '_enqueueProductionCommand',
  '_productionCommandTail',
  '_refreshProductionStateDeferred',
  'MathLiveOfficialFontBundleIngestionPolicy.phase',
  'MathLiveOfficialFontBundleIngestionPolicy.phase',
  'MathLiveRuntimeRenderContractPolicy.phase',
  'MathLiveCaretFocusSlotContractPolicy.phase',
]) {
  if (!prodSrc.includes(requiredMarker)) fail(`separated production file missing ${requiredMarker}`);
}

const workspace = read('lib/features/workspace/workspace_panel.dart');
const appShell = read('lib/app/app_shell.dart');
if (!appShell.includes('final bool _useMathLiveMainEditor = true;')) fail('AppShell does not force MathLive main editor');
if (!workspace.includes('MathLiveProductionEditorSurface(')) fail('WorkspacePanel does not construct production surface');
if (workspace.includes('MathLiveMainEditorSurface(')) fail('WorkspacePanel constructs legacy compatibility shim directly');

const manifest = JSON.parse(read(manifestPath));
if (!['V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) fail('latestProductionPhase must be Q197 or verified Q198/Q199 successor');
const env = manifest.v172Q197ProductionSurfaceFileSeparation;
if (!env) fail('missing Q197 manifest envelope');
for (const [key, expected] of Object.entries({
  phase: 'V172-Q197',
  productionImplementationPhysicallySeparated: true,
  productionSurfacePartFile: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  compatibilityShimFile: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  compatibilityShimForwardsToProductionSurface: true,
  legacyStateImplementationMayReturn: false,
  fallbackOverlayMayReturn: false,
  diagnosticOverlayMayReturn: false,
  productionPartDirectiveRequired: true,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  flutterRunPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
  premiumSymbolVisualPassClaimed: false,
  caretRealDevicePassClaimed: false,
  finalReleasePassClaimed: false,
})) {
  if (env[key] !== expected) fail(`manifest Q197 ${key} expected ${expected}`);
}

must('assets/mathlive/main_editor_prod.html', '<math-field id="mathlive-field"');
must('assets/mathlive/main_editor_prod.html', 'virtual-keyboard-mode="off"');
must('assets/mathlive/mathlive_prod_bridge.js', 'window.MathProProductionMathLiveBridge');

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
  for (const marker of ['Q197', 'ProductionSurfaceFileSeparation']) {
    if (text.includes(marker)) fail(`protected file polluted by Q197 marker ${marker}: ${p}`);
  }
}

// Static part/import resolution without Dart SDK.
const partRe = /^\s*part\s+['"]([^'"]+)['"]/gm;
let partMatch;
while ((partMatch = partRe.exec(mainSrc)) !== null) {
  const target = path.normalize(path.join(path.dirname(main), partMatch[1]));
  if (!exists(target)) fail(`main file has missing part target ${partMatch[1]} -> ${target}`);
}
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

console.log('MATHLIVE_PRODUCTION_SURFACE_FILE_SEPARATION_Q197_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
