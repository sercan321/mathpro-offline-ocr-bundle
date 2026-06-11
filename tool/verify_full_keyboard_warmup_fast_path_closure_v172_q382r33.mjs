#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const fail = (message) => { console.error(`FAIL verify_full_keyboard_warmup_fast_path_closure_v172_q382r33: ${message}`); process.exit(1); };
const must = (rel, needle) => { if (!read(rel).includes(needle)) fail(`${rel} missing ${needle}`); };
const mustNot = (rel, needle) => { if (read(rel).includes(needle)) fail(`${rel} must not contain ${needle}`); };

const required = [
  'lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'lib/features/mathlive/mathlive_production_editor_surface.dart',
  'assets/mathlive/mathlive_prod_bridge.js',
  'lib/features/workspace/template_tray.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'test/v172_q382r33_full_keyboard_warmup_fast_path_closure_test.dart',
  'tool/verify_full_keyboard_warmup_fast_path_closure_v172_q382r33.mjs',
  'docs/audit/V172_Q382R33_FULL_KEYBOARD_WARMUP_FAST_PATH_CLOSURE.md',
  'docs/audit/V172_Q382R33_CHANGED_FILES.md',
];
for (const rel of required) if (!exists(rel)) fail(`missing required file ${rel}`);

must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', "static const String phase = 'V172-Q382R33'");
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'q382r33-full-keyboard-warmup-fast-path-closure-active');
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'webViewOnPageFinishedWarmupEnabled = true');
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'warmupDoesNotInsertIntoVisibleMathField = true');
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'optimisticEchoScopeExpanded = false');
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'keyboardLayoutOrderLabelsUntouched = true');
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'longPressListsUntouched = true');
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'moreInventoryUntouched = true');
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'fullKeyInventory');
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'KeyConfig.buildKeyboardSections');
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'KeyConfig.longPressMap');
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'ActionUtils.morePanelCategories');
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', 'MathLiveKeyboardBridgePolicy.commandForMainEditorLabel');

must('lib/features/mathlive/mathlive_main_editor_surface.dart', "import 'mathlive_full_keyboard_warmup_q382r33_policy.dart';");
must('lib/features/mathlive/mathlive_production_editor_surface.dart', 'await _warmupProductionMathLiveQ382R33();');
must('lib/features/mathlive/mathlive_production_editor_surface.dart', 'Future<void> _warmupProductionMathLiveQ382R33()');
must('lib/features/mathlive/mathlive_production_editor_surface.dart', 'MathLiveFullKeyboardWarmupQ382R33Policy.fullKeyInventory');
must('lib/features/mathlive/mathlive_production_editor_surface.dart', 'window.MathProProductionMathLiveBridge.mathproWarmupAllKeys');
mustNot('lib/features/mathlive/mathlive_production_editor_surface.dart', "final scheme = Uri.tryParse(request.url)?.scheme.toLowerCase() ?? '';\n            final scheme");

must('assets/mathlive/mathlive_prod_bridge.js', "const FULL_KEYBOARD_WARMUP_PHASE = 'V172-Q382R33'");
must('assets/mathlive/mathlive_prod_bridge.js', 'const Q382R33_FULL_KEYBOARD_WARMUP_LIMIT = 256');
must('assets/mathlive/mathlive_prod_bridge.js', 'function q382r33WarmupAllKeys(input)');
must('assets/mathlive/mathlive_prod_bridge.js', 'q382r33-full-keyboard-warmup-complete');
must('assets/mathlive/mathlive_prod_bridge.js', 'q382r32CachedDocumentLatex(latex);');
must('assets/mathlive/mathlive_prod_bridge.js', 'mathproWarmupAllKeys: q382r33WarmupAllKeys');
mustNot('assets/mathlive/mathlive_prod_bridge.js', "beginBridgeCommand('insertLatex', payload);\n    beginBridgeCommand('insertLatex', payload);");

must('lib/features/workspace/template_tray.dart', '_q382r33MoreChipWarmupCache');
must('lib/features/workspace/template_tray.dart', 'AutomaticKeepAliveClientMixin<TemplateTray>');
must('lib/features/keyboard/long_press_popup.dart', 'warmupLongPressPopupLayoutCacheQ382R33');
must('lib/features/keyboard/long_press_popup.dart', '_q382r33LongPressPanelWidthCache');
must('lib/features/keyboard/bottom_dock.dart', 'MathLiveFullKeyboardWarmupQ382R33Policy.longPressOptionGroups()');

for (const rel of [
  'lib/features/keyboard/key_config.dart',
  'lib/logic/action_utils.dart',
  'android/app/src/main/kotlin/com/mathpro/phase17/MainActivity.kt',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
  'android/app/build.gradle',
  'android/settings.gradle',
]) {
  if (exists(rel)) {
    mustNot(rel, 'V172-Q382R33');
    mustNot(rel, 'q382r33-full-keyboard-warmup-fast-path-closure-active');
  }
}

for (const rel of ['assets/mathlive/mathlive_prod_bridge.js', 'lib/features/mathlive/mathlive_production_editor_surface.dart']) {
  mustNot(rel, 'document.addEventListener(\'touchmove\'');
  mustNot(rel, 'direct-pan');
  mustNot(rel, 'host-scrollport-force');
  mustNot(rel, 'document-capture');
  mustNot(rel, 'templateOptimisticEchoAllowed = true');
}

console.log('PASS verify_full_keyboard_warmup_fast_path_closure_v172_q382r33');
