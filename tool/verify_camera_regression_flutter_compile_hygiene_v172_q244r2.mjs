#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const checks = [];
const pass = (name, ok, detail = '') => checks.push({ name, ok, detail });

const policyPath = 'lib/features/camera/gauss_camera_regression_flutter_compile_hygiene_policy.dart';
pass('q244r2_policy_exists', exists(policyPath));
if (exists(policyPath)) {
  const policy = read(policyPath);
  pass('q244r2_policy_phase', policy.includes("phase = 'V172-Q244R2'"));
  pass('q244r2_compile_error_repair_recorded', policy.includes('repairsQ244R1WorkspaceMutedCompileError = true'));
  pass('q244r2_no_ocr_runtime', policy.includes('ocrRuntimeAdded = false'));
  pass('q244r2_no_direct_solve', policy.includes('directSolveFromCameraAllowed = false'));
  pass('q244r2_no_fake_flutter_pass', policy.includes('flutterAnalyzePassClaimedByAssistant = false') && policy.includes('flutterTestPassClaimedByAssistant = false'));
}

const workspace = read('lib/features/workspace/workspace_panel.dart');
pass('workspace_camera_entry_key_preserved', workspace.includes("ValueKey('mathpro-workspace-camera-entry-button')"));
pass('workspace_muted_param_not_restored', !workspace.includes('this.muted = false') && !workspace.includes('final bool muted;'));
pass('workspace_muted_references_removed', !workspace.includes('muted ?') && !/\bmuted\b/.test(workspace));
pass('workspace_inactive_gradient_constant', workspace.includes('Colors.white.withValues(alpha: 0.040)'));
pass('workspace_inactive_border_constant', workspace.includes('MathProColors.accent.withValues(alpha: 0.27)'));

const q244r1Verifier = read('tool/verify_camera_regression_flutter_hygiene_v172_q244r1.mjs');
pass('q244r1_verifier_hardened_for_muted_references', q244r1Verifier.includes('workspace_muted_references_removed'));

const widgetTest = read('test/widget_test.dart');
pass('stale_ellipsis_key_removed_from_widget_test', !widgetTest.includes("ValueKey('mathpro-more-placeholder-button')"));
pass('camera_key_present_in_widget_test', widgetTest.includes("ValueKey('mathpro-workspace-camera-entry-button')"));

const pubspec = read('pubspec.yaml');
pass('no_mlkit_dependency', !/google_mlkit_text_recognition\s*:/.test(pubspec));
pass('no_onnx_dependency', !/onnxruntime\s*:/.test(pubspec));

const manifest = read('assets/mathlive/manifest.json');
pass('manifest_records_q244r2', manifest.includes('v172Q244R2CameraRegressionFlutterCompileHygiene'));

const failed = checks.filter((c) => !c.ok);
for (const c of checks) console.log(`${c.ok ? '[PASS]' : '[FAIL]'} ${c.name}${c.detail ? `: ${c.detail}` : ''}`);
if (failed.length) {
  console.error(`CAMERA_REGRESSION_FLUTTER_COMPILE_HYGIENE_Q244R2_FAILED blockers=${failed.length}`);
  process.exit(1);
}
console.log('CAMERA_REGRESSION_FLUTTER_COMPILE_HYGIENE_Q244R2_STATIC_READY_BUT_REAL_FLUTTER_ANDROID_AND_CAMERA_RETEST_REQUIRED');
