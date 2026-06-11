#!/usr/bin/env node
import { existsSync, readFileSync, writeFileSync, mkdirSync, readdirSync, statSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { spawnSync } from 'node:child_process';

const __filename = fileURLToPath(import.meta.url);
const root = dirname(dirname(__filename));
const phase = "V172-Q126";
const expectedStatus = "Q126_LOCAL_EVIDENCE_RECONCILIATION_INTAKE_PACKAGE_READY_BUT_USER_EVIDENCE_REQUIRED";
const previousScript = "tool/verify_final_package_evidence_closure_intake_guard_v172_q125.mjs";
const protectedFiles = [
  "lib/features/keyboard/key_config.dart",
  "lib/features/keyboard/math_keyboard.dart",
  "lib/features/keyboard/bottom_dock.dart",
  "lib/features/keyboard/long_press_popup.dart",
  "lib/features/keyboard/premium_key.dart",
  "lib/features/workspace/math_label.dart",
  "lib/features/workspace/template_tray.dart",
  "lib/app/app_shell.dart",
  "lib/features/solution/solution_steps_panel.dart",
  "lib/features/graph/graph_card.dart",
  "lib/features/history/history_controller.dart",
  "lib/features/history/history_panel.dart"
];
const requiredFiles = [
  "lib/features/editor_adapter/local_evidence_reconciliation_intake_guard_v172_q126_policy.dart",
  "tool/verify_local_evidence_reconciliation_intake_guard_v172_q126.mjs",
  "test/v172_q126_local_evidence_reconciliation_intake_guard_test.dart",
  "docs/audit/V172_Q126_LOCAL_EVIDENCE_RECONCILIATION_INTAKE_GUARD_AUDIT_REPORT.md",
  "docs/audit/V172_Q126_LOCAL_EVIDENCE_RECONCILIATION_INTAKE_GUARD_CHANGED_FILES_MANIFEST.md",
  "docs/evidence/V172_Q126_LOCAL_EVIDENCE_RECONCILIATION_INTAKE_GUARD_EVIDENCE_TEMPLATE.json"
];
const requiredMarkers = [
  [
    "lib/features/editor_adapter/local_evidence_reconciliation_intake_guard_v172_q126_policy.dart",
    "phase = 'V172-Q126'"
  ],
  [
    "lib/features/editor_adapter/local_evidence_reconciliation_intake_guard_v172_q126_policy.dart",
    "guardOnly = true"
  ],
  [
    "lib/features/editor_adapter/local_evidence_reconciliation_intake_guard_v172_q126_policy.dart",
    "mathLiveDefaultSwitchImplementedInThisPackage = false"
  ],
  [
    "lib/features/editor_adapter/local_evidence_reconciliation_intake_guard_v172_q126_policy.dart",
    "legacyCursorPhysicalDeletionImplementedInThisPackage = false"
  ],
  [
    "lib/features/editor_adapter/local_evidence_reconciliation_intake_guard_v172_q126_policy.dart",
    "releasePassClaimedInThisPackage = false"
  ],
  [
    "lib/features/editor_adapter/local_evidence_reconciliation_intake_guard_v172_q126_policy.dart",
    "Q126_LOCAL_EVIDENCE_RECONCILIATION_INTAKE_PACKAGE_READY_BUT_USER_EVIDENCE_REQUIRED"
  ],
  [
    "assets/mathlive/manifest.json",
    "\"q126LocalEvidenceReconciliationIntakeGuardPhase\": \"V172-Q126\""
  ],
  [
    "assets/mathlive/manifest.json",
    "\"q126MaySwitchDefaultEditorNow\": false"
  ],
  [
    "assets/mathlive/manifest.json",
    "\"q126MayDeleteLegacyCursor\": false"
  ],
  [
    "assets/mathlive/manifest.json",
    "\"q126MayClaimReleasePass\": false"
  ],
  [
    "lib/logic/mathpro_package_contract.dart",
    "q126LocalEvidenceReconciliationIntakeGuardRule"
  ],
  [
    "README.md",
    "V172-Q126 \u2014 Local Evidence Reconciliation Intake Guard"
  ]
];
const forbiddenEnabledMarkers = [
  "mathLiveDefaultSwitchImplementedInThisPackage = true",
  "mainWorkspaceMountImplementedInThisPackage = true",
  "runtimeGraphHistorySolutionWritesImplementedInThisPackage = true",
  "legacyMainPathRetirementImplementedInThisPackage = true",
  "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
  "physicalCleanupExecutedInThisPackage = true",
  "releasePassClaimedInThisPackage = true",
  "cursorPassClaimedInThisPackage = true",
  "\"q126MaySwitchDefaultEditorNow\": true",
  "\"q126MayDeleteLegacyCursor\": true",
  "\"q126MayClaimReleasePass\": true",
  "\"q126MayClaimCursorPass\": true"
];
function fileExists(rel) { return existsSync(join(root, rel)); }
function read(rel) { try { return readFileSync(join(root, rel), 'utf8'); } catch { return ''; } }
function readJson(rel) { if (!fileExists(rel)) return null; try { return JSON.parse(read(rel)); } catch { return null; } }
function has(rel, marker) { return read(rel).includes(marker); }
function run(script) { if (!fileExists(script)) return { script, exitCode: 127, status: 'MISSING_SCRIPT' }; const r = spawnSync(process.execPath, [script], { cwd: root, encoding: 'utf8' }); return { script, exitCode: r.status ?? 1, stdout: (r.stdout || '').trim(), stderr: (r.stderr || '').trim() }; }
function listFiles(dir) { if (!existsSync(dir)) return []; const out = []; for (const name of readdirSync(dir)) { const p = join(dir, name); const st = statSync(p); if (st.isDirectory()) out.push(...listFiles(p)); else out.push(p.slice(root.length + 1).replaceAll('\\','/')); } return out; }
const previousRun = run(previousScript);
const previousReportPath = previousScript.replace('tool/verify_', 'tool/reports/').replace('.mjs', '_report.json');
const previousReport = readJson(previousReportPath);
const blockers = [];
for (const rel of requiredFiles) if (!fileExists(rel)) blockers.push(`missing required file: ${rel}`);
for (const [rel, marker] of requiredMarkers) if (!has(rel, marker)) blockers.push(`missing marker in ${rel}: ${marker}`);
const combined = [read('assets/mathlive/manifest.json'), read("lib/features/editor_adapter/local_evidence_reconciliation_intake_guard_v172_q126_policy.dart"), read('README.md')].join('\n');
for (const marker of forbiddenEnabledMarkers) if (combined.includes(marker)) blockers.push(`forbidden enabled marker present: ${marker}`);
const protectedSurfacesUnchanged = protectedFiles.every((rel) => fileExists(rel) && !read(rel).includes(phase) && !read(rel).includes("q126LocalEvidenceReconciliationIntakeGuard"));
if (!protectedSurfacesUnchanged) blockers.push('protected surfaces changed or contain this phase marker');
const allFiles = listFiles(root);
const forbiddenArtifacts = allFiles.filter((p) => p.endsWith('.zip') || p.endsWith('.apk') || p.endsWith('.aab') || p.startsWith('build/') || p.startsWith('.dart_tool/') || p.startsWith('.gradle/') || p.startsWith('.idea/') || p.includes('__pycache__/') || p.endsWith('.pyc') || p.endsWith('.tmp'));
if (forbiddenArtifacts.length) blockers.push(`forbidden build/cache/nested release artifacts found: ${forbiddenArtifacts.slice(0,20).join('; ')}`);
const packageReady = blockers.length === 0 && previousRun.exitCode === 0;
const evidenceComplete = false;
const report = { phase, status: packageReady ? expectedStatus : `BLOCKED_${phase}`, packageReady, evidenceComplete, blockers, selectedDefaultEngine: 'legacyFlutterSlotEditor', candidateEngine: 'mathlive', rollbackEngine: 'legacyFlutterSlotEditor', previousRun, previousReportStatus: previousReport?.status ?? null, protectedSurfacesUnchanged, forbiddenArtifacts, invariants: { guardOnly: true, packageSideBatchPhase: true, mathLiveDefaultSwitchImplementedInThisPackage: false, mainWorkspaceMountImplementedInThisPackage: false, runtimeGraphHistorySolutionWritesImplementedInThisPackage: false, legacyMainPathRetirementImplementedInThisPackage: false, legacyCursorPhysicalDeletionImplementedInThisPackage: false, physicalCleanupExecutedInThisPackage: false, releasePassClaimedInThisPackage: false, cursorPassClaimedInThisPackage: false, fakeRuntimeEvidenceAllowed: false, fakeDeviceEvidenceAllowed: false, fakeReleaseEvidenceAllowed: false }, requiredEvidenceBeforeProgress: ['prerequisite evidence complete', 'flutter analyze PASS evidence', 'flutter test PASS evidence', 'MathLive Lab real-device evidence', 'main app real-device evidence', 'explicit human approval'] };
mkdirSync(join(root, 'tool/reports'), { recursive: true });
const outJson = "tool/reports/local_evidence_reconciliation_intake_guard_v172_q126_report.json";
writeFileSync(join(root, outJson), JSON.stringify(report, null, 2) + '\n');
writeFileSync(join(root, outJson.replace('.json', '.md')), `# ${phase} Report\n\nStatus: ${report.status}\n\nPackage ready: ${packageReady}\n\nEvidence complete: false\n\nBlockers:\n${blockers.map((b) => `- ${b}`).join('\n') || '- none'}\n`);
console.log(JSON.stringify(report, null, 2));
process.exit(packageReady ? 0 : 2);
