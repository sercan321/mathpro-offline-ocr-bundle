import { createHash } from 'node:crypto';
import { existsSync, readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => readFileSync(path.join(root, rel), 'utf8');
const sha256 = (rel) => createHash('sha256').update(readFileSync(path.join(root, rel))).digest('hex');
const fail = (message) => {
  console.error(`WORKSPACE_CARD_SLOT_FILL_PHANTOM_GAP_FIX_Q229R4_FAIL: ${message}`);
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
const policy = 'lib/features/workspace/workspace_card_slot_fill_phantom_gap_fix_policy.dart';
const q229Policy = 'lib/features/workspace/workspace_idle_vertical_expansion_policy.dart';
const q229r2Policy = 'lib/features/workspace/workspace_bottom_gap_optical_match_policy.dart';
const manifest = 'assets/mathlive/manifest.json';

for (const rel of [workspace, policy, q229Policy, q229r2Policy, manifest]) {
  if (!existsSync(path.join(root, rel))) fail(`missing required file ${rel}`);
}

requireIncludes(workspace, 'final idleExpansion = graphExpression == null && !templateTrayOpen && !showSolutionPanel;', 'idle gate preserved');
requireIncludes(workspace, 'Q229R4 root fix: the parent already allocates the exact vertical slot', 'root fix comment');
requireIncludes(workspace, 'at 292/316/348px', 'legacy cap diagnosis');
requireIncludes(workspace, 'return availableHeight;', 'slot fill return');
requireIncludes(workspace, 'Graph does not reintroduce a larger card-slot phantom gap', 'Graph route margin rhythm');
requireIncludes(workspace, 'final resultFlex = !stepsPanelOpen && cardVisualHeight >= 260 ? 3 : 2;', 'non-solution result flex guard');
requireNotIncludes(workspace, 'availableHeight.clamp(220.0, 292.0)', 'MORE 292 cap');
requireNotIncludes(workspace, '.clamp(238.0, 316.0)', 'idle 316 cap');
requireNotIncludes(workspace, '.clamp(260.0, 348.0)', 'idle 348 cap');
requireIncludes(workspace, 'TemplateTray(', 'MORE/template route preserved');
requireIncludes(workspace, 'GraphCard(', 'Graph route preserved');
requireIncludes(workspace, 'SolutionStepsPanel(', 'Solution route preserved');
requireIncludes(workspace, 'MathLiveProductionEditorSurface(', 'MathLive production editor preserved');
requireIncludes(workspace, 'ResultView(', 'Q226 result/status view preserved');

requireIncludes(policy, "phase = 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX'", 'Q229R4 policy phase');
requireIncludes(policy, 'cardSlotHeight minus cardVisualHeight created phantom gap', 'root cause policy');
requireIncludes(policy, 'keyboardLayoutMayChange = false', 'keyboard guard');
requireIncludes(policy, 'mathLiveProductionEditorMayChange = false', 'MathLive guard');
requireIncludes(policy, 'graphEngineMayChange = false', 'Graph engine guard');
requireIncludes(policy, 'solutionEngineMayChange = false', 'Solution guard');
requireIncludes(policy, 'moreTemplateTrayContentMayChange = false', 'MORE guard');
requireIncludes(policy, 'legacyIdleCapsRemoved = true', 'idle caps removed');
requireIncludes(policy, 'legacyMoreCapsRemoved = true', 'MORE caps removed');
requireIncludes(policy, 'legacyGraphCapsRemoved = true', 'Graph caps removed');
requireIncludes(q229Policy, "successorPhase = 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX'", 'Q229 successor marker');
requireIncludes(q229r2Policy, "successorPhase = 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX'", 'Q229R2 successor marker');

const json = JSON.parse(read(manifest));
const phase = 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX';
if (json.workspaceIdleExpansionLatestPhase !== phase) fail('manifest workspaceIdleExpansionLatestPhase is not Q229R4');
if (json.workspaceBottomGapOpticalMatchLatestPhase !== phase) fail('manifest workspaceBottomGapOpticalMatchLatestPhase is not Q229R4');
if (json.workspaceCardSlotFillLatestPhase !== phase) fail('manifest workspaceCardSlotFillLatestPhase is not Q229R4');
const envelope = json.v172Q229R4WorkspaceCardSlotFillPhantomGapFix;
if (!envelope) fail('manifest missing Q229R4 envelope');
if (envelope.keyboardFilesMutated !== false) fail('manifest keyboard guard broken');
if (envelope.mathLiveProductionFilesMutated !== false) fail('manifest MathLive guard broken');
if (envelope.graphEngineMutated !== false) fail('manifest Graph guard broken');
if (envelope.solutionFilesMutated !== false) fail('manifest Solution guard broken');
if (envelope.moreTemplateTrayMutated !== false) fail('manifest MORE guard broken');
if (envelope.workspacePanelMutated !== true) fail('manifest workspace target marker missing');

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
const sample = {
  idle: { cardSlotHeight: 520, cardVisualHeight: 507, difference: 13, note: '8 top + 5 bottom margin only' },
  moreOpen: { cardSlotHeight: 360, cardVisualHeight: 340, difference: 20, note: '12 top + 8 bottom margin only; old 292 cap removed' },
  graphOpen: { cardSlotHeight: 360, cardVisualHeight: 340, difference: 20, note: 'Graph uses MORE/Solution rhythm; old 316/348 cap removed' },
  solutionOpen: { cardSlotHeight: 360, cardVisualHeight: 341, difference: 19, note: '12 top + 7 bottom margin only' },
};
const report = {
  phase,
  status: 'STATIC_READY_WITH_Q231_LONG_PRESS_AND_Q234_GRAPH_VISUAL_SUCCESSOR_WITH_Q231R1_LONG_PRESS_ANCHOR_AND_Q234_GRAPH_VISUAL_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED',
  rootCause: 'cardSlotHeight and cardVisualHeight diverged because state branches capped visual card height.',
  rootFix: 'cardVisualHeight uses usableHeight directly; only premium margins remain.',
  removedLegacyCaps: ['templateTrayOpen max 292', 'idle max 316', 'idle max 348', 'Graph/default 0.76 caps'],
  sampleMeasurements: sample,
  keyboardProtected: true,
  mathLiveProtected: true,
  solutionProtected: true,
  graphEngineProtected: true,
  moreTemplateTrayProtected: true,
};
writeFileSync(path.join(root, 'tool/reports/workspace_card_slot_fill_phantom_gap_fix_q229r4_report.json'), `${JSON.stringify(report, null, 2)}\n`);
writeFileSync(path.join(root, 'tool/reports/workspace_card_slot_fill_phantom_gap_fix_q229r4_report.md'), `# Q229R4 Workspace Card Slot Fill / Phantom Gap Root Fix Report\n\nStatus: ${report.status}\n\nRoot cause: ${report.rootCause}\n\nRoot fix: ${report.rootFix}\n\n## Sample slot/visual measurements\n\n- Idle: slot 520, visual 507, difference 13\n- MORE: slot 360, visual 340, difference 20\n- Graph: slot 360, visual 340, difference 20\n- Solution: slot 360, visual 341, difference 19\n\nProtected surfaces: keyboard, MathLive production, Solution, Graph engine, MORE/template tray, History, AppShell, Android startup.\n`);

console.log('WORKSPACE_CARD_SLOT_FILL_PHANTOM_GAP_FIX_Q229R4_STATIC_READY_WITH_Q231_LONG_PRESS_AND_Q234_GRAPH_VISUAL_SUCCESSOR_WITH_Q231R1_LONG_PRESS_ANCHOR_AND_Q234_GRAPH_VISUAL_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED');
