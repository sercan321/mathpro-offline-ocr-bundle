#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const fail = (message) => { console.error(`FAIL verify_workspace_frame_isolation_v172_q382r30: ${message}`); process.exit(1); };
const must = (rel, needle) => { if (!read(rel).includes(needle)) fail(`${rel} missing ${needle}`); };
const mustNot = (rel, needle) => { if (read(rel).includes(needle)) fail(`${rel} must not contain ${needle}`); };

const required = [
  'lib/features/workspace/workspace_frame_isolation_q382r30.dart',
  'lib/features/workspace/workspace_panel.dart',
  'lib/app/app_shell.dart',
  'test/v172_q382r30_workspace_frame_isolation_test.dart',
  'tool/verify_workspace_frame_isolation_v172_q382r30.mjs',
  'docs/audit/V172_Q382R30_WORKSPACE_FRAME_ISOLATION.md',
  'docs/audit/V172_Q382R30_CHANGED_FILES.md',
];
for (const rel of required) if (!exists(rel)) fail(`missing required file ${rel}`);

must('lib/features/workspace/workspace_frame_isolation_q382r30.dart', "static const String phase = 'V172-Q382R30'");
must('lib/features/workspace/workspace_frame_isolation_q382r30.dart', 'q382r30-workspace-frame-isolation-active');
must('lib/features/workspace/workspace_frame_isolation_q382r30.dart', 'isolateExpressionAndResultFrame = true');
must('lib/features/workspace/workspace_frame_isolation_q382r30.dart', 'cacheStructuralWorkspaceShell = true');
must('lib/features/workspace/workspace_frame_isolation_q382r30.dart', 'optimisticEchoScopeUnchanged = true');
must('lib/features/workspace/workspace_frame_isolation_q382r30.dart', 'class WorkspaceFrameHotSnapshotQ382R30');
must('lib/features/workspace/workspace_frame_isolation_q382r30.dart', 'operator ==');

must('lib/app/app_shell.dart', "import '../features/workspace/workspace_frame_isolation_q382r30.dart';");
must('lib/app/app_shell.dart', '_WorkspaceStructuralKeyQ382R30');
must('lib/app/app_shell.dart', 'ValueNotifier<WorkspaceFrameHotSnapshotQ382R30> _q382r30WorkspaceHotFrame');
must('lib/app/app_shell.dart', '_calculator.addListener(_handleQ382R30CalculatorFrameChanged)');
must('lib/app/app_shell.dart', '_calculator.removeListener(_handleQ382R30CalculatorFrameChanged)');
must('lib/app/app_shell.dart', '_q382r30CachedWorkspaceKey');
must('lib/app/app_shell.dart', '_q382r30CachedWorkspace');
must('lib/app/app_shell.dart', 'WorkspaceFrameIsolationQ382R30Policy.cacheStructuralWorkspaceShell');
must('lib/app/app_shell.dart', 'q382r30HotFrameListenable: _q382r30WorkspaceHotFrame');
must('lib/app/app_shell.dart', 'solutionExpression: _stepsPanelState.isOpen');
must('lib/app/app_shell.dart', 'if (next == _q382r30WorkspaceHotFrame.value) return;');

must('lib/features/workspace/workspace_panel.dart', "import 'workspace_frame_isolation_q382r30.dart';");
must('lib/features/workspace/workspace_panel.dart', 'final ValueListenable<WorkspaceFrameHotSnapshotQ382R30>? q382r30HotFrameListenable;');
must('lib/features/workspace/workspace_panel.dart', '_Q382R30ExpressionFrameSection');
must('lib/features/workspace/workspace_panel.dart', '_Q382R30ResultFrameSection');
must('lib/features/workspace/workspace_panel.dart', 'ValueListenableBuilder<WorkspaceFrameHotSnapshotQ382R30>');
must('lib/features/workspace/workspace_panel.dart', 'expressionText: frame.expressionText');
must('lib/features/workspace/workspace_panel.dart', 'lastAnswer: frame.resultText');
must('lib/features/workspace/workspace_panel.dart', 'value: resultText');

for (const rel of [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/logic/action_utils.dart',
  'assets/mathlive/mathlive_prod_bridge.js',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
]) {
  mustNot(rel, 'V172-Q382R30');
  mustNot(rel, 'q382r30-workspace-frame-isolation-active');
}
for (const rel of ['assets/mathlive/mathlive_prod_bridge.js', 'lib/features/mathlive/mathlive_production_editor_surface.dart']) {
  mustNot(rel, 'document.addEventListener(\'touchmove\'');
  mustNot(rel, 'direct-pan');
  mustNot(rel, 'host-scrollport-force');
  mustNot(rel, 'document-capture');
}

console.log('PASS verify_workspace_frame_isolation_v172_q382r30');
