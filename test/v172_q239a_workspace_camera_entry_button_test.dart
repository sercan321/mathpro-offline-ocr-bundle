import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_workspace_camera_entry_policy.dart';

void main() {
  group('V172-Q239A workspace camera entry button replacement', () {
    test('policy records surgical camera entry scope without fake PASS claims', () {
      expect(GaussWorkspaceCameraEntryButtonPolicy.phase, 'V172-Q239A');
      expect(GaussWorkspaceCameraEntryButtonPolicy.replacesWorkspaceEllipsisAction, isTrue);
      expect(GaussWorkspaceCameraEntryButtonPolicy.workspaceTopActionSlotPreserved, isTrue);
      expect(GaussWorkspaceCameraEntryButtonPolicy.premiumVisualShellPreserved, isTrue);
      expect(GaussWorkspaceCameraEntryButtonPolicy.tooltipProvided, isTrue);
      expect(GaussWorkspaceCameraEntryButtonPolicy.semanticLabelProvided, isTrue);
      expect(GaussWorkspaceCameraEntryButtonPolicy.safePlaceholderSheetOnly, isTrue);
      expect(GaussWorkspaceCameraEntryButtonPolicy.cameraPackageAdded, isFalse);
      expect(GaussWorkspaceCameraEntryButtonPolicy.androidCameraPermissionAdded, isFalse);
      expect(GaussWorkspaceCameraEntryButtonPolicy.cameraPreviewImplemented, isFalse);
      expect(GaussWorkspaceCameraEntryButtonPolicy.ocrEngineAdded, isFalse);
      expect(GaussWorkspaceCameraEntryButtonPolicy.mathLiveImportImplemented, isFalse);
      expect(GaussWorkspaceCameraEntryButtonPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussWorkspaceCameraEntryButtonPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussWorkspaceCameraEntryButtonPolicy.mathLiveProductionMutationAllowed, isFalse);
      expect(GaussWorkspaceCameraEntryButtonPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussWorkspaceCameraEntryButtonPolicy.androidRealDeviceCameraPassClaimedByAssistant, isFalse);
    });

    test('workspace top action row exposes camera entry and removes inert ellipsis', () {
      final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

      expect(workspace, contains("ValueKey('mathpro-workspace-camera-entry-button')"));
      expect(workspace, contains('Icons.photo_camera_outlined'));
      expect(workspace, contains("tooltip: 'Kamera'"));
      expect(workspace, contains("semanticLabel: 'Kamera ile ifade tara'"));
      // Q382R24R1: Q239A's old exact helper-call expectation became stale
      // after the camera shell was wired to the approved OCR import callback.
      // Keep the camera entry contract, but require the current callback-safe
      // route instead of reverting production code to `_openCameraCaptureShell(context)`.
      expect(workspace, contains('_openCameraCaptureShell('));
      expect(workspace, contains('onApprovedLatexImport: onApprovedOcrWorkspaceImport'));
      expect(workspace, contains('GaussCameraCaptureShell'));

      expect(workspace, isNot(contains("ValueKey('mathpro-more-placeholder-button')")));
      expect(
        !workspace.contains('Icons.more_horiz_rounded') ||
            workspace.contains("ValueKey('mathpro-q382-expression-context-menu-safe-hit-zone')"),
        isTrue,
      );
      // Q239A itself did not add the camera package. Q239B is the intentional
      // successor phase that turns the same entry into a capture shell.
      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*(0\.11\.0|0\.10\.6)\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains(RegExp(r'^\s*google_mlkit_text_recognition\s*:', multiLine: true))));
      // Q239B is allowed to add the Android camera permission; OCR/media
      // storage permissions remain forbidden.
      expect(manifest, contains('android.permission.CAMERA'));
      expect(manifest, isNot(contains('READ_MEDIA_IMAGES')));
      expect(manifest, isNot(contains('READ_EXTERNAL_STORAGE')));
    });
  });
}
