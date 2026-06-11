#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_physical_legacy_cleanup_v172_q194.mjs', preservedPhase: 'verify_mathlive_physical_legacy_cleanup_v172_q194' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q194_PHYSICAL_LEGACY_CLEANUP_FAIL: ${msg}`); process.exit(1); };
const mustContain = (p, text) => { if (!read(p).includes(text)) fail(`${p} missing ${text}`); };
const mustNotContain = (p, text) => { if (read(p).includes(text)) fail(`${p} contains forbidden ${text}`); };

const phase = 'V172-Q194';
const surfacePath = 'lib/features/mathlive/mathlive_main_editor_surface.dart';
const policyPath = 'lib/features/mathlive/mathlive_physical_legacy_cleanup_policy.dart';
const manifestPath = 'assets/mathlive/manifest.json';
const readmePath = 'README.md';

for (const p of [
  surfacePath,
  policyPath,
  manifestPath,
  readmePath,
  'test/v172_q194_physical_legacy_cleanup_test.dart',
  'docs/audit/V172_Q194_PHYSICAL_LEGACY_CLEANUP_AUDIT_REPORT.md',
  'docs/audit/V172_Q194_PHYSICAL_LEGACY_CLEANUP_CHANGED_FILES_MANIFEST.md',
  'docs/audit/V172_Q194_PROTECTED_FILE_HASH_MANIFEST.md',
]) {
  if (!exists(p)) fail(`missing required file ${p}`);
}

mustContain(policyPath, `static const String phase = '${phase}'`);
mustContain(policyPath, 'legacyMainEditorStatePhysicallyRemoved = true');
mustContain(policyPath, 'visibleFallbackOverlayPhysicallyRemoved = true');
mustContain(policyPath, 'diagnosticOverlayPhysicallyRemoved = true');
mustContain(policyPath, 'compatibilityShimForwardsToProductionSurface = true');
mustContain(policyPath, 'staleLegacyCallSiteMayReviveQ169Surface = false');
mustContain(policyPath, 'fallbackMirrorMayOwnVisibleEditor = false');
mustContain(policyPath, 'flutterAnalyzePassClaimedByAssistant = false');
mustContain(policyPath, 'androidRealDevicePassClaimed = false');

const productionSurfacePath = 'lib/features/mathlive/mathlive_production_editor_surface.dart';
const surface = read(surfacePath) + '\n' + (exists(productionSurfacePath) ? read(productionSurfacePath) : '');
if (!surface.includes("import 'mathlive_physical_legacy_cleanup_policy.dart';")) fail('surface missing Q194 policy import');
if (!surface.includes('class MathLiveMainEditorSurface extends StatelessWidget')) fail('public compatibility shim missing');
if (!surface.includes('return MathLiveProductionEditorSurface(')) fail('compatibility shim does not forward to production surface');
if (!surface.includes('static const String physicalLegacyCleanupPhase = MathLivePhysicalLegacyCleanupPolicy.phase;')) fail('compatibility shim missing cleanup phase constant');
if (!surface.includes('legacyImplementationPhysicallyRemoved = true')) fail('surface missing legacy cleanup marker');
for (const forbidden of [
  'class _MathLiveMainEditorSurfaceState',
  'class _MathLiveAppShellVisibleFallbackOverlay',
  'class _MathLiveDiagnosticOverlay',
  '_visibleFallbackExpression',
  'mathpro-q165-appshell-visible-fallback-overlay',
]) {
  if (surface.includes(forbidden)) fail(`surface still contains legacy artifact: ${forbidden}`);
}
if (!surface.includes('class _MathLiveProductionEditorSurfaceState')) fail('production state missing');
if (surface.includes('runJavaScriptReturningResult')) fail('production surface reintroduced returning-result state read');
if (!surface.includes("'physicalLegacyCleanupPhase': MathLivePhysicalLegacyCleanupPolicy.phase")) fail('production payload missing Q194 phase');
if (!surface.includes("'legacyImplementationPhysicallyRemoved': MathLivePhysicalLegacyCleanupPolicy.legacyMainEditorStatePhysicallyRemoved")) fail('production payload missing legacy removed truth');

mustContain('lib/features/workspace/workspace_panel.dart', 'MathLiveProductionEditorSurface(');
mustContain('lib/app/app_shell.dart', 'final bool _useMathLiveMainEditor = true;');
mustContain(manifestPath, 'v172Q194PhysicalLegacyCleanup');
mustContain(manifestPath, 'V172-Q194-PHYSICAL-LEGACY-CLEANUP', 'V172-Q195-FINAL-STATIC-RELEASE-FREEZE', 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION');
mustContain(manifestPath, 'latestProductionPhase');
mustContain(readmePath, 'V172-Q194 — Physical Legacy Cleanup');

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
  const src = read(p);
  if (src.includes('Q194') || src.includes('PhysicalLegacyCleanup')) fail(`protected file polluted by Q194 marker: ${p}`);
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

console.log('MATHLIVE_PHYSICAL_LEGACY_CLEANUP_Q194_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
