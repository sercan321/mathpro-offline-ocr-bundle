#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const fail = (msg) => { console.error(`[FAIL] ${msg}`); process.exit(1); };
const must = (text, needle, label) => { if (!text.includes(needle)) fail(`missing ${label}: ${needle}`); };
const mustNot = (text, needle, label) => { if (text.includes(needle)) fail(`forbidden ${label}: ${needle}`); };

const required = [
  'lib/features/keyboard/keyboard_latency_closure_q382r24_policy.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/app/app_shell.dart',
  'lib/debug/latency/mathpro_latency_probe_q382r23.dart',
  'lib/debug/latency/mathpro_latency_overlay_q382r23.dart',
  'tool/verify_keyboard_latency_closure_v172_q382r24.mjs',
  'docs/audit/V172_Q382R24_KEYBOARD_LATENCY_CLOSURE_AUDIT_REPORT.md',
  'docs/audit/V172_Q382R24_CHANGED_FILES.md',
];
for (const rel of required) if (!exists(rel)) fail(`missing required Q382R24 file: ${rel}`);

const policy = read('lib/features/keyboard/keyboard_latency_closure_q382r24_policy.dart');
const premiumKey = read('lib/features/keyboard/premium_key.dart');
const appShell = read('lib/app/app_shell.dart');
const probe = read('lib/debug/latency/mathpro_latency_probe_q382r23.dart');
const overlay = read('lib/debug/latency/mathpro_latency_overlay_q382r23.dart');
const bridge = read('assets/mathlive/mathlive_prod_bridge.js');
const surface = read('lib/features/mathlive/mathlive_production_editor_surface.dart');

must(policy, "static const String phase = 'V172-Q382R24'", 'Q382R24 policy phase');
must(policy, 'q382r24-keyboard-latency-closure-pack-active', 'Q382R24 contract marker');
must(policy, 'latencyProbeEnabledByDefault = false', 'latency overlay/log default off');
must(policy, 'controllerSyncDebounce = Duration', 'downstream controller sync debounce');
must(policy, 'keyboardNativeEventSuppressionMs = 64', 'Q382R24 native-event suppression policy');
must(policy, 'keyboardSettlePushAfterCanonicalAllowed = false', 'Q382R24 single canonical state push policy');
must(policy, 'dispatchOnTapDown', 'tap-down gate helper');
must(policy, 'hasLongPress) return false', 'long-press protected from tap-down dispatch');
must(policy, "label == 'MORE'", 'MORE protected from tap-down dispatch');
must(policy, "label == '↵'", 'evaluate protected from tap-down dispatch');
must(policy, "label == 'C'", 'clear protected from tap-down dispatch');
must(policy, "label == '⌫'", 'delete protected from tap-down dispatch');
must(policy, 'deferDownstreamSyncForLabel', 'downstream defer helper');
must(policy, 'keyboardLayoutOrderLabelsUntouched = true', 'keyboard layout protected');
must(policy, 'longPressListsUntouched = true', 'long-press protected');
must(policy, 'moreTemplateTrayUntouched = true', 'MORE protected');
must(policy, 'graphSolutionHistoryUiUntouched = true', 'Graph/Solution/History UI protected');
must(policy, 'panDragScrollReintroduced = false', 'pan not reintroduced');

must(premiumKey, "import 'keyboard_latency_closure_q382r24_policy.dart';", 'PremiumKey Q382R24 import');
must(premiumKey, 'bool _tapDownDispatched = false', 'tap-down double-dispatch guard');
must(premiumKey, 'KeyboardLatencyClosureQ382R24Policy.dispatchOnTapDown', 'tap-down policy gate wired');
must(premiumKey, 'widget.onPressed?.call(widget.label);', 'tap-down/onTap dispatch still uses existing callback');
must(premiumKey, 'if (_tapDownDispatched)', 'onTap suppression after tap-down dispatch');
must(premiumKey, 'onLongPressStart: widget.onLongPressed == null ? null : _handleLongPressStart', 'long-press hook preserved');
must(premiumKey, 'onLongPress: widget.onLongPressed == null ? null : _handleLongPress', 'long-press callback preserved');
must(premiumKey, 'onTap: _handleTap', 'onTap fallback preserved');

must(probe, "import '../../features/keyboard/keyboard_latency_closure_q382r24_policy.dart';", 'probe Q382R24 import');
must(probe, 'KeyboardLatencyClosureQ382R24Policy.latencyProbeEnabledByDefault', 'probe gated by Q382R24 default-off policy');
must(overlay, "import '../../features/keyboard/keyboard_latency_closure_q382r24_policy.dart';", 'overlay Q382R24 import');
must(overlay, '!KeyboardLatencyClosureQ382R24Policy.latencyProbeEnabledByDefault', 'overlay default-off guard');

must(appShell, "import 'dart:async';", 'AppShell Timer import');
must(appShell, "import '../features/keyboard/keyboard_latency_closure_q382r24_policy.dart';", 'AppShell Q382R24 import');
must(appShell, 'Timer? _q382r24MathLiveDownstreamSyncDebounce', 'downstream debounce timer field');
must(appShell, 'MathLiveEditorStateSnapshot? _q382r24PendingMathLiveSnapshot', 'pending snapshot field');
must(appShell, '_q382r24MathLiveDownstreamSyncDebounce?.cancel();', 'timer cancellation present');
must(appShell, 'KeyboardLatencyClosureQ382R24Policy.deferDownstreamSyncForLabel(snapshot.lastCommandLabel)', 'hot state defer gate');
must(appShell, 'KeyboardLatencyClosureQ382R24Policy.controllerSyncDebounce', 'debounce duration wired');
must(appShell, 'void _flushQ382R24PendingMathLiveSnapshot()', 'pending snapshot flush helper');
must(appShell, 'void _applyMathLiveSnapshotToDownstreamState(MathLiveEditorStateSnapshot snapshot)', 'downstream apply helper');
must(appShell, '_flushQ382R24PendingMathLiveSnapshot();\n    final envelope = _lastMathLiveProductionStateEnvelope;', 'evaluate flush before consuming envelope');
must(appShell, 'void _handleGraphPressed() {\n    _flushQ382R24PendingMathLiveSnapshot();', 'graph flush before consuming envelope');
must(appShell, 'const MathProLatencyOverlayQ382R23()', 'debug overlay widget remains mounted but gated');

// Q382R24 must not rewrite MathLive bridge semantics or protected app surfaces.
must(bridge, "const KEYBOARD_INSERTION_STATE_PUSH_BUDGET_PHASE = 'V172-Q382R19'", 'Q382R19 bridge preserved');
must(bridge, "const RUNTIME_PAYLOAD_SLIMMING_PHASE = 'V172-Q382R22'", 'Q382R22 bridge preserved');
must(bridge, "const REAL_DEVICE_LATENCY_INSTRUMENTATION_PHASE = 'V172-Q382R23'", 'Q382R23 bridge preserved');
must(bridge, "const KEYBOARD_LATENCY_CLOSURE_PHASE = 'V172-Q382R24'", 'Q382R24 JS phase');
must(bridge, 'KEYBOARD_INSERTION_NATIVE_EVENT_SUPPRESSION_MS = 64', 'Q382R24 JS native event suppression window');
must(bridge, 'Q382R24_KEYBOARD_SETTLE_PUSH_AFTER_CANONICAL_ALLOWED = false', 'Q382R24 JS canonical-only push flag');
must(bridge, 'q382r24KeyboardSettlePushSuppressedCount += 1', 'Q382R24 settle push suppression counter');
must(surface, '_productionCommandTail', 'serial command tail preserved');
must(surface, 'MathLiveRealDeviceDefectRepairPolicy.androidBridgeCommandTimeout', 'Android bridge timeout preserved');
mustNot(surface, 'runJavaScriptReturningResult', 'blocking JS returning-result dispatch not reintroduced');

for (const forbidden of [
  'q382R13', 'q382R14', 'q382R16', 'direct-pan', 'host-scrollport-force', 'document-capture',
  'AndroidManifest.xml', 'MainActivity.kt', 'build.gradle', 'settings.gradle'
]) {
  mustNot(`${policy}\n${premiumKey}\n${appShell}\n${surface}\n${bridge}`, forbidden, `forbidden regression marker ${forbidden}`);
}

console.log('PASS verify_keyboard_latency_closure_v172_q382r24');
