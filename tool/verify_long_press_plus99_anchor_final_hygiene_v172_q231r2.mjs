#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const exists = (rel) => fs.existsSync(p(rel));
const errors = [];
const fail = (message) => errors.push(message);

for (const file of [
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/keyboard_long_press_anchor.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'tool/verify_solution_steps_single_surface_cleanup_v172_q227.mjs',
  'assets/mathlive/manifest.json',
  'README.md',
]) {
  if (!exists(file)) fail(`missing required Q231R2 file: ${file}`);
}

const bottomDock = read('lib/features/keyboard/bottom_dock.dart');
const popup = read('lib/features/keyboard/long_press_popup.dart');
const premiumKey = read('lib/features/keyboard/premium_key.dart');
const q227Verifier = read('tool/verify_solution_steps_single_surface_cleanup_v172_q227.mjs');
const manifest = read('assets/mathlive/manifest.json');
const readme = read('README.md');
const graphCard = read('lib/features/graph/graph_card.dart');
const keyConfig = read('lib/features/keyboard/key_config.dart');

const zeroRectIndex = bottomDock.indexOf('if (anchor.globalRect == Rect.zero) return null;');
const globalToLocalIndex = bottomDock.indexOf('renderObject.globalToLocal(anchor.globalCenter).dx');
if (!(zeroRectIndex >= 0 && globalToLocalIndex > zeroRectIndex)) {
  fail('BottomDock must return null for Rect.zero anchors before converting global center to local coordinates');
}

for (const marker of [
  'globalRect: Rect.zero',
  'localToGlobal(Offset(size.width / 2, size.height / 2))',
  'globalRect',
]) {
  if (!premiumKey.includes(marker) && marker !== 'globalRect') fail(`PremiumKey missing measured/fallback anchor marker: ${marker}`);
}

for (const marker of [
  'final idealCenter = actualKeyCenterX ?? estimatedCenter;',
  'pointerCenter = (idealCenter - panelLeft).clamp',
  'onTap: onDismissed',
  '_PremiumSegmentScrollFrame',
  'ShaderMask',
]) {
  if (!popup.includes(marker)) fail(`LongPressPopup missing hardened popup marker: ${marker}`);
}

for (const marker of [
  'Q231R2_LONG_PRESS_ANCHOR_FINAL_HYGIENE_SUCCESSOR',
  'q231r2LongPressAnchorFinalHygieneSuccessor: true',
  "'lib/features/keyboard/bottom_dock.dart': 'a6e8c25369faa0cac016314c42a93be76ac5ca21c0b16c4152b279a339f9c354'",
  "'lib/features/keyboard/math_keyboard.dart': 'fc8e6504448bbdd64bdbb674fd000c04511ab185a8a110eecb7102dce19d116c'",
  "'lib/features/keyboard/long_press_popup.dart': '4bb7e11846efd80d831cc3178b72f57207e458dd7e72bb27f1615d7218769369'",
]) {
  if (!q227Verifier.includes(marker)) fail(`Q227 verifier successor hygiene missing marker: ${marker}`);
}

for (const marker of [
  'V172-Q231R2-LONG-PRESS-PLUS99-ANCHOR-FINAL-HYGIENE',
  'v172Q231R2LongPressPlus99AnchorFinalHygiene',
  'zeroRectAnchorReturnsNull',
  'q227VerifierSuccessorHygieneUpdated',
]) {
  if (!manifest.includes(marker)) fail(`manifest missing Q231R2 metadata marker: ${marker}`);
}

for (const marker of [
  'V172-Q231R2 — Long-Press +99 Anchor Final Hygiene',
  '_localAnchorCenterXFor',
  'Rect.zero',
  'estimated anchor path',
]) {
  if (!readme.includes(marker)) fail(`README missing Q231R2 metadata marker: ${marker}`);
}

if (graphCard.includes("import 'graph_painter.dart';")) fail('graph_card.dart must not directly import graph_painter.dart');
if (!graphCard.includes("import 'graph_curve_painter.dart';")) fail('graph_card.dart must keep graph_curve_painter export import for GraphExpressionEvaluator');

for (const marker of [
  "'Σ': ['Σ', 'Π', 'Taylor', 'Maclaurin'",
  "'y': ['y', 'y₁', 'y₂', 'y_□'",
  "'=': ['=', '≠', '<', '>', '≤', '≥', '≈', '≡']",
]) {
  if (!keyConfig.includes(marker)) fail(`long-press inventory/order marker drifted: ${marker}`);
}

const protectedHashes = {
  'lib/features/keyboard/key_config.dart': '4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2',
  'lib/features/workspace/template_tray.dart': 'b58f05b9f6f8b089a4335554f062e0652929bd9c2f60d3fdbf79d4bc87aca678',
  'assets/mathlive/main_editor_prod.html': 'f32e884f83f94d3ac2077f2c65d0278edbba163ca30c640605edc75c337dd9cd',
  'assets/mathlive/mathlive_prod_bridge.js': 'fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4',
  'lib/features/mathlive/mathlive_production_editor_surface.dart': 'f89f6822b85870608befd20d9602c0310d2e67c300bbc5736612b5a4d90929a9',
  'lib/features/workspace/workspace_panel.dart': 'b2c3c20b8edcec5675e187667142000b7cddea4e49ba21796b4b18e680f18f13',
  'lib/features/solution/solution_steps_panel.dart': '558c0f232dd4bb81bbf92ffa7687ff8d77fb450daf95f5e04a98f277f1625f2b',
  'lib/features/solution/solution_step_models.dart': 'faab66d941f841911989bee8fae44d0d1edc546fabb6f65fd7dab777405cc248',
  'lib/features/history/history_panel.dart': 'fad987605894ffafc0069fa80f560908c6f529a05da81d2165e924524728537b',
  'lib/app/app_shell.dart': 'ac80aef66dde3b4c4a7bc863f4a4b36b0be735ea3a865ceaa90a854afacbd637',
  'lib/main.dart': '068648069a69ec196c566cc0e27feb6dcb496059f9cd606367c6cc646b602689',
};

for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) {
    fail(`protected file missing: ${file}`);
    continue;
  }
  const actual = crypto.createHash('sha256').update(fs.readFileSync(p(file))).digest('hex');
  if (actual !== expected) fail(`protected file hash drift for ${file}: ${actual} expected ${expected}`);
}

const report = {
  phase: 'V172-Q231R2-LONG-PRESS-PLUS99-ANCHOR-FINAL-HYGIENE',
  status: errors.length === 0
    ? 'LONG_PRESS_PLUS99_ANCHOR_FINAL_HYGIENE_Q231R2_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_LONG_PRESS_SCREENSHOT_QA_REQUIRED'
    : 'LONG_PRESS_PLUS99_ANCHOR_FINAL_HYGIENE_Q231R2_BLOCKED',
  zeroRectAnchorReturnsNull: bottomDock.includes('if (anchor.globalRect == Rect.zero) return null;'),
  q227VerifierSuccessorHygieneUpdated: q227Verifier.includes('Q231R2_LONG_PRESS_ANCHOR_FINAL_HYGIENE_SUCCESSOR'),
  readmeManifestMetadataUpdated: manifest.includes('v172Q231R2LongPressPlus99AnchorFinalHygiene') && readme.includes('V172-Q231R2'),
  graphPainterDirectImportRemoved: !graphCard.includes("import 'graph_painter.dart';"),
  longPressInventoryChanged: false,
  keyboardLayoutChanged: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidPlus99PassClaimedByAssistant: false,
  errors,
};

fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/long_press_plus99_anchor_final_hygiene_q231r2_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(p('tool/reports/long_press_plus99_anchor_final_hygiene_q231r2_report.md'), `# V172-Q231R2 Long-Press +99 Anchor Final Hygiene\n\nStatus: ${report.status}\n\nZero-rect anchor returns null: ${report.zeroRectAnchorReturnsNull}\n\nQ227 verifier successor hygiene updated: ${report.q227VerifierSuccessorHygieneUpdated}\n\nREADME/manifest metadata updated: ${report.readmeManifestMetadataUpdated}\n\nDirect graph_painter import removed from graph_card: ${report.graphPainterDirectImportRemoved}\n\nFlutter/Android/+99 PASS claimed: false\n\n## Errors\n${errors.map((e) => `- ${e}`).join('\n') || '- none'}\n`);

if (errors.length) {
  console.error(errors.join('\n'));
  process.exit(1);
}
console.log(report.status);
