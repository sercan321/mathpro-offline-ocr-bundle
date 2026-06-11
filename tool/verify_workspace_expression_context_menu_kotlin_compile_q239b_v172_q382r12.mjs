#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q382R12_VERIFY_FAIL: ${msg}`); process.exit(1); };
const assert = (cond, msg) => { if (!cond) fail(msg); };
const phase = 'V172-Q382R12-WORKSPACE-CONTEXT-MENU-KOTLIN-COMPILE-Q239B-EXPECTATION-REPAIR';

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert(manifest.workspaceExpressionContextMenuKotlinCompileQ239BExpectationRepairLatestPhase === phase, 'manifest Q382R12 latest phase missing');
const envelope = manifest.v172Q382R12WorkspaceContextMenuKotlinCompileQ239BExpectationRepair;
assert(envelope?.kotlinVocabularySidecarBooleanPrecedenceRepaired === true, 'Q382R12 Kotlin precedence marker missing');
assert(envelope?.q239bMoreIconExpectationAllowsQ382ContextMenu === true, 'Q382R12 Q239B more icon marker missing');
assert(envelope?.runtimeBehaviorChanged === false, 'Q382R12 must not change runtime behavior');
assert(envelope?.keyboardLayoutChanged === false, 'keyboard must remain unchanged');
assert(envelope?.mathLiveProductionAssetsChanged === false, 'MathLive production assets must remain unchanged');
assert(envelope?.q381R1OcrRuntimeSemanticsChanged === false, 'Q381R1 OCR runtime semantics must remain unchanged');

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes('"vocabularySidecarsReady" to (copied.isNotEmpty() || q379LoadDecoderVocabulary().isNotEmpty()),'), 'MainActivity Q381 vocabulary boolean precedence repair missing');
assert(!mainActivity.includes('"vocabularySidecarsReady" to copied.isNotEmpty() || q379LoadDecoderVocabulary().isNotEmpty(),'), 'MainActivity still has unparenthesized vocabularySidecarsReady pair');

const q239b = read('test/v172_q239b_camera_permission_capture_shell_test.dart');
assert(q239b.includes("workspace.contains(\"ValueKey('mathpro-q382-expression-context-menu-safe-hit-zone')\")"), 'Q239B must allow Q382 context menu safe-zone more icon');
assert(q239b.includes("!workspace.contains('Icons.more_horiz_rounded') ||"), 'Q239B more icon guard must be successor-aware');
assert(q239b.includes("ValueKey('mathpro-more-placeholder-button')"), 'Q239B must still block legacy MORE placeholder button');

const policy = read('lib/features/workspace/workspace_expression_context_menu_q382_policy.dart');
assert(policy.includes(`kotlinCompileAndQ239BExpectationRepairPhase = '${phase}'`), 'policy Q382R12 phase missing');
assert(policy.includes('q382R12KotlinVocabularySidecarBooleanPrecedenceRepaired = true'), 'policy Q382R12 Kotlin marker missing');
assert(policy.includes('q382R12Q239BMoreIconExpectationAllowsQ382ContextMenu = true'), 'policy Q382R12 Q239B marker missing');
assert(policy.includes('q382R12RuntimeBehaviorUnchanged = true'), 'policy Q382R12 runtime unchanged marker missing');

const q382Test = read('test/v172_q382_workspace_expression_context_menu_test.dart');
assert(q382Test.includes('kotlinCompileAndQ239BExpectationRepairPhase'), 'Q382 test missing Q382R12 phase expectation');
assert(q382Test.includes('q382R12KotlinVocabularySidecarBooleanPrecedenceRepaired'), 'Q382 test missing Q382R12 Kotlin expectation');
assert(q382Test.includes('q382R12Q239BMoreIconExpectationAllowsQ382ContextMenu'), 'Q382 test missing Q382R12 Q239B expectation');

for (const protectedFile of [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'assets/mathlive/mathlive_bridge.js',
  'assets/mathlive/main_editor.html',
  'android/app/build.gradle',
  'pubspec.yaml',
  'android/app/src/main/AndroidManifest.xml',
]) assert(exists(protectedFile), `${protectedFile} missing`);

console.log('Q382R12_VERIFY_PASS workspace context menu Kotlin compile/Q239B expectation repair verified.');
