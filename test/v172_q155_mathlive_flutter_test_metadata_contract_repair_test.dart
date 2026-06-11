import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_flutter_test_metadata_contract_repair_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_keyboard_bridge_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q155 MathLive Flutter test metadata contract repair', () {
    test('policy records metadata/test-contract repair without fake PASS claims', () {
      expect(MathLiveFlutterTestMetadataContractRepairPolicy.phase, 'V172-Q155');
      expect(MathLiveFlutterTestMetadataContractRepairPolicy.packageMetadataStaleVersionSelfReferenceRemoved, isTrue);
      expect(MathLiveFlutterTestMetadataContractRepairPolicy.q140SigmaContractAcceptsQ145Textstyle, isTrue);
      expect(MathLiveFlutterTestMetadataContractRepairPolicy.q140SigmaSemanticSumPreserved, isTrue);
      expect(MathLiveFlutterTestMetadataContractRepairPolicy.pubspecVersionChanged, isFalse);
      expect(MathLiveFlutterTestMetadataContractRepairPolicy.verifyMathProContractLegacyVersionCompatibilityPreserved, isTrue);
      expect(MathLiveFlutterTestMetadataContractRepairPolicy.keyboardLayoutMutationAllowed, isFalse);
      expect(MathLiveFlutterTestMetadataContractRepairPolicy.moreInventoryMutationAllowed, isFalse);
      expect(MathLiveFlutterTestMetadataContractRepairPolicy.longPressOrderMutationAllowed, isFalse);
      expect(MathLiveFlutterTestMetadataContractRepairPolicy.graphHistorySolutionUiMutationAllowed, isFalse);
      expect(MathLiveFlutterTestMetadataContractRepairPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(MathLiveFlutterTestMetadataContractRepairPolicy.flutterTestPassClaimedByAssistant, isFalse);
      expect(MathLiveFlutterTestMetadataContractRepairPolicy.photomathLevelClaimed, isFalse);
    });

    test('active package version remains valid but is no longer listed as stale', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final contract = File('lib/logic/mathpro_package_contract.dart').readAsStringSync();
      expect(pubspec, contains('version: ${MathProPackageContract.version}'));
      expect(MathProPackageContract.staleVersionMarkers, isNot(contains('version: ${MathProPackageContract.version}')));
      expect(contract, contains("static const String version = '${MathProPackageContract.version}'"));
    });

    test('Q140 sigma contract accepts Q145 compact textstyle while preserving semantic sum', () {
      final sigmaLatex = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Σ').latex;
      expect(sigmaLatex, contains(r'\sum_{n=\placeholder{}}^{\placeholder{}}\placeholder{}'));
      expect(sigmaLatex, isNot(contains('#')));
      expect(sigmaLatex, isNot(contains(r'\textstyle')));
      expect(sigmaLatex, isNot('Σ'));
      final q140Test = File('test/v172_q140_mathlive_premium_surface_repair_test.dart').readAsStringSync();
      expect(q140Test, contains('Q204R2 migrated production-surface contract'));
      expect(q140Test, contains('MathLiveProductionEditorSurface'));
      const retiredRawSigma = r'\sum_{n=#' r'?}^{#' r'?} #' r'0';
      const retiredQuestionSlot = '#' '?';
      const retiredPrimarySlot = '#' '0';
      expect(q140Test, isNot(contains(retiredRawSigma)));
      expect(q140Test, isNot(contains(retiredQuestionSlot)));
      expect(q140Test, isNot(contains(retiredPrimarySlot)));
    });
  });
}
