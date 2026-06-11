#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const readJson = (rel) => JSON.parse(read(rel));
const errors = [];
const fail = (message) => errors.push(message);

for (const required of [
  'lib/features/workspace/workspace_panel.dart',
  'lib/features/workspace/result_view.dart',
  'lib/features/workspace/result_status_message_inside_result_panel_policy.dart',
  'lib/state/calculator_state.dart',
  'test/v172_q226_result_status_inside_result_panel_test.dart',
  'tool/verify_result_status_inside_result_panel_v172_q226.mjs',
  'assets/mathlive/manifest.json',
]) {
  if (!exists(required)) fail(`missing required file: ${required}`);
}

const workspace = read('lib/features/workspace/workspace_panel.dart');
const resultView = read('lib/features/workspace/result_view.dart');
const state = read('lib/state/calculator_state.dart');
const policy = read('lib/features/workspace/result_status_message_inside_result_panel_policy.dart');
const test = read('test/v172_q226_result_status_inside_result_panel_test.dart');
const manifest = readJson('assets/mathlive/manifest.json');

for (const marker of [
  'final resultStatusMessage = statusText?.trim() ??',
  'resultStatusMessage: resultStatusMessage',
  'ResultView(',
]) {
  if (!workspace.includes(marker)) fail(`workspace missing Q226 result-status routing marker: ${marker}`);
}
for (const forbidden of [
  'class _StatusLine',
  'showStatus',
  'statusHeight',
  'statusGap',
]) {
  if (workspace.includes(forbidden)) fail(`workspace still contains independent status-strip marker: ${forbidden}`);
}
if (workspace.includes('SizedBox(height: statusHeight') || workspace.includes('_StatusLine(text:')) {
  fail('workspace still renders the old status strip between workspace and keyboard');
}

for (const marker of [
  'this.resultStatusMessage',
  'final resultStatusMessage = widget.resultStatusMessage?.trim() ??',
  'final hasResultValue = rawValue.isNotEmpty && rawValue !=',
  'if (!hasResultValue && resultStatusMessage.isNotEmpty)',
  "key: const ValueKey('mathpro-result-status-message')",
  'maxLines: 1',
  'TextOverflow.fade',
  'softWrap: false',
  'ResultStatusCopyResolver.displayText',
  'Alignment.centerLeft',
  'if (!hasResultValue)',
  "key: ValueKey('mathpro-result-empty-state')",
  "key: const ValueKey('mathpro-result-math-render-surface')",
]) {
  if (!resultView.includes(marker)) fail(`result_view missing Q226 result-panel state marker: ${marker}`);
}
const statusBranch = resultView.indexOf('if (!hasResultValue && resultStatusMessage.isNotEmpty)');
const emptyBranch = resultView.indexOf('if (!hasResultValue)');
const resultSurface = resultView.indexOf("key: const ValueKey('mathpro-result-math-render-surface')");
if (!(statusBranch >= 0 && emptyBranch > statusBranch && resultSurface > emptyBranch)) {
  fail('ResultView state priority is not resultValue > resultStatusMessage > empty-state');
}

for (const marker of [
  'String? get resultStatusMessage => lastUnsupportedReason',
  'bool get hasResultStatusMessage',
]) {
  if (!state.includes(marker)) fail(`calculator_state missing resultStatusMessage state marker: ${marker}`);
}

for (const marker of [
  "phase = 'V172-Q226'",
  'resultStatusMessageStateAdded = true',
  'resultStatusMessageRendersInsideResultPanel = true',
  'resultValueHasPriorityOverStatusMessage = true',
  'resultAndStatusNeverRenderTogether = true',
  'independentWorkspaceKeyboardStatusStripRemoved = true',
  'workspaceKeyboardGapBudgetReleased = true',
  'statusMessageMaxTwoLinesWithEllipsis = true',
  'keyboardMutationAllowed = false',
  'moreMutationAllowed = false',
  'longPressMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'graphMutationAllowed = false',
  'appShellMutationAllowed = false',
  'flutterAnalyzePassClaimedByAssistant = false',
  'androidRealDevicePassClaimedByAssistant = false',
]) {
  if (!policy.includes(marker)) fail(`Q226 policy missing ${marker}`);
}

for (const marker of [
  'ResultView shows resultStatusMessage only when actual result is absent',
  'find.byKey(const ValueKey(\'mathpro-result-status-message\'))',
  'find.byKey(const ValueKey(\'mathpro-result-math-render-surface\'))',
  'source removes the independent workspace-keyboard status strip',
]) {
  if (!test.includes(marker)) fail(`Q226 test missing coverage marker: ${marker}`);
}

const env = manifest.v172Q226ResultStatusMessageInsideResultPanel;
if (!env || env.phase !== 'V172-Q226') fail('manifest missing Q226 envelope');
for (const [key, expected] of Object.entries({
  resultStatusMessageStateAdded: true,
  resultStatusMessageRendersInsideResultPanel: true,
  resultValueHasPriorityOverStatusMessage: true,
  resultAndStatusNeverRenderTogether: true,
  independentWorkspaceKeyboardStatusStripRemoved: true,
  workspaceKeyboardGapBudgetReleased: true,
  keyboardMutationAllowed: false,
  moreMutationAllowed: false,
  longPressMutationAllowed: false,
  mathLiveProductionMutationAllowed: false,
  graphMutationAllowed: false,
  historyMutationAllowed: false,
  solutionMutationAllowed: false,
  appShellMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimedByAssistant: false,
})) {
  if (env?.[key] !== expected) fail(`manifest Q226 ${key} expected ${expected} got ${env?.[key]}`);
}
const acceptedResultWorkspaceLatestPhases = new Set([
  'V172-Q226-RESULT-STATUS-MESSAGE-INSIDE-RESULT-PANEL-WORKSPACE-GAP-CLEANUP',
  'V172-Q232-RESULT-STATUS-COMPACT-COPY-GRAPH-OPEN-FIT-REPAIR',
]);
if (!acceptedResultWorkspaceLatestPhases.has(manifest.resultWorkspaceLatestPhase)) {
  fail(`manifest resultWorkspaceLatestPhase must be Q226 or Q232 successor, got ${manifest.resultWorkspaceLatestPhase}`);
}

const protectedHashes = {
  'lib/features/keyboard/key_config.dart': '4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2',
  'lib/features/workspace/template_tray.dart': 'b58f05b9f6f8b089a4335554f062e0652929bd9c2f60d3fdbf79d4bc87aca678',
  'lib/features/history/history_controller.dart': '331a6d84dbe4a940f185a69bc5623c6aaa0f2b16f4198f2149a4f4b375be3f51',
  'lib/features/history/history_panel.dart': 'fad987605894ffafc0069fa80f560908c6f529a05da81d2165e924524728537b',
  'assets/mathlive/main_editor_prod.html': 'f32e884f83f94d3ac2077f2c65d0278edbba163ca30c640605edc75c337dd9cd',
  'assets/mathlive/mathlive_prod_bridge.js': 'fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4',
  'lib/features/mathlive/mathlive_production_editor_surface.dart': 'f89f6822b85870608befd20d9602c0310d2e67c300bbc5736612b5a4d90929a9',
  'lib/app/app_shell.dart': 'ac80aef66dde3b4c4a7bc863f4a4b36b0be735ea3a865ceaa90a854afacbd637',
  'lib/main.dart': '068648069a69ec196c566cc0e27feb6dcb496059f9cd606367c6cc646b602689',
  'android/app/src/main/AndroidManifest.xml': 'e788776fb08b0e63d7beb9844b34df0e198a913b715dcfbef3df6e2ef77f5b20',
  'android/app/src/main/res/values/styles.xml': '3c2cdc2835c62f5c107c2c01eef9d56107ede8190d0e5387c5f105d55c55eeb3',
  'android/app/src/main/res/values-v31/styles.xml': 'a7c6fb6d72ee0c032629ea760c9a02ff585a9dda4b9c0aacee243e30da1a23a1',
};
for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) {
    fail(`protected file missing: ${file}`);
    continue;
  }
  const actual = crypto.createHash('sha256').update(fs.readFileSync(p(file))).digest('hex');
  if (actual !== expected) fail(`protected hash changed for ${file}: ${actual} expected ${expected}`);
}

const report = {
  phase: 'V172-Q226',
  status: errors.length === 0
    ? 'RESULT_STATUS_MESSAGE_INSIDE_RESULT_PANEL_Q226_STATIC_READY_WITH_Q232_COMPACT_COPY_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED'
    : 'RESULT_STATUS_MESSAGE_INSIDE_RESULT_PANEL_Q226_BLOCKED',
  errors,
  independentStatusStripRemoved: !workspace.includes('class _StatusLine') && !workspace.includes('statusHeight') && !workspace.includes('statusGap'),
  resultStatusMessageInsideResultPanel: resultView.includes("key: const ValueKey('mathpro-result-status-message')"),
  protectedHashesUnchanged: errors.every((e) => !e.startsWith('protected hash changed')),
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimedByAssistant: false,
};

fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/result_status_inside_result_panel_q226_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(p('tool/reports/result_status_inside_result_panel_q226_report.md'), `# V172-Q226 Result Status Message Inside Result Panel / Workspace Gap Cleanup\n\nStatus: ${report.status}\n\nIndependent workspace-keyboard status strip removed: ${report.independentStatusStripRemoved}\n\nResult status message rendered inside result panel: ${report.resultStatusMessageInsideResultPanel}\n\nProtected hashes unchanged: ${report.protectedHashesUnchanged}\n\nFlutter/Android/Premium PASS claimed: false\n\n## Errors\n${errors.map((e) => `- ${e}`).join('\n') || '- none'}\n`);

if (errors.length) {
  console.error(errors.join('\n'));
  process.exit(1);
}
console.log(report.status);
