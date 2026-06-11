#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_compact_bridge_state_readback_v172_q169r16.mjs', retiredPhase: 'verify_mathlive_compact_bridge_state_readback_v172_q169r16', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const js = fs.readFileSync('assets/mathlive/mathlive_bridge.js', 'utf8');
const dart = fs.readFileSync('lib/features/mathlive/mathlive_main_editor_surface.dart', 'utf8');
const policy = fs.readFileSync('lib/features/mathlive/mathlive_compact_bridge_state_readback_policy.dart', 'utf8');
const manifest = fs.readFileSync('assets/mathlive/manifest.json', 'utf8');

const failures = [];
function requireContains(source, needle, label) {
  if (!source.includes(needle)) failures.push(label || needle);
}

requireContains(policy, "phase = 'V172-Q169R16'", 'Q169R16 policy phase');
requireContains(policy, 'compactStateTimeout', 'compact state timeout');
requireContains(dart, "import 'mathlive_compact_bridge_state_readback_policy.dart';", 'Dart imports Q169R16 policy');
requireContains(dart, '_q169R16CompactStateJson', 'Dart compact state readback method');
requireContains(dart, 'getQ169CompactState', 'Dart calls compact JS endpoint');
requireContains(dart, 'q169r16-final-diagnostic-compact-fallback', 'Dart final diagnostic compact fallback');
requireContains(js, "compactBridgeStateReadbackPhase: 'V172-Q169R16'", 'JS bridge phase marker');
requireContains(js, 'function getQ169CompactState(reason)', 'JS compact state endpoint');
requireContains(js, 'getQ169CompactState: getQ169CompactState', 'JS exports compact endpoint');
requireContains(js, 'q169r16-compact-bridge-state-readback', 'JS compact marker');
requireContains(manifest, 'v172Q169R16CompactBridgeStateReadback', 'manifest Q169R16 envelope');
requireContains(manifest, 'getQ169CompactState', 'manifest compact endpoint');

if (failures.length) {
  console.error('MATHLIVE_COMPACT_BRIDGE_STATE_READBACK_Q169R16_FAILED');
  for (const failure of failures) console.error(` - ${failure}`);
  process.exit(1);
}

console.log('MATHLIVE_COMPACT_BRIDGE_STATE_READBACK_PACKAGE_READY_BUT_REAL_DEVICE_PAINT_EVIDENCE_REQUIRED');
