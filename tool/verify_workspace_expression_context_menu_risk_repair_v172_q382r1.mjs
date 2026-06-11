#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q382R1_VERIFY_FAIL: ${msg}`); process.exit(1); };
const assert = (cond, msg) => { if (!cond) fail(msg); };

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert(manifest.workspaceExpressionContextMenuRiskRepairLatestPhase === 'V172-Q382R1-WORKSPACE-CONTEXT-MENU-RISK-REPAIR', 'manifest Q382R1 latest phase missing');
assert(manifest.v172Q382R1WorkspaceContextMenuRiskRepair?.overlayEntryRemovalGuarded === true, 'overlay removal guard manifest missing');
assert(manifest.v172Q382R1WorkspaceContextMenuRiskRepair?.menuMaxHeightNeverExceedsSafeArea === true, 'safe max height manifest missing');
assert(manifest.v172Q382R1WorkspaceContextMenuRiskRepair?.q381R1OcrSafetyPreserved === true, 'Q381R1 OCR preservation missing');

const menu = read('lib/features/workspace/workspace_expression_context_menu.dart');
assert(menu.includes("riskRepairPhase = 'V172-Q382R1-WORKSPACE-CONTEXT-MENU-RISK-REPAIR'"), 'Q382R1 risk repair phase marker missing');
assert(menu.includes('overlayEntryRemovalGuarded = true'), 'overlay removal guard policy missing');
assert(menu.includes('maxHeightNeverExceedsSafeArea = true'), 'safe height policy missing');
assert(menu.includes('var removed = false'), 'overlay remove-once state missing');
assert(menu.includes('void removeEntryOnce()'), 'removeEntryOnce helper missing');
assert(menu.includes('if (removed) return;'), 'removeEntryOnce double-remove guard missing');
assert(menu.includes('final safeHeight = math.max(72.0, safeBottom - safeTop);'), 'safeHeight clamp missing');
assert(menu.includes('final maxHeight = math.min(382.0, safeHeight);'), 'maxHeight safe area upper bound missing');
assert(!menu.includes('math.max(196.0, safeBottom - safeTop)'), 'old unsafe min-height clamp still present');

const policy = read('lib/features/workspace/workspace_expression_context_menu_q382_policy.dart');
assert(policy.includes("riskRepairPhase = 'V172-Q382R1-WORKSPACE-CONTEXT-MENU-RISK-REPAIR'"), 'policy risk repair marker missing');
assert(policy.includes('overlayEntryRemovalGuarded = true'), 'policy overlay guard missing');
assert(policy.includes('menuMaxHeightNeverExceedsSafeArea = true'), 'policy safe height marker missing');

const q382Verifier = read('tool/verify_workspace_expression_context_menu_v172_q382.mjs');
assert(q382Verifier.includes('Q382_VERIFY_PASS'), 'Q382 base verifier missing/changed unexpectedly');

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
]) {
  assert(exists(protectedFile), `${protectedFile} missing`);
}

console.log('Q382R1_VERIFY_PASS workspace context menu risk repair verified.');
