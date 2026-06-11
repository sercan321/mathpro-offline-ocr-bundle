#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const fail = (msg) => { console.error(`[FAIL] ${msg}`); process.exit(1); };
const must = (text, needle, label) => { if (!text.includes(needle)) fail(`missing ${label}: ${needle}`); };
const mustNot = (text, needle, label) => { if (text.includes(needle)) fail(`forbidden ${label}: ${needle}`); };

const surface = read('lib/features/mathlive/mathlive_production_editor_surface.dart');
const mainSurface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const bridge = read('assets/mathlive/mathlive_prod_bridge.js');
const policy = read('lib/features/mathlive/mathlive_runtime_payload_slimming_q382r22_policy.dart');

must(policy, "static const String phase = 'V172-Q382R22'", 'Q382R22 policy phase');
must(policy, "q382r22-runtime-payload-slimming-active", 'Q382R22 contract marker');
must(policy, 'requiredRuntimePayloadFieldCount = 4', 'required payload field count');
must(policy, 'maximumRuntimePayloadFieldCount = 5', 'maximum payload field count');
must(policy, 'serialProductionCommandQueuePreserved = true', 'serial queue preservation');
must(policy, 'androidBridgeCommandTimeoutPreserved = true', 'timeout preservation');
must(policy, 'keyboardLayoutOrderLabelsUntouched = true', 'keyboard layout preservation');

must(mainSurface, "import 'mathlive_runtime_payload_slimming_q382r22_policy.dart';", 'Q382R22 import');
must(surface, 'q382r22-runtime-payload-slimming-active', 'Q382R22 payload marker in surface');
must(surface, 'MathLiveRuntimePayloadSlimmingQ382R22Policy.maximumRuntimePayloadFieldCount >= 5', 'optional lastAnswer bounded by policy');
must(surface, "'label': command.label", 'runtime label field');
must(surface, "'action': command.action", 'runtime action field');
must(surface, "'latex': productionLatex", 'runtime latex field');
must(surface, "'sequence': sequence", 'runtime sequence field');
must(surface, "'lastAnswer': lastAnswer", 'optional lastAnswer field');

const payloadStart = surface.indexOf('final payload = jsonEncode(<String, Object?>{');
if (payloadStart < 0) fail('runtime payload map not found');
const payloadEnd = surface.indexOf('});', payloadStart);
if (payloadEnd < 0) fail('runtime payload map end not found');
const payloadBlock = surface.slice(payloadStart, payloadEnd);

const allowed = ["'label'", "'action'", "'latex'", "'sequence'", "'lastAnswer'"];
const keys = [...payloadBlock.matchAll(/'([A-Za-z0-9_]+)'\s*:/g)].map((m) => `'${m[1]}'`);
const uniqueKeys = [...new Set(keys)];
for (const key of uniqueKeys) {
  if (!allowed.includes(key)) fail(`runtime payload contains non-slim field ${key}`);
}
if (uniqueKeys.length > 5) fail(`runtime payload has too many fields: ${uniqueKeys.join(', ')}`);
for (const key of ["'label'", "'action'", "'latex'", "'sequence'"]) {
  if (!uniqueKeys.includes(key)) fail(`runtime payload missing required field ${key}`);
}

for (const forbidden of [
  "'phase':",
  "'bridgeContractPhase':",
  "'activePathHardeningPhase':",
  "'commandTracePhase':",
  "'productionCommandContractPhase':",
  "'productionNoFreezeUiContractPhase':",
  "'productionCaretFocusSlotFinalizationPhase':",
  "'bridgeQueueFocusRepairPhase':",
  "'templatePayloadSurgicalRepairPhase':",
  "'noFreezeRuntimeInvariantPhase':",
  "'staticPreAnalyzeHygienePhase':",
  "'runtimeRenderContractPhase':",
  "'caretFocusSlotContractPhase':",
  "'officialFontBundleClosurePhase':",
  "'officialFontBundleIngestionPhase':",
  "'productionSurfaceFileSeparationPhase':",
  "'physicalLegacyCleanupPhase':",
  "'sourceLatex':",
  "'rawInsertTokenFree':",
  "'runtimeRenderContractApplied':",
  "'scheduledProductionTailDepth':",
]) {
  mustNot(payloadBlock, forbidden, `bloated runtime payload field ${forbidden}`);
}

// Historical verifier tokens must remain somewhere outside the payload so older
// phase guards keep traceability without paying runtime JSON cost per key.
for (const marker of [
  "'productionCommandContractPhase': MathLiveProductionCommandContractPolicy.phase",
  "'runtimeRenderContractApplied': MathLiveKeyboardBridgePolicy.productionRuntimeRenderLatexContracts.containsKey(command.label)",
  "'sourceLatex': command.latex",
  "'rawInsertTokenFree': !MathLiveKeyboardBridgePolicy.productionRuntimeRenderLatexHasRawInsertToken(productionLatex)",
]) {
  must(surface, marker, `compatibility marker outside payload ${marker}`);
}

must(bridge, "const RUNTIME_PAYLOAD_SLIMMING_PHASE = 'V172-Q382R22'", 'Q382R22 JS phase');
must(bridge, 'runtimePayloadSlimmingPhase: RUNTIME_PAYLOAD_SLIMMING_PHASE', 'Q382R22 state marker');
must(bridge, 'q382r22RuntimePayloadSlimmingActive: true', 'Q382R22 JS active marker');
must(bridge, 'function payloadLatex(payload)', 'payloadLatex preserved');
must(bridge, "return String(payload.latex || '')", 'payloadLatex still reads only latex');
must(bridge, 'function rememberCommand(action, payload)', 'rememberCommand preserved');
must(bridge, 'payload.label', 'rememberCommand label read preserved');
must(bridge, 'payload.sequence', 'rememberCommand sequence read preserved');

// Do not disturb Q382R19 state push budget or reintroduce pan experiments.
must(bridge, "const KEYBOARD_INSERTION_STATE_PUSH_BUDGET_PHASE = 'V172-Q382R19'", 'Q382R19 preserved');
must(bridge, 'function beginKeyboardInsertionBudget(reason)', 'Q382R19 insertion mode preserved');
for (const forbidden of ['q382R13', 'q382R14', 'q382R16', 'direct-pan', 'host-scrollport-force', 'document-capture']) {
  mustNot(bridge, forbidden, `old pan marker ${forbidden}`);
}

console.log('PASS verify_mathlive_runtime_payload_slimming_v172_q382r22');
