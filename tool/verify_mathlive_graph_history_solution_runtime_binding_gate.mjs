import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_graph_history_solution_runtime_binding_gate.mjs', retiredPhase: 'verify_mathlive_graph_history_solution_runtime_binding_gate', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const __dirname = dirname(fileURLToPath(import.meta.url));
const root = dirname(__dirname);
const reportDir = join(root, 'tool', 'reports');
const reportJson = join(reportDir, 'mathlive_graph_history_solution_runtime_binding_gate_report.json');
const reportMarkdown = join(reportDir, 'mathlive_graph_history_solution_runtime_binding_gate_report.md');

function read(rel) {
  const p = join(root, rel);
  return existsSync(p) ? readFileSync(p, 'utf8') : '';
}

function fileExists(rel) {
  return existsSync(join(root, rel));
}

function has(rel, marker) {
  return read(rel).includes(marker);
}

const requiredFiles = [
  'lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart',
  'tool/verify_mathlive_graph_history_solution_runtime_binding_gate.mjs',
  'test/v172_q119_graph_history_solution_runtime_binding_gate_test.dart',
  'docs/audit/V172_Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_GATE_AUDIT_REPORT.md',
  'docs/audit/V172_Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_GATE_CHANGED_FILES_MANIFEST.md',
];

const protectedFiles = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/workspace/math_label.dart',
  'lib/features/workspace/template_tray.dart',
  'lib/app/app_shell.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart',
];

const requiredMarkers = [
  ['lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart', "phase = 'V172-Q119'"],
  ['lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart', 'gateOnly = true'],
  ['lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart', 'runtimeGraphBindingImplementedInThisPackage = false'],
  ['lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart', 'runtimeHistoryBindingImplementedInThisPackage = false'],
  ['lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart', 'runtimeSolutionBindingImplementedInThisPackage = false'],
  ['lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart', 'graphCardMutationAllowed = false'],
  ['lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart', 'historyControllerMutationAllowed = false'],
  ['lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart', 'solutionStepsPanelMutationAllowed = false'],
  ['lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart', 'legacyCursorDeletionAllowed = false'],
  ['lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart', 'Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'],
  ['assets/mathlive/manifest.json', '"q119GraphHistorySolutionRuntimeBindingGatePhase": "V172-Q119"'],
  ['assets/mathlive/manifest.json', '"q119RuntimeGraphBindingImplemented": false'],
  ['assets/mathlive/manifest.json', '"q119RuntimeHistoryBindingImplemented": false'],
  ['assets/mathlive/manifest.json', '"q119RuntimeSolutionBindingImplemented": false'],
  ['assets/mathlive/manifest.json', '"q119MayDeleteLegacyCursor": false'],
  ['lib/logic/mathpro_package_contract.dart', 'q119GraphHistorySolutionRuntimeBindingGateRule'],
  ['README.md', 'V172-Q119 — Graph / History / Solution Runtime Binding Gate'],
  ['docs/audit/V172_Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_GATE_AUDIT_REPORT.md', 'Q119 is a gate only; it does not perform runtime Graph, History, or Solution writes'],
  ['docs/audit/V172_Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_GATE_CHANGED_FILES_MANIFEST.md', 'Protected files intentionally untouched'],
];

const forbiddenMarkers = [
  '"q119RuntimeGraphBindingImplemented": true',
  '"q119RuntimeHistoryBindingImplemented": true',
  '"q119RuntimeSolutionBindingImplemented": true',
  '"q119MaySwitchDefaultEditorNow": true',
  '"q119MayRetireLegacyMainPath": true',
  '"q119MayDeleteLegacyCursor": true',
  '"q119MayClaimCursorPass": true',
  '"q119CreatesFakeRuntimeEvidence": true',
  '"q119CreatesFakeGraphEvidence": true',
  '"q119CreatesFakeHistoryEvidence": true',
  '"q119CreatesFakeSolutionEvidence": true',
];

const blockers = [];
for (const rel of requiredFiles) {
  if (!fileExists(rel)) blockers.push(`missing required Q119 file: ${rel}`);
}
for (const [rel, marker] of requiredMarkers) {
  if (!has(rel, marker)) blockers.push(`missing marker in ${rel}: ${marker}`);
}
const combined = [
  read('assets/mathlive/manifest.json'),
  read('lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart'),
  read('README.md'),
].join('\n');
for (const marker of forbiddenMarkers) {
  if (combined.includes(marker)) blockers.push(`forbidden enabled Q119 marker present: ${marker}`);
}
for (const rel of protectedFiles) {
  const source = read(rel);
  if (source.includes('V172-Q119') || source.includes('q119GraphHistorySolutionRuntimeBinding')) {
    blockers.push(`Q119 marker found in protected file: ${rel}`);
  }
}

const packageReady = blockers.length === 0;
const report = {
  phase: 'V172-Q119',
  status: packageReady
    ? 'Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED'
    : 'BLOCKED_Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_GATE',
  packageReady,
  runtimeBindingEvidenceComplete: false,
  blockers,
  mayBindGraphAtRuntime: false,
  mayBindHistoryAtRuntime: false,
  mayBindSolutionAtRuntime: false,
  maySwitchMainEditor: false,
  mayRetireLegacyMainPath: false,
  mayDeleteLegacyCursor: false,
  mayClaimCursorPass: false,
  mayClaimReleasePass: false,
  protectedRuntimeUiSurfacesUntouchedByPolicy: true,
  requiredEvidenceBeforeRuntimeBinding: [
    'Q118 activation dry-run evidence complete',
    'Q118 human review approval',
    'explicit Q119 runtime binding approval',
    'flutter analyze PASS evidence',
    'flutter test PASS evidence',
    'MathLive Lab real-device run evidence',
    'main app real-device run evidence',
    'Graph runtime scenario evidence',
    'History runtime scenario evidence',
    'Solution runtime scenario evidence',
    'protected surface hash verification',
    'legacy rollback availability',
  ],
};

mkdirSync(reportDir, { recursive: true });
writeFileSync(reportJson, `${JSON.stringify(report, null, 2)}\n`);
writeFileSync(reportMarkdown, `# V172-Q119 Graph / History / Solution Runtime Binding Gate\n\nStatus: ${report.status}\n\nPackage ready: ${report.packageReady}\nRuntime binding evidence complete: ${report.runtimeBindingEvidenceComplete}\n\nMay bind Graph at runtime: ${report.mayBindGraphAtRuntime}\nMay bind History at runtime: ${report.mayBindHistoryAtRuntime}\nMay bind Solution at runtime: ${report.mayBindSolutionAtRuntime}\nMay switch main editor: ${report.maySwitchMainEditor}\nMay delete legacy cursor: ${report.mayDeleteLegacyCursor}\n\nBlockers:\n${blockers.length ? blockers.map((b) => `- ${b}`).join('\n') : '- Evidence is intentionally incomplete until user-side real-device/runtime reports are provided.'}\n`);

if (!packageReady) {
  console.error(report.status);
  console.error(blockers.join('\n'));
  process.exit(1);
}
console.log(report.status);
