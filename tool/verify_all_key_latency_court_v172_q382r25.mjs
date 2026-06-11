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
  'lib/debug/latency/mathpro_all_key_latency_court_q382r25_policy.dart',
  'lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart',
  'lib/debug/latency/mathpro_latency_probe_q382r23.dart',
  'lib/debug/latency/mathpro_latency_overlay_q382r23.dart',
  'lib/app/app_shell.dart',
  'tool/verify_all_key_latency_court_v172_q382r25.mjs',
  'docs/audit/V172_Q382R25_ALL_KEY_LATENCY_COURT_AND_INVENTORY.md',
  'docs/audit/V172_Q382R25_CHANGED_FILES.md',
  'test/v172_q382r25_all_key_latency_court_test.dart',
];
for (const rel of required) if (!exists(rel)) fail(`missing required Q382R25 file: ${rel}`);

const policy = read('lib/debug/latency/mathpro_all_key_latency_court_q382r25_policy.dart');
const court = read('lib/debug/latency/mathpro_all_key_latency_court_q382r25.dart');
const probe = read('lib/debug/latency/mathpro_latency_probe_q382r23.dart');
const overlay = read('lib/debug/latency/mathpro_latency_overlay_q382r23.dart');
const appShell = read('lib/app/app_shell.dart');
const keyConfig = read('lib/features/keyboard/key_config.dart');
const actionUtils = read('lib/logic/action_utils.dart');
const premiumKey = read('lib/features/keyboard/premium_key.dart');
const bottomDock = read('lib/features/keyboard/bottom_dock.dart');
const mathKeyboard = read('lib/features/keyboard/math_keyboard.dart');
const bridge = read('assets/mathlive/mathlive_prod_bridge.js');
const surface = read('lib/features/mathlive/mathlive_production_editor_surface.dart');

must(policy, "static const String phase = 'V172-Q382R25'", 'Q382R25 policy phase');
must(policy, 'q382r25-all-key-latency-court-and-inventory-active', 'Q382R25 contract marker');
must(policy, "bool.fromEnvironment(\n    'MATHPRO_LATENCY_COURT'", 'explicit dart-define gate');
must(policy, 'defaultValue: false', 'court default off');
must(policy, 'performanceOptimizationAllowed = false', 'measurement-only no optimization');
must(policy, 'keyboardBehaviorChangeAllowed = false', 'keyboard behavior protected');
must(policy, 'mathLiveCommandSemanticsChangeAllowed = false', 'MathLive semantics protected');
must(policy, 'graphSolutionHistoryOcrAndroidChangeAllowed = false', 'protected subsystems protected');
must(policy, 'panDragScrollReintroduced = false', 'pan not reintroduced');
must(policy, 'includeMainKeyboardEntries = true', 'main keyboard inventory included');
must(policy, 'includeLongPressOptionEntries = true', 'long-press inventory included');
must(policy, 'includeMoreTemplateEntries = true', 'MORE template inventory included');
must(policy, 'dispatchDestructiveOrUiCommands = false', 'destructive commands not auto-dispatched');

must(court, 'class MathProAllKeyLatencyCourtEntryQ382R25', 'inventory entry class');
must(court, 'class MathProAllKeyLatencyCourtSummaryQ382R25', 'summary class');
must(court, 'class MathProAllKeyLatencyCourtQ382R25 extends ChangeNotifier', 'court singleton');
must(court, 'static List<MathProAllKeyLatencyCourtEntryQ382R25> buildInventory()', 'inventory builder');
must(court, 'KeyConfig.tabs', 'tab inventory source');
must(court, 'KeyConfig.buildKeyboardSections(tab)', 'main keyboard source');
must(court, 'KeyConfig.longPressMap.entries', 'long-press source');
must(court, 'KeyConfig.getLongPressOptions(entry.key, tab)', 'long-press normalization source');
must(court, 'ActionUtils.morePanelCategories', 'MORE inventory source');
must(court, 'origin: \'mainKeyboard\'', 'main keyboard origin marker');
must(court, 'origin: \'longPressOption\'', 'long-press origin marker');
must(court, 'origin: \'moreTemplate\'', 'MORE template origin marker');
must(court, 'origin: \'moreCategory\'', 'MORE category origin marker');
must(court, 'dispatchInDirectBridgeCourt', 'dispatchability flag');
must(court, 'exportInventoryJson()', 'inventory JSON export');
must(court, 'maybeRunDirectBridgeCourt', 'debug direct bridge runner');
must(court, '[Q382R25_COURT] INVENTORY', 'inventory log marker');
must(court, '[Q382R25_COURT] DIRECT_BRIDGE_ENTRY', 'per-entry court log marker');
must(court, 'maxDirectBridgeEntriesPerRun', 'bounded direct court run');
must(court, 'KeyBehaviorType.command', 'command filtering');
must(court, "'destructive-or-ui-command'", 'destructive command category');

must(probe, "import 'mathpro_all_key_latency_court_q382r25_policy.dart';", 'probe Q382R25 import');
must(probe, 'MathProAllKeyLatencyCourtQ382R25Policy.enabledByDartDefine', 'probe enabled during court');
must(probe, 'bool get _probeActive', 'probe active helper');
must(overlay, "import 'mathpro_all_key_latency_court_q382r25_policy.dart';", 'overlay Q382R25 import');
must(overlay, 'MathProAllKeyLatencyCourtQ382R25Policy.enabledByDartDefine', 'overlay enabled during court');

must(appShell, "import '../debug/latency/mathpro_all_key_latency_court_q382r25.dart';", 'AppShell court import');
must(appShell, 'MathProAllKeyLatencyCourtQ382R25.instance.maybeRunDirectBridgeCourt', 'court scheduled from app shell');
must(appShell, 'dispatch: _dispatchQ382R25LatencyCourtLabel', 'court dispatch callback wired');
must(appShell, 'Future<bool> _dispatchQ382R25LatencyCourtLabel(String label)', 'debug court dispatch helper');
must(appShell, 'MathProLatencyProbeQ382R23.instance.recordPremiumKeyTapDown(label);', 'court T0 marker');
must(appShell, 'MathProLatencyProbeQ382R23.instance.recordPremiumKeyTap(label);', 'court T1 marker');
must(appShell, '_mathLiveMainEditor.sendKeyFast(label', 'court uses existing MathLive key path');
must(appShell, 'assert(() {', 'court debug-only scheduling guard');

// Existing Q382R24/Q382R23 lines must remain present.
must(premiumKey, 'KeyboardLatencyClosureQ382R24Policy.dispatchOnTapDown', 'Q382R24 tap policy preserved');
must(appShell, 'KeyboardLatencyClosureQ382R24Policy.deferDownstreamSyncForLabel', 'Q382R24 downstream defer preserved');
must(bridge, "const KEYBOARD_LATENCY_CLOSURE_PHASE = 'V172-Q382R24'", 'Q382R24 JS bridge preserved');
must(surface, '_dispatchProductionCommandFireAndForgetQ382R24', 'Q382R24 fire-and-forget path preserved');

// Source inventory sanity: the court is not allowed to hardcode a tiny subset.
const tabMatches = [...keyConfig.matchAll(/'([^']+)'/g)].map((m) => m[1]);
for (const tab of ['Temel', 'Cebir', 'Kalkülüs', 'Kompleks', 'Lineer Cebir']) {
  if (!tabMatches.includes(tab)) fail(`missing tab in KeyConfig: ${tab}`);
}
const longPressParents = [...keyConfig.matchAll(/\n\s*'([^']+)'\s*:\s*\[/g)].length;
if (longPressParents < 30) fail(`long-press inventory unexpectedly small: ${longPressParents}`);
const moreCategories = [...actionUtils.matchAll(/MorePanelCategory\(/g)].length;
if (moreCategories < 7) fail(`MORE category inventory unexpectedly small: ${moreCategories}`);

// Protected source mutation guardrails: Q382R25 is allowed to add debug court
// wiring, not revive old touch/pan experiments or mutate protected Android/OCR.
for (const forbidden of [
  'q382R13', 'q382R14', 'q382R16', 'direct-pan', 'drag-pan', 'host-scrollport-force',
  'document-capture', 'document.addEventListener(\'touchmove\'', 'preventDefault()', 'stopPropagation()',
  'caretAtDocumentEnd = true', 'optimisticExpressionEcho = true', 'Q383'
]) {
  mustNot(`${policy}\n${court}\n${probe}\n${overlay}\n${appShell}\n${premiumKey}\n${bottomDock}\n${mathKeyboard}\n${bridge}\n${surface}`, forbidden, `forbidden Q382R25 regression marker ${forbidden}`);
}

for (const rel of [
  'android/app/src/main/AndroidManifest.xml',
  'android/app/src/main/kotlin/com/mathpro/phase17/MainActivity.kt',
  'android/app/build.gradle',
  'android/settings.gradle',
]) {
  if (exists(rel)) {
    const text = read(rel);
    mustNot(text, 'Q382R25', `protected Android/Gradle file mutated by Q382R25: ${rel}`);
  }
}

console.log('PASS verify_all_key_latency_court_v172_q382r25');
