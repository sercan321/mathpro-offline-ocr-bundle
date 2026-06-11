#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
const root = process.cwd();
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function check(condition, message) {
  if (!condition) {
    console.error(`Q387R7A VERIFY FAIL: ${message}`);
    process.exit(1);
  }
}
const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
const q387Test = read('test/v172_q387_paddle_lite_nb_model_format_decision_gate_test.dart');
const q387r2Test = read('test/v172_q387r2_paddle_lite_nb_source_download_install_binding_test.dart');
const q387r3Test = read('test/v172_q387r3_paddle_lite_nb_artifact_acquisition_protocol_test.dart');
const q387r4Test = read('test/v172_q387r4_paddle_lite_nb_production_source_binding_test.dart');
check(manager.includes('static const int sizeBytes = GaussCameraOcrDeferredModelDownloadQ384R1Policy.expectedPrimarySizeApproxBytes;'), 'model manager sizeBytes should be non-nullable int to remove analyzer info');
check(!manager.includes('static const int? sizeBytes'), 'model manager still declares nullable final const sizeBytes');
check(q387Test.includes('q387R1NbArtifactReady && supportsSetModelFromFile'), 'Q387 native bridge test must expect the stronger Q387R1 manifest evidence gate');
check(!q387Test.includes('q387IsPaddleLiteNbModelFile(nbModelFile) && supportsSetModelFromFile)'), 'Q387 native bridge test still expects stale pre-Q387R1 load condition');
check(q387r2Test.includes('const accepted = GaussQ387R2PaddleLiteNbSource('), 'Q387R2 accepted fixture should be a const declaration');
check(q387r2Test.includes('const rejected = GaussQ387R2PaddleLiteNbSource('), 'Q387R2 rejected fixture should be a const declaration');
check(!q387r2Test.includes('final accepted = const'), 'Q387R2 accepted fixture still uses final = const');
check(!q387r2Test.includes('final rejected = const'), 'Q387R2 rejected fixture still uses final = const');
check(q387r3Test.includes('const evidence = GaussQ387R3PaddleLiteNbAcquisitionEvidence('), 'Q387R3 evidence fixture should use const declaration');
check(!q387r3Test.includes('final evidence = const'), 'Q387R3 evidence fixture still uses final = const');
check(q387r4Test.includes('const placeholder = GaussQ387R3PaddleLiteNbAcquisitionEvidence('), 'Q387R4 placeholder fixture should use const declaration');
check(q387r4Test.includes('input: const GaussQ387R4PaddleLiteNbProductionSourceBindingInput(\n          acquisitionEvidence: placeholder,'), 'Q387R4 placeholder input should use const constructor after the placeholder fixture became const');
check(!q387r4Test.includes('final placeholder = const'), 'Q387R4 placeholder fixture must not regress to final = const');
for (const rel of [
  'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart',
  'test/v172_q387_paddle_lite_nb_model_format_decision_gate_test.dart',
  'test/v172_q387r2_paddle_lite_nb_source_download_install_binding_test.dart',
  'test/v172_q387r3_paddle_lite_nb_artifact_acquisition_protocol_test.dart',
  'test/v172_q387r4_paddle_lite_nb_production_source_binding_test.dart',
]) {
  const text = read(rel);
  check(!text.includes('ocrPassClaimed = true'), `${rel} must not claim OCR PASS`);
  check(!text.includes('androidRealDevicePassClaimed = true'), `${rel} must not claim Android real-device PASS`);
}
console.log('PASS verify_paddle_lite_nb_flutter_analyze_test_repair_v172_q387r7a');
