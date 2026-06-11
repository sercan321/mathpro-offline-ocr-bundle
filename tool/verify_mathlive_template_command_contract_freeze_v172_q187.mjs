#!/usr/bin/env node
import fs from 'node:fs';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_template_command_contract_freeze_v172_q187.mjs', retiredPhase: 'verify_mathlive_template_command_contract_freeze_v172_q187', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const files = {
  keyConfig: 'lib/features/keyboard/key_config.dart',
  bridgePolicy: 'lib/features/mathlive/mathlive_keyboard_bridge_policy.dart',
  freezePolicy: 'lib/features/mathlive/mathlive_template_command_contract_freeze_policy.dart',
  q184Test: 'test/v172_q184_production_mathlive_cutover_surface_test.dart',
  q187Test: 'test/v172_q187_template_command_contract_freeze_test.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
};
const text = Object.fromEntries(Object.entries(files).map(([k, p]) => [k, fs.readFileSync(p, 'utf8')]))
const failures = [];
const has = (name, needle) => { if (!text[name].includes(needle)) failures.push(`${files[name]} missing ${needle}`); };
const lacks = (name, needle) => { if (text[name].includes(needle)) failures.push(`${files[name]} must not contain ${needle}`); };

function extractBlock(source, startNeedle, endNeedle) {
  const start = source.indexOf(startNeedle);
  if (start < 0) return '';
  const end = source.indexOf(endNeedle, start);
  return end < 0 ? source.slice(start) : source.slice(start, end);
}

const behaviorBlock = extractBlock(text.keyConfig, 'static const Map<String, KeyBehaviorType> keyBehaviorMap = {', '\n  };\n\n  static KeyBehaviorType getKeyBehavior');
const templateBlock = extractBlock(text.bridgePolicy, 'static const Map<String, String> mainEditorTemplateLatexCommands = <String, String>{', '\n  };\n  static MathLiveBridgeCommand commandForMainEditorLabel');
if (!behaviorBlock) failures.push('keyBehaviorMap block not found');
if (!templateBlock) failures.push('mainEditorTemplateLatexCommands block not found');

const structuralLabels = [];
for (const m of behaviorBlock.matchAll(/^\s*'([^']+)'\s*:\s*KeyBehaviorType\.(structureInsert|wrapper|postfix)\s*,/gm)) {
  structuralLabels.push(m[1]);
}
const templateMap = new Map();
for (const m of templateBlock.matchAll(/^\s*'([^']+)'\s*:\s*r?(['"])((?:\\.|(?!\2).)*)\2\s*,/gm)) {
  templateMap.set(m[1], m[3]);
}

if (structuralLabels.length < 140) failures.push(`expected at least 140 structural/wrapper/postfix labels, found ${structuralLabels.length}`);
const missing = structuralLabels.filter((label) => !templateMap.has(label));
if (missing.length) failures.push(`mainEditorTemplateLatexCommands missing structural labels: ${missing.join(', ')}`);

const critical = [
  '□/□', '√□', '□^□', '□!', '|□|', 'sin', 'cos', 'tan', 'ln', 'log',
  'd/dx', '∫□dx', '∫ₐᵇ', 'lim', 'Σ', 'Π', 'Taylor', 'Maclaurin',
  'Geometrik', 'Binom', 'eˣ serisi', 'sin serisi', 'cos serisi', 'ln serisi',
  'arctan serisi', '{□=□', '{3 denklem', '{n denklem', '3 Denklem',
  'n Denklem', '[□ □]', '[□]', '2×2', '3×3', '4×4', 'm×n', 'det(□)',
  'RREF', 'Rank', 'Özdeğer', 'Çöz'
];
for (const label of critical) {
  if (!templateMap.has(label)) failures.push(`critical template label not explicitly mapped: ${label}`);
}

const rawForbidden = [
  'Taylor', 'Maclaurin', 'Geometrik', 'Binom', 'eˣ serisi', 'sin serisi',
  'cos serisi', 'ln serisi', 'arctan serisi', '{3 denklem', '{n denklem',
  '3 Denklem', 'n Denklem', 'Kuadratik', 'RREF', 'Rank', 'Özdeğer', 'Çöz'
];
for (const label of rawForbidden) {
  const payload = templateMap.get(label);
  if (!payload) failures.push(`raw-forbidden label missing explicit payload: ${label}`);
  else if (payload === label || payload.includes(label)) failures.push(`raw-forbidden label can fall through visibly: ${label} -> ${payload}`);
}
for (const label of ['□/□', '□⁄□', '√□', '∛□', '□√□', '□^□', '□!', '|□|', '‖□‖', '∫□dx', '∫ₐᵇ', 'Σ', 'Π', '[□ □]', '[□]']) {
  const payload = templateMap.get(label);
  if (!payload) failures.push(`structural glyph label missing explicit payload: ${label}`);
  else if (payload === label) failures.push(`structural glyph label maps to raw visible glyph: ${label}`);
}

has('bridgePolicy', "mainEditorTemplateCommandFreezePhase = 'V172-Q187'");
has('bridgePolicy', 'V172-Q187 freezes this map');
has('freezePolicy', "phase = 'V172-Q187'");
has('freezePolicy', 'missingExplicitTemplateLabels()');
has('freezePolicy', 'rawFallbackViolations()');
has('freezePolicy', 'keyboardLayoutMutationAllowed = false');
has('freezePolicy', 'productionBridgePublicApiMutationAllowed = false');
has('q187Test', 'missingExplicitTemplateLabels(), isEmpty');
has('q187Test', 'rawFallbackViolations(), isEmpty');
has('q184Test', 'MathProProductionMathLiveBridge.insertLatex');
has('q184Test', "isNot(contains('executeMathProCommand'))");
has('manifest', 'v172Q187TemplateCommandContractFreeze');
has('manifest', 'V172-Q187-MATHLIVE-TEMPLATE-COMMAND-CONTRACT-FREEZE');
has('readme', 'V172-Q187 — Template Command Contract Freeze');

// Q187 must not broaden the Q186 production bridge public API.
for (const forbidden of ['executeMathProCommand', 'getState:', 'scheduleMount:', 'flushQueuedCommands']) {
  lacks('prodBridge', forbidden);
}
has('prodBridge', 'insertLatex');
has('prodBridge', 'notifyFlutterState');

if (failures.length) {
  console.error('MATHLIVE_TEMPLATE_COMMAND_CONTRACT_FREEZE_Q187_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_TEMPLATE_COMMAND_CONTRACT_FREEZE_Q187_PACKAGE_READY_BUT_FLUTTER_DEVICE_EVIDENCE_REQUIRED');
