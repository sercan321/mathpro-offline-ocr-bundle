#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_mount_authority_reset_v172_q169r24.mjs', retiredPhase: 'verify_mathlive_mount_authority_reset_v172_q169r24', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const surface = fs.readFileSync('lib/features/mathlive/mathlive_main_editor_surface.dart', 'utf8');
const policy = fs.readFileSync('lib/features/mathlive/mathlive_mount_authority_reset_policy.dart', 'utf8');
const bridge = fs.readFileSync('assets/mathlive/mathlive_bridge.js', 'utf8');
const failures = [];
function must(text, needle, label) {
  if (!text.includes(needle)) failures.push(label || needle);
}
function mustNot(text, needle, label) {
  if (text.includes(needle)) failures.push(label || `forbidden: ${needle}`);
}
must(policy, "phase = 'V172-Q169R24'", 'policy phase');
must(surface, "import 'mathlive_mount_authority_reset_policy.dart';", 'surface imports mount authority policy');
must(surface, "static const String mountAuthorityResetPhase = 'V172-Q169R24';", 'surface phase constant');
must(surface, "String _lastDiagnosticSummary = MathLiveMountAuthorityResetPolicy.initialSummary;", 'initial boot summary');
must(surface, "bool _q169CourtOverlayLocked = true;", 'court overlay locked by default');
must(surface, "bool get isReady => _webViewController != null && _pageLoaded;", 'controller readiness no longer requires mf true');
must(surface, "Future<bool> _ensureQ169MountAuthorityBeforeCommand", 'mount authority guard before command');
must(surface, "_noteQ169MountAuthorityBlocked", 'mount authority blocked diagnostic');
must(surface, "if (!await _ensureQ169MountAuthorityBeforeCommand(label)) return false;", 'sendMathProKey uses mount guard');
must(surface, "if (!_q169CourtOverlayLocked && !_bridgeHasVisibleExpression", 'fallback overlay blocked while court locked');
must(surface, "_q169LastSendState = 'MountGate';", 'tap diagnostic uses MountGate while locked');
must(surface, "Future<bool> _ensureQ169MountAuthorityBeforeCommand", 'mount authority replaces old early bridge gate');
must(bridge, "mountAuthorityResetPhase: 'V172-Q169R24'", 'bridge exposes Q169R24 phase');
if (failures.length) {
  console.error('MATHLIVE_MOUNT_AUTHORITY_RESET_Q169R24_FAILED');
  for (const failure of failures) console.error(' - ' + failure);
  process.exit(1);
}
console.log('MATHLIVE_MOUNT_AUTHORITY_RESET_PACKAGE_READY_BUT_REAL_DEVICE_MOUNT_AUTHORITY_EVIDENCE_REQUIRED');
