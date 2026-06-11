#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const sha256 = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
const errors = [];
const fail = (message) => errors.push(message);

for (const required of [
  'lib/features/solution/solution_step_models.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/solution/solution_steps_single_surface_cleanup_policy.dart',
  'lib/features/solution/solution_steps_premium_copy_polish_policy.dart',
  'test/v172_q228_solution_steps_premium_copy_polish_test.dart',
  'tool/verify_solution_steps_premium_copy_polish_v172_q228.mjs',
]) {
  if (!exists(required)) fail(`missing required file: ${required}`);
}

const model = read('lib/features/solution/solution_step_models.dart');
const panel = read('lib/features/solution/solution_steps_panel.dart');
const q227Policy = read('lib/features/solution/solution_steps_single_surface_cleanup_policy.dart');
const q228Policy = read('lib/features/solution/solution_steps_premium_copy_polish_policy.dart');
const q228Test = read('test/v172_q228_solution_steps_premium_copy_polish_test.dart');

for (const marker of [
  "title: 'İfade alındı'",
  "title: semantic.kind == 'numeric' ? 'İşlem değerlendirildi' : _shortTitleFor(semantic)",
  "title: 'Sonuç'",
  'static String _shortTitleFor(MathSemanticSummary semantic)',
  'static String _shortDescriptionFor(MathSemanticSummary semantic)',
  'static String _shortSemanticStepTitle(String semanticStep)',
  'static String _shortUnsupportedReason(String unsupported)',
]) {
  if (!model.includes(marker)) fail(`solution composer missing Q228 copy marker: ${marker}`);
}

for (const marker of [
  'ListView.separated',
  "key: const ValueKey('mathpro-solution-steps-scroll')",
  'separatorBuilder: (context, index) => const _StepSeparator()',
  'class _SolutionStepItem',
  "key: ValueKey('mathpro-solution-step-item-",
  'class _StepNumberChip',
  'class _MathLineInline',
  "key: const ValueKey('mathpro-solution-empty-state-message')",
  'İfade girildiğinde çözüm adımları burada görünür.',
  'Bu ifade için çözüm adımı yok.',
]) {
  if (!panel.includes(marker)) fail(`solution panel missing Q227/Q228 marker: ${marker}`);
}

for (const forbidden of [
  'Yazılan ifade hesaplama köprüsüne gönderilmeden önce editördeki mevcut biçimiyle korunur.',
  'Desteklenen temel aritmetik ifade güvenli sayısal değerlendiriciden geçirilir.',
  'Sonuç ana kartta görünür kalır; panel yalnızca açıklama katmanı olarak açılır.',
  'Bu ifade için çözüm adımı henüz oluşturulamadı.',
  'Gelişmiş adım motoru gerekli',
  'Solver bridge durumu',
  'Sayısal değerlendirme',
  'Sonuç gösterildi',
  'İfade hazırlandı',
]) {
  if (model.includes(forbidden)) fail(`solution model still contains long/old runtime copy: ${forbidden}`);
  if (panel.includes(forbidden)) fail(`solution panel still contains long/old runtime copy: ${forbidden}`);
}

for (const forbidden of [
  'class _SolutionStepCard',
  'class _AnimatedStepCard',
  'class _MathLineBlock',
  'class _StepToneChip',
  'mathpro-solution-step-card-',
  'mathpro-solution-step-tone-chip-',
  'widget.snapshot.statusText!',
]) {
  if (panel.includes(forbidden)) fail(`Q227 single-surface cleanup regressed: ${forbidden}`);
}

for (const marker of [
  "phase = 'V172-Q228-SOLUTION-STEPS-PREMIUM-COPY-POLISH'",
  "emptyIdleMessage = 'İfade girildiğinde çözüm adımları burada görünür.'",
  "expressionWithoutStepsMessage = 'Bu ifade için çözüm adımı yok.'",
  'copyOnly = true',
  'singleSurfaceLayoutKept = true',
  'nestedStepCardsAllowed = false',
  'longTechnicalCopyAllowed = false',
  'headerSubtitleAllowed = false',
  'solverMutationAllowed = false',
  'keyboardMutationAllowed = false',
  'moreMutationAllowed = false',
  'longPressMutationAllowed = false',
  'mathLiveProductionRouteMutationAllowed = false',
  'graphMutationAllowed = false',
  'historyMutationAllowed = false',
  'workspaceLayoutMutationAllowed = false',
]) {
  if (!q228Policy.includes(marker)) fail(`Q228 policy missing marker: ${marker}`);
}

if (!q227Policy.includes("expressionWithoutStepsMessage = 'Bu ifade için çözüm adımı yok.'")) {
  fail('Q227 policy was not refined to the Q228 shorter empty-expression copy');
}

for (const marker of [
  'Q228 policy locks copy-only solution step polish scope',
  'Q228 numeric steps use short premium copy',
  'Q228 source keeps Q227 single-surface panel and removes technical copy',
  "containsAllInOrder(<String>[",
  "'İfade alındı'",
  "'İşlem değerlendirildi'",
  "'Sonuç'",
  "isNot(contains('hesaplama köprüsüne'))",
]) {
  if (!q228Test.includes(marker)) fail(`Q228 test missing coverage marker: ${marker}`);
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
  'lib/features/graph/graph_surface.dart': '1bd5c0810742213990647cf89e172190971950046e807caa495def771ae54a49',
  'lib/features/graph/graph_painter.dart': '7683c0a259a6c21b6dd7a9f8d2aa3aeae5baff010b1515079f932c61d70fdec7',
  'lib/features/graph/graph_style.dart': 'e509b94e3b59c60773c5108debe94e5d8eb5ba3f6483465b5118cd44b34e029e',
  'lib/features/graph/graph_settings_sheet.dart': 'a4f9e8933b4eec7acaadb39072b35103bae1d13cba578164333aa9f09ba16d94',
  'lib/features/graph/graph_surface_3d.dart': '49865e359cd6a25b0cccb081e6d4c8239f4cf9c3b510873b3608d717be3ad997',
  'lib/features/graph/graph_models.dart': '407841e339467e9215ef8b59f11e79c383f928ccbe97ee4d44527354fb85bdcf',
};

for (const [rel, expected] of Object.entries(protectedHashes)) {
  if (!exists(rel)) {
    fail(`protected file missing: ${rel}`);
    continue;
  }
  const actual = sha256(rel);
  if (actual !== expected) fail(`protected hash changed for ${rel}: expected ${expected}, got ${actual}`);
}

if (errors.length > 0) {
  console.error('SOLUTION_STEPS_PREMIUM_COPY_POLISH_Q228_FAILED');
  for (const error of errors) console.error(`- ${error}`);
  process.exit(1);
}

const report = {
  phase: 'V172-Q228-SOLUTION-STEPS-PREMIUM-COPY-POLISH',
  status: 'SOLUTION_STEPS_PREMIUM_COPY_POLISH_Q228_STATIC_READY_WITH_Q228R3_FLUTTER_TEST_HYGIENE_SUCCESSOR_WITH_Q231R1_LONG_PRESS_ANCHOR_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED',
  copyOnly: true,
  singleSurfaceLayoutKept: true,
  protectedHashUnchanged: true,
  q228r2AnalyzerTestHygieneSuccessor: true,
  runtimeRemovedCopy: [
    'Yazılan ifade hesaplama köprüsüne gönderilmeden önce editördeki mevcut biçimiyle korunur.',
    'Desteklenen temel aritmetik ifade güvenli sayısal değerlendiriciden geçirilir.',
    'Sonuç ana kartta görünür kalır; panel yalnızca açıklama katmanı olarak açılır.',
    'Bu ifade için çözüm adımı henüz oluşturulamadı.',
  ],
  preferredCoreStepTitles: ['İfade alındı', 'İşlem değerlendirildi', 'Sonuç'],
};
fs.mkdirSync(p('tool/reports'), {recursive: true});
fs.writeFileSync(p('tool/reports/solution_steps_premium_copy_polish_q228_report.json'), `${JSON.stringify(report, null, 2)}\n`);
fs.writeFileSync(p('tool/reports/solution_steps_premium_copy_polish_q228_report.md'), `# ${report.phase}\n\n${report.status}\n\n- Copy-only: true\n- Q227 single surface kept: true\n- Protected hash unchanged: true\n- Core titles: ${report.preferredCoreStepTitles.join(' / ')}\n`);
console.log(report.status);
