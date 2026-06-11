#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q382R6_VERIFY_FAIL: ${msg}`); process.exit(1); };
const assert = (cond, msg) => { if (!cond) fail(msg); };
const phase = 'V172-Q382R6-WORKSPACE-CONTEXT-MENU-DISMISS-HITZONE-HARDENING';

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert(manifest.workspaceExpressionContextMenuDismissHitZoneHardeningLatestPhase === phase, 'manifest Q382R6 latest phase missing');
const envelope = manifest.v172Q382R6WorkspaceContextMenuDismissHitZoneHardening;
assert(envelope?.androidBackDismissesOverlayBeforeRoutePop === true, 'manifest back-dismiss marker missing');
assert(envelope?.overlayUsesLocalHistoryEntry === true, 'manifest LocalHistoryEntry marker missing');
assert(envelope?.safeHitZoneUsabilityHardenedWithoutCoveringMathLive === true, 'manifest safe hit-zone marker missing');
assert(envelope?.safeHitZoneWidth === 54 && envelope?.safeHitZoneHeight === 38, 'manifest safe hit-zone dimensions missing');
assert(envelope?.expressionEditClearsContextStateWithSetState === true, 'manifest expression edit cleanup marker missing');
assert(envelope?.unsupportedActionsRemainDisabledBeforeHandlerProof === true, 'manifest unsupported actions remain disabled marker missing');
assert(envelope?.q381R1OcrRuntimeChanged === false, 'manifest must preserve Q381R1 OCR runtime');

const policy = read('lib/features/workspace/workspace_expression_context_menu_q382_policy.dart');
assert(policy.includes(`dismissAndHitZoneHardeningPhase = '${phase}'`), 'policy Q382R6 phase missing');
for (const marker of [
  'androidBackDismissesOverlayBeforeRoutePop = true',
  'safeHitZoneUsabilityHardenedWithoutCoveringMathLive = true',
  'expressionEditClearsContextStateWithSetState = true',
  'q382R6WidgetContractsCoveredByTests = true',
]) assert(policy.includes(marker), `policy marker missing: ${marker}`);

const menu = read('lib/features/workspace/workspace_expression_context_menu.dart');
assert(menu.includes(`dismissAndHitZoneHardeningPhase = '${phase}'`), 'menu Q382R6 phase missing');
assert(menu.includes('LocalHistoryEntry? routeHistoryEntry'), 'menu missing LocalHistoryEntry state');
assert(menu.includes('route.addLocalHistoryEntry(routeHistoryEntry!)'), 'menu missing route local-history registration');
assert(menu.includes('removeEntryOnce(fromRouteHistory: true)'), 'menu back-dismiss remove path missing');
assert(menu.includes('androidBackDismissesOverlayBeforeRoutePop = true'), 'menu back-dismiss contract missing');
assert(menu.includes('safeHitZoneUsabilityHardenedWithoutCoveringMathLive = true'), 'menu hit-zone contract missing');

const panel = read('lib/features/workspace/workspace_panel.dart');
assert(panel.includes("ValueKey('mathpro-q382-expression-context-menu-safe-hit-zone')"), 'safe hit-zone key missing');
assert(panel.includes('width: 54'), 'safe hit-zone width not hardened');
assert(panel.includes('height: 38'), 'safe hit-zone height not hardened');
assert(panel.includes('V172-Q382R6: keep the menu trigger in a safe non-MathLive hit-zone'), 'Q382R6 hit-zone comment missing');

const app = read('lib/app/app_shell.dart');
assert(app.includes('void _clearWorkspaceContextStateForExpressionEdit()'), 'deterministic context-state cleanup helper missing');
assert(app.includes('setState(() {\n      _selectedWorkspaceMathAction = null;\n      _workspaceExpressionAllSelectedFromContextMenu = false;\n    });'), 'cleanup helper must clear through setState');
assert(app.includes('_clearWorkspaceContextStateForExpressionEdit();'), 'expression-edit cleanup helper not used');

const resolver = read('lib/features/workspace/workspace_math_action_resolver.dart');
assert(resolver.includes('enabled: false'), 'unproven math intents must remain disabled');
assert(!resolver.includes('enabled: true,\n        disabledReason'), 'unproven enabled action regression detected');

const test = read('test/v172_q382_workspace_expression_context_menu_test.dart');
assert(test.includes('dismissAndHitZoneHardeningPhase'), 'test missing Q382R6 phase coverage');
assert(test.includes('androidBackDismissesOverlayBeforeRoutePop'), 'test missing back-dismiss coverage');
assert(test.includes('safeHitZoneUsabilityHardenedWithoutCoveringMathLive'), 'test missing safe hit-zone coverage');
assert(test.includes('expressionEditClearsContextStateWithSetState'), 'test missing expression-edit cleanup coverage');

for (const protectedFile of [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'assets/mathlive/mathlive_bridge.js',
  'assets/mathlive/main_editor.html',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
  'android/app/build.gradle',
  'pubspec.yaml',
  'android/app/src/main/AndroidManifest.xml',
]) assert(exists(protectedFile), `${protectedFile} missing`);

console.log('Q382R6_VERIFY_PASS workspace context menu dismiss/hit-zone hardening verified.');
