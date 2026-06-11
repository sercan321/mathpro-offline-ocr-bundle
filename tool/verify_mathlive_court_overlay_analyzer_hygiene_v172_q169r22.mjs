#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_court_overlay_analyzer_hygiene_v172_q169r22.mjs', retiredPhase: 'verify_mathlive_court_overlay_analyzer_hygiene_v172_q169r22', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const root = process.cwd();
const surfacePath = path.join(root, 'lib/features/mathlive/mathlive_main_editor_surface.dart');
const policyPath = path.join(root, 'lib/features/mathlive/mathlive_court_overlay_analyzer_hygiene_policy.dart');
const manifestPath = path.join(root, 'assets/mathlive/manifest.json');
const surface = fs.readFileSync(surfacePath, 'utf8');
const policy = fs.readFileSync(policyPath, 'utf8');
const manifest = fs.readFileSync(manifestPath, 'utf8');
const failures = [];
function requireContains(source, needle, label) {
  if (!source.includes(needle)) failures.push(`${label} missing: ${needle}`);
}
function requireNotContains(source, needle, label) {
  if (source.includes(needle)) failures.push(`${label} forbidden: ${needle}`);
}
requireContains(policy, "phase = 'V172-Q169R22'", 'Q169R22 policy phase');
requireContains(policy, "analyzerDiagnostic = 'unnecessary_this'", 'Q169R22 analyzer diagnostic marker');
requireContains(surface, 'if (_q169CourtOverlayLocked && mounted) {', 'analyzer-clean mounted guard');
requireContains(surface, 'final runtimeMountedFromSnapshot = snapshot.runtime.contains', 'runtime mount local remains renamed');
requireContains(surface, 'if (runtimeMountedFromSnapshot != _runtimeMounted || _runtimeBlocked) {', 'runtime mount comparison remains renamed');
requireNotContains(surface, 'if (_q169CourtOverlayLocked && this.mounted) {', 'unnecessary this mounted guard');
requireNotContains(surface, 'final mounted = snapshot.runtime.contains', 'local mounted shadow');
requireContains(surface, 'COURT_RAW:compact CHANNEL:ok ROOT:compact-state-received-awaiting-court-result', 'Q169R20 compact court overlay marker preserved');
requireContains(manifest, 'v172Q169R22CourtOverlayAnalyzerHygiene', 'manifest Q169R22 envelope');
requireContains(manifest, 'unnecessary_this', 'manifest analyzer diagnostic');
if (failures.length) {
  console.error('MATHLIVE_COURT_OVERLAY_ANALYZER_HYGIENE_Q169R22_FAILED');
  for (const failure of failures) console.error(` - ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_COURT_OVERLAY_ANALYZER_HYGIENE_PACKAGE_READY_BUT_USER_SIDE_FLUTTER_ANALYZE_REQUIRED');
