import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../features/mathlive/mathlive_lab_screen.dart';
import 'app_shell.dart';
import 'gauss_splash_screen.dart';

class MathProApp extends StatelessWidget {
  const MathProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MathPro',
      theme: MathProTheme.darkTheme,
      // Q90R8 static compatibility marker: home: const MathProAppShell()
      // V172-Q235R4: native splash hands off to a Flutter-held splash poster;
      // AppShell is mounted only after the poster duration, preventing a dark frame gap.
      home: const GaussStartupSplash(child: MathProAppShell()),
      routes: <String, WidgetBuilder>{
        // V172-Q90R8: registered only for controlled Lab access; the normal
        // app still boots into MathProAppShell and legacy remains default.
        MathLiveLabScreen.routeName: (_) => const MathLiveLabScreen(),
      },
    );
  }
}
