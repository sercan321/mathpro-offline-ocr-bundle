#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_final_static_release_freeze_v172_q195.mjs', preservedPhase: 'verify_mathlive_final_static_release_freeze_v172_q195' });

const root = process.cwd();
const exists = (p) => fs.existsSync(path.join(root, p));
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const fail = (msg) => { console.error(`Q195_FINAL_STATIC_RELEASE_FREEZE_FAIL: ${msg}`); process.exit(1); };
const mustContain = (p, text) => { if (!read(p).includes(text)) fail(`${p} missing ${text}`); };
const mustNotContain = (p, text) => { if (read(p).includes(text)) fail(`${p} contains forbidden ${text}`); };

const phaseFull = 'V172-Q195-FINAL-STATIC-RELEASE-FREEZE';
const required = [
  'lib/features/mathlive/mathlive_final_static_release_freeze_policy.dart',
  'test/v172_q195_final_static_release_freeze_test.dart',
  'tool/verify_mathlive_final_static_release_freeze_v172_q195.mjs',
  'docs/audit/V172_Q195_FINAL_STATIC_RELEASE_FREEZE_AUDIT_REPORT.md',
  'docs/audit/V172_Q195_FINAL_STATIC_RELEASE_FREEZE_CHANGED_FILES_MANIFEST.md',
  'docs/audit/V172_Q195_PROTECTED_FILE_HASH_MANIFEST.md',
  'assets/mathlive/manifest.json',
  'README.md',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'assets/mathlive/main_editor_prod.html',
  'assets/mathlive/mathlive_prod_bridge.js',
];
for (const p of required) if (!exists(p)) fail(`missing required file ${p}`);

const policy = 'lib/features/mathlive/mathlive_final_static_release_freeze_policy.dart';
mustContain(policy, "static const String phase = 'V172-Q195'");
mustContain(policy, 'finalStaticCandidate = true');
mustContain(policy, 'newRuntimeBehaviorAllowed = false');
mustContain(policy, 'activeProductionRouteFrozen = true');
mustContain(policy, 'compatibilityShimForwardingRequired = true');
mustContain(policy, 'physicalLegacyCleanupRequired = true');
mustContain(policy, 'fakeFontBundleClosureAllowed = false');
mustContain(policy, 'q193FontBundleStillBlockedUntilOfficialFontsPresent = true');
mustContain(policy, 'keyboardLayoutMutationAllowed = false');
mustContain(policy, 'moreInventoryMutationAllowed = false');
mustContain(policy, 'longPressMutationAllowed = false');
mustContain(policy, 'graphUiMutationAllowed = false');
mustContain(policy, 'historyPanelMutationAllowed = false');
mustContain(policy, 'solutionStepsPanelMutationAllowed = false');
mustContain(policy, 'flutterAnalyzePassClaimedByAssistant = false');
mustContain(policy, 'flutterTestPassClaimedByAssistant = false');
mustContain(policy, 'flutterRunPassClaimedByAssistant = false');
mustContain(policy, 'androidRealDevicePassClaimed = false');
mustContain(policy, 'premiumSymbolVisualPassClaimed = false');
mustContain(policy, 'caretRealDevicePassClaimed = false');
mustContain(policy, 'finalReleasePassClaimed = false');

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
if (![phaseFull, 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) fail(`latestProductionPhase must be ${phaseFull} or verified successor through Q197`);
if (!manifest.v172Q195FinalStaticReleaseFreeze) fail('missing v172Q195FinalStaticReleaseFreeze manifest envelope');
const env = manifest.v172Q195FinalStaticReleaseFreeze;
if (env.phase !== 'V172-Q195') fail('Q195 manifest phase mismatch');
if (env.finalStaticCandidate !== true) fail('Q195 manifest must mark finalStaticCandidate true');
for (const [k, expected] of Object.entries({
  newRuntimeBehaviorAllowed: false,
  activeProductionRouteFrozen: true,
  physicalLegacyCleanupRequired: true,
  physicalLegacyCleanupCompletedForLegacySurfaceState: true,
  compatibilityShimForwardsToProductionSurface: true,
  q193FontBundleStillBlockedUntilOfficialFontsPresent: true,
  fakeFontBundleClosureAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  flutterRunPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
  premiumSymbolVisualPassClaimed: false,
  caretRealDevicePassClaimed: false,
  finalReleasePassClaimed: false,
})) {
  if (env[k] !== expected) fail(`manifest Q195 ${k} expected ${expected}`);
}

const appShell = read('lib/app/app_shell.dart');
const workspace = read('lib/features/workspace/workspace_panel.dart');
const productionSurfacePath = 'lib/features/mathlive/mathlive_production_editor_surface.dart';
const surface = read('lib/features/mathlive/mathlive_main_editor_surface.dart') + '\n' + (exists(productionSurfacePath) ? read(productionSurfacePath) : '');
if (!appShell.includes('final bool _useMathLiveMainEditor = true;')) fail('AppShell does not force MathLive main editor');
if (!workspace.includes('MathLiveProductionEditorSurface(')) fail('WorkspacePanel does not construct production surface');
if (workspace.includes('MathLiveMainEditorSurface(')) fail('WorkspacePanel constructs legacy compatibility shim directly');
if (!surface.includes('class MathLiveMainEditorSurface extends StatelessWidget')) fail('compatibility shim missing');
if (!surface.includes('return MathLiveProductionEditorSurface(')) fail('compatibility shim must forward to production');
for (const forbidden of [
  'class _MathLiveMainEditorSurfaceState',
  'class _MathLiveAppShellVisibleFallbackOverlay',
  'class _MathLiveDiagnosticOverlay',
  '_visibleFallbackExpression',
  'mathpro-q165-appshell-visible-fallback-overlay',
  'runJavaScriptReturningResult',
]) {
  if (surface.includes(forbidden)) fail(`surface contains forbidden legacy/returning artifact: ${forbidden}`);
}
if (!surface.includes('class _MathLiveProductionEditorSurfaceState')) fail('production state missing');
if (!surface.includes('MathLivePhysicalLegacyCleanupPolicy.phase')) fail('surface missing Q194 physical cleanup phase');
if (!surface.includes('MathLiveCaretFocusSlotContractPolicy.phase')) fail('surface missing Q192 caret contract phase');
if (!surface.includes('MathLiveRuntimeRenderContractPolicy.phase')) fail('surface missing Q191 runtime render phase');

mustContain('assets/mathlive/main_editor_prod.html', '<math-field id="mathlive-field"');
mustContain('assets/mathlive/main_editor_prod.html', 'virtual-keyboard-mode="off"');
mustContain('assets/mathlive/main_editor_prod.html', '__MATHPRO_INLINE_MATHLIVE_RUNTIME__');
mustContain('assets/mathlive/main_editor_prod.html', '__MATHPRO_INLINE_PRODUCTION_BRIDGE__');
mustContain('assets/mathlive/mathlive_prod_bridge.js', 'window.MathProProductionMathLiveBridge');
mustContain('assets/mathlive/mathlive_prod_bridge.js', 'noFreezeRuntimeInvariantPhase');
mustContain('assets/mathlive/mathlive_prod_bridge.js', 'normalizeProductionDocumentPayload');
mustContain('assets/mathlive/mathlive_prod_bridge.js', 'q190r6-js-queue-flush-request-nonblocking');
mustContain('assets/mathlive/mathlive_prod_bridge.js', 'q190r5-js-template-payload-converted-to-document-placeholder');

const fontEvidence = 'docs/evidence/V172_Q193_REQUIRED_MATHLIVE_FONT_FILES.json';
if (!exists(fontEvidence)) fail('missing Q193 required font evidence file');
const font = JSON.parse(read(fontEvidence));
const q196Successor = ['V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase);
if (!q196Successor && (font.presentOfficialFontCount ?? font.presentFontCount) !== 0) fail('Q195 expected font truth to remain blocked with 0 bundled official fonts before Q196');
if (q196Successor && (font.presentOfficialFontCount ?? font.presentFontCount) !== 20) fail('Q195 verified Q196/Q197 successor must record 20 bundled official fonts');
if (!manifest.v172Q193RealMathLiveFontBundleClosure) fail('missing Q193 font closure envelope');
if (!q196Successor && manifest.v172Q193RealMathLiveFontBundleClosure.closureStatus !== 'BLOCKED_OFFICIAL_FONT_FILES_ABSENT') fail('Q193 font truth must remain blocked before Q196');
if (q196Successor && manifest.v172Q193RealMathLiveFontBundleClosure.closureStatus !== 'RESOLVED_BY_Q196_OFFICIAL_FONT_BUNDLE_INGESTION') fail('Q193 font truth must be resolved by Q196/Q197 successor');

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
  for (const marker of ['Q195', 'FinalStaticReleaseFreeze', 'finalStaticReleaseFreeze']) {
    if (src.includes(marker)) fail(`protected file polluted by Q195 marker ${marker}: ${p}`);
  }
}

// Static Dart import resolution without Dart SDK.
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

mustContain('README.md', 'V172-Q195 — Final Static Release Freeze');
mustContain('docs/audit/V172_Q195_FINAL_STATIC_RELEASE_FREEZE_AUDIT_REPORT.md', 'V172-Q195 — Final Static Release Freeze');
mustContain('docs/audit/V172_Q195_FINAL_STATIC_RELEASE_FREEZE_CHANGED_FILES_MANIFEST.md', 'V172-Q195 changed files');
mustContain('docs/audit/V172_Q195_PROTECTED_FILE_HASH_MANIFEST.md', 'PROTECTED_HASH_UNCHANGED');

console.log('MATHLIVE_FINAL_STATIC_RELEASE_FREEZE_Q195_STATIC_READY_FOR_USER_FLUTTER_ANDROID_EVIDENCE_COURT');
