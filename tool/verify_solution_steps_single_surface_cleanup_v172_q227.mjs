#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const errors = [];
const q231r2LegacySuccessorMarker = 'Q231R2_LONG_PRESS_ANCHOR_FINAL_HYGIENE_SUCCESSOR';
const fail = (message) => errors.push(message);

for (const required of [
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/solution/solution_step_models.dart',
  'lib/features/solution/solution_steps_single_surface_cleanup_policy.dart',
  'test/v172_q227_solution_steps_single_surface_cleanup_test.dart',
  'tool/verify_solution_steps_single_surface_cleanup_v172_q227.mjs',
]) {
  if (!exists(required)) fail(`missing required file: ${required}`);
}

const panel = read('lib/features/solution/solution_steps_panel.dart');
const model = read('lib/features/solution/solution_step_models.dart');
const policy = read('lib/features/solution/solution_steps_single_surface_cleanup_policy.dart');
const test = read('test/v172_q227_solution_steps_single_surface_cleanup_test.dart');

for (const marker of [
  'ListView.separated',
  "key: const ValueKey('mathpro-solution-steps-scroll')",
  'separatorBuilder: (context, index) => const _StepSeparator()',
  'class _SolutionStepItem',
  "key: ValueKey('mathpro-solution-step-item-",
  'class _StepNumberChip',
  'class _MathLineInline',
  "key: ValueKey('mathpro-solution-step-math-scroll-",
  'class _EmptySolutionSteps',
  "key: const ValueKey('mathpro-solution-empty-state-message')",
  'İfade girildiğinde çözüm adımları burada görünür.',
  'Bu ifade için çözüm adımı yok.',
  'maxLines: 2',
  'TextOverflow.ellipsis',
  'softWrap: true',
]) {
  if (!panel.includes(marker)) fail(`solution panel missing Q227 marker: ${marker}`);
}

for (const forbidden of [
  'class _SolutionStepCard',
  'class _AnimatedStepCard',
  'class _MathLineBlock',
  'class _StepToneChip',
  'class _StepTimeline',
  'mathpro-solution-step-card-',
  'mathpro-solution-step-tone-chip-',
  'Matematik satırı',
  'widget.snapshot.statusText!',
]) {
  if (panel.includes(forbidden)) fail(`solution panel still contains nested-card/tutorial clutter marker: ${forbidden}`);
}

for (const forbidden of [
  'İfade yazıldığında adım paneli aynı ekranda hazır kalır.',
  'Çözüm adımları, yazılan ifade ve hesap sonucu ile aynı bağlamda gösterilir.',
  'Panel açıldığında ifade, sonuç ve klavye görünür kalacak şekilde tasarlanmıştır.',
  "title: 'İfade bekleniyor'",
  "title: 'Bağlam korunur'",
]) {
  if (model.includes(forbidden)) fail(`solution composer still emits old empty tutorial content: ${forbidden}`);
}

const emptyBlock = model.indexOf('if (cleanExpression.isEmpty)');
const emptyReturn = model.indexOf('steps: const <SolutionStep>[]', emptyBlock);
if (!(emptyBlock >= 0 && emptyReturn > emptyBlock)) {
  fail('empty solution composer branch does not return an empty steps list');
}

for (const marker of [
  "phase = 'V172-Q227-SOLUTION-STEPS-SINGLE-SURFACE-CLEANUP'",
  'singlePanelSurfaceOnly = true',
  'tutorialEmptyCardsRemoved = true',
  'headerStatusSubtitleRemoved = true',
  'stepCardsNestedInPanelAllowed = false',
  'inlineMathLaneKept = true',
  'internalScrollKept = true',
  'mediumExpandedMechanicsKept = true',
  'dragMechanicsKept = true',
  'keyboardMutationAllowed = false',
  'moreMutationAllowed = false',
  'longPressMutationAllowed = false',
  'mathLiveProductionRouteMutationAllowed = false',
  'graphMutationAllowed = false',
  'historyMutationAllowed = false',
  'solverMutationAllowed = false',
]) {
  if (!policy.includes(marker)) fail(`Q227 policy missing marker: ${marker}`);
}

for (const marker of [
  'Q227 policy locks solution panel simplification scope',
  'Q227 empty composer no longer emits tutorial steps',
  'Q227 source keeps single-surface list items and removes nested step-card widgets',
  "contains('mathpro-solution-step-item-')",
  "isNot(contains('mathpro-solution-step-card-'))",
]) {
  if (!test.includes(marker)) fail(`Q227 test missing coverage marker: ${marker}`);
}

const protectedHashes = {
  'lib/features/keyboard/key_config.dart': '4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2',
  'lib/features/keyboard/math_keyboard.dart': 'fc8e6504448bbdd64bdbb674fd000c04511ab185a8a110eecb7102dce19d116c',
  'lib/features/keyboard/bottom_dock.dart': 'a6e8c25369faa0cac016314c42a93be76ac5ca21c0b16c4152b279a339f9c354',
  'lib/features/keyboard/premium_key.dart': '4311a54f0f4e21b3b134552af2613d2ff30fed2078ebd6279a222d877fa21b43',
  'lib/features/keyboard/long_press_popup.dart': '4bb7e11846efd80d831cc3178b72f57207e458dd7e72bb27f1615d7218769369',
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
  'lib/features/graph/graph_card.dart': '124accae8499c2dbc8cb6e1dde3a2317dfaafad576363aecebd5f78c94f22b6f',
  'lib/features/graph/graph_surface.dart': '1bd5c0810742213990647cf89e172190971950046e807caa495def771ae54a49',
  'lib/features/graph/graph_painter.dart': '2b56953cf7d884399bf96b63e3d6130b6bc6db9e674abd0b7c0e69756d6f6eb1',
  'lib/features/graph/graph_style.dart': 'e509b94e3b59c60773c5108debe94e5d8eb5ba3f6483465b5118cd44b34e029e',
  'lib/features/graph/graph_settings_sheet.dart': '45e8b0492777533d8b9c8d775f35ff7bbe1b98a6cf399eec53af826b7495320e',
  'lib/features/graph/graph_surface_3d.dart': '0662ff9e6828b579b51434e07d0cc3bef80065cf773a18b79b45afa88928037c',
  'lib/features/graph/graph_models.dart': '277974a4a621c27c6989b990ebdcfdd2c38af0e0baae024327b17f900034d96d',
};

for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) {
    fail(`protected/non-solution file missing: ${file}`);
    continue;
  }
  const actual = crypto.createHash('sha256').update(fs.readFileSync(p(file))).digest('hex');
  if (actual !== expected) fail(`protected/non-solution hash changed for ${file}: ${actual} expected ${expected}`);
}

const report = {
  phase: 'V172-Q227',
  status: errors.length === 0
    ? 'SOLUTION_STEPS_SINGLE_SURFACE_CLEANUP_Q227_STATIC_READY_WITH_Q231R2_LONG_PRESS_ANCHOR_FINAL_HYGIENE_AND_Q234_GRAPH_VISUAL_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED'
    : 'SOLUTION_STEPS_SINGLE_SURFACE_CLEANUP_Q227_BLOCKED',
  errors,
  solutionOnlySourceMutation: true,
  emptyTutorialStepsRemoved: !model.includes('Bağlam korunur') && !model.includes('Panel açıldığında ifade'),
  singleSurfaceListItems: panel.includes('mathpro-solution-step-item-') && !panel.includes('mathpro-solution-step-card-'),
  internalScrollKept: panel.includes("key: const ValueKey('mathpro-solution-steps-scroll')"),
  mediumExpandedMechanicsKept: panel.includes('widget.onToggleExpanded') && panel.includes('mathpro-solution-panel-state-pill'),
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimedByAssistant: false,
  q231r2LongPressAnchorFinalHygieneSuccessor: true,
};

fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/solution_steps_single_surface_cleanup_q227_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(p('tool/reports/solution_steps_single_surface_cleanup_q227_report.md'), `# V172-Q227 Solution Steps Single-Surface Cleanup\n\nStatus: ${report.status}\n\nEmpty tutorial steps removed: ${report.emptyTutorialStepsRemoved}\n\nSingle-surface list items: ${report.singleSurfaceListItems}\n\nInternal scroll kept: ${report.internalScrollKept}\n\nMedium/expanded mechanics kept: ${report.mediumExpandedMechanicsKept}\n\nFlutter/Android/Premium PASS claimed: false\n\n## Errors\n${errors.map((e) => `- ${e}`).join('\n') || '- none'}\n`);

if (errors.length) {
  console.error(errors.join('\n'));
  process.exit(1);
}
console.log(report.status);
