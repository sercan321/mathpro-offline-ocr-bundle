import { createHash } from 'node:crypto';
import { existsSync, readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => readFileSync(path.join(root, rel), 'utf8');
const sha256 = (rel) => createHash('sha256').update(readFileSync(path.join(root, rel))).digest('hex');
const fail = (message) => {
  console.error(`WORKSPACE_BOTTOM_GAP_OPTICAL_MATCH_Q229R2_FAIL: ${message}`);
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
const policy = 'lib/features/workspace/workspace_bottom_gap_optical_match_policy.dart';
const q229Policy = 'lib/features/workspace/workspace_idle_vertical_expansion_policy.dart';
const manifest = 'assets/mathlive/manifest.json';

for (const rel of [workspace, policy, q229Policy, manifest]) {
  if (!existsSync(path.join(root, rel))) fail(`missing required file ${rel}`);
}

requireIncludes(workspace, 'final idleExpansion = graphExpression == null && !templateTrayOpen && !showSolutionPanel;', 'idle-only gate');
requireIncludes(workspace, 'Q229R2: mirror the compact MORE-open rhythm', 'MORE-open reference comment');
requireIncludes(workspace, 'if (height >= 420) return const EdgeInsets.fromLTRB(0.0, 8, 0.0, 5);', 'tall idle bottom gap polish');
requireIncludes(workspace, 'if (height >= 360) return const EdgeInsets.fromLTRB(0.0, 7, 0.0, 5);', 'normal idle bottom gap polish');
requireIncludes(workspace, 'Q229R4 root fix: the parent already allocates the exact vertical slot', 'Q229R4 root slot-fill successor');
requireIncludes(workspace, 'return availableHeight;', 'Q229R4 direct slot fill');
requireNotIncludes(workspace, '.clamp(238.0, 316.0)', 'legacy idle 316 cap removed by Q229R4');
requireNotIncludes(workspace, '.clamp(260.0, 348.0)', 'legacy idle 348 cap removed by Q229R4');
requireNotIncludes(workspace, 'availableHeight.clamp(220.0, 292.0)', 'legacy MORE 292 cap removed by Q229R4');
requireIncludes(workspace, 'if (templateTrayOpen || stepsPanelOpen || idleExpansion) {', 'slot-fill shared context branch');
requireIncludes(workspace, 'GraphCard(', 'graph route preserved');
requireIncludes(workspace, 'TemplateTray(', 'MORE/template tray route preserved');
requireIncludes(workspace, 'SolutionStepsPanel(', 'solution route preserved');
requireIncludes(workspace, 'MathLiveProductionEditorSurface(', 'MathLive production route preserved');
requireIncludes(workspace, 'ResultView(', 'Q226 result/status route preserved');

requireIncludes(policy, "phase = 'V172-Q229R2-WORKSPACE-BOTTOM-GAP-OPTICAL-MATCH'", 'Q229R2 policy phase');
requireIncludes(policy, "reference = 'MORE-open compact tray separator rhythm'", 'MORE reference');
requireIncludes(policy, 'keyboardLayoutMayChange = false', 'keyboard guard');
requireIncludes(policy, 'mathLiveProductionEditorMayChange = false', 'MathLive guard');
requireIncludes(policy, 'graphRuntimeMayChange = false', 'Graph guard');
requireIncludes(policy, 'solutionRuntimeMayChange = false', 'Solution guard');
requireIncludes(policy, 'moreTemplateTrayMayChange = false', 'MORE guard');
requireIncludes(policy, "successorPhase = 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX'", 'Q229R4 successor marker');
requireIncludes(q229Policy, "successorPhase = 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX'", 'Q229R4 successor marker');

const json = JSON.parse(read(manifest));
if (!['V172-Q229R2-WORKSPACE-BOTTOM-GAP-OPTICAL-MATCH','V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX'].includes(json.workspaceIdleExpansionLatestPhase)) fail('manifest latest workspace phase is not Q229R2/Q229R4');
if (!['V172-Q229R2-WORKSPACE-BOTTOM-GAP-OPTICAL-MATCH','V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX'].includes(json.workspaceBottomGapOpticalMatchLatestPhase)) fail('manifest missing bottom gap latest phase');
const envelope = json.v172Q229R2WorkspaceBottomGapOpticalMatch;
if (!envelope) fail('manifest missing Q229R2 envelope');
if (envelope.keyboardFilesMutated !== false) fail('manifest keyboard guard broken');
if (envelope.mathLiveProductionFilesMutated !== false) fail('manifest MathLive guard broken');
if (envelope.graphRuntimeMutated !== false) fail('manifest Graph guard broken');
if (envelope.solutionRuntimeMutated !== false) fail('manifest Solution guard broken');
if (envelope.moreTemplateTrayMutated !== false) fail('manifest MORE guard broken');
if (envelope.onlyWorkspaceIdleSpacingMutated !== true) fail('manifest target scope missing');

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
  'lib/features/graph/graph_surface.dart': '1bd5c0810742213990647cf89e172190971950046e807caa495def771ae54a49',
  'lib/features/graph/graph_settings_sheet.dart': '45e8b0492777533d8b9c8d775f35ff7bbe1b98a6cf399eec53af826b7495320e',
  'lib/features/graph/graph_models.dart': '277974a4a621c27c6989b990ebdcfdd2c38af0e0baae024327b17f900034d96d',
};
for (const [rel, expected] of Object.entries(protectedHashes)) {
  if (!existsSync(path.join(root, rel))) fail(`protected file missing: ${rel}`);
  const actual = sha256(rel);
  if (actual !== expected) fail(`protected/non-target hash changed for ${rel}: ${actual} !== ${expected}`);
}

mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
const report = {
  phase: 'V172-Q229R2-WORKSPACE-BOTTOM-GAP-OPTICAL-MATCH',
  status: 'STATIC_READY_WITH_Q231_LONG_PRESS_AND_Q234_GRAPH_VISUAL_SUCCESSOR_WITH_Q231R1_LONG_PRESS_ANCHOR_AND_Q234_GRAPH_VISUAL_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED',
  idleBottomGapReference: 'MORE-open compact tray separator rhythm',
  idleBottomGapTargetPx: '8-12 optical pixels',
  keyboardProtected: true,
  mathLiveProtected: true,
  graphProtected: true,
  solutionProtected: true,
  contextShrinkPreserved: true,
  checkedProtectedHashes: Object.keys(protectedHashes),
};
writeFileSync(path.join(root, 'tool/reports/workspace_bottom_gap_optical_match_q229r2_report.json'), `${JSON.stringify(report, null, 2)}\n`);
writeFileSync(path.join(root, 'tool/reports/workspace_bottom_gap_optical_match_q229r2_report.md'), `# Q229R2 Workspace Bottom Gap Optical Match Report\n\nStatus: ${report.status}\n\n- Idle bottom gap reference: ${report.idleBottomGapReference}\n- Target: ${report.idleBottomGapTargetPx}\n- Keyboard protected: yes\n- MathLive production protected: yes\n- Graph runtime protected: yes\n- Solution runtime protected: yes\n- Graph/MORE/Solution shrink behavior preserved: yes\n`);

console.log('WORKSPACE_BOTTOM_GAP_OPTICAL_MATCH_Q229R2_STATIC_READY_WITH_Q229R4_SLOT_FILL_SUCCESSOR_WITH_Q231R1_LONG_PRESS_ANCHOR_AND_Q234_GRAPH_VISUAL_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED');
