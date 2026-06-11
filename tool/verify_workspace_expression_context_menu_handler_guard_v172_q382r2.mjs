#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q382R2_VERIFY_FAIL: ${msg}`); process.exit(1); };
const assert = (cond, msg) => { if (!cond) fail(msg); };

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert(manifest.workspaceExpressionContextMenuHandlerGuardRepairLatestPhase === 'V172-Q382R2-WORKSPACE-CONTEXT-MENU-HANDLER-GUARD-REPAIR', 'manifest Q382R2 latest phase missing');
assert(manifest.v172Q382R2WorkspaceContextMenuHandlerGuardRepair?.unsupportedActionHandlerGuarded === true, 'handler guard manifest missing');
assert(manifest.v172Q382R2WorkspaceContextMenuHandlerGuardRepair?.solutionMetadataCarriesHandlerSupport === true, 'solution handler support metadata manifest missing');
assert(manifest.v172Q382R2WorkspaceContextMenuHandlerGuardRepair?.unsupportedActionDoesNotReuseGenericResultAsHandlerOutput === true, 'unsupported generic result guard manifest missing');

const policy = read('lib/features/workspace/workspace_expression_context_menu_q382_policy.dart');
assert(policy.includes("handlerGuardRepairPhase = 'V172-Q382R2-WORKSPACE-CONTEXT-MENU-HANDLER-GUARD-REPAIR'"), 'policy Q382R2 marker missing');
assert(policy.includes('unsupportedActionHandlerGuarded = true'), 'policy unsupported handler guard missing');
assert(policy.includes('unsupportedActionDoesNotReuseGenericResultAsHandlerOutput = true'), 'policy generic result guard missing');

const menu = read('lib/features/workspace/workspace_expression_context_menu.dart');
assert(menu.includes("handlerGuardRepairPhase = 'V172-Q382R2-WORKSPACE-CONTEXT-MENU-HANDLER-GUARD-REPAIR'"), 'menu Q382R2 marker missing');
assert(menu.includes('unsupportedActionHandlerGuarded = true'), 'menu unsupported handler guard marker missing');

const state = read('lib/features/workspace/workspace_math_action_state.dart');
assert(state.includes('final bool requiresSolverHandler;'), 'selected state requiresSolverHandler missing');
assert(state.includes('final bool supportedByCurrentEngine;'), 'selected state supportedByCurrentEngine missing');
assert(state.includes('bool get hasUnsupportedSolverHandler => requiresSolverHandler && !supportedByCurrentEngine;'), 'selected unsupported handler guard getter missing');
assert(state.includes('requiresSolverHandler: action.requiresSolverHandler'), 'selected state does not capture action requiresSolverHandler');
assert(state.includes('supportedByCurrentEngine: action.supportedByCurrentEngine'), 'selected state does not capture action supportedByCurrentEngine');

const appShell = read('lib/app/app_shell.dart');
assert(appShell.includes('selectedActionRequiresSolverHandler: selectedActionForSnapshot?.requiresSolverHandler'), 'app shell does not route requiresSolverHandler to solution snapshot');
assert(appShell.includes('selectedActionSupportedByCurrentEngine: selectedActionForSnapshot?.supportedByCurrentEngine'), 'app shell does not route supportedByCurrentEngine to solution snapshot');
assert(appShell.includes('selectedAction?.hasUnsupportedSolverHandler == true'), 'solution open unsupported handler guard missing');
assert(appShell.includes('Bu işlem henüz desteklenmiyor; sahte sonuç gösterilmiyor.'), 'unsupported action user message missing');

const solution = read('lib/features/solution/solution_step_models.dart');
assert(solution.includes('final bool? selectedActionRequiresSolverHandler;'), 'solution snapshot requiresSolverHandler metadata missing');
assert(solution.includes('final bool? selectedActionSupportedByCurrentEngine;'), 'solution snapshot supportedByCurrentEngine metadata missing');
assert(solution.includes('handler kanıtlanmadığı için mevcut sonuç değiştirilmedi'), 'solution unsupported handler no-fake description missing');
assert(solution.includes('selectedActionRequiresSolverHandler == true && selectedActionSupportedByCurrentEngine != true'), 'solution unsupported handler branch missing');

const test = read('test/v172_q382_workspace_expression_context_menu_test.dart');
assert(test.includes('handlerGuardRepairPhase'), 'Q382 test does not cover handler guard phase');
assert(test.includes('hasUnsupportedSolverHandler'), 'Q382 test does not cover selected unsupported handler state');
assert(test.includes('handler kanıtlanmadığı için mevcut sonuç değiştirilmedi'), 'Q382 test does not cover unsupported handler solution guard');

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

console.log('Q382R2_VERIFY_PASS workspace context menu handler guard repair verified.');
