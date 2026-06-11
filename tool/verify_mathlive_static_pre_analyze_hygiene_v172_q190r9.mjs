#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_static_pre_analyze_hygiene_v172_q190r9.mjs', preservedPhase: 'verify_mathlive_static_pre_analyze_hygiene_v172_q190r9' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q190R9_STATIC_PRE_ANALYZE_HYGIENE_FAIL: ${msg}`); process.exit(1); };
const mustContain = (p, text) => { if (!read(p).includes(text)) fail(`${p} missing ${text}`); };
const mustNotContain = (p, text) => { if (read(p).includes(text)) fail(`${p} contains forbidden ${text}`); };

const phase = 'V172-Q190R9';
const surfacePath = 'lib/features/mathlive/mathlive_main_editor_surface.dart';
const bridgePath = 'assets/mathlive/mathlive_prod_bridge.js';
const htmlPath = 'assets/mathlive/main_editor_prod.html';
const manifestPath = 'assets/mathlive/manifest.json';
const policyPath = 'lib/features/mathlive/mathlive_static_pre_analyze_hygiene_policy.dart';

for (const p of [
  surfacePath,
  bridgePath,
  htmlPath,
  manifestPath,
  policyPath,
  'README.md',
  'docs/audit/V172_Q190R9_STATIC_PRE_ANALYZE_HYGIENE_AUDIT_REPORT.md',
  'docs/audit/V172_Q190R9_STATIC_PRE_ANALYZE_HYGIENE_CHANGED_FILES_MANIFEST.md',
  'docs/audit/V172_Q190R9_PROTECTED_FILE_HASH_MANIFEST.md',
]) {
  if (!exists(p)) fail(`missing required file ${p}`);
}

mustContain(policyPath, `static const String phase = '${phase}'`);
mustContain('README.md', 'V172-Q190R9 — Static Pre-Analyze Hygiene Closure');
mustContain('docs/audit/V172_Q190R9_STATIC_PRE_ANALYZE_HYGIENE_AUDIT_REPORT.md', 'V172-Q190R9 Static Pre-Analyze Hygiene Audit Report');
mustContain('docs/audit/V172_Q190R9_STATIC_PRE_ANALYZE_HYGIENE_CHANGED_FILES_MANIFEST.md', 'V172-Q190R9 Static Pre-Analyze Hygiene Changed Files Manifest');
mustContain('docs/audit/V172_Q190R9_PROTECTED_FILE_HASH_MANIFEST.md', 'V172-Q190R9 Protected File Hash Manifest');
mustContain(policyPath, 'localDartImportsMustResolve = true');
mustContain(policyPath, 'packageDartImportsMustResolveToLib = true');
mustContain(policyPath, 'productionHelpersMayExistOnlyInProductionState = true');
mustContain(policyPath, 'productionClassMayUseRunJavaScriptReturningResult = false');
mustContain(policyPath, 'protectedFilesMayContainQ190R9Markers = false');
mustContain(surfacePath, "import 'mathlive_static_pre_analyze_hygiene_policy.dart';");

const productionSurfacePath = 'lib/features/mathlive/mathlive_production_editor_surface.dart';
if (!exists(productionSurfacePath)) fail('missing separated production surface file');
const surface = read(surfacePath) + '\n' + read(productionSurfacePath);
if (!surface.includes("'staticPreAnalyzeHygienePhase': MathLiveStaticPreAnalyzeHygienePolicy.phase")) fail('separated production surface missing Q190R9 static hygiene payload marker');
const legacyStart = surface.indexOf('class _MathLiveMainEditorSurfaceState');
const productionStart = surface.indexOf('class _MathLiveProductionEditorSurfaceState');
if (productionStart < 0) fail('production class missing');
if (legacyStart >= 0 && legacyStart > productionStart) fail('legacy class appears after production class');
const legacy = legacyStart >= 0 ? surface.slice(legacyStart, productionStart) : '';
if (legacyStart < 0 && !surface.includes('legacyImplementationPhysicallyRemoved = true')) fail('legacy class absent without Q194 cleanup marker');
const production = surface.slice(productionStart);
for (const forbidden of ['_enqueueProductionCommand', '_productionCommandTail', '_refreshProductionStateDeferred', 'q190r9']) {
  if (legacy.includes(forbidden)) fail(`legacy state contains forbidden production/pre-analyze marker: ${forbidden}`);
}
for (const required of ['_enqueueProductionCommand', '_productionCommandTail', '_refreshProductionStateDeferred', 'MathLiveStaticPreAnalyzeHygienePolicy.phase']) {
  if (!production.includes(required)) fail(`production state missing required ${required}`);
}
if (production.includes('runJavaScriptReturningResult')) fail('production state reintroduced runJavaScriptReturningResult');
if (!(production.includes('return Future<bool>.value(true);') || production.includes('return true;'))) fail('production sendKey no-freeze return invariant missing');

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
  if (read(p).includes('Q190R9') || read(p).includes('StaticPreAnalyzeHygiene')) fail(`protected file polluted with Q190R9 marker: ${p}`);
}

// Dart import resolution that does not require the Dart SDK.
const dartFiles = [];
function walk(dir) {
  for (const entry of fs.readdirSync(path.join(root, dir), { withFileTypes: true })) {
    const rel = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      if (['build', '.dart_tool', '.gradle', '.idea'].includes(entry.name)) continue;
      walk(rel);
    } else if (entry.isFile() && entry.name.endsWith('.dart')) {
      dartFiles.push(rel);
    }
  }
}
for (const dir of ['lib', 'test']) if (exists(dir)) walk(dir);
const importRe = /^\s*import\s+['"]([^'"]+)['"]/gm;
for (const file of dartFiles) {
  const src = read(file);
  let m;
  while ((m = importRe.exec(src)) !== null) {
    const spec = m[1];
    if (spec.startsWith('dart:') || spec.startsWith('package:flutter') || spec.startsWith('package:webview_flutter') || spec.startsWith('package:provider') || spec.startsWith('package:shared_preferences')) continue;
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

// Static asset truth and production route checks.
mustContain(htmlPath, '__MATHPRO_INLINE_MATHLIVE_STATIC_CSS__');
if (!surface.includes('MathLiveProductionEditorSurface.staticCssAssetPath')) fail('separated production surface missing static CSS asset load marker');
if (!surface.includes('_q190r8ProductionCssWithoutMissingFontFaces')) fail('separated production surface missing Q190R8 font sanitizer helper');
mustContain(bridgePath, 'noFreezeRuntimeInvariantPhase');
mustContain(bridgePath, 'normalizeProductionDocumentPayload');
mustContain(bridgePath, 'q190r6-js-queue-flush-request-nonblocking');
mustContain(bridgePath, 'q190r5-js-template-payload-converted-to-document-placeholder');
mustContain(bridgePath, 'q190r5-js-template-raw-token-fallback-blocked');

const forbiddenDirs = ['build', '.dart_tool', '.gradle', '.idea', 'node_modules', '__pycache__'];
for (const dir of forbiddenDirs) {
  if (exists(dir)) fail(`forbidden package hygiene directory present: ${dir}`);
}

const manifest = JSON.parse(read(manifestPath));
if (!['V172-Q190R9-STATIC-PRE-ANALYZE-HYGIENE-CLOSURE', 'V172-Q191-RUNTIME-RENDER-CONTRACT-CLOSURE', 'V172-Q192-CARET-FOCUS-SLOT-CONTRACT-CLOSURE', 'V172-Q193-REAL-MATHLIVE-FONT-BUNDLE-CLOSURE', 'V172-Q194-PHYSICAL-LEGACY-CLEANUP', 'V172-Q195-FINAL-STATIC-RELEASE-FREEZE', 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) fail('latestProductionPhase not Q190R9 or verified successor through Q197');
if (!manifest.v172Q190R9StaticPreAnalyzeHygieneClosure) fail('missing Q190R9 manifest envelope');
if (manifest.v172Q190R9StaticPreAnalyzeHygieneClosure.flutterAnalyzePassClaimedByAssistant !== false) fail('manifest falsely claims flutter analyze PASS');
if (manifest.v172Q190R9StaticPreAnalyzeHygieneClosure.localDartImportsResolvedByStaticGate !== true) fail('manifest missing import resolution truth');

console.log('MATHLIVE_STATIC_PRE_ANALYZE_HYGIENE_Q190R9_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
