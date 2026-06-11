#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const fail = (message) => { console.error(`FAIL verify_key_category_fast_paths_v172_q382r29: ${message}`); process.exit(1); };
const must = (rel, needle) => { if (!read(rel).includes(needle)) fail(`${rel} missing ${needle}`); };
const mustNot = (rel, needle) => { if (read(rel).includes(needle)) fail(`${rel} must not contain ${needle}`); };

const required = [
  'lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart',
  'lib/features/keyboard/keyboard_latency_closure_q382r24_policy.dart',
  'lib/app/app_shell.dart',
  'lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart',
  'test/v172_q382r29_key_category_fast_paths_test.dart',
  'tool/verify_key_category_fast_paths_v172_q382r29.mjs',
  'docs/audit/V172_Q382R29_KEY_CATEGORY_FAST_PATHS.md',
  'docs/audit/V172_Q382R29_CHANGED_FILES.md',
];
for (const rel of required) if (!exists(rel)) fail(`missing required file ${rel}`);

must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', "static const String phase = 'V172-Q382R29'");
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'q382r29-key-category-fast-paths-active');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'enum KeyCategoryFastPathQ382R29');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'linearSafe');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'structureTemplate');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'wrapperTemplate');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'longPressParent');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'longPressChild');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'moreTemplate');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'deleteRepeat');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'clearPriority');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'evaluateAction');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'optimisticEchoScopeExpanded = false');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'panDragScrollReintroduced = false');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', "'□/□'");
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', "'|□|'");
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', "'MORE', '↵', 'C', '⌫'");
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'downstreamSyncDebounceForLabel');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'usesJsSideQueue');

must('lib/features/keyboard/keyboard_latency_closure_q382r24_policy.dart', "import 'keyboard_category_fast_paths_q382r29_policy.dart';");
must('lib/features/keyboard/keyboard_latency_closure_q382r24_policy.dart', 'KeyboardCategoryFastPathsQ382R29Policy.dispatchOnTapDown');
must('lib/features/keyboard/keyboard_latency_closure_q382r24_policy.dart', 'KeyboardCategoryFastPathsQ382R29Policy.deferDownstreamSyncForLabel');
must('lib/features/keyboard/keyboard_latency_closure_q382r24_policy.dart', 'KeyboardCategoryFastPathsQ382R29Policy.downstreamSyncDebounceForLabel');
must('lib/app/app_shell.dart', 'controllerSyncDebounceForLabel(snapshot.lastCommandLabel)');
must('lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart', "import '../../features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart';");
must('lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart', 'KeyboardCategoryFastPathsQ382R29Policy.categoryFor');

for (const rel of [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/logic/action_utils.dart',
  'assets/mathlive/mathlive_prod_bridge.js',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
]) {
  mustNot(rel, 'V172-Q382R29');
}
for (const rel of ['assets/mathlive/mathlive_prod_bridge.js', 'lib/features/mathlive/mathlive_production_editor_surface.dart']) {
  mustNot(rel, 'document.addEventListener(\'touchmove\'');
  mustNot(rel, 'direct-pan');
  mustNot(rel, 'host-scrollport-force');
  mustNot(rel, 'document-capture');
}

console.log('PASS verify_key_category_fast_paths_v172_q382r29');
