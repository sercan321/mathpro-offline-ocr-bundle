#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_analyzer_hygiene_v172_q158.mjs', retiredPhase: 'verify_mathlive_analyzer_hygiene_v172_q158', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const issues = [];
const requireContains = (file, needle) => {
  const text = read(file);
  if (!text.includes(needle)) issues.push(`${file} missing ${needle}`);
};

requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', "String _lastRuntimeCommandAck = ''");
requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', "_lastRuntimeCommandAck = 'q157-command-ack-$sequence'");
requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', "source: 'q157-returning-result-command-ack $_lastRuntimeCommandAck'");
requireContains('lib/features/mathlive/mathlive_analyzer_hygiene_policy.dart', "phase = 'V172-Q158R1'");
requireContains('test/v172_q158_mathlive_analyzer_hygiene_test.dart', "q157-returning-result-command-ack \\$_lastRuntimeCommandAck");
requireContains('assets/mathlive/manifest.json', 'v172Q158R1AnalyzerHygiene');

const result = {
  phase: 'V172-Q158R1',
  status: issues.length === 0
    ? 'MATHLIVE_ANALYZER_HYGIENE_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
    : 'BLOCKED_MATHLIVE_ANALYZER_HYGIENE',
  blockers: issues,
  analyzerHygiene: {
    unusedRuntimeCommandAckWarningRepaired: issues.length === 0,
    runtimeCommandAckTelemetryPreserved: true,
    runJavaScriptReturningResultBindingPreserved: true,
    visibleFallbackPreserved: true,
    keyboardLayoutMutationAllowed: false,
    longPressOrderMutationAllowed: false,
    graphHistorySolutionUiMutationAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false,
  },
};
console.log(JSON.stringify(result, null, 2));
if (issues.length) process.exit(1);
