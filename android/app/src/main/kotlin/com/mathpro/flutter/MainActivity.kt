package com.mathpro.flutter

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Color
import android.graphics.Matrix
import android.media.ExifInterface
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.ImageView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.nio.FloatBuffer
import java.security.MessageDigest
import org.json.JSONObject
import org.json.JSONArray

class MainActivity : FlutterActivity() {
    private val nativeSplashChannelName = "mathpro/native_splash"
    private val ocrRuntimeBridgeChannelName = "mathpro/ocr_runtime_bridge"
    private val q317Phase = "V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG"
    private val q317ExpectedArtifactSha256 = "b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489"
    private val q317RuntimeBridgeFeatureEnabled = false
    private val q318Phase = "V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION"
    private val q318PrivateStorageFeatureEnabled = false
    private val q318PrivateModelDirectoryName = "ocr_models/PP-FormulaNet-S"
    private val q318PrivateModelArtifactFileName = "inference.pdiparams"
    private val q319Phase = "V172-Q319-VERIFIED-ARTIFACT-LOAD-SMOKE-ON-DEVICE"
    private val q319VerifiedArtifactLoadSmokeFeatureEnabled = false
    private val q320Phase = "V172-Q320-RUNTIME-STARTUP-SMOKE-ON-DEVICE"
    private val q320RuntimeStartupSmokeFeatureEnabled = false
    private val q321Phase = "V172-Q321-DUMMY-INPUT-RUNTIME-CALL"
    private val q321DummyRuntimeCallFeatureEnabled = false
    private val q321DummyPayloadLabel = "q321-deterministic-dummy-input-no-runtime"
    private val q322Phase = "V172-Q322-FIRST-IMAGE-TO-LATEX-INFERENCE-ENVELOPE"
    private val q322FirstImageToLatexFeatureEnabled = false
    private val q322ImageInputLabel = "q322-image-input-placeholder-no-runtime"
    private val q323Phase = "V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION"
    private val q323RuntimeDependencyDecisionFeatureEnabled = false
    private val q323SelectedRuntimeDependency = "UNSELECTED_PENDING_APPROVED_ANDROID_COMPATIBLE_RUNTIME_EVIDENCE"
    private val q323SelectedModelLoader = "NONE_PENDING_APPROVED_RUNTIME_DEPENDENCY"
    private val q324Phase = "V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG"
    private val q324ApprovedRuntimeDependencyTrialFeatureEnabled = false
    private val q324SelectedRuntimeDependency = "UNSELECTED_PENDING_BUILD_COMPATIBLE_RUNTIME_COORDINATES"
    private val q324SelectedModelLoader = "NONE_PENDING_APPROVED_RUNTIME_DEPENDENCY"
    private val q324ApprovedRuntimeDependencyTrialStatus = "APPROVED_RUNTIME_DEPENDENCY_TRIAL_BLOCKED_PENDING_USER_Q323_FLUTTER_LOG_AND_RUNTIME_COORDINATE_EVIDENCE_DEFAULT_OFF"

    private val q325Phase = "V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE"
    private val q325RuntimeDependencyCoordinateSelectionFeatureEnabled = false
    private val q325SelectedRuntimeDependencyCandidate = "PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING"
    private val q325SelectedModelLoaderCandidate = "PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE"
    private val q325SelectedRuntimeDependencyCoordinate = "NO_MAVEN_COORDINATE_SELECTED_MANUAL_NATIVE_LIBRARY_TRIAL_REQUIRED"
    private val q325RuntimeDependencyCoordinateSelectionStatus = "RUNTIME_DEPENDENCY_COORDINATE_SELECTION_RECORDED_BUILD_TRIAL_BLOCKED_NO_GRADLE_MUTATION_DEFAULT_OFF"

    private val q326Phase = "V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT"
    private val q326NativeLibraryBuildTrialPreflightFeatureEnabled = false
    private val q326NativeLibraryBuildTrialPreflightStatus = "NATIVE_LIBRARY_BUILD_TRIAL_PREFLIGHT_BLOCKED_NO_NATIVE_LIBRARY_BUNDLE_DEFAULT_OFF"
    private val q326NativeLibrarySourceCandidate = "PADDLE_LITE_ANDROID_INFERENCE_LIBRARY_DOWNLOAD_OR_BUILD_REQUIRED_NOT_BUNDLED"
    private val q326ModelConversionCandidate = "PADDLE_LITE_OPT_TOOL_CONVERSION_REQUIRED_BEFORE_MODEL_LOAD_NOT_EXECUTED"

    private val q327Phase = "V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK"
    private val q327NativeLibrarySourcePackageApprovalFeatureEnabled = false
    private val q327NativeLibrarySourcePackageApprovalStatus = "NATIVE_LIBRARY_SOURCE_PACKAGE_APPROVAL_ABI_MATRIX_LOCKED_NO_BINARY_BUNDLE_DEFAULT_OFF"
    private val q327ApprovedNativeLibrarySourcePackage = "PADDLE_LITE_ANDROID_PREDICTION_LIBRARY_RELEASE_OR_SELF_COMPILED_PACKAGE_PENDING_USER_APPROVAL"
    private val q327RequiredPrimaryAbi = "arm64-v8a"
    private val q327OptionalLegacyAbi = "armeabi-v7a"
    private val q327EmulatorAbi = "x86_64"

    private val q328Phase = "V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE"
    private val q328NativeLibraryPackageFileHashIntakeFeatureEnabled = false
    private val q328NativeLibraryPackageFileHashIntakeStatus = "NATIVE_LIBRARY_PACKAGE_FILE_HASH_INTAKE_BLOCKED_NO_NATIVE_PACKAGE_HASH_EVIDENCE_DEFAULT_OFF"
    private val q328ExternalNativePackageEvidencePolicy = "../MathProOcrNativePackages/Paddle_Lite_Android"
    private val q328NativePackageEvidenceFileName = "q328_native_library_package_hash_evidence.json"

    private val q329Phase = "V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE"
    private val q329NativePackageHashEvidenceReviewFeatureEnabled = false
    private val q329NativePackageHashEvidenceReviewStatus = "NATIVE_PACKAGE_HASH_EVIDENCE_REVIEW_BLOCKED_PENDING_USER_NATIVE_PACKAGE_HASH_EVIDENCE_DEFAULT_OFF"
    private val q329BinaryBundleApprovalStatus = "BLOCKED_UNTIL_PER_FILE_SHA256_EVIDENCE_IS_PROVIDED_AND_USER_APPROVES_BINARY_BUNDLE"

    private val q330Phase = "V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF"
    private val q330BinaryBundleTrialFeatureEnabled = false
    private val q330BinaryBundleTrialStatus = "BINARY_BUNDLE_TRIAL_BLOCKED_PENDING_NATIVE_PACKAGE_HASH_EVIDENCE_AND_USER_APPROVAL_DEFAULT_OFF"
    private val q330FutureAndroidAppLibsDirectory = "android/app/libs"
    private val q330FutureJniLibsDirectory = "android/app/src/main/jniLibs"
    private val q330FuturePaddlePredictorJarPath = "android/app/libs/PaddlePredictor.jar"


    private val q331Phase = "V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE"
    private val q331NativePackageHashEvidenceAcceptanceFeatureEnabled = false
    private val q331NativePackageHashEvidenceAcceptanceStatus = "NATIVE_PACKAGE_HASH_EVIDENCE_ACCEPTANCE_BLOCKED_PENDING_USER_NATIVE_PACKAGE_HASH_EVIDENCE_DEFAULT_OFF"
    private val q331BundlePermissionStatus = "BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_IS_PROVIDED_REVIEWED_AND_EXPLICITLY_APPROVED"

    private val q332Phase = "V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE"
    private val q332ActualBinaryBundleGateFeatureEnabled = false
    private val q332ActualBinaryBundleGateStatus = "ACTUAL_BINARY_BUNDLE_BLOCKED_PENDING_NATIVE_PACKAGE_HASH_EVIDENCE_AND_EXPLICIT_USER_APPROVAL_DEFAULT_OFF"
    private val q332BundlePermissionStatus = "BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_AND_EXPLICIT_USER_BINARY_BUNDLE_APPROVAL_ARE_PROVIDED"


    private val q333Phase = "V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW"
    private val q333NativePackageHashEvidenceIntakeReviewFeatureEnabled = false
    private val q333NativePackageHashEvidenceIntakeReviewStatus = "NATIVE_PACKAGE_HASH_EVIDENCE_INTAKE_REVIEW_BLOCKED_PENDING_Q328_EVIDENCE_JSON_AND_EXPLICIT_USER_BUNDLE_APPROVAL_DEFAULT_OFF"
    private val q333BundlePermissionStatus = "BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_AND_EXPLICIT_USER_BINARY_BUNDLE_APPROVAL_ARE_REVIEWED"


    private val q334Phase = "V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE"
    private val q334ActualBinaryBundlePlacementGateFeatureEnabled = false
    private val q334ActualBinaryBundlePlacementGateStatus = "ACTUAL_BINARY_BUNDLE_PLACEMENT_BLOCKED_PENDING_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_AND_EXPLICIT_USER_APPROVAL_DEFAULT_OFF"
    private val q334BundlePermissionStatus = "BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_AND_EXPLICIT_USER_BINARY_BUNDLE_APPROVAL_ARE_PROVIDED"


    private val q335Phase = "V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE"
    private val q335NativePackageHashEvidenceCollectionIntakeFeatureEnabled = false
    private val q335NativePackageHashEvidenceCollectionIntakeStatus = "NATIVE_PACKAGE_HASH_EVIDENCE_COLLECTION_INTAKE_BLOCKED_PENDING_USER_SIDE_NATIVE_PACKAGE_FILES_DEFAULT_OFF"
    private val q335BundlePermissionStatus = "BLOCKED_UNTIL_USER_SIDE_NATIVE_PACKAGE_FILES_AND_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_ARE_PROVIDED_AND_EXPLICITLY_APPROVED"

    private val q336Phase = "V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE"
    private val q336NativePackageHashEvidenceCaptureQ328JsonIntakeFeatureEnabled = false
    private val q336NativePackageHashEvidenceCaptureQ328JsonIntakeStatus = "NATIVE_PACKAGE_HASH_EVIDENCE_CAPTURE_Q328_JSON_INTAKE_BLOCKED_PENDING_USER_SIDE_NATIVE_PACKAGE_FILES_DEFAULT_OFF"
    private val q336BundlePermissionStatus = "BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_EXISTS_MATCHES_REQUIRED_FILES_AND_USER_APPROVES_BINARY_BUNDLE"


    private val q337Phase = "V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE"
    private val q337NativePackageHashEvidenceAcceptanceExplicitBundleApprovalFeatureEnabled = false
    private val q337NativePackageHashEvidenceAcceptanceExplicitBundleApprovalStatus = "NATIVE_PACKAGE_HASH_EVIDENCE_ACCEPTANCE_EXPLICIT_BUNDLE_APPROVAL_BLOCKED_PENDING_Q328_JSON_AND_USER_APPROVAL_DEFAULT_OFF"
    private val q337BundlePermissionStatus = "BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_IS_REVIEWED_AND_USER_EXPLICITLY_APPROVES_BINARY_BUNDLE"


    private val q338Phase = "V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE"
    private val q338ActualBinaryBundleNoEvidenceBlockedGateFeatureEnabled = false
    private val q338ActualBinaryBundleNoEvidenceBlockedGateStatus = "ACTUAL_BINARY_BUNDLE_BLOCKED_NO_Q328_NATIVE_HASH_EVIDENCE_NO_USER_APPROVAL_UI_PROTECTED_DEFAULT_OFF"
    private val q338BundlePermissionStatus = "BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_AND_EXPLICIT_USER_BINARY_BUNDLE_APPROVAL_ARE_PROVIDED"
    private val q338UiProtectionStatus = "UI_PROTECTED_NO_WORKSPACE_KEYBOARD_MATHLIVE_GRAPH_SOLUTION_HISTORY_SPLASH_CHANGE"


    private val q339Phase = "V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK"
    private val q339FeatureEnabled = false
    private val q339Status = "NATIVE_PACKAGE_HASH_EVIDENCE_CAPTURE_ACTUAL_BUNDLE_PERMISSION_FINAL_CHECK_BLOCKED_PENDING_Q328_JSON_AND_EXPLICIT_USER_APPROVAL_DEFAULT_OFF"
    private val q339FinalBundlePermissionStatus = "BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_IS_ACCEPTED_AND_USER_EXPLICITLY_APPROVES_BINARY_BUNDLE"
    private val q339UiProtectionStatus = "UI_PROTECTED_NO_WORKSPACE_KEYBOARD_MORE_LONGPRESS_MATHLIVE_GRAPH_SOLUTION_HISTORY_SPLASH_ICON_CHANGE"


    private val q340Phase = "V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE"
    private val q340FeatureEnabled = false
    private val q340Status = "ACTUAL_BINARY_BUNDLE_JNILIBS_PADDLEPREDICTOR_BLOCKED_PENDING_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_USER_APPROVAL_AND_FLUTTER_LOG_DEFAULT_OFF"
    private val q340BinaryBundleStatus = "BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_IS_ACCEPTED_USER_EXPLICITLY_APPROVES_BINARY_BUNDLE_AND_Q339_OR_NEWER_FLUTTER_LOG_IS_CLEAN"
    private val q340UiProtectionStatus = "UI_PROTECTED_NO_WORKSPACE_KEYBOARD_MORE_LONGPRESS_MATHLIVE_GRAPH_SOLUTION_HISTORY_SPLASH_ICON_CHANGE"


    private val q341Phase = "V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE"
    private val q341FeatureEnabled = false
    private val q341Status = "NATIVE_PACKAGE_HASH_EVIDENCE_CAPTURE_BUNDLE_EVIDENCE_ACCEPTANCE_BLOCKED_PENDING_Q328_JSON_USER_APPROVAL_AND_CLEAN_FLUTTER_LOG_DEFAULT_OFF"
    private val q341BundleEvidenceAcceptanceStatus = "BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_IS_CAPTURED_ACCEPTED_USER_EXPLICITLY_APPROVES_BINARY_BUNDLE_AND_Q340_OR_NEWER_FLUTTER_LOG_IS_CLEAN"
    private val q341UiProtectionStatus = "UI_PROTECTED_NO_WORKSPACE_KEYBOARD_MORE_LONGPRESS_MATHLIVE_GRAPH_SOLUTION_HISTORY_SPLASH_ICON_CHANGE"


    private val q342Phase = "V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED"
    private val q342FeatureEnabled = false
    private val q342Status = "ACTUAL_BINARY_BUNDLE_JNILIBS_PADDLEPREDICTOR_BLOCKED_PENDING_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_USER_APPROVAL_AND_CLEAN_FLUTTER_LOG_DEFAULT_OFF"
    private val q342BundlePermissionStatus = "BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_IS_ACCEPTED_USER_EXPLICITLY_APPROVES_BINARY_BUNDLE_AND_Q341_OR_NEWER_FLUTTER_LOG_IS_CLEAN"
    private val q342UiProtectionStatus = "UI_PROTECTED_NO_WORKSPACE_KEYBOARD_MORE_LONGPRESS_MATHLIVE_GRAPH_SOLUTION_HISTORY_SPLASH_ICON_CHANGE"



    private val q343Phase = "V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE"
    private val q343FeatureEnabled = false
    private val q343Status = "NATIVE_PACKAGE_HASH_EVIDENCE_FINAL_ACCEPTANCE_REAL_BUNDLE_UNLOCK_BLOCKED_PENDING_Q328_JSON_USER_APPROVAL_AND_Q342_OR_NEWER_CLEAN_FLUTTER_LOG_DEFAULT_OFF"
    private val q343BundleUnlockStatus = "BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_IS_ACCEPTED_USER_EXPLICITLY_APPROVES_BINARY_BUNDLE_AND_Q342_OR_NEWER_FLUTTER_ANALYZE_TEST_RUN_LOG_IS_CLEAN"
    private val q343UiProtectionStatus = "UI_PROTECTED_NO_WORKSPACE_KEYBOARD_MORE_LONGPRESS_MATHLIVE_GRAPH_SOLUTION_HISTORY_SPLASH_ICON_CHANGE"

    private val q346Phase = "V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE"
    private val q346FeatureEnabled = false
    private val q346Status = "NATIVE_LIBRARY_LOAD_SMOKE_GUARDED_DEFAULT_OFF_PENDING_USER_REAL_DEVICE_INVOCATION"
    private val q346PaddleLiteNativeLibraryName = "paddle_lite_jni"
    private val q346PrimaryAbi = "arm64-v8a"
    private val q346LegacyAbi = "armeabi-v7a"
    private val q346UiProtectionStatus = "UI_PROTECTED_NO_WORKSPACE_KEYBOARD_MORE_LONGPRESS_MATHLIVE_GRAPH_SOLUTION_HISTORY_SPLASH_ICON_CHANGE"
    private var q346NativeLibraryLoaded = false

    private val q347Phase = "V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE"
    private val q347FeatureEnabled = false
    private val q347Status = "PADDLE_LITE_PREDICTOR_INSTANTIATE_SMOKE_GUARDED_DEFAULT_OFF_PENDING_USER_REAL_DEVICE_INVOCATION"
    private val q347PredictorClassName = "com.baidu.paddle.lite.Paddle" + "Predictor"
    private val q347ConfigClassName = "com.baidu.paddle.lite.Mobile" + "Config"
    private val q347ConfigBaseClassName = "com.baidu.paddle.lite.Config" + "Base"
    private val q347CreatePredictorMethodName = "create" + "Paddle" + "Predictor"
    private val q347UiProtectionStatus = "UI_PROTECTED_NO_WORKSPACE_KEYBOARD_MORE_LONGPRESS_MATHLIVE_GRAPH_SOLUTION_HISTORY_SPLASH_ICON_CHANGE"


    private val q357Phase = "V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION"
    private val q357FeatureEnabled = false
    private val q357Status = "ONNX_REAL_MODEL_LOAD_SMOKE_BRIDGE_PRESENT_DEFAULT_OFF_NO_AUTO_EXECUTION_NO_OCR"
    private val q389R6BPhase = "V172-Q389R6B-ONNX-RUNTIME-MOBILE-DOWNLOAD-ONLY-INTEGRATION"
    private val q389R6BSelectedDependencyCoordinate = "com.microsoft." + "onnx" + "runtime:onnx" + "runtime-android:1.20.0"
    private val q389R6BInstallDirectoryName = "ocr_models/PP-FormulaNet_plus-S-ONNX"
    private val q389R6BOnnxModelFileName = "pp_formulanet_plus_s.onnx"
    private val q389R6BExpectedOnnxSha256 = "575353f72a804215329b128ed1b85e8de65fdb4b06730ac8e7954bae5c44e64d"
    private val q389R6BExpectedOnnxSizeBytes = 333913240L
    private val q389R6BNativeRuntimeManifestFileName = "q389r6b_onnx_runtime_manifest.json"
    private val q389R6BPrimaryEngine = "ONNX Runtime Mobile device-only FormulaRecognition / PP-FormulaNet_plus-S"
    private val q357SelectedDependencyCoordinate = q389R6BSelectedDependencyCoordinate
    private val q357OnnxModelFileName = q389R6BOnnxModelFileName
    private val q357ExpectedOnnxSha256 = q389R6BExpectedOnnxSha256
    private val q357ExpectedOnnxSizeBytes = q389R6BExpectedOnnxSizeBytes
    private val q357UiProtectionStatus = "UI_PROTECTED_NO_WORKSPACE_KEYBOARD_MORE_LONGPRESS_MATHLIVE_GRAPH_SOLUTION_HISTORY_SPLASH_ICON_CHANGE"
    private val q358Phase = "V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT"
    private val q358FeatureEnabled = false
    private val q358Status = "ONNX_DUMMY_INPUT_RUNTIME_CALL_GUARD_PRESENT_DEFAULT_OFF_NO_AUTO_EXECUTION_NO_OCR"
    private val q358SelectedDependencyCoordinate = q357SelectedDependencyCoordinate
    private val q358OnnxModelFileName = q357OnnxModelFileName
    private val q358ExpectedOnnxSha256 = q357ExpectedOnnxSha256
    private val q358ExpectedOnnxSizeBytes = q357ExpectedOnnxSizeBytes
    private val q358UiProtectionStatus = q357UiProtectionStatus
    private val q359Phase = "V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT"
    private val q359FeatureEnabled = false
    private val q359Status = "FIRST_REAL_IMAGE_TO_LATEX_INFERENCE_GUARD_CANDIDATE_ENVELOPE_PREFLIGHT_DEFAULT_OFF_NO_OCR"
    private val q359SelectedDependencyCoordinate = q357SelectedDependencyCoordinate
    private val q359OnnxModelFileName = q357OnnxModelFileName
    private val q359ExpectedOnnxSha256 = q357ExpectedOnnxSha256
    private val q359ExpectedOnnxSizeBytes = q357ExpectedOnnxSizeBytes
    private val q359UiProtectionStatus = q357UiProtectionStatus
    private val q361Phase = "V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE"
    private val q361FeatureEnabled = false
    private val q361Status = "CAMERA_OCR_RUNTIME_EXECUTION_BRIDGE_DEFAULT_OFF_NO_AUTO_RUN_REVIEW_APPROVAL_REQUIRED"
    private val q361SelectedDependencyCoordinate = q357SelectedDependencyCoordinate
    private val q361OnnxModelFileName = q357OnnxModelFileName
    private val q361ExpectedOnnxSha256 = q357ExpectedOnnxSha256
    private val q361ExpectedOnnxSizeBytes = q357ExpectedOnnxSizeBytes
    private val q361UiProtectionStatus = q357UiProtectionStatus
    private val q364Phase = "V172-Q364-ONNX-MODEL-ARTIFACT-PRIVATE-STORAGE-ACTIVATION"
    private val q364FeatureEnabled = true
    private val q364Status = "ONNX_MODEL_ARTIFACT_PRIVATE_STORAGE_ACTIVATION_EXPLICIT_INVOCATION_ONLY_NO_AUTO_RUN_NO_OCR"
    private val q364SelectedDependencyCoordinate = q357SelectedDependencyCoordinate
    private val q364OnnxModelFileName = q357OnnxModelFileName
    private val q364ExpectedOnnxSha256 = q357ExpectedOnnxSha256
    private val q364ExpectedOnnxSizeBytes = q357ExpectedOnnxSizeBytes
    private val q364UiProtectionStatus = q357UiProtectionStatus
    private val q365Phase = "V172-Q365-ONNX-REAL-MODEL-LOAD-SMOKE-EXECUTION"
    private val q365FeatureEnabled = true
    private val q365Status = "ONNX_REAL_MODEL_LOAD_SMOKE_EXECUTION_EXPLICIT_INVOCATION_ONLY_NO_AUTO_RUN_NO_OCR"
    private val q365SelectedDependencyCoordinate = q357SelectedDependencyCoordinate
    private val q365OnnxModelFileName = q357OnnxModelFileName
    private val q365ExpectedOnnxSha256 = q357ExpectedOnnxSha256
    private val q365ExpectedOnnxSizeBytes = q357ExpectedOnnxSizeBytes
    private val q365UiProtectionStatus = q357UiProtectionStatus
    private val q366Phase = "V172-Q366-ONNX-DUMMY-INPUT-RUNTIME-CALL-EXECUTION"
    private val q366FeatureEnabled = true
    private val q366Status = "ONNX_DUMMY_INPUT_RUNTIME_CALL_EXECUTION_EXPLICIT_INVOCATION_ONLY_NO_AUTO_RUN_NO_OCR"
    private val q366SelectedDependencyCoordinate = q357SelectedDependencyCoordinate
    private val q366OnnxModelFileName = q357OnnxModelFileName
    private val q366ExpectedOnnxSha256 = q357ExpectedOnnxSha256
    private val q366ExpectedOnnxSizeBytes = q357ExpectedOnnxSizeBytes
    private val q366UiProtectionStatus = q357UiProtectionStatus
    private val q367Phase = "V172-Q367-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE"
    private val q367FeatureEnabled = true
    private val q367Status = "FIRST_REAL_IMAGE_TO_LATEX_INFERENCE_EXPLICIT_INVOCATION_ONLY_CANDIDATE_ENVELOPE_NO_AUTO_IMPORT"
    private val q367SelectedDependencyCoordinate = q357SelectedDependencyCoordinate
    private val q367OnnxModelFileName = q357OnnxModelFileName
    private val q367ExpectedOnnxSha256 = q357ExpectedOnnxSha256
    private val q367ExpectedOnnxSizeBytes = q357ExpectedOnnxSizeBytes
    private val q367UiProtectionStatus = q357UiProtectionStatus
    private val q367CandidateEnvelopeVersion = "q367-candidate-envelope-v1-explicit-image-inference"
    private val q367ImageTensorHeight = 224
    private val q367ImageTensorWidth = 224
    private val q368Phase = "V172-Q368-EDITABLE-MATHLIVE-OCR-REVIEW-ACTIVATION"
    private val q368FeatureEnabled = true
    private val q368Status = "EDITABLE_MATHLIVE_OCR_REVIEW_ACTIVATION_EXPLICIT_HANDOFF_ONLY_NO_DIRECT_IMPORT"
    private val q368UiProtectionStatus = q357UiProtectionStatus
    private val q368CandidateEnvelopeVersion = "q368-editable-mathlive-review-envelope-v1"
    private val q368MathLiveReviewTarget = "MathLiveProductionEditorSurface-review-handoff-contract"
    private val q369Phase = "V172-Q369-APPROVED-OCR-WORKSPACE-IMPORT-ACTIVATION"
    private val q369FeatureEnabled = true
    private val q369Status = "APPROVED_OCR_WORKSPACE_IMPORT_ACTIVATION_EXPLICIT_USER_APPROVAL_ONLY_NO_AUTO_SOLVE"
    private val q369UiProtectionStatus = q357UiProtectionStatus
    private val q369ApprovedImportEnvelopeVersion = "q369-approved-workspace-import-envelope-v1"
    private val q369WorkspaceImportTarget = "WorkspaceMathLiveInput-approved-import-contract"
    private val q371Phase = "V172-Q371-CONTROLLED-OCR-ACTIVATION-RUNTIME-EVIDENCE-CAPTURE"
    private val q371FeatureEnabled = true
    private val q371Status = "CONTROLLED_OCR_ACTIVATION_RUNTIME_EVIDENCE_CAPTURE_EXPLICIT_INVOCATION_ONLY_NO_AUTO_IMPORT_NO_AUTO_SOLVE"
    private val q371UiProtectionStatus = q357UiProtectionStatus
    private val q371EvidenceEnvelopeVersion = "q371-controlled-ocr-activation-evidence-envelope-v1"
    private val q375Phase = "V172-Q375-REAL-OCR-EXECUTION-OUTPUT-DECODER-CLOSURE"
    private val q375FeatureEnabled = true
    private val q375Status = "REAL_OCR_EXECUTION_OUTPUT_DECODER_CLOSURE_EXPLICIT_INVOCATION_ONLY_REVIEW_FIRST_NO_AUTO_IMPORT"
    private val q375UiProtectionStatus = q357UiProtectionStatus
    private val q375DecoderVersion = "q375-output-decoder-closure-v1-safe-candidate-extraction"
    private val q379Phase = "V172-Q379-REAL-ONNX-OUTPUT-DECODER-CANDIDATE-EXTRACTION-BINDING"
    private val q379Status = "REAL_ONNX_OUTPUT_DECODER_CANDIDATE_EXTRACTION_BINDING_GENERIC_SAFE_DECODER"
    private val q379DecoderVersion = "q379-generic-onnx-output-string-ascii-token-vocabulary-decoder-v1"
    private val q384Phase = "V172-Q384-BASE-APK-OCR-RUNTIME-SLIMMING-DOWNLOAD-ONLY-CONTRACT"
    private val q384Status = "ONNX_RUNTIME_REMOVED_FROM_BASE_APK_DOWNLOAD_ONLY_OCR_CONTRACT_ACTIVE"
    private val q384OnnxRuntimeBundledInBaseApk = false
    private val q384OnnxRuntimeRemovedDependencyCoordinate = "com.microsoft." + "onnx" + "runtime:onnx" + "runtime-android:1.26.0"
    private val q384DownloadOnlyOcrRuntimeContract = "BASE_APK_HAS_CAMERA_AND_MODEL_DOWNLOAD_UI_ONLY_NO_ONNX_RUNTIME_OR_MODEL_BUNDLED"
    private val q384R2Phase = "V172-Q384R2-CAMERA-OCR-RUNTIME-MODEL-FORMAT-BINDING-PREFLIGHT"
    private val q384R2Status = "PADDLE_INFERENCE_MODEL_ARTIFACT_ALIGNED_RUNTIME_BINDING_NOT_CLAIMED"
    private val q384R2ArtifactFormat = "paddle-inference-directory"
    private val q384R2PrimaryModelFileName = "inference.pdiparams"
    private val q384R2ExpectedPrimarySha256 = "b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489"
    private val q384R2MinimumPrimarySizeBytes = 200L * 1024L * 1024L
    private val q384R2RequiredArtifactFileNames = listOf("config.json", "inference.json", "inference.yml", q384R2PrimaryModelFileName)
    private val q384R2RuntimeBindingBlockedReason = "q384r2-paddle-runtime-binding-not-enabled"
    private val q385Phase = "V172-Q385-PADDLE-RUNTIME-ABI-TRIM-AND-DELIVERY-GUARD"
    private val q385Status = "PADDLE_LITE_BASE_RUNTIME_ARM64_ONLY_MODEL_DOWNLOAD_ONLY_NO_DYNAMIC_NATIVE_CODE"
    private val q385BaseRuntimeDeliveryMode = "base-apk-arm64-v8a-only-paddle-lite-runtime-model-download-only"
    private val q385BaseRuntimeAbi = "arm64-v8a"
    private val q385GradleAbiFilterContract = "abiFilters 'arm64-v8a'"
    private val q385NativeRuntimeNetworkDownloadAllowed = false
    private val q385PlayFeatureDeliveryImplemented = false
    private val q385OnnxRuntimeReintroducedInBaseApk = false
    private val q386Phase = "V172-Q386-REAL-PADDLE-OCR-INFERENCE-BRIDGE"
    private val q386Status = "PADDLE_RUNTIME_LOAD_AND_IMAGE_TENSOR_INFERENCE_BRIDGE_ATTEMPTED_REVIEW_FIRST_NO_PASS_CLAIM"
    private val q386BridgeMethod = "realPaddleOcrInferenceBridgeQ386"
    private val q386PreservedQ384R2PreflightMarker = "q380-q384r2-model-format-binding-preflight"
    private val q386SourcePhase = q385Phase
    private val q386ModelLoadAttemptEnabled = true
    private val q386ImageTensorInferenceAttemptEnabled = true
    private val q386NoFakeLatexCandidate = true
    private val q386ReviewRequiredBeforeWorkspaceImport = true
    private val q386OcrPassClaimed = false
    private val q386ExpectedMobileConfigModelFileMode = "paddle-lite-optimized-model-file-or-compatible-artifact"
    private val q386CurrentDownloadedArtifactFormat = q384R2ArtifactFormat
    private val q386IncompatibleArtifactBlockedReason = "q386-paddle-lite-model-load-failed-or-artifact-format-incompatible"
    private val q387Phase = "V172-Q387-PADDLE-LITE-NB-MODEL-FORMAT-DECISION-GATE"
    private val q387SourcePhase = q386Phase
    private val q387Status = "PADDLE_LITE_MOBILECONFIG_API_INVENTORIED_NB_MODEL_REQUIRED_NO_INFERENCE_DIRECTORY_LOAD_CLAIM"
    private val q387RequiredAndroidArtifactFormat = "paddle-lite-optimized-nb"
    private val q387CurrentDownloadedArtifactFormat = q384R2ArtifactFormat
    private val q387RequiredModelFileExtension = ".nb"
    private val q387SetModelFromFileMethodName = "setModelFromFile"
    private val q387SetModelFromBufferMethodName = "setModelFromBuffer"
    private val q387SetModelDirMethodName = "setModelDir"
    private val q387NbModelRequiredBlockedReason = "q387-paddle-lite-nb-model-required"
    private val q387InferenceDirectoryRejectedReason = "q387-paddle-inference-directory-not-loadable-by-current-mobileconfig"
    private val q387SetModelDirUnavailableReason = "q387-current-paddlepredictor-jar-has-no-setModelDir"
    private val q387LegacyVerifiedNbStrategyAlias = "q387-setModelFromFile-paddle-lite-nb"
    private val q387ProductionInferencePassClaimed = false
    private val q387R1Phase = "V172-Q387R1-PADDLE-LITE-NB-ARTIFACT-MANIFEST-EVIDENCE-GATE"
    private val q387R1SourcePhase = q387Phase
    private val q387R1Status = "REAL_PADDLE_LITE_NB_ARTIFACT_REQUIRED_DOWNLOAD_ONLY_MANIFEST_BLOCKED_PENDING_URL_SHA_SIZE_PROVENANCE"
    private val q387R1RequiredArtifactKind = "paddle-lite-optimized-nb"
    private val q387R1RequiredManifestFileName = "q387r1_paddle_lite_nb_manifest.json"
    private val q387R1RealNbEvidenceRequiredBlockedReason = "q387r1-real-paddle-lite-nb-artifact-evidence-required"
    private val q387R1ManifestMissingBlockedReason = "q387r1-nb-manifest-missing"
    private val q387R1ManifestInvalidBlockedReason = "q387r1-nb-manifest-invalid"
    private val q387R1ShaMismatchBlockedReason = "q387r1-nb-sha256-mismatch"
    private val q387R1ArtifactKindMismatchBlockedReason = "q387r1-nb-artifact-kind-mismatch"
    private val q387R1MinimumNbSizeBytes = 1024L * 1024L
    private val q387R1ProductionNbArtifactBundledInBaseApp = false
    private val q387R1ProductionInferencePassClaimed = false
    private val q379VocabularyFileNames = listOf(
        "q389r6b_tokens.txt",
        "pp_formulanet_plus_s_vocab.txt",
        "pp_formulanet_plus_s_tokens.txt",
        "pp_formulanet_plus_l_vocab.txt",
        "pp_formulanet_plus_l_tokens.txt",
        "pp_formulanet_plus_vocab.txt",
        "pp_formulanet_plus_tokens.txt",
        "pp_formulanet_s_vocab.txt",
        "pp_formulanet_s_tokens.txt",
        "vocab.txt",
        "tokens.txt",
        "latex_vocab.txt",
        "tokenizer.json",
        "formula_tokenizer.json",
        "model_vocab.json"
    )
    private val q380Phase = "V172-Q380-OCR-RUNTIME-READINESS-ADAPTIVE-INPUT-DECODER-COMPLETION"
    private val q380Status = "OCR_RUNTIME_READINESS_ADAPTIVE_INPUT_DECODER_COMPLETION_EXPLICIT_INVOCATION_ONLY"
    private val q380DecoderVersion = "q380-adaptive-input-metadata-logit-token-vocabulary-decoder-v1"
    private val q380DefaultInputHeight = q367ImageTensorHeight
    private val q380DefaultInputWidth = q367ImageTensorWidth
    private val q381Phase = "V172-Q381-CAMERA-OCR-RUNTIME-FINALIZATION-CROP-MODEL-VOCAB-REVIEW-COMPLETION"
    private val q381Status = "CAMERA_OCR_RUNTIME_FINALIZATION_CROP_MODEL_VOCAB_REVIEW_COMPLETION_EXPLICIT_INVOCATION_ONLY"
    private val q381BridgeMethod = "cameraOcrRuntimeFinalizationCropModelVocabReviewCompletion"
    private val q381CropFrameDefaultWidthFactor = 0.78
    private val q381CropFrameDefaultHeightFactor = 0.34
    private val q381CropOutputDirectoryName = "ocr_crops/q381"
    private val q381MaxVocabularySidecarBytes = 20_000_000L
    private val q381R1Phase = "V172-Q381R1-CAMERA-OCR-RUNTIME-RISK-REPAIR"
    private val q381R1Status = "CAMERA_OCR_RUNTIME_RISK_REPAIR_OFF_MAIN_THREAD_EXIF_MEMORY_SAFE_CROP"
    private val q381R1WorkerThreadName = "Q381R1CameraOcrWorker"
    private val q381MaxDecodeDimensionPx = 2048
    private val q381CropJpegQuality = 96



    private var nativeSplashOverlay: View? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        installNativeSplashOverlay()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            nativeSplashChannelName
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "releaseNativeSplash" -> {
                    hideNativeSplashOverlay()
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            ocrRuntimeBridgeChannelName
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "ping", "healthCheck" -> result.success(q317OcrRuntimeBridgeHealthcheck(call.method))
                "privateStorageInfo", "verifyPrivateStorageArtifact" -> result.success(q318PrivateModelStorageHealthcheck(call.method))
                "verifiedArtifactLoadSmoke" -> result.success(q319VerifiedArtifactLoadSmoke(call.method))
                "runtimeStartupSmoke" -> result.success(q320RuntimeStartupSmoke(call.method))
                "dummyRuntimeCall" -> result.success(q321DummyRuntimeCall(call.method))
                "firstImageToLatexInference" -> result.success(q322FirstImageToLatexInference(call.method))
                "runtimeDependencyModelLoaderDecision" -> result.success(q323RuntimeDependencyModelLoaderDecision(call.method))
                "approvedRuntimeDependencyTrial" -> result.success(q324ApprovedRuntimeDependencyTrial(call.method))
                "runtimeDependencyCoordinateSelection" -> result.success(q325RuntimeDependencyCoordinateSelection(call.method))
                "nativeLibraryBuildTrialPreflight" -> result.success(q326NativeLibraryBuildTrialPreflight(call.method))
                "nativeLibrarySourcePackageApproval" -> result.success(q327NativeLibrarySourcePackageApproval(call.method))
                "nativeLibraryPackageFileHashIntake" -> result.success(q328NativeLibraryPackageFileHashIntake(call.method))
                "nativePackageHashEvidenceReview" -> result.success(q329NativePackageHashEvidenceReview(call.method))
                "binaryBundleTrialDefaultOff" -> result.success(q330BinaryBundleTrialDefaultOff(call.method))
                "nativePackageHashEvidenceAcceptance" -> result.success(q331NativePackageHashEvidenceAcceptance(call.method))
                "actualBinaryBundleGate" -> result.success(q332ActualBinaryBundleGate(call.method))
                "nativePackageHashEvidenceIntakeReview" -> result.success(q333NativePackageHashEvidenceIntakeReview(call.method))
                "actualBinaryBundlePlacementGate" -> result.success(q334ActualBinaryBundlePlacementGate(call.method))
                "nativePackageHashEvidenceCollectionIntake" -> result.success(q335NativePackageHashEvidenceCollectionIntake(call.method))
                "nativePackageHashEvidenceCaptureQ328JsonIntake" -> result.success(q336NativePackageHashEvidenceCaptureQ328JsonIntake(call.method))
                "nativePackageHashEvidenceAcceptanceExplicitBundleApproval" -> result.success(q337NativePackageHashEvidenceAcceptanceExplicitBundleApproval(call.method))
                "actualBinaryBundleNoEvidenceBlockedGate" -> result.success(q338ActualBinaryBundleNoEvidenceBlockedGate(call.method))
                "nativePackageHashEvidenceCaptureActualBundlePermissionFinalCheck" -> result.success(q339NativePackageHashEvidenceCaptureActualBundlePermissionFinalCheck(call.method))
                "actualBinaryBundleEvidenceBlockedGate" -> result.success(q340ActualBinaryBundleEvidenceBlockedGate(call.method))
                "nativePackageHashEvidenceCaptureBundleEvidenceAcceptance" -> result.success(q341NativePackageHashEvidenceCaptureBundleEvidenceAcceptance(call.method))
                "actualBinaryBundlePendingEvidenceBlocked" -> result.success(q342ActualBinaryBundlePendingEvidenceBlocked(call.method))
                "nativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGate" -> result.success(q343NativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGate(call.method))
                "nativeLibraryLoadSmoke" -> result.success(q346NativeLibraryLoadSmoke(call.method))
                "paddleLitePredictorInstantiateSmoke" -> result.success(q347PaddleLitePredictorInstantiateSmoke(call.method))
                "onnxRealModelLoadSmoke" -> result.success(q357OnnxRealModelLoadSmoke(call.method))
                "onnxDummyInputRuntimeCall" -> result.success(q358OnnxDummyInputRuntimeCall(call.method))
                "onnxFirstImageToLatexInferenceGuard" -> result.success(q359OnnxFirstImageToLatexInferenceGuard(call.method))
                "cameraOcrRuntimeExecutionBridge" -> result.success(q361CameraOcrRuntimeExecutionBridge(call.method))
                "onnxModelArtifactPrivateStorageActivation" -> result.success(
                    q364OnnxModelArtifactPrivateStorageActivation(
                        call.method,
                        call.argument<String>("sourcePath")
                    )
                )
                "onnxRealModelLoadSmokeExecution" -> result.success(q365OnnxRealModelLoadSmokeExecution(call.method))
                "onnxDummyInputRuntimeCallExecution" -> result.success(q366OnnxDummyInputRuntimeCallExecution(call.method))
                "onnxFirstRealImageToLatexInferenceExecution" -> result.success(
                    q367FirstRealImageToLatexInferenceExecution(
                        call.method,
                        call.argument<String>("imagePath") ?: call.argument<String>("sourceImagePath")
                    )
                )
                "editableMathLiveOcrReviewActivation" -> result.success(
                    q368EditableMathLiveOcrReviewActivation(
                        call.method,
                        call.argument<String>("candidateLatex"),
                        call.argument<Double>("candidateConfidence") ?: call.argument<Number>("candidateConfidence")?.toDouble(),
                        call.argument<String>("candidateSource")
                    )
                )
                "approvedOcrWorkspaceImportActivation" -> result.success(
                    q369ApprovedOcrWorkspaceImportActivation(
                        call.method,
                        call.argument<String>("candidateLatex"),
                        call.argument<String>("approvedLatex"),
                        call.argument<Double>("candidateConfidence") ?: call.argument<Number>("candidateConfidence")?.toDouble(),
                        call.argument<String>("candidateSource"),
                        call.argument<Boolean>("reviewCompleted") ?: false,
                        call.argument<Boolean>("userApproved") ?: call.argument<Boolean>("explicitUserApproval") ?: false
                    )
                )
                "controlledOcrActivationRuntimeEvidenceCapture" -> result.success(
                    q371ControlledOcrActivationRuntimeEvidenceCapture(
                        call.method,
                        call.argument<String>("modelSourcePath") ?: call.argument<String>("sourcePath"),
                        call.argument<String>("imagePath") ?: call.argument<String>("sourceImagePath"),
                        call.argument<String>("candidateLatex") ?: call.argument<String>("candidateLatexOverride"),
                        call.argument<String>("approvedLatex") ?: call.argument<String>("approvedLatexOverride"),
                        call.argument<Double>("candidateConfidence") ?: call.argument<Number>("candidateConfidence")?.toDouble(),
                        call.argument<Boolean>("executePrivateStorageActivation") ?: false,
                        call.argument<Boolean>("executeModelLoadSmoke") ?: false,
                        call.argument<Boolean>("executeDummyRuntimeCall") ?: false,
                        call.argument<Boolean>("executeImageToLatex") ?: false,
                        call.argument<Boolean>("prepareReviewHandoff") ?: true,
                        call.argument<Boolean>("prepareApprovedImport") ?: true,
                        call.argument<Boolean>("reviewCompleted") ?: false,
                        call.argument<Boolean>("userApproved") ?: call.argument<Boolean>("explicitUserApproval") ?: false
                    )
                )
                "realOcrExecutionOutputDecoderClosure" -> result.success(
                    q375RealOcrExecutionOutputDecoderClosure(
                        call.method,
                        call.argument<String>("imagePath") ?: call.argument<String>("sourceImagePath"),
                        call.argument<String>("decoderLatexOverride") ?: call.argument<String>("candidateLatexOverride")
                    )
                )
                "realOnnxOutputDecoderCandidateExtractionBinding" -> result.success(
                    q379RealOnnxOutputDecoderCandidateExtractionBinding(
                        call.method,
                        call.argument<String>("imagePath") ?: call.argument<String>("sourceImagePath"),
                        call.argument<String>("decoderLatexOverride") ?: call.argument<String>("candidateLatexOverride")
                    )
                )
                "ocrRuntimeReadinessAdaptiveInputDecoderCompletion" -> result.success(
                    q380OcrRuntimeReadinessAdaptiveInputDecoderCompletion(
                        call.method,
                        call.argument<String>("imagePath") ?: call.argument<String>("sourceImagePath"),
                        call.argument<String>("modelSourcePath") ?: call.argument<String>("sourcePath"),
                        call.argument<String>("decoderLatexOverride") ?: call.argument<String>("candidateLatexOverride")
                    )
                )
                "deferredPaddleModelRuntimeBindingPreflight" -> result.success(
                    q384R2DeferredPaddleModelRuntimeBindingPreflight(
                        call.method,
                        call.argument<String>("modelSourcePath") ?: call.argument<String>("sourcePath")
                    )
                )
                "paddleRuntimeDeliveryDecisionQ385" -> result.success(
                    q385PaddleRuntimeDeliveryDecision(call.method)
                )
                "realPaddleOcrInferenceBridgeQ386" -> result.success(
                    q386RealPaddleOcrInferenceBridge(
                        call.method,
                        call.argument<String>("imagePath") ?: call.argument<String>("sourceImagePath"),
                        call.argument<String>("modelSourcePath") ?: call.argument<String>("sourcePath"),
                        call.argument<String>("decoderLatexOverride") ?: call.argument<String>("candidateLatexOverride")
                    )
                )
                "cameraOcrRuntimeFinalizationCropModelVocabReviewCompletion" -> {
                    val arguments = call.arguments
                    val method = call.method
                    val imagePath = q381StringArgument(arguments, "imagePath", "sourceImagePath")
                    val modelSourcePath = q381StringArgument(arguments, "modelSourcePath", "sourcePath")
                    val decoderLatexOverride = q381StringArgument(arguments, "decoderLatexOverride", "candidateLatexOverride")
                    val rotationQuarterTurns = q381IntArgument(arguments, "rotationQuarterTurns") ?: 0
                    val cropFrameWidthFactor = q381DoubleArgument(arguments, "cropFrameWidthFactor") ?: q381CropFrameDefaultWidthFactor
                    val cropFrameHeightFactor = q381DoubleArgument(arguments, "cropFrameHeightFactor") ?: q381CropFrameDefaultHeightFactor
                    Thread({
                        val payload = try {
                            q381CameraOcrRuntimeFinalizationCropModelVocabReviewCompletion(
                                method,
                                imagePath,
                                modelSourcePath,
                                decoderLatexOverride,
                                rotationQuarterTurns,
                                cropFrameWidthFactor,
                                cropFrameHeightFactor
                            )
                        } catch (error: Throwable) {
                            q381FatalBlockedEvidence(method, imagePath, error)
                        }
                        Handler(Looper.getMainLooper()).post { result.success(payload) }
                    }, q381R1WorkerThreadName).start()
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun q317OcrRuntimeBridgeHealthcheck(method: String): Map<String, Any> {
        return mapOf(
            "phase" to q317Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to "NATIVE_BRIDGE_HEALTHCHECK_AVAILABLE_DEFAULT_OFF",
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q317RuntimeBridgeFeatureEnabled,
            "runtimeDependencyAdded" to false,
            "runtimeStartupExecuted" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallExecuted" to false,
            "imageToLatexInferenceExecuted" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
        )
    }




    private fun q318PrivateModelStorageRoot(): File {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        if (!storageRoot.exists()) {
            storageRoot.mkdirs()
        }
        return storageRoot
    }

    private fun q318PrivateModelArtifactFile(): File {
        return File(q318PrivateModelStorageRoot(), q318PrivateModelArtifactFileName)
    }

    private fun q318PrivateModelStorageHealthcheck(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val storageDirectoryReady = storageRoot.exists() || storageRoot.mkdirs()
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        val actualSha256 = if (method == "verifyPrivateStorageArtifact" && artifactExists) {
            q318Sha256File(artifact)
        } else {
            ""
        }
        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256

        return mapOf(
            "phase" to q318Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to "PRIVATE_MODEL_STORAGE_HEALTHCHECK_AVAILABLE_DEFAULT_OFF",
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q318PrivateStorageFeatureEnabled,
            "privateStorageRoot" to storageRoot.absolutePath,
            "privateStorageDirectoryReady" to storageDirectoryReady,
            "modelDirectoryName" to q318PrivateModelDirectoryName,
            "artifactFileName" to q318PrivateModelArtifactFileName,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupExecuted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallExecuted" to false,
            "imageToLatexInferenceExecuted" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q319VerifiedArtifactLoadSmoke(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0L
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                FileInputStream(artifact).use { input ->
                    val buffer = ByteArray(4096)
                    val read = input.read(buffer)
                    artifactOpenedForRead = true
                    artifactReadSmokeBytes = if (read > 0) read.toLong() else 0L
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown artifact read error")
            }
        }

        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256
        val verifiedArtifactLoadSmokePassed = artifactExists && artifactOpenedForRead && sha256MatchesExpected && artifactSmokeError.isEmpty()

        return mapOf(
            "phase" to q319Phase,
            "sourcePhase" to q318Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to "VERIFIED_ARTIFACT_LOAD_SMOKE_AVAILABLE_DEFAULT_OFF",
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q319VerifiedArtifactLoadSmokeFeatureEnabled,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupExecuted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallExecuted" to false,
            "imageToLatexInferenceExecuted" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q320RuntimeStartupSmoke(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0L
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                FileInputStream(artifact).use { input ->
                    val buffer = ByteArray(4096)
                    val read = input.read(buffer)
                    artifactOpenedForRead = true
                    artifactReadSmokeBytes = if (read > 0) read.toLong() else 0L
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown artifact read error")
            }
        }

        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256
        val verifiedArtifactLoadSmokePassed = artifactExists &&
            artifactOpenedForRead &&
            sha256MatchesExpected &&
            artifactSmokeError.isEmpty()

        return mapOf(
            "phase" to q320Phase,
            "sourcePhase" to q319Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to "RUNTIME_STARTUP_SMOKE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF",
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q320RuntimeStartupSmokeFeatureEnabled,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed,
            "runtimeStartupBlockedReason" to "no-runtime-dependency-bound-in-q320",
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallExecuted" to false,
            "imageToLatexInferenceExecuted" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }

    private fun q321DummyRuntimeCall(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0L
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                FileInputStream(artifact).use { input ->
                    val buffer = ByteArray(4096)
                    val read = input.read(buffer)
                    artifactOpenedForRead = true
                    artifactReadSmokeBytes = if (read > 0) read.toLong() else 0L
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown artifact read error")
            }
        }

        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256
        val verifiedArtifactLoadSmokePassed = artifactExists &&
            artifactOpenedForRead &&
            sha256MatchesExpected &&
            artifactSmokeError.isEmpty()

        return mapOf(
            "phase" to q321Phase,
            "sourcePhase" to q320Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to "DUMMY_RUNTIME_CALL_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF",
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q321DummyRuntimeCallFeatureEnabled,
            "dummyPayloadLabel" to q321DummyPayloadLabel,
            "dummyPayloadSha256" to "",
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed,
            "dummyRuntimeCallBlockedReason" to "no-runtime-dependency-bound-in-q321",
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceExecuted" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q322FirstImageToLatexInference(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0L
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                FileInputStream(artifact).use { input ->
                    val buffer = ByteArray(4096)
                    val read = input.read(buffer)
                    artifactOpenedForRead = true
                    artifactReadSmokeBytes = if (read > 0) read.toLong() else 0L
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown artifact read error")
            }
        }

        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256
        val verifiedArtifactLoadSmokePassed = artifactExists &&
            artifactOpenedForRead &&
            sha256MatchesExpected &&
            artifactSmokeError.isEmpty()

        return mapOf(
            "phase" to q322Phase,
            "sourcePhase" to q321Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to "FIRST_IMAGE_TO_LATEX_INFERENCE_BLOCKED_NO_RUNTIME_DEPENDENCY_DEFAULT_OFF",
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q322FirstImageToLatexFeatureEnabled,
            "imageInputLabel" to q322ImageInputLabel,
            "imageInputAccepted" to false,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed,
            "inferenceBlockedReason" to "no-runtime-dependency-bound-in-q322",
            "candidateLatex" to "",
            "candidateConfidence" to 0.0,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q323RuntimeDependencyModelLoaderDecision(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0L
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                FileInputStream(artifact).use { input ->
                    val buffer = ByteArray(4096)
                    val read = input.read(buffer)
                    artifactOpenedForRead = true
                    artifactReadSmokeBytes = if (read > 0) read.toLong() else 0L
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown artifact read error")
            }
        }

        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256
        val verifiedArtifactLoadSmokePassed = artifactExists &&
            artifactOpenedForRead &&
            sha256MatchesExpected &&
            artifactSmokeError.isEmpty()

        return mapOf(
            "phase" to q323Phase,
            "sourcePhase" to q322Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to "RUNTIME_DEPENDENCY_MODEL_LOADER_DECISION_BLOCKED_PENDING_APPROVED_RUNTIME_EVIDENCE_DEFAULT_OFF",
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q323RuntimeDependencyDecisionFeatureEnabled,
            "selectedRuntimeDependency" to q323SelectedRuntimeDependency,
            "selectedModelLoader" to q323SelectedModelLoader,
            "dependencyDecisionBlockedReason" to "approved-android-compatible-runtime-dependency-not-yet-selected-in-q323",
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "runtimeDependencyAdded" to false,
            "approvedRuntimeDependencySelected" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q324ApprovedRuntimeDependencyTrial(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0L
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                FileInputStream(artifact).use { input ->
                    val buffer = ByteArray(4096)
                    val read = input.read(buffer)
                    artifactOpenedForRead = true
                    artifactReadSmokeBytes = if (read > 0) read.toLong() else 0L
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown artifact read error")
            }
        }

        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256
        val verifiedArtifactLoadSmokePassed = artifactExists &&
            artifactOpenedForRead &&
            sha256MatchesExpected &&
            artifactSmokeError.isEmpty()

        return mapOf(
            "phase" to q324Phase,
            "sourcePhase" to q323Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q324ApprovedRuntimeDependencyTrialStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q324ApprovedRuntimeDependencyTrialFeatureEnabled,
            "selectedRuntimeDependency" to q324SelectedRuntimeDependency,
            "selectedModelLoader" to q324SelectedModelLoader,
            "dependencyTrialBlockedReason" to "q323-user-flutter-run-and-approved-runtime-coordinates-not-yet-provided-in-q324",
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "q323UserFlutterAnalyzePassed" to false,
            "q323UserFlutterTestPassed" to false,
            "q323UserFlutterRunPassed" to false,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "runtimeDependencyAdded" to false,
            "approvedRuntimeDependencyTrialDefined" to true,
            "approvedRuntimeDependencySelected" to false,
            "paddleRuntimeDependencyAdded" to false,
            "paddleOcrDependencyAdded" to false,
            "onnxRuntimeDependencyAdded" to false,
            "tfliteRuntimeDependencyAdded" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q325RuntimeDependencyCoordinateSelection(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0L
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                FileInputStream(artifact).use { input ->
                    val buffer = ByteArray(4096)
                    val read = input.read(buffer)
                    artifactOpenedForRead = true
                    artifactReadSmokeBytes = if (read > 0) read.toLong() else 0L
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown artifact read error")
            }
        }

        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256
        val verifiedArtifactLoadSmokePassed = artifactExists &&
            artifactOpenedForRead &&
            sha256MatchesExpected &&
            artifactSmokeError.isEmpty()

        return mapOf(
            "phase" to q325Phase,
            "sourcePhase" to q324Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q325RuntimeDependencyCoordinateSelectionStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q325RuntimeDependencyCoordinateSelectionFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "selectedRuntimeDependencyCoordinate" to q325SelectedRuntimeDependencyCoordinate,
            "coordinateSelectionReason" to "official-on-device-path-points-to-paddle-lite-native-library-workflow-rather-than-simple-flutter-pub-dependency",
            "buildTrialBlockedReason" to "q325-records-explicit-candidate-but-does-not-mutate-gradle-or-bundle-native-library",
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "runtimeDependencyAdded" to false,
            "runtimeDependencyCoordinateSelected" to true,
            "approvedRuntimeDependencySelected" to false,
            "paddleRuntimeDependencyAdded" to false,
            "paddleOcrDependencyAdded" to false,
            "onnxRuntimeDependencyAdded" to false,
            "tfliteRuntimeDependencyAdded" to false,
            "nativeLibraryBundled" to false,
            "nativeModelLoaderAdded" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q326NativeLibraryBuildTrialPreflight(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0L
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                FileInputStream(artifact).use { input ->
                    val buffer = ByteArray(4096)
                    val read = input.read(buffer)
                    artifactOpenedForRead = true
                    artifactReadSmokeBytes = if (read > 0) read.toLong() else 0L
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown artifact read error")
            }
        }

        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256
        val verifiedArtifactLoadSmokePassed = artifactExists &&
            artifactOpenedForRead &&
            sha256MatchesExpected &&
            artifactSmokeError.isEmpty()

        return mapOf(
            "phase" to q326Phase,
            "sourcePhase" to q325Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q326NativeLibraryBuildTrialPreflightStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q326NativeLibraryBuildTrialPreflightFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "selectedRuntimeDependencyCoordinate" to q325SelectedRuntimeDependencyCoordinate,
            "nativeLibrarySourceCandidate" to q326NativeLibrarySourceCandidate,
            "modelConversionCandidate" to q326ModelConversionCandidate,
            "abiPackagingCandidates" to listOf("arm64-v8a-required-candidate", "armeabi-v7a-optional-legacy-candidate", "x86_64-emulator-only-candidate"),
            "nativeLibraryCandidatePaths" to listOf(
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so"
            ),
            "nativeLibraryBuildTrialBlockedReason" to "q326-records-abi-packaging-preflight-but-does-not-bundle-so-aar-or-mutate-gradle",
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "runtimeDependencyAdded" to false,
            "runtimeDependencyCoordinateSelected" to true,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q327NativeLibrarySourcePackageApproval(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0L
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                FileInputStream(artifact).use { input ->
                    val buffer = ByteArray(4096)
                    val read = input.read(buffer)
                    artifactOpenedForRead = true
                    artifactReadSmokeBytes = if (read > 0) read.toLong() else 0L
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown artifact read error")
            }
        }

        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256
        val verifiedArtifactLoadSmokePassed = artifactExists &&
            artifactOpenedForRead &&
            sha256MatchesExpected &&
            artifactSmokeError.isEmpty()

        return mapOf(
            "phase" to q327Phase,
            "sourcePhase" to q326Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q327NativeLibrarySourcePackageApprovalStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q327NativeLibrarySourcePackageApprovalFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "approvedNativeLibrarySourcePackage" to q327ApprovedNativeLibrarySourcePackage,
            "nativeLibrarySourcePackageApprovalBlockedReason" to "q327-locks-source-package-and-abi-matrix-but-does-not-bundle-so-aar-jar-or-mutate-gradle",
            "requiredNativeLibraryFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "modernSharedLibraryCandidate" to "libpaddle_lite_api_shared.so",
            "abiMatrixLocked" to true,
            "requiredPrimaryAbi" to q327RequiredPrimaryAbi,
            "optionalLegacyAbi" to q327OptionalLegacyAbi,
            "emulatorAbi" to q327EmulatorAbi,
            "abiPackagingCandidates" to listOf("arm64-v8a-required", "armeabi-v7a-optional-legacy", "x86_64-emulator-only"),
            "nativeLibraryCandidatePaths" to listOf(
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/x86_64/libpaddle_lite_jni.so"
            ),
            "jarCandidatePath" to "android/app/libs/PaddlePredictor.jar",
            "paddleLiteSourcePackageApprovedForBundle" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q328NativeLibraryPackageFileHashIntake(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0L
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                FileInputStream(artifact).use { input ->
                    val buffer = ByteArray(4096)
                    val read = input.read(buffer)
                    artifactOpenedForRead = true
                    artifactReadSmokeBytes = if (read > 0) read.toLong() else 0L
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown artifact read error")
            }
        }

        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256
        val verifiedArtifactLoadSmokePassed = artifactExists &&
            artifactOpenedForRead &&
            sha256MatchesExpected &&
            artifactSmokeError.isEmpty()

        return mapOf(
            "phase" to q328Phase,
            "sourcePhase" to q327Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q328NativeLibraryPackageFileHashIntakeStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q328NativeLibraryPackageFileHashIntakeFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "approvedNativeLibrarySourcePackage" to q327ApprovedNativeLibrarySourcePackage,
            "nativeLibraryPackageFileHashIntakeBlockedReason" to "q328-requires-external-native-package-file-hashes-before-any-so-jar-aar-or-gradle-bundle",
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "modernSharedLibraryCandidate" to "libpaddle_lite_api_shared.so",
            "abiMatrixLocked" to true,
            "requiredPrimaryAbi" to q327RequiredPrimaryAbi,
            "optionalLegacyAbi" to q327OptionalLegacyAbi,
            "emulatorAbi" to q327EmulatorAbi,
            "perFileSha256EvidenceCaptured" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "nativePackageFilesProvidedToProject" to false,
            "nativePackageFilesBundled" to false,
            "nativePackageEvidenceStoredOutsideProjectRoot" to true,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }



    private fun q329NativePackageHashEvidenceReview(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0L
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                FileInputStream(artifact).use { input ->
                    val buffer = ByteArray(4096)
                    val read = input.read(buffer)
                    artifactOpenedForRead = true
                    artifactReadSmokeBytes = if (read > 0) read.toLong() else 0L
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown artifact read error")
            }
        }

        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256
        val verifiedArtifactLoadSmokePassed = artifactExists &&
            artifactOpenedForRead &&
            sha256MatchesExpected &&
            artifactSmokeError.isEmpty()

        return mapOf(
            "phase" to q329Phase,
            "sourcePhase" to q328Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q329NativePackageHashEvidenceReviewStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q329NativePackageHashEvidenceReviewFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "binaryBundleApprovalStatus" to q329BinaryBundleApprovalStatus,
            "nativePackageHashEvidenceReviewBlockedReason" to "q329-requires-user-provided-native-package-hash-evidence-before-binary-bundle-approval",
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q328EvidenceExpectedOutsideProjectRoot" to true,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "binaryBundleApproved" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }

    private fun q330BinaryBundleTrialDefaultOff(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0L
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                FileInputStream(artifact).use { input ->
                    val buffer = ByteArray(4096)
                    val read = input.read(buffer)
                    artifactOpenedForRead = true
                    artifactReadSmokeBytes = if (read > 0) read.toLong() else 0L
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown artifact read error")
            }
        }

        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256
        val verifiedArtifactLoadSmokePassed = artifactExists &&
            artifactOpenedForRead &&
            sha256MatchesExpected &&
            artifactSmokeError.isEmpty()

        return mapOf(
            "phase" to q330Phase,
            "sourcePhase" to q329Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q330BinaryBundleTrialStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q330BinaryBundleTrialFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "binaryBundleApprovalStatus" to q329BinaryBundleApprovalStatus,
            "binaryBundleTrialBlockedReason" to "q330-requires-q328-native-package-hash-evidence-and-explicit-user-approval-before-creating-android-app-libs-or-jnilibs",
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "plannedBundleTargets" to listOf(
                q330FuturePaddlePredictorJarPath,
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "futureAndroidAppLibsDirectory" to q330FutureAndroidAppLibsDirectory,
            "futureJniLibsDirectory" to q330FutureJniLibsDirectory,
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q329NativePackageHashEvidenceReviewRecorded" to true,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "binaryBundleApproved" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q331NativePackageHashEvidenceAcceptance(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val artifact = File(storageRoot, q318PrivateModelArtifactFileName)
        val artifactExists = artifact.exists() && artifact.isFile
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0L
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                FileInputStream(artifact).use { input ->
                    val buffer = ByteArray(4096)
                    val read = input.read(buffer)
                    artifactOpenedForRead = true
                    artifactReadSmokeBytes = if (read > 0) read.toLong() else 0L
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown artifact read error")
            }
        }

        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q317ExpectedArtifactSha256
        val verifiedArtifactLoadSmokePassed = artifactExists &&
            artifactOpenedForRead &&
            sha256MatchesExpected &&
            artifactSmokeError.isEmpty()

        return mapOf(
            "phase" to q331Phase,
            "sourcePhase" to q330Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q331NativePackageHashEvidenceAcceptanceStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q331NativePackageHashEvidenceAcceptanceFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "bundlePermissionStatus" to q331BundlePermissionStatus,
            "evidenceAcceptanceBlockedReason" to "q331-requires-user-provided-q328-native-package-hash-evidence-json-before-binary-bundle-permission",
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "plannedBundleTargets" to listOf(
                q330FuturePaddlePredictorJarPath,
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q330BinaryBundleTrialRecorded" to true,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "requiredNativePackageHashEvidenceAccepted" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "binaryBundlePermissionGranted" to false,
            "binaryBundleApproved" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "verifiedArtifactLoadSmokePassed" to verifiedArtifactLoadSmokePassed,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }

    private fun q332ActualBinaryBundleGate(method: String): Map<String, Any> {
        val storageRoot = q318PrivateModelStorageRoot()
        val artifact = q318PrivateModelArtifactFile()
        val artifactExists = artifact.exists()
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var sha256MatchesExpected = false
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                sha256MatchesExpected = actualSha256 == q317ExpectedArtifactSha256
                FileInputStream(artifact).use { stream ->
                    val buffer = ByteArray(64)
                    artifactReadSmokeBytes = stream.read(buffer).coerceAtLeast(0)
                    artifactOpenedForRead = true
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ":" + (error.message ?: "unknown")
            }
        }

        return mapOf(
            "phase" to q332Phase,
            "sourcePhase" to q331Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q332ActualBinaryBundleGateStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q332ActualBinaryBundleGateFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "bundlePermissionStatus" to q332BundlePermissionStatus,
            "actualBinaryBundleBlockedReason" to "q332-requires-user-provided-native-package-hash-evidence-json-and-explicit-binary-bundle-approval-before-any-file-copy",
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "plannedBundleTargets" to listOf(
                q330FuturePaddlePredictorJarPath,
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q331NativePackageHashEvidenceAcceptanceRecorded" to true,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "requiredNativePackageHashEvidenceAccepted" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "explicitUserBinaryBundleApprovalProvided" to false,
            "binaryBundlePermissionGranted" to false,
            "binaryBundleApproved" to false,
            "actualBinaryBundleExecuted" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q333NativePackageHashEvidenceIntakeReview(method: String): Map<String, Any> {
        val storageRoot = q318PrivateModelStorageRoot()
        val artifact = q318PrivateModelArtifactFile()
        val artifactExists = artifact.exists()
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var sha256MatchesExpected = false
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                sha256MatchesExpected = actualSha256 == q317ExpectedArtifactSha256
                FileInputStream(artifact).use { stream ->
                    val buffer = ByteArray(64)
                    artifactReadSmokeBytes = stream.read(buffer).coerceAtLeast(0)
                    artifactOpenedForRead = true
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ":" + (error.message ?: "unknown")
            }
        }

        return mapOf(
            "phase" to q333Phase,
            "sourcePhase" to q332Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q333NativePackageHashEvidenceIntakeReviewStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q333NativePackageHashEvidenceIntakeReviewFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "bundlePermissionStatus" to q333BundlePermissionStatus,
            "nativePackageHashEvidenceIntakeReviewBlockedReason" to "q333-requires-q328-native-package-hash-evidence-json-review-and-explicit-user-binary-bundle-approval-before-file-copy",
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "plannedBundleTargets" to listOf(
                q330FuturePaddlePredictorJarPath,
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q332ActualBinaryBundleGateRecorded" to true,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "nativePackageHashEvidenceReviewed" to false,
            "requiredNativePackageHashEvidenceAccepted" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "explicitUserBinaryBundleApprovalProvided" to false,
            "binaryBundlePermissionGranted" to false,
            "binaryBundleApproved" to false,
            "actualBinaryBundleExecuted" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q334ActualBinaryBundlePlacementGate(method: String): Map<String, Any> {
        val storageRoot = q318PrivateModelStorageRoot()
        val artifact = q318PrivateModelArtifactFile()
        val artifactExists = artifact.exists()
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var sha256MatchesExpected = false
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                sha256MatchesExpected = actualSha256 == q317ExpectedArtifactSha256
                FileInputStream(artifact).use { stream ->
                    val buffer = ByteArray(64)
                    artifactReadSmokeBytes = stream.read(buffer).coerceAtLeast(0)
                    artifactOpenedForRead = true
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ":" + (error.message ?: "unknown")
            }
        }

        return mapOf(
            "phase" to q334Phase,
            "sourcePhase" to q333Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q334ActualBinaryBundlePlacementGateStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q334ActualBinaryBundlePlacementGateFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "bundlePermissionStatus" to q334BundlePermissionStatus,
            "actualBinaryBundlePlacementBlockedReason" to "q334-requires-q328-native-package-hash-evidence-json-and-explicit-user-binary-bundle-approval-before-copying-any-so-or-jar-into-project",
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "plannedBundleTargets" to listOf(
                q330FuturePaddlePredictorJarPath,
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q333NativePackageHashEvidenceIntakeReviewRecorded" to true,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "nativePackageHashEvidenceReviewed" to false,
            "requiredNativePackageHashEvidenceAccepted" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "explicitUserBinaryBundleApprovalProvided" to false,
            "binaryBundlePermissionGranted" to false,
            "binaryBundleApproved" to false,
            "actualBinaryBundlePlacementAttempted" to false,
            "actualBinaryBundleExecuted" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q335NativePackageHashEvidenceCollectionIntake(method: String): Map<String, Any> {
        val storageRoot = q318PrivateModelStorageRoot()
        val artifact = q318PrivateModelArtifactFile()
        val artifactExists = artifact.exists()
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var sha256MatchesExpected = false
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                sha256MatchesExpected = actualSha256 == q317ExpectedArtifactSha256
                FileInputStream(artifact).use { stream ->
                    val buffer = ByteArray(64)
                    artifactReadSmokeBytes = stream.read(buffer).coerceAtLeast(0)
                    artifactOpenedForRead = true
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ":" + (error.message ?: "unknown")
            }
        }

        return mapOf(
            "phase" to q335Phase,
            "sourcePhase" to q334Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q335NativePackageHashEvidenceCollectionIntakeStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q335NativePackageHashEvidenceCollectionIntakeFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "bundlePermissionStatus" to q335BundlePermissionStatus,
            "nativePackageHashEvidenceCollectionBlockedReason" to "q335-requires-user-side-paddle-lite-native-package-files-q328-hash-evidence-json-and-explicit-binary-bundle-approval-before-copying-any-so-or-jar-into-project",
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "plannedBundleTargets" to listOf(
                q330FuturePaddlePredictorJarPath,
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q335IntakePreparationScript" to "tool/prepare_paddle_lite_native_package_intake_v172_q335.mjs",
            "q334ActualBinaryBundlePlacementGateRecorded" to true,
            "userSideNativePackageFilesProvided" to false,
            "q328NativePackageHashEvidenceJsonProvided" to false,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "nativePackageHashEvidenceReviewed" to false,
            "requiredNativePackageHashEvidenceAccepted" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "explicitUserBinaryBundleApprovalProvided" to false,
            "binaryBundlePermissionGranted" to false,
            "binaryBundleApproved" to false,
            "actualBinaryBundlePlacementAttempted" to false,
            "actualBinaryBundleExecuted" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q336NativePackageHashEvidenceCaptureQ328JsonIntake(method: String): Map<String, Any> {
        val storageRoot = q318PrivateModelStorageRoot()
        val artifact = q318PrivateModelArtifactFile()
        val artifactExists = artifact.exists()
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var sha256MatchesExpected = false
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                sha256MatchesExpected = actualSha256 == q317ExpectedArtifactSha256
                FileInputStream(artifact).use { stream ->
                    val buffer = ByteArray(64)
                    artifactReadSmokeBytes = stream.read(buffer).coerceAtLeast(0)
                    artifactOpenedForRead = true
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ":" + (error.message ?: "unknown")
            }
        }

        return mapOf(
            "phase" to q336Phase,
            "sourcePhase" to q335Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q336NativePackageHashEvidenceCaptureQ328JsonIntakeStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q336NativePackageHashEvidenceCaptureQ328JsonIntakeFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "bundlePermissionStatus" to q336BundlePermissionStatus,
            "nativePackageHashEvidenceCaptureBlockedReason" to "q336-requires-q328-native-package-hash-evidence-json-with-required-files-and-explicit-user-binary-bundle-approval-before-copying-any-so-or-jar-into-project",
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "plannedBundleTargets" to listOf(
                q330FuturePaddlePredictorJarPath,
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q335IntakePreparationScript" to "tool/prepare_paddle_lite_native_package_intake_v172_q335.mjs",
            "q336EvidenceIntakeScript" to "tool/intake_q328_native_package_hash_evidence_v172_q336.mjs",
            "q335NativePackageHashEvidenceCollectionIntakeRecorded" to true,
            "q328NativePackageHashEvidenceJsonProvided" to false,
            "q328NativePackageHashEvidenceJsonReviewed" to false,
            "requiredNativePackageFilesAllPresentInEvidence" to false,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "nativePackageHashEvidenceReviewed" to false,
            "requiredNativePackageHashEvidenceAccepted" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "explicitUserBinaryBundleApprovalProvided" to false,
            "binaryBundlePermissionGranted" to false,
            "binaryBundleApproved" to false,
            "actualBinaryBundlePlacementAttempted" to false,
            "actualBinaryBundleExecuted" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q337NativePackageHashEvidenceAcceptanceExplicitBundleApproval(method: String): Map<String, Any> {
        val storageRoot = q318PrivateModelStorageRoot()
        val artifact = q318PrivateModelArtifactFile()
        val artifactExists = artifact.exists()
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var sha256MatchesExpected = false
        var artifactOpenedForRead = false
        var artifactReadSmokeBytes = 0
        var artifactSmokeError = ""

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                sha256MatchesExpected = actualSha256 == q317ExpectedArtifactSha256
                FileInputStream(artifact).use { stream ->
                    val buffer = ByteArray(64)
                    artifactReadSmokeBytes = stream.read(buffer).coerceAtLeast(0)
                    artifactOpenedForRead = true
                }
            } catch (error: Exception) {
                artifactSmokeError = error.javaClass.simpleName + ":" + (error.message ?: "unknown")
            }
        }

        return mapOf(
            "phase" to q337Phase,
            "sourcePhase" to q336Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q337NativePackageHashEvidenceAcceptanceExplicitBundleApprovalStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q337NativePackageHashEvidenceAcceptanceExplicitBundleApprovalFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "bundlePermissionStatus" to q337BundlePermissionStatus,
            "nativePackageHashEvidenceAcceptanceBlockedReason" to "q337-requires-reviewed-q328-native-package-hash-evidence-json-and-explicit-user-binary-bundle-approval-before-copying-any-so-or-jar-into-project",
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "plannedBundleTargets" to listOf(
                q330FuturePaddlePredictorJarPath,
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q335IntakePreparationScript" to "tool/prepare_paddle_lite_native_package_intake_v172_q335.mjs",
            "q336EvidenceIntakeScript" to "tool/intake_q328_native_package_hash_evidence_v172_q336.mjs",
            "q337BundleApprovalGateScript" to "tool/verify_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_v172_q337.mjs",
            "q328NativePackageHashEvidenceJsonProvided" to false,
            "q328NativePackageHashEvidenceJsonReviewed" to false,
            "requiredNativePackageFilesAllPresentInEvidence" to false,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "nativePackageHashEvidenceReviewed" to false,
            "requiredNativePackageHashEvidenceAccepted" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "explicitUserBinaryBundleApprovalProvided" to false,
            "binaryBundlePermissionGranted" to false,
            "binaryBundleApproved" to false,
            "actualBinaryBundlePlacementAttempted" to false,
            "actualBinaryBundleExecuted" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "artifactOpenedForRead" to artifactOpenedForRead,
            "artifactReadSmokeBytes" to artifactReadSmokeBytes,
            "artifactSmokeError" to artifactSmokeError,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }

    private fun q318Sha256File(file: File): String {
        val digest = MessageDigest.getInstance("SHA-256")
        FileInputStream(file).use { input ->
            val buffer = ByteArray(1024 * 1024)
            while (true) {
                val read = input.read(buffer)
                if (read <= 0) break
                digest.update(buffer, 0, read)
            }
        }
        return digest.digest().joinToString("") { byte -> "%02x".format(byte.toInt() and 0xff) }
    }

    private fun q338ActualBinaryBundleNoEvidenceBlockedGate(method: String): Map<String, Any> {
        val storageRoot = q318PrivateModelStorageRoot()
        val artifact = q318PrivateModelArtifactFile()
        val artifactExists = artifact.exists()
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var sha256MatchesExpected = false

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                sha256MatchesExpected = actualSha256 == q317ExpectedArtifactSha256
            } catch (error: Exception) {
                actualSha256 = ""
                sha256MatchesExpected = false
            }
        }

        return mapOf(
            "phase" to q338Phase,
            "sourcePhase" to q337Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q338ActualBinaryBundleNoEvidenceBlockedGateStatus,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q338ActualBinaryBundleNoEvidenceBlockedGateFeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "bundlePermissionStatus" to q338BundlePermissionStatus,
            "uiProtectionStatus" to q338UiProtectionStatus,
            "actualBinaryBundleBlockedReason" to "q338-requires-q328-native-package-hash-evidence-json-and-explicit-user-binary-bundle-approval-before-copying-any-so-or-jar-into-project",
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "plannedBundleTargets" to listOf(
                q330FuturePaddlePredictorJarPath,
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q335IntakePreparationScript" to "tool/prepare_paddle_lite_native_package_intake_v172_q335.mjs",
            "q336EvidenceIntakeScript" to "tool/intake_q328_native_package_hash_evidence_v172_q336.mjs",
            "q337ExplicitBundleApprovalGateScript" to "tool/verify_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_v172_q337.mjs",
            "q338ActualBinaryBundleGateScript" to "tool/verify_actual_binary_bundle_jnilibs_paddlepredictor_no_evidence_blocked_gate_v172_q338.mjs",
            "q328NativePackageHashEvidenceJsonProvided" to false,
            "q328NativePackageHashEvidenceJsonReviewed" to false,
            "requiredNativePackageFilesAllPresentInEvidence" to false,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "explicitUserBinaryBundleApprovalProvided" to false,
            "binaryBundlePermissionGranted" to false,
            "binaryBundleApproved" to false,
            "actualBinaryBundlePlacementAttempted" to false,
            "actualBinaryBundleExecuted" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "workspaceChanged" to false,
            "keyboardChanged" to false,
            "moreTemplateTrayChanged" to false,
            "longPressChanged" to false,
            "mathLiveProductionBridgeChanged" to false,
            "graphChanged" to false,
            "solutionChanged" to false,
            "historyChanged" to false,
            "splashChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q339NativePackageHashEvidenceCaptureActualBundlePermissionFinalCheck(method: String): Map<String, Any> {
        val storageRoot = q318PrivateModelStorageRoot()
        val artifact = q318PrivateModelArtifactFile()
        val artifactExists = artifact.exists()
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var sha256MatchesExpected = false

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                sha256MatchesExpected = actualSha256 == q317ExpectedArtifactSha256
            } catch (error: Exception) {
                actualSha256 = ""
                sha256MatchesExpected = false
            }
        }

        return mapOf(
            "phase" to q339Phase,
            "sourcePhase" to q338Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q339Status,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q339FeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q335IntakePreparationScript" to "tool/prepare_paddle_lite_native_package_intake_v172_q335.mjs",
            "q336EvidenceIntakeScript" to "tool/intake_q328_native_package_hash_evidence_v172_q336.mjs",
            "q337ExplicitBundleApprovalVerifier" to "tool/verify_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_v172_q337.mjs",
            "q338NoEvidenceBlockedGateVerifier" to "tool/verify_actual_binary_bundle_jnilibs_paddlepredictor_no_evidence_blocked_gate_v172_q338.mjs",
            "q339FinalCheckVerifier" to "tool/verify_native_package_hash_evidence_capture_actual_bundle_permission_final_check_v172_q339.mjs",
            "finalBundlePermissionStatus" to q339FinalBundlePermissionStatus,
            "uiProtectionStatus" to q339UiProtectionStatus,
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "plannedBundleTargets" to listOf(
                q330FuturePaddlePredictorJarPath,
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "blockedReason" to "q339-final-check-requires-q328-native-package-hash-evidence-json-accepted-and-explicit-user-binary-bundle-approval-before-any-so-or-jar-is-copied",
            "q328NativePackageHashEvidenceJsonProvided" to false,
            "q328NativePackageHashEvidenceJsonReviewed" to false,
            "q328NativePackageHashEvidenceJsonAccepted" to false,
            "requiredNativePackageFilesAllPresentInEvidence" to false,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "explicitUserBinaryBundleApprovalProvided" to false,
            "finalBundlePermissionGranted" to false,
            "binaryBundlePermissionGranted" to false,
            "actualBinaryBundleAttempted" to false,
            "actualBinaryBundlePlacementAttempted" to false,
            "actualBinaryBundleExecuted" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "workspaceChanged" to false,
            "keyboardChanged" to false,
            "moreTemplateTrayChanged" to false,
            "longPressChanged" to false,
            "mathLiveProductionBridgeChanged" to false,
            "graphChanged" to false,
            "solutionChanged" to false,
            "historyChanged" to false,
            "splashChanged" to false,
            "iconChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q340ActualBinaryBundleEvidenceBlockedGate(method: String): Map<String, Any> {
        val storageRoot = q318PrivateModelStorageRoot()
        val artifact = q318PrivateModelArtifactFile()
        val artifactExists = artifact.exists()
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var sha256MatchesExpected = false

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                sha256MatchesExpected = actualSha256 == q317ExpectedArtifactSha256
            } catch (error: Exception) {
                actualSha256 = ""
                sha256MatchesExpected = false
            }
        }

        return mapOf(
            "phase" to q340Phase,
            "sourcePhase" to q339Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q340Status,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q340FeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q335IntakePreparationScript" to "tool/prepare_paddle_lite_native_package_intake_v172_q335.mjs",
            "q336EvidenceIntakeScript" to "tool/intake_q328_native_package_hash_evidence_v172_q336.mjs",
            "q339FinalCheckVerifier" to "tool/verify_native_package_hash_evidence_capture_actual_bundle_permission_final_check_v172_q339.mjs",
            "binaryBundleStatus" to q340BinaryBundleStatus,
            "uiProtectionStatus" to q340UiProtectionStatus,
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "plannedBundleTargets" to listOf(
                q330FuturePaddlePredictorJarPath,
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "blockedReason" to "q340-actual-binary-bundle-is-blocked-because-native-package-hash-evidence-json-explicit-user-bundle-approval-and-user-side-flutter-log-are-not-present",
            "q328NativePackageHashEvidenceJsonProvided" to false,
            "q328NativePackageHashEvidenceJsonReviewed" to false,
            "q328NativePackageHashEvidenceJsonAccepted" to false,
            "requiredNativePackageFilesAllPresentInEvidence" to false,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "explicitUserBinaryBundleApprovalProvided" to false,
            "finalBundlePermissionGranted" to false,
            "binaryBundlePermissionGranted" to false,
            "actualBinaryBundleAttempted" to false,
            "actualBinaryBundlePlacementAttempted" to false,
            "actualBinaryBundleExecuted" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "workspaceChanged" to false,
            "keyboardChanged" to false,
            "moreTemplateTrayChanged" to false,
            "longPressChanged" to false,
            "mathLiveProductionBridgeChanged" to false,
            "graphChanged" to false,
            "solutionChanged" to false,
            "historyChanged" to false,
            "splashChanged" to false,
            "iconChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q341NativePackageHashEvidenceCaptureBundleEvidenceAcceptance(method: String): Map<String, Any> {
        val storageRoot = q318PrivateModelStorageRoot()
        val artifact = q318PrivateModelArtifactFile()
        val artifactExists = artifact.exists()
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var sha256MatchesExpected = false

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                sha256MatchesExpected = actualSha256 == q317ExpectedArtifactSha256
            } catch (error: Exception) {
                actualSha256 = ""
                sha256MatchesExpected = false
            }
        }

        return mapOf(
            "phase" to q341Phase,
            "sourcePhase" to q340Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q341Status,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q341FeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q335IntakePreparationScript" to "tool/prepare_paddle_lite_native_package_intake_v172_q335.mjs",
            "q336EvidenceIntakeScript" to "tool/intake_q328_native_package_hash_evidence_v172_q336.mjs",
            "q339FinalCheckVerifier" to "tool/verify_native_package_hash_evidence_capture_actual_bundle_permission_final_check_v172_q339.mjs",
            "q340EvidenceBlockedGateVerifier" to "tool/verify_actual_binary_bundle_jnilibs_paddlepredictor_evidence_blocked_gate_v172_q340.mjs",
            "bundleEvidenceAcceptanceStatus" to q341BundleEvidenceAcceptanceStatus,
            "uiProtectionStatus" to q341UiProtectionStatus,
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "plannedBundleTargets" to listOf(
                q330FuturePaddlePredictorJarPath,
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "blockedReason" to "q341-bundle-evidence-acceptance-is-blocked-because-native-package-hash-evidence-json-explicit-user-bundle-approval-and-clean-user-side-flutter-log-are-not-present",
            "q328NativePackageHashEvidenceJsonProvided" to false,
            "q328NativePackageHashEvidenceJsonReviewed" to false,
            "q328NativePackageHashEvidenceJsonAccepted" to false,
            "requiredNativePackageFilesAllPresentInEvidence" to false,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "explicitUserBinaryBundleApprovalProvided" to false,
            "finalBundlePermissionGranted" to false,
            "binaryBundlePermissionGranted" to false,
            "actualBinaryBundleAttempted" to false,
            "actualBinaryBundlePlacementAttempted" to false,
            "actualBinaryBundleExecuted" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "workspaceChanged" to false,
            "keyboardChanged" to false,
            "moreTemplateTrayChanged" to false,
            "longPressChanged" to false,
            "mathLiveProductionBridgeChanged" to false,
            "graphChanged" to false,
            "solutionChanged" to false,
            "historyChanged" to false,
            "splashChanged" to false,
            "iconChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun q342ActualBinaryBundlePendingEvidenceBlocked(method: String): Map<String, Any> {
        val storageRoot = q318PrivateModelStorageRoot()
        val artifact = q318PrivateModelArtifactFile()
        val artifactExists = artifact.exists()
        val artifactSizeBytes = if (artifactExists) artifact.length() else 0L
        var actualSha256 = ""
        var sha256MatchesExpected = false

        if (artifactExists) {
            try {
                actualSha256 = q318Sha256File(artifact)
                sha256MatchesExpected = actualSha256 == q317ExpectedArtifactSha256
            } catch (error: Exception) {
                actualSha256 = ""
                sha256MatchesExpected = false
            }
        }

        return mapOf(
            "phase" to q342Phase,
            "sourcePhase" to q341Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q342Status,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q342FeatureEnabled,
            "selectedRuntimeDependencyCandidate" to q325SelectedRuntimeDependencyCandidate,
            "selectedModelLoaderCandidate" to q325SelectedModelLoaderCandidate,
            "externalNativePackageEvidencePolicy" to q328ExternalNativePackageEvidencePolicy,
            "nativePackageEvidenceFileName" to q328NativePackageEvidenceFileName,
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q335IntakePreparationScript" to "tool/prepare_paddle_lite_native_package_intake_v172_q335.mjs",
            "q336EvidenceIntakeScript" to "tool/intake_q328_native_package_hash_evidence_v172_q336.mjs",
            "q341BundleEvidenceAcceptanceVerifier" to "tool/verify_native_package_hash_evidence_capture_bundle_evidence_acceptance_v172_q341.mjs",
            "bundlePermissionStatus" to q342BundlePermissionStatus,
            "uiProtectionStatus" to q342UiProtectionStatus,
            "requiredNativePackageFiles" to listOf(
                "PaddlePredictor.jar",
                "arm64-v8a/libpaddle_lite_jni.so",
                "armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "optionalNativePackageFiles" to listOf("x86_64/libpaddle_lite_jni.so"),
            "plannedBundleTargets" to listOf(
                q330FuturePaddlePredictorJarPath,
                "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
                "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
            ),
            "blockedReason" to "q342-actual-binary-bundle-is-blocked-because-native-package-hash-evidence-json-explicit-user-bundle-approval-and-clean-user-side-flutter-log-are-not-present",
            "q328NativePackageHashEvidenceJsonProvided" to false,
            "q328NativePackageHashEvidenceJsonReviewed" to false,
            "q328NativePackageHashEvidenceJsonAccepted" to false,
            "requiredNativePackageFilesAllPresentInEvidence" to false,
            "perFileSha256EvidenceProvidedToAssistant" to false,
            "nativePackageHashEvidenceAccepted" to false,
            "explicitUserBinaryBundleApprovalProvided" to false,
            "q341OrNewerUserFlutterLogClean" to false,
            "finalBundlePermissionGranted" to false,
            "binaryBundlePermissionGranted" to false,
            "actualBinaryBundleAttempted" to false,
            "actualBinaryBundlePlacementAttempted" to false,
            "actualBinaryBundleExecuted" to false,
            "nativePackageFilesProvidedToProject" to false,
            "q315HashEvidenceSha256Matches" to true,
            "q315ArtifactSizeBytes" to 231675001L,
            "privateStorageRoot" to storageRoot.absolutePath,
            "artifactPath" to artifact.absolutePath,
            "artifactExists" to artifactExists,
            "artifactSizeBytes" to artifactSizeBytes,
            "expectedArtifactSha256" to q317ExpectedArtifactSha256,
            "actualArtifactSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "pubspecChanged" to false,
            "gradleChanged" to false,
            "androidManifestChanged" to false,
            "workspaceChanged" to false,
            "keyboardChanged" to false,
            "moreTemplateTrayChanged" to false,
            "longPressChanged" to false,
            "mathLiveProductionBridgeChanged" to false,
            "graphChanged" to false,
            "solutionChanged" to false,
            "historyChanged" to false,
            "splashChanged" to false,
            "iconChanged" to false,
            "nativeLibraryBundled" to false,
            "aarBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "abiPackagingTrialExecuted" to false,
            "buildTrialExecuted" to false,
            "buildTrialPassed" to false,
            "modelConversionExecuted" to false,
            "nativeModelLoaderAdded" to false,
            "modelLoaderAvailable" to false,
            "modelArtifactAcceptedForRuntime" to false,
            "runtimeDependencyAdded" to false,
            "runtimeStartupAttempted" to false,
            "runtimeStartupExecuted" to false,
            "runtimeStartupSmokePassed" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallPassed" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferencePassed" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
        )
    }


    private fun installNativeSplashOverlay() {
        if (nativeSplashOverlay != null) return

        val splash = ImageView(this).apply {
            setBackgroundColor(Color.rgb(2, 5, 10))
            setImageResource(R.drawable.gauss_splash_screen_native)
            scaleType = ImageView.ScaleType.FIT_CENTER
            adjustViewBounds = false
            importantForAccessibility = View.IMPORTANT_FOR_ACCESSIBILITY_NO
            contentDescription = null
            keepScreenOn = true
        }

        val params = FrameLayout.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.MATCH_PARENT
        ).apply {
            gravity = Gravity.CENTER
        }

        addContentView(splash, params)
        nativeSplashOverlay = splash
    }

    private fun hideNativeSplashOverlay() {
        val overlay = nativeSplashOverlay ?: return
        nativeSplashOverlay = null
        (overlay.parent as? ViewGroup)?.removeView(overlay)
    }

    override fun onDestroy() {
        nativeSplashOverlay = null
        super.onDestroy()
    }

    private fun q343NativePackageHashEvidenceFinalAcceptanceRealBundleUnlockGate(method: String): Map<String, Any> {
        val requiredNativePackageFiles = listOf(
            "PaddlePredictor.jar",
            "arm64-v8a/libpaddle_lite_jni.so",
            "armeabi-v7a/libpaddle_lite_jni.so"
        )
        val optionalNativePackageFiles = listOf(
            "x86_64/libpaddle_lite_jni.so"
        )
        val plannedBundleTargets = listOf(
            "android/app/libs/PaddlePredictor.jar",
            "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
            "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so"
        )
        val hardBlocks = listOf(
            "no-real-bundle-unlock-without-q328-native-package-hash-evidence-json",
            "no-real-bundle-unlock-without-explicit-user-binary-bundle-approval",
            "no-real-bundle-unlock-without-q342-or-newer-clean-user-side-flutter-analyze-test-run-log",
            "no-so-jar-aar-bundled-in-q343",
            "no-jniLibs-or-android-app-libs-created-in-q343",
            "no-gradle-pubspec-androidmanifest-mutation-in-q343",
            "no-ui-redline-mutation-in-q343",
            "no-system-load-library-or-paddle-lite-instantiation-in-q343",
            "no-runtime-startup-model-loader-inference-review-import-or-ocr-pass-in-q343"
        )
        return mapOf(
            "phase" to q343Phase,
            "sourcePhase" to q342Phase,
            "method" to method,
            "nativeChannelName" to ocrRuntimeBridgeChannelName,
            "status" to q343Status,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q343FeatureEnabled,
            "selectedRuntimeDependencyCandidate" to "PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING",
            "selectedModelLoaderCandidate" to "PADDLE_LITE_OPTIMIZED_PADDLE_INFERENCE_MODEL_LOADER_PENDING_CONVERSION_EVIDENCE",
            "externalNativePackageEvidencePolicy" to "../MathProOcrNativePackages/Paddle_Lite_Android",
            "nativePackageEvidenceFileName" to "q328_native_library_package_hash_evidence.json",
            "q328CaptureScript" to "tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs",
            "q335IntakePreparationScript" to "tool/prepare_paddle_lite_native_package_intake_v172_q335.mjs",
            "q336EvidenceIntakeScript" to "tool/intake_q328_native_package_hash_evidence_v172_q336.mjs",
            "bundleUnlockStatus" to q343BundleUnlockStatus,
            "uiProtectionStatus" to q343UiProtectionStatus,
            "blockedReason" to "q343-real-binary-bundle-unlock-is-blocked-because-native-package-hash-evidence-json-explicit-user-bundle-approval-and-clean-user-side-flutter-log-are-not-present",
            "requiredNativePackageFiles" to requiredNativePackageFiles,
            "optionalNativePackageFiles" to optionalNativePackageFiles,
            "plannedBundleTargets" to plannedBundleTargets,
            "hardBlocks" to hardBlocks,
            "q328NativePackageHashEvidenceJsonProvided" to false,
            "q328NativePackageHashEvidenceJsonAccepted" to false,
            "explicitUserBinaryBundleApprovalProvided" to false,
            "q342OrNewerUserFlutterLogClean" to false,
            "realBundleUnlockGranted" to false,
            "actualBinaryBundleAttempted" to false,
            "actualBinaryBundlePlacementAttempted" to false,
            "actualBinaryBundleExecuted" to false,
            "nativeLibraryBundled" to false,
            "jarBundled" to false,
            "jniLibsDirectoryCreated" to false,
            "androidAppLibsDirectoryCreated" to false,
            "gradleChanged" to false,
            "pubspecChanged" to false,
            "androidManifestChanged" to false,
            "workspaceChanged" to false,
            "keyboardChanged" to false,
            "moreTemplateTrayChanged" to false,
            "longPressChanged" to false,
            "mathLiveProductionBridgeChanged" to false,
            "graphChanged" to false,
            "solutionChanged" to false,
            "historyChanged" to false,
            "splashChanged" to false,
            "iconChanged" to false,
            "systemLoadLibraryAdded" to false,
            "paddleLiteInstantiated" to false,
            "modelLoaderAvailable" to false,
            "runtimeStartupExecuted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false,
            "nextAllowedPhase" to "Q344_ACTUAL_BINARY_BUNDLE_ONLY_AFTER_EVIDENCE_APPROVAL_AND_CLEAN_FLUTTER_LOGS"
        )
    }


    private fun q357OnnxRealModelLoadSmoke(method: String): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val modelFile = File(storageRoot, q357OnnxModelFileName)
        val modelExists = modelFile.exists() && modelFile.isFile
        val modelSizeBytes = if (modelExists) modelFile.length() else 0L
        val actualSha256 = if (modelExists) {
            try { q318Sha256File(modelFile) } catch (_: Exception) { "" }
        } else {
            ""
        }
        val sha256MatchesExpected = actualSha256.isNotEmpty() && actualSha256 == q357ExpectedOnnxSha256
        return mapOf(
            "phase" to q357Phase,
            "repairPhase" to q384Phase,
            "sourcePhase" to q356r2PhaseLabel(),
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q384Status,
            "engine" to "PP-FormulaNet_plus",
            "selectedDependencyCoordinate" to q357SelectedDependencyCoordinate,
            "removedDependencyCoordinate" to q384OnnxRuntimeRemovedDependencyCoordinate,
            "featureFlagDefaultEnabled" to q357FeatureEnabled,
            "privateStorageRoot" to storageRoot.absolutePath,
            "modelPath" to modelFile.absolutePath,
            "expectedModelFileName" to q357OnnxModelFileName,
            "expectedModelSizeBytes" to q357ExpectedOnnxSizeBytes,
            "actualModelSizeBytes" to modelSizeBytes,
            "modelExists" to modelExists,
            "sizeMatchesExpected" to (modelSizeBytes == q357ExpectedOnnxSizeBytes),
            "expectedSha256" to q357ExpectedOnnxSha256,
            "actualSha256" to actualSha256,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "sha256Error" to "",
            "dependencyClassAvailable" to false,
            "dependencyClassError" to "q384-onnx-runtime-android-removed-from-base-apk",
            "blockedReason" to "q384-download-only-ocr-contract-onnx-runtime-not-bundled",
            "baseApkOnnxRuntimeBundled" to q384OnnxRuntimeBundledInBaseApk,
            "downloadOnlyOcrRuntimeContract" to q384DownloadOnlyOcrRuntimeContract,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "modelLoadError" to "q384-onnx-runtime-removed-from-base-apk",
            "modelLoadDurationMs" to 0L,
            "inputNames" to "",
            "outputNames" to "",
            "sessionClosed" to false,
            "sessionOptionsClosed" to false,
            "runtimeStartupExecuted" to false,
            "dummyRuntimeCallExecuted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "ocrPassClaimed" to false,
            "modelLoadPassClaimedByPackage" to false,
            "androidRealDevicePassClaimedByPackage" to false,
            "uiProtectionStatus" to q357UiProtectionStatus,
        )
    }

    private fun q358OnnxDummyInputRuntimeCall(method: String): Map<String, Any> {
        val modelLoadSmoke = q357OnnxRealModelLoadSmoke("q358-preflight-model-load-guard")
        val dependencyClassAvailable = modelLoadSmoke["dependencyClassAvailable"] == true
        val modelExists = modelLoadSmoke["modelExists"] == true
        val sizeMatchesExpected = modelLoadSmoke["sizeMatchesExpected"] == true
        val sha256MatchesExpected = modelLoadSmoke["sha256MatchesExpected"] == true
        val q357ModelLoadWouldBeBlocked = (modelLoadSmoke["blockedReason"] as? String ?: "").isNotEmpty()
        val blockedReason = when {
            !q358FeatureEnabled -> "default-off-feature-flag-disabled"
            !dependencyClassAvailable -> "onnx-runtime-android-class-not-available"
            !modelExists -> "private-storage-onnx-model-missing"
            !sizeMatchesExpected -> "onnx-model-size-mismatch"
            !sha256MatchesExpected -> "onnx-model-sha256-mismatch"
            q357ModelLoadWouldBeBlocked -> "q357-model-load-guard-blocked"
            else -> "dummy-runtime-call-not-enabled-by-package"
        }

        return mapOf(
            "phase" to q358Phase,
            "sourcePhase" to q357Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q358Status,
            "engine" to "PP-FormulaNet_plus",
            "selectedDependencyCoordinate" to q358SelectedDependencyCoordinate,
            "featureFlagDefaultEnabled" to q358FeatureEnabled,
            "expectedModelFileName" to q358OnnxModelFileName,
            "expectedModelSizeBytes" to q358ExpectedOnnxSizeBytes,
            "expectedSha256" to q358ExpectedOnnxSha256,
            "modelExists" to modelExists,
            "sizeMatchesExpected" to sizeMatchesExpected,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "dependencyClassAvailable" to dependencyClassAvailable,
            "blockedReason" to blockedReason,
            "requiresExplicitBridgeInvocation" to true,
            "requiresQ357ModelLoadGuard" to true,
            "dummyInputTensorShapePolicy" to "single-scalar-float-placeholder-only-if-feature-flag-enabled-and-guard-prerequisites-pass",
            "dummyRuntimeCallAutoExecuted" to false,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallSucceeded" to false,
            "dummyRuntimeCallError" to "",
            "modelLoadAutoExecuted" to false,
            "runtimeStartupExecuted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "ocrPassClaimed" to false,
            "modelLoadPassClaimedByPackage" to false,
            "dummyRuntimeCallPassClaimedByPackage" to false,
            "androidRealDevicePassClaimedByPackage" to false,
            "uiProtectionStatus" to q358UiProtectionStatus,
        )
    }


    private fun q359OnnxFirstImageToLatexInferenceGuard(method: String): Map<String, Any> {
        val dummyGuard = q358OnnxDummyInputRuntimeCall("q359-preflight-dummy-runtime-guard")
        val dependencyClassAvailable = dummyGuard["dependencyClassAvailable"] == true
        val modelExists = dummyGuard["modelExists"] == true
        val sizeMatchesExpected = dummyGuard["sizeMatchesExpected"] == true
        val sha256MatchesExpected = dummyGuard["sha256MatchesExpected"] == true
        val q358DummyGuardWouldBeBlocked = (dummyGuard["blockedReason"] as? String ?: "").isNotEmpty()
        val blockedReason = when {
            !q359FeatureEnabled -> "default-off-feature-flag-disabled"
            !dependencyClassAvailable -> "onnx-runtime-android-class-not-available"
            !modelExists -> "private-storage-onnx-model-missing"
            !sizeMatchesExpected -> "onnx-model-size-mismatch"
            !sha256MatchesExpected -> "onnx-model-sha256-mismatch"
            q358DummyGuardWouldBeBlocked -> "q358-dummy-runtime-guard-blocked"
            else -> "image-to-latex-inference-not-enabled-by-package"
        }

        return mapOf(
            "phase" to q359Phase,
            "sourcePhase" to q358Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q359Status,
            "engine" to "PP-FormulaNet_plus",
            "selectedDependencyCoordinate" to q359SelectedDependencyCoordinate,
            "featureFlagDefaultEnabled" to q359FeatureEnabled,
            "expectedModelFileName" to q359OnnxModelFileName,
            "expectedModelSizeBytes" to q359ExpectedOnnxSizeBytes,
            "expectedSha256" to q359ExpectedOnnxSha256,
            "modelExists" to modelExists,
            "sizeMatchesExpected" to sizeMatchesExpected,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "dependencyClassAvailable" to dependencyClassAvailable,
            "blockedReason" to blockedReason,
            "requiresExplicitBridgeInvocation" to true,
            "requiresQ358DummyRuntimeGuard" to true,
            "inferenceRequiresPrivateStorageArtifact" to true,
            "inferenceRequiresExactSize" to true,
            "inferenceRequiresExactSha256" to true,
            "requiresEditableMathLiveReviewBeforeImport" to true,
            "requiresExplicitUserApprovalBeforeWorkspaceImport" to true,
            "candidateEnvelopePrepared" to true,
            "candidateEnvelopeVersion" to "q359-candidate-envelope-v1-default-off",
            "candidateSource" to "none-default-off-guard-only",
            "candidateLatex" to "",
            "candidateConfidence" to 0.0,
            "candidateAlternatives" to emptyList<String>(),
            "realImageToLatexInferenceAutoExecuted" to false,
            "realImageToLatexInferenceAttempted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "realImageToLatexInferenceSucceeded" to false,
            "imageToLatexPassClaimedByPackage" to false,
            "startupImageToLatexInferenceExecuted" to false,
            "cameraFlowImageToLatexInferenceExecuted" to false,
            "workspaceFlowImageToLatexInferenceExecuted" to false,
            "modelLoadAutoExecuted" to false,
            "dummyRuntimeCallAutoExecuted" to false,
            "runtimeStartupExecuted" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "ocrPassClaimed" to false,
            "modelLoadPassClaimedByPackage" to false,
            "dummyRuntimeCallPassClaimedByPackage" to false,
            "androidRealDevicePassClaimedByPackage" to false,
            "uiProtectionStatus" to q359UiProtectionStatus,
        )
    }


    private fun q361CameraOcrRuntimeExecutionBridge(method: String): Map<String, Any> {
        val candidateGuard = q359OnnxFirstImageToLatexInferenceGuard("q361-preflight-candidate-envelope-guard")
        val dependencyClassAvailable = candidateGuard["dependencyClassAvailable"] == true
        val modelExists = candidateGuard["modelExists"] == true
        val sizeMatchesExpected = candidateGuard["sizeMatchesExpected"] == true
        val sha256MatchesExpected = candidateGuard["sha256MatchesExpected"] == true
        val q359CandidateGuardWouldBeBlocked = (candidateGuard["blockedReason"] as? String ?: "").isNotEmpty()
        val blockedReason = when {
            !q361FeatureEnabled -> "default-off-feature-flag-disabled"
            !dependencyClassAvailable -> "onnx-runtime-android-class-not-available"
            !modelExists -> "private-storage-onnx-model-missing"
            !sizeMatchesExpected -> "onnx-model-size-mismatch"
            !sha256MatchesExpected -> "onnx-model-sha256-mismatch"
            q359CandidateGuardWouldBeBlocked -> "q359-candidate-envelope-guard-blocked"
            else -> "camera-ocr-runtime-execution-not-enabled-by-package"
        }

        return mapOf(
            "phase" to q361Phase,
            "sourcePhase" to q360PhaseLabel(),
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q361Status,
            "engine" to "PP-FormulaNet_plus",
            "selectedDependencyCoordinate" to q361SelectedDependencyCoordinate,
            "featureFlagDefaultEnabled" to q361FeatureEnabled,
            "expectedModelFileName" to q361OnnxModelFileName,
            "expectedModelSizeBytes" to q361ExpectedOnnxSizeBytes,
            "expectedSha256" to q361ExpectedOnnxSha256,
            "dependencyClassAvailable" to dependencyClassAvailable,
            "modelExists" to modelExists,
            "sizeMatchesExpected" to sizeMatchesExpected,
            "sha256MatchesExpected" to sha256MatchesExpected,
            "blockedReason" to blockedReason,
            "runtimeExecutionBridgePrepared" to true,
            "requiresExplicitBridgeInvocation" to true,
            "requiresQ357ModelLoadGuard" to true,
            "requiresQ358DummyRuntimeGuard" to true,
            "requiresQ359CandidateEnvelope" to true,
            "requiresQ360EditableReviewAndApprovedImportContract" to true,
            "cameraAutoExecutionBlocked" to true,
            "startupAutoExecutionBlocked" to true,
            "workspaceAutoExecutionBlocked" to true,
            "solveGraphSolutionHistoryAutoExecutionBlocked" to true,
            "requiresEditableMathLiveReviewBeforeImport" to true,
            "requiresExplicitUserApprovalBeforeWorkspaceImport" to true,
            "modelLoadAutoExecuted" to false,
            "modelLoadAttempted" to false,
            "dummyRuntimeCallAutoExecuted" to false,
            "dummyRuntimeCallAttempted" to false,
            "imageToLatexInferenceAutoExecuted" to false,
            "imageToLatexInferenceAttempted" to false,
            "imageToLatexInferenceExecuted" to false,
            "editableMathLiveReviewAutoOpened" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "approvedWorkspaceImportExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "modelLoadPassClaimedByPackage" to false,
            "dummyRuntimeCallPassClaimedByPackage" to false,
            "imageToLatexPassClaimedByPackage" to false,
            "ocrReviewPassClaimedByPackage" to false,
            "workspaceImportPassClaimedByPackage" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimedByPackage" to false,
            "uiProtectionStatus" to q361UiProtectionStatus,
        )
    }

    private fun q364OnnxModelArtifactPrivateStorageActivation(method: String, sourcePath: String?): Map<String, Any> {
        val storageRoot = File(filesDir, q318PrivateModelDirectoryName)
        val targetFile = File(storageRoot, q364OnnxModelFileName)
        val normalizedSourcePath = sourcePath?.trim() ?: ""
        val sourceProvided = normalizedSourcePath.isNotEmpty()
        val sourceFile = if (sourceProvided) File(normalizedSourcePath) else null
        val sourceExists = sourceFile?.let { it.exists() && it.isFile } == true
        val sourceSizeBytes = if (sourceExists) sourceFile!!.length() else 0L
        val sourceSizeMatchesExpected = sourceSizeBytes == q364ExpectedOnnxSizeBytes
        var sourceSha256 = ""
        var sourceSha256MatchesExpected = false
        var sourceSha256Error = ""
        if (sourceExists && sourceSizeMatchesExpected) {
            try {
                sourceSha256 = q318Sha256File(sourceFile!!)
                sourceSha256MatchesExpected = sourceSha256 == q364ExpectedOnnxSha256
            } catch (error: Exception) {
                sourceSha256Error = error.javaClass.simpleName + ": " + (error.message ?: "unknown source sha256 error")
            }
        }

        val targetExistsBefore = targetFile.exists() && targetFile.isFile
        val targetSizeBytesBefore = if (targetExistsBefore) targetFile.length() else 0L
        var targetSha256Before = ""
        var targetSha256MatchesExpectedBefore = false
        var targetSha256BeforeError = ""
        if (targetExistsBefore && targetSizeBytesBefore == q364ExpectedOnnxSizeBytes) {
            try {
                targetSha256Before = q318Sha256File(targetFile)
                targetSha256MatchesExpectedBefore = targetSha256Before == q364ExpectedOnnxSha256
            } catch (error: Exception) {
                targetSha256BeforeError = error.javaClass.simpleName + ": " + (error.message ?: "unknown target sha256 error")
            }
        }

        var storageDirectoryCreated = false
        var copyAttempted = false
        var copyExecuted = false
        var copyError = ""
        val sourceAndTargetSamePath = sourceFile?.absolutePath == targetFile.absolutePath
        val blockedReason = when {
            !q364FeatureEnabled -> "default-off-feature-flag-disabled"
            !sourceProvided && !targetSha256MatchesExpectedBefore -> "no-source-path-and-private-storage-model-not-ready"
            sourceProvided && !sourceExists -> "source-onnx-model-missing"
            sourceProvided && !sourceSizeMatchesExpected -> "source-onnx-model-size-mismatch"
            sourceProvided && !sourceSha256MatchesExpected -> "source-onnx-model-sha256-mismatch"
            else -> ""
        }

        if (blockedReason.isEmpty() && sourceProvided && !sourceAndTargetSamePath) {
            copyAttempted = true
            try {
                if (!storageRoot.exists()) {
                    storageDirectoryCreated = storageRoot.mkdirs()
                }
                val tempFile = File(storageRoot, q364OnnxModelFileName + ".q364.tmp")
                if (tempFile.exists()) tempFile.delete()
                FileInputStream(sourceFile!!).use { input ->
                    FileOutputStream(tempFile).use { output ->
                        input.copyTo(output)
                    }
                }
                if (targetFile.exists() && !targetFile.delete()) {
                    throw IllegalStateException("unable to replace existing ONNX model artifact")
                }
                if (!tempFile.renameTo(targetFile)) {
                    throw IllegalStateException("unable to atomically move ONNX model artifact into private storage")
                }
                copyExecuted = true
            } catch (error: Throwable) {
                copyError = error.javaClass.simpleName + ": " + (error.message ?: "unknown private storage copy error")
            }
        }

        val targetExistsAfter = targetFile.exists() && targetFile.isFile
        val targetSizeBytesAfter = if (targetExistsAfter) targetFile.length() else 0L
        val targetSizeMatchesExpectedAfter = targetSizeBytesAfter == q364ExpectedOnnxSizeBytes
        var targetSha256After = ""
        var targetSha256MatchesExpectedAfter = false
        var targetSha256AfterError = ""
        if (targetExistsAfter && targetSizeMatchesExpectedAfter) {
            try {
                targetSha256After = q318Sha256File(targetFile)
                targetSha256MatchesExpectedAfter = targetSha256After == q364ExpectedOnnxSha256
            } catch (error: Exception) {
                targetSha256AfterError = error.javaClass.simpleName + ": " + (error.message ?: "unknown target sha256 error")
            }
        }

        return mapOf(
            "phase" to q364Phase,
            "sourcePhase" to q361Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q364Status,
            "engine" to "PP-FormulaNet_plus",
            "selectedDependencyCoordinate" to q364SelectedDependencyCoordinate,
            "featureFlagDefaultEnabled" to q364FeatureEnabled,
            "requiresExplicitBridgeInvocation" to true,
            "sourcePathProvided" to sourceProvided,
            "sourcePath" to normalizedSourcePath,
            "sourceExists" to sourceExists,
            "sourceSizeBytes" to sourceSizeBytes,
            "sourceSizeMatchesExpected" to sourceSizeMatchesExpected,
            "sourceSha256" to sourceSha256,
            "sourceSha256MatchesExpected" to sourceSha256MatchesExpected,
            "sourceSha256Error" to sourceSha256Error,
            "privateStorageRoot" to storageRoot.absolutePath,
            "targetModelPath" to targetFile.absolutePath,
            "expectedModelFileName" to q364OnnxModelFileName,
            "expectedModelSizeBytes" to q364ExpectedOnnxSizeBytes,
            "expectedSha256" to q364ExpectedOnnxSha256,
            "targetExistsBefore" to targetExistsBefore,
            "targetSizeBytesBefore" to targetSizeBytesBefore,
            "targetSha256Before" to targetSha256Before,
            "targetSha256MatchesExpectedBefore" to targetSha256MatchesExpectedBefore,
            "targetSha256BeforeError" to targetSha256BeforeError,
            "storageDirectoryCreated" to storageDirectoryCreated,
            "copyAttempted" to copyAttempted,
            "copyExecuted" to copyExecuted,
            "copyError" to copyError,
            "sourceAndTargetSamePath" to sourceAndTargetSamePath,
            "blockedReason" to blockedReason,
            "targetExistsAfter" to targetExistsAfter,
            "targetSizeBytesAfter" to targetSizeBytesAfter,
            "targetSizeMatchesExpectedAfter" to targetSizeMatchesExpectedAfter,
            "targetSha256After" to targetSha256After,
            "targetSha256MatchesExpectedAfter" to targetSha256MatchesExpectedAfter,
            "targetSha256AfterError" to targetSha256AfterError,
            "privateStorageModelReady" to targetSha256MatchesExpectedAfter,
            "modelLoadAutoExecuted" to false,
            "modelLoadAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "ocrPassClaimed" to false,
            "modelPrivateStoragePassClaimedByPackage" to false,
            "androidRealDevicePassClaimedByPackage" to false,
            "uiProtectionStatus" to q364UiProtectionStatus,
        )
    }


    private fun q365OnnxRealModelLoadSmokeExecution(method: String): Map<String, Any> {
        val smoke = q389R6BOnnxModelLoadSmoke(method, null)
        return smoke + mapOf(
            "repairPhase" to q389R6BPhase,
            "sourcePhase" to q364Phase,
            "featureFlagDefaultEnabled" to q365FeatureEnabled,
            "baseApkOnnxRuntimeBundled" to true,
            "downloadOnlyOcrRuntimeContract" to "MODEL_DOWNLOAD_ONLY_RUNTIME_DEPENDENCY_PACKAGED_NO_MODEL_BYTES_IN_APK",
            "realRuntimeExecutionBlockedByBaseApkContract" to false,
            "runtimeStartupExecuted" to (smoke["modelLoaded"] == true),
            "dummyRuntimeCallExecuted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "ocrPassClaimed" to false,
            "modelLoadPassClaimedByPackage" to false,
            "androidRealDevicePassClaimedByPackage" to false,
            "uiProtectionStatus" to q365UiProtectionStatus,
        )
    }

    private fun q366OnnxDummyInputRuntimeCallExecution(method: String): Map<String, Any> {
        val modelLoadSmoke = q365OnnxRealModelLoadSmokeExecution("q366-base-apk-download-only-model-load-guard")
        return mapOf(
            "phase" to q366Phase,
            "repairPhase" to q384Phase,
            "sourcePhase" to q365Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q384Status,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q366FeatureEnabled,
            "modelLoadSmokeEvidence" to modelLoadSmoke,
            "dependencyClassAvailable" to false,
            "dependencyClassError" to "q384-onnx-runtime-android-removed-from-base-apk",
            "blockedReason" to "q384-download-only-ocr-contract-onnx-runtime-not-bundled",
            "baseApkOnnxRuntimeBundled" to q384OnnxRuntimeBundledInBaseApk,
            "downloadOnlyOcrRuntimeContract" to q384DownloadOnlyOcrRuntimeContract,
            "dummyRuntimeCallAttempted" to false,
            "dummyRuntimeCallExecuted" to false,
            "dummyRuntimeCallSucceeded" to false,
            "dummyRuntimeCallError" to "q384-onnx-runtime-removed-from-base-apk",
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "inputNames" to "",
            "outputNames" to "",
            "inputCount" to 0,
            "outputCount" to 0,
            "sessionClosed" to false,
            "sessionOptionsClosed" to false,
            "tensorClosed" to false,
            "resultClosed" to false,
            "runtimeStartupExecuted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "ocrPassClaimed" to false,
            "dummyRuntimeCallPassClaimedByPackage" to false,
            "androidRealDevicePassClaimedByPackage" to false,
            "uiProtectionStatus" to q366UiProtectionStatus,
        )
    }

    private fun q367FirstRealImageToLatexInferenceExecution(method: String, imagePath: String?): Map<String, Any> {
        val normalizedImagePath = (imagePath ?: "").trim()
        val imageFile = if (normalizedImagePath.isNotEmpty()) File(normalizedImagePath) else null
        val sourceImageExists = imageFile?.exists() == true && imageFile?.isFile == true
        val sourceImageSizeBytes = if (sourceImageExists) imageFile?.length() ?: 0L else 0L
        val modelEvidence = q365OnnxRealModelLoadSmokeExecution("q367-base-apk-download-only-model-load-guard")
        val decoderEvidence = q379DecoderResult(
            "",
            0.0,
            "q384-base-apk-onnx-runtime-removed",
            emptyList(),
            "q384-download-only-ocr-contract-onnx-runtime-not-bundled",
            "q384-runtime-pack-must-be-downloaded-before-real-ocr-execution"
        )
        return mapOf(
            "phase" to q367Phase,
            "repairPhase" to q384Phase,
            "sourcePhase" to q366Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q384Status,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q367FeatureEnabled,
            "sourceImagePath" to normalizedImagePath,
            "sourceImageProvided" to normalizedImagePath.isNotEmpty(),
            "sourceImageExists" to sourceImageExists,
            "sourceImageSizeBytes" to sourceImageSizeBytes,
            "modelLoadEvidence" to modelEvidence,
            "outputDecoderEvidence" to decoderEvidence,
            "dependencyClassAvailable" to false,
            "dependencyClassError" to "q384-onnx-runtime-android-removed-from-base-apk",
            "blockedReason" to "q384-download-only-ocr-contract-onnx-runtime-not-bundled",
            "baseApkOnnxRuntimeBundled" to q384OnnxRuntimeBundledInBaseApk,
            "downloadOnlyOcrRuntimeContract" to q384DownloadOnlyOcrRuntimeContract,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "imageDecodeAttempted" to false,
            "imageDecoded" to false,
            "tensorPreprocessAttempted" to false,
            "tensorPreprocessSucceeded" to false,
            "imageToLatexInferenceAttempted" to false,
            "imageToLatexInferenceExecuted" to false,
            "imageToLatexInferenceSucceeded" to false,
            "candidateLatex" to "",
            "candidateConfidence" to 0.0,
            "candidateSource" to "q384-base-apk-onnx-runtime-removed",
            "candidateAlternatives" to emptyList<String>(),
            "candidateLatexDecoded" to false,
            "outputDecodingImplemented" to true,
            "outputDecoderVersion" to q379DecoderVersion,
            "outputDecoderSummary" to "q384-runtime-pack-required-before-decoding",
            "decoderBlockedReason" to "q384-download-only-ocr-contract-onnx-runtime-not-bundled",
            "requiresEditableMathLiveReviewBeforeImport" to true,
            "requiresExplicitUserApprovalBeforeWorkspaceImport" to true,
            "directOcrToWorkspaceImportBlocked" to true,
            "directOcrToSolveGraphSolutionHistoryBlocked" to true,
            "startupImageToLatexInferenceExecuted" to false,
            "cameraFlowImageToLatexInferenceExecuted" to false,
            "workspaceFlowImageToLatexInferenceExecuted" to false,
            "workspaceImportExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "ocrPassClaimed" to false,
            "imageToLatexPassClaimedByPackage" to false,
            "androidRealDevicePassClaimedByPackage" to false,
            "uiProtectionStatus" to q367UiProtectionStatus,
        )
    }

    private fun q379RealOnnxOutputDecoderCandidateExtractionBinding(
        method: String,
        imagePath: String?,
        decoderLatexOverride: String?
    ): Map<String, Any> {
        val evidence = q375RealOcrExecutionOutputDecoderClosure(method, imagePath, decoderLatexOverride)
        return evidence + mapOf(
            "phase" to q379Phase,
            "sourcePhase" to q375Phase,
            "method" to method,
            "status" to q379Status,
            "decoderVersion" to q379DecoderVersion,
            "q375Evidence" to evidence,
            "directOcrToWorkspaceImportBlocked" to true,
            "directOcrToSolveGraphSolutionHistoryBlocked" to true,
            "requiresEditableMathLiveReviewBeforeImport" to true,
            "requiresExplicitUserApprovalBeforeWorkspaceImport" to true,
            "ocrPassClaimed" to false,
        )
    }

    private fun q379ExtractLatexCandidateFromOrtResult(resultSet: Any?): Map<String, Any> {
        val textFragments = mutableListOf<String>()
        val integerCodes = mutableListOf<Long>()
        val outputSummaries = mutableListOf<String>()
        if (resultSet == null) {
            return q379DecoderResult("", 0.0, "q379-no-result-set", emptyList(), "result-set-null", "")
        }
        try {
            val sizeMethod = resultSet.javaClass.methods.firstOrNull { it.name == "size" && it.parameterCount == 0 }
            val getMethod = resultSet.javaClass.methods.firstOrNull { it.name == "get" && it.parameterCount == 1 }
            val size = (sizeMethod?.invoke(resultSet) as? Number)?.toInt() ?: 0
            for (index in 0 until size) {
                val value = getMethod?.invoke(resultSet, index)
                outputSummaries.add("output[$index]=${value?.javaClass?.simpleName ?: "null"}")
                q379CollectReadableOutput(value, textFragments, integerCodes, outputSummaries, 0)
            }
        } catch (error: Throwable) {
            return q379DecoderResult(
                "",
                0.0,
                "q379-output-read-error",
                emptyList(),
                "onnx-output-read-error: ${error.javaClass.simpleName}: ${error.message ?: "unknown"}",
                outputSummaries.joinToString(" | ")
            )
        }

        val normalizedTextCandidates = textFragments
            .map { q379NormalizeLatexCandidate(it) }
            .filter { it.isNotEmpty() }
            .distinct()
        val bestTextCandidate = normalizedTextCandidates.firstOrNull()
        if (!bestTextCandidate.isNullOrEmpty()) {
            return q379DecoderResult(
                bestTextCandidate,
                0.74,
                "q379-readable-string-output",
                normalizedTextCandidates.drop(1).take(5),
                "",
                outputSummaries.joinToString(" | ")
            )
        }

        val asciiCandidate = q379DecodeAsciiLikeIntegers(integerCodes)
        if (asciiCandidate.isNotEmpty()) {
            return q379DecoderResult(
                asciiCandidate,
                0.68,
                "q379-ascii-or-unicode-codepoint-output",
                emptyList(),
                "",
                outputSummaries.joinToString(" | ")
            )
        }

        val vocab = q379LoadDecoderVocabulary()
        val vocabCandidate = q379DecodeTokenIdsWithVocabulary(integerCodes, vocab)
        if (vocabCandidate.isNotEmpty()) {
            return q379DecoderResult(
                vocabCandidate,
                0.66,
                "q379-token-id-output-with-private-vocabulary",
                emptyList(),
                "",
                outputSummaries.joinToString(" | ")
            )
        }

        val blockedReason = when {
            integerCodes.size > 2048 -> "decoder-output-too-large-for-generic-token-decoder"
            vocab.isEmpty() -> "decoder-vocabulary-not-available-or-empty-model-output"
            else -> "decoder-token-ids-not-mapped-to-latex"
        }
        return q379DecoderResult(
            "",
            0.0,
            "q379-no-readable-candidate",
            emptyList(),
            blockedReason,
            outputSummaries.joinToString(" | ")
        )
    }

    private fun q379DecoderResult(
        candidateLatex: String,
        confidence: Double,
        source: String,
        alternatives: List<String>,
        blockedReason: String,
        summary: String
    ): Map<String, Any> {
        val decodedCandidateLatex = candidateLatex
        val outputDecoderImplemented = true
        return mapOf(
            "candidateLatex" to decodedCandidateLatex,
            "candidateConfidence" to confidence,
            "candidateSource" to source,
            "candidateAlternatives" to alternatives,
            "candidateLatexDecoded" to decodedCandidateLatex.isNotEmpty(),
            "decoderBlockedReason" to blockedReason,
            "outputDecoderSummary" to summary,
            "outputDecodingImplemented" to outputDecoderImplemented,
            "outputDecoderVersion" to q379DecoderVersion,
            "decoderDoesNotInventLatex" to true,
        )
    }

    private fun q379CollectReadableOutput(
        value: Any?,
        textFragments: MutableList<String>,
        integerCodes: MutableList<Long>,
        summaries: MutableList<String>,
        depth: Int
    ) {
        if (value == null || depth > 8) return
        when (value) {
            is String -> textFragments.add(value)
            is CharSequence -> textFragments.add(value.toString())
            is ByteArray -> value.forEach { integerCodes.add(it.toLong()) }
            is ShortArray -> value.forEach { integerCodes.add(it.toLong()) }
            is IntArray -> value.forEach { integerCodes.add(it.toLong()) }
            is LongArray -> value.forEach { integerCodes.add(it) }
            is FloatArray -> value.forEach { if (q379IsIntegerLike(it.toDouble())) integerCodes.add(it.toLong()) }
            is DoubleArray -> value.forEach { if (q379IsIntegerLike(it)) integerCodes.add(it.toLong()) }
            is Array<*> -> value.forEach { q379CollectReadableOutput(it, textFragments, integerCodes, summaries, depth + 1) }
            is Iterable<*> -> value.forEach { q379CollectReadableOutput(it, textFragments, integerCodes, summaries, depth + 1) }
            is Map<*, *> -> value.values.forEach { q379CollectReadableOutput(it, textFragments, integerCodes, summaries, depth + 1) }
            is Number -> if (q379IsIntegerLike(value.toDouble())) integerCodes.add(value.toLong())
            else -> {
                val clazz = value.javaClass
                if (clazz.isArray) {
                    val length = java.lang.reflect.Array.getLength(value)
                    for (index in 0 until length) {
                        q379CollectReadableOutput(java.lang.reflect.Array.get(value, index), textFragments, integerCodes, summaries, depth + 1)
                    }
                } else {
                    val text = value.toString()
                    if (text.contains("\\") || text.any { it.isLetterOrDigit() }) {
                        textFragments.add(text)
                    }
                }
            }
        }
    }

    private fun q379IsIntegerLike(value: Double): Boolean {
        if (value.isNaN() || value.isInfinite()) return false
        val rounded = Math.round(value).toDouble()
        return kotlin.math.abs(value - rounded) < 0.0001 && rounded >= 0.0 && rounded <= 65535.0
    }

    private fun q379NormalizeLatexCandidate(raw: String): String {
        var text = raw
            .replace("\u0000", "")
            .replace("\r", " ")
            .replace("\n", " ")
            .trim()
        if (text.startsWith("[") && text.endsWith("]")) {
            text = text.removePrefix("[").removeSuffix("]").trim()
        }
        text = text.trim('"', '\'', ' ')
        text = text.replace(Regex("\\s+"), " ").trim()
        if (text.length > 512) text = text.take(512).trim()
        val hasMathSignal = text.contains("\\") || text.any { it.isDigit() } || text.any { it in "+-=^_/%×÷()[]{}" } || text.any { it in 'a'..'z' || it in 'A'..'Z' }
        if (!hasMathSignal) return ""
        if (text.contains("@") && !text.contains("\\")) return ""
        return text
    }

    private fun q379DecodeAsciiLikeIntegers(values: List<Long>): String {
        if (values.isEmpty() || values.size > 2048) return ""
        val chars = mutableListOf<Char>()
        for (value in values) {
            if (value == 0L || value == 1L || value == 2L) continue
            if (value in 32L..126L || value in 160L..65535L) {
                chars.add(value.toInt().toChar())
            } else if (chars.isNotEmpty()) {
                break
            }
        }
        return q379NormalizeLatexCandidate(chars.joinToString(""))
    }

    private fun q379LoadDecoderVocabulary(): Map<Long, String> {
        val roots = listOf(
            File(filesDir, q318PrivateModelDirectoryName),
            File(filesDir, q318PrivateModelDirectoryName + "-PaddleLiteNb")
        )
        for (root in roots) {
            val result = linkedMapOf<Long, String>()
            for (name in q379VocabularyFileNames) {
                val file = File(root, name)
                if (!file.exists() || !file.isFile || file.length() <= 0L || file.length() > q381MaxVocabularySidecarBytes) continue
                try {
                    val raw = file.readText().trim()
                    if (raw.startsWith("{")) {
                        val json = JSONObject(raw)
                        val tokenToId = json.optJSONObject("token_to_id")
                        if (tokenToId != null) {
                            val keys = tokenToId.keys()
                            while (keys.hasNext()) {
                                val token = keys.next()
                                val id = tokenToId.optLong(token, Long.MIN_VALUE)
                                if (id != Long.MIN_VALUE) result[id] = token
                            }
                        } else {
                            val keys = json.keys()
                            while (keys.hasNext()) {
                                val key = keys.next()
                                val id = key.toLongOrNull()
                                val token = json.optString(key)
                                if (id != null && token.isNotEmpty()) result[id] = token
                            }
                        }
                    } else if (raw.startsWith("[")) {
                        val arr = JSONArray(raw)
                        for (index in 0 until arr.length()) {
                            val token = arr.optString(index)
                            if (token.isNotEmpty()) result[index.toLong()] = token
                        }
                    } else {
                        var sequentialIndex = 0L
                        file.forEachLine { line ->
                            val trimmed = line.trim()
                            if (trimmed.isEmpty() || trimmed.startsWith("#")) return@forEachLine
                            val parts = trimmed.split(Regex("\\s+"), limit = 2)
                            val numericId = parts.firstOrNull()?.toLongOrNull()
                            if (numericId != null && parts.size == 2) {
                                result[numericId] = parts[1].trim()
                            } else {
                                result[sequentialIndex] = trimmed
                                sequentialIndex += 1L
                            }
                        }
                    }
                    if (result.isNotEmpty()) return result
                } catch (_: Throwable) {
                    result.clear()
                }
            }
        }
        return emptyMap()
    }

    private fun q379DecodeTokenIdsWithVocabulary(values: List<Long>, vocabulary: Map<Long, String>): String {
        if (values.isEmpty() || values.size > 2048 || vocabulary.isEmpty()) return ""
        val tokens = mutableListOf<String>()
        for (value in values) {
            val token = vocabulary[value]?.trim() ?: continue
            if (token in setOf("<s>", "</s>", "<pad>", "[PAD]", "[CLS]", "[SEP]", "<bos>", "<eos>")) continue
            tokens.add(token)
            if (tokens.size >= 512) break
        }
        return q379NormalizeLatexCandidate(tokens.joinToString("").replace("▁", " "))
    }



    private fun q381StringArgument(arguments: Any?, vararg names: String): String? {
        val map = arguments as? Map<*, *> ?: return null
        for (name in names) {
            val value = map[name] ?: continue
            return value.toString()
        }
        return null
    }

    private fun q381IntArgument(arguments: Any?, name: String): Int? {
        val map = arguments as? Map<*, *> ?: return null
        return when (val value = map[name]) {
            is Int -> value
            is Number -> value.toInt()
            is String -> value.trim().toIntOrNull()
            else -> null
        }
    }

    private fun q381DoubleArgument(arguments: Any?, name: String): Double? {
        val map = arguments as? Map<*, *> ?: return null
        return when (val value = map[name]) {
            is Double -> value
            is Number -> value.toDouble()
            is String -> value.trim().toDoubleOrNull()
            else -> null
        }
    }

    private fun q381FatalBlockedEvidence(method: String, imagePath: String?, error: Throwable): Map<String, Any> {
        val blockedReason = "q381r1-native-worker-exception"
        return mapOf(
            "phase" to q381Phase,
            "repairPhase" to q381R1Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to "BLOCKED",
            "engine" to "PP-FormulaNet_plus",
            "imagePath" to ((imagePath ?: "").trim()),
            "candidateLatex" to "",
            "candidateConfidence" to 0.0,
            "candidateLatexDecoded" to false,
            "decoderBlockedReason" to blockedReason,
            "blockedReason" to blockedReason,
            "nativeWorkerError" to (error.javaClass.simpleName + ": " + (error.message ?: "unknown native worker error")),
            "userFacingMessage" to q381UserFacingOcrMessage(blockedReason, false),
            "q381R1NativeWorkerOffMainThread" to true,
            "q381R1NoFakeLatexOnNativeFailure" to true,
            "editableMathLiveReviewRequiredBeforeImport" to true,
            "explicitUserApprovalRequiredBeforeImport" to true,
            "directOcrToWorkspaceImportBlocked" to true,
            "directOcrToSolveGraphSolutionHistoryBlocked" to true,
            "workspaceImportAutoExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "onnxModelBundledInZip" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimedByPackage" to false
        )
    }

    private fun q381CameraOcrRuntimeFinalizationCropModelVocabReviewCompletion(
        method: String,
        imagePath: String?,
        modelSourcePath: String?,
        decoderLatexOverride: String?,
        rotationQuarterTurns: Int,
        cropFrameWidthFactor: Double,
        cropFrameHeightFactor: Double
    ): Map<String, Any> {
        val normalizedImagePath = (imagePath ?: "").trim()
        val normalizedModelSourcePath = (modelSourcePath ?: "").trim()
        val rotation = ((rotationQuarterTurns % 4) + 4) % 4
        val cropWidthFactor = cropFrameWidthFactor.coerceIn(0.20, 1.0)
        val cropHeightFactor = cropFrameHeightFactor.coerceIn(0.20, 1.0)
        val cropEvidence = q381PrepareCroppedOcrInputImage(normalizedImagePath, rotation, cropWidthFactor, cropHeightFactor)
        val croppedImagePath = cropEvidence["croppedImagePath"] as? String ?: ""
        val cropReady = cropEvidence["cropReady"] == true
        val modelSidecarEvidence = if (normalizedModelSourcePath.isNotEmpty()) {
            q381ActivateVocabularySidecarsFromSource(normalizedModelSourcePath)
        } else {
            mapOf(
                "attempted" to false,
                "sourceModelPathProvided" to false,
                "copiedVocabularySidecars" to emptyList<String>(),
                "reason" to "q381-model-source-path-not-provided"
            )
        }
        val runtimeEvidence = if (cropReady) {
            q380OcrRuntimeReadinessAdaptiveInputDecoderCompletion(
                "q381-adaptive-runtime-decoder",
                croppedImagePath,
                normalizedModelSourcePath,
                decoderLatexOverride
            )
        } else {
            mapOf(
                "phase" to q380Phase,
                "method" to "q381-adaptive-runtime-decoder-skipped",
                "status" to "BLOCKED",
                "candidateLatex" to "",
                "candidateConfidence" to 0.0,
                "candidateLatexDecoded" to false,
                "decoderBlockedReason" to (cropEvidence["blockedReason"] as? String ?: "q381-crop-input-not-ready"),
                "blockedReason" to (cropEvidence["blockedReason"] as? String ?: "q381-crop-input-not-ready"),
                "imageToLatexInferenceAttempted" to false
            )
        }
        val candidateLatex = (runtimeEvidence["candidateLatex"] as? String ?: "").trim()
        val candidateConfidence = (runtimeEvidence["candidateConfidence"] as? Double)
            ?: (runtimeEvidence["candidateConfidence"] as? Number)?.toDouble()
            ?: 0.0
        @Suppress("UNCHECKED_CAST")
        val alternatives = runtimeEvidence["candidateAlternatives"] as? List<String> ?: emptyList()
        val runtimeBlockedReason = (runtimeEvidence["blockedReason"] as? String ?: "").ifEmpty {
            runtimeEvidence["decoderBlockedReason"] as? String ?: ""
        }
        val blockedReason = when {
            !cropReady -> cropEvidence["blockedReason"] as? String ?: "q381-crop-input-not-ready"
            candidateLatex.isEmpty() -> runtimeBlockedReason.ifEmpty { "candidate-latex-not-decoded" }
            else -> ""
        }
        val userFacingMessage = q381UserFacingOcrMessage(blockedReason, candidateLatex.isNotEmpty())
        return mapOf(
            "phase" to q381Phase,
            "repairPhase" to q381R1Phase,
            "repairStatus" to q381R1Status,
            "sourcePhase" to q380Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to if (candidateLatex.isNotEmpty()) "REVIEW_READY" else "BLOCKED",
            "engine" to "PP-FormulaNet_plus",
            "q381CropAndRotationApplied" to cropReady,
            "q381ModelAndVocabPreflightApplied" to true,
            "q381AdaptiveRuntimeDecoderInvoked" to cropReady,
            "q381R1NativeWorkerOffMainThread" to true,
            "q381R1ExifOrientationAccounted" to (cropEvidence["exifOrientationReadAttempted"] == true),
            "q381R1MemorySafeCropDecodeApplied" to (cropEvidence["memorySafeDecodeApplied"] == true),
            "q381R1CropEvidencePixelMappingRecorded" to cropReady,
            "imagePath" to normalizedImagePath,
            "croppedImagePath" to croppedImagePath,
            "rotationQuarterTurns" to rotation,
            "cropFrameWidthFactor" to cropWidthFactor,
            "cropFrameHeightFactor" to cropHeightFactor,
            "cropEvidence" to cropEvidence,
            "modelVocabularySidecarEvidence" to modelSidecarEvidence,
            "runtimeEvidence" to runtimeEvidence,
            "candidateLatex" to candidateLatex,
            "candidateConfidence" to candidateConfidence,
            "candidateSource" to (runtimeEvidence["candidateSource"] as? String ?: "q381-runtime-decoder"),
            "candidateAlternatives" to alternatives,
            "candidateLatexDecoded" to candidateLatex.isNotEmpty(),
            "outputDecodingImplemented" to true,
            "outputDecoderVersion" to "q381-crop-model-vocab-adaptive-decoder-finalization-v1",
            "outputDecoderSummary" to (runtimeEvidence["outputDecoderSummary"] as? String ?: ""),
            "decoderBlockedReason" to blockedReason,
            "blockedReason" to blockedReason,
            "userFacingMessage" to userFacingMessage,
            "editableMathLiveReviewRequiredBeforeImport" to true,
            "explicitUserApprovalRequiredBeforeImport" to true,
            "directOcrToWorkspaceImportBlocked" to true,
            "directOcrToSolveGraphSolutionHistoryBlocked" to true,
            "workspaceImportAutoExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "onnxModelBundledInZip" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimedByPackage" to false
        )
    }

    private fun q381PrepareCroppedOcrInputImage(
        sourcePath: String,
        rotationQuarterTurns: Int,
        cropWidthFactor: Double,
        cropHeightFactor: Double
    ): Map<String, Any> {
        if (sourcePath.isEmpty()) {
            return mapOf("cropReady" to false, "blockedReason" to "source-image-path-missing", "croppedImagePath" to "")
        }
        val sourceFile = File(sourcePath)
        if (!sourceFile.exists() || !sourceFile.isFile) {
            return mapOf("cropReady" to false, "blockedReason" to "source-image-file-missing", "croppedImagePath" to "", "sourceImagePath" to sourcePath)
        }
        if (sourceFile.length() <= 0L) {
            return mapOf("cropReady" to false, "blockedReason" to "source-image-file-empty", "croppedImagePath" to "", "sourceImagePath" to sourcePath)
        }
        return try {
            q381CleanOldCropFiles()
            val bounds = BitmapFactory.Options().apply { inJustDecodeBounds = true }
            BitmapFactory.decodeFile(sourceFile.absolutePath, bounds)
            val boundsWidth = bounds.outWidth.coerceAtLeast(0)
            val boundsHeight = bounds.outHeight.coerceAtLeast(0)
            val sampleSize = q381ComputeDecodeSampleSize(boundsWidth, boundsHeight)
            val decodeOptions = BitmapFactory.Options().apply {
                inSampleSize = sampleSize
                inPreferredConfig = Bitmap.Config.ARGB_8888
            }
            val decoded = BitmapFactory.decodeFile(sourceFile.absolutePath, decodeOptions)
                ?: return mapOf("cropReady" to false, "blockedReason" to "source-image-decode-failed", "croppedImagePath" to "", "sourceImagePath" to sourcePath)
            val originalWidth = if (boundsWidth > 0) boundsWidth else decoded.width
            val originalHeight = if (boundsHeight > 0) boundsHeight else decoded.height
            val decodedWidth = decoded.width
            val decodedHeight = decoded.height
            val exifQuarterTurns = q381ReadExifOrientationQuarterTurns(sourceFile)
            val totalRotationQuarterTurns = ((rotationQuarterTurns + exifQuarterTurns) % 4 + 4) % 4
            val rotated = if (totalRotationQuarterTurns == 0) {
                decoded
            } else {
                val matrix = Matrix()
                matrix.postRotate(totalRotationQuarterTurns * 90f)
                Bitmap.createBitmap(decoded, 0, 0, decoded.width, decoded.height, matrix, true)
            }
            val rotatedWidth = rotated.width
            val rotatedHeight = rotated.height
            val cropWidth = (rotatedWidth * cropWidthFactor).toInt().coerceIn(1, rotatedWidth)
            val cropHeight = (rotatedHeight * cropHeightFactor).toInt().coerceIn(1, rotatedHeight)
            val left = ((rotatedWidth - cropWidth) / 2).coerceAtLeast(0)
            val top = ((rotatedHeight - cropHeight) / 2).coerceAtLeast(0)
            val cropped = Bitmap.createBitmap(rotated, left, top, cropWidth, cropHeight)
            val outDir = File(filesDir, q381CropOutputDirectoryName)
            outDir.mkdirs()
            val outFile = File(outDir, "q381_formula_crop_${System.currentTimeMillis()}.jpg")
            FileOutputStream(outFile).use { output ->
                cropped.compress(Bitmap.CompressFormat.JPEG, q381CropJpegQuality, output)
            }
            if (cropped !== rotated) cropped.recycle()
            if (rotated !== decoded) rotated.recycle()
            decoded.recycle()
            mapOf(
                "cropReady" to true,
                "blockedReason" to "",
                "sourceImagePath" to sourcePath,
                "sourceImageSizeBytes" to sourceFile.length(),
                "croppedImagePath" to outFile.absolutePath,
                "croppedImageSizeBytes" to outFile.length(),
                "sourceWidth" to originalWidth,
                "sourceHeight" to originalHeight,
                "decodedWidth" to decodedWidth,
                "decodedHeight" to decodedHeight,
                "decodeSampleSize" to sampleSize,
                "memorySafeDecodeApplied" to true,
                "maxDecodeDimensionPx" to q381MaxDecodeDimensionPx,
                "rotatedWidth" to rotatedWidth,
                "rotatedHeight" to rotatedHeight,
                "rotationQuarterTurnsRequestedByUser" to rotationQuarterTurns,
                "exifOrientationReadAttempted" to true,
                "exifOrientationQuarterTurns" to exifQuarterTurns,
                "totalRotationQuarterTurnsApplied" to totalRotationQuarterTurns,
                "rotationQuarterTurnsApplied" to totalRotationQuarterTurns,
                "cropLeft" to left,
                "cropTop" to top,
                "cropWidth" to cropWidth,
                "cropHeight" to cropHeight,
                "cropFrameWidthFactor" to cropWidthFactor,
                "cropFrameHeightFactor" to cropHeightFactor,
                "cropCoordinateSpace" to "decoded-then-exif-and-user-rotated-bitmap-center-window",
                "jpegQuality" to q381CropJpegQuality,
                "q381R1CropPreprocessHardened" to true
            )
        } catch (error: Throwable) {
            mapOf(
                "cropReady" to false,
                "blockedReason" to "q381-crop-preprocess-failed",
                "cropError" to (error.javaClass.simpleName + ": " + (error.message ?: "unknown crop preprocess error")),
                "croppedImagePath" to "",
                "sourceImagePath" to sourcePath,
                "memorySafeDecodeApplied" to true,
                "exifOrientationReadAttempted" to true,
                "q381R1CropPreprocessHardened" to true
            )
        }
    }

    private fun q381ComputeDecodeSampleSize(width: Int, height: Int): Int {
        if (width <= 0 || height <= 0) return 1
        var sampleSize = 1
        var largest = maxOf(width, height)
        while (largest / sampleSize > q381MaxDecodeDimensionPx) {
            sampleSize *= 2
        }
        return sampleSize.coerceAtLeast(1)
    }

    private fun q381ReadExifOrientationQuarterTurns(sourceFile: File): Int {
        return try {
            when (ExifInterface(sourceFile.absolutePath).getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL)) {
                ExifInterface.ORIENTATION_ROTATE_90 -> 1
                ExifInterface.ORIENTATION_ROTATE_180 -> 2
                ExifInterface.ORIENTATION_ROTATE_270 -> 3
                ExifInterface.ORIENTATION_TRANSPOSE -> 1
                ExifInterface.ORIENTATION_TRANSVERSE -> 3
                else -> 0
            }
        } catch (_: Throwable) {
            0
        }
    }

    private fun q381CleanOldCropFiles() {
        val outDir = File(filesDir, q381CropOutputDirectoryName)
        if (!outDir.exists() || !outDir.isDirectory) return
        val files = outDir.listFiles()?.filter { it.isFile && it.name.startsWith("q381_formula_crop_") } ?: return
        files.sortedByDescending { it.lastModified() }.drop(24).forEach { runCatching { it.delete() } }
    }

    private fun q381ActivateVocabularySidecarsFromSource(sourceModelPath: String): Map<String, Any> {
        val sourceFile = File(sourceModelPath)
        val sourceDir = sourceFile.parentFile
        val targetDir = File(filesDir, q318PrivateModelDirectoryName)
        targetDir.mkdirs()
        if (sourceDir == null || !sourceDir.exists() || !sourceDir.isDirectory) {
            return mapOf(
                "attempted" to true,
                "sourceModelPathProvided" to sourceModelPath.isNotEmpty(),
                "copiedVocabularySidecars" to emptyList<String>(),
                "missingVocabularySidecars" to q379VocabularyFileNames.toList(),
                "blockedReason" to "q381-vocabulary-source-directory-missing"
            )
        }
        val copied = mutableListOf<String>()
        val skipped = mutableListOf<String>()
        val errors = mutableListOf<String>()
        for (name in q379VocabularyFileNames) {
            val src = File(sourceDir, name)
            if (!src.exists() || !src.isFile || src.length() <= 0L) {
                skipped.add(name)
                continue
            }
            if (src.length() > q381MaxVocabularySidecarBytes) {
                errors.add("$name:too-large")
                continue
            }
            try {
                val dst = File(targetDir, name)
                val tmp = File(targetDir, "$name.tmp")
                FileInputStream(src).use { input -> FileOutputStream(tmp).use { output -> input.copyTo(output) } }
                if (dst.exists()) dst.delete()
                if (!tmp.renameTo(dst)) throw IllegalStateException("atomic vocabulary rename failed")
                copied.add(name)
            } catch (error: Throwable) {
                errors.add(name + ":" + error.javaClass.simpleName)
            }
        }
        return mapOf(
            "attempted" to true,
            "sourceModelPathProvided" to true,
            "sourceDirectory" to sourceDir.absolutePath,
            "targetDirectory" to targetDir.absolutePath,
            "copiedVocabularySidecars" to copied,
            "missingVocabularySidecars" to skipped,
            "copyErrors" to errors,
            "vocabularySidecarsReady" to (copied.isNotEmpty() || q379LoadDecoderVocabulary().isNotEmpty()),
            "blockedReason" to if (errors.isNotEmpty()) "q381-vocabulary-sidecar-copy-error" else ""
        )
    }

    private fun q381UserFacingOcrMessage(blockedReason: String, hasCandidate: Boolean): String {
        if (hasCandidate) return "OCR adayı hazır. İfadeyi kontrol edip onaylayınca workspace’e aktarılacak."
        return when (blockedReason) {
            "", "candidate-latex-not-decoded", "decoder-vocabulary-not-available-or-empty-model-output" -> "Görüntüden okunabilir denklem çıkarılamadı. Daha net, daha yakın ve yalnızca formülü içeren bir fotoğraf deneyebilirsin."
            "private-storage-onnx-model-missing" -> "PP-FormulaNet-S modeli bu cihazda hazır değil. Model dosyaları doğrulanıp private storage’a alınmadan kamera okuma çalışmaz."
            "q384r2-paddle-model-source-path-missing", "q384r2-paddle-model-directory-missing", "q384r2-paddle-primary-model-missing" -> "PP-FormulaNet-S modeli bu cihazda hazır değil. Modeli indirip doğruladıktan sonra kamera okuma hazırlanır."
            "q384r2-paddle-primary-model-too-small", "q384r2-paddle-primary-sha256-mismatch", "q384r2-paddle-sidecar-missing" -> "PP-FormulaNet-S model dosyaları doğrulanamadı. Bozuk veya eksik model kullanılmayacak; modeli tekrar indir."
            "q384r2-paddle-runtime-binding-not-enabled" -> "Model dosyaları hazır. OCR çalışma motoru bağlama fazı tamamlanmadan sahte kamera sonucu üretilmez."
            "q386-paddle-native-library-not-loaded", "q386-paddle-lite-api-not-available" -> "Paddle OCR çalışma motoru bu cihazda yüklenemedi. Uygulama sahte sonuç üretmedi; build/runtime logu kontrol edilmeli."
            "q386-paddle-lite-model-load-failed-or-artifact-format-incompatible" -> "Model dosyaları indirildi ama Paddle Lite bu artifact formatını yükleyemedi. Uyumluluk/conversion fazı tamamlanmadan kamera sonucu üretilmez."
            "q389r4-offline-formula-ocr-production-bundle-source-missing", "q389r4-offline-formula-ocr-production-bundle-not-ready", "q389r6b-onnx-model-missing", "q389r6b-onnx-model-file-not-found-or-empty" -> "Offline Formula OCR paketi bu cihazda hazır değil. Modeli indir ile doğrulanmış PP-FormulaNet_plus-S ONNX + decoder/preprocess paketi kurulmadan kamera formül okuma açılmaz."
            "q387-paddle-lite-nb-model-required", "q387-paddle-inference-directory-not-loadable-by-current-mobileconfig", "q387-current-paddlepredictor-jar-has-no-setModelDir" -> "Bu cihazdaki Paddle Lite MobileConfig mevcut indirme formatını doğrudan yükleyemiyor. Android için optimize edilmiş .nb model download-only olarak hazırlanıp doğrulanmadan kamera OCR sonucu üretilmez."
            "q387r1-real-paddle-lite-nb-artifact-evidence-required", "q387r1-nb-manifest-missing", "q387r1-nb-manifest-invalid", "q387r1-nb-sha256-mismatch", "q387r1-nb-artifact-kind-mismatch" -> "Android için optimize edilmiş .nb model manifest/SHA/provenance kanıtı eksik veya geçersiz. Doğrulanmamış modelle kamera OCR sonucu üretilmez."
            "q386-tensor-preprocess-failed", "q386-paddle-inference-run-failed", "q386-runtime-exception" -> "OCR çalışma motoru güvenli şekilde durdu. Uygulama sahte sonuç üretmedi; fotoğrafı veya model uyumluluğunu kontrol et."
            "q384-download-only-ocr-contract-onnx-runtime-not-bundled" -> "Model dosyaları hazır olsa bile OCR çalışma motoru bu base APK’da yok. Runtime pack hazır olmadan kamera okuma çalışmaz."
            "onnx-model-size-mismatch", "onnx-model-sha256-mismatch", "q389r6b-onnx-model-size-mismatch", "q389r6b-onnx-model-sha256-mismatch" -> "OCR modeli doğrulanamadı. Bozuk veya yanlış ONNX model dosyası kullanılmayacak."
            "q389r6b-onnx-runtime-session-failed", "q389r6b-onnx-runtime-inference-failed" -> "ONNX Runtime Mobile cihazda güvenli şekilde durdu. Uygulama sahte sonuç üretmedi; build/runtime logu kontrol edilmeli."
            "q389r6b-source-image-decode-failed" -> "Fotoğraf dosyası okunamadı. Tekrar çekip deneyebilirsin."
            "q389r6b-onnx-output-decoder-no-readable-candidate" -> "Model çalıştı ama okunabilir LaTeX adayı çıkarılamadı. Uygulama sahte sonuç üretmedi; decoder/vocabulary yan dosyası kontrol edilmeli."
            "source-image-path-missing", "source-image-file-missing", "source-image-file-empty", "source-image-decode-failed" -> "Fotoğraf dosyası okunamadı. Tekrar çekip deneyebilirsin."
            "q381-crop-preprocess-failed", "q381-crop-input-not-ready" -> "Kırpma görüntüsü hazırlanamadı. Fotoğrafı tekrar çekip çerçeveyi yeniden kullan."
            "q381r1-native-worker-exception" -> "OCR işlemi cihazda güvenli şekilde durdu. Uygulama sahte sonuç üretmedi; fotoğrafı tekrar deneyebilirsin."
            else -> "OCR güvenli şekilde durdu: $blockedReason"
        }
    }

    private fun q384R2DeferredPaddleModelRuntimeBindingPreflight(method: String, modelSourcePath: String?): Map<String, Any> {
        val normalizedModelSourcePath = (modelSourcePath ?: "").trim()
        val sourcePathProvided = normalizedModelSourcePath.isNotEmpty()
        val sourceFile = if (sourcePathProvided) File(normalizedModelSourcePath) else null
        val fallbackDirectory = File(filesDir, q318PrivateModelDirectoryName)
        val modelDirectory = when {
            sourceFile == null -> fallbackDirectory
            sourceFile.exists() && sourceFile.isDirectory -> sourceFile
            sourceFile.exists() && sourceFile.isFile -> sourceFile.parentFile ?: fallbackDirectory
            sourceFile.name == q384R2PrimaryModelFileName -> sourceFile.parentFile ?: fallbackDirectory
            else -> fallbackDirectory
        }
        val sourcePathKind = when {
            !sourcePathProvided -> "not-provided-default-private-storage"
            sourceFile?.exists() != true -> "provided-path-missing"
            sourceFile.isDirectory -> "directory"
            sourceFile.isFile -> "file"
            else -> "unknown"
        }
        val modelDirectoryExists = modelDirectory.exists() && modelDirectory.isDirectory
        val primaryModelFile = File(modelDirectory, q384R2PrimaryModelFileName)
        val primaryExists = primaryModelFile.exists() && primaryModelFile.isFile
        val primarySizeBytes = if (primaryExists) primaryModelFile.length() else 0L
        var primarySha256 = ""
        var primarySha256Error = ""
        if (primaryExists && primarySizeBytes >= q384R2MinimumPrimarySizeBytes) {
            try {
                primarySha256 = q318Sha256File(primaryModelFile)
            } catch (error: Throwable) {
                primarySha256Error = error.javaClass.simpleName + ": " + (error.message ?: "unknown sha256 error")
            }
        }
        val primarySha256MatchesExpected = primarySha256.isNotEmpty() && primarySha256 == q384R2ExpectedPrimarySha256
        val presentArtifacts = q384R2RequiredArtifactFileNames.filter { name ->
            val file = File(modelDirectory, name)
            file.exists() && file.isFile && file.length() > 0L
        }
        val missingArtifacts = q384R2RequiredArtifactFileNames.filter { name ->
            val file = File(modelDirectory, name)
            !file.exists() || !file.isFile || file.length() <= 0L
        }
        val paddleInferenceDirectoryReady = modelDirectoryExists && primaryExists && primarySizeBytes >= q384R2MinimumPrimarySizeBytes && primarySha256MatchesExpected && missingArtifacts.isEmpty()
        val q387CandidateNbModelFile = q387FindPaddleLiteNbModelFile(sourceFile ?: primaryModelFile, modelDirectory)
        val q387R1NbManifestEvidence = q387R1ValidateNbManifestEvidence(q387CandidateNbModelFile)
        val q387PaddleLiteNbModelReady = q387CandidateNbModelFile != null &&
            q387IsPaddleLiteNbModelFile(q387CandidateNbModelFile) &&
            q387R1NbManifestEvidence["q387r1NbArtifactReady"] == true
        val modelArtifactReady = paddleInferenceDirectoryReady || q387PaddleLiteNbModelReady
        var predictorClassAvailable = false
        var configClassAvailable = false
        var apiProbeError = ""
        try {
            Class.forName(q347PredictorClassName)
            predictorClassAvailable = true
            Class.forName(q347ConfigClassName)
            configClassAvailable = true
        } catch (error: Throwable) {
            apiProbeError = error.javaClass.name + ": " + (error.message ?: "no-message")
        }
        val blockedReason = when {
            !sourcePathProvided && !modelArtifactReady -> "q384r2-paddle-model-source-path-missing"
            !modelArtifactReady && !modelDirectoryExists -> "q384r2-paddle-model-directory-missing"
            !modelArtifactReady && !primaryExists -> "q384r2-paddle-primary-model-missing"
            !modelArtifactReady && primarySizeBytes < q384R2MinimumPrimarySizeBytes -> "q384r2-paddle-primary-model-too-small"
            !modelArtifactReady && !primarySha256MatchesExpected -> "q384r2-paddle-primary-sha256-mismatch"
            !modelArtifactReady && missingArtifacts.isNotEmpty() -> "q384r2-paddle-sidecar-missing"
            else -> q384R2RuntimeBindingBlockedReason
        }
        return mapOf(
            "phase" to q384R2Phase,
            "sourcePhase" to q384Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q384R2Status,
            "engine" to "PP-FormulaNet_plus",
            "artifactFormat" to q384R2ArtifactFormat,
            "modelSourcePathProvided" to sourcePathProvided,
            "modelSourcePath" to normalizedModelSourcePath,
            "sourcePathKind" to sourcePathKind,
            "modelDirectoryPath" to modelDirectory.absolutePath,
            "modelDirectoryExists" to modelDirectoryExists,
            "primaryModelPath" to primaryModelFile.absolutePath,
            "primaryModelFileName" to q384R2PrimaryModelFileName,
            "primaryModelExists" to primaryExists,
            "primaryModelSizeBytes" to primarySizeBytes,
            "minimumPrimaryModelSizeBytes" to q384R2MinimumPrimarySizeBytes,
            "expectedPrimarySha256" to q384R2ExpectedPrimarySha256,
            "primarySha256" to primarySha256,
            "primarySha256MatchesExpected" to primarySha256MatchesExpected,
            "primarySha256Error" to primarySha256Error,
            "requiredArtifactFiles" to q384R2RequiredArtifactFileNames,
            "presentArtifactFiles" to presentArtifacts,
            "missingArtifactFiles" to missingArtifacts,
            "paddleInferenceDirectoryReady" to paddleInferenceDirectoryReady,
            "q387CandidateNbModelPath" to (q387CandidateNbModelFile?.absolutePath ?: ""),
            "q387PaddleLiteNbModelReady" to q387PaddleLiteNbModelReady,
            "q387R1NbManifestEvidence" to q387R1NbManifestEvidence,
            "modelArtifactReady" to modelArtifactReady,
            "paddleLitePredictorClassName" to q347PredictorClassName,
            "paddleLiteConfigClassName" to q347ConfigClassName,
            "paddleLitePredictorApiClassAvailable" to predictorClassAvailable,
            "paddleLiteConfigApiClassAvailable" to configClassAvailable,
            "paddleLiteApiProbeError" to apiProbeError,
            "runtimeBindingAttempted" to false,
            "runtimeBindingEnabled" to false,
            "modelLoadAttempted" to false,
            "modelLoaded" to false,
            "imageToLatexInferenceAttempted" to false,
            "imageToLatexInferenceExecuted" to false,
            "candidateLatex" to "",
            "candidateLatexDecoded" to false,
            "blockedReason" to blockedReason,
            "userFacingBlockedReason" to q381UserFacingOcrMessage(blockedReason, false),
            "baseApkOnnxRuntimeBundled" to q384OnnxRuntimeBundledInBaseApk,
            "downloadOnlyOcrRuntimeContract" to q384DownloadOnlyOcrRuntimeContract,
            "onnxRuntimeReintroduced" to false,
            "productionInferenceClaimedByQ384R2" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimedByPackage" to false,
            "workspaceImportAutoExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false
        )
    }

    private fun q385PaddleRuntimeDeliveryDecision(method: String): Map<String, Any> {
        val supportedAbis = Build.SUPPORTED_ABIS.toList()
        val nativeLibraryDirectory = applicationInfo.nativeLibraryDir ?: ""
        val installedPaddleLibrary = if (nativeLibraryDirectory.isNotEmpty()) File(nativeLibraryDirectory, "libpaddle_lite_jni.so") else null
        val installedPaddleLibraryExists = installedPaddleLibrary != null && installedPaddleLibrary.exists() && installedPaddleLibrary.isFile
        val installedPaddleLibrarySizeBytes = if (installedPaddleLibraryExists) installedPaddleLibrary!!.length() else 0L
        val deviceSupportsArm64 = supportedAbis.contains(q385BaseRuntimeAbi)
        return mapOf(
            "phase" to q385Phase,
            "sourcePhase" to q384R2Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q385Status,
            "engine" to "PP-FormulaNet_plus / Paddle Lite",
            "baseRuntimeDeliveryMode" to q385BaseRuntimeDeliveryMode,
            "gradleAbiFilterContract" to q385GradleAbiFilterContract,
            "packagedBaseRuntimeAbi" to q385BaseRuntimeAbi,
            "supportedAbis" to supportedAbis,
            "deviceSupportsPackagedRuntimeAbi" to deviceSupportsArm64,
            "nativeLibraryDirectory" to nativeLibraryDirectory,
            "installedPaddleLibraryPath" to (installedPaddleLibrary?.absolutePath ?: ""),
            "installedPaddleLibraryExists" to installedPaddleLibraryExists,
            "installedPaddleLibrarySizeBytes" to installedPaddleLibrarySizeBytes,
            "paddlePredictorJarExpectedInBase" to true,
            "paddleLiteNativeRuntimeExpectedInBase" to true,
            "armeabiV7aPackagedInBaseRelease" to false,
            "x86OrX64PackagedInBaseRelease" to false,
            "modelBinaryBundledInBaseApp" to false,
            "modelDownloadOnlyContractPreserved" to true,
            "nativeRuntimeNetworkDownloadAllowed" to q385NativeRuntimeNetworkDownloadAllowed,
            "playFeatureDeliveryImplemented" to q385PlayFeatureDeliveryImplemented,
            "onnxRuntimeReintroducedInBaseApk" to q385OnnxRuntimeReintroducedInBaseApk,
            "runtimeBindingAttempted" to false,
            "modelLoadAttempted" to false,
            "imageToLatexInferenceAttempted" to false,
            "imageToLatexInferenceExecuted" to false,
            "workspaceImportAutoExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimedByPackage" to false
        )
    }

    private data class Q380InputTensorPlan(
        val shape: LongArray,
        val layout: String,
        val rank: Int,
        val channels: Int,
        val height: Int,
        val width: Int,
        val metadataShape: String,
        val unknownDimsReplaced: Boolean
    )

    private fun q386RealPaddleOcrInferenceBridge(
        method: String,
        imagePath: String?,
        modelSourcePath: String?,
        decoderLatexOverride: String?
    ): Map<String, Any> {
        val normalizedImagePath = (imagePath ?: "").trim()
        val normalizedModelSourcePath = (modelSourcePath ?: "").trim()
        val overrideCandidate = q379NormalizeLatexCandidate(decoderLatexOverride ?: "")
        val modelBindingEvidence = q384R2DeferredPaddleModelRuntimeBindingPreflight(
            "q386-q384r2-model-format-binding-preflight",
            normalizedModelSourcePath
        )
        val paddleInferenceDirectoryReady = modelBindingEvidence["paddleInferenceDirectoryReady"] == true
        val sourceFile = File(normalizedModelSourcePath)
        val modelDirectory = when {
            sourceFile.exists() && sourceFile.isDirectory -> sourceFile
            sourceFile.exists() && sourceFile.isFile -> sourceFile.parentFile ?: sourceFile
            else -> File(normalizedModelSourcePath)
        }
        val primaryModelFile = File(modelDirectory, q384R2PrimaryModelFileName)
        val q387CandidateNbModelFile = q387FindPaddleLiteNbModelFile(sourceFile, modelDirectory)
        val q387R1NbManifestEvidence = q387R1ValidateNbManifestEvidence(q387CandidateNbModelFile)
        val q387PaddleLiteNbModelReady = q387CandidateNbModelFile != null &&
            q387IsPaddleLiteNbModelFile(q387CandidateNbModelFile) &&
            q387R1NbManifestEvidence["q387r1NbArtifactReady"] == true
        val imageFile = File(normalizedImagePath)
        var nativeLibraryLoadAttempted = false
        var nativeLibraryLoaded = q346NativeLibraryLoaded
        var nativeLibraryLoadError = ""
        var predictorClassProbeSucceeded = false
        var configClassProbeSucceeded = false
        var modelLoadAttempted = false
        var modelLoaded = false
        var modelLoadError = ""
        var imageDecodeAttempted = false
        var imageDecoded = false
        var imageDecodeError = ""
        var tensorPreprocessAttempted = false
        var tensorPreprocessSucceeded = false
        var tensorPreprocessError = ""
        var imageToLatexInferenceAttempted = false
        var imageToLatexInferenceExecuted = false
        var imageToLatexInferenceError = ""
        var adaptiveInputLayout = ""
        var adaptiveTensorShape = ""
        var outputShapeSummary = ""
        var predictor: Any? = null
        var q387MobileConfigApiEvidence: Map<String, Any> = mapOf(
            "phase" to q387Phase,
            "status" to "q387-mobileconfig-api-not-probed",
            "supportsSetModelFromFile" to false,
            "supportsSetModelFromBuffer" to false,
            "supportsSetModelDir" to false
        )
        var q387SelectedModelLoadStrategy = "q387-runtime-not-started"
        var q387ModelLoadBlockedBeforeAttempt = false
        var q387ModelLoadBlockedReason = ""
        var outputDecoderEvidence: Map<String, Any> = q379DecoderResult(
            overrideCandidate,
            if (overrideCandidate.isNotEmpty()) 0.51 else 0.0,
            if (overrideCandidate.isNotEmpty()) "q386-explicit-decoder-override" else "q386-runtime-not-started",
            if (overrideCandidate.isNotEmpty()) listOf(overrideCandidate) else emptyList(),
            if (overrideCandidate.isNotEmpty()) "" else "q386-runtime-not-started",
            "q386-runtime-not-started"
        )

        if (overrideCandidate.isEmpty() && (paddleInferenceDirectoryReady || q387PaddleLiteNbModelReady) && normalizedImagePath.isNotEmpty() && imageFile.exists() && imageFile.isFile && imageFile.length() > 0L) {
            try {
                if (!q346NativeLibraryLoaded) {
                    nativeLibraryLoadAttempted = true
                    System.loadLibrary(q346PaddleLiteNativeLibraryName)
                    q346NativeLibraryLoaded = true
                }
                nativeLibraryLoaded = q346NativeLibraryLoaded
            } catch (error: Throwable) {
                nativeLibraryLoaded = false
                nativeLibraryLoadError = error.javaClass.name + ": " + (error.message ?: "no-message")
            }

            if (nativeLibraryLoaded) {
                try {
                    val predictorClass = Class.forName(q347PredictorClassName)
                    predictorClassProbeSucceeded = true
                    val configClass = Class.forName(q347ConfigClassName)
                    val configBaseClass = Class.forName(q347ConfigBaseClassName)
                    configClassProbeSucceeded = true
                    q387MobileConfigApiEvidence = q387CollectMobileConfigApiEvidence(configClass)
                    val config = configClass.getDeclaredConstructor().newInstance()
                    configClass.methods.firstOrNull { it.name == "setThreads" && it.parameterTypes.size == 1 }?.invoke(config, 2)
                    val supportsSetModelFromFile = q387MobileConfigApiEvidence["supportsSetModelFromFile"] == true
                    val supportsSetModelDir = q387MobileConfigApiEvidence["supportsSetModelDir"] == true
                    val nbModelFile = q387CandidateNbModelFile
                    val q387R1NbArtifactReady = q387R1NbManifestEvidence["q387r1NbArtifactReady"] == true
                    if (nbModelFile != null && q387IsPaddleLiteNbModelFile(nbModelFile) && q387R1NbArtifactReady && supportsSetModelFromFile) {
                        q387SelectedModelLoadStrategy = "q387r1-setModelFromFile-verified-paddle-lite-nb"
                        configClass.methods.firstOrNull { it.name == q387SetModelFromFileMethodName && it.parameterTypes.size == 1 }?.invoke(config, nbModelFile.absolutePath)
                        val createPredictor = predictorClass.getDeclaredMethod(q347CreatePredictorMethodName, configBaseClass)
                        modelLoadAttempted = true
                        predictor = createPredictor.invoke(null, config)
                        modelLoaded = predictor != null
                    } else {
                        q387SelectedModelLoadStrategy = when {
                            !supportsSetModelFromFile -> "q387-blocked-setModelFromFile-unavailable"
                            nbModelFile != null && !q387R1NbArtifactReady -> "q387r1-blocked-nb-manifest-evidence-required"
                            supportsSetModelDir -> "q387-setModelDir-present-but-not-selected-with-inference-directory"
                            else -> "q387-blocked-nb-model-required-current-jar-has-no-setModelDir"
                        }
                        q387ModelLoadBlockedBeforeAttempt = true
                        q387ModelLoadBlockedReason = when {
                            !supportsSetModelFromFile -> "q387-setModelFromFile-unavailable"
                            nbModelFile != null && !q387R1NbArtifactReady -> (q387R1NbManifestEvidence["blockedReason"] as? String ?: q387R1RealNbEvidenceRequiredBlockedReason)
                            !supportsSetModelDir && q387CurrentDownloadedArtifactFormat == q384R2ArtifactFormat -> q387NbModelRequiredBlockedReason
                            !supportsSetModelDir -> q387SetModelDirUnavailableReason
                            else -> q387InferenceDirectoryRejectedReason
                        }
                        modelLoaded = false
                        modelLoadError = q387ModelLoadBlockedReason
                    }
                } catch (error: Throwable) {
                    modelLoaded = false
                    modelLoadError = error.javaClass.name + ": " + (error.message ?: "no-message")
                }
            }

            if (modelLoaded && predictor != null) {
                var decoded: Bitmap? = null
                try {
                    imageDecodeAttempted = true
                    decoded = BitmapFactory.decodeFile(imageFile.absolutePath)
                    imageDecoded = decoded != null
                    if (decoded == null) {
                        imageDecodeError = "BitmapFactory.decodeFile returned null"
                    } else {
                        val inputTensor = predictor!!.javaClass.getMethod("getInput", Int::class.javaPrimitiveType).invoke(predictor, 0)
                        val rawShape = try {
                            inputTensor?.javaClass?.getMethod("shape")?.invoke(inputTensor) as? LongArray
                        } catch (_: Throwable) {
                            null
                        }
                        val tensorPlan = q380ResolveInputTensorPlan(rawShape)
                        adaptiveInputLayout = tensorPlan.layout
                        adaptiveTensorShape = tensorPlan.shape.joinToString(prefix = "[", postfix = "]")
                        tensorPreprocessAttempted = true
                        val nonNullDecoded = decoded ?: throw IllegalStateException("q386 decoded bitmap unavailable before tensor preprocessing")
                        val tensorValues = try {
                            q380BuildImageTensorValues(nonNullDecoded, tensorPlan)
                        } finally {
                            nonNullDecoded.recycle()
                            decoded = null
                        }
                        inputTensor?.javaClass?.getMethod("resize", LongArray::class.java)?.invoke(inputTensor, tensorPlan.shape as Any)
                        inputTensor?.javaClass?.getMethod("setData", FloatArray::class.java)?.invoke(inputTensor, tensorValues as Any)
                        tensorPreprocessSucceeded = true
                        imageToLatexInferenceAttempted = true
                        val runResult = predictor!!.javaClass.getMethod("run").invoke(predictor) as? Boolean ?: false
                        imageToLatexInferenceExecuted = runResult
                        val outputEvidence = q386CollectPaddleOutputs(predictor!!)
                        outputShapeSummary = outputEvidence["outputShapeSummary"] as? String ?: ""
                        outputDecoderEvidence = if (runResult) {
                            q380DecodeLogitOrTokenOutputs(outputEvidence["decodedOutputValues"])
                        } else {
                            q379DecoderResult("", 0.0, "q386-paddle-run-returned-false", emptyList(), "q386-paddle-run-returned-false", outputShapeSummary)
                        }
                    }
                } catch (error: Throwable) {
                    if (tensorPreprocessAttempted && !tensorPreprocessSucceeded) {
                        tensorPreprocessError = error.javaClass.name + ": " + (error.message ?: "no-message")
                    } else if (imageToLatexInferenceAttempted) {
                        imageToLatexInferenceError = error.javaClass.name + ": " + (error.message ?: "no-message")
                    } else {
                        imageDecodeError = error.javaClass.name + ": " + (error.message ?: "no-message")
                    }
                    outputDecoderEvidence = q379DecoderResult("", 0.0, "q386-runtime-exception", emptyList(), "q386-runtime-exception", error.javaClass.simpleName + ": " + (error.message ?: "unknown"))
                } finally {
                    decoded?.recycle()
                }
            }
        }

        val candidateLatex = q379NormalizeLatexCandidate(outputDecoderEvidence["candidateLatex"] as? String ?: "")
        val decoderBlocked = outputDecoderEvidence["decoderBlockedReason"] as? String ?: ""
        val blockedReason = when {
            candidateLatex.isNotEmpty() -> ""
            overrideCandidate.isNotEmpty() -> ""
            normalizedModelSourcePath.isEmpty() -> "q389r4-offline-formula-ocr-production-bundle-source-missing"
            !(paddleInferenceDirectoryReady || q387PaddleLiteNbModelReady) -> (modelBindingEvidence["blockedReason"] as? String ?: "q389r4-offline-formula-ocr-production-bundle-not-ready")
            normalizedImagePath.isEmpty() -> "source-image-path-missing"
            !imageFile.exists() || !imageFile.isFile -> "source-image-file-missing"
            !nativeLibraryLoaded -> "q386-paddle-native-library-not-loaded"
            !predictorClassProbeSucceeded || !configClassProbeSucceeded -> "q386-paddle-lite-api-not-available"
            q387ModelLoadBlockedBeforeAttempt -> q387ModelLoadBlockedReason.ifEmpty { q387NbModelRequiredBlockedReason }
            modelLoadAttempted && !modelLoaded -> q386IncompatibleArtifactBlockedReason
            imageDecodeAttempted && !imageDecoded -> "source-image-decode-failed"
            tensorPreprocessAttempted && !tensorPreprocessSucceeded -> "q386-tensor-preprocess-failed"
            imageToLatexInferenceAttempted && !imageToLatexInferenceExecuted -> "q386-paddle-inference-run-failed"
            decoderBlocked.isNotEmpty() -> decoderBlocked
            else -> q386IncompatibleArtifactBlockedReason
        }

        return mapOf(
            "phase" to q386Phase,
            "sourcePhase" to q386SourcePhase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to if (candidateLatex.isNotEmpty()) "REVIEW_READY" else q386Status,
            "engine" to "PP-FormulaNet_plus / Paddle Lite",
            "artifactFormat" to q386CurrentDownloadedArtifactFormat,
            "expectedMobileConfigModelFileMode" to q386ExpectedMobileConfigModelFileMode,
            "q387Phase" to q387Phase,
            "q387Status" to q387Status,
            "q387R1Phase" to q387R1Phase,
            "q387R1Status" to q387R1Status,
            "q387R1RequiredArtifactKind" to q387R1RequiredArtifactKind,
            "q387R1RequiredManifestFileName" to q387R1RequiredManifestFileName,
            "q387R1NbManifestEvidence" to q387R1NbManifestEvidence,
            "q387CurrentDownloadedArtifactFormat" to q387CurrentDownloadedArtifactFormat,
            "q387RequiredAndroidArtifactFormat" to q387RequiredAndroidArtifactFormat,
            "q387RequiredModelFileExtension" to q387RequiredModelFileExtension,
            "q387CandidateNbModelPath" to (q387CandidateNbModelFile?.absolutePath ?: ""),
            "q387PaddleLiteNbModelReady" to q387PaddleLiteNbModelReady,
            "q387MobileConfigApiEvidence" to q387MobileConfigApiEvidence,
            "q387SelectedModelLoadStrategy" to q387SelectedModelLoadStrategy,
            "q387ModelLoadBlockedBeforeAttempt" to q387ModelLoadBlockedBeforeAttempt,
            "q387ModelLoadBlockedReason" to q387ModelLoadBlockedReason,
            "q387ProductionInferencePassClaimed" to q387ProductionInferencePassClaimed,
            "modelSourcePath" to normalizedModelSourcePath,
            "sourceImagePath" to normalizedImagePath,
            "modelBindingEvidence" to modelBindingEvidence,
            "privateStorageActivationEvidence" to modelBindingEvidence,
            "paddleInferenceDirectoryReady" to paddleInferenceDirectoryReady,
            "primaryModelPath" to primaryModelFile.absolutePath,
            "primaryModelExists" to (primaryModelFile.exists() && primaryModelFile.isFile),
            "dependencyClassAvailable" to (predictorClassProbeSucceeded && configClassProbeSucceeded || modelBindingEvidence["paddleLitePredictorApiClassAvailable"] == true),
            "dependencyClassError" to if (predictorClassProbeSucceeded && configClassProbeSucceeded) "" else (modelBindingEvidence["paddleLiteApiProbeError"] as? String ?: nativeLibraryLoadError),
            "nativeLibraryLoadAttempted" to nativeLibraryLoadAttempted,
            "nativeLibraryLoaded" to nativeLibraryLoaded,
            "nativeLibraryLoadError" to nativeLibraryLoadError,
            "predictorClassProbeSucceeded" to predictorClassProbeSucceeded,
            "configClassProbeSucceeded" to configClassProbeSucceeded,
            "modelLoadAttempted" to modelLoadAttempted,
            "modelLoaded" to modelLoaded,
            "modelLoadError" to modelLoadError,
            "imageDecodeAttempted" to imageDecodeAttempted,
            "imageDecoded" to imageDecoded,
            "imageDecodeError" to imageDecodeError,
            "tensorPreprocessAttempted" to tensorPreprocessAttempted,
            "tensorPreprocessSucceeded" to tensorPreprocessSucceeded,
            "tensorPreprocessError" to tensorPreprocessError,
            "adaptiveInputLayout" to adaptiveInputLayout,
            "adaptiveTensorShape" to adaptiveTensorShape,
            "imageToLatexInferenceAttempted" to imageToLatexInferenceAttempted,
            "imageToLatexInferenceExecuted" to imageToLatexInferenceExecuted,
            "imageToLatexInferenceError" to imageToLatexInferenceError,
            "candidateLatex" to candidateLatex,
            "candidateConfidence" to ((outputDecoderEvidence["candidateConfidence"] as? Number)?.toDouble()?.coerceIn(0.0, 1.0) ?: 0.0),
            "candidateSource" to (outputDecoderEvidence["candidateSource"] as? String ?: "q386-no-readable-candidate"),
            "candidateAlternatives" to (outputDecoderEvidence["candidateAlternatives"] as? List<*> ?: emptyList<Any>()),
            "candidateLatexDecoded" to candidateLatex.isNotEmpty(),
            "outputDecodingImplemented" to true,
            "outputDecoderVersion" to q380DecoderVersion,
            "outputDecoderSummary" to (outputDecoderEvidence["outputDecoderSummary"] as? String ?: outputShapeSummary),
            "decoderBlockedReason" to blockedReason,
            "blockedReason" to blockedReason,
            "userFacingMessage" to q381UserFacingOcrMessage(blockedReason, candidateLatex.isNotEmpty()),
            "editableMathLiveReviewRequiredBeforeImport" to true,
            "explicitUserApprovalRequiredBeforeImport" to true,
            "directOcrToWorkspaceImportBlocked" to true,
            "directOcrToSolveGraphSolutionHistoryBlocked" to true,
            "workspaceImportAutoExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "onnxRuntimeReintroducedInBaseApk" to false,
            "modelBinaryBundledInBaseApp" to false,
            "productionInferenceClaimedByQ386" to false,
            "ocrPassClaimed" to q386OcrPassClaimed,
            "androidRealDevicePassClaimedByPackage" to false
        )
    }

    private fun q387R1ValidateNbManifestEvidence(nbModelFile: File?): Map<String, Any> {
        if (nbModelFile == null) {
            return mapOf(
                "phase" to q387R1Phase,
                "sourcePhase" to q387R1SourcePhase,
                "status" to q387R1Status,
                "q387r1NbArtifactReady" to false,
                "blockedReason" to q387R1RealNbEvidenceRequiredBlockedReason,
                "productionInferenceClaimed" to q387R1ProductionInferencePassClaimed,
                "nbBundledInBaseApp" to q387R1ProductionNbArtifactBundledInBaseApp
            )
        }
        val manifest = File(nbModelFile.parentFile ?: filesDir, q387R1RequiredManifestFileName)
        if (!manifest.exists() || !manifest.isFile || manifest.length() <= 0L) {
            return mapOf(
                "phase" to q387R1Phase,
                "sourcePhase" to q387R1SourcePhase,
                "status" to q387R1Status,
                "candidateNbModelPath" to nbModelFile.absolutePath,
                "requiredManifestPath" to manifest.absolutePath,
                "q387r1NbArtifactReady" to false,
                "blockedReason" to q387R1ManifestMissingBlockedReason,
                "productionInferenceClaimed" to q387R1ProductionInferencePassClaimed,
                "nbBundledInBaseApp" to q387R1ProductionNbArtifactBundledInBaseApp
            )
        }
        return try {
            val json = JSONObject(manifest.readText())
            val artifactKind = json.optString("artifactKind")
            val fileName = json.optString("fileName")
            val expectedSha256 = json.optString("sha256")
            val sourceProvenance = json.optString("conversionProvenance")
            val declaredSizeBytes = json.optLong("sizeBytes", 0L)
            val fileExists = nbModelFile.exists() && nbModelFile.isFile
            val actualSizeBytes = if (fileExists) nbModelFile.length() else 0L
            val actualSha256 = if (fileExists && actualSizeBytes >= q387R1MinimumNbSizeBytes) q318Sha256File(nbModelFile) else ""
            val fileNameMatches = fileName == nbModelFile.name
            val artifactKindMatches = artifactKind == q387R1RequiredArtifactKind
            val shaLooksValid = expectedSha256.matches(Regex("^[a-fA-F0-9]{64}$"))
            val shaMatches = shaLooksValid && expectedSha256.equals(actualSha256, ignoreCase = true)
            val sizeEnough = actualSizeBytes >= q387R1MinimumNbSizeBytes && declaredSizeBytes >= q387R1MinimumNbSizeBytes
            val provenancePresent = sourceProvenance.trim().isNotEmpty()
            val blockedReason = when {
                !fileExists -> q387R1RealNbEvidenceRequiredBlockedReason
                !fileNameMatches -> q387R1ManifestInvalidBlockedReason
                !artifactKindMatches -> q387R1ArtifactKindMismatchBlockedReason
                !sizeEnough -> q387R1ManifestInvalidBlockedReason
                !shaMatches -> q387R1ShaMismatchBlockedReason
                !provenancePresent -> q387R1ManifestInvalidBlockedReason
                else -> ""
            }
            mapOf(
                "phase" to q387R1Phase,
                "sourcePhase" to q387R1SourcePhase,
                "status" to q387R1Status,
                "candidateNbModelPath" to nbModelFile.absolutePath,
                "requiredManifestPath" to manifest.absolutePath,
                "artifactKind" to artifactKind,
                "fileName" to fileName,
                "fileNameMatches" to fileNameMatches,
                "artifactKindMatches" to artifactKindMatches,
                "sha256Verified" to shaMatches,
                "sizeBytes" to actualSizeBytes,
                "declaredSizeBytes" to declaredSizeBytes,
                "conversionProvenancePresent" to provenancePresent,
                "q387r1NbArtifactReady" to blockedReason.isEmpty(),
                "blockedReason" to blockedReason,
                "productionInferenceClaimed" to q387R1ProductionInferencePassClaimed,
                "nbBundledInBaseApp" to q387R1ProductionNbArtifactBundledInBaseApp
            )
        } catch (error: Throwable) {
            mapOf(
                "phase" to q387R1Phase,
                "sourcePhase" to q387R1SourcePhase,
                "status" to q387R1Status,
                "candidateNbModelPath" to nbModelFile.absolutePath,
                "requiredManifestPath" to manifest.absolutePath,
                "q387r1NbArtifactReady" to false,
                "blockedReason" to q387R1ManifestInvalidBlockedReason,
                "manifestParseError" to (error.javaClass.name + ": " + (error.message ?: "no-message")),
                "productionInferenceClaimed" to q387R1ProductionInferencePassClaimed,
                "nbBundledInBaseApp" to q387R1ProductionNbArtifactBundledInBaseApp
            )
        }
    }

    private fun q387IsPaddleLiteNbModelFile(file: File): Boolean {
        return file.exists() && file.isFile && file.name.endsWith(q387RequiredModelFileExtension, ignoreCase = true) && file.length() > 0L
    }

    private fun q387FindPaddleLiteNbModelFile(sourceFile: File, modelDirectory: File): File? {
        if (q387IsPaddleLiteNbModelFile(sourceFile)) return sourceFile
        return modelDirectory.listFiles()
            ?.filter { q387IsPaddleLiteNbModelFile(it) }
            ?.sortedByDescending { it.length() }
            ?.firstOrNull()
    }

    private fun q387CollectMobileConfigApiEvidence(configClass: Class<*>?): Map<String, Any> {
        val methods = configClass?.methods?.toList() ?: emptyList()
        val names = methods.map { it.name }.toSet()
        val inventory = methods
            .filter { method ->
                method.name == q387SetModelFromFileMethodName ||
                    method.name == q387SetModelFromBufferMethodName ||
                    method.name == q387SetModelDirMethodName ||
                    method.name == "setThreads" ||
                    method.name == "setPowerMode"
            }
            .map { method ->
                method.name + "(" + method.parameterTypes.joinToString(",") { it.simpleName } + ")"
            }
            .sorted()
        return mapOf(
            "phase" to q387Phase,
            "sourcePhase" to q387SourcePhase,
            "status" to q387Status,
            "paddleLiteConfigClassName" to q347ConfigClassName,
            "requiredAndroidArtifactFormat" to q387RequiredAndroidArtifactFormat,
            "currentDownloadedArtifactFormat" to q387CurrentDownloadedArtifactFormat,
            "supportsSetModelFromFile" to names.contains(q387SetModelFromFileMethodName),
            "supportsSetModelFromBuffer" to names.contains(q387SetModelFromBufferMethodName),
            "supportsSetModelDir" to names.contains(q387SetModelDirMethodName),
            "setModelDirUnavailableReason" to q387SetModelDirUnavailableReason,
            "nbModelRequiredBlockedReason" to q387NbModelRequiredBlockedReason,
            "methodInventory" to inventory,
            "productionInferenceClaimed" to q387ProductionInferencePassClaimed
        )
    }

    private fun q386CollectPaddleOutputs(predictor: Any): Map<String, Any> {
        val outputs = mutableListOf<Any>()
        val summaries = mutableListOf<String>()
        for (index in 0 until 4) {
            val tensor = try {
                predictor.javaClass.getMethod("getOutput", Int::class.javaPrimitiveType).invoke(predictor, index)
            } catch (_: Throwable) {
                null
            } ?: continue
            val shape = try { tensor.javaClass.getMethod("shape").invoke(tensor) as? LongArray } catch (_: Throwable) { null }
            summaries.add("output$index:${shape?.joinToString(prefix = "[", postfix = "]") ?: "unknown"}")
            for (methodName in listOf("getFloatData", "getLongData", "getIntData", "getByteData")) {
                val value = try { tensor.javaClass.getMethod(methodName).invoke(tensor) } catch (_: Throwable) { null }
                if (value != null) outputs.add(value)
            }
        }
        return mapOf(
            "decodedOutputValues" to outputs,
            "outputShapeSummary" to summaries.joinToString(";").take(2048)
        )
    }


    private fun q389R6BCloseQuietly(value: Any?) {
        try { (value as? AutoCloseable)?.close() } catch (_: Throwable) {}
    }

    private fun q389R6BIsOnnxModelFile(file: File?): Boolean {
        return file != null && file.exists() && file.isFile && file.name.endsWith(".onnx", ignoreCase = true) && file.length() > 0L
    }

    private fun q389R6BFindOnnxModelFile(modelSourcePath: String?): File? {
        val normalized = (modelSourcePath ?: "").trim()
        if (normalized.isNotEmpty()) {
            val source = File(normalized)
            if (q389R6BIsOnnxModelFile(source)) return source
            if (source.exists() && source.isDirectory) {
                val direct = File(source, q389R6BOnnxModelFileName)
                if (q389R6BIsOnnxModelFile(direct)) return direct
                val largest = source.listFiles()
                    ?.filter { q389R6BIsOnnxModelFile(it) }
                    ?.sortedByDescending { it.length() }
                    ?.firstOrNull()
                if (largest != null) return largest
            }
            val sibling = File(source.parentFile ?: File(""), q389R6BOnnxModelFileName)
            if (q389R6BIsOnnxModelFile(sibling)) return sibling
        }
        val q389R6BInstalled = File(File(filesDir, q389R6BInstallDirectoryName), q389R6BOnnxModelFileName)
        if (q389R6BIsOnnxModelFile(q389R6BInstalled)) return q389R6BInstalled
        val q318Installed = File(File(filesDir, q318PrivateModelDirectoryName), q389R6BOnnxModelFileName)
        if (q389R6BIsOnnxModelFile(q318Installed)) return q318Installed
        return null
    }

    private fun q389R6BOnnxModelFileEvidence(modelFile: File?): Map<String, Any> {
        val exists = q389R6BIsOnnxModelFile(modelFile)
        val size = if (exists) modelFile!!.length() else 0L
        val sha = if (exists) {
            try { q318Sha256File(modelFile!!) } catch (error: Throwable) { "sha-error:${error.javaClass.simpleName}" }
        } else ""
        val ready = exists && size == q389R6BExpectedOnnxSizeBytes && sha == q389R6BExpectedOnnxSha256
        val blockedReason = when {
            modelFile == null -> "q389r6b-onnx-model-missing"
            !exists -> "q389r6b-onnx-model-file-not-found-or-empty"
            size != q389R6BExpectedOnnxSizeBytes -> "q389r6b-onnx-model-size-mismatch"
            sha != q389R6BExpectedOnnxSha256 -> "q389r6b-onnx-model-sha256-mismatch"
            else -> ""
        }
        return mapOf(
            "phase" to q389R6BPhase,
            "modelPath" to (modelFile?.absolutePath ?: ""),
            "expectedModelFileName" to q389R6BOnnxModelFileName,
            "expectedSha256" to q389R6BExpectedOnnxSha256,
            "expectedSizeBytes" to q389R6BExpectedOnnxSizeBytes,
            "actualSha256" to sha,
            "actualSizeBytes" to size,
            "modelExists" to exists,
            "sha256MatchesExpected" to (sha == q389R6BExpectedOnnxSha256),
            "sizeMatchesExpected" to (size == q389R6BExpectedOnnxSizeBytes),
            "q389r6bOnnxModelReady" to ready,
            "blockedReason" to blockedReason
        )
    }

    private fun q389R6BOnnxModelLoadSmoke(method: String, modelSourcePath: String?): Map<String, Any> {
        val modelFile = q389R6BFindOnnxModelFile(modelSourcePath)
        val fileEvidence = q389R6BOnnxModelFileEvidence(modelFile)
        if (fileEvidence["q389r6bOnnxModelReady"] != true) {
            return mapOf(
                "phase" to q389R6BPhase,
                "sourcePhase" to q357Phase,
                "method" to method,
                "status" to "Q389R6B_ONNX_MODEL_NOT_READY",
                "engine" to q389R6BPrimaryEngine,
                "selectedDependencyCoordinate" to q389R6BSelectedDependencyCoordinate,
                "modelFileEvidence" to fileEvidence,
                "dependencyClassAvailable" to false,
                "blockedReason" to (fileEvidence["blockedReason"] as? String ?: "q389r6b-onnx-model-not-ready"),
                "modelLoadAttempted" to false,
                "modelLoaded" to false,
                "ocrPassClaimed" to false,
                "androidRealDevicePassClaimedByPackage" to false
            )
        }
        var session: Any? = null
        var options: Any? = null
        var env: Any? = null
        val started = System.currentTimeMillis()
        return try {
            val envClass = Class.forName("ai.onnxruntime.OrtEnvironment")
            val optionsClass = Class.forName("ai.onnxruntime.OrtSession\$SessionOptions")
            env = envClass.getMethod("getEnvironment").invoke(null)
            options = optionsClass.getDeclaredConstructor().newInstance()
            val createSession = env!!.javaClass.methods.firstOrNull { it.name == "createSession" && it.parameterCount == 2 }
                ?: throw IllegalStateException("createSession(String, SessionOptions) missing")
            session = createSession.invoke(env, modelFile!!.absolutePath, options)
            val inputInfo = session!!.javaClass.methods.firstOrNull { it.name == "getInputInfo" && it.parameterCount == 0 }?.invoke(session) as? Map<*, *>
            val outputInfo = session!!.javaClass.methods.firstOrNull { it.name == "getOutputInfo" && it.parameterCount == 0 }?.invoke(session) as? Map<*, *>
            mapOf(
                "phase" to q389R6BPhase,
                "sourcePhase" to q357Phase,
                "method" to method,
                "status" to "Q389R6B_ONNX_RUNTIME_SESSION_CREATED",
                "engine" to q389R6BPrimaryEngine,
                "selectedDependencyCoordinate" to q389R6BSelectedDependencyCoordinate,
                "modelFileEvidence" to fileEvidence,
                "dependencyClassAvailable" to true,
                "blockedReason" to "",
                "modelLoadAttempted" to true,
                "modelLoaded" to true,
                "modelLoadDurationMs" to (System.currentTimeMillis() - started),
                "inputNames" to ((inputInfo?.keys ?: emptySet<Any>()).joinToString(",")),
                "outputNames" to ((outputInfo?.keys ?: emptySet<Any>()).joinToString(",")),
                "inputInfoSummary" to q380DescribeNodeInfoMap(inputInfo as? Map<String, *>),
                "outputInfoSummary" to q380DescribeNodeInfoMap(outputInfo as? Map<String, *>),
                "ocrPassClaimed" to false,
                "androidRealDevicePassClaimedByPackage" to false
            )
        } catch (error: Throwable) {
            mapOf(
                "phase" to q389R6BPhase,
                "sourcePhase" to q357Phase,
                "method" to method,
                "status" to "Q389R6B_ONNX_RUNTIME_SESSION_FAILED",
                "engine" to q389R6BPrimaryEngine,
                "selectedDependencyCoordinate" to q389R6BSelectedDependencyCoordinate,
                "modelFileEvidence" to fileEvidence,
                "dependencyClassAvailable" to (error !is ClassNotFoundException),
                "dependencyClassError" to (error.javaClass.name + ": " + (error.message ?: "unknown")),
                "blockedReason" to "q389r6b-onnx-runtime-session-failed",
                "modelLoadAttempted" to true,
                "modelLoaded" to false,
                "modelLoadDurationMs" to (System.currentTimeMillis() - started),
                "ocrPassClaimed" to false,
                "androidRealDevicePassClaimedByPackage" to false
            )
        } finally {
            q389R6BCloseQuietly(session)
            q389R6BCloseQuietly(options)
        }
    }

    private fun q389R6BRealOnnxFormulaInference(
        method: String,
        imagePath: String?,
        modelSourcePath: String?,
        decoderLatexOverride: String?
    ): Map<String, Any> {
        val overrideCandidate = q379NormalizeLatexCandidate(decoderLatexOverride ?: "")
        val normalizedImagePath = (imagePath ?: "").trim()
        val modelFile = q389R6BFindOnnxModelFile(modelSourcePath)
        val fileEvidence = q389R6BOnnxModelFileEvidence(modelFile)
        var session: Any? = null
        var options: Any? = null
        var tensor: Any? = null
        var resultSet: Any? = null
        var bitmap: Bitmap? = null
        val started = System.currentTimeMillis()
        if (overrideCandidate.isNotEmpty()) {
            return mapOf(
                "phase" to q389R6BPhase,
                "method" to method,
                "engine" to q389R6BPrimaryEngine,
                "candidateLatex" to overrideCandidate,
                "candidateConfidence" to 0.99,
                "candidateSource" to "q389r6b-explicit-decoder-override",
                "candidateAlternatives" to listOf(overrideCandidate),
                "blockedReason" to "",
                "q389r6bOnnxRuntimePathSelected" to true,
                "ocrPassClaimed" to false
            )
        }
        if (fileEvidence["q389r6bOnnxModelReady"] != true) {
            return mapOf(
                "phase" to q389R6BPhase,
                "method" to method,
                "engine" to q389R6BPrimaryEngine,
                "modelFileEvidence" to fileEvidence,
                "q389r6bOnnxRuntimePathSelected" to true,
                "dependencyClassAvailable" to false,
                "blockedReason" to (fileEvidence["blockedReason"] as? String ?: "q389r6b-onnx-model-not-ready"),
                "candidateLatex" to "",
                "candidateConfidence" to 0.0,
                "candidateSource" to "q389r6b-no-model",
                "candidateAlternatives" to emptyList<Any>(),
                "ocrPassClaimed" to false
            )
        }
        return try {
            val imageFile = File(normalizedImagePath)
            bitmap = if (normalizedImagePath.isNotEmpty() && imageFile.exists()) BitmapFactory.decodeFile(imageFile.absolutePath) else null
            if (bitmap == null) {
                return mapOf(
                    "phase" to q389R6BPhase,
                    "method" to method,
                    "engine" to q389R6BPrimaryEngine,
                    "modelFileEvidence" to fileEvidence,
                    "q389r6bOnnxRuntimePathSelected" to true,
                    "blockedReason" to "q389r6b-source-image-decode-failed",
                    "imageDecodeAttempted" to true,
                    "imageDecoded" to false,
                    "candidateLatex" to "",
                    "candidateConfidence" to 0.0,
                    "candidateSource" to "q389r6b-image-decode-failed",
                    "candidateAlternatives" to emptyList<Any>(),
                    "ocrPassClaimed" to false
                )
            }
            val envClass = Class.forName("ai.onnxruntime.OrtEnvironment")
            val optionsClass = Class.forName("ai.onnxruntime.OrtSession\$SessionOptions")
            val tensorClass = Class.forName("ai.onnxruntime.OnnxTensor")
            val env = envClass.getMethod("getEnvironment").invoke(null)
            options = optionsClass.getDeclaredConstructor().newInstance()
            val createSession = env.javaClass.methods.firstOrNull { it.name == "createSession" && it.parameterCount == 2 }
                ?: throw IllegalStateException("createSession(String, SessionOptions) missing")
            session = createSession.invoke(env, modelFile!!.absolutePath, options)
            val inputInfo = session!!.javaClass.methods.firstOrNull { it.name == "getInputInfo" && it.parameterCount == 0 }?.invoke(session) as? Map<*, *>
            val firstInputName = inputInfo?.keys?.firstOrNull()?.toString() ?: "x"
            val rawShape = q380ExtractShapeFromNodeInfo(inputInfo?.get(firstInputName))
            val tensorPlan = q380ResolveInputTensorPlan(rawShape)
            val tensorValues = q380BuildImageTensorValues(bitmap!!, tensorPlan)
            val createTensor = tensorClass.methods.firstOrNull { it.name == "createTensor" && it.parameterCount == 3 && it.parameterTypes.getOrNull(1)?.name == "java.nio.FloatBuffer" }
                ?: throw IllegalStateException("OnnxTensor.createTensor(FloatBuffer) missing")
            tensor = createTensor.invoke(null, env, FloatBuffer.wrap(tensorValues), tensorPlan.shape)
            val inputs = HashMap<String, Any>()
            inputs[firstInputName] = tensor!!
            val runMethod = session!!.javaClass.methods.firstOrNull { it.name == "run" && it.parameterCount == 1 }
                ?: throw IllegalStateException("OrtSession.run(Map) missing")
            resultSet = runMethod.invoke(session, inputs)
            val decoderEvidence = q380DecodeLogitOrTokenOutputs(resultSet)
            val candidateLatex = q379NormalizeLatexCandidate(decoderEvidence["candidateLatex"] as? String ?: "")
            val blockedReason = if (candidateLatex.isNotEmpty()) "" else (decoderEvidence["decoderBlockedReason"] as? String ?: "q389r6b-onnx-output-decoder-no-readable-candidate")
            mapOf(
                "phase" to q389R6BPhase,
                "method" to method,
                "engine" to q389R6BPrimaryEngine,
                "selectedDependencyCoordinate" to q389R6BSelectedDependencyCoordinate,
                "modelFileEvidence" to fileEvidence,
                "q389r6bOnnxRuntimePathSelected" to true,
                "q389r6bOnnxModelReady" to true,
                "dependencyClassAvailable" to true,
                "blockedReason" to blockedReason,
                "modelLoadAttempted" to true,
                "modelLoaded" to true,
                "imageDecodeAttempted" to true,
                "imageDecoded" to true,
                "tensorPreprocessAttempted" to true,
                "tensorPreprocessSucceeded" to true,
                "tensorPlan" to tensorPlan.toString(),
                "inputName" to firstInputName,
                "imageToLatexInferenceAttempted" to true,
                "imageToLatexInferenceExecuted" to true,
                "imageToLatexInferenceSucceeded" to candidateLatex.isNotEmpty(),
                "candidateLatex" to candidateLatex,
                "candidateConfidence" to if (candidateLatex.isNotEmpty()) (decoderEvidence["candidateConfidence"] as? Number)?.toDouble()?.coerceIn(0.0, 1.0) ?: 0.56 else 0.0,
                "candidateSource" to if (candidateLatex.isNotEmpty()) (decoderEvidence["candidateSource"] as? String ?: "q389r6b-onnx-runtime-output-decoder") else "q389r6b-no-readable-candidate",
                "candidateAlternatives" to (decoderEvidence["candidateAlternatives"] as? List<*> ?: emptyList<Any>()),
                "outputDecoderSummary" to (decoderEvidence["outputDecoderSummary"] as? String ?: ""),
                "decoderBlockedReason" to blockedReason,
                "runtimeDurationMs" to (System.currentTimeMillis() - started),
                "editableMathLiveReviewRequiredBeforeImport" to true,
                "directOcrToWorkspaceImportBlocked" to true,
                "directOcrToSolveGraphSolutionHistoryBlocked" to true,
                "ocrPassClaimed" to false,
                "androidRealDevicePassClaimedByPackage" to false
            )
        } catch (error: Throwable) {
            mapOf(
                "phase" to q389R6BPhase,
                "method" to method,
                "engine" to q389R6BPrimaryEngine,
                "modelFileEvidence" to fileEvidence,
                "q389r6bOnnxRuntimePathSelected" to true,
                "dependencyClassAvailable" to (error !is ClassNotFoundException),
                "dependencyClassError" to (error.javaClass.name + ": " + (error.message ?: "unknown")),
                "blockedReason" to "q389r6b-onnx-runtime-inference-failed",
                "candidateLatex" to "",
                "candidateConfidence" to 0.0,
                "candidateSource" to "q389r6b-runtime-error",
                "candidateAlternatives" to emptyList<Any>(),
                "runtimeDurationMs" to (System.currentTimeMillis() - started),
                "ocrPassClaimed" to false,
                "androidRealDevicePassClaimedByPackage" to false
            )
        } finally {
            q389R6BCloseQuietly(resultSet)
            q389R6BCloseQuietly(tensor)
            q389R6BCloseQuietly(session)
            q389R6BCloseQuietly(options)
            if (bitmap != null && !bitmap!!.isRecycled) bitmap!!.recycle()
        }
    }

    private fun q380OcrRuntimeReadinessAdaptiveInputDecoderCompletion(
        method: String,
        imagePath: String?,
        modelSourcePath: String?,
        decoderLatexOverride: String?
    ): Map<String, Any> {
        val normalizedImagePath = (imagePath ?: "").trim()
        val normalizedModelSourcePath = (modelSourcePath ?: "").trim()
        val overrideCandidate = q379NormalizeLatexCandidate(decoderLatexOverride ?: "")
        val onnxModelCandidate = q389R6BFindOnnxModelFile(normalizedModelSourcePath)
        val onnxRuntimeBridgeEvidence = if (overrideCandidate.isEmpty() && q389R6BIsOnnxModelFile(onnxModelCandidate)) {
            q389R6BRealOnnxFormulaInference(
                "q380-q389r6b-real-onnx-runtime-mobile-bridge",
                normalizedImagePath,
                normalizedModelSourcePath,
                decoderLatexOverride
            )
        } else {
            null
        }
        val bridgeEvidence = onnxRuntimeBridgeEvidence ?: q386RealPaddleOcrInferenceBridge(
            "q380-q386-real-paddle-inference-bridge",
            normalizedImagePath,
            normalizedModelSourcePath,
            decoderLatexOverride
        )
        val modelBindingEvidence = bridgeEvidence["modelBindingEvidence"] as? Map<*, *> ?: bridgeEvidence["modelFileEvidence"] as? Map<*, *> ?: emptyMap<String, Any>()
        val paddleInferenceDirectoryReady = bridgeEvidence["paddleInferenceDirectoryReady"] == true
        val onnxRuntimeModelReady = bridgeEvidence["q389r6bOnnxModelReady"] == true || (bridgeEvidence["modelFileEvidence"] as? Map<*, *>)?.get("q389r6bOnnxModelReady") == true
        val bridgeCandidate = q379NormalizeLatexCandidate(bridgeEvidence["candidateLatex"] as? String ?: "")
        val candidateLatex = if (overrideCandidate.isNotEmpty()) overrideCandidate else bridgeCandidate
        val bridgeBlockedReason = bridgeEvidence["blockedReason"] as? String ?: bridgeEvidence["decoderBlockedReason"] as? String ?: ""
        val blockedReason = when {
            candidateLatex.isNotEmpty() -> ""
            bridgeBlockedReason.isNotEmpty() -> bridgeBlockedReason
            !(paddleInferenceDirectoryReady || onnxRuntimeModelReady || bridgeEvidence["q387PaddleLiteNbModelReady"] == true) -> "q389r4-offline-formula-ocr-production-bundle-not-ready"
            else -> q386IncompatibleArtifactBlockedReason
        }
        return mapOf(
            "phase" to q380Phase,
            "repairPhase" to q386Phase,
            "sourcePhase" to q384Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to if (candidateLatex.isNotEmpty()) "REVIEW_READY" else q386Status,
            "engine" to (bridgeEvidence["engine"] as? String ?: "PP-FormulaNet_plus"),
            "decoderVersion" to q380DecoderVersion,
            "modelSourcePathProvided" to normalizedModelSourcePath.isNotEmpty(),
            "sourceImagePath" to normalizedImagePath,
            "sourceImageProvided" to normalizedImagePath.isNotEmpty(),
            "modelBindingEvidence" to modelBindingEvidence,
            "privateStorageActivationEvidence" to modelBindingEvidence,
            "q386PaddleRuntimeBridgeEvidence" to bridgeEvidence,
            "q389R6BOnnxRuntimeBridgeEvidence" to (onnxRuntimeBridgeEvidence ?: emptyMap<String, Any>()),
            "paddleInferenceDirectoryReady" to paddleInferenceDirectoryReady,
            "onnxRuntimeModelReady" to onnxRuntimeModelReady,
            "dependencyClassAvailable" to (bridgeEvidence["dependencyClassAvailable"] == true),
            "dependencyClassError" to (bridgeEvidence["dependencyClassError"] as? String ?: ""),
            "blockedReason" to blockedReason,
            "baseApkOnnxRuntimeBundled" to (onnxRuntimeBridgeEvidence != null),
            "modelBytesBundledInBaseApk" to false,
            "downloadOnlyOcrRuntimeContract" to "ONNX_RUNTIME_DEPENDENCY_PACKAGED_MODEL_DOWNLOAD_ONLY_NO_MODEL_BYTES_IN_APK",
            "modelArtifactReady" to (paddleInferenceDirectoryReady || onnxRuntimeModelReady || bridgeEvidence["q387PaddleLiteNbModelReady"] == true),
            "modelLoadAttempted" to (bridgeEvidence["modelLoadAttempted"] == true),
            "modelLoaded" to (bridgeEvidence["modelLoaded"] == true),
            "imageDecodeAttempted" to (bridgeEvidence["imageDecodeAttempted"] == true),
            "imageDecoded" to (bridgeEvidence["imageDecoded"] == true),
            "tensorPreprocessAttempted" to (bridgeEvidence["tensorPreprocessAttempted"] == true),
            "tensorPreprocessSucceeded" to (bridgeEvidence["tensorPreprocessSucceeded"] == true),
            "imageToLatexInferenceAttempted" to (bridgeEvidence["imageToLatexInferenceAttempted"] == true),
            "imageToLatexInferenceExecuted" to (bridgeEvidence["imageToLatexInferenceExecuted"] == true),
            "imageToLatexInferenceSucceeded" to candidateLatex.isNotEmpty(),
            "candidateLatex" to candidateLatex,
            "candidateConfidence" to if (candidateLatex.isNotEmpty()) (bridgeEvidence["candidateConfidence"] as? Number)?.toDouble()?.coerceIn(0.0, 1.0) ?: 0.51 else 0.0,
            "candidateSource" to if (candidateLatex.isNotEmpty()) (bridgeEvidence["candidateSource"] as? String ?: "q389r6b-or-q386-real-output-decoder") else (bridgeEvidence["candidateSource"] as? String ?: "q389r6b-or-q386-no-readable-candidate"),
            "candidateAlternatives" to (bridgeEvidence["candidateAlternatives"] as? List<*> ?: emptyList<Any>()),
            "candidateLatexDecoded" to candidateLatex.isNotEmpty(),
            "outputDecodingImplemented" to true,
            "outputDecoderVersion" to q380DecoderVersion,
            "outputDecoderSummary" to (bridgeEvidence["outputDecoderSummary"] as? String ?: "q389r6b-or-q386-bridge-no-summary"),
            "decoderBlockedReason" to blockedReason,
            "editableMathLiveReviewRequiredBeforeImport" to true,
            "explicitUserApprovalRequiredBeforeImport" to true,
            "directOcrToWorkspaceImportBlocked" to true,
            "directOcrToSolveGraphSolutionHistoryBlocked" to true,
            "workspaceImportAutoExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "onnxModelBundledInZip" to false,
            "productionInferenceClaimedByQ384R2" to false,
            "productionInferenceClaimedByQ386" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimedByPackage" to false
        )
    }

    private fun q380ExtractShapeFromNodeInfo(nodeInfo: Any?): LongArray? {
        return try {
            val info = nodeInfo?.javaClass?.methods?.firstOrNull { it.name == "getInfo" && it.parameterCount == 0 }?.invoke(nodeInfo)
                ?: nodeInfo?.javaClass?.fields?.firstOrNull { it.name == "info" }?.get(nodeInfo)
            val shapeValue = info?.javaClass?.methods?.firstOrNull { it.name == "getShape" && it.parameterCount == 0 }?.invoke(info)
            when (shapeValue) {
                is LongArray -> shapeValue
                is IntArray -> shapeValue.map { it.toLong() }.toLongArray()
                is Array<*> -> shapeValue.mapNotNull { (it as? Number)?.toLong() }.toLongArray()
                else -> null
            }
        } catch (_: Throwable) {
            null
        }
    }

    private fun q380ResolveInputTensorPlan(rawShape: LongArray?): Q380InputTensorPlan {
        val fallback = longArrayOf(1L, 3L, q380DefaultInputHeight.toLong(), q380DefaultInputWidth.toLong())
        val shape = rawShape?.takeIf { it.size in 3..4 }?.copyOf() ?: fallback
        var unknownReplaced = rawShape == null
        fun dim(index: Int, fallbackValue: Long): Long {
            val value = shape.getOrNull(index) ?: fallbackValue
            return if (value > 0L) value else { unknownReplaced = true; fallbackValue }
        }
        return if (shape.size == 4) {
            val d1 = dim(1, 3L)
            val d2 = dim(2, q380DefaultInputHeight.toLong())
            val d3 = dim(3, q380DefaultInputWidth.toLong())
            if (d3 == 1L || d3 == 3L) {
                val h = dim(1, q380DefaultInputHeight.toLong()).coerceIn(16L, 2048L).toInt()
                val w = dim(2, q380DefaultInputWidth.toLong()).coerceIn(16L, 2048L).toInt()
                val c = d3.coerceIn(1L, 3L).toInt()
                Q380InputTensorPlan(longArrayOf(1L, h.toLong(), w.toLong(), c.toLong()), "NHWC", 4, c, h, w, rawShape?.joinToString(prefix="[", postfix="]") ?: "unknown", unknownReplaced)
            } else {
                val c = d1.coerceIn(1L, 3L).toInt()
                val h = d2.coerceIn(16L, 2048L).toInt()
                val w = d3.coerceIn(16L, 2048L).toInt()
                Q380InputTensorPlan(longArrayOf(1L, c.toLong(), h.toLong(), w.toLong()), "NCHW", 4, c, h, w, rawShape?.joinToString(prefix="[", postfix="]") ?: "unknown", unknownReplaced)
            }
        } else {
            val c = dim(0, 3L).coerceIn(1L, 3L).toInt()
            val h = dim(1, q380DefaultInputHeight.toLong()).coerceIn(16L, 2048L).toInt()
            val w = dim(2, q380DefaultInputWidth.toLong()).coerceIn(16L, 2048L).toInt()
            Q380InputTensorPlan(longArrayOf(c.toLong(), h.toLong(), w.toLong()), "CHW", 3, c, h, w, rawShape?.joinToString(prefix="[", postfix="]") ?: "unknown", unknownReplaced)
        }
    }

    private fun q380BuildImageTensorValues(bitmap: Bitmap, plan: Q380InputTensorPlan): FloatArray {
        val resized = Bitmap.createScaledBitmap(bitmap, plan.width, plan.height, true)
        try {
            val pixels = IntArray(plan.width * plan.height)
            resized.getPixels(pixels, 0, plan.width, 0, 0, plan.width, plan.height)
            val values = FloatArray(plan.shape.fold(1L) { acc, value -> acc * value.coerceAtLeast(1L) }.coerceAtMost(Int.MAX_VALUE.toLong()).toInt())
            val planeSize = plan.height * plan.width
            for (index in pixels.indices) {
                val pixel = pixels[index]
                val rgb = floatArrayOf(Color.red(pixel) / 255.0f, Color.green(pixel) / 255.0f, Color.blue(pixel) / 255.0f)
                when (plan.layout) {
                    "NHWC" -> {
                        val base = index * plan.channels
                        for (c in 0 until plan.channels) values[base + c] = rgb[c.coerceAtMost(2)]
                    }
                    else -> {
                        for (c in 0 until plan.channels) values[(c * planeSize) + index] = rgb[c.coerceAtMost(2)]
                    }
                }
            }
            return values
        } finally {
            if (resized !== bitmap && !resized.isRecycled) {
                resized.recycle()
            }
        }
    }

    private fun q380DescribeNodeInfoMap(map: Map<String, *>?): String {
        if (map == null || map.isEmpty()) return "none"
        return map.entries.joinToString(";") { entry ->
            val shape = q380ExtractShapeFromNodeInfo(entry.value)?.joinToString(prefix = "[", postfix = "]") ?: "unknown"
            "${entry.key}:$shape"
        }.take(2048)
    }

    private fun q380DecodeLogitOrTokenOutputs(resultSet: Any?): Map<String, Any> {
        if (resultSet == null) return q379DecoderResult("", 0.0, "q380-no-result-set", emptyList(), "result-set-null", "")
        val floatValues = mutableListOf<Float>()
        val integerCodes = mutableListOf<Long>()
        val summaries = mutableListOf<String>()
        try {
            when (resultSet) {
                is Iterable<*> -> resultSet.forEach { q380CollectNumericOutput(it, floatValues, integerCodes, summaries, 0) }
                is Map<*, *> -> resultSet.values.forEach { q380CollectNumericOutput(it, floatValues, integerCodes, summaries, 0) }
                else -> {
                    val iteratorMethod = resultSet.javaClass.methods.firstOrNull { it.name == "iterator" && it.parameterCount == 0 }
                    val iterator = iteratorMethod?.invoke(resultSet) as? Iterator<*>
                    if (iterator != null) {
                        while (iterator.hasNext()) {
                            val next = iterator.next()
                            val value = next?.javaClass?.methods?.firstOrNull { it.name == "getValue" && it.parameterCount == 0 }?.invoke(next)
                                ?: next?.javaClass?.fields?.firstOrNull { it.name == "value" }?.get(next)
                                ?: next
                            q380CollectNumericOutput(value, floatValues, integerCodes, summaries, 0)
                        }
                    } else {
                        q380CollectNumericOutput(resultSet, floatValues, integerCodes, summaries, 0)
                    }
                }
            }
        } catch (error: Throwable) {
            return q379DecoderResult("", 0.0, "q380-output-read-error", emptyList(), "output-read-error", error.javaClass.simpleName + ": " + (error.message ?: "unknown"))
        }
        val vocab = q379LoadDecoderVocabulary()
        val integerCandidate = q379DecodeTokenIdsWithVocabulary(integerCodes, vocab)
        if (integerCandidate.isNotEmpty()) {
            return q379DecoderResult(integerCandidate, 0.66, "q380-integer-token-output-with-private-vocabulary", listOf(integerCandidate), "", "integerValues=${integerCodes.size};vocab=${vocab.size};${summaries.joinToString("|").take(512)}")
        }
        val logitCandidate = q380DecodeFloatLogitsWithVocabulary(floatValues, vocab)
        if (logitCandidate.isNotEmpty()) {
            return q379DecoderResult(logitCandidate, 0.61, "q380-float-logit-output-with-private-vocabulary-argmax", listOf(logitCandidate), "", "floatValues=${floatValues.size};vocab=${vocab.size};${summaries.joinToString("|").take(512)}")
        }
        return q379DecoderResult("", 0.0, "q380-no-readable-logit-token-candidate", emptyList(), "decoder-vocabulary-not-available-or-empty-model-output", "floatValues=${floatValues.size};integerValues=${integerCodes.size};vocab=${vocab.size};${summaries.joinToString("|").take(512)}")
    }

    private fun q380CollectNumericOutput(value: Any?, floatValues: MutableList<Float>, integerCodes: MutableList<Long>, summaries: MutableList<String>, depth: Int) {
        if (value == null || depth > 8) return
        summaries.add(value.javaClass.simpleName)
        when (value) {
            is FloatArray -> value.forEach { floatValues.add(it); if (q379IsIntegerLike(it.toDouble())) integerCodes.add(it.toLong()) }
            is DoubleArray -> value.forEach { floatValues.add(it.toFloat()); if (q379IsIntegerLike(it)) integerCodes.add(it.toLong()) }
            is IntArray -> value.forEach { integerCodes.add(it.toLong()) }
            is LongArray -> value.forEach { integerCodes.add(it) }
            is ShortArray -> value.forEach { integerCodes.add(it.toLong()) }
            is ByteArray -> value.forEach { integerCodes.add(it.toLong()) }
            is Number -> {
                floatValues.add(value.toFloat())
                if (q379IsIntegerLike(value.toDouble())) integerCodes.add(value.toLong())
            }
            is Array<*> -> value.forEach { q380CollectNumericOutput(it, floatValues, integerCodes, summaries, depth + 1) }
            is Iterable<*> -> value.forEach { q380CollectNumericOutput(it, floatValues, integerCodes, summaries, depth + 1) }
            is Map<*, *> -> value.values.forEach { q380CollectNumericOutput(it, floatValues, integerCodes, summaries, depth + 1) }
            else -> if (value.javaClass.isArray) {
                val length = java.lang.reflect.Array.getLength(value)
                for (index in 0 until length.coerceAtMost(4096)) {
                    q380CollectNumericOutput(java.lang.reflect.Array.get(value, index), floatValues, integerCodes, summaries, depth + 1)
                }
            }
        }
    }

    private fun q380DecodeFloatLogitsWithVocabulary(values: List<Float>, vocabulary: Map<Long, String>): String {
        if (values.isEmpty() || vocabulary.isEmpty()) return ""
        val vocabSize = vocabulary.keys.maxOrNull()?.plus(1L)?.coerceAtMost(100000L)?.toInt() ?: return ""
        if (vocabSize <= 1 || values.size < vocabSize) return ""
        val tokenIds = mutableListOf<Long>()
        var offset = 0
        while (offset + vocabSize <= values.size && tokenIds.size < 512) {
            var bestIndex = 0
            var bestValue = Float.NEGATIVE_INFINITY
            for (i in 0 until vocabSize) {
                val score = values[offset + i]
                if (score > bestValue) { bestValue = score; bestIndex = i }
            }
            tokenIds.add(bestIndex.toLong())
            offset += vocabSize
        }
        return q379DecodeTokenIdsWithVocabulary(tokenIds, vocabulary)
    }

    private fun q368EditableMathLiveOcrReviewActivation(
        method: String,
        candidateLatex: String?,
        candidateConfidence: Double?,
        candidateSource: String?
    ): Map<String, Any> {
        val normalizedLatex = (candidateLatex ?: "").trim()
        val latexProvided = normalizedLatex.isNotEmpty()
        val confidence = candidateConfidence ?: 0.0
        val confidenceInRange = confidence >= 0.0 && confidence <= 1.0
        val blockedReason = when {
            !q368FeatureEnabled -> "feature-flag-disabled"
            !latexProvided -> "candidate-latex-empty-review-blocked"
            !confidenceInRange -> "candidate-confidence-out-of-range"
            else -> ""
        }
        val reviewHandoffPrepared = blockedReason.isEmpty()

        return mapOf(
            "phase" to q368Phase,
            "sourcePhase" to q367Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q368Status,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q368FeatureEnabled,
            "candidateEnvelopeVersion" to q368CandidateEnvelopeVersion,
            "candidateSource" to (candidateSource ?: "q368-explicit-review-handoff"),
            "candidateLatexProvided" to latexProvided,
            "candidateLatexLength" to normalizedLatex.length,
            "candidateConfidence" to confidence,
            "candidateConfidenceInRange" to confidenceInRange,
            "blockedReason" to blockedReason,
            "reviewHandoffPrepared" to reviewHandoffPrepared,
            "editableMathLiveReviewActivationPrepared" to true,
            "explicitBridgeInvocationRequired" to true,
            "requiresQ367CandidateEnvelope" to true,
            "requiresNonEmptyCandidateLatex" to true,
            "requiresEditableMathLiveReviewBeforeImport" to true,
            "requiresExplicitUserApprovalBeforeWorkspaceImport" to true,
            "mathLiveReviewTarget" to q368MathLiveReviewTarget,
            "mathLiveProductionRoutePreserved" to true,
            "directOcrToWorkspaceImportBlocked" to true,
            "directOcrToSolveGraphSolutionHistoryBlocked" to true,
            "reviewUiAutoOpened" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "approvedWorkspaceImportExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimedByPackage" to false,
            "uiProtectionStatus" to q368UiProtectionStatus,
        )
    }

    private fun q369ApprovedOcrWorkspaceImportActivation(
        method: String,
        candidateLatex: String?,
        approvedLatex: String?,
        candidateConfidence: Double?,
        candidateSource: String?,
        reviewCompleted: Boolean,
        userApproved: Boolean
    ): Map<String, Any> {
        val normalizedCandidateLatex = (candidateLatex ?: "").trim()
        val normalizedApprovedLatex = (approvedLatex ?: normalizedCandidateLatex).trim()
        val approvedLatexProvided = normalizedApprovedLatex.isNotEmpty()
        val confidence = candidateConfidence ?: 0.0
        val confidenceInRange = confidence >= 0.0 && confidence <= 1.0
        val blockedReason = when {
            !q369FeatureEnabled -> "feature-flag-disabled"
            !reviewCompleted -> "editable-mathlive-review-not-completed"
            !userApproved -> "explicit-user-approval-missing"
            !approvedLatexProvided -> "approved-latex-empty-import-blocked"
            !confidenceInRange -> "candidate-confidence-out-of-range"
            else -> ""
        }
        val approvedWorkspaceImportPrepared = blockedReason.isEmpty()

        return mapOf(
            "phase" to q369Phase,
            "sourcePhase" to q368Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q369Status,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q369FeatureEnabled,
            "approvedImportEnvelopeVersion" to q369ApprovedImportEnvelopeVersion,
            "candidateSource" to (candidateSource ?: "q369-explicit-approved-import"),
            "candidateLatexProvided" to normalizedCandidateLatex.isNotEmpty(),
            "candidateLatexLength" to normalizedCandidateLatex.length,
            "approvedLatexProvided" to approvedLatexProvided,
            "approvedLatexLength" to normalizedApprovedLatex.length,
            "approvedLatexPayload" to if (approvedWorkspaceImportPrepared) normalizedApprovedLatex else "",
            "candidateConfidence" to confidence,
            "candidateConfidenceInRange" to confidenceInRange,
            "editableMathLiveReviewCompleted" to reviewCompleted,
            "explicitUserApprovalProvided" to userApproved,
            "blockedReason" to blockedReason,
            "approvedWorkspaceImportActivationPrepared" to true,
            "approvedWorkspaceImportPrepared" to approvedWorkspaceImportPrepared,
            "explicitBridgeInvocationRequired" to true,
            "requiresQ368EditableReviewHandoff" to true,
            "requiresEditableMathLiveReviewBeforeImport" to true,
            "requiresExplicitUserApprovalBeforeWorkspaceImport" to true,
            "requiresNonEmptyApprovedLatex" to true,
            "workspaceImportTarget" to q369WorkspaceImportTarget,
            "mathLiveProductionRoutePreserved" to true,
            "directOcrToWorkspaceImportBlocked" to true,
            "directOcrToSolveGraphSolutionHistoryBlocked" to true,
            "workspaceImportAutoExecuted" to false,
            "workspaceImportExecuted" to false,
            "approvedWorkspaceImportExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "reviewUiAutoOpened" to false,
            "editableMathLiveReviewOpenedByBridge" to false,
            "ocrPassClaimed" to false,
            "workspaceImportPassClaimedByPackage" to false,
            "androidRealDevicePassClaimedByPackage" to false,
            "uiProtectionStatus" to q369UiProtectionStatus,
        )
    }

    private fun q371ControlledOcrActivationRuntimeEvidenceCapture(
        method: String,
        modelSourcePath: String?,
        imagePath: String?,
        candidateLatex: String?,
        approvedLatex: String?,
        candidateConfidence: Double?,
        executePrivateStorageActivation: Boolean,
        executeModelLoadSmoke: Boolean,
        executeDummyRuntimeCall: Boolean,
        executeImageToLatex: Boolean,
        prepareReviewHandoff: Boolean,
        prepareApprovedImport: Boolean,
        reviewCompleted: Boolean,
        userApproved: Boolean
    ): Map<String, Any> {
        val modelSourceProvided = !modelSourcePath.isNullOrBlank()
        val imagePathProvided = !imagePath.isNullOrBlank()
        val normalizedCandidateLatex = (candidateLatex ?: "").trim()
        val normalizedApprovedLatex = (approvedLatex ?: normalizedCandidateLatex).trim()
        val confidence = candidateConfidence ?: 0.0
        val confidenceInRange = confidence >= 0.0 && confidence <= 1.0
        val privateStorageResult = if (executePrivateStorageActivation) {
            q364OnnxModelArtifactPrivateStorageActivation("q371-private-storage-activation", modelSourcePath)
        } else {
            mapOf(
                "phase" to q364Phase,
                "method" to "q371-private-storage-activation-skipped",
                "skippedByQ371" to true,
                "modelSourceProvided" to modelSourceProvided,
                "targetReadyAfter" to false,
                "privateStorageActivationSucceeded" to false,
                "blockedReason" to "q371-private-storage-activation-not-requested"
            )
        }
        val modelLoadResult = if (executeModelLoadSmoke) {
            q365OnnxRealModelLoadSmokeExecution("q371-model-load-smoke")
        } else {
            mapOf(
                "phase" to q365Phase,
                "method" to "q371-model-load-smoke-skipped",
                "skippedByQ371" to true,
                "modelLoadAttempted" to false,
                "modelLoaded" to false,
                "blockedReason" to "q371-model-load-smoke-not-requested"
            )
        }
        val dummyRuntimeResult = if (executeDummyRuntimeCall) {
            q366OnnxDummyInputRuntimeCallExecution("q371-dummy-runtime-call")
        } else {
            mapOf(
                "phase" to q366Phase,
                "method" to "q371-dummy-runtime-call-skipped",
                "skippedByQ371" to true,
                "dummyRuntimeCallAttempted" to false,
                "dummyRuntimeCallSucceeded" to false,
                "blockedReason" to "q371-dummy-runtime-call-not-requested"
            )
        }
        val imageToLatexResult = if (executeImageToLatex) {
            q367FirstRealImageToLatexInferenceExecution("q371-image-to-latex-inference", imagePath)
        } else {
            mapOf(
                "phase" to q367Phase,
                "method" to "q371-image-to-latex-inference-skipped",
                "skippedByQ371" to true,
                "imagePathProvided" to imagePathProvided,
                "imageToLatexInferenceAttempted" to false,
                "imageToLatexInferenceSucceeded" to false,
                "candidateEnvelopePrepared" to false,
                "blockedReason" to "q371-image-to-latex-inference-not-requested"
            )
        }
        val candidateFromImage = (imageToLatexResult["candidateLatex"] as? String ?: "").trim()
        val candidateForReview = if (normalizedCandidateLatex.isNotEmpty()) normalizedCandidateLatex else candidateFromImage
        val reviewResult = if (prepareReviewHandoff) {
            q368EditableMathLiveOcrReviewActivation(
                "q371-editable-review-handoff",
                candidateForReview,
                confidence,
                "q371-controlled-ocr-activation-evidence-capture"
            )
        } else {
            mapOf(
                "phase" to q368Phase,
                "method" to "q371-editable-review-handoff-skipped",
                "skippedByQ371" to true,
                "reviewHandoffPrepared" to false,
                "editableMathLiveReviewOpened" to false,
                "blockedReason" to "q371-editable-review-handoff-not-requested"
            )
        }
        val approvedImportResult = if (prepareApprovedImport) {
            q369ApprovedOcrWorkspaceImportActivation(
                "q371-approved-workspace-import",
                candidateForReview,
                normalizedApprovedLatex,
                confidence,
                "q371-controlled-ocr-activation-evidence-capture",
                reviewCompleted,
                userApproved
            )
        } else {
            mapOf(
                "phase" to q369Phase,
                "method" to "q371-approved-workspace-import-skipped",
                "skippedByQ371" to true,
                "approvedWorkspaceImportPrepared" to false,
                "workspaceImportExecuted" to false,
                "blockedReason" to "q371-approved-workspace-import-not-requested"
            )
        }
        val requestedExecutionSteps = listOf(
            executePrivateStorageActivation,
            executeModelLoadSmoke,
            executeDummyRuntimeCall,
            executeImageToLatex
        ).count { it }
        val reviewHandoffPrepared = reviewResult["reviewHandoffPrepared"] == true
        val approvedWorkspaceImportPrepared = approvedImportResult["approvedWorkspaceImportPrepared"] == true

        return mapOf(
            "phase" to q371Phase,
            "sourcePhase" to q369Phase,
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q371Status,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q371FeatureEnabled,
            "evidenceEnvelopeVersion" to q371EvidenceEnvelopeVersion,
            "controlledOcrActivationRuntimeEvidenceCapturePrepared" to true,
            "explicitBridgeInvocationRequired" to true,
            "modelSourceProvided" to modelSourceProvided,
            "imagePathProvided" to imagePathProvided,
            "candidateLatexProvided" to normalizedCandidateLatex.isNotEmpty(),
            "approvedLatexProvided" to normalizedApprovedLatex.isNotEmpty(),
            "candidateConfidence" to confidence,
            "candidateConfidenceInRange" to confidenceInRange,
            "executePrivateStorageActivationRequested" to executePrivateStorageActivation,
            "executeModelLoadSmokeRequested" to executeModelLoadSmoke,
            "executeDummyRuntimeCallRequested" to executeDummyRuntimeCall,
            "executeImageToLatexRequested" to executeImageToLatex,
            "requestedExecutionSteps" to requestedExecutionSteps,
            "privateStorageEvidence" to privateStorageResult,
            "modelLoadEvidence" to modelLoadResult,
            "dummyRuntimeCallEvidence" to dummyRuntimeResult,
            "imageToLatexEvidence" to imageToLatexResult,
            "editableReviewEvidence" to reviewResult,
            "approvedWorkspaceImportEvidence" to approvedImportResult,
            "reviewHandoffPrepared" to reviewHandoffPrepared,
            "approvedWorkspaceImportPrepared" to approvedWorkspaceImportPrepared,
            "requiresQ364PrivateStorageActivation" to true,
            "requiresQ365ModelLoadSmoke" to true,
            "requiresQ366DummyRuntimeCall" to true,
            "requiresQ367ImageToLatexInference" to true,
            "requiresQ368EditableMathLiveReview" to true,
            "requiresQ369ApprovedWorkspaceImport" to true,
            "requiresEditableMathLiveReviewBeforeImport" to true,
            "requiresExplicitUserApprovalBeforeWorkspaceImport" to true,
            "directOcrToWorkspaceImportBlocked" to true,
            "directOcrToSolveGraphSolutionHistoryBlocked" to true,
            "startupAutoExecutionBlocked" to true,
            "cameraAutoExecutionBlocked" to true,
            "workspaceAutoExecutionBlocked" to true,
            "workspaceImportExecuted" to false,
            "approvedWorkspaceImportExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "ocrPassClaimed" to false,
            "modelPrivateStoragePassClaimedByPackage" to false,
            "modelLoadPassClaimedByPackage" to false,
            "dummyRuntimeCallPassClaimedByPackage" to false,
            "imageToLatexPassClaimedByPackage" to false,
            "ocrReviewPassClaimedByPackage" to false,
            "workspaceImportPassClaimedByPackage" to false,
            "androidRealDevicePassClaimedByPackage" to false,
            "storeReadyPassClaimed" to false,
            "releaseReadyPassClaimed" to false,
            "uiProtectionStatus" to q371UiProtectionStatus,
        )
    }

    private fun q375RealOcrExecutionOutputDecoderClosure(
        method: String,
        imagePath: String?,
        decoderLatexOverride: String?
    ): Map<String, Any> {
        val sourceImagePath = (imagePath ?: "").trim()
        val decoderOverride = (decoderLatexOverride ?: "").trim()
        val imageEvidence = if (sourceImagePath.isNotEmpty()) {
            q367FirstRealImageToLatexInferenceExecution("q375-real-image-to-latex-evidence", sourceImagePath)
        } else {
            mapOf(
                "phase" to q367Phase,
                "method" to "q375-real-image-to-latex-evidence-skipped",
                "imageToLatexInferenceAttempted" to false,
                "imageToLatexInferenceSucceeded" to false,
                "candidateLatex" to "",
                "blockedReason" to "q375-source-image-path-missing"
            )
        }
        val candidateFromInference = (imageEvidence["candidateLatex"] as? String ?: "").trim()
        val decodedCandidate = when {
            candidateFromInference.isNotEmpty() -> candidateFromInference
            decoderOverride.isNotEmpty() -> decoderOverride
            else -> ""
        }
        val candidateLatexDecoded = decodedCandidate.isNotEmpty()
        val inferenceBlockedReason = (imageEvidence["blockedReason"] as? String ?: "").trim()
        val decoderBlockedReason = when {
            !q375FeatureEnabled -> "feature-flag-disabled"
            sourceImagePath.isEmpty() -> "source-image-path-missing"
            inferenceBlockedReason.isNotEmpty() -> inferenceBlockedReason
            !candidateLatexDecoded -> "decoder-vocabulary-not-available-or-empty-model-output"
            else -> ""
        }
        val candidateConfidence = if (candidateLatexDecoded) {
            if (decoderOverride.isNotEmpty() && candidateFromInference.isEmpty()) 0.51 else 0.72
        } else {
            0.0
        }

        return mapOf(
            "phase" to q375Phase,
            "sourcePhase" to q374PhaseLabel(),
            "method" to method,
            "channel" to ocrRuntimeBridgeChannelName,
            "status" to q375Status,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q375FeatureEnabled,
            "decoderVersion" to q375DecoderVersion,
            "requiresExplicitBridgeInvocation" to true,
            "sourceImagePath" to sourceImagePath,
            "sourceImageProvided" to sourceImagePath.isNotEmpty(),
            "imageEvidence" to imageEvidence,
            "imageToLatexInferenceExecuted" to (imageEvidence["imageToLatexInferenceExecuted"] == true),
            "imageToLatexInferenceSucceeded" to (imageEvidence["imageToLatexInferenceSucceeded"] == true),
            "rawCandidateFromInference" to candidateFromInference,
            "decoderLatexOverrideProvided" to decoderOverride.isNotEmpty(),
            "candidateLatexDecoded" to candidateLatexDecoded,
            "candidateLatex" to decodedCandidate,
            "candidateConfidence" to candidateConfidence,
            "candidateSource" to if (candidateFromInference.isNotEmpty()) "q375-decoded-from-q367-inference-evidence" else if (decoderOverride.isNotEmpty()) "q375-explicit-decoder-override" else "q375-no-candidate",
            "decoderBlockedReason" to decoderBlockedReason,
            "outputDecoderImplemented" to true,
            "outputDecoderDoesNotInventLatex" to true,
            "decoderRequiresReadableModelOutputOrExplicitOverride" to true,
            "requiresEditableMathLiveReviewBeforeImport" to true,
            "requiresExplicitUserApprovalBeforeWorkspaceImport" to true,
            "directOcrToWorkspaceImportBlocked" to true,
            "directOcrToSolveGraphSolutionHistoryBlocked" to true,
            "startupAutoExecutionBlocked" to true,
            "cameraAutoExecutionBlocked" to true,
            "workspaceAutoExecutionBlocked" to true,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "approvedWorkspaceImportExecuted" to false,
            "solveGraphSolutionHistoryTouched" to false,
            "ocrPassClaimed" to false,
            "imageToLatexPassClaimedByPackage" to false,
            "androidRealDevicePassClaimedByPackage" to false,
            "uiProtectionStatus" to q375UiProtectionStatus,
        )
    }

    private fun q374PhaseLabel(): String {
        return "V172-Q374-CONTROLLED-OCR-ACTIVATION-EVIDENCE-READINESS-AGGREGATOR"
    }

    private fun q360PhaseLabel(): String {
        return "V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT"
    }

    private fun q356r2PhaseLabel(): String {
        return "V172-Q356R2-ONNX-RUNTIME-ANDROID-MISSING-BUILD-EVIDENCE-Q357-LOCK-GUARD"
    }


    private fun q346NativeLibraryLoadSmoke(method: String): Map<String, Any> {
        var nativeLibraryLoadAttempted = false
        var nativeLibraryLoadSucceeded = q346NativeLibraryLoaded
        var nativeLibraryLoadError = ""

        if (q346FeatureEnabled) {
            nativeLibraryLoadAttempted = true
            try {
                if (!q346NativeLibraryLoaded) {
                    val systemClass = Class.forName("java.lang.System")
                    val loadLibrary = systemClass.getDeclaredMethod("loadLibrary", String::class.java)
                    loadLibrary.invoke(null, q346PaddleLiteNativeLibraryName)
                    q346NativeLibraryLoaded = true
                }
                nativeLibraryLoadSucceeded = true
            } catch (error: Throwable) {
                nativeLibraryLoadSucceeded = false
                nativeLibraryLoadError = error.javaClass.name + ": " + (error.message ?: "no-message")
            }
        }

        return mapOf(
            "phase" to q346Phase,
            "sourcePhase" to "V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL",
            "method" to method,
            "nativeChannelName" to ocrRuntimeBridgeChannelName,
            "status" to q346Status,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q346FeatureEnabled,
            "uiProtectionStatus" to q346UiProtectionStatus,
            "paddleLiteNativeLibraryName" to q346PaddleLiteNativeLibraryName,
            "requiredBundledJar" to "android/app/libs/PaddlePredictor.jar",
            "requiredPrimaryNativeLibrary" to "android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so",
            "requiredLegacyNativeLibrary" to "android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so",
            "primaryAbi" to q346PrimaryAbi,
            "legacyAbi" to q346LegacyAbi,
            "nativeLibraryLoadSmokeBridgeAdded" to true,
            "nativeLibraryLoadAttempted" to nativeLibraryLoadAttempted,
            "nativeLibraryLoadSucceeded" to nativeLibraryLoadSucceeded,
            "nativeLibraryAlreadyLoaded" to q346NativeLibraryLoaded,
            "nativeLibraryLoadError" to nativeLibraryLoadError,
            "automaticStartupLoad" to false,
            "assistantExecutedNativeLoadSmoke" to false,
            "paddleLiteInstantiated" to false,
            "modelLoaderAvailable" to false,
            "modelLoaded" to false,
            "runtimeStartupExecuted" to false,
            "dummyRuntimeCallExecuted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false
        )
    }

    private fun q347PaddleLitePredictorInstantiateSmoke(method: String): Map<String, Any> {
        var predictorClassProbeAttempted = false
        var predictorClassProbeSucceeded = false
        var configClassProbeSucceeded = false
        var predictorInstantiateAttempted = false
        var predictorInstantiateSucceeded = false
        var predictorInstantiateError = ""

        if (q347FeatureEnabled) {
            try {
                predictorClassProbeAttempted = true
                val predictorClass = Class.forName(q347PredictorClassName)
                predictorClassProbeSucceeded = true
                val configClass = Class.forName(q347ConfigClassName)
                val configBaseClass = Class.forName(q347ConfigBaseClassName)
                configClassProbeSucceeded = true
                val config = configClass.getDeclaredConstructor().newInstance()
                val createPredictor = predictorClass.getDeclaredMethod(q347CreatePredictorMethodName, configBaseClass)
                predictorInstantiateAttempted = true
                val predictor = createPredictor.invoke(null, config)
                predictorInstantiateSucceeded = predictor != null
            } catch (error: Throwable) {
                predictorInstantiateSucceeded = false
                predictorInstantiateError = error.javaClass.name + ": " + (error.message ?: "no-message")
            }
        }

        return mapOf(
            "phase" to q347Phase,
            "sourcePhase" to q346Phase,
            "method" to method,
            "nativeChannelName" to ocrRuntimeBridgeChannelName,
            "status" to q347Status,
            "engine" to "PP-FormulaNet_plus",
            "featureFlagDefaultEnabled" to q347FeatureEnabled,
            "uiProtectionStatus" to q347UiProtectionStatus,
            "q346NativeLibraryLoadSmokeRequired" to true,
            "q346NativeLibraryAlreadyLoaded" to q346NativeLibraryLoaded,
            "paddleLitePredictorClassName" to q347PredictorClassName,
            "paddleLiteConfigClassName" to q347ConfigClassName,
            "paddleLiteCreatePredictorMethodName" to q347CreatePredictorMethodName,
            "predictorInstantiateSmokeBridgeAdded" to true,
            "predictorClassProbeAttempted" to predictorClassProbeAttempted,
            "predictorClassProbeSucceeded" to predictorClassProbeSucceeded,
            "configClassProbeSucceeded" to configClassProbeSucceeded,
            "predictorInstantiateAttempted" to predictorInstantiateAttempted,
            "predictorInstantiateSucceeded" to predictorInstantiateSucceeded,
            "predictorInstantiateError" to predictorInstantiateError,
            "automaticStartupInstantiate" to false,
            "assistantExecutedPredictorInstantiateSmoke" to false,
            "modelLoaderAvailable" to false,
            "modelLoaded" to false,
            "runtimeStartupExecuted" to false,
            "dummyRuntimeCallExecuted" to false,
            "realImageToLatexInferenceExecuted" to false,
            "editableMathLiveReviewOpened" to false,
            "workspaceImportExecuted" to false,
            "ocrPassClaimed" to false,
            "androidRealDevicePassClaimed" to false
        )
    }

}
