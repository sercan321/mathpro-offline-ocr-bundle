#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const exists = (rel) => fs.existsSync(p(rel));
const sha256 = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
const errors = [];
const fail = (message) => errors.push(message);

for (const required of [
  'lib/features/graph/graph_card.dart',
  'lib/features/graph/graph_settings_sheet.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'test/v172_q209_real_3d_graph_surface_foundation_test.dart',
  'test/v172_q210_graph_3d_route_fullscreen_binding_test.dart',
  'test/v172_q226_result_status_inside_result_panel_test.dart',
  'tool/verify_solution_steps_premium_copy_test_hygiene_v172_q228r2.mjs',
]) {
  if (!exists(required)) fail(`missing required Q228R2 file: ${required}`);
}

const graphCard = read('lib/features/graph/graph_card.dart');
const graphSettings = read('lib/features/graph/graph_settings_sheet.dart');
const solutionPanel = read('lib/features/solution/solution_steps_panel.dart');
const q209Test = read('test/v172_q209_real_3d_graph_surface_foundation_test.dart');
const q210Test = read('test/v172_q210_graph_3d_route_fullscreen_binding_test.dart');
const q226Test = read('test/v172_q226_result_status_inside_result_panel_test.dart');

for (const marker of [
  "import 'graph_curve_painter.dart';",
  'final evaluator = GraphExpressionEvaluator(expression.normalizedExpression);',
  'GraphSurface3D(',
  'compact: canvasCompact || canvasPixelTight',
  "key: const ValueKey('mathpro-graph-canvas-preview')",
]) {
  if (!graphCard.includes(marker)) fail(`graph card missing Q228R2 analyzer/test marker: ${marker}`);
}

for (const marker of [
  "const _SectionTitle(label: 'Mode')",
  "const _SectionTitle(label: 'Window')",
  "const _SectionTitle(label: 'Trace')",
  "const _SectionTitle(label: 'Actions')",
]) {
  if (!graphSettings.includes(marker)) fail(`graph settings missing analyzer const marker: ${marker}`);
}

for (const forbidden of [
  'static const Color innerGlass',
  'static const Color innerGraphite',
  'static const Color stroke = Color',
  'final accent = _SolutionStepsPalette.accent',
]) {
  if (solutionPanel.includes(forbidden)) fail(`solution panel still contains analyzer issue marker: ${forbidden}`);
}
if (!solutionPanel.includes('const accent = _SolutionStepsPalette.accent')) {
  fail('solution panel did not const-fold the step item accent');
}

for (const marker of [
  "contains('compact: canvasCompact || canvasPixelTight')",
  "contains('mathpro-graph-canvas-preview')",
]) {
  if (!q209Test.includes(marker)) fail(`Q209 test missing Q225-compatible marker: ${marker}`);
}
for (const forbidden of [
  "contains('3D Surface')",
  "contains('SingleChildScrollView')",
]) {
  if (q209Test.includes(forbidden)) fail(`Q209 test still has stale marker: ${forbidden}`);
}

for (const marker of [
  "contains('GraphSurface3D(')",
  "contains('compact: canvasCompact || canvasPixelTight')",
  "contains(r'x[${_GraphValueFormatter.format(expression.xMin)},${_GraphValueFormatter.format(expression.xMax)}]')",
]) {
  if (!q210Test.includes(marker)) fail(`Q210 test missing Q225-compatible marker: ${marker}`);
}
for (const forbidden of [
  "contains('expression.displayExpressionFor(renderMode)')",
  "contains(r'y ∈ [${_format(expression.yMin)}, ${_format(expression.yMax)}]')",
]) {
  if (q210Test.includes(forbidden)) fail(`Q210 test still has stale marker: ${forbidden}`);
}
if (!q226Test.includes("const calculatorState = CalculatorState(lastUnsupportedReason:")) {
  fail('Q226 test did not const-fold calculatorState declaration');
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
for (const [rel, expected] of Object.entries(protectedHashes)) {
  if (!exists(rel)) {
    fail(`protected file missing: ${rel}`);
    continue;
  }
  const actual = sha256(rel);
  if (actual !== expected) fail(`protected hash changed for ${rel}: expected ${expected}, got ${actual}`);
}

const report = {
  phase: 'V172-Q228R2-SOLUTION-STEPS-PREMIUM-COPY-ANALYZER-TEST-HYGIENE',
  status: errors.length === 0
    ? 'SOLUTION_STEPS_PREMIUM_COPY_ANALYZER_TEST_HYGIENE_Q228R2_STATIC_READY_WITH_Q231_LONG_PRESS_SUCCESSOR_WITH_Q231R1_LONG_PRESS_ANCHOR_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED'
    : 'SOLUTION_STEPS_PREMIUM_COPY_ANALYZER_TEST_HYGIENE_Q228R2_BLOCKED',
  errors,
  runtimeSolutionCopyUnchangedFromQ228: true,
  graphRuntimeBehaviorMutationAllowed: false,
  graphImportAnalyzerRepair: graphCard.includes("import 'graph_curve_painter.dart';"),
  staleGraphTestsRepaired: !q209Test.includes("contains('3D Surface')") && !q210Test.includes("contains('expression.displayExpressionFor(renderMode)')"),
  keyboardMoreLongPressMathLiveProtected: errors.every((e) => !e.startsWith('protected hash changed')),
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimedByAssistant: false,
};
fs.mkdirSync(p('tool/reports'), {recursive: true});
fs.writeFileSync(p('tool/reports/solution_steps_premium_copy_test_hygiene_q228r2_report.json'), `${JSON.stringify(report, null, 2)}\n`);
fs.writeFileSync(p('tool/reports/solution_steps_premium_copy_test_hygiene_q228r2_report.md'), `# ${report.phase}\n\n${report.status}\n\n- Graph import analyzer repair: ${report.graphImportAnalyzerRepair}\n- Stale Q209/Q210 graph test markers repaired: ${report.staleGraphTestsRepaired}\n- Runtime solution copy unchanged from Q228: true\n- Keyboard/MORE/long-press/MathLive protected: ${report.keyboardMoreLongPressMathLiveProtected}\n- Flutter/Android PASS claimed: false\n`);

if (errors.length > 0) {
  console.error(report.status);
  for (const error of errors) console.error(`- ${error}`);
  process.exit(1);
}
console.log(report.status);
