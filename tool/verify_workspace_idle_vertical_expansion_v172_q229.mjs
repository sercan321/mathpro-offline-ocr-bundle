import { createHash } from 'node:crypto';
import { existsSync, readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => readFileSync(path.join(root, rel), 'utf8');
const sha256 = (rel) => createHash('sha256').update(readFileSync(path.join(root, rel))).digest('hex');
const fail = (message) => {
  console.error(`WORKSPACE_IDLE_VERTICAL_EXPANSION_Q229_FAIL: ${message}`);
  process.exit(1);
};
const requireIncludes = (rel, needle, label = needle) => {
  const body = read(rel);
  if (!body.includes(needle)) fail(`${rel} missing ${label}`);
};
const requireNotIncludes = (rel, needle, label = needle) => {
  const body = read(rel);
  if (body.includes(needle)) fail(`${rel} still contains forbidden ${label}`);
};

const workspace = 'lib/features/workspace/workspace_panel.dart';
const graphCard = 'lib/features/graph/graph_card.dart';
const policy = 'lib/features/workspace/workspace_idle_vertical_expansion_policy.dart';
const manifest = 'assets/mathlive/manifest.json';

for (const rel of [workspace, graphCard, policy, manifest]) {
  if (!existsSync(path.join(root, rel))) fail(`missing required file ${rel}`);
}

requireIncludes(workspace, 'final idleExpansion = graphExpression == null && !templateTrayOpen && !showSolutionPanel;', 'idle-only expansion gate');
requireIncludes(workspace, 'idleExpansion: idleExpansion', 'idleExpansion propagation');
requireIncludes(workspace, 'final resultFlex = !stepsPanelOpen && cardVisualHeight >= 260 ? 3 : 2;', 'non-solution result panel flex');
requireIncludes(workspace, 'Q229R4 root fix: the parent already allocates the exact vertical slot', 'Q229R4 root slot-fill successor');
requireIncludes(workspace, 'return availableHeight;', 'Q229R4 direct slot fill');
requireNotIncludes(workspace, '.clamp(260.0, 348.0)', 'legacy idle 348 cap removed by Q229R4');
requireNotIncludes(workspace, 'availableHeight.clamp(220.0, 292.0)', 'legacy MORE 292 cap removed by Q229R4');
requireIncludes(workspace, 'if (templateTrayOpen || stepsPanelOpen || idleExpansion) {', 'slot-fill shared context branch');
requireIncludes(workspace, 'MathLiveProductionEditorSurface(', 'MathLive production editor still used');
requireIncludes(workspace, 'ResultView(', 'Q226 result view still used');
requireIncludes(workspace, 'SolutionStepsPanel(', 'solution panel still mounted by existing route');

const graphBody = read(graphCard);
if (graphBody.includes("import 'graph_painter.dart';") && !graphBody.includes('GraphExpressionEvaluator(')) {
  fail('graph_painter.dart import exists but GraphExpressionEvaluator is not used');
}
if (!graphBody.includes('GraphExpressionEvaluator(')) {
  fail('graph card lost GraphExpressionEvaluator value-at-origin path');
}

requireIncludes(policy, "keyboardLayoutMayChange = false", 'keyboard guard');
requireIncludes(policy, "mathLiveProductionEditorMayChange = false", 'MathLive guard');
requireIncludes(policy, "graphRuntimeMayBeRedesigned = false", 'Graph runtime guard');
requireIncludes(policy, "solutionRuntimeMayChange = false", 'Solution runtime guard');

const json = JSON.parse(read(manifest));
if (!['V172-Q229-WORKSPACE-IDLE-VERTICAL-EXPANSION', 'V172-Q229R2-WORKSPACE-BOTTOM-GAP-OPTICAL-MATCH', 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX'].includes(json.workspaceIdleExpansionLatestPhase)) {
  fail('manifest missing Q229/Q229R2/Q229R4 latest phase marker');
}
if (json.v172Q229WorkspaceIdleVerticalExpansion?.keyboardFilesMutated !== false) fail('manifest keyboard mutation guard missing');
if (json.v172Q229WorkspaceIdleVerticalExpansion?.mathLiveProductionFilesMutated !== false) fail('manifest MathLive mutation guard missing');
if (json.v172Q229WorkspaceIdleVerticalExpansion?.solutionFilesMutated !== false) fail('manifest solution mutation guard missing');

const protectedHashes = {
  'lib/features/keyboard/key_config.dart': '4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2',
  'lib/features/workspace/template_tray.dart': 'b58f05b9f6f8b089a4335554f062e0652929bd9c2f60d3fdbf79d4bc87aca678',
  'assets/mathlive/mathlive_prod_bridge.js': 'fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4',
  'assets/mathlive/main_editor_prod.html': 'f32e884f83f94d3ac2077f2c65d0278edbba163ca30c640605edc75c337dd9cd',
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
for (const [rel, expected] of Object.entries(protectedHashes)) {
  if (!existsSync(path.join(root, rel))) fail(`protected file missing: ${rel}`);
  const actual = sha256(rel);
  if (actual !== expected) fail(`protected/non-target hash changed for ${rel}: ${actual} !== ${expected}`);
}

mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
const report = {
  phase: 'V172-Q229-WORKSPACE-IDLE-VERTICAL-EXPANSION-DEAD-GAP-RECLAIM',
  successorPhase: 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX',
  status: 'STATIC_READY_WITH_Q231_LONG_PRESS_SUCCESSOR_WITH_Q231R1_LONG_PRESS_ANCHOR_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED',
  idleExpansionGate: true,
  keyboardProtected: true,
  mathLiveProtected: true,
  solutionProtected: true,
  graphCardRuntimeUnchanged: true,
  graphPainterImportKeptBecauseUsed: true,
  checkedProtectedHashes: Object.keys(protectedHashes),
};
writeFileSync(path.join(root, 'tool/reports/workspace_idle_vertical_expansion_q229_report.json'), `${JSON.stringify(report, null, 2)}\n`);
writeFileSync(path.join(root, 'tool/reports/workspace_idle_vertical_expansion_q229_report.md'), `# Q229 Workspace Idle Vertical Expansion Report\n\nStatus: ${report.status}\n\n- Idle expansion gate: yes\n- Keyboard protected: yes\n- MathLive production protected: yes\n- Solution runtime protected: yes\n- Graph runtime behavior unchanged: yes\n- graph_painter.dart import kept because GraphExpressionEvaluator is used: yes\n`);

console.log('WORKSPACE_IDLE_VERTICAL_EXPANSION_Q229_STATIC_READY_WITH_Q229R4_SLOT_FILL_SUCCESSOR_WITH_Q231R1_LONG_PRESS_ANCHOR_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED');
