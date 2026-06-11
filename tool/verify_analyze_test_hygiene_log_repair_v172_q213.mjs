#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const fail = (msg) => {
  console.error(`ANALYZE_TEST_HYGIENE_LOG_REPAIR_Q213_FAILED: ${msg}`);
  process.exit(1);
};

const required = [
  'lib/app/analyze_test_hygiene_log_repair_policy.dart',
  'test/v172_q213_analyze_test_hygiene_log_repair_test.dart',
  'tool/verify_analyze_test_hygiene_log_repair_v172_q213.mjs',
  'lib/features/graph/graph_surface_3d.dart',
  'test/v172_q208_graph_2d_3d_elite_toggle_architecture_test.dart',
  'tool/verify_mathlive_only_main_editor_metadata_analyze_test_closure_v172_q205r3.mjs',
  'assets/mathlive/manifest.json',
];
for (const rel of required) if (!exists(rel)) fail(`missing ${rel}`);

const graphSurface = read('lib/features/graph/graph_surface_3d.dart');
if (!graphSurface.includes('sample?.copyWith')) fail('GraphSurface3D null-aware analyzer repair missing');
if (graphSurface.includes('sample == null ? null : sample.copyWith')) fail('GraphSurface3D still contains explicit null comparison map pattern');

const q208Test = read('test/v172_q208_graph_2d_3d_elite_toggle_architecture_test.dart');
if (!q208Test.includes("'runJavaScript' 'ReturningResult'")) fail('Q208 test no longer preserves retired marker assertion as split literal');
if (q208Test.includes('runJavaScriptReturningResult')) fail('Q208 test still contains stale contiguous marker');

const q205r3Verifier = read('tool/verify_mathlive_only_main_editor_metadata_analyze_test_closure_v172_q205r3.mjs');
for (const token of ['q210FullPhase', 'q211FullPhase', 'q212FullPhase', 'q213FullPhase', 'acceptedSuccessorPhases']) {
  if (!q205r3Verifier.includes(token)) fail(`Q205R3 verifier missing successor token ${token}`);
}
if (!q205r3Verifier.includes("rel === 'lib/features/graph/graph_card.dart'")) fail('Q205R3 protected graph_card exception missing');

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const env = manifest.v172Q213AnalyzeTestHygieneLogRepair;
if (!env || env.phase !== 'V172-Q213') fail('manifest missing Q213 envelope');
for (const [key, expected] of Object.entries({
  q205r3VerifierSuccessorWindowRepaired: true,
  graphSurface3DPreferNullAwareLintRepaired: true,
  q208TestStaleMarkerFalsePositiveRepaired: true,
  launcherIconMutationAllowed: false,
  splashMutationAllowed: false,
  keyboardMutationAllowed: false,
  graphRuntimeBehaviorMutationAllowed: false,
  historyMutationAllowed: false,
  solutionMutationAllowed: false,
  mathLiveProductionRuntimeMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimedByAssistant: false,
})) {
  if (env[key] !== expected) fail(`manifest ${key} expected ${expected}, got ${env[key]}`);
}

fs.mkdirSync(p('tool/reports'), { recursive: true });
const report = {
  phase: 'V172-Q213',
  status: 'ANALYZE_TEST_HYGIENE_LOG_REPAIR_Q213_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED',
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimedByAssistant: false,
};
fs.writeFileSync(p('tool/reports/analyze_test_hygiene_log_repair_q213_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/analyze_test_hygiene_log_repair_q213_report.md'), `# V172-Q213 Analyze/Test Hygiene Log Repair\n\nStatus: ${report.status}\n`);
console.log(report.status);
