#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_template_payload_surgical_repair_v172_q190r5.mjs', preservedPhase: 'verify_mathlive_template_payload_surgical_repair_v172_q190r5' });

const files = {
  policy: 'lib/features/mathlive/mathlive_template_payload_surgical_repair_policy.dart',
  test: 'test/v172_q190r5_template_payload_surgical_repair_test.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  prodSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurfacePart: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  keyboardBridge: 'lib/features/mathlive/mathlive_keyboard_bridge_policy.dart',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  audit: 'docs/audit/V172_Q190R5_TEMPLATE_PAYLOAD_SURGICAL_REPAIR_AUDIT_REPORT.md',
  changed: 'docs/audit/V172_Q190R5_TEMPLATE_PAYLOAD_SURGICAL_REPAIR_CHANGED_FILES_MANIFEST.md',
  hash: 'docs/audit/V172_Q190R5_PROTECTED_FILE_HASH_MANIFEST.md',
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

has('policy', "phase = 'V172-Q190R5'");
has('policy', "baseline = 'V172-Q190R4_PRODUCTION_BRIDGE_QUEUE_FOCUS_REPAIR'");
has('policy', "repairScope = 'production-template-payload-document-placeholder-repair'");
has('policy', 'productionPayloadMustUseDocumentPlaceholders = true');
has('policy', 'rawInsertTokensMayCrossProductionBridge = false');
has('policy', 'q190R4RawTemplateFallbackBlockPreserved = true');
has('policy', 'jsBridgeAlsoNormalizesPayload = true');
has('policy', 'historicalCommandMapCompatibilityPreserved = true');
has('policy', 'androidRealDevicePassClaimed = false');
has('policy', 'premiumSymbolVisualPassClaimed = false');
has('policy', 'caretRealDevicePassClaimed = false');

has('test', 'MathLiveTemplatePayloadSurgicalRepairPolicy.phase');
has('test', 'productionDocumentLatexForMainEditorPayload');
has('test', "['lim', 'a/b', '□/□', '√□', '√x', 'x^y', '□^□', 'Σ', '∫□dx', '∫ₐᵇ']");
has('test', "contains(r'\\placeholder{}')");

has('keyboardBridge', 'V172-Q190R5 — production document-template conversion');
has('keyboardBridge', 'productionDocumentLatexForMainEditorPayload');
has('keyboardBridge', ".replaceAll('#@', r'\\placeholder{}')");
has('keyboardBridge', ".replaceAll('#0', r'\\placeholder{}')");
has('keyboardBridge', ".replaceAll('#?', r'\\placeholder{}')");
has('keyboardBridge', 'productionDocumentLatexHasRawInsertToken');

has('prodSurfaceCombined', "import 'mathlive_template_payload_surgical_repair_policy.dart';");
if (!text.prodSurfaceCombined?.includes('final productionLatex = MathLiveKeyboardBridgePolicy.productionDocumentLatexForMainEditorPayload(command.latex);') && !text.prodSurfaceCombined?.includes('final productionLatex = MathLiveKeyboardBridgePolicy.productionRuntimeRenderLatexForMainEditorLabel(command.label, command.latex);')) failures.push('production surface missing Q190R5/Q191 production latex conversion path');
has('prodSurfaceCombined', "'templatePayloadSurgicalRepairPhase': MathLiveTemplatePayloadSurgicalRepairPolicy.phase");
has('prodSurfaceCombined', "'sourceLatex': command.latex");
has('prodSurfaceCombined', "'latex': productionLatex");
if (!text.prodSurfaceCombined?.includes("'rawInsertTokenFree': !MathLiveKeyboardBridgePolicy.productionDocumentLatexHasRawInsertToken(productionLatex)") && !text.prodSurfaceCombined?.includes("'rawInsertTokenFree': !MathLiveKeyboardBridgePolicy.productionRuntimeRenderLatexHasRawInsertToken(productionLatex)")) failures.push('production surface missing Q190R5/Q191 raw token free gate');

const surface = text.prodSurfaceCombined || '';
const legacyState = sliceBetween(surface, 'class _MathLiveMainEditorSurfaceState', 'class MathLiveProductionEditorSurface');
const productionState = sliceBetween(surface, 'class _MathLiveProductionEditorSurfaceState', '');
if (!legacyState && !surface.includes('legacyImplementationPhysicallyRemoved = true')) failures.push('legacy state absent before Q194 cleanup marker');
if (!productionState) failures.push('production _MathLiveProductionEditorSurfaceState slice not found');
if (legacyState.includes('Q190R5') || legacyState.includes('templatePayloadSurgicalRepairPhase') || legacyState.includes('MathLiveTemplatePayloadSurgicalRepairPolicy')) {
  failures.push('legacy _MathLiveMainEditorSurfaceState must not contain Q190R5 production template repair code');
}
if (productionState.includes('runJavaScriptReturningResult(')) {
  failures.push('active production state must not reintroduce runJavaScriptReturningResult');
}

has('prodBridge', "TEMPLATE_PAYLOAD_SURGICAL_REPAIR_PHASE = 'V172-Q190R5'");
has('prodBridge', 'templatePayloadSurgicalRepairPhase: TEMPLATE_PAYLOAD_SURGICAL_REPAIR_PHASE');
has('prodBridge', 'function normalizeProductionDocumentPayload(input)');
has('prodBridge', 'q190r5-js-template-payload-converted-to-document-placeholder');
if (!text.prodBridge?.includes('q190r5-js-document-payload-raw-token-blocked') && !text.prodBridge?.includes('q191-js-runtime-render-contract-raw-token-blocked')) failures.push('production bridge missing raw-token blocked trace marker');
has('prodBridge', 'q190r5-direct-setValue-document-placeholder-latex');
has('prodBridge', 'q190r5-js-document-placeholder-fallback-committed');
has('prodBridge', 'q190r5-template-document-payload-still-has-raw-token');
has('prodBridge', 'const sourceLatex = normalizeLatex(payloadLatex(payload));');
has('prodBridge', 'const latex = normalizeProductionDocumentPayload(sourceLatex);');
has('prodBridge', "state.lastFailureReason = 'q190r5-empty-or-raw-token-document-payload-blocked'");
for (const api of ['mount', 'insertLatex', 'deleteBackward', 'clear', 'setLatex', 'getLatex', 'focus', 'keepCaretVisible', 'notifyFlutterState']) has('prodBridge', api);
lacks('prodBridge', 'executeMathProCommand');
lacks('prodBridge', 'getRealDeviceDiagnosticReport');
lacks('prodBridge', 'runQ169FinalSelfTestCourt');

// Critical production payload labels must be convertible to document placeholders.
const bridge = text.keyboardBridge || '';
const conversionBlock = sliceBetween(bridge, 'static String productionDocumentLatexForMainEditorPayload', 'static bool productionDocumentLatexHasRawInsertToken');
for (const token of ['#@', '#0', '#?']) {
  if (!conversionBlock.includes(token)) failures.push(`production conversion block missing token ${token}`);
}
const criticalLabels = ['lim', 'a/b', '□/□', '√□', '√x', 'x^y', '□^□', 'Σ', '∫□dx', '∫ₐᵇ'];
for (const label of criticalLabels) {
  if (!bridge.includes(`'${label}'`)) failures.push(`keyboard bridge missing critical label ${label}`);
}

has('manifest', 'v172Q190R5TemplatePayloadSurgicalRepair');
has('manifest', 'V172-Q190R5-TEMPLATE-PAYLOAD-SURGICAL-REPAIR');
has('manifest', 'productionPayloadMustUseDocumentPlaceholders');
has('manifest', 'rawInsertTokensMayCrossProductionBridge');
has('readme', 'V172-Q190R5 — Template Payload Surgical Repair');
has('audit', 'V172-Q190R5 Template Payload Surgical Repair Audit Report');
has('changed', 'V172-Q190R5 Template Payload Surgical Repair Changed Files Manifest');
has('hash', 'V172-Q190R5 Protected File Hash Manifest');
has('hash', 'PROTECTED_HASH_UNCHANGED');

for (const protectedName of ['keyConfig', 'mathKeyboard', 'bottomDock', 'premiumKey', 'longPressPopup', 'templateTray', 'graphCard', 'graphController', 'historyController', 'historyPanel', 'solutionPanel']) {
  lacks(protectedName, 'V172-Q190R5');
  lacks(protectedName, 'Template Payload Surgical Repair');
}

try {
  const manifest = JSON.parse(text.manifest ?? '{}');
  const q190r5 = manifest.v172Q190R5TemplatePayloadSurgicalRepair;
  if (!q190r5) failures.push('manifest missing v172Q190R5TemplatePayloadSurgicalRepair object');
  else {
    if (q190r5.phase !== 'V172-Q190R5') failures.push('manifest q190r5 phase mismatch');
    if (q190r5.newFeatureAllowed !== false) failures.push('q190r5 must not allow new features');
    if (q190r5.productionPayloadMustUseDocumentPlaceholders !== true) failures.push('q190r5 document placeholder gate missing');
    if (q190r5.rawInsertTokensMayCrossProductionBridge !== false) failures.push('q190r5 raw token bridge gate mismatch');
    if (q190r5.androidRealDevicePassClaimed !== false) failures.push('q190r5 must not claim Android PASS');
  }
  if (!['V172-Q190R5-TEMPLATE-PAYLOAD-SURGICAL-REPAIR', 'V172-Q190R6-NO-FREEZE-RUNTIME-INVARIANT', 'V172-Q190R7-PRODUCTION-LEGACY-FALLBACK-ISOLATION', 'V172-Q190R8-PRODUCTION-STATIC-ASSET-TRUTH-CLOSURE', 'V172-Q190R9-STATIC-PRE-ANALYZE-HYGIENE-CLOSURE', 'V172-Q191-RUNTIME-RENDER-CONTRACT-CLOSURE', 'V172-Q192-CARET-FOCUS-SLOT-CONTRACT-CLOSURE', 'V172-Q193-REAL-MATHLIVE-FONT-BUNDLE-CLOSURE', 'V172-Q194-PHYSICAL-LEGACY-CLEANUP', 'V172-Q195-FINAL-STATIC-RELEASE-FREEZE', 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) {
    failures.push('manifest latestProductionPhase must point at Q190R5 or a verified Q190R5-preserving successor phase');
  }
} catch (error) {
  failures.push(`manifest JSON parse failed: ${error.message}`);
}

if (failures.length) {
  console.error('MATHLIVE_TEMPLATE_PAYLOAD_SURGICAL_REPAIR_Q190R5_VERIFICATION_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_TEMPLATE_PAYLOAD_SURGICAL_REPAIR_Q190R5_STATIC_READY_BUT_FLUTTER_ANALYZE_AND_ANDROID_RETEST_REQUIRED');
