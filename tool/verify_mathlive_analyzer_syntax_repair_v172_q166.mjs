#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_analyzer_syntax_repair_v172_q166.mjs', retiredPhase: 'verify_mathlive_analyzer_syntax_repair_v172_q166', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const surface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const appShell = read('lib/app/app_shell.dart');
const policy = read('lib/features/mathlive/mathlive_analyzer_syntax_repair_policy.dart');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));

const failures = [];
const requireContains = (name, content, needle) => {
  if (!content.includes(needle)) failures.push(`${name} missing ${needle}`);
};

requireContains('policy', policy, "phase = 'V172-Q166'");
requireContains('surface', surface, "value = value.replaceAll('\\n', ' ');");
requireContains('surface', surface, "value = value.replaceAll(r'\\textstyle', '');");
requireContains('surface', surface, "value = value.replaceAll(r'\\times', '×');");
requireContains('surface', surface, "value = value.replaceAll(r'\\to', '→');");
requireContains('surface', surface, "appShellVisibleFallbackPhase = 'V172-Q165'");
requireContains('app_shell', appShell, '_syncMathLiveVisibleFallbackForRealDevice(label, command);');
requireContains('app_shell', appShell, '_syncMathLiveSimpleKeyFallbackForTests(label, command);');
requireContains('app_shell', appShell, 'if (current.endsWith(command.latex)) return;');
requireContains('app_shell', appShell, "source: 'V172-Q153-mathlive-simple-key-test-fallback'");

if (!manifest.v172Q166AnalyzerSyntaxRepair) {
  failures.push('manifest missing v172Q166AnalyzerSyntaxRepair');
} else {
  const q = manifest.v172Q166AnalyzerSyntaxRepair;
  if (q.phase !== 'V172-Q166') failures.push('manifest Q166 phase mismatch');
  if (q.malformedPrettyExpressionStringLiteralRepaired !== true) failures.push('manifest Q166 syntax repair not true');
  if (q.q165VisibleFallbackPreserved !== true) failures.push('manifest Q165 fallback preservation not true');
  if (q.realDevicePassClaimed !== false) failures.push('manifest must not claim real device PASS');
}

if (failures.length) {
  console.error('BLOCKED_MATHLIVE_ANALYZER_SYNTAX_REPAIR');
  for (const f of failures) console.error(`- ${f}`);
  process.exit(1);
}

console.log('MATHLIVE_ANALYZER_SYNTAX_REPAIR_PACKAGE_READY_BUT_USER_SIDE_FLUTTER_REQUIRED');
