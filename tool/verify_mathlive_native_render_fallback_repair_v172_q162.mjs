#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_native_render_fallback_repair_v172_q162.mjs', retiredPhase: 'verify_mathlive_native_render_fallback_repair_v172_q162', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const required = [
  ['lib/features/mathlive/mathlive_native_render_fallback_repair_policy.dart', 'phase = \'V172-Q162\''],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', "nativeRenderFallbackRepairPhase = 'V172-Q162'"],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', 'data-q159-visible-command-fallback'],
  ['lib/features/mathlive/mathlive_main_editor_surface.dart', 'data-q162-sanitized-fallback'],
  ['assets/mathlive/mathlive_bridge.js', "nativeRenderFallbackRepairPhase: 'V172-Q162'"],
  ['assets/mathlive/mathlive_bridge.js', 'q162-sanitized-structural-fallback-no-mathfield'],
  ['assets/mathlive/mathlive_bridge.js', 'q157-js-visible-fallback-no-mathfield'],
  ['assets/mathlive/mathlive_bridge.js', 'visibleFallbackTextFromLatex'],
  ['test/v172_q162_mathlive_native_render_fallback_repair_test.dart', 'V172-Q162'],
];

const failures = [];
for (const [file, needle] of required) {
  if (!fs.existsSync(file)) {
    failures.push(`missing ${file}`);
    continue;
  }
  const text = fs.readFileSync(file, 'utf8');
  if (!text.includes(needle)) failures.push(`${file} missing ${needle}`);
}

const surface = fs.readFileSync('lib/features/mathlive/mathlive_main_editor_surface.dart', 'utf8');
if (surface.includes('class _VisibleMathLiveInputMirror') || surface.includes('Math.tex(')) {
  failures.push('Q160 Flutter visible mirror was revived');
}

if (failures.length) {
  console.error('BLOCKED_MATHLIVE_NATIVE_RENDER_FALLBACK_REPAIR');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_NATIVE_RENDER_FALLBACK_REPAIR_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED');
