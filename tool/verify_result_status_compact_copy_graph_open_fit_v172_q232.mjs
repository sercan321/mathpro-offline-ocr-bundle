#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const readJson = (rel) => JSON.parse(read(rel));
const sha = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
const errors = [];
const fail = (message) => errors.push(message);

for (const required of [
  'lib/features/workspace/result_view.dart',
  'lib/features/workspace/workspace_panel.dart',
  'lib/features/workspace/result_status_compact_copy.dart',
  'lib/features/workspace/result_status_compact_copy_policy.dart',
  'test/v172_q232_result_status_compact_copy_graph_open_fit_test.dart',
  'tool/verify_result_status_compact_copy_graph_open_fit_v172_q232.mjs',
  'assets/mathlive/manifest.json',
  'README.md',
]) {
  if (!exists(required)) fail(`missing required file: ${required}`);
}

const resultView = read('lib/features/workspace/result_view.dart');
const workspace = read('lib/features/workspace/workspace_panel.dart');
const resolver = read('lib/features/workspace/result_status_compact_copy.dart');
const policy = read('lib/features/workspace/result_status_compact_copy_policy.dart');
const test = read('test/v172_q232_result_status_compact_copy_graph_open_fit_test.dart');
const readme = read('README.md');
const manifest = readJson('assets/mathlive/manifest.json');

for (const marker of [
  'class ResultStatusCopy',
  'class ResultStatusCopyResolver',
  "full: 'Açık slotları doldurun'",
  "compact: 'Slot bekleniyor'",
  "full: 'İfade girin'",
  "compact: 'İfade bekleniyor'",
  "full: 'İfade değerlendirilemiyor'",
  "compact: 'Değerlendirilemedi'",
  "full: 'Grafik için uygun değil'",
  "compact: 'Grafik uygun değil'",
  "full: 'Geçersiz ifade'",
  "compact: 'Geçersiz'",
  "full: 'Hesaplama hatası'",
  "compact: 'Hata'",
  "full: 'Çözüm adımı yok'",
  "compact: 'Adım yok'",
  'static String displayText',
]) {
  if (!resolver.includes(marker)) fail(`compact resolver missing marker: ${marker}`);
}

for (const marker of [
  "import 'result_status_compact_copy.dart';",
  'this.forceCompactStatus = false',
  'final statusPanelIsTight = constraints.maxHeight.isFinite && constraints.maxHeight < 48.0',
  'final statusWidthIsTight = constraints.maxWidth.isFinite && constraints.maxWidth < 260.0',
  'final useCompactStatusCopy = widget.forceCompactStatus || statusPanelIsTight || statusWidthIsTight',
  'ResultStatusCopyResolver.displayText',
  'compactMode: useCompactStatusCopy',
  "key: const ValueKey('mathpro-result-status-message')",
  'maxLines: 1',
  'TextOverflow.fade',
  'softWrap: false',
  'fontSize: useCompactStatusCopy ? 11.0 : 12.0',
  "key: const ValueKey('mathpro-result-math-render-surface')",
]) {
  if (!resultView.includes(marker)) fail(`result_view missing Q232 fit marker: ${marker}`);
}
for (const forbidden of [
  'maxLines: 2',
  'TextOverflow.ellipsis',
  'softWrap: true',
  'Açık slotları doldurmadan değerlendirme yapılmadı.',
]) {
  if (resultView.includes(forbidden)) fail(`result_view still contains forbidden cramped-status marker: ${forbidden}`);
}
const statusBranch = resultView.indexOf('if (!hasResultValue && resultStatusMessage.isNotEmpty)');
const emptyBranch = resultView.indexOf('if (!hasResultValue)');
const resultSurface = resultView.indexOf("key: const ValueKey('mathpro-result-math-render-surface')");
if (!(statusBranch >= 0 && emptyBranch > statusBranch && resultSurface > emptyBranch)) {
  fail('ResultView priority must remain resultValue > compact status > empty state');
}

for (const marker of [
  'resultStatusMessage: resultStatusMessage',
  'GraphCard(',
]) {
  if (!workspace.includes(marker)) fail(`workspace missing preserved Q232 result/graph route marker: ${marker}`);
}
for (const forbidden of [
  'resultStatusCompactMode',
  'forceCompactResultStatus',
]) {
  if (workspace.includes(forbidden)) fail(`workspace should not be mutated for Q232 compact status routing: ${forbidden}`);
}

for (const marker of [
  "phase = 'V172-Q232'",
  'centralStatusCopyResolverAdded = true',
  'fullAndCompactCopyVariantsAvailable = true',
  'graphOpenForcesCompactResultStatus = true',
  'compressedResultPanelForcesCompactResultStatus = true',
  'resultStatusSingleLine = true',
  'resultStatusSoftWrapDisabled = true',
  'resultStatusOverflowUsesFadeNotEllipsisDots = true',
  'resultValueHasPriorityOverStatusMessage = true',
  "openSlotCompactCopy = 'Slot bekleniyor'",
  'keyboardMutationAllowed = false',
  'moreMutationAllowed = false',
  'longPressMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'graphEngineMutationAllowed = false',
  'solutionPanelMutationAllowed = false',
  'flutterAnalyzePassClaimedByAssistant = false',
  'androidRealDevicePassClaimedByAssistant = false',
]) {
  if (!policy.includes(marker)) fail(`Q232 policy missing marker: ${marker}`);
}

for (const marker of [
  'graph-open ResultView renders compact slot copy as one line',
  "find.text('Slot bekleniyor')",
  'TextOverflow.fade',
  'actual result keeps priority over status copy',
  'resultStatusMessage: resultStatusMessage',
]) {
  if (!test.includes(marker)) fail(`Q232 test missing marker: ${marker}`);
}

if (!readme.includes('## V172-Q232 — Result Status Compact Copy / Graph-Open Result Panel Fit Repair')) {
  fail('README missing Q232 section');
}
if (manifest.resultWorkspaceLatestPhase !== 'V172-Q232-RESULT-STATUS-COMPACT-COPY-GRAPH-OPEN-FIT-REPAIR') {
  fail(`manifest resultWorkspaceLatestPhase expected Q232 got ${manifest.resultWorkspaceLatestPhase}`);
}
const env = manifest.v172Q232ResultStatusCompactCopyGraphOpenFitRepair;
if (!env || env.phase !== 'V172-Q232-RESULT-STATUS-COMPACT-COPY-GRAPH-OPEN-FIT-REPAIR') {
  fail('manifest missing Q232 envelope');
} else {
  for (const [key, expected] of Object.entries({
    centralStatusCopyResolverAdded: true,
    fullAndCompactCopyVariantsAvailable: true,
    graphOpenForcesCompactResultStatus: true,
    compressedResultPanelForcesCompactResultStatus: true,
    resultStatusSingleLine: true,
    resultStatusSoftWrapDisabled: true,
    resultStatusOverflowUsesFadeNotEllipsisDots: true,
    resultValueHasPriorityOverStatusMessage: true,
    keyboardMutationAllowed: false,
    moreMutationAllowed: false,
    longPressMutationAllowed: false,
    mathLiveProductionMutationAllowed: false,
    graphEngineMutationAllowed: false,
    solutionPanelMutationAllowed: false,
    flutterAnalyzePassClaimed: false,
    flutterTestPassClaimed: false,
    androidGraphOpenResultFitPassClaimed: false,
  })) {
    if (env[key] !== expected) fail(`manifest Q232 ${key} expected ${expected} got ${env[key]}`);
  }
}

const protectedHashes = {
  'lib/features/keyboard/key_config.dart': '4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2',
  'lib/features/keyboard/math_keyboard.dart': 'fc8e6504448bbdd64bdbb674fd000c04511ab185a8a110eecb7102dce19d116c',
  'lib/features/keyboard/bottom_dock.dart': 'a6e8c25369faa0cac016314c42a93be76ac5ca21c0b16c4152b279a339f9c354',
  'lib/features/keyboard/premium_key.dart': '4311a54f0f4e21b3b134552af2613d2ff30fed2078ebd6279a222d877fa21b43',
  'lib/features/keyboard/long_press_popup.dart': '4bb7e11846efd80d831cc3178b72f57207e458dd7e72bb27f1615d7218769369',
  'lib/features/workspace/template_tray.dart': 'b58f05b9f6f8b089a4335554f062e0652929bd9c2f60d3fdbf79d4bc87aca678',
  'assets/mathlive/main_editor_prod.html': 'f32e884f83f94d3ac2077f2c65d0278edbba163ca30c640605edc75c337dd9cd',
  'assets/mathlive/mathlive_prod_bridge.js': 'fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4',
  'lib/features/mathlive/mathlive_production_editor_surface.dart': 'f89f6822b85870608befd20d9602c0310d2e67c300bbc5736612b5a4d90929a9',
  'lib/features/solution/solution_steps_panel.dart': '558c0f232dd4bb81bbf92ffa7687ff8d77fb450daf95f5e04a98f277f1625f2b',
  'lib/features/solution/solution_step_models.dart': 'faab66d941f841911989bee8fae44d0d1edc546fabb6f65fd7dab777405cc248',
  'lib/features/history/history_panel.dart': 'fad987605894ffafc0069fa80f560908c6f529a05da81d2165e924524728537b',
  'lib/features/history/history_controller.dart': '331a6d84dbe4a940f185a69bc5623c6aaa0f2b16f4198f2149a4f4b375be3f51',
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
  const actual = sha(file);
  if (actual !== expected) fail(`protected hash changed for ${file}: ${actual} expected ${expected}`);
}

const report = {
  phase: 'V172-Q232',
  status: errors.length === 0
    ? 'RESULT_STATUS_COMPACT_COPY_GRAPH_OPEN_FIT_Q232_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_GRAPH_OPEN_SCREENSHOT_QA_REQUIRED'
    : 'RESULT_STATUS_COMPACT_COPY_GRAPH_OPEN_FIT_Q232_BLOCKED',
  errors,
  foundLongStatusSources: [
    'Açık slotları doldurmadan değerlendirme yapılmadı.',
    'Bu ifade şu anda değerlendirilemiyor.',
    'Bu ifade grafik gösterimi için uygun değil.',
    'Bu ifade için çözüm adımı henüz oluşturulamadı.',
  ],
  compactCopies: {
    openSlot: 'Slot bekleniyor',
    emptyExpression: 'İfade bekleniyor',
    noResult: 'Sonuç yok',
    unsupported: 'Değerlendirilemedi',
    graphIncompatible: 'Grafik uygun değil',
    invalidExpression: 'Geçersiz',
    calculationError: 'Hata',
    noSolutionStep: 'Adım yok',
  },
  protectedHashesUnchanged: errors.every((e) => !e.startsWith('protected hash changed')),
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimedByAssistant: false,
};

fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/result_status_compact_copy_graph_open_fit_q232_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(p('tool/reports/result_status_compact_copy_graph_open_fit_q232_report.md'), `# V172-Q232 Result Status Compact Copy / Graph-open Result Panel Fit Repair\n\nStatus: ${report.status}\n\nProtected hashes unchanged: ${report.protectedHashesUnchanged}\n\nFlutter/Android/Premium PASS claimed: false\n\n## Compact copies\n${Object.entries(report.compactCopies).map(([k, v]) => `- ${k}: ${v}`).join('\n')}\n\n## Errors\n${errors.map((e) => `- ${e}`).join('\n') || '- none'}\n`);

if (errors.length) {
  console.error(errors.join('\n'));
  process.exit(1);
}
console.log(report.status);
