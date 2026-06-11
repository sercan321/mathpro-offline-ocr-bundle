#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q382R4_VERIFY_FAIL: ${msg}`); process.exit(1); };
const assert = (cond, msg) => { if (!cond) fail(msg); };

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert(manifest.workspaceExpressionContextMenuTestSyntaxRepairLatestPhase === 'V172-Q382R4-WORKSPACE-CONTEXT-MENU-TEST-SYNTAX-REPAIR', 'manifest Q382R4 latest phase missing');
assert(manifest.v172Q382R4WorkspaceContextMenuTestSyntaxRepair?.dartTestClosureSyntaxRepaired === true, 'manifest test closure repair marker missing');
assert(manifest.v172Q382R4WorkspaceContextMenuTestSyntaxRepair?.runtimeFeatureUnchanged === true, 'manifest runtime unchanged marker missing');
assert(manifest.v172Q382R4WorkspaceContextMenuTestSyntaxRepair?.fakeSolverResultsBlocked === true, 'manifest no-fake solver marker missing');
assert(manifest.v172Q382R4WorkspaceContextMenuTestSyntaxRepair?.q381R1OcrSafetyPreserved === true, 'manifest Q381R1 OCR safety marker missing');

const policy = read('lib/features/workspace/workspace_expression_context_menu_q382_policy.dart');
assert(policy.includes("testSyntaxRepairPhase = 'V172-Q382R4-WORKSPACE-CONTEXT-MENU-TEST-SYNTAX-REPAIR'"), 'policy Q382R4 phase marker missing');
assert(policy.includes('contextMenuTestClosureSyntaxRepaired = true'), 'policy test closure repair marker missing');
assert(policy.includes('q382R3VerifierRemainsBackwardCompatible = true'), 'policy Q382R3 backward compatibility marker missing');

const test = read('test/v172_q382_workspace_expression_context_menu_test.dart');
assert(test.includes("testSyntaxRepairPhase, 'V172-Q382R4-WORKSPACE-CONTEXT-MENU-TEST-SYNTAX-REPAIR'"), 'test does not assert Q382R4 phase');
assert(test.includes('contextMenuTestClosureSyntaxRepaired, isTrue'), 'test does not assert closure repair policy');
assert(test.includes("test('selected action intent step is injected exactly once in normal snapshots'"), 'Q382R3 exact-once test missing');
assert(!test.includes("expect(snapshot.steps.map((step) => step.index).toList(), List<int>.generate(snapshot.steps.length, (index) => index + 1));\n  }\n\n}"), 'Q382R3 exact-once test still has unterminated closure');
assert(test.includes("expect(snapshot.steps.map((step) => step.index).toList(), List<int>.generate(snapshot.steps.length, (index) => index + 1));\n  });"), 'Q382R3 exact-once test closure was not repaired');

const testInvocationCount = (test.match(/\btest\(/g) || []).length;
const closedInvocationCount = (test.match(/\n\s*}\);/g) || []).length;
assert(testInvocationCount === closedInvocationCount, `test invocation closure mismatch: test=${testInvocationCount}, closed=${closedInvocationCount}`);

const appShell = read('lib/app/app_shell.dart');
assert(appShell.includes('Bu işlem henüz desteklenmiyor; sahte sonuç gösterilmiyor.'), 'unsupported selected action no-fake message not preserved');
assert(appShell.includes('_clearWorkspaceMathActionSilently();'), 'selected action clear path not preserved');

const solution = read('lib/features/solution/solution_step_models.dart');
assert(solution.includes('var intentStepInjected = false;'), 'Q382R3 explicit intent injection flag missing after Q382R4');
assert(!solution.includes('!injected.contains(intentStep)'), 'object-identity contains guard reintroduced');

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
  'android/app/src/main/AndroidManifest.xml',
]) {
  assert(exists(protectedFile), `${protectedFile} missing`);
}

console.log('Q382R4_VERIFY_PASS workspace context menu test syntax repair verified.');
