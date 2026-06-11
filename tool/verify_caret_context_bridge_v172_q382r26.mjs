#!/usr/bin/env node
import fs from 'node:fs';

const checks = [];
function read(path) {
  return fs.readFileSync(path, 'utf8');
}
function requireContains(path, needle, label = needle) {
  const text = read(path);
  if (!text.includes(needle)) {
    throw new Error(`${path} missing ${label}`);
  }
  checks.push(`contains:${path}:${label}`);
}
function requireNotContains(path, needle, label = needle) {
  const text = read(path);
  if (text.includes(needle)) {
    throw new Error(`${path} must not contain ${label}`);
  }
  checks.push(`not-contains:${path}:${label}`);
}

requireContains('lib/features/mathlive/mathlive_state_adapter.dart', 'class MathLiveCaretContextBridgeQ382R26Policy');
requireContains('lib/features/mathlive/mathlive_state_adapter.dart', "static const String phase = 'V172-Q382R26'");
requireContains('lib/features/mathlive/mathlive_state_adapter.dart', 'class MathLiveCaretContextSnapshot');
requireContains('lib/features/mathlive/mathlive_state_adapter.dart', 'MathLiveCaretContextSnapshot.fromJson(json[\'caretContext\'])');
requireContains('lib/features/mathlive/mathlive_state_adapter.dart', 'bool get mayAllowOptimisticLinearAppend');
requireContains('lib/features/mathlive/mathlive_state_adapter.dart', "static const bool optimisticEchoEnabledByThisPhase = false");
requireContains('lib/features/mathlive/mathlive_state_adapter.dart', "static const bool privateShadowDomCaretReadAllowed = false");
requireContains('assets/mathlive/mathlive_prod_bridge.js', "const CARET_CONTEXT_BRIDGE_PHASE = 'V172-Q382R26'");
requireContains('assets/mathlive/mathlive_prod_bridge.js', 'q382r26CaretContextBridgeActive: true');
requireContains('assets/mathlive/mathlive_prod_bridge.js', 'q382r26OptimisticEchoEnabledByThisPhase: false');
requireContains('assets/mathlive/mathlive_prod_bridge.js', 'function q382r26ReadCaretContext');
requireContains('assets/mathlive/mathlive_prod_bridge.js', 'state.caretContext = q382r26ReadCaretContext(mf, value);');
requireContains('assets/mathlive/mathlive_prod_bridge.js', 'mathlive-public-position-lastOffset');
requireContains('test/v172_q382r26_caret_context_bridge_test.dart', 'V172-Q382R26 Caret Context Bridge');

for (const finalPath of [
  'docs/audit/V172_Q382R26_CARET_CONTEXT_BRIDGE.md',
  'docs/audit/V172_Q382R26_CHANGED_FILES.md',
]) {
  if (!fs.existsSync(finalPath)) {
    throw new Error(`${finalPath} missing Q382R26 audit artifact`);
  }
  checks.push(`exists:${finalPath}`);
}
requireContains('docs/audit/V172_Q382R26_CARET_CONTEXT_BRIDGE.md', 'Q382R26');
requireContains('docs/audit/V172_Q382R26_CHANGED_FILES.md', 'Q382R26');
const bridgeText = read('assets/mathlive/mathlive_prod_bridge.js');
const readerStart = bridgeText.indexOf('function q382r26ReadCaretContext');
const readerEnd = bridgeText.indexOf('function updateState');
if (readerStart < 0 || readerEnd < readerStart) throw new Error('q382r26 reader section not found');
const reader = bridgeText.slice(readerStart, readerEnd);
if (reader.includes('shadowRoot') || reader.includes('ML__caret')) {
  throw new Error('Q382R26 caret context reader must not use private MathLive shadow DOM caret internals');
}
checks.push('q382r26-reader-no-private-caret-dom');
requireNotContains('lib/features/mathlive/mathlive_production_editor_surface.dart', 'optimisticExpressionEcho', 'optimistic echo production code in Q382R26');
requireNotContains('lib/app/app_shell.dart', 'optimisticExpressionEcho', 'optimistic echo app shell code in Q382R26');

console.log(`PASS verify_caret_context_bridge_v172_q382r26 checks=${checks.length}`);
