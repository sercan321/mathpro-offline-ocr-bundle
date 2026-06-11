#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q382R5_VERIFY_FAIL: ${msg}`); process.exit(1); };
const assert = (cond, msg) => { if (!cond) fail(msg); };

const phase = 'V172-Q382R5-WORKSPACE-CONTEXT-MENU-UNSUPPORTED-ACTION-AND-EDITOR-SEMANTICS-REPAIR';
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert(manifest.workspaceExpressionContextMenuUnsupportedActionEditorSemanticsRepairLatestPhase === phase, 'manifest Q382R5 latest phase missing');
const envelope = manifest.v172Q382R5WorkspaceContextMenuUnsupportedActionEditorSemanticsRepair;
assert(envelope?.unsupportedActionsDisabledBeforeSelection === true, 'manifest unsupported actions disabled marker missing');
assert(envelope?.staleGenericResultSuppressedForUnsupportedIntent === true, 'manifest stale generic result suppression marker missing');
assert(envelope?.editorReplacementActionsUseExplicitLabels === true, 'manifest editor explicit label marker missing');
assert(envelope?.selectAllShowsVisibleTargetChip === true, 'manifest select-all visible chip marker missing');
assert(envelope?.contextMenuUsesAllResolvedActionsForInternalScroll === true, 'manifest no-truncate/scroll marker missing');
assert(envelope?.mathLiveContextMenuSyncResultChecked === true, 'manifest MathLive sync result marker missing');
assert(envelope?.q381R1OcrRuntimeChanged === false, 'manifest must preserve Q381R1 OCR runtime');

const policy = read('lib/features/workspace/workspace_expression_context_menu_q382_policy.dart');
assert(policy.includes(`unsupportedActionAndEditorSemanticsRepairPhase = '${phase}'`), 'policy Q382R5 phase marker missing');
for (const marker of [
  'unsupportedActionsDisabledBeforeSelection = true',
  'staleResultSuppressedForUnsupportedIntent = true',
  'editorReplacementActionsUseExplicitLabels = true',
  'selectAllShowsVisibleTargetChip = true',
  'contextMenuUsesAllResolvedActionsForInternalScroll = true',
  'mathLiveContextMenuSyncResultChecked = true',
]) assert(policy.includes(marker), `policy marker missing: ${marker}`);

const menu = read('lib/features/workspace/workspace_expression_context_menu.dart');
assert(menu.includes(`handlerSupportAndEditorSemanticsRepairPhase = '${phase}'`), 'menu Q382R5 phase marker missing');
assert(menu.includes('unsupportedActionsDisabledBeforeSelection = true'), 'menu unsupported action marker missing');
assert(menu.includes("label: 'Tümünü Değiştir'"), 'paste label must disclose whole-expression replacement');
assert(menu.includes("label: 'Tümünü Kes'"), 'cut label must disclose whole-expression cut');
assert(menu.includes("label: 'Tümünü Hedefle'"), 'select-all label must disclose target-state behavior');
assert(menu.includes('final mathActions = resolution.actions;'), 'menu must not truncate math actions before internal scroll');
assert(!menu.includes('resolution.actions.take(7)'), 'menu still truncates math actions with take(7)');
assert(menu.includes('availableSafeHeight'), 'actual safe-height clamp missing');
assert(menu.includes('_compactDisabledReason(action.disabledReason)'), 'disabled reason compaction missing');

const resolver = read('lib/features/workspace/workspace_math_action_resolver.dart');
assert(resolver.includes('enabled: false'), 'default unproven solver intents must be disabled');
assert(resolver.includes("disabledReason: 'Gerçek handler kanıtlanmadan aktif değil.'"), 'default unproven handler disabled reason missing');
assert(!resolver.includes('enabled: true,\n        priority: priority,\n        supportedByCurrentEngine: false,\n        requiresSolverHandler: true'), 'unproven solver intent still enabled');

const app = read('lib/app/app_shell.dart');
assert(app.includes('selectedActionHasUnsupportedHandler'), 'app shell unsupported selected action guard missing');
assert(app.includes("result: selectedActionHasUnsupportedHandler ? '—' : calculatorState.result"), 'app shell stale result suppression missing');
assert(app.includes("unsupportedReason: selectedActionHasUnsupportedHandler"), 'app shell unsupported reason override missing');
assert(app.includes('allExpressionSelectedFromContextMenu: _workspaceExpressionAllSelectedFromContextMenu'), 'app shell select-all chip state not routed');
assert(app.includes('final synced = await _mathLiveMainEditor.setLatexFromWorkspaceContextMenu(replacement);'), 'MathLive sync result not checked');
assert(app.includes('editor eşitlemesi bekleniyor'), 'MathLive sync pending message missing');

const solution = read('lib/features/solution/solution_step_models.dart');
assert(solution.includes('V172-Q382R5: unsupported context-menu intents must never reuse a stale'), 'solution Q382R5 stale-result guard comment missing');
assert(solution.includes('selectedActionUnsupported'), 'solution selectedActionUnsupported guard missing');
assert(solution.includes("final cleanResult = selectedActionUnsupported ? '—'"), 'solution cleanResult stale suppression missing');
assert(solution.includes("'Bu işlem henüz desteklenmiyor; sahte sonuç gösterilmiyor.'"), 'solution unsupported no-fake copy missing');

const panel = read('lib/features/workspace/workspace_panel.dart');
assert(panel.includes('allExpressionSelectedFromContextMenu'), 'workspace panel select-all state missing');
assert(panel.includes('mathpro-q382-selected-all-expression-target-chip'), 'visible select-all target chip missing');
assert(panel.includes('Hedef: Tüm ifade'), 'select-all target chip copy missing');

const editor = read('lib/features/workspace/workspace_editor_actions.dart');
assert(editor.includes('Tüm ifade kesildi.'), 'cut-all message missing');
assert(editor.includes('Tüm ifade panodaki metinle değiştirildi.'), 'paste replacement message missing');

const test = read('test/v172_q382_workspace_expression_context_menu_test.dart');
assert(test.includes('unsupportedActionAndEditorSemanticsRepairPhase'), 'Q382 test does not cover Q382R5 phase');
assert(test.includes("expect(polynomial.actions.where((action) => action.id == 'factor').single.enabled, isFalse)"), 'test does not assert factor disabled without handler');
assert(test.includes('unsupported selected action suppresses stale generic result'), 'test does not cover stale generic result suppression');

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
]) assert(exists(protectedFile), `${protectedFile} missing`);

console.log('Q382R5_VERIFY_PASS workspace context menu unsupported-action/editor-semantics repair verified.');
