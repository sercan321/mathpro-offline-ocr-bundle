import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_android_toolchain_modernization.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_android_toolchain_modernization_policy.dart';

void main() {
  group('V172-Q253 Android Toolchain Modernization', () {
    test('records AGP 8.6.1 / Kotlin 2.1.0 / Gradle 8.7 / Java 17 modernization scope', () {
      expect(GaussAndroidToolchainModernizationPolicy.phase, 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION');
      expect(GaussAndroidToolchainModernizationPolicy.sourcePhase, 'V172-Q252-CAMERA-OCR-PREMIUM-FINAL-REGRESSION');
      expect(GaussAndroidToolchainModernizationPolicy.previousAgpVersion, '8.3.2');
      expect(GaussAndroidToolchainModernizationPolicy.targetAgpVersion, '8.6.1');
      expect(GaussAndroidToolchainModernizationPolicy.kotlinGradlePluginVersion, '2.1.0');
      expect(GaussAndroidToolchainModernizationPolicy.gradleWrapperVersion, '8.7');
      expect(GaussAndroidToolchainModernizationPolicy.javaSourceCompatibility, '17');
      expect(GaussAndroidToolchainModernizationPolicy.javaTargetCompatibility, '17');
      expect(GaussAndroidToolchainModernizationPolicy.kotlinJvmTarget, '17');
      expect(GaussAndroidToolchainModernizationPolicy.androidOfficialKotlin21MinimumAgp, '8.6');
      expect(GaussAndroidToolchainModernizationPolicy.androidOfficialAgp86MinimumGradle, '8.7');
      expect(GaussAndroidToolchainModernizationPolicy.androidOfficialAgp86Jdk, '17');
      expect(GaussAndroidToolchainModernizationPolicy.agpUpgradePerformed, isTrue);
      expect(GaussAndroidToolchainModernizationPolicy.kotlinPluginPreserved, isTrue);
      expect(GaussAndroidToolchainModernizationPolicy.gradleWrapperPreservedAtRequiredVersion, isTrue);
      expect(GaussAndroidToolchainModernizationPolicy.java17CompileOptionsPreserved, isTrue);
    });

    test('keeps camera/OCR as review-only and blocks real runtime additions', () {
      expect(GaussAndroidToolchainModernizationPolicy.cameraOcrFoundationPreserved, isTrue);
      expect(GaussAndroidToolchainModernizationPolicy.ppFormulaNetSUserSelectionPreserved, isTrue);
      expect(GaussAndroidToolchainModernizationPolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussAndroidToolchainModernizationPolicy.paddleRuntimeAdded, isFalse);
      expect(GaussAndroidToolchainModernizationPolicy.paddleOcrDependencyAdded, isFalse);
      expect(GaussAndroidToolchainModernizationPolicy.ppFormulaNetSModelBinaryBundledInBaseApp, isFalse);
      expect(GaussAndroidToolchainModernizationPolicy.productionModelUrlBound, isFalse);
      expect(GaussAndroidToolchainModernizationPolicy.productionInferenceAllowed, isFalse);
      expect(GaussAndroidToolchainModernizationPolicy.editableMathLiveReviewRequired, isTrue);
      expect(GaussAndroidToolchainModernizationPolicy.userApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(GaussAndroidToolchainModernizationPolicy.directWorkspaceImportAllowed, isFalse);
      expect(GaussAndroidToolchainModernizationPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussAndroidToolchainModernizationPolicy.directGraphFromCameraAllowed, isFalse);
      expect(GaussAndroidToolchainModernizationPolicy.directSolutionFromCameraAllowed, isFalse);
      expect(GaussAndroidToolchainModernizationPolicy.directHistoryFromCameraAllowed, isFalse);
      expect(GaussAndroidToolchainModernizationPolicy.forbiddenQ253Actions, contains('runPpFormulaNetSInference'));
      expect(GaussAndroidToolchainModernizationPolicy.forbiddenQ253Actions, contains('addPaddleRuntime'));
      expect(GaussAndroidToolchainModernizationPolicy.forbiddenQ253Actions, contains('bundlePpFormulaNetSModelInBaseApk'));
      expect(GaussAndroidToolchainModernizationPolicy.forbiddenQ253Actions, contains('solveFromCameraWithoutReview'));
    });

    test('passes only when Q252 foundation, Android targets, and protected surfaces are intact', () {
      final result = GaussAndroidToolchainModernization.evaluate(
        const GaussAndroidToolchainModernizationInput(
          q252PremiumFinalRegressionVerified: true,
          settingsGradleUsesTargetAgp: true,
          kotlinPluginPreservedAt21: true,
          gradleWrapperAt87: true,
          javaCompileOptionsAt17: true,
          kotlinJvmTargetAt17: true,
          cameraDependencyLinePreserved: true,
          cameraOcrRuntimeUnchanged: true,
          protectedSurfaceHashesUnchanged: true,
          noPaddleRuntimeDependency: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrl: true,
          mathLiveReviewAndUserApprovalRequired: true,
          noDirectCameraSolveGraphSolutionHistory: true,
          evidenceLabel: 'Q253 static Android toolchain modernization court',
        ),
      );

      expect(result.androidToolchainModernizationStaticReady, isTrue);
      expect(result.targetAgpVersion, '8.6.1');
      expect(result.kotlinGradlePluginVersion, '2.1.0');
      expect(result.gradleWrapperVersion, '8.7');
      expect(result.javaTargetCompatibility, '17');
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.canClaimFlutterPassWithoutLogs, isFalse);
      expect(result.canClaimAndroidRunPassWithoutDeviceLog, isFalse);
      expect(result.canClaimOcrPass, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
      expect(result.canSolveCameraOutputBeforeReviewApproval, isFalse);
    });

    test('blocks missing Q252 foundation, toolchain mismatch, and forbidden runtime additions', () {
      final missingFoundation = GaussAndroidToolchainModernization.evaluate(
        const GaussAndroidToolchainModernizationInput(
          q252PremiumFinalRegressionVerified: false,
          settingsGradleUsesTargetAgp: true,
          kotlinPluginPreservedAt21: true,
          gradleWrapperAt87: true,
          javaCompileOptionsAt17: true,
          kotlinJvmTargetAt17: true,
          cameraDependencyLinePreserved: true,
          cameraOcrRuntimeUnchanged: true,
          protectedSurfaceHashesUnchanged: true,
          noPaddleRuntimeDependency: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrl: true,
          mathLiveReviewAndUserApprovalRequired: true,
          noDirectCameraSolveGraphSolutionHistory: true,
          evidenceLabel: 'missing Q252 should block',
        ),
      );
      expect(missingFoundation.decision, GaussAndroidToolchainModernizationDecision.blockedMissingQ252Foundation);

      final agpMismatch = GaussAndroidToolchainModernization.evaluate(
        const GaussAndroidToolchainModernizationInput(
          q252PremiumFinalRegressionVerified: true,
          settingsGradleUsesTargetAgp: false,
          kotlinPluginPreservedAt21: true,
          gradleWrapperAt87: true,
          javaCompileOptionsAt17: true,
          kotlinJvmTargetAt17: true,
          cameraDependencyLinePreserved: true,
          cameraOcrRuntimeUnchanged: true,
          protectedSurfaceHashesUnchanged: true,
          noPaddleRuntimeDependency: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrl: true,
          mathLiveReviewAndUserApprovalRequired: true,
          noDirectCameraSolveGraphSolutionHistory: true,
          evidenceLabel: 'AGP mismatch should block',
        ),
      );
      expect(agpMismatch.decision, GaussAndroidToolchainModernizationDecision.blockedAgpTargetMismatch);

      final forbiddenRuntime = GaussAndroidToolchainModernization.evaluate(
        const GaussAndroidToolchainModernizationInput(
          q252PremiumFinalRegressionVerified: true,
          settingsGradleUsesTargetAgp: true,
          kotlinPluginPreservedAt21: true,
          gradleWrapperAt87: true,
          javaCompileOptionsAt17: true,
          kotlinJvmTargetAt17: true,
          cameraDependencyLinePreserved: true,
          cameraOcrRuntimeUnchanged: true,
          protectedSurfaceHashesUnchanged: true,
          noPaddleRuntimeDependency: false,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrl: true,
          mathLiveReviewAndUserApprovalRequired: true,
          noDirectCameraSolveGraphSolutionHistory: true,
          evidenceLabel: 'Paddle runtime must not be added in Q253',
        ),
      );
      expect(forbiddenRuntime.decision, GaussAndroidToolchainModernizationDecision.blockedForbiddenRuntimeBinding);
    });
  });
}
