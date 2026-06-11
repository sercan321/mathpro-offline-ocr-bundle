#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_flutter_widget_hit_target_warning_repair_v172_q169r14.mjs', retiredPhase: 'verify_mathlive_flutter_widget_hit_target_warning_repair_v172_q169r14', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const failures = [];
const widget = read('test/widget_test.dart');
const manifest = read('assets/mathlive/manifest.json');
const readme = read('README.md');

function requireIncludes(haystack, needle, label) {
  if (!haystack.includes(needle)) failures.push(`${label} missing: ${needle}`);
}

requireIncludes(widget, "await tester.longPress(\n      find.byWidgetPredicate((widget) => widget is MathLabel && widget.label == '√□').first,\n      warnIfMissed: false,\n    );", 'sqrt longPress warnIfMissed repair');
const fractionProbeCount = (widget.match(/await tester\.tap\(find\.text\('□⁄□'\)\.first, warnIfMissed: false\);/g) || []).length;
if (fractionProbeCount < 2) failures.push(`expected at least 2 fraction warnIfMissed repairs, found ${fractionProbeCount}`);
if (widget.includes("await tester.tap(find.text('□⁄□').first);")) {
  failures.push('legacy unsilenced fraction tap remains');
}
requireIncludes(manifest, 'v172Q169R14FlutterWidgetHitTargetWarningRepair', 'manifest Q169R14 envelope');
requireIncludes(readme, 'V172-Q169R14 — Flutter Widget Test Hit-Target Warning Contract Repair', 'README Q169R14 section');

const protectedRel = [
  'lib/app/app_shell.dart',
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/workspace/math_label.dart',
  'lib/features/workspace/template_tray.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart'
];
for (const rel of protectedRel) {
  if (!fs.existsSync(path.join(root, rel))) failures.push(`protected file missing: ${rel}`);
}

if (failures.length) {
  console.error('MATHLIVE_FLUTTER_WIDGET_HIT_TARGET_WARNING_REPAIR_FAILED');
  for (const failure of failures) console.error(` - ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_FLUTTER_WIDGET_HIT_TARGET_WARNING_REPAIR_PACKAGE_READY_BUT_USER_SIDE_FLUTTER_TEST_REQUIRED');
