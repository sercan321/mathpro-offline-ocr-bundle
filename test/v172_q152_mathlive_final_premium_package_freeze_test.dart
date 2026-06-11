import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_final_premium_package_freeze_policy.dart';

void main() {
  group('V172-Q152 MathLive final premium package freeze', () {
    test('policy freezes package without fake Flutter/device/Photomath claims', () {
      expect(MathLiveFinalPremiumPackageFreezePolicy.phase, 'V172-Q152');
      expect(MathLiveFinalPremiumPackageFreezePolicy.patchOnlyDeliveryAllowed, isFalse);
      expect(MathLiveFinalPremiumPackageFreezePolicy.staleStandardZipAllowed, isFalse);
      expect(MathLiveFinalPremiumPackageFreezePolicy.protectedKeyboardLayoutMutationAllowed, isFalse);
      expect(MathLiveFinalPremiumPackageFreezePolicy.protectedLongPressOrderMutationAllowed, isFalse);
      expect(MathLiveFinalPremiumPackageFreezePolicy.graphHistorySolutionUiMutationAllowed, isFalse);
      expect(MathLiveFinalPremiumPackageFreezePolicy.fakeRuntimeEvidenceAllowed, isFalse);
      expect(MathLiveFinalPremiumPackageFreezePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(MathLiveFinalPremiumPackageFreezePolicy.flutterTestPassClaimedByAssistant, isFalse);
      expect(MathLiveFinalPremiumPackageFreezePolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(MathLiveFinalPremiumPackageFreezePolicy.cursorPassClaimed, isFalse);
      expect(MathLiveFinalPremiumPackageFreezePolicy.realDevicePassClaimed, isFalse);
      expect(MathLiveFinalPremiumPackageFreezePolicy.photomathLevelClaimed, isFalse);
    });

    test('manifest preserves Q152 package freeze record while allowing successor phases', () {
      final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
      expect(manifest['activePhase'], isA<String>());
      expect(manifest['currentPhase'], isA<String>());
      expect(manifest['activePhase'], startsWith('V172-Q'));
      expect(manifest['currentPhase'], startsWith('V172-Q'));
      expect(manifest['v172Q152FinalPremiumPackageFreeze'], isA<Map<String, dynamic>>());
      final q152 = manifest['v172Q152FinalPremiumPackageFreeze'] as Map<String, dynamic>;
      expect(q152['phase'], 'V172-Q152');
      expect(q152['patchOnlyDeliveryAllowed'], isFalse);
      expect(q152['realDevicePassClaimed'], isFalse);
      expect(q152['photomathLevelClaimed'], isFalse);
      expect(q152['requiresUserSideFinalCourt'], isTrue);
    });

    test('required verifier chain is present for final user-side court', () {
      for (final command in MathLiveFinalPremiumPackageFreezePolicy.userSideFinalCourtCommands) {
        if (!command.startsWith('node tool/')) continue;
        final script = command.split(' ')[1];
        expect(File(script).existsSync(), isTrue, reason: 'missing $script');
      }
    });

    test('protected UI surfaces remain locked by Q152', () {
      for (final rel in MathLiveFinalPremiumPackageFreezePolicy.protectedSurfaces) {
        final content = File(rel).readAsStringSync();
        expect(content, isNot(contains('V172-Q152')), reason: '$rel must not be mutated by Q152');
      }
    });
  });
}
