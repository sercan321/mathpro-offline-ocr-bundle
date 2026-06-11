import 'package:flutter/services.dart';

import 'gauss_controlled_ocr_activation_flutter_evidence_harness_q372_policy.dart';

class GaussControlledOcrActivationFlutterEvidenceHarnessQ372Request {
  const GaussControlledOcrActivationFlutterEvidenceHarnessQ372Request({
    this.modelSourcePath,
    this.imagePath,
    this.candidateLatex,
    this.approvedLatex,
    this.candidateConfidence,
    this.executePrivateStorageActivation = false,
    this.executeModelLoadSmoke = false,
    this.executeDummyRuntimeCall = false,
    this.executeImageToLatex = false,
    this.prepareReviewHandoff = true,
    this.prepareApprovedImport = true,
    this.reviewCompleted = false,
    this.userApproved = false,
  });

  final String? modelSourcePath;
  final String? imagePath;
  final String? candidateLatex;
  final String? approvedLatex;
  final double? candidateConfidence;
  final bool executePrivateStorageActivation;
  final bool executeModelLoadSmoke;
  final bool executeDummyRuntimeCall;
  final bool executeImageToLatex;
  final bool prepareReviewHandoff;
  final bool prepareApprovedImport;
  final bool reviewCompleted;
  final bool userApproved;

  Map<String, Object?> toArguments() {
    return <String, Object?>{
      'modelSourcePath': modelSourcePath,
      'sourcePath': modelSourcePath,
      'imagePath': imagePath,
      'sourceImagePath': imagePath,
      'candidateLatex': candidateLatex,
      'approvedLatex': approvedLatex,
      'candidateConfidence': candidateConfidence,
      'executePrivateStorageActivation': executePrivateStorageActivation,
      'executeModelLoadSmoke': executeModelLoadSmoke,
      'executeDummyRuntimeCall': executeDummyRuntimeCall,
      'executeImageToLatex': executeImageToLatex,
      'prepareReviewHandoff': prepareReviewHandoff,
      'prepareApprovedImport': prepareApprovedImport,
      'reviewCompleted': reviewCompleted,
      'userApproved': userApproved,
      'explicitUserApproval': userApproved,
      'q372HarnessVersion': GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.harnessVersion,
    };
  }
}

class GaussControlledOcrActivationFlutterEvidenceHarnessQ372Result {
  const GaussControlledOcrActivationFlutterEvidenceHarnessQ372Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.bridgeChannel,
    required this.nativeBridgeMethod,
    required this.harnessVersion,
    required this.flutterHarnessPrepared,
    required this.explicitUserInvocationRequired,
    required this.requiresQ371NativeEvidenceCapture,
    required this.directOcrToWorkspaceImportBlocked,
    required this.directOcrToSolveGraphSolutionHistoryBlocked,
    required this.startupAutoExecutionBlocked,
    required this.cameraAutoExecutionBlocked,
    required this.workspaceAutoExecutionBlocked,
    required this.workspaceImportExecuted,
    required this.approvedWorkspaceImportExecuted,
    required this.solveGraphSolutionHistoryTouched,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String bridgeChannel;
  final String nativeBridgeMethod;
  final String harnessVersion;
  final bool flutterHarnessPrepared;
  final bool explicitUserInvocationRequired;
  final bool requiresQ371NativeEvidenceCapture;
  final bool directOcrToWorkspaceImportBlocked;
  final bool directOcrToSolveGraphSolutionHistoryBlocked;
  final bool startupAutoExecutionBlocked;
  final bool cameraAutoExecutionBlocked;
  final bool workspaceAutoExecutionBlocked;
  final bool workspaceImportExecuted;
  final bool approvedWorkspaceImportExecuted;
  final bool solveGraphSolutionHistoryTouched;
  final bool ocrPassClaimed;
}

class GaussControlledOcrActivationFlutterEvidenceHarnessQ372 {
  const GaussControlledOcrActivationFlutterEvidenceHarnessQ372._();

  static const MethodChannel channel = MethodChannel(
    GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.bridgeChannel,
  );

  static GaussControlledOcrActivationFlutterEvidenceHarnessQ372Result evaluate() {
    return const GaussControlledOcrActivationFlutterEvidenceHarnessQ372Result(
      phase: GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.phase,
      sourcePhase: GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.sourcePhase,
      status: GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.status,
      bridgeChannel: GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.bridgeChannel,
      nativeBridgeMethod: GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.nativeBridgeMethod,
      harnessVersion: GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.harnessVersion,
      flutterHarnessPrepared: true,
      explicitUserInvocationRequired: true,
      requiresQ371NativeEvidenceCapture: true,
      directOcrToWorkspaceImportBlocked: true,
      directOcrToSolveGraphSolutionHistoryBlocked: true,
      startupAutoExecutionBlocked: true,
      cameraAutoExecutionBlocked: true,
      workspaceAutoExecutionBlocked: true,
      workspaceImportExecuted: false,
      approvedWorkspaceImportExecuted: false,
      solveGraphSolutionHistoryTouched: false,
      ocrPassClaimed: false,
    );
  }

  static Map<String, Object?> buildArguments(
    GaussControlledOcrActivationFlutterEvidenceHarnessQ372Request request,
  ) {
    return request.toArguments();
  }

  static Future<Map<String, Object?>> captureEvidence(
    GaussControlledOcrActivationFlutterEvidenceHarnessQ372Request request,
  ) async {
    final response = await channel.invokeMapMethod<String, Object?>(
      GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.nativeBridgeMethod,
      request.toArguments(),
    );
    return response ?? <String, Object?>{
      'phase': GaussControlledOcrActivationFlutterEvidenceHarnessQ372Policy.phase,
      'status': 'NO_NATIVE_RESPONSE',
      'flutterHarnessPrepared': true,
      'explicitUserInvocationRequired': true,
      'workspaceImportExecuted': false,
      'solveGraphSolutionHistoryTouched': false,
      'ocrPassClaimed': false,
    };
  }
}
