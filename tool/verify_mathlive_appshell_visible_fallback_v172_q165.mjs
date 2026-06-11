#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_appshell_visible_fallback_v172_q165.mjs', retiredPhase: 'verify_mathlive_appshell_visible_fallback_v172_q165', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const surface = fs.readFileSync('lib/features/mathlive/mathlive_main_editor_surface.dart', 'utf8');
const shell = fs.readFileSync('lib/app/app_shell.dart', 'utf8');
const policy = fs.readFileSync('lib/features/mathlive/mathlive_appshell_visible_fallback_policy.dart', 'utf8');
const manifest = fs.readFileSync('assets/mathlive/manifest.json', 'utf8');

const required = [
  ['surface phase', surface.includes("appShellVisibleFallbackPhase = 'V172-Q165'") || surface.includes("static const String appShellVisibleFallbackPhase = 'V172-Q165'")],
  ['visible fallback overlay', surface.includes('mathpro-q165-appshell-visible-fallback-overlay')],
  ['keyboard tap diagnostic', surface.includes('Q165 KEY:')],
  ['raw token cleanup', surface.includes("replaceAll('#0', '□')") && surface.includes("replaceAll('#?', '□')") && surface.includes("replaceAll('#@', '□')")],
  ['app shell fallback method', shell.includes('_syncMathLiveVisibleFallbackForRealDevice')],
  ['app shell mark tap', shell.includes('markKeyboardTap(label)') || shell.includes('markKeyboardTap(label, visibleLatex: visibleFallbackLatex)')],
  ['document latex sanitize', shell.includes('documentLatexFromInsertPayload')],
  ['policy exists', policy.includes("phase = 'V172-Q165'")],
  ['manifest envelope', manifest.includes('v172Q165AppShellVisibleFallback')],
];
const failed = required.filter(([, pass]) => !pass).map(([name]) => name);
if (failed.length) {
  console.error('MATHLIVE_APPSHELL_VISIBLE_FALLBACK_Q165_FAILED');
  for (const name of failed) console.error(` - ${name}`);
  process.exit(1);
}
console.log('MATHLIVE_APPSHELL_VISIBLE_FALLBACK_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED');
process.exit(0);
