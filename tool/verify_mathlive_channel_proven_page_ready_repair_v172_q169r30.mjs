#!/usr/bin/env node
import { readFileSync, existsSync } from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_channel_proven_page_ready_repair_v172_q169r30.mjs', retiredPhase: 'verify_mathlive_channel_proven_page_ready_repair_v172_q169r30', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const checks = [];
const has = (file, needle, label = `${file} contains ${needle}`) => {
  const ok = existsSync(file) && readFileSync(file, 'utf8').includes(needle);
  checks.push({ ok, label });
};

has('lib/features/mathlive/mathlive_channel_proven_page_ready_repair_policy.dart', "phase = 'V172-Q169R30'", 'Q169R30 policy phase exists');
has('lib/features/mathlive/mathlive_channel_proven_page_ready_repair_policy.dart', 'WEBVIEW:ok PAGE:pending RUNTIME:pending MF:missing CHANNEL:court-visible', 'Q169R30 real-device evidence is recorded');
has('lib/features/mathlive/mathlive_channel_proven_page_ready_repair_policy.dart', 'keyboardLayoutMutationAllowed = false', 'Q169R30 does not mutate keyboard layout');
has('lib/features/mathlive/mathlive_channel_proven_page_ready_repair_policy.dart', 'appShellMutationAllowed = false', 'Q169R30 does not mutate AppShell');
has('lib/features/mathlive/mathlive_channel_proven_page_ready_repair_policy.dart', 'realDevicePaintPassClaimed = false', 'Q169R30 makes no paint PASS claim');

has('lib/features/mathlive/mathlive_main_editor_surface.dart', "import 'mathlive_channel_proven_page_ready_repair_policy.dart';", 'surface imports Q169R30 policy');
has('lib/features/mathlive/mathlive_main_editor_surface.dart', 'channelProvenPageReadyRepairPhase = MathLiveChannelProvenPageReadyRepairPolicy.phase', 'surface exposes Q169R30 phase');
has('lib/features/mathlive/mathlive_main_editor_surface.dart', 'bool _q169R30PageReadyRecoveredFromBridge = false;', 'surface tracks channel-proven page recovery');
has('lib/features/mathlive/mathlive_main_editor_surface.dart', '_markQ169R30PageReadyFromBridge(source);', 'bridge channel messages mark page ready');
has('lib/features/mathlive/mathlive_main_editor_surface.dart', 'pageLoaded: true', 'stale PAGE:pending is lifted after bridge proof');
has('lib/features/mathlive/mathlive_main_editor_surface.dart', 'channelProvenQueueFlushReason', 'queued keys are flushed after channel-proven page readiness');
has('lib/features/mathlive/mathlive_main_editor_surface.dart', '_q169FinalCourtResultVisible ||', 'isReady / mount probing accepts court-visible page proof');

has('assets/mathlive/manifest.json', 'v172Q169R30ChannelProvenPageReadyRepair', 'manifest records Q169R30');
has('assets/mathlive/manifest.json', 'Any MathPro JS channel message proves the page and bridge are alive', 'manifest records page authority rule');
has('test/v172_q169r30_channel_proven_page_ready_repair_test.dart', 'V172-Q169R30 recovers stale PAGE:pending', 'Flutter static test exists');

const failed = checks.filter((c) => !c.ok);
if (failed.length) {
  console.error('MATHLIVE_CHANNEL_PROVEN_PAGE_READY_REPAIR_Q169R30_FAILED');
  for (const item of failed) console.error(`- ${item.label}`);
  process.exit(1);
}
console.log('MATHLIVE_CHANNEL_PROVEN_PAGE_READY_REPAIR_Q169R30_PACKAGE_READY_BUT_REAL_DEVICE_EVIDENCE_REQUIRED');
