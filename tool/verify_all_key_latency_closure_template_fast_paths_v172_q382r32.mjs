#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const fail = (message) => { console.error(`FAIL verify_all_key_latency_closure_template_fast_paths_v172_q382r32: ${message}`); process.exit(1); };
const must = (rel, needle) => { if (!read(rel).includes(needle)) fail(`${rel} missing ${needle}`); };
const mustNot = (rel, needle) => { if (read(rel).includes(needle)) fail(`${rel} must not contain ${needle}`); };

const required = [
  'lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart',
  'lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart',
  'lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart',
  'lib/debug/latency/mathpro_all_key_latency_court_q382r25_policy.dart',
  'assets/mathlive/mathlive_prod_bridge.js',
  'test/v172_q382r32_all_key_latency_closure_template_fast_paths_test.dart',
  'tool/verify_all_key_latency_closure_template_fast_paths_v172_q382r32.mjs',
  'docs/audit/V172_Q382R32_ALL_KEY_LATENCY_CLOSURE_AND_TEMPLATE_FAST_PATHS.md',
  'docs/audit/V172_Q382R32_CHANGED_FILES.md',
];
for (const rel of required) if (!exists(rel)) fail(`missing required file ${rel}`);

must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', "static const String phase = 'V172-Q382R32'");
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', 'q382r32-all-key-latency-closure-template-fast-paths-active');
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', 'coversMoreTemplates = true');
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', 'coversLongPressChildren = true');
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', 'coversStructureTemplates = true');
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', 'coversFunctionTemplates = true');
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', 'coversDeleteCadence = true');
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', 'preservesClearPriorityPath = true');
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', 'optimisticEchoScopeExpanded = false');
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', 'templateOptimisticEchoAllowed = false');
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', 'moreLongPressOptimisticEchoAllowed = false');
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', 'templatePayloadCacheLimit = 96');
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', "'□/□'");
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', "'√□'");
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', "'sin'");
must('lib/features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart', "'∫□dx'");

must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', "import 'all_key_latency_closure_template_fast_paths_q382r32_policy.dart';");
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'q382r32AllKeyLatencyClosureActive = true');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'templateMoreLongPressFastPathsCovered = true');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.templateDownstreamSyncDebounce');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', 'AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.moreTemplateDownstreamSyncDebounce');
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', '!AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.isProtectedTemplateLabel(label)');

must('lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart', "import '../../features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart';");
must('lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart', 'q382r32TemplateFastPathCandidate');
must('lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart', 'q382r32OptimisticEchoProtected');
must('lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart', '[Q382R32_CLOSURE] ALL_KEY_TEMPLATE_MORE_LONGPRESS');
must('lib/debug/latency/mathpro_all_key_latency_court_q382r25_policy.dart', 'q382r32AllKeyLatencyClosureSummaryEnabled = true');
must('lib/debug/latency/mathpro_all_key_latency_court_q382r25_policy.dart', 'q382r32TemplateMoreLongPressCoverageExpected = true');

must('assets/mathlive/mathlive_prod_bridge.js', "const ALL_KEY_LATENCY_CLOSURE_PHASE = 'V172-Q382R32'");
must('assets/mathlive/mathlive_prod_bridge.js', 'const Q382R32_TEMPLATE_PAYLOAD_CACHE_LIMIT = 96');
must('assets/mathlive/mathlive_prod_bridge.js', 'const q382r32TemplatePayloadCache = new Map()');
must('assets/mathlive/mathlive_prod_bridge.js', 'function q382r32CachedDocumentLatex(input)');
must('assets/mathlive/mathlive_prod_bridge.js', 'q382r32-template-payload-cache-hit');
must('assets/mathlive/mathlive_prod_bridge.js', 'q382r32-template-payload-cache-miss-store');
must('assets/mathlive/mathlive_prod_bridge.js', 'const latex = q382r32CachedDocumentLatex(sourceLatex);');
must('assets/mathlive/mathlive_prod_bridge.js', 'function enqueueKeyboardCommand(payload)');
must('assets/mathlive/mathlive_prod_bridge.js', 'q382r28-js-side-command-processing-sequence-safe');
must('assets/mathlive/mathlive_prod_bridge.js', "else if (action === 'deleteBackward') deleteBackward(payload);");

for (const rel of [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/logic/action_utils.dart',
  'android/app/src/main/kotlin/com/mathpro/phase17/MainActivity.kt',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
  'android/app/build.gradle',
  'android/settings.gradle',
]) {
  if (exists(rel)) {
    mustNot(rel, 'V172-Q382R32');
    mustNot(rel, 'q382r32-all-key-latency-closure-template-fast-paths-active');
  }
}

for (const rel of ['assets/mathlive/mathlive_prod_bridge.js', 'lib/features/mathlive/mathlive_production_editor_surface.dart']) {
  mustNot(rel, 'document.addEventListener(\'touchmove\'');
  mustNot(rel, 'direct-pan');
  mustNot(rel, 'host-scrollport-force');
  mustNot(rel, 'document-capture');
  mustNot(rel, 'templateOptimisticEchoAllowed = true');
}

console.log('PASS verify_all_key_latency_closure_template_fast_paths_v172_q382r32');
