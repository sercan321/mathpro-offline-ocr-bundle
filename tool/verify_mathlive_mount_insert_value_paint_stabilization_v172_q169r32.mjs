#!/usr/bin/env node
import { existsSync, readFileSync } from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_mount_insert_value_paint_stabilization_v172_q169r32.mjs', retiredPhase: 'verify_mathlive_mount_insert_value_paint_stabilization_v172_q169r32', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const checks = [];
const has = (file, needle, label = `${file} contains ${needle}`) => {
  const ok = existsSync(file) && readFileSync(file, 'utf8').includes(needle);
  checks.push({ ok, label });
};
const fileExists = (file, label = `${file} exists`) => checks.push({ ok: existsSync(file), label });

fileExists('lib/features/mathlive/mathlive_mount_insert_value_paint_stabilization_policy.dart', 'Q169R32 policy file exists');
has('lib/features/mathlive/mathlive_mount_insert_value_paint_stabilization_policy.dart', "phase = 'V172-Q169R32'", 'Q169R32 policy phase exists');
has('lib/features/mathlive/mathlive_mount_insert_value_paint_stabilization_policy.dart', 'q170PremiumPolishAllowed = false', 'Q169R32 blocks Q170 polish without device evidence');
has('lib/features/mathlive/mathlive_mount_insert_value_paint_stabilization_policy.dart', 'realDevicePaintPassClaimed = false', 'Q169R32 makes no real-device PAINT claim');
has('lib/features/mathlive/mathlive_mount_insert_value_paint_stabilization_policy.dart', 'keyboardLayoutMutationAllowed = false', 'Q169R32 does not mutate keyboard');
has('lib/features/mathlive/mathlive_mount_insert_value_paint_stabilization_policy.dart', 'appShellMutationAllowed = false', 'Q169R32 does not mutate AppShell');

has('assets/mathlive/mathlive_bridge.js', "mountInsertValuePaintStabilizationPhase: 'V172-Q169R32'", 'bridge exposes Q169R32 phase');
has('assets/mathlive/mathlive_bridge.js', 'q169R32ScheduleBootStabilization', 'bridge schedules repeated boot stabilization');
has('assets/mathlive/mathlive_bridge.js', 'q169R32EnsureNativeReadyForCommand', 'bridge preflights native readiness before commands');
has('assets/mathlive/mathlive_bridge.js', 'q169R32RunBootStabilizationPass', 'bridge exposes a boot stabilization pass');
has('assets/mathlive/mathlive_bridge.js', "window.customElements.whenDefined('math-field')", 'bridge hooks customElements.whenDefined for delayed MathLive registration');
has('assets/mathlive/mathlive_bridge.js', "q169r32-before-insert-latex", 'insert path is routed through Q169R32 native readiness');
has('assets/mathlive/mathlive_bridge.js', "q169r32-before-execute-command-", 'execute path is routed through Q169R32 native readiness');
has('assets/mathlive/mathlive_bridge.js', "runQ169FinalSelfTestCourtAndPush(marker + '-final-court-'", 'mounted boot stabilization runs final court push');

has('assets/mathlive/main_editor.html', 'window.MathProMountInsertValuePaintStabilization', 'HTML declares Q169R32 boot stabilization contract');
has('assets/mathlive/main_editor.html', 'data-q169r32-mount-insert-value-paint-stabilization="true"', 'HTML host records Q169R32 marker');

has('lib/features/mathlive/mathlive_main_editor_surface.dart', "import 'mathlive_mount_insert_value_paint_stabilization_policy.dart';", 'surface imports Q169R32 policy');
has('lib/features/mathlive/mathlive_main_editor_surface.dart', 'mountInsertValuePaintStabilizationPhase = MathLiveMountInsertValuePaintStabilizationPolicy.phase', 'surface exposes Q169R32 phase');
has('lib/features/mathlive/mathlive_main_editor_surface.dart', '_q169R32StabilizeBootStateJson', 'surface can request Q169R32 boot stabilization state');
has('lib/features/mathlive/mathlive_main_editor_surface.dart', "q169r32-before-command-", 'surface stabilizes boot before command dispatch');
has('lib/features/mathlive/mathlive_main_editor_surface.dart', 'q169-runtime-mounted-retry-flush q169r32-mounted-command-flush', 'surface flushes queued commands after Q169R32 mount');

has('assets/mathlive/manifest.json', 'v172Q169R32MountInsertValuePaintStabilization', 'manifest records Q169R32');
has('test/v172_q169r32_mount_insert_value_paint_stabilization_test.dart', 'V172-Q169R32 stabilizes mount/insert/value/paint', 'Q169R32 Flutter static test exists');

const failed = checks.filter((c) => !c.ok);
if (failed.length) {
  console.error('MATHLIVE_MOUNT_INSERT_VALUE_PAINT_STABILIZATION_Q169R32_FAILED');
  for (const item of failed) console.error(`- ${item.label}`);
  process.exit(1);
}
console.log('MATHLIVE_MOUNT_INSERT_VALUE_PAINT_STABILIZATION_PACKAGE_READY_BUT_REAL_DEVICE_COURT_EVIDENCE_REQUIRED');
