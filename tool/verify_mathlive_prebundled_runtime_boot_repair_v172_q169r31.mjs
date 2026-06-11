#!/usr/bin/env node
import { existsSync, readFileSync, statSync } from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_prebundled_runtime_boot_repair_v172_q169r31.mjs', retiredPhase: 'verify_mathlive_prebundled_runtime_boot_repair_v172_q169r31', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const checks = [];
const has = (file, needle, label = `${file} contains ${needle}`) => {
  const ok = existsSync(file) && readFileSync(file, 'utf8').includes(needle);
  checks.push({ ok, label });
};
const fileExists = (file, label = `${file} exists`) => {
  checks.push({ ok: existsSync(file), label });
};
const fileMinSize = (file, min, label = `${file} has at least ${min} bytes`) => {
  const ok = existsSync(file) && statSync(file).size >= min;
  checks.push({ ok, label });
};

has('lib/features/mathlive/mathlive_prebundled_runtime_boot_repair_policy.dart', "phase = 'V172-Q169R31'", 'Q169R31 policy phase exists');
has('lib/features/mathlive/mathlive_prebundled_runtime_boot_repair_policy.dart', 'officialRuntimeBootstrapAssetsIncluded = true', 'Q169R31 records prebundled runtime bootstrap assets');
has('lib/features/mathlive/mathlive_prebundled_runtime_boot_repair_policy.dart', 'keyboardLayoutMutationAllowed = false', 'Q169R31 does not mutate keyboard');
has('lib/features/mathlive/mathlive_prebundled_runtime_boot_repair_policy.dart', 'appShellMutationAllowed = false', 'Q169R31 does not mutate AppShell');
has('lib/features/mathlive/mathlive_prebundled_runtime_boot_repair_policy.dart', 'realDevicePaintPassClaimed = false', 'Q169R31 makes no PAINT:ok claim');

fileExists('assets/mathlive/vendor/mathlive/mathlive.min.js', 'official MathLive JS is present before Flutter build time');
fileMinSize('assets/mathlive/vendor/mathlive/mathlive.min.js', 1024, 'official MathLive JS is non-placeholder');
fileExists('assets/mathlive/vendor/mathlive/mathlive-static.css', 'official MathLive static CSS is present');
fileExists('assets/mathlive/vendor/mathlive/mathlive-fonts.css', 'official MathLive fonts CSS is present');
fileExists('assets/mathlive/vendor/mathlive/LICENSE.txt', 'official MathLive license is present');
fileExists('assets/mathlive/vendor/mathlive/package.json', 'official MathLive package metadata is present');
fileExists('assets/mathlive/vendor/mathlive/runtime_manifest.json', 'official MathLive runtime manifest is present');

has('assets/mathlive/main_editor.html', 'vendor/mathlive/mathlive-static.css', 'main editor references official static CSS');
has('assets/mathlive/main_editor.html', "window.MathProPrebundledRuntimeBootRepair", 'main editor records Q169R31 boot repair probe');
has('assets/mathlive/main_editor.html', 'data-q169r31-runtime-prebundled="true"', 'main editor host records runtime prebundle marker');
has('assets/mathlive/main_editor.html', 'vendor/mathlive/mathlive.min.js', 'main editor references local official MathLive JS');

has('assets/mathlive/mathlive_bridge.js', "prebundledRuntimeBootRepairPhase: 'V172-Q169R31'", 'bridge exposes Q169R31 phase');
has('assets/mathlive/mathlive_bridge.js', 'q169R31AttemptRuntimeScriptRecovery', 'bridge has local-only runtime recovery loader');
has('assets/mathlive/mathlive_bridge.js', "script.src = 'vendor/mathlive/mathlive.min.js'", 'bridge recovery loader uses local vendor script');
has('assets/mathlive/mathlive_bridge.js', 'q169r31-runtime-recovery-onload', 'bridge retries mount after runtime recovery onload');
has('assets/mathlive/mathlive_bridge.js', 'q169r31-runtime-script-asset-load-failed', 'bridge reports local asset load failure explicitly');

has('lib/features/mathlive/mathlive_main_editor_surface.dart', "import 'mathlive_prebundled_runtime_boot_repair_policy.dart';", 'surface imports Q169R31 policy');
has('lib/features/mathlive/mathlive_main_editor_surface.dart', 'prebundledRuntimeBootRepairPhase = MathLivePrebundledRuntimeBootRepairPolicy.phase', 'surface exposes Q169R31 phase');
has('assets/mathlive/manifest.json', 'v172Q169R31PrebundledRuntimeBootRepair', 'manifest records Q169R31');
has('test/v172_q169r31_prebundled_runtime_boot_repair_test.dart', 'V172-Q169R31 prebundles runtime bootstrap', 'Flutter static test exists');

const failed = checks.filter((c) => !c.ok);
if (failed.length) {
  console.error('MATHLIVE_PREBUNDLED_RUNTIME_BOOT_REPAIR_Q169R31_FAILED');
  for (const item of failed) console.error(`- ${item.label}`);
  process.exit(1);
}
console.log('MATHLIVE_PREBUNDLED_RUNTIME_BOOT_REPAIR_PACKAGE_READY_BUT_REAL_DEVICE_MOUNT_INSERT_VALUE_PAINT_EVIDENCE_REQUIRED');
