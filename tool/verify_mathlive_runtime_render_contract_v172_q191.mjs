#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_runtime_render_contract_v172_q191.mjs', preservedPhase: 'verify_mathlive_runtime_render_contract_v172_q191' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q191_RUNTIME_RENDER_CONTRACT_FAIL: ${msg}`); process.exit(1); };
const must = (p, s) => { if (!exists(p) || !read(p).includes(s)) fail(`${p} missing ${s}`); };
const mustNot = (p, s) => { if (exists(p) && read(p).includes(s)) fail(`${p} contains forbidden ${s}`); };

const files = {
  policy: 'lib/features/mathlive/mathlive_runtime_render_contract_policy.dart',
  keyboard: 'lib/features/mathlive/mathlive_keyboard_bridge_policy.dart',
  surface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurfacePart: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  bridge: 'assets/mathlive/mathlive_prod_bridge.js',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  test: 'test/v172_q191_runtime_render_contract_test.dart',
  audit: 'docs/audit/V172_Q191_RUNTIME_RENDER_CONTRACT_AUDIT_REPORT.md',
  changed: 'docs/audit/V172_Q191_RUNTIME_RENDER_CONTRACT_CHANGED_FILES_MANIFEST.md',
  hash: 'docs/audit/V172_Q191_PROTECTED_FILE_HASH_MANIFEST.md',
};
for (const p of Object.values(files)) if (!exists(p)) fail(`missing required file ${p}`);
const surfaceCombined = `${read(files.surface)}\n${read(files.prodSurfacePart)}`;
const mustSurface = (s) => { if (!surfaceCombined.includes(s)) fail(`${files.surface} + ${files.prodSurfacePart} missing ${s}`); };
const mustSurfaceNot = (s) => { if (surfaceCombined.includes(s)) fail(`${files.surface} + ${files.prodSurfacePart} contains forbidden ${s}`); };

must(files.policy, "phase = 'V172-Q191'");
must(files.policy, 'criticalTemplatesMustUseExplicitRenderContracts = true');
must(files.policy, 'rawInsertTokensMayCrossProductionBridge = false');
must(files.policy, 'renderPayloadMayBePlainVisibleLabel = false');
must(files.keyboard, 'mainEditorRuntimeRenderContractPhase = \'V172-Q191\'');
must(files.keyboard, 'productionRuntimeRenderLatexContracts');
must(files.keyboard, 'productionRuntimeRenderLatexForMainEditorLabel');
mustSurface("import 'mathlive_runtime_render_contract_policy.dart';");
mustSurface('productionRuntimeRenderLatexForMainEditorLabel(command.label, command.latex)');
mustSurface("'runtimeRenderContractPhase': MathLiveRuntimeRenderContractPolicy.phase");
mustSurface("'runtimeRenderContractApplied': MathLiveKeyboardBridgePolicy.productionRuntimeRenderLatexContracts.containsKey(command.label)");
must(files.bridge, "RUNTIME_RENDER_CONTRACT_PHASE = 'V172-Q191'");
must(files.bridge, 'runtimeRenderContractPhase: RUNTIME_RENDER_CONTRACT_PHASE');
must(files.bridge, 'runtimeRenderContractViolation');
must(files.bridge, 'q191-js-runtime-render-contract-accepted');
must(files.bridge, 'q191-js-runtime-render-contract-raw-token-blocked');
must(files.readme, 'V172-Q191 — Runtime Render Contract Closure');
must(files.test, 'MathLiveRuntimeRenderContractPolicy.criticalLabels');

const keyboard = read(files.keyboard);
const requiredContracts = new Map([
  ['lim', String.raw`\lim_{x\to \placeholder{}}\placeholder{}`],
  ['□/□', String.raw`\frac{\placeholder{}}{\placeholder{}}`],
  ['a/b', String.raw`\frac{\placeholder{}}{\placeholder{}}`],
  ['√□', String.raw`\sqrt{\placeholder{}}`],
  ['√x', String.raw`\sqrt{\placeholder{}}`],
  ['x^y', String.raw`\placeholder{}^{\placeholder{}}`],
  ['□^□', String.raw`\placeholder{}^{\placeholder{}}`],
  ['Σ', String.raw`\sum_{n=\placeholder{}}^{\placeholder{}}\placeholder{}`],
  ['Π', String.raw`\prod_{n=\placeholder{}}^{\placeholder{}}\placeholder{}`],
  ['∫□dx', String.raw`\int \placeholder{}\,dx`],
  ['∫ₐᵇ', String.raw`\int_{\placeholder{}}^{\placeholder{}}\placeholder{}\,dx`],
  ['Taylor', String.raw`\sum_{n=0}^{\infty}`],
  ['Maclaurin', String.raw`\sum_{n=0}^{\infty}`],
]);
for (const [label, latex] of requiredContracts) {
  if (!keyboard.includes(`'${label}'`)) fail(`missing runtime render contract label ${label}`);
  if (!keyboard.includes(latex)) fail(`runtime render contract for ${label} missing expected latex ${latex}`);
}

const surface = surfaceCombined;
const legacyStart = surface.indexOf('class _MathLiveMainEditorSurfaceState');
const productionStart = surface.indexOf('class _MathLiveProductionEditorSurfaceState');
if (productionStart < 0) fail('production class missing');
if (legacyStart >= 0 && legacyStart > productionStart) fail('legacy class appears after production class');
const legacy = legacyStart >= 0 ? surface.slice(legacyStart, productionStart) : '';
if (legacyStart < 0 && !surface.includes('legacyImplementationPhysicallyRemoved = true')) fail('legacy class absent without Q194 cleanup marker');
const production = surface.slice(productionStart);
for (const forbidden of ['V172-Q191', 'RuntimeRenderContract', 'runtimeRenderContractPhase']) {
  if (legacy.includes(forbidden)) fail(`legacy state contains forbidden Q191 marker ${forbidden}`);
}
if (!production.includes('runtimeRenderContractPhase')) fail('production class missing Q191 render contract payload');
if (production.includes('runJavaScriptReturningResult')) fail('production class reintroduced runJavaScriptReturningResult');

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
  if (!exists(p)) fail(`missing protected file ${p}`);
  const t = read(p);
  if (t.includes('V172-Q191') || t.includes('Runtime Render Contract')) fail(`protected file polluted by Q191 marker ${p}`);
}

const manifest = JSON.parse(read(files.manifest));
if (!['V172-Q191-RUNTIME-RENDER-CONTRACT-CLOSURE', 'V172-Q192-CARET-FOCUS-SLOT-CONTRACT-CLOSURE', 'V172-Q193-REAL-MATHLIVE-FONT-BUNDLE-CLOSURE', 'V172-Q194-PHYSICAL-LEGACY-CLEANUP', 'V172-Q195-FINAL-STATIC-RELEASE-FREEZE', 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) fail('manifest latestProductionPhase is not Q191 or verified Q192/Q193/Q194/Q195 successor');
if (!manifest.v172Q191RuntimeRenderContractClosure) fail('manifest missing Q191 envelope');
if (manifest.v172Q191RuntimeRenderContractClosure.flutterAnalyzePassClaimedByAssistant !== false) fail('manifest falsely claims Flutter analyze PASS');
if (manifest.v172Q191RuntimeRenderContractClosure.androidRealDevicePassClaimed !== false) fail('manifest falsely claims Android PASS');
if (manifest.v172Q191RuntimeRenderContractClosure.rawInsertTokensMayCrossProductionBridge !== false) fail('manifest raw token bridge gate mismatch');

console.log('MATHLIVE_RUNTIME_RENDER_CONTRACT_Q191_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
