#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const fail = (msg) => { console.error(`[FAIL] ${msg}`); process.exit(1); };
const must = (text, needle, label) => { if (!text.includes(needle)) fail(`missing ${label}: ${needle}`); };
const mustNot = (text, needle, label) => { if (text.includes(needle)) fail(`forbidden ${label}: ${needle}`); };

for (const rel of [
  'lib/debug/latency/mathpro_latency_probe_q382r23.dart',
  'lib/debug/latency/mathpro_latency_overlay_q382r23.dart',
  'tool/verify_real_device_latency_instrumentation_v172_q382r23.mjs',
  'docs/audit/V172_Q382R23_REAL_DEVICE_LATENCY_INSTRUMENTATION_AUDIT_REPORT.md',
  'docs/audit/V172_Q382R23_CHANGED_FILES.md',
]) {
  if (!exists(rel)) fail(`expected file missing: ${rel}`);
}

const probe = read('lib/debug/latency/mathpro_latency_probe_q382r23.dart');
const overlay = read('lib/debug/latency/mathpro_latency_overlay_q382r23.dart');
const premiumKey = read('lib/features/keyboard/premium_key.dart');
const appShell = read('lib/app/app_shell.dart');
const mainSurface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const productionSurface = read('lib/features/mathlive/mathlive_production_editor_surface.dart');
const bridge = read('assets/mathlive/mathlive_prod_bridge.js');

must(probe, "static const String phase = 'V172-Q382R23'", 'Q382R23 phase');
must(probe, 'q382r23-real-device-latency-instrumentation-active', 'Q382R23 contract marker');
must(probe, 'static const bool debugOnly = true', 'debug-only policy');
must(probe, 'static const bool releaseOverlayAllowed = false', 'release overlay blocked');
must(probe, 'static const bool performanceOptimizationAllowed = false', 'no optimization policy');
must(probe, 'recordPremiumKeyTapDown', 'T0 recorder');
must(probe, 'recordPremiumKeyTap', 'T1 recorder');
must(probe, 'recordDartCommandScheduled', 'T2 recorder');
must(probe, 'recordFlutterStateReceivedFromJs', 'T7 recorder');
must(probe, 'recordAppShellStateHandled', 'T8 recorder');
must(probe, '[Q382R23_LATENCY]', 'terminal latency log marker');
if (/(^|[^A-Za-z0-9_.])String\s*\(/m.test(probe)) fail('undefined Dart String constructor regression found in probe');
mustNot(overlay, "import 'dart:ui'", 'unnecessary dart:ui overlay import regression');

must(overlay, 'class MathProLatencyOverlayQ382R23', 'debug overlay widget');
must(overlay, 'if (!kDebugMode', 'overlay debug guard');
must(overlay, 'LATENCY Q382R23', 'overlay label');
must(overlay, 'TOTAL', 'overlay total row');
must(overlay, 'IgnorePointer', 'overlay must not intercept touches');

must(premiumKey, "import '../../debug/latency/mathpro_latency_probe_q382r23.dart';", 'PremiumKey probe import');
must(premiumKey, 'recordPremiumKeyTapDown(widget.label)', 'PremiumKey T0 hook inside pressed feedback path');
must(appShell, 'recordPremiumKeyTap(label)', 'AppShell T1 hook at key callback');
must(premiumKey, 'onTap: _handleTap', 'onTap dispatch preserved');
mustNot(premiumKey, 'recordDartCommandScheduled', 'PremiumKey must not dispatch commands');

must(appShell, "import '../debug/latency/mathpro_latency_overlay_q382r23.dart';", 'AppShell overlay import');
must(appShell, "import '../debug/latency/mathpro_latency_probe_q382r23.dart';", 'AppShell probe import');
must(appShell, 'const MathProLatencyOverlayQ382R23()', 'AppShell overlay mounted');
must(appShell, 'recordAppShellStateHandled', 'AppShell T8 hook');
must(appShell, 'BottomDock(', 'keyboard dock preserved');
must(appShell, 'onKeyPressed: _handleKeyPressed', 'keyboard dispatch callback preserved');

must(mainSurface, "import '../../debug/latency/mathpro_latency_probe_q382r23.dart';", 'MathLive probe import');
must(productionSurface, 'recordDartCommandScheduled', 'T2 hook in production surface');
must(productionSurface, 'recordFlutterStateReceivedFromJs(message)', 'T7 hook in production surface');
must(productionSurface, '_productionCommandTail', 'serial command tail preserved');
must(productionSurface, 'MathLiveRuntimePayloadSlimmingQ382R22Policy.maximumRuntimePayloadFieldCount >= 5', 'Q382R22 payload budget preserved');

must(bridge, "const REAL_DEVICE_LATENCY_INSTRUMENTATION_PHASE = 'V172-Q382R23'", 'JS Q382R23 phase');
must(bridge, 'q382r23LatencyInstrumentationActive: true', 'JS Q382R23 active marker');
must(bridge, 'q382r23LastLatency', 'JS latency state');
must(bridge, 'function q382r23NewLatencySpan(action, payload)', 'JS T3 helper');
must(bridge, 'function q382r23MarkLatency(fieldName)', 'JS mark helper');
must(bridge, "q382r23MarkLatency('t4MathLiveInsertStartEpochMs')", 'JS T4 hook');
must(bridge, "q382r23MarkLatency('t5MathLiveInsertEndEpochMs')", 'JS T5 hook');
must(bridge, "q382r23MarkLatency('t6JsStatePostEpochMs')", 'JS T6 hook');
must(bridge, "const RUNTIME_PAYLOAD_SLIMMING_PHASE = 'V172-Q382R22'", 'Q382R22 JS marker preserved');
must(bridge, "const KEYBOARD_INSERTION_STATE_PUSH_BUDGET_PHASE = 'V172-Q382R19'", 'Q382R19 JS marker preserved');
must(bridge, 'function beginKeyboardInsertionBudget(reason)', 'Q382R19 insertion budget preserved');

for (const forbidden of [
  'optimistic echo',
  'OptimisticExpressionEcho',
  'q382R13',
  'q382R14',
  'q382R16',
  'direct-pan',
  'host-scrollport-force',
  'document-capture',
]) {
  mustNot(`${premiumKey}\n${appShell}\n${productionSurface}\n${bridge}`, forbidden, `forbidden behavior marker ${forbidden}`);
}

console.log('PASS verify_real_device_latency_instrumentation_v172_q382r23');
