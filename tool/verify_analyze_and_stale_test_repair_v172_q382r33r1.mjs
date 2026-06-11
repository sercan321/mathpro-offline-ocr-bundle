#!/usr/bin/env node
import fs from 'fs';

function read(path) {
  return fs.readFileSync(path, 'utf8');
}
function must(path, needle) {
  const text = read(path);
  if (!text.includes(needle)) {
    throw new Error(`${path} missing ${needle}`);
  }
}
function mustNot(path, needle) {
  const text = read(path);
  if (text.includes(needle)) {
    throw new Error(`${path} still contains forbidden ${needle}`);
  }
}

mustNot('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', "String(entry['action'] ?? '')");
must('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart', "(entry['action'] ?? '').toString()");
mustNot('lib/app/app_shell.dart', "import 'package:flutter/foundation.dart';");
must('lib/debug/latency/mathpro_latency_overlay_q382r23.dart', 'const latencyProbeDisabled =');
must('test/v172_q239a_workspace_camera_entry_button_test.dart', "ValueKey('mathpro-q382-expression-context-menu-safe-hit-zone')");
must('lib/features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart', "if (functionTemplateRoots.contains(trimmed) || _looksLikeFunctionTemplate(trimmed))");
must('test/v172_q382r29_key_category_fast_paths_test.dart', 'KeyCategoryFastPathQ382R29.functionTemplate');
must('docs/audit/V172_Q382R33R1_ANALYZE_AND_STALE_TEST_REPAIR.md', 'V172-Q382R33R1');
must('docs/audit/V172_Q382R33R1_CHANGED_FILES.md', 'mathlive_full_keyboard_warmup_q382r33_policy.dart');

console.log('PASS verify_analyze_and_stale_test_repair_v172_q382r33r1');
