#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { spawnSync } from 'node:child_process';
import { assertQ204R3ProductionContracts, q204r3FullPhase } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';

const root = process.cwd();
const listPath = path.join(root, 'tool/evidence/V172_Q204R3_ACTIVE_VERIFIER_SUITE.json');
if (!fs.existsSync(listPath)) { console.error('Q204R3 verifier suite list missing'); process.exit(1); }
const suite = JSON.parse(fs.readFileSync(listPath, 'utf8'));
const active = suite.activeVerifiers || [];
const retired = suite.retiredHistoricalVerifiers || [];
const failures = [];
const result = assertQ204R3ProductionContracts('Q204R3_VERIFIER_SUITE_HYGIENE');
function runVerifier(rel) {
  const abs = path.join(root, rel);
  if (!fs.existsSync(abs)) { failures.push(`${rel} missing`); return; }
  const p = spawnSync(process.execPath, [rel], { cwd: root, encoding: 'utf8', timeout: 30000 });
  if (p.status !== 0) failures.push(`${rel} exit=${p.status} stdout=${(p.stdout||'').slice(-300)} stderr=${(p.stderr||'').slice(-300)}`);
  return p;
}
for (const rel of active) runVerifier(rel);
for (const rel of retired) {
  const p = runVerifier(rel);
  const out = `${p?.stdout || ''}${p?.stderr || ''}`;
  if (!out.includes('RETIRED_HISTORICAL_VERIFIER_Q204R3_NO_FAKE_FAILURE')) failures.push(`${rel} did not report retired verifier status`);
}
const policyPath = 'lib/features/mathlive/mathlive_real_device_evidence_intake_verifier_suite_hygiene_policy.dart';
const policy = fs.readFileSync(path.join(root, policyPath), 'utf8');
for (const token of [
  "static const String phase = 'V172-Q204R3'",
  'activeVerifierSuiteDeclared = true',
  'retiredVerifierSuiteDeclared = true',
  'obsoleteVerifiersMayProduceFakeFailures = false',
  'productionRuntimeFilesMutated = false',
  'returningResultApiRestored = false',
  'retiredVisibleFallbackOverlayRestored = false',
  'retiredDiagnosticOverlayRestored = false',
  'retiredLegacyMainEditorStateRestored = false',
  'flutterAnalyzePassClaimedByAssistant = false',
  'flutterTestPassClaimedByAssistant = false',
]) { if (!policy.includes(token)) failures.push(`policy missing ${token}`); }
const report = {
  phase: 'V172-Q204R3',
  fullPhase: q204r3FullPhase,
  status: failures.length ? 'FAILED' : 'STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED',
  activeVerifierCount: active.length,
  retiredVerifierCount: retired.length,
  productionContracts: result,
  failures,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
  finalReleasePassClaimed: false,
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_real_device_evidence_intake_verifier_suite_hygiene_v172_q204r3_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(path.join(root, 'tool/reports/mathlive_real_device_evidence_intake_verifier_suite_hygiene_v172_q204r3_report.md'), `# V172-Q204R3 Verifier Suite Hygiene

Status: ${report.status}

Active verifiers: ${active.length}

Retired historical verifiers: ${retired.length}

Flutter/Android PASS claimed: false
`);
if (failures.length) { console.error(JSON.stringify(report, null, 2)); process.exit(1); }
console.log('MATHLIVE_REAL_DEVICE_EVIDENCE_INTAKE_VERIFIER_SUITE_HYGIENE_Q204R3_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
