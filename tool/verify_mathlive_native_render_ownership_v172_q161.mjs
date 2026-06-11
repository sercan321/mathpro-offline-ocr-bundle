#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_native_render_ownership_v172_q161.mjs', retiredPhase: 'verify_mathlive_native_render_ownership_v172_q161', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const blockers = [];
const requireFile = (p) => {
  if (!exists(p)) blockers.push(`missing file: ${p}`);
};
const requireContains = (label, text, needle) => {
  if (!text.includes(needle)) blockers.push(`${label} missing: ${needle}`);
};
const requireNotContains = (label, text, needle) => {
  if (text.includes(needle)) blockers.push(`${label} must not contain: ${needle}`);
};

requireFile('lib/features/mathlive/mathlive_main_editor_surface.dart');
requireFile('lib/features/mathlive/mathlive_native_render_ownership_policy.dart');
requireFile('assets/mathlive/mathlive_bridge.js');
requireFile('test/v172_q161_mathlive_native_render_ownership_test.dart');

const surface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const policy = read('lib/features/mathlive/mathlive_native_render_ownership_policy.dart');
const mirrorPolicy = read('lib/features/mathlive/mathlive_flutter_visible_mirror_policy.dart');
const bridge = read('assets/mathlive/mathlive_bridge.js');

requireContains('surface', surface, "static const String nativeRenderOwnershipPhase = 'V172-Q161'");
requireContains('surface', surface, 'MathLiveNativeRenderOwnershipPolicy');
requireContains('surface', surface, '_shouldAllowVisibleFallbackForLatex');
requireContains('surface', surface, 'data-q161-native-render-ownership-fallback');
requireNotContains('surface', surface, 'class _VisibleMathLiveInputMirror');
requireNotContains('surface', surface, 'mathpro-q160-visible-input-mirror');
requireNotContains('surface', surface, 'Math.tex(');
requireNotContains('surface', surface, "import 'package:flutter_math_fork/flutter_math.dart';");

requireContains('policy', policy, "static const String phase = 'V172-Q161'");
requireContains('policy', policy, 'mathFieldIsOnlyStructuralRenderer = true');
requireContains('policy', policy, 'flutterVisibleMirrorEnabled = false');
requireContains('policy', policy, 'rawInsertTokensMayBeUserVisible = false');
requireContains('policy', policy, 'rawInsertTokensMayEnterSetLatex = false');
requireContains('policy', policy, 'structuralTemplateFallbackMayShowRawLatex = false');
requireContains('policy', policy, 'visibleFallbackMayRenderStructuralTemplates = false');
requireContains('policy', policy, 'keyboardLayoutMutationAllowed = false');
requireContains('policy', policy, 'graphHistorySolutionUiMutationAllowed = false');
requireContains('policy', policy, 'photomathLevelClaimed = false');

requireContains('mirror policy', mirrorPolicy, 'static const bool enabled = false');
requireContains('mirror policy', mirrorPolicy, 'static const bool usesFlutterMathFallback = false');
requireContains('mirror policy', mirrorPolicy, 'V172-Q161: mirror retired');

requireContains('bridge', bridge, "nativeRenderOwnershipPhase: 'V172-Q161'");
requireContains('bridge', bridge, 'function containsRawInsertToken');
requireContains('bridge', bridge, 'function documentLatexFromInsertPayload');
requireContains('bridge', bridge, 'function mayShowFallbackAsText');
requireContains('bridge', bridge, "replace(/#0/g, '\\\\placeholder{}')");
requireContains('bridge', bridge, "replace(/#\\?/g, '\\\\placeholder{}')");
requireContains('bridge', bridge, "replace(/#@/g, '\\\\placeholder{}')");
requireContains('bridge', bridge, 'q161-blocked-raw-structural-fallback-no-mathfield');
requireContains('bridge', bridge, 'q161-sanitized-document-latex-fallback-in-mathfield');
requireNotContains('bridge', bridge, 'mathpro-q160-visible-input-mirror');

const report = {
  phase: 'V172-Q161',
  status: blockers.length === 0
    ? 'MATHLIVE_NATIVE_RENDER_OWNERSHIP_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
    : 'BLOCKED_MATHLIVE_NATIVE_RENDER_OWNERSHIP',
  blockers,
  packageSideRepairReady: blockers.length === 0,
  renderOwnershipRepairs: {
    flutterMirrorRetired: !surface.includes('class _VisibleMathLiveInputMirror'),
    mathFieldOnlyStructuralRenderer: policy.includes('mathFieldIsOnlyStructuralRenderer = true'),
    rawInsertTokensUserVisibleAllowed: false,
    structuralFallbackRawLatexAllowed: false,
    bridgeSanitizesInsertTokensForDocumentLatex: bridge.includes('function documentLatexFromInsertPayload'),
    protectedKeyboardMutationAllowed: false,
    graphHistorySolutionUiMutationAllowed: false,
    realDevicePassClaimed: false,
    cursorPassClaimed: false,
    photomathLevelClaimed: false
  }
};
console.log(JSON.stringify(report, null, 2));
process.exit(blockers.length === 0 ? 0 : 1);
