#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q382R3_VERIFY_FAIL: ${msg}`); process.exit(1); };
const assert = (cond, msg) => { if (!cond) fail(msg); };

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert(manifest.workspaceExpressionContextMenuSolutionIntentInjectionRepairLatestPhase === 'V172-Q382R3-WORKSPACE-CONTEXT-MENU-SOLUTION-INTENT-INJECTION-REPAIR', 'manifest Q382R3 latest phase missing');
assert(manifest.v172Q382R3WorkspaceContextMenuSolutionIntentInjectionRepair?.selectedActionIntentStepInjectedExactlyOnce === true, 'manifest exact-once intent injection guard missing');
assert(manifest.v172Q382R3WorkspaceContextMenuSolutionIntentInjectionRepair?.solutionStepObjectIdentityContainsNotUsedForIntentInjection === true, 'manifest object-identity contains guard missing');
assert(manifest.v172Q382R3WorkspaceContextMenuSolutionIntentInjectionRepair?.fakeSolverResultsBlocked === true, 'manifest no-fake solver guard missing');

const policy = read('lib/features/workspace/workspace_expression_context_menu_q382_policy.dart');
assert(policy.includes("solutionIntentInjectionRepairPhase = 'V172-Q382R3-WORKSPACE-CONTEXT-MENU-SOLUTION-INTENT-INJECTION-REPAIR'"), 'policy Q382R3 phase marker missing');
assert(policy.includes('selectedActionIntentStepInjectedExactlyOnce = true'), 'policy exact-once marker missing');
assert(policy.includes('selectedActionIntentInjectionAvoidsObjectIdentityContains = true'), 'policy object-identity guard marker missing');

const solution = read('lib/features/solution/solution_step_models.dart');
assert(solution.includes('V172-Q382R3: intent-step injection must be deterministic'), 'solution Q382R3 repair comment missing');
assert(solution.includes('var intentStepInjected = false;'), 'solution explicit injection flag missing');
assert(solution.includes('if (!intentStepInjected && step.index > 1)'), 'solution single-shot insertion branch missing');
assert(solution.includes('intentStepInjected = true;'), 'solution injection flag not set');
assert(!solution.includes('!injected.contains(intentStep)'), 'solution still uses object-identity contains guard for intent step');
assert(solution.includes('handler kanıtlanmadığı için mevcut sonuç değiştirilmedi'), 'unsupported handler no-fake description not preserved');

const test = read('test/v172_q382_workspace_expression_context_menu_test.dart');
assert(test.includes('solutionIntentInjectionRepairPhase'), 'test does not cover Q382R3 phase');
assert(test.includes('selectedActionIntentStepInjectedExactlyOnce'), 'test does not cover exact-once policy marker');
assert(test.includes("snapshot.steps.where((step) => step.title == 'İşlem niyeti'), hasLength(1)"), 'test does not assert exactly one intent step');

for (const protectedFile of [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'assets/mathlive/mathlive_bridge.js',
  'assets/mathlive/main_editor.html',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
  'android/app/build.gradle',
  'pubspec.yaml',
]) {
  assert(exists(protectedFile), `${protectedFile} missing`);
}

console.log('Q382R3_VERIFY_PASS workspace context menu solution intent injection repair verified.');
