#!/usr/bin/env node
import { existsSync, readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const root = dirname(dirname(__filename));
const phase = 'V172-Q133';

function read(rel) { try { return readFileSync(join(root, rel), 'utf8'); } catch { return ''; } }
function exists(rel) { return existsSync(join(root, rel)); }
function has(rel, marker) { return read(rel).includes(marker); }

const required = [
  'assets/mathlive/main_editor.html',
  'assets/mathlive/mathlive_bridge.js',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'lib/features/mathlive/mathlive_main_editor_runtime_activation_v172_q133_policy.dart',
  'lib/features/workspace/workspace_panel.dart',
  'lib/app/app_shell.dart',
  'lib/state/calculator_controller.dart',
  'docs/audit/V172_Q133_MAIN_EDITOR_MATHLIVE_RUNTIME_ACTIVATION_AUDIT_REPORT.md',
  'docs/audit/V172_Q133_MAIN_EDITOR_MATHLIVE_RUNTIME_ACTIVATION_CHANGED_FILES_MANIFEST.md'
];
const markers = [
  ['assets/mathlive/main_editor.html', "window.MathProMathLiveRuntimeMode = 'main-editor'"],
  ['assets/mathlive/main_editor.html', 'vendor/mathlive/mathlive.min.js'],
  ['assets/mathlive/mathlive_bridge.js', "runtimeMode === 'main-editor'"],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', 'class MathLiveMainEditorSurface'],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', 'executeMathProCommand'],
  ['lib/features/workspace/workspace_panel.dart', 'useMathLiveMainEditor'],
  ['lib/app/app_shell.dart', '_useMathLiveMainEditor = true'],
  ['lib/app/app_shell.dart', '_mathLiveMainEditor.sendKey'],
  ['lib/state/calculator_controller.dart', 'syncExternalEditorExpression'],
  ['lib/features/mathlive/mathlive_main_editor_runtime_activation_v172_q133_policy.dart', "phase = 'V172-Q133'"],
  ['lib/features/mathlive/mathlive_main_editor_runtime_activation_v172_q133_policy.dart', 'legacyCursorPhysicalDeletionImplementedInThisPackage = false'],
  ['lib/features/mathlive/mathlive_main_editor_runtime_activation_v172_q133_policy.dart', 'mathLiveVirtualKeyboardEnabled = false']
];
const protectedKeyboard = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/keyboard/premium_key.dart'
];
const untouchedUi = [
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart',
  'lib/features/workspace/math_label.dart',
  'lib/features/workspace/template_tray.dart'
];
const blockers = [];
for (const rel of required) if (!exists(rel)) blockers.push(`missing required file: ${rel}`);
for (const [rel, marker] of markers) if (!has(rel, marker)) blockers.push(`missing marker in ${rel}: ${marker}`);
for (const rel of [...protectedKeyboard, ...untouchedUi]) {
  if (!exists(rel)) blockers.push(`missing protected/untouched file: ${rel}`);
  if (has(rel, phase)) blockers.push(`Q133 marker unexpectedly found in protected/untouched UI file: ${rel}`);
}
const combined = [
  read('lib/features/mathlive/mathlive_main_editor_runtime_activation_v172_q133_policy.dart'),
  read('lib/features/mathlive/mathlive_main_editor_surface.dart'),
  read('assets/mathlive/main_editor.html')
].join('\n');
for (const forbidden of [
  'legacyCursorPhysicalDeletionImplementedInThisPackage = true',
  'mathLiveVirtualKeyboardEnabled = true',
  'remoteScriptLoadingAllowed = true',
  'cursorPassClaimedInThisPackage = true',
  'releasePassClaimedInThisPackage = true',
  'http://',
  'https://'
]) {
  if (combined.includes(forbidden)) blockers.push(`forbidden Q133 marker present: ${forbidden}`);
}
const packageReady = blockers.length === 0;
const report = {
  phase,
  status: packageReady
    ? 'Q133_MAIN_EDITOR_MATHLIVE_RUNTIME_ACTIVATION_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
    : 'BLOCKED_Q133_MAIN_EDITOR_MATHLIVE_RUNTIME_ACTIVATION',
  packageReady,
  evidenceComplete: false,
  blockers,
  activeVisibleEditor: 'mathliveMainEditorBehindFlag',
  rollbackEditor: 'legacyFlutterSlotEditor',
  mathLiveEnabledByDefaultForProbe: true,
  mayDeleteLegacyCursor: false,
  mayClaimCursorPass: false,
  mayClaimReleasePass: false,
  keyboardFilesMutated: false,
  moreLongPressFilesMutated: false,
  graphHistorySolutionUiFilesMutated: false,
  appShellTouchedForEditorRouting: true,
  requiredRuntimeSteps: [
    'node tool/install_mathlive_runtime.mjs',
    'flutter run -d 23106RN0DA',
    'real-device main editor tap/caret validation'
  ]
};
mkdirSync(join(root, 'tool/reports'), { recursive: true });
writeFileSync(join(root, 'tool/reports/main_editor_mathlive_runtime_activation_v172_q133_report.json'), JSON.stringify(report, null, 2) + '\n');
writeFileSync(join(root, 'tool/reports/main_editor_mathlive_runtime_activation_v172_q133_report.md'), `# ${phase} Report\n\nStatus: ${report.status}\n\nPackage ready: ${packageReady}\n\nBlockers:\n${blockers.map((b) => `- ${b}`).join('\n') || '- none'}\n`);
console.log(JSON.stringify(report, null, 2));
process.exit(packageReady ? 0 : 2);
