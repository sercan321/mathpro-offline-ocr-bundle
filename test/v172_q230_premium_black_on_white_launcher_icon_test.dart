import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/branding/premium_black_on_white_launcher_icon_policy.dart';

void main() {
  test('V172-Q230 uses the user-provided reference and stays launcher-icon-only', () {
    expect(PremiumBlackOnWhiteLauncherIconPolicy.phase, 'V172-Q230');
    expect(PremiumBlackOnWhiteLauncherIconPolicy.userProvidedReferenceUsed, isTrue);
    expect(PremiumBlackOnWhiteLauncherIconPolicy.newImageGenerationUsed, isFalse);
    expect(PremiumBlackOnWhiteLauncherIconPolicy.premiumBlackOnWhiteLauncherIconApplied, isTrue);
    expect(PremiumBlackOnWhiteLauncherIconPolicy.goldAccentRetired, isTrue);
    expect(PremiumBlackOnWhiteLauncherIconPolicy.neonAccentRetired, isTrue);
    expect(PremiumBlackOnWhiteLauncherIconPolicy.textGridFormulaRetired, isTrue);
    expect(PremiumBlackOnWhiteLauncherIconPolicy.keyboardMutationAllowed, isFalse);
    expect(PremiumBlackOnWhiteLauncherIconPolicy.longPressMutationAllowed, isFalse);
    expect(PremiumBlackOnWhiteLauncherIconPolicy.moreMutationAllowed, isFalse);
    expect(PremiumBlackOnWhiteLauncherIconPolicy.mathLiveMutationAllowed, isFalse);
    expect(PremiumBlackOnWhiteLauncherIconPolicy.graphMutationAllowed, isFalse);
    expect(PremiumBlackOnWhiteLauncherIconPolicy.solutionMutationAllowed, isFalse);
    expect(PremiumBlackOnWhiteLauncherIconPolicy.workspaceMutationAllowed, isFalse);
    expect(PremiumBlackOnWhiteLauncherIconPolicy.splashMutationAllowed, isFalse);
  });

  test('V172-Q230 Android launcher and adaptive icon assets exist', () {
    for (final path in <String>[
      'assets/branding/gauss_app_icon_1024.png',
      'android/app/src/main/res/drawable-nodpi/ic_launcher_foreground.png',
      'android/app/src/main/res/drawable/ic_launcher_background.xml',
      'android/app/src/main/res/mipmap-mdpi/ic_launcher.png',
      'android/app/src/main/res/mipmap-hdpi/ic_launcher.png',
      'android/app/src/main/res/mipmap-xhdpi/ic_launcher.png',
      'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png',
      'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png',
      'android/app/src/main/res/mipmap-mdpi/ic_launcher_round.png',
      'android/app/src/main/res/mipmap-hdpi/ic_launcher_round.png',
      'android/app/src/main/res/mipmap-xhdpi/ic_launcher_round.png',
      'android/app/src/main/res/mipmap-xxhdpi/ic_launcher_round.png',
      'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher_round.png',
    ]) {
      expect(File(path).existsSync(), isTrue, reason: 'missing asset: $path');
    }
  });
}
