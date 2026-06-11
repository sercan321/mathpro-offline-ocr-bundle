#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
function read(rel) {
  return fs.readFileSync(path.join(root, rel), 'utf8');
}
function assertContains(haystack, needle, label) {
  if (!haystack.includes(needle)) {
    console.error(`FAIL: missing ${label}: ${needle}`);
    process.exit(1);
  }
}
function assertNotContains(haystack, needle, label) {
  if (haystack.includes(needle)) {
    console.error(`FAIL: forbidden ${label}: ${needle}`);
    process.exit(1);
  }
}

const appShell = read('lib/app/app_shell.dart');
const policy = read('lib/features/solution/solution_steps_memoization_q382r18_policy.dart');

assertContains(policy, 'solution-steps-memoization-closed-panel-compose-guard', 'Q382R18 policy contract');
assertContains(appShell, '_solutionStepsSnapshotFor(', 'memoized snapshot helper usage');
assertContains(appShell, 'panelOpen: _stepsPanelState.isOpen', 'panel open gate');
assertContains(appShell, 'if (!panelOpen)', 'closed panel compose guard');
assertContains(appShell, 'SolutionStepsSnapshot(', 'closed panel lightweight snapshot');
assertContains(appShell, '_cachedSolutionStepsMemoKey', 'memo key storage');
assertContains(appShell, '_cachedSolutionStepsSnapshot', 'memo snapshot storage');
assertContains(appShell, 'if (_cachedSolutionStepsMemoKey == memoKey && cached != null)', 'memo reuse guard');
assertContains(appShell, 'final snapshot = SolutionStepsComposer.compose(', 'open panel authoritative compose');
assertContains(appShell, 'class _SolutionStepsMemoKey', 'semantic input memo key');
assertContains(appShell, 'selectedActionRequiresSolverHandler', 'unsupported action key coverage');
assertContains(appShell, 'selectedActionSupportedByCurrentEngine', 'supported engine key coverage');

const directComposerCalls = (appShell.match(/SolutionStepsComposer\.compose\(/g) || []).length;
if (directComposerCalls !== 1) {
  console.error(`FAIL: expected exactly one AppShell composer call inside helper, found ${directComposerCalls}`);
  process.exit(1);
}

for (const rel of [
  'assets/mathlive/mathlive_prod_bridge.js',
  'assets/mathlive/main_editor_prod.html',
  'android/app/src/main/AndroidManifest.xml',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/workspace/workspace_panel.dart',
]) {
  const content = read(rel);
  assertNotContains(content, 'q382R13', `${rel} old pan marker`);
  assertNotContains(content, 'q382R14', `${rel} old scrollport marker`);
  assertNotContains(content, 'q382R16', `${rel} old internal pan marker`);
  assertNotContains(content, 'document-capture', `${rel} document capture marker`);
  assertNotContains(content, 'host-scrollport-force', `${rel} forced scrollport marker`);
}

console.log('PASS verify_solution_steps_memoization_v172_q382r18');
