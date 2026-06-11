import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/real_device_pixel_qa_court_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q45 real-device pixel QA court', () {
    test('Q45 court lineage remains protected after later Q48 repairs without fake +95 device PASS', () {
      expect(MathProPackageContract.cursorLineageVersions, contains(MathProPackageContract.version));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q45 Real Device Pixel QA Court'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q46 Renderer Slot Identity Prototype'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q48 Native LayoutBox Cursor Layer'));
      expect(MathProPackageContract.auditTitle, contains('Closure'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
    });

    test('court locks 20-attempt 19-correct physical-device acceptance', () {
      expect(RealDevicePixelQACourtPolicy.realDevicePixelQACourtAvailable, isTrue);
      expect(RealDevicePixelQACourtPolicy.finalPlus95CursorPassClaimed, isFalse);
      expect(RealDevicePixelQACourtPolicy.photomathWolframLevelClaimed, isFalse);
      expect(RealDevicePixelQACourtPolicy.attemptsPerScenario, 20);
      expect(RealDevicePixelQACourtPolicy.requiredCorrectPerScenario, 19);
      expect(RealDevicePixelQACourtPolicy.requiredOverallSuccessRate, 0.95);
      expect(RealDevicePixelQACourtPolicy.targetDeviceId, '23106RN0DA');
    });

    test('court covers the core +95 cursor families without touching P6 UI', () {
      expect(RealDevicePixelQACourtPolicy.p6VisualBaselineLocked, isTrue);
      expect(RealDevicePixelQACourtPolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(RealDevicePixelQACourtPolicy.moreSurfaceMutationAllowed, isFalse);
      expect(RealDevicePixelQACourtPolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(RealDevicePixelQACourtPolicy.graphHistorySolutionMutationAllowed, isFalse);
      expect(RealDevicePixelQACourtPolicy.hasRequiredCaseCoverage(), isTrue);
      expect(RealDevicePixelQACourtPolicy.referencesExistingPixelMatrix(), isTrue);
      expect(RealDevicePixelQACourtPolicy.courtCases.length, greaterThanOrEqualTo(10));
    });

    test('case pass evaluation rejects incomplete evidence', () {
      expect(RealDevicePixelQACourtPolicy.casePass(18), isFalse);
      expect(RealDevicePixelQACourtPolicy.casePass(19), isTrue);
      expect(RealDevicePixelQACourtPolicy.casePass(20), isTrue);
      expect(RealDevicePixelQACourtPolicy.casePass(19, attempts: 19), isFalse);
    });
  });
}
