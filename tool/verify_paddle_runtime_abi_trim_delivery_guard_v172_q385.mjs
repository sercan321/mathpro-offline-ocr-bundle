#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_paddle_runtime_abi_trim_delivery_guard_v172_q385: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const buildGradle = read('android/app/build.gradle');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const policy = read('lib/features/camera/gauss_paddle_runtime_abi_trim_delivery_guard_q385.dart');
const test = read('test/v172_q385_paddle_runtime_abi_trim_delivery_guard_test.dart');

check(policy.includes("V172-Q385-PADDLE-RUNTIME-ABI-TRIM-AND-DELIVERY-GUARD"), 'Q385 policy phase missing');
check(policy.includes("base-apk-arm64-v8a-only-paddle-lite-runtime-model-download-only"), 'Q385 base runtime delivery mode missing');
check(policy.includes("modelBinaryBundledInBaseApp = false"), 'Q385 must keep model bytes out of base app');
check(policy.includes("ppFormulaNetSModelRemainsDeferredDownload = true"), 'Q385 must preserve deferred model download');
check(policy.includes("onnxRuntimeReintroducedInBaseApk = false"), 'Q385 must not reintroduce ONNX Runtime');
check(policy.includes("nativeRuntimeNetworkDownloadAllowed = false"), 'Q385 must not enable arbitrary native runtime download');
check(policy.includes("playFeatureDeliveryRuntimeModuleImplemented = false"), 'Q385 must not falsely claim Play Feature Delivery runtime module');
check(policy.includes("productionInferenceClaimedByQ385 = false"), 'Q385 must not claim OCR inference');

check(buildGradle.includes("abiFilters 'arm64-v8a'"), 'android/app/build.gradle must constrain release native runtime packaging to arm64-v8a');
check(!/abiFilters\s+['\"]armeabi-v7a['\"]/.test(buildGradle), 'Q385 abiFilters must not package legacy armeabi-v7a in base release');
check(!/abiFilters\s+['\"]x86_64['\"]/.test(buildGradle), 'Q385 abiFilters must not package x86_64 in base release');
check(buildGradle.includes("implementation files('libs/PaddlePredictor.jar')"), 'PaddlePredictor.jar must remain for current bridge');
check(!buildGradle.includes('onnxruntime-android'), 'ONNX Runtime Android AAR must remain removed');
check(!buildGradle.includes('com.microsoft.onnxruntime'), 'ONNX Runtime dependency coordinate must remain absent');

check(exists('android/app/libs/PaddlePredictor.jar'), 'PaddlePredictor.jar must remain present');
check(exists('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'), 'arm64-v8a Paddle Lite library must remain present');
check(exists('android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so'), 'legacy armeabi-v7a source file may remain as rollback source, but Gradle must not package it in Q385 base release');

for (const required of [
  'import android.os.Build',
  'private val q385Phase = "V172-Q385-PADDLE-RUNTIME-ABI-TRIM-AND-DELIVERY-GUARD"',
  'private val q385Status = "PADDLE_LITE_BASE_RUNTIME_ARM64_ONLY_MODEL_DOWNLOAD_ONLY_NO_DYNAMIC_NATIVE_CODE"',
  'private val q385BaseRuntimeDeliveryMode = "base-apk-arm64-v8a-only-paddle-lite-runtime-model-download-only"',
  'private val q385BaseRuntimeAbi = "arm64-v8a"',
  '"paddleRuntimeDeliveryDecisionQ385" -> result.success',
  'private fun q385PaddleRuntimeDeliveryDecision(method: String): Map<String, Any>',
  '"nativeRuntimeNetworkDownloadAllowed" to q385NativeRuntimeNetworkDownloadAllowed',
  '"playFeatureDeliveryImplemented" to q385PlayFeatureDeliveryImplemented',
  '"onnxRuntimeReintroducedInBaseApk" to q385OnnxRuntimeReintroducedInBaseApk',
  '"ocrPassClaimed" to false',
]) {
  check(mainActivity.includes(required), `Q385 native bridge marker missing: ${required}`);
}

for (const required of [
  'GaussPaddleRuntimeAbiTrimDeliveryGuardQ385Policy',
  "abiFilters 'arm64-v8a'",
  'nativeRuntimeNetworkDownloadAllowed, isFalse',
  'playFeatureDeliveryRuntimeModuleImplemented, isFalse',
  'productionInferenceClaimedByQ385, isFalse',
]) {
  check(test.includes(required), `Q385 Flutter test marker missing: ${required}`);
}

const forbiddenModelExt = /\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors)$/i;
const ignored = (p) => p.includes('/build/') || p.startsWith('build/') || p.includes('/.dart_tool/') || p.startsWith('.dart_tool/') || p.startsWith('docs/evidence/');
const modelArtifacts = [];
const walk = (dir) => {
  for (const entry of fs.readdirSync(path.join(root, dir), { withFileTypes: true })) {
    const rel = path.posix.join(dir, entry.name);
    if (ignored(rel)) continue;
    if (entry.isDirectory()) walk(rel);
    else if (forbiddenModelExt.test(rel)) modelArtifacts.push(rel);
  }
};
walk('.');
check(modelArtifacts.length === 0, `Q385 must not bundle model artifacts: ${modelArtifacts.join(', ')}`);

for (const rel of [
  'docs/audit/V172_Q385_PADDLE_RUNTIME_ABI_TRIM_AND_DELIVERY_GUARD.md',
  'docs/audit/V172_Q385_CHANGED_FILES.md',
]) {
  check(exists(rel), `Q385 audit artifact missing: ${rel}`);
}

console.log('PASS verify_paddle_runtime_abi_trim_delivery_guard_v172_q385');
