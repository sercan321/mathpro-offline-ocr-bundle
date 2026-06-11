#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_single_device_candidate_v172_q189.mjs', preservedPhase: 'verify_mathlive_single_device_candidate_v172_q189' });

const files = {
  policy: 'lib/features/mathlive/mathlive_single_device_candidate_policy.dart',
  test: 'test/v172_q189_single_device_candidate_test.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  q184Verifier: 'tool/verify_mathlive_production_cutover_surface_v172_q184.mjs',
  q185Verifier: 'tool/verify_mathlive_production_html_finalization_v172_q185.mjs',
  q186Verifier: 'tool/verify_mathlive_production_bridge_contract_v172_q186.mjs',
  q187Verifier: 'tool/verify_mathlive_template_command_contract_freeze_v172_q187.mjs',
  q188Verifier: 'tool/verify_mathlive_production_graph_history_solution_adapter_v172_q188.mjs',
  q189Audit: 'docs/audit/V172_Q189_SINGLE_DEVICE_CANDIDATE_AUDIT_REPORT.md',
  q189Changed: 'docs/audit/V172_Q189_SINGLE_DEVICE_CANDIDATE_CHANGED_FILES_MANIFEST.md',
  q189Evidence: 'docs/evidence/V172_Q189_SINGLE_DEVICE_CANDIDATE_CHECKLIST_TEMPLATE.json',
  prodSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurfacePart: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  prodHtml: 'assets/mathlive/main_editor_prod.html',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  graphAdapter: 'lib/features/mathlive/mathlive_production_graph_history_solution_adapter_policy.dart',
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

has('policy', "phase = 'V172-Q189'");
has('policy', "baseline = 'V172-Q188_PRODUCTION_GRAPH_HISTORY_SOLUTION_ADAPTER'");
has('policy', 'packagesQ184MinimalProductionSurface = true');
has('policy', 'packagesQ185MinimalProductionHtml = true');
has('policy', 'packagesQ186MinimalProductionBridge = true');
has('policy', 'packagesQ187TemplateCommandContract = true');
has('policy', 'packagesQ188GraphHistorySolutionAdapter = true');
has('policy', 'singleDeviceCandidateOnly = true');
has('policy', 'finalReleaseClaimAllowed = false');
has('policy', 'newFeatureAllowed = false');
has('policy', 'keyboardLayoutMutationAllowed = false');
has('policy', 'moreInventoryMutationAllowed = false');
has('policy', 'longPressOrderMutationAllowed = false');
has('policy', 'graphUiMutationAllowed = false');
has('policy', 'historyUiMutationAllowed = false');
has('policy', 'solutionUiMutationAllowed = false');
has('policy', 'fakeEvidenceAllowed = false');
has('policy', 'flutterAnalyzePassClaimedByAssistant = false');
has('policy', 'flutterTestPassClaimedByAssistant = false');
has('policy', 'flutterRunPassClaimedByAssistant = false');
has('policy', 'realDevicePassClaimed = false');
has('policy', 'photomathLevelClaimed = false');
has('policy', 'requiredFlutterCommands');
has('policy', 'flutter run -d 23106RN0DA');
has('policy', 'requiredVerifierCommands');
has('policy', 'verify_mathlive_single_device_candidate_v172_q189.mjs');
has('policy', 'requiredManualScenarios');
has('policy', 'taylor-template-not-raw-text');
has('policy', 'graph-open-from-mathlive-state');
has('policy', 'solution-evaluator-candidate-from-mathlive-state');
has('policy', 'isFinalEvidenceComplete');
has('policy', 'Q189_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED');

has('test', 'MathLiveSingleDeviceCandidatePolicy.phase');
has('test', 'Q189_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED');
has('test', 'Q189_DEVICE_CANDIDATE_EVIDENCE_COMPLETE_READY_FOR_FINAL_REVIEW');

has('prodSurfaceCombined', 'MathLiveProductionEditorSurface');
has('prodHtml', 'data-mathpro-production-html="V172-Q185"');
has('prodBridge', 'window.MathProProductionMathLiveBridge');
has('graphAdapter', "phase = 'V172-Q188'");

has('manifest', 'v172Q189SingleDeviceCandidate');
has('manifest', 'V172-Q189-MATHLIVE-SINGLE-DEVICE-CANDIDATE');
has('manifest', 'docs/evidence/V172_Q189_SINGLE_DEVICE_CANDIDATE_CHECKLIST_TEMPLATE.json');
has('manifest', 'flutterAnalyzePassClaimedByAssistant');
has('manifest', 'realDevicePassClaimed');
has('manifest', 'latestProductionPhase');

has('readme', 'V172-Q189 — Single Device Candidate');
has('readme', 'Q189 does not claim Flutter analyze/test/run PASS');
has('q189Audit', 'V172-Q189 Single Device Candidate Audit Report');
has('q189Changed', 'V172-Q189 Single Device Candidate Changed Files Manifest');
has('q189Evidence', 'V172-Q189');
has('q189Evidence', 'flutter analyze');
has('q189Evidence', 'taylor-template-not-raw-text');
has('q189Evidence', 'graph-open-from-mathlive-state');

for (const protectedName of [
  'keyConfig',
  'mathKeyboard',
  'bottomDock',
  'premiumKey',
  'longPressPopup',
  'templateTray',
  'graphCard',
  'graphController',
  'historyController',
  'historyPanel',
  'solutionPanel',
]) {
  lacks(protectedName, 'V172-Q189');
  lacks(protectedName, 'Single Device Candidate');
}

try {
  const manifest = JSON.parse(text.manifest ?? '{}');
  const q189 = manifest.v172Q189SingleDeviceCandidate;
  if (!q189) failures.push('manifest missing v172Q189SingleDeviceCandidate object');
  else {
    if (q189.phase !== 'V172-Q189') failures.push('manifest q189 phase mismatch');
    if (q189.baseline !== 'V172-Q188_PRODUCTION_GRAPH_HISTORY_SOLUTION_ADAPTER') failures.push('manifest q189 baseline mismatch');
    if (q189.finalReleaseClaimAllowed !== false) failures.push('manifest must block final release claim');
    if (q189.realDevicePassClaimed !== false) failures.push('manifest must not claim real-device PASS');
    if (q189.flutterAnalyzePassClaimedByAssistant !== false) failures.push('manifest must not claim flutter analyze PASS');
    if (!Array.isArray(q189.requiredManualScenarios) || q189.requiredManualScenarios.length < 20) failures.push('manifest must list manual device scenarios');
    if (!q189.requiredManualScenarios?.includes('taylor-template-not-raw-text')) failures.push('manifest manual scenarios missing Taylor raw-text gate');
    if (!q189.requiredManualScenarios?.includes('solution-evaluator-candidate-from-mathlive-state')) failures.push('manifest manual scenarios missing solution adapter gate');
  }
} catch (error) {
  failures.push(`manifest JSON parse failed: ${error.message}`);
}

try {
  const evidence = JSON.parse(text.q189Evidence ?? '{}');
  if (evidence.phase !== 'V172-Q189') failures.push('evidence checklist phase mismatch');
  if (evidence.deviceEvidenceStatus !== 'required-not-claimed-by-assistant') failures.push('evidence checklist must require device evidence');
  if (!Array.isArray(evidence.manualScenarios) || evidence.manualScenarios.length < 20) failures.push('evidence checklist manual scenario count too low');
} catch (error) {
  failures.push(`evidence checklist JSON parse failed: ${error.message}`);
}

if (failures.length) {
  console.error('MATHLIVE_SINGLE_DEVICE_CANDIDATE_Q189_VERIFICATION_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}

console.log('MATHLIVE_SINGLE_DEVICE_CANDIDATE_Q189_PACKAGE_READY_BUT_FLUTTER_DEVICE_EVIDENCE_REQUIRED');
