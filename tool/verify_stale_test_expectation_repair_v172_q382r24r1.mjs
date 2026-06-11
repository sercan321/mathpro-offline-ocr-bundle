#!/usr/bin/env node
import fs from 'node:fs';

function read(path) {
  return fs.readFileSync(path, 'utf8');
}

function assertContains(source, needle, label) {
  if (!source.includes(needle)) {
    throw new Error(`${label}: missing ${needle}`);
  }
}

function assertNotContains(source, needle, label) {
  if (source.includes(needle)) {
    throw new Error(`${label}: stale expectation still present: ${needle}`);
  }
}

const q239a = read('test/v172_q239a_workspace_camera_entry_button_test.dart');
const q277r3 = read('test/v172_q277r3_camera_ocr_runtime_premium_regression_tap_latency_cadence_test.dart');
const productionSurface = read('lib/features/mathlive/mathlive_production_editor_surface.dart');
const workspace = read('lib/features/workspace/workspace_panel.dart');

assertNotContains(
  q239a,
  "expect(workspace, contains('_openCameraCaptureShell(context)'));",
  'Q239A workspace camera entry test'
);
assertContains(q239a, "expect(workspace, contains('_openCameraCaptureShell('));", 'Q239A workspace camera entry test');
assertContains(
  q239a,
  "expect(workspace, contains('onApprovedLatexImport: onApprovedOcrWorkspaceImport'));",
  'Q239A workspace camera entry test'
);
assertContains(workspace, 'onApprovedLatexImport: onApprovedOcrWorkspaceImport', 'workspace production camera callback route');
assertContains(workspace, 'GaussCameraCaptureShell', 'workspace production camera callback route');

assertNotContains(
  q277r3,
  "expect(source, contains('unawaited(_emitState(\\n          reason: _lastProductionCommandTrace,\\n          lastCommandLabel: label,\\n        ));'));",
  'Q277R3 tap latency cadence test'
);
assertContains(
  q277r3,
  "MathLiveKeyboardLatencyClosureQ382R24Policy.syntheticDartEchoSuppressedForKeyboardCommands",
  'Q277R3 tap latency cadence test'
);
assertContains(
  q277r3,
  "if (!MathLiveKeyboardLatencyClosureQ382R24Policy.syntheticDartEchoSuppressedForKeyboardCommands)",
  'Q277R3 tap latency cadence test'
);
assertContains(q277r3, 'q382r24-fire-and-forget-js-dispatch', 'Q277R3 tap latency cadence test');
assertContains(
  productionSurface,
  'if (!MathLiveKeyboardLatencyClosureQ382R24Policy.syntheticDartEchoSuppressedForKeyboardCommands)',
  'production MathLive surface Q382R24 guarded echo'
);
assertContains(productionSurface, 'q382r24-fire-and-forget-js-dispatch', 'production MathLive surface Q382R24 dispatch marker');

console.log('PASS verify_stale_test_expectation_repair_v172_q382r24r1');
