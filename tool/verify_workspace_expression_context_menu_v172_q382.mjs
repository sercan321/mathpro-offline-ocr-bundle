#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q382_VERIFY_FAIL: ${msg}`); process.exit(1); };
const assert = (cond, msg) => { if (!cond) fail(msg); };

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert(manifest.workspaceExpressionContextMenuActionIntentLatestPhase === 'V172-Q382-WORKSPACE-EXPRESSION-CONTEXT-MENU-ACTION-INTENT', 'manifest latest Q382 phase missing');
assert(manifest.v172Q382WorkspaceExpressionContextMenuActionIntent?.fakeSolverResultBlocked === true, 'manifest fake solver block missing');
assert(manifest.v172Q382WorkspaceExpressionContextMenuActionIntent?.ocrQ381R1SafetyPreserved === true, 'manifest OCR safety preservation missing');

const required = [
  'lib/features/workspace/workspace_expression_context_menu.dart',
  'lib/features/workspace/workspace_editor_actions.dart',
  'lib/features/workspace/workspace_math_action.dart',
  'lib/features/workspace/workspace_math_action_classifier.dart',
  'lib/features/workspace/workspace_math_action_resolver.dart',
  'lib/features/workspace/workspace_math_action_state.dart',
  'lib/features/workspace/workspace_expression_context_menu_q382_policy.dart',
  'test/v172_q382_workspace_expression_context_menu_test.dart',
  'docs/audit/V172_Q382_WORKSPACE_EXPRESSION_CONTEXT_MENU_AUDIT_REPORT.md',
  'docs/audit/V172_Q382_WORKSPACE_EXPRESSION_CONTEXT_MENU_CHANGED_FILES_MANIFEST.md',
];
for (const file of required) assert(exists(file), `${file} missing`);

const menu = read('lib/features/workspace/workspace_expression_context_menu.dart');
assert(menu.includes('floatingOverlayDoesNotResizeWorkspace = true'), 'floating overlay contract missing');
assert(menu.includes('scrollsInsideOwnMaxHeight = true'), 'internal scroll contract missing');
assert(menu.includes('clampsToSafeArea = true'), 'safe-area clamp contract missing');
assert(menu.includes('SingleChildScrollView'), 'menu internal scroll missing');
assert(menu.includes('OverlayEntry'), 'overlay entry missing');
assert(menu.includes('mathpro-q382-floating-expression-context-menu'), 'context menu key missing');
assert(menu.includes('WorkspaceEditorActionType.copy'), 'copy action missing');
assert(menu.includes('WorkspaceEditorActionType.paste'), 'paste action missing');
assert(menu.includes('WorkspaceEditorActionType.cut'), 'cut action missing');
assert(menu.includes('WorkspaceEditorActionType.selectAll'), 'select all action missing');
assert(menu.includes('WorkspaceEditorActionType.clear'), 'clear action missing');

const action = read('lib/features/workspace/workspace_math_action.dart');
assert(action.includes('polynomialExpression'), 'polynomial kind missing');
assert(action.includes('trigonometricEquation'), 'trig kind missing');
assert(action.includes('complexNumberExpression'), 'complex kind missing');
assert(action.includes('WorkspaceMathActionKind.mathIntentAction'), 'math intent kind missing');

const resolver = read('lib/features/workspace/workspace_math_action_resolver.dart');
for (const token of ['factor', 'roots', 'trigSolve', 'logSolve', 'partialFractions', 'complexRoots', 'differentiate', 'integrate', 'limit']) {
  assert(resolver.includes(`'${token}'`), `resolver missing ${token}`);
}
assert(resolver.includes("disabled('"), 'unsupported actions are not marked disabled');

const workspace = read('lib/features/workspace/workspace_panel.dart');
assert(workspace.includes('mathpro-q382-expression-context-menu-safe-hit-zone'), 'safe hit-zone trigger missing');
assert(workspace.includes('mathpro-q382-selected-workspace-action-chip'), 'selected action chip missing');
assert(workspace.includes('WorkspaceExpressionContextMenu.show'), 'workspace panel does not open menu');

const app = read('lib/app/app_shell.dart');
assert(app.includes('WorkspaceSelectedMathAction? _selectedWorkspaceMathAction'), 'app shell selected action state missing');
assert(app.includes('selectedActionId: selectedActionForSnapshot?.id'), 'solution metadata selectedActionId missing');
assert(app.includes('setLatexFromWorkspaceContextMenu'), 'MathLive context menu sync call missing');
assert(app.includes('q382-workspace-expression-context-menu'), 'Q382 editor source marker missing');

const solution = read('lib/features/solution/solution_step_models.dart');
assert(solution.includes('selectedActionId'), 'solution selectedActionId metadata missing');
assert(solution.includes('İşlem niyeti'), 'solution intent step missing');
assert(solution.includes('sahte sonuç üretilmedi'), 'fake result block copy missing');

const mathlive = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
assert(mathlive.includes('setLatexFromWorkspaceContextMenu'), 'MathLive controller context menu setter missing');
assert(!read('assets/mathlive/mathlive_prod_bridge.js').includes('Q382'), 'production MathLive bridge asset unexpectedly changed with Q382 marker');

const ocrPolicy = read('lib/features/camera/gauss_camera_ocr_runtime_finalization_q381_policy.dart');
assert(ocrPolicy.includes('nativeOcrBridgeRunsOffMainThread'), 'Q381R1 OCR risk repair marker missing');
assert(ocrPolicy.includes('fakeLatexGenerationBlocked'), 'Q381 fake OCR block marker missing');

console.log('Q382_VERIFY_PASS workspace expression context menu action intent shell verified.');
