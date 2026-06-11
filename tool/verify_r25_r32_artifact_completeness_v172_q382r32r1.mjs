#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const exists = (rel) => fs.existsSync(path.join(root, rel));
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const fail = (msg) => { console.error(`FAIL verify_r25_r32_artifact_completeness_v172_q382r32r1: ${msg}`); process.exit(1); };
const mustExist = (rel) => { if (!exists(rel)) fail(`missing ${rel}`); };
const mustContain = (rel, needle) => { if (!read(rel).includes(needle)) fail(`${rel} missing ${needle}`); };

const artifacts = [
  {
    phase: 'Q382R25',
    test: 'test/v172_q382r25_all_key_latency_court_test.dart',
    docs: [
      'docs/audit/V172_Q382R25_ALL_KEY_LATENCY_COURT_AND_INVENTORY.md',
      'docs/audit/V172_Q382R25_CHANGED_FILES.md',
    ],
    verifier: 'tool/verify_all_key_latency_court_v172_q382r25.mjs',
  },
  {
    phase: 'Q382R26',
    test: 'test/v172_q382r26_caret_context_bridge_test.dart',
    docs: [
      'docs/audit/V172_Q382R26_CARET_CONTEXT_BRIDGE.md',
      'docs/audit/V172_Q382R26_CHANGED_FILES.md',
    ],
    verifier: 'tool/verify_caret_context_bridge_v172_q382r26.mjs',
  },
  {
    phase: 'Q382R27',
    test: 'test/v172_q382r27_safe_optimistic_linear_echo_test.dart',
    docs: [
      'docs/audit/V172_Q382R27_SAFE_OPTIMISTIC_LINEAR_ECHO.md',
      'docs/audit/V172_Q382R27_CHANGED_FILES.md',
    ],
    verifier: 'tool/verify_safe_optimistic_linear_echo_v172_q382r27.mjs',
  },
  {
    phase: 'Q382R28',
    test: 'test/v172_q382r28_js_side_command_queue_test.dart',
    docs: [
      'docs/audit/V172_Q382R28_JS_SIDE_COMMAND_QUEUE.md',
      'docs/audit/V172_Q382R28_CHANGED_FILES.md',
    ],
    verifier: 'tool/verify_js_side_command_queue_v172_q382r28.mjs',
  },
  {
    phase: 'Q382R29',
    test: 'test/v172_q382r29_key_category_fast_paths_test.dart',
    docs: [
      'docs/audit/V172_Q382R29_KEY_CATEGORY_FAST_PATHS.md',
      'docs/audit/V172_Q382R29_CHANGED_FILES.md',
    ],
    verifier: 'tool/verify_key_category_fast_paths_v172_q382r29.mjs',
  },
  {
    phase: 'Q382R30',
    test: 'test/v172_q382r30_workspace_frame_isolation_test.dart',
    docs: [
      'docs/audit/V172_Q382R30_WORKSPACE_FRAME_ISOLATION.md',
      'docs/audit/V172_Q382R30_CHANGED_FILES.md',
    ],
    verifier: 'tool/verify_workspace_frame_isolation_v172_q382r30.mjs',
  },
  {
    phase: 'Q382R31',
    test: 'test/v172_q382r31_result_solution_idle_pipeline_test.dart',
    docs: [
      'docs/audit/V172_Q382R31_RESULT_SOLUTION_IDLE_PIPELINE.md',
      'docs/audit/V172_Q382R31_CHANGED_FILES.md',
    ],
    verifier: 'tool/verify_result_solution_idle_pipeline_v172_q382r31.mjs',
  },
  {
    phase: 'Q382R32',
    test: 'test/v172_q382r32_all_key_latency_closure_template_fast_paths_test.dart',
    docs: [
      'docs/audit/V172_Q382R32_ALL_KEY_LATENCY_CLOSURE_AND_TEMPLATE_FAST_PATHS.md',
      'docs/audit/V172_Q382R32_CHANGED_FILES.md',
    ],
    verifier: 'tool/verify_all_key_latency_closure_template_fast_paths_v172_q382r32.mjs',
  },
];

for (const item of artifacts) {
  mustExist(item.test);
  mustContain(item.test, `V172-${item.phase}`);
  for (const doc of item.docs) {
    mustExist(doc);
    mustContain(doc, item.phase);
  }
  mustExist(item.verifier);
}

for (const rel of [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/logic/action_utils.dart',
  'assets/mathlive/mathlive_prod_bridge.js',
  'lib/app/app_shell.dart',
]) {
  const text = read(rel);
  if (text.includes('Q382R32R1') || text.includes('r25-r32-artifact-completeness-runtime-change')) {
    fail(`runtime file mutated by artifact-only repair: ${rel}`);
  }
}

console.log('PASS verify_r25_r32_artifact_completeness_v172_q382r32r1');
