import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../features/keyboard/keyboard_latency_closure_q382r24_policy.dart';
import 'mathpro_all_key_latency_court_q382r25_policy.dart';
import 'mathpro_latency_probe_q382r23.dart';

class MathProLatencyOverlayQ382R23 extends StatelessWidget {
  const MathProLatencyOverlayQ382R23({super.key});

  @override
  Widget build(BuildContext context) {
    const latencyProbeDisabled = !KeyboardLatencyClosureQ382R24Policy.latencyProbeEnabledByDefault &&
        !MathProAllKeyLatencyCourtQ382R25Policy.enabledByDartDefine;
    if (!kDebugMode || latencyProbeDisabled || MathProRealDeviceLatencyInstrumentationQ382R23Policy.releaseOverlayAllowed) {
      return const SizedBox.shrink();
    }
    return IgnorePointer(
      child: SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: AnimatedBuilder(
              animation: MathProLatencyProbeQ382R23.instance,
              builder: (context, _) {
                final snapshot = MathProLatencyProbeQ382R23.instance.latest;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xE6111519),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.18), width: 0.7),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.22),
                        blurRadius: 14,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                    child: Text(
                      _textFor(snapshot),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        height: 1.18,
                        fontWeight: FontWeight.w700,
                        fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String _textFor(MathProLatencySnapshotQ382R23? s) {
    if (s == null) {
      return 'LATENCY Q382R23\nwaiting for key...';
    }
    return 'LATENCY Q382R23'
        '\nkey ${s.label} #${s.sequence}'
        '\nT0→T1 ${_fmt(s.tapDownToTapMs)}'
        '\nT1→T2 ${_fmt(s.tapToDartCommandMs)}'
        '\nT2→T3 ${_fmt(s.dartToJsBridgeMs)}'
        '\nT3→T4 ${_fmt(s.jsBridgeToInsertStartMs)}'
        '\nT4→T5 ${_fmt(s.mathLiveInsertMs)}'
        '\nT5→T6 ${_fmt(s.insertEndToJsPostMs)}'
        '\nT6→T7 ${_fmt(s.jsPostToFlutterStateMs)}'
        '\nT7→T8 ${_fmt(s.flutterStateToFrameMs)}'
        '\nTOTAL ${_fmt(s.totalTapDownToFrameMs)}'
        '\npush ${s.bridgeNotifyCount}/${s.caretStatePushCount}';
  }

  String _fmt(double? value) {
    if (value == null) return '—';
    return '${value.toStringAsFixed(1)}ms';
  }
}
