import 'package:flutter/material.dart';

import 'features/mathlive/mathlive_lab_screen.dart';
import 'theme/app_theme.dart';

/// V172-Q90R8 — direct real-device Lab entrypoint.
///
/// This is intentionally separate from the normal MathPro entrypoint. It lets
/// the isolated MathLive Lab be run directly with:
///
///   flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA
///
/// It does not switch the main editor, does not mount MathLive in the main
/// workspace, and does not delete or bypass the legacy cursor engine.
void main() {
  runApp(const MathLiveLabOnlyApp());
}

class MathLiveLabOnlyApp extends StatelessWidget {
  const MathLiveLabOnlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MathLive Lab',
      theme: MathProTheme.darkTheme,
      home: const MathLiveLabScreen(),
    );
  }
}
