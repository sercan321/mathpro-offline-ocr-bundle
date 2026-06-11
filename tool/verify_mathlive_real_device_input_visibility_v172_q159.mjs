#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_real_device_input_visibility_v172_q159.mjs', retiredPhase: 'verify_mathlive_real_device_input_visibility_v172_q159', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const root = process.cwd();
const issues = [];
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
function requireContains(rel, needle, label = needle) {
  const text = read(rel);
  if (!text.includes(needle)) issues.push(`${rel} missing ${label}`);
}
function requireMissing(rel, needle, label = needle) {
  const text = read(rel);
  if (text.includes(needle)) issues.push(`${rel} unexpectedly contains ${label}`);
}
requireContains('lib/features/mathlive/mathlive_real_device_input_visibility_policy.dart', "phase = 'V172-Q159'", 'Q159 policy phase');
requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', "realDeviceInputVisibilityPhase = 'V172-Q159'", 'surface Q159 phase');
requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', '_flushQueuedLabels(lastAnswer: widget.lastAnswer)', 'queued command flush after page load');

const surface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
if (!(surface.includes('data-q159-visible-command-fallback') || surface.includes('data-q161-native-render-ownership-fallback'))) {
  issues.push('lib/features/mathlive/mathlive_main_editor_surface.dart missing DOM visible fallback / Q161 native render ownership marker');
}
if (!(surface.includes('q159-visible-command-fallback-without-bridge-state') || surface.includes('q161-simple-visible-fallback-without-bridge-state'))) {
  issues.push('lib/features/mathlive/mathlive_main_editor_surface.dart missing controller fallback state diagnostic / Q161 simple fallback diagnostic');
}

requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', 'webViewFallbackMayStayVisibleWithoutMountedMathfield', 'blocked overlay fallback policy');
requireContains('assets/mathlive/manifest.json', 'v172Q159RealDeviceInputVisibility', 'manifest Q159 envelope');

const q159Test = read('test/v172_q159_mathlive_real_device_input_visibility_test.dart');
const q161Test = fs.existsSync(path.join(root, 'test/v172_q161_mathlive_native_render_ownership_test.dart'))
  ? read('test/v172_q161_mathlive_native_render_ownership_test.dart')
  : '';
if (!(q159Test.includes('data-q159-visible-command-fallback') || q161Test.includes('data-q161-native-render-ownership-fallback'))) {
  issues.push('Q159/Q161 Flutter test fallback marker missing');
}

requireMissing('lib/features/keyboard/key_config.dart', 'V172-Q159', 'protected keyboard mutation');
requireMissing('lib/features/keyboard/math_keyboard.dart', 'V172-Q159', 'protected keyboard mutation');
requireMissing('lib/features/workspace/template_tray.dart', 'V172-Q159', 'protected MORE mutation');
let manifest = {};
try { manifest = JSON.parse(read('assets/mathlive/manifest.json')); } catch (error) { issues.push(`manifest parse failed: ${error.message}`); }
const q159 = manifest.v172Q159RealDeviceInputVisibility || {};
if (q159.phase !== 'V172-Q159') issues.push('manifest Q159 phase mismatch');
if (q159.flushQueuedCommandsAfterWebViewLoad !== true) issues.push('manifest Q159 queue flush missing');
if (q159.visibleFallbackWithoutMountedMathfield !== true) issues.push('manifest Q159 visible fallback missing');
if (q159.keyboardLayoutMutationAllowed !== false) issues.push('manifest Q159 keyboard mutation not blocked');
if (q159.realDevicePassClaimed !== false) issues.push('manifest Q159 fake device pass not blocked');
if (issues.length) {
  console.error(JSON.stringify({ phase: 'V172-Q159', status: 'BLOCKED_MATHLIVE_REAL_DEVICE_INPUT_VISIBILITY', blockers: issues }, null, 2));
  process.exit(1);
}
console.log(JSON.stringify({
  phase: 'V172-Q159',
  status: 'MATHLIVE_REAL_DEVICE_INPUT_VISIBILITY_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED',
  blockers: [],
  packageSideRepairReady: true,
  repairs: {
    queuedCommandsFlushAfterWebViewLoad: true,
    visibleFallbackWithoutMountedMathfield: true,
    domFallbackWhenBridgeMissing: true,
    protectedKeyboardMutationAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
}, null, 2));
