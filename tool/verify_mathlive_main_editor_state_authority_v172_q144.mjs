#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_main_editor_state_authority_v172_q144.mjs', retiredPhase: 'verify_mathlive_main_editor_state_authority_v172_q144', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/mathlive/mathlive_main_editor_state_authority_policy.dart',
  'lib/app/app_shell.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'lib/features/mathlive/mathlive_state_normalization_hardening_policy.dart',
  'test/v172_q144_mathlive_main_editor_state_authority_test.dart',
  'docs/audit/V172_Q144_MATHLIVE_MAIN_EDITOR_STATE_AUTHORITY_AUDIT_REPORT.md',
  'docs/audit/V172_Q144_MATHLIVE_MAIN_EDITOR_STATE_AUTHORITY_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const shell = exists(required[1]) ? read(required[1]) : '';
const surface = exists(required[2]) ? read(required[2]) : '';
const normalizer = exists(required[3]) ? read(required[3]) : '';
const mustContain = [
  [policy, "phase = 'V172-Q144'"],
  [policy, 'mathLiveSnapshotOwnsMainExpression = true'],
  [policy, 'rawFlutterLabelShadowWritesAllowed = false'],
  [policy, 'namedTemplateLabelsMayEnterControllerAsPlainText = false'],
  [policy, 'mathfieldMayBeOverwrittenByRoutineKeyEcho = false'],
  [policy, 'isPlainNamedTemplateLeak'],
  [shell, "import '../features/mathlive/mathlive_keyboard_bridge_policy.dart';"],
  [shell, "import '../features/mathlive/mathlive_main_editor_state_authority_policy.dart';"],
  [shell, 'MathLive is now the expression authority'],
  [shell, 'commandForMainEditorLabel'],
  [shell, 'MathLiveMainEditorStateAuthorityPolicy.snapshotSource'],
  [surface, "stateAuthorityPhase = 'V172-Q144'"],
  [surface, 'MathLiveMainEditorStateAuthorityPolicy.authoritativeExpression'],
  [surface, 'mayAcceptExternalExpressionSync'],
  [surface, 'avoiding raw label echo'],
  [normalizer, "mainEditorStateAuthorityActivationPhase = 'V172-Q144'"],
  [normalizer, '_replaceMathLivePlaceholders'],
  [normalizer, "RegExp(r'\\\\placeholder\\s*\\{[^{}]*\\}')"],
  [normalizer, "RegExp(r'#\\?|#0|#@')"]
];
for (const [src, marker] of mustContain) if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
const forbidden = [
  [policy, 'realDevicePassClaimed = true'],
  [policy, 'photomathLevelClaimed = true'],
  [shell, '_calculator.handleKey(label);\n      _mathLiveMainEditor.sendKey(label'],
  [shell, 'q133-mathlive-main-editor-state']
];
for (const [src, marker] of forbidden) if (src.includes(marker)) blockers.push(`forbidden marker present: ${marker}`);
const protectedFiles = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/workspace/math_label.dart',
  'lib/features/workspace/template_tray.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart'
];
for (const rel of protectedFiles) if (!exists(rel)) blockers.push(`protected file missing: ${rel}`);
const status = blockers.length === 0
  ? 'MATHLIVE_MAIN_EDITOR_STATE_AUTHORITY_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_MATHLIVE_MAIN_EDITOR_STATE_AUTHORITY';
const report = {
  phase: 'V172-Q144',
  status,
  blockers,
  packageSideRepairReady: blockers.length === 0,
  authorityRepairs: {
    mathLiveSnapshotOwnsMainExpression: true,
    rawFlutterLabelShadowWritesAllowed: false,
    namedTemplateLabelsMayEnterControllerAsPlainText: false,
    mathfieldMayBeOverwrittenByRoutineKeyEcho: false,
    placeholderNormalizationForControllerState: true,
    protectedKeyboardMutationAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_main_editor_state_authority_v172_q144_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_main_editor_state_authority_v172_q144_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
