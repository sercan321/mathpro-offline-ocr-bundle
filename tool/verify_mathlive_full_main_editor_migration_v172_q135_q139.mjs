#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_full_main_editor_migration_v172_q135_q139.mjs', retiredPhase: 'verify_mathlive_full_main_editor_migration_v172_q135_q139', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = process.argv[2] ? path.resolve(process.argv[2]) : path.resolve(__dirname, '..');
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
const blockers = [];
const required = [
  'lib/features/editor_adapter/mathlive_full_main_editor_migration_v172_q135_q139_policy.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'lib/features/workspace/workspace_panel.dart',
  'assets/mathlive/main_editor.html',
  'assets/mathlive/mathlive_bridge.js',
  'docs/audit/V172_Q135_Q139_MATHLIVE_FULL_MAIN_EDITOR_MIGRATION_AUDIT_REPORT.md',
  'docs/audit/V172_Q135_Q139_MATHLIVE_FULL_MAIN_EDITOR_MIGRATION_CHANGED_FILES_MANIFEST.md'
];
for (const rel of required) if (!exists(rel)) blockers.push(`missing ${rel}`);
const policy = exists(required[0]) ? read(required[0]) : '';
const surface = exists(required[1]) ? read(required[1]) : '';
const workspace = exists(required[2]) ? read(required[2]) : '';
const bridge = exists(required[4]) ? read(required[4]) : '';
const readme = exists('README.md') ? read('README.md') : '';
const contract = exists('lib/logic/mathpro_package_contract.dart') ? read('lib/logic/mathpro_package_contract.dart') : '';
const mustContain = [
  [policy, "phase = 'V172-Q135-Q139'"],
  [policy, 'legacyCursorOverlayActiveInMainPath = false'],
  [policy, 'legacyCursorHitTestActiveInMainPath = false'],
  [policy, 'legacyEditorSurfaceFallbackAllowedInMainPath = false'],
  [policy, 'mathLiveMainEditorMandatory = true'],
  [surface, "phase = 'V172-Q135-Q139'"],
  [surface, 'mathpro-main-mathlive-editor-surface-q135-q139-full-migration'],
  [surface, "premiumSurfaceRepairPhase = 'V172-Q140'"],
  [surface, 'window.MathProMathLiveOfflineBridge.tryMountOfficialMathLive'],
  [workspace, 'mathpro-legacy-cursor-main-path-disabled-q135'],
  [workspace, 'useMathLiveMainEditor'],
  [workspace, 'const _LegacyCursorMainPathDisabledPanel()'],
  [bridge, "phase: mainEditorMode ? 'V172-Q135-Q139' : 'V172-Q84'"],
  [bridge, "activeMainEditorEngine: mainEditorMode ? 'mathliveMainEditorMandatory' : 'legacyFlutterSlotEditor'"],
  [bridge, 'stateAdapterLabOnly: !mainEditorMode'],
  [readme, 'V172-Q135–Q139 — MathLive Full Main Editor Migration Batch'],
  [contract, 'q135Q139MathLiveFullMainEditorMigrationRule'],
];
for (const [src, marker] of mustContain) {
  if (!src.includes(marker)) blockers.push(`missing marker: ${marker}`);
}
const forbidden = [
  [workspace, 'useMathLiveMainEditor && mathLiveController != null'],
  [bridge, "activeMainEditorEngine: mainEditorMode ? 'mathliveMainEditorBehindFlag'"],
  [bridge, "defaultMainEditorEngine: 'legacyFlutterSlotEditor'"],
  [policy, 'legacyCursorPhysicalDeletionInThisBatch = true'],
  [policy, 'releasePassClaimed = true'],
  [policy, 'cursorPassClaimed = true'],
  [surface, 'mathpro-main-editor-mathlive-migration-badge-q135-q139'],
];
for (const [src, marker] of forbidden) {
  if (src.includes(marker)) blockers.push(`forbidden marker present: ${marker}`);
}
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
for (const rel of protectedFiles) {
  if (!exists(rel)) blockers.push(`protected file missing: ${rel}`);
}
const status = blockers.length === 0
  ? 'Q135_Q139_MATHLIVE_FULL_MAIN_EDITOR_MIGRATION_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_Q135_Q139_MATHLIVE_FULL_MAIN_EDITOR_MIGRATION';
const report = {
  phase: 'V172-Q135-Q139',
  status,
  blockers,
  invariants: {
    realMigrationBatch: true,
    legacyCursorOverlayActiveInMainPath: false,
    legacyCursorHitTestActiveInMainPath: false,
    legacyEditorSurfaceFallbackAllowedInMainPath: false,
    mathLiveMainEditorMandatory: true,
    keyboardLayoutMutationAllowed: false,
    longPressMutationAllowed: false,
    moreMutationAllowed: false,
    graphHistorySolutionUiMutationAllowed: false,
    legacyCursorPhysicalDeletionInThisBatch: false,
    cursorPassClaimed: false,
    releasePassClaimed: false
  }
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_full_main_editor_migration_v172_q135_q139_report.json'), JSON.stringify(report, null, 2));
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_full_main_editor_migration_v172_q135_q139_report.md'), `# ${status}\n\nBlockers: ${blockers.length}\n`);
console.log(JSON.stringify(report, null, 2));
if (blockers.length) process.exit(1);
