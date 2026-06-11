import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_onnx_output_decoder_candidate_extraction_binding_q379.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_real_onnx_output_decoder_candidate_extraction_binding_q379_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q379 records real ONNX output decoder candidate extraction binding without OCR pass claim', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q379 = manifest['v172Q379RealOnnxOutputDecoderCandidateExtractionBinding'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['realOnnxOutputDecoderCandidateExtractionBindingLatestPhase'], GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Policy.phase);
    expect(q379['phase'], GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Policy.phase);
    expect(q379['genericStringOutputDecoderImplemented'], isTrue);
    expect(q379['asciiCodepointDecoderImplemented'], isTrue);
    expect(q379['privateVocabularyTokenDecoderImplemented'], isTrue);
    expect(q379['outputDecoderDoesNotInventLatex'], isTrue);
    expect(q379['editableMathLiveReviewRequiredBeforeImport'], isTrue);
    expect(q379['explicitUserApprovalRequiredBeforeImport'], isTrue);
    expect(q379['directOcrToWorkspaceImportBlockedBeforeReview'], isTrue);
    expect(q379['solveGraphSolutionHistoryAutoTriggerBlocked'], isTrue);
    expect(q379['ocrPassClaimedByPackage'], isFalse);
  });

  test('q379 Dart policy exposes safe decoder families and review-first invariants', () {
    final result = GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379.evaluate();
    expect(result.phase, GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Policy.phase);
    expect(result.acceptsReadableStringOutput, isTrue);
    expect(result.acceptsAsciiCodepointOutput, isTrue);
    expect(result.acceptsTokenIdVocabularyOutput, isTrue);
    expect(result.outputDecoderDoesNotInventLatex, isTrue);
    expect(result.reviewRequiredBeforeImport, isTrue);
    expect(result.explicitApprovalRequiredBeforeImport, isTrue);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q379 source code binds Q367 output to non-empty candidate fields when readable', () {
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    expect(mainActivity, contains('q379ExtractLatexCandidateFromOrtResult'));
    expect(mainActivity, contains('q379DecodeAsciiLikeIntegers'));
    expect(mainActivity, contains('q379DecodeTokenIdsWithVocabulary'));
    expect(mainActivity, contains('realOnnxOutputDecoderCandidateExtractionBinding'));
    expect(mainActivity, contains('"candidateLatex" to decodedCandidateLatex'));
    expect(mainActivity, contains('"outputDecodingImplemented" to outputDecoderImplemented'));
    expect(mainActivity, isNot(contains('"candidateLatex" to "",\n            "candidateConfidence" to 0.0,\n            "candidateAlternatives" to emptyList<String>(),\n            "outputDecodingImplemented" to false')));
  });
}
