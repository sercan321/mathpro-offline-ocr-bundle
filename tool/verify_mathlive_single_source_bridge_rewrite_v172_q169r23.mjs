#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_single_source_bridge_rewrite_v172_q169r23.mjs', retiredPhase: 'verify_mathlive_single_source_bridge_rewrite_v172_q169r23', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const dart = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const js = read('assets/mathlive/mathlive_bridge.js');
const policy = read('lib/features/mathlive/mathlive_single_source_bridge_policy.dart');
const manifest = read('assets/mathlive/manifest.json');
const failures = [];
function has(src, needle, label){ if(!src.includes(needle)) failures.push(`missing ${label}: ${needle}`); }
function not(src, needle, label){ if(src.includes(needle)) failures.push(`forbidden ${label}: ${needle}`); }
has(policy, "phase = 'V172-Q169R23'", 'policy phase');
has(policy, "visiblePrefix = 'COURT_SINGLE_SOURCE'", 'single source visible prefix');
has(dart, "import 'mathlive_single_source_bridge_policy.dart';", 'Dart policy import');
has(dart, "singleSourceBridgePhase = 'V172-Q169R23'", 'Dart phase const');
has(dart, 'MathLiveSingleSourceBridgePolicy.shouldConsumeSingleSourceEnvelope(message)', 'Dart consumes single-source envelope before older handlers');
has(dart, '_applyQ169SingleSourceEnvelopeJson', 'Dart applies single-source envelope');
has(dart, 'MathLiveSingleSourceBridgePolicy.visiblePrefix', 'Dart overlay uses single-source prefix');
has(dart, 'if (!_q169CourtOverlayLocked) {\n        _lastDiagnosticSummary = \'Q169 KEY:', 'keyboard tap cannot overwrite locked court overlay');
has(js, "singleSourceBridgePhase: 'V172-Q169R23'", 'JS phase in state/export');
has(js, 'function buildQ169SingleSourceEnvelope', 'JS single-source envelope builder');
has(js, 'q169SingleSourceEnvelope: true', 'JS envelope marker');
has(js, 'const payload = buildQ169SingleSourceEnvelope(report, marker);', 'post path always normalizes payload');
has(js, 'envelope.rootCause = rootCause;', 'JS guarantees root cause');
has(js, 'buildQ169SingleSourceEnvelope: buildQ169SingleSourceEnvelope', 'JS exports builder');
has(manifest, 'v172Q169R23SingleSourceBridgeRewrite', 'manifest envelope');
has(manifest, 'compactPayloadNormalizedIntoCourtFields', 'manifest compact normalization');
if (failures.length) {
  console.error('MATHLIVE_SINGLE_SOURCE_BRIDGE_REWRITE_Q169R23_FAILED');
  for (const f of failures) console.error(' - ' + f);
  process.exit(1);
}
console.log('MATHLIVE_SINGLE_SOURCE_BRIDGE_REWRITE_PACKAGE_READY_BUT_REAL_DEVICE_SINGLE_SOURCE_EVIDENCE_REQUIRED');
