import { createHash } from 'node:crypto';
import { existsSync, readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => readFileSync(path.join(root, rel), 'utf8');
const sha256 = (rel) => createHash('sha256').update(readFileSync(path.join(root, rel))).digest('hex');
const fail = (message) => {
  console.error(`LONG_PRESS_PLUS99_FLOATING_SEGMENT_MENU_Q231_FAIL: ${message}`);
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

const popup = 'lib/features/keyboard/long_press_popup.dart';
const policy = 'lib/features/keyboard/premium_popup_fit_policy.dart';
const q231Policy = 'lib/features/keyboard/long_press_plus99_floating_segment_menu_policy.dart';
const q231r1Policy = 'lib/features/keyboard/long_press_plus99_anchor_hardening_policy.dart';
const manifest = 'assets/mathlive/manifest.json';
const test = 'test/v172_q231_long_press_plus99_floating_segment_menu_test.dart';
for (const rel of [popup, policy, q231Policy, q231r1Policy, manifest, test]) {
  if (!existsSync(path.join(root, rel))) fail(`missing required file ${rel}`);
}

requireIncludes(policy, "plus99FloatingSegmentMenuPhase = 'V172-Q231'", 'Q231 policy phase');
requireIncludes(policy, 'longPressPanelMinHeight = 60.0', 'compact panel min height');
requireIncludes(policy, 'longPressPanelMaxHeight = 64.0', 'compact panel max height');
requireIncludes(policy, 'longPressChipHeight = 48.0', 'compact chip height');
requireIncludes(policy, 'longPressChipGap = 2.0', 'segment divider gap');
requireIncludes(policy, 'longPressBoundedIntegralChipWidth = 98.0', 'bounded integral no-clip width');
requireIncludes(q231Policy, "phase = 'V172-Q231'", 'Q231 standalone policy');
requireIncludes(q231Policy, 'keyboardLayoutMutationAllowed = false', 'keyboard guard');
requireIncludes(q231Policy, 'longPressOptionMutationAllowed = false', 'option inventory guard');
requireIncludes(q231Policy, 'longPressOrderMutationAllowed = false', 'option order guard');
requireIncludes(q231Policy, 'singleCapsuleSurface = true', 'single capsule marker');
requireIncludes(q231Policy, 'edgeSafePlacement = true', 'edge-safe marker');
requireIncludes(q231r1Policy, "phase = 'V172-Q231R1'", 'Q231R1 successor policy');
requireIncludes(q231r1Policy, 'actualKeyGeometryRequired = true', 'actual key geometry successor marker');

requireIncludes(popup, 'mathpro-long-press-plus99-floating-segment-menu', 'plus99 surface key');
requireIncludes(popup, 'TweenAnimationBuilder<double>', 'fade/scale animation');
requireIncludes(popup, '_ElitePopupCapsule', 'single capsule surface');
requireIncludes(popup, '_SegmentDivider', 'segmented option divider');
requireIncludes(popup, '_LongPressPointerPainter', 'pointer painter');
requireIncludes(popup, 'final double? anchorCenterX;', 'measured anchor input');
requireIncludes(popup, 'final idealCenter = actualKeyCenterX ?? estimatedCenter;', 'actual key center before fallback');
requireIncludes(popup, '_anchorLabelFor', 'source-key anchor inference fallback');
requireIncludes(popup, '_anchorFractionFor', 'keyboard-grid anchor fraction');
requireIncludes(popup, 'panelLeft = (idealCenter - panelWidth / 2).clamp', 'edge-safe panel placement');
requireIncludes(popup, 'pointerCenter = (idealCenter - panelLeft).clamp', 'pointer clamp');
requireIncludes(popup, 'KeyConfig.getLongPressOptions(entry.key, activeTab)', 'uses existing long-press inventory');
requireIncludes(popup, 'widget.onPressed(widget.label)', 'selection command unchanged');
requireNotIncludes(popup, 'MathProRadius.lg', 'legacy large-card radius');
requireNotIncludes(popup, 'blurRadius: 9,\n                    spreadRadius: -5', 'legacy per-chip card shadow');

const keyConfig = read('lib/features/keyboard/key_config.dart');
if (!keyConfig.includes('static const Map<String, List<String>> longPressMap')) fail('key_config longPressMap missing');
if (!keyConfig.includes("['MORE', '0', '.', 'Ans']")) fail('keyboard core order marker missing');

const json = JSON.parse(read(manifest));
const envelope = json.v172Q231LongPressPlus99FloatingSegmentMenu;
if (![
  'V172-Q231-LONG-PRESS-PLUS99-FLOATING-SEGMENT-MENU',
  'V172-Q231R1-LONG-PRESS-PLUS99-ANCHOR-HARDENING',
  'V172-Q231R2-LONG-PRESS-PLUS99-ANCHOR-FINAL-HYGIENE',
].includes(json.longPressPlus99LatestPhase)) fail('manifest Q231/Q231R1/Q231R2 latest phase missing');
if (!envelope) fail('manifest missing Q231 envelope');
for (const [key, expected] of Object.entries({
  visualRedesignOnly: true,
  singleCapsuleSurface: true,
  segmentedOptions: true,
  edgeSafePlacement: true,
  pointerAnchoredToSourceKey: true,
  keyboardLayoutMutationAllowed: false,
  longPressOptionMutationAllowed: false,
  longPressOrderMutationAllowed: false,
  moreMutationAllowed: false,
  mathLiveMutationAllowed: false,
  workspaceGraphHistorySolutionMutationAllowed: false,
  realDevicePassClaimed: false,
})) {
  if (envelope[key] !== expected) fail(`manifest Q231 envelope ${key} !== ${expected}`);
}

const protectedHashes = {
  'lib/features/keyboard/key_config.dart': '4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2',
  'lib/features/workspace/template_tray.dart': 'b58f05b9f6f8b089a4335554f062e0652929bd9c2f60d3fdbf79d4bc87aca678',
  'assets/mathlive/mathlive_prod_bridge.js': 'fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4',
  'assets/mathlive/main_editor_prod.html': 'f32e884f83f94d3ac2077f2c65d0278edbba163ca30c640605edc75c337dd9cd',
  'lib/features/mathlive/mathlive_production_editor_surface.dart': 'f89f6822b85870608befd20d9602c0310d2e67c300bbc5736612b5a4d90929a9',
  'lib/features/workspace/workspace_panel.dart': 'b2c3c20b8edcec5675e187667142000b7cddea4e49ba21796b4b18e680f18f13',
  'lib/features/graph/graph_surface.dart': '1bd5c0810742213990647cf89e172190971950046e807caa495def771ae54a49',
  'lib/features/graph/graph_settings_sheet.dart': '45e8b0492777533d8b9c8d775f35ff7bbe1b98a6cf399eec53af826b7495320e',
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
  phase: 'V172-Q231-LONG-PRESS-PLUS99-FLOATING-SEGMENT-MENU',
  status: 'STATIC_READY_WITH_Q231R2_ANCHOR_FINAL_HYGIENE_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_LONG_PRESS_SCREENSHOT_QA_REQUIRED',
  changedRuntimeFiles: [popup, policy, q231Policy, q231r1Policy, 'lib/features/keyboard/keyboard_long_press_anchor.dart', 'lib/features/keyboard/premium_key.dart', 'lib/features/keyboard/math_keyboard.dart', 'lib/features/keyboard/bottom_dock.dart'],
  protectedRuntimeFilesUnchanged: Object.keys(protectedHashes),
  visual: {
    singleCapsuleSurface: true,
    segmentedOptions: true,
    pointer: true,
    compactPanelHeight: `${json.v172Q231LongPressPlus99FloatingSegmentMenu ? 64 : 'unknown'}px max`,
  },
  collisionHandling: 'center-anchor + left/right edge clamp + pointer clamp',
  longPressInventoryChanged: false,
  keyboardLayoutChanged: false,
  realDevicePassClaimed: false,
};
writeFileSync(path.join(root, 'tool/reports/long_press_plus99_floating_segment_menu_q231_report.json'), `${JSON.stringify(report, null, 2)}\n`);
writeFileSync(path.join(root, 'tool/reports/long_press_plus99_floating_segment_menu_q231_report.md'), `# Q231 Long-Press +99 Floating Segment Menu Report\n\nStatus: ${report.status}\n\nVisual: single dark-glass capsule, segmented chips, subtle pointer, compact elite envelope.\n\nCollision handling: ${report.collisionHandling}.\n\nLong-press inventory/order changed: false.\nKeyboard layout changed: false.\nReal-device +99 pass claimed: false.\n`);

console.log('LONG_PRESS_PLUS99_FLOATING_SEGMENT_MENU_Q231_STATIC_READY_WITH_Q231R2_ANCHOR_FINAL_HYGIENE_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_LONG_PRESS_SCREENSHOT_QA_REQUIRED');
