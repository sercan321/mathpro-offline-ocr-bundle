import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// V172-Q212/Q218/Q235/Q235R2/Q235R4: branded GAUSS splash handoff.
///
/// This widget is splash-only. It does not alter launcher icon assets, keyboard,
/// Graph, History, Solution, MathLive, routing contracts, or business logic.
/// Q235 deliberately avoids Flutter first-frame deferral and Android icon-slot
/// bitmap tricks. The app shell is built immediately, while this normal Flutter
/// overlay paints the user-supplied GAUSS artwork with BoxFit.contain so it is
/// never cropped, stretched, or routed through Android's adaptive icon slot.
/// Q235R4 is the native-to-Flutter continuity repair: Android native splash
/// shows first, then this Flutter poster keeps the same artwork visible long
/// enough to avoid a dark frame gap. The child is mounted only after the
/// bounded poster timer completes, so platform views cannot cover the splash.
/// Q235R5 added a native Android overlay above FlutterView. Q235R6 removes
/// native hard time caps: the overlay is released only after AppShell has
/// drawn a Flutter frame and Dart sends the explicit release signal.
class GaussStartupSplash extends StatefulWidget {
  const GaussStartupSplash({
    required this.child,
    super.key,
  });

  static const String assetPath = 'assets/branding/gauss_splash_screen.png';
  static const Duration visibleDuration = Duration(milliseconds: 2400);
  static const Duration fadeOutDuration = Duration(milliseconds: 180);

  final Widget child;

  @override
  State<GaussStartupSplash> createState() => _GaussStartupSplashState();
}

class _GaussStartupSplashState extends State<GaussStartupSplash> {
  static const MethodChannel _nativeSplashChannel = MethodChannel('mathpro/native_splash');
  bool _visible = !_isRunningInWidgetTest();
  bool _fadeOut = false;
  bool _nativeReleaseScheduled = false;
  Timer? _handoffTimer;
  Timer? _removeTimer;

  @override
  void initState() {
    super.initState();
    if (_visible) {
      _startBoundedHandoff();
      _warmSplashImageForQualityOnly();
    }
  }

  void _startBoundedHandoff() {
    _handoffTimer = Timer(GaussStartupSplash.visibleDuration, () {
      if (!mounted) {
        return;
      }
      setState(() => _fadeOut = true);
      _removeTimer = Timer(GaussStartupSplash.fadeOutDuration, () {
        if (!mounted) {
          return;
        }
        setState(() => _visible = false);
      });
    });
  }

  void _warmSplashImageForQualityOnly() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      unawaited(
        precacheImage(const AssetImage(GaussStartupSplash.assetPath), context)
            .catchError((Object _) {}),
      );
    });
  }

  @override
  void dispose() {
    _handoffTimer?.cancel();
    _removeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      _scheduleNativeSplashReleaseAfterChildFrame();
      return widget.child;
    }

    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: _fadeOut ? 0 : 1,
        duration: GaussStartupSplash.fadeOutDuration,
        curve: Curves.easeOutCubic,
        child: const RepaintBoundary(
          child: _GaussSplashImage(),
        ),
      ),
    );
  }

  void _scheduleNativeSplashReleaseAfterChildFrame() {
    if (_nativeReleaseScheduled || _isRunningInWidgetTest()) return;
    _nativeReleaseScheduled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future<void>.delayed(const Duration(milliseconds: 350), () async {
        try {
          await _nativeSplashChannel.invokeMethod<void>('releaseNativeSplash');
        } catch (_) {
          // Native splash release is best-effort. Android has its own max guard.
        }
      });
    });
  }
}

class _GaussSplashImage extends StatelessWidget {
  const _GaussSplashImage();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF02050A),
      child: Image.asset(
        GaussStartupSplash.assetPath,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        filterQuality: FilterQuality.high,
        gaplessPlayback: true,
        isAntiAlias: true,
        errorBuilder: (_, __, ___) => const _SplashDecodeFallback(),
      ),
    );
  }
}

bool _isRunningInWidgetTest() {
  var result = false;
  assert(() {
    final bindingName = WidgetsBinding.instance.runtimeType.toString();
    result = bindingName.contains('TestWidgetsFlutterBinding');
    return true;
  }());
  return result;
}

class _SplashDecodeFallback extends StatelessWidget {
  const _SplashDecodeFallback();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFF02050A),
      child: Center(
        child: Text(
          'GAUSS',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFE8EEF2),
            fontSize: 32,
            fontWeight: FontWeight.w600,
            letterSpacing: 9,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
