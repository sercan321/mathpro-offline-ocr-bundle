#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const checks = [];
const pass = (name, ok, detail = '') => checks.push({ name, ok, detail });

const policyPath = 'lib/features/camera/gauss_camera_regression_flutter_hygiene_policy.dart';
pass('q244r1_policy_exists', exists(policyPath));
if (exists(policyPath)) {
  const policy = read(policyPath);
  pass('q244r1_policy_phase', policy.includes("phase = 'V172-Q244R1'"));
  pass('q244r1_no_ocr_runtime', policy.includes('ocrRuntimeAdded = false'));
  pass('q244r1_no_direct_solve', policy.includes('directSolveFromCameraAllowed = false'));
  pass('q244r1_no_fake_flutter_pass', policy.includes('flutterAnalyzePassClaimedByAssistant = false') && policy.includes('flutterTestPassClaimedByAssistant = false'));
}

const court = read('lib/features/camera/gauss_camera_regression_court.dart');
pass('q244_policy_symbol_repaired', court.includes('GaussWorkspaceCameraEntryButtonPolicy.replacesWorkspaceEllipsisAction'));
pass('q244_old_policy_symbol_removed', !court.includes('GaussWorkspaceCameraEntryPolicy.'));

const adapter = read('lib/features/camera/gauss_winner_engine_adapter.dart');
pass('q241_candidate_case_insensitive', adapter.includes("issue.code.toLowerCase().contains('candidate')"));

const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
pass('q239d_copy_contains_sonraki_faz_or_successor_download_recovery', manager.includes('sonraki faz') || manager.includes('queueUserApprovedNetworkPreparation') || manager.includes('_recoverStaleActiveSnapshot'));

const widgetTest = read('test/widget_test.dart');
pass('stale_ellipsis_key_removed_from_widget_test', !widgetTest.includes("ValueKey('mathpro-more-placeholder-button')"));
pass('camera_key_present_in_widget_test', widgetTest.includes("ValueKey('mathpro-workspace-camera-entry-button')"));

const cameraShell = read('lib/features/camera/gauss_camera_capture_shell.dart');
pass('camera_shell_non_null_assertion_removed', !cameraShell.includes('activeCapture!.path'));
pass('camera_shell_const_quality_lists', cameraShell.includes('const labels = GaussCameraUxPremiumPolishContract.qualityRailLabels;') && cameraShell.includes('const hints = GaussCameraUxPremiumPolishContract.qualityRailHints;'));
pass('camera_shell_string_interp_hygiene', !cameraShell.includes('${degrees}°'));

const workspace = read('lib/features/workspace/workspace_panel.dart');
pass('workspace_muted_optional_param_removed', !workspace.includes('this.muted = false') && !workspace.includes('final bool muted;'));
pass('workspace_muted_references_removed', !workspace.includes('muted ?') && !/\bmuted\b/.test(workspace));

const pubspec = read('pubspec.yaml');
pass('no_mlkit_dependency', !/google_mlkit_text_recognition\s*:/.test(pubspec));
pass('no_onnx_dependency', !/onnxruntime\s*:/.test(pubspec));

const manifest = read('assets/mathlive/manifest.json');
pass('manifest_records_q244r1', manifest.includes('v172Q244R1CameraRegressionFlutterHygiene'));

const failed = checks.filter((c) => !c.ok);
for (const c of checks) console.log(`${c.ok ? '[PASS]' : '[FAIL]'} ${c.name}${c.detail ? `: ${c.detail}` : ''}`);
if (failed.length) {
  console.error(`CAMERA_REGRESSION_FLUTTER_HYGIENE_Q244R1_FAILED blockers=${failed.length}`);
  process.exit(1);
}
console.log('CAMERA_REGRESSION_FLUTTER_HYGIENE_Q244R1_STATIC_READY_BUT_REAL_FLUTTER_ANDROID_AND_CAMERA_RETEST_REQUIRED');
