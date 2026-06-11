#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
function read(rel) {
  const p = path.join(root, rel);
  if (!fs.existsSync(p)) throw new Error(`Missing required file: ${rel}`);
  return fs.readFileSync(p, 'utf8');
}
function fail(message) {
  console.error(`[FAIL] ${message}`);
  process.exit(1);
}
function pass(message) {
  console.log(`[PASS] ${message}`);
}

const bridgeRel = 'assets/mathlive/mathlive_prod_bridge.js';
const htmlRel = 'assets/mathlive/main_editor_prod.html';
const bridge = read(bridgeRel);
const html = read(htmlRel);

const forbiddenRuntimeMarkers = [
  'q382R13',
  'q382R14',
  'q382R16',
  'Q382R13',
  'Q382R14',
  'Q382R16',
  'direct-pan',
  'DIRECT_DRAG_PAN',
  'SCROLLPORT_DIRECT_DRAG_PAN',
  'INTERNAL_CONTENT_DIRECT_DRAG_PAN',
  'host-scrollport-force',
  'document-capture',
  'q382r8-direct-pan-scroll-drag-move',
];
for (const marker of forbiddenRuntimeMarkers) {
  if (bridge.includes(marker) || html.includes(marker)) {
    fail(`Latency relock forbids pan/scroll experiment marker in MathLive production assets: ${marker}`);
  }
}

const forbiddenPatterns = [
  /document\.addEventListener\(['"]pointermove['"][^;]*true\)/,
  /document\.addEventListener\(['"]touchmove['"][^;]*true\)/,
  /addEventListener\(['"]pointermove['"],[\s\S]{0,240}preventDefault\s*\(/,
  /addEventListener\(['"]touchmove['"],[\s\S]{0,240}preventDefault\s*\(/,
  /stopPropagation\s*\(\s*\)/,
];
for (const pattern of forbiddenPatterns) {
  if (pattern.test(bridge)) {
    fail(`Latency relock forbids aggressive touch/pointer interception pattern: ${pattern}`);
  }
}

const protectedFiles = [
  'android/app/src/main/AndroidManifest.xml',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
  'lib/features/camera/gauss_camera_capture_shell.dart',
  'lib/features/camera/gauss_mathlive_ocr_review_surface.dart',
  'lib/features/workspace/workspace_panel.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/graph/graph_card.dart',
  'pubspec.yaml',
];
for (const rel of protectedFiles) {
  if (!fs.existsSync(path.join(root, rel))) {
    fail(`Protected file missing after latency relock: ${rel}`);
  }
}

const panPolicyFiles = [
  'lib/features/mathlive/mathlive_long_expression_direct_drag_pan_scroll_q382r13_policy.dart',
  'lib/features/mathlive/mathlive_long_expression_direct_drag_pan_scroll_q382r14_policy.dart',
  'lib/features/mathlive/mathlive_long_expression_direct_drag_pan_scroll_q382r16_policy.dart',
  'tool/verify_mathlive_long_expression_direct_drag_pan_scroll_v172_q382r13.mjs',
  'tool/verify_mathlive_long_expression_direct_drag_pan_scroll_v172_q382r14.mjs',
  'tool/verify_mathlive_long_expression_direct_drag_pan_scroll_v172_q382r16.mjs',
];
for (const rel of panPolicyFiles) {
  if (fs.existsSync(path.join(root, rel))) {
    fail(`Pan experiment file must not exist in Q382R17 latency baseline: ${rel}`);
  }
}

pass('Q382R17 latency baseline relock: MathLive production assets contain no Q382R13/R14/R16 pan experiment code, no document-capture touch interception, and protected runtime files are present.');
