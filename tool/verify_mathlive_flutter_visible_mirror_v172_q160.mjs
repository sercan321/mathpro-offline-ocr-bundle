#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_flutter_visible_mirror_v172_q160.mjs', retiredPhase: 'verify_mathlive_flutter_visible_mirror_v172_q160', reason: 'superseded by Q197/Q203 production-surface architecture and Q204R2 full test-suite migration; old diagnostic/fallback/court markers are no longer allowed in active production source or tests' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const issues = [];
const surface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const policy = read('lib/features/mathlive/mathlive_flutter_visible_mirror_policy.dart');
const q161Policy = fs.existsSync(path.join(root, 'lib/features/mathlive/mathlive_native_render_ownership_policy.dart'))
  ? read('lib/features/mathlive/mathlive_native_render_ownership_policy.dart')
  : '';

const retiredByQ161 = surface.includes("nativeRenderOwnershipPhase = 'V172-Q161'") ||
  surface.includes("static const String nativeRenderOwnershipPhase = 'V172-Q161'");

const checks = retiredByQ161 ? [
  ['Q160 historical policy phase retained', policy.includes("static const String phase = 'V172-Q160'")],
  ['Q160 mirror disabled by Q161', policy.includes('static const bool enabled = false')],
  ['Q160 Flutter math fallback disabled by Q161', policy.includes('static const bool usesFlutterMathFallback = false')],
  ['Q161 native render policy exists', q161Policy.includes("static const String phase = 'V172-Q161'")],
  ['surface no longer contains mirror widget', !surface.includes('class _VisibleMathLiveInputMirror')],
  ['surface no longer imports flutter_math_fork mirror renderer', !surface.includes('package:flutter_math_fork/flutter_math.dart')],
  ['surface no longer contains mirror value key', !surface.includes('mathpro-q160-visible-input-mirror')],
  ['protected claims false', policy.includes('keyboardLayoutMutationAllowed = false') && policy.includes('graphHistorySolutionUiMutationAllowed = false')],
] : [
  ['surface phase marker', surface.includes("flutterVisibleMirrorPhase = 'V172-Q160'") || surface.includes("static const String flutterVisibleMirrorPhase = 'V172-Q160'")],
  ['policy phase', policy.includes("static const String phase = 'V172-Q160'")],
  ['flutter math import', surface.includes('package:flutter_math_fork/flutter_math.dart')],
  ['visible mirror widget', surface.includes('class _VisibleMathLiveInputMirror')],
  ['ignore pointer mirror', surface.includes('IgnorePointer(')],
  ['mirror value key', surface.includes('mathpro-q160-visible-input-mirror')],
  ['keyboard command updates mirror', surface.includes('_updateVisibleMirrorForCommand(command')],
  ['bridge snapshot updates mirror', surface.includes('_syncVisibleMirrorFromSnapshot(snapshot')],
  ['placeholder conversion', surface.includes("replaceAll('#0', r'\\square')") && surface.includes("replaceAll('#?', r'\\square')")],
  ['protected claims false', policy.includes('keyboardLayoutMutationAllowed = false') && policy.includes('graphHistorySolutionUiMutationAllowed = false')],
];
for (const [name, pass] of checks) if (!pass) issues.push(name);
const result = {
  phase: 'V172-Q160',
  supersededBy: retiredByQ161 ? 'V172-Q161' : null,
  status: issues.length === 0
    ? (retiredByQ161
      ? 'MATHLIVE_FLUTTER_VISIBLE_MIRROR_RETIRED_BY_Q161_NATIVE_RENDER_OWNERSHIP'
      : 'MATHLIVE_FLUTTER_VISIBLE_MIRROR_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED')
    : 'BLOCKED_MATHLIVE_FLUTTER_VISIBLE_MIRROR',
  blockers: issues,
  contract: {
    visibleMirrorEnabled: !retiredByQ161 && issues.length === 0,
    retiredByNativeRenderOwnership: retiredByQ161,
    nonInteractive: true,
    preservesMathLiveWebViewPath: true,
    keyboardLayoutMutationAllowed: false,
    longPressOrderMutationAllowed: false,
    graphHistorySolutionUiMutationAllowed: false,
    realDevicePassClaimed: false,
    photomathLevelClaimed: false
  }
};
console.log(JSON.stringify(result, null, 2));
process.exit(issues.length === 0 ? 0 : 1);
