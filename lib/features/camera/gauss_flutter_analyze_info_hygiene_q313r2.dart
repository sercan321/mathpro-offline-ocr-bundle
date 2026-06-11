import 'gauss_flutter_analyze_info_hygiene_q313r2_policy.dart';

class GaussFlutterAnalyzeInfoHygieneQ313R2Result {
  const GaussFlutterAnalyzeInfoHygieneQ313R2Result({
    required this.phase,
    required this.sourcePhase,
    required this.preferConstConstructorsApplied,
    required this.q291TestConstDeclarationApplied,
    required this.parserErrorReintroduced,
    required this.runtimeBehaviorChanged,
    required this.cameraOcrRuntimeAdded,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final bool preferConstConstructorsApplied;
  final bool q291TestConstDeclarationApplied;
  final bool parserErrorReintroduced;
  final bool runtimeBehaviorChanged;
  final bool cameraOcrRuntimeAdded;
  final bool ocrPassClaimed;
}

class GaussFlutterAnalyzeInfoHygieneQ313R2 {
  const GaussFlutterAnalyzeInfoHygieneQ313R2._();

  static GaussFlutterAnalyzeInfoHygieneQ313R2Result evaluate() {
    return const GaussFlutterAnalyzeInfoHygieneQ313R2Result(
      phase: GaussFlutterAnalyzeInfoHygieneQ313R2Policy.phase,
      sourcePhase: GaussFlutterAnalyzeInfoHygieneQ313R2Policy.sourcePhase,
      preferConstConstructorsApplied: GaussFlutterAnalyzeInfoHygieneQ313R2Policy.preferConstConstructorsApplied,
      q291TestConstDeclarationApplied: GaussFlutterAnalyzeInfoHygieneQ313R2Policy.q291TestConstDeclarationApplied,
      parserErrorReintroduced: GaussFlutterAnalyzeInfoHygieneQ313R2Policy.parserErrorReintroduced,
      runtimeBehaviorChanged: GaussFlutterAnalyzeInfoHygieneQ313R2Policy.runtimeBehaviorChanged,
      cameraOcrRuntimeAdded: GaussFlutterAnalyzeInfoHygieneQ313R2Policy.cameraOcrRuntimeAdded,
      ocrPassClaimed: GaussFlutterAnalyzeInfoHygieneQ313R2Policy.ocrPassClaimed,
    );
  }
}
