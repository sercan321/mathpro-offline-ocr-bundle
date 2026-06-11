import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../features/keyboard/keyboard_latency_closure_q382r24_policy.dart';
import 'mathpro_all_key_latency_court_q382r25_policy.dart';

class MathProRealDeviceLatencyInstrumentationQ382R23Policy {
  const MathProRealDeviceLatencyInstrumentationQ382R23Policy._();

  static const String phase = 'V172-Q382R23';
  static const String contractMarker = 'q382r23-real-device-latency-instrumentation-active';
  static const bool debugOnly = true;
  static const bool releaseOverlayAllowed = false;
  static const bool performanceOptimizationAllowed = false;
  static const bool keyboardLayoutOrderLabelsUntouched = true;
  static const bool mathLiveCommandSemanticsUntouched = true;
  static const bool graphSolutionHistoryOcrAndroidUntouched = true;
  static const bool panDragScrollReintroduced = false;
}

class MathProLatencySnapshotQ382R23 {
  const MathProLatencySnapshotQ382R23({
    required this.phase,
    required this.label,
    required this.sequence,
    required this.t0TapDownEpochMs,
    required this.t1TapEpochMs,
    required this.t2DartCommandScheduledEpochMs,
    required this.t3JsBridgeReceivedEpochMs,
    required this.t4MathLiveInsertStartEpochMs,
    required this.t5MathLiveInsertEndEpochMs,
    required this.t6JsStatePostEpochMs,
    required this.t7FlutterStateReceivedEpochMs,
    required this.t8FramePaintedEpochMs,
    required this.bridgeNotifyCount,
    required this.caretStatePushCount,
    required this.rawStatus,
  });

  final String phase;
  final String label;
  final int sequence;
  final double? t0TapDownEpochMs;
  final double? t1TapEpochMs;
  final double? t2DartCommandScheduledEpochMs;
  final double? t3JsBridgeReceivedEpochMs;
  final double? t4MathLiveInsertStartEpochMs;
  final double? t5MathLiveInsertEndEpochMs;
  final double? t6JsStatePostEpochMs;
  final double? t7FlutterStateReceivedEpochMs;
  final double? t8FramePaintedEpochMs;
  final int bridgeNotifyCount;
  final int caretStatePushCount;
  final String rawStatus;

  static double? _delta(double? start, double? end) {
    if (start == null || end == null) return null;
    return end - start;
  }

  double? get tapDownToTapMs => _delta(t0TapDownEpochMs, t1TapEpochMs);
  double? get tapToDartCommandMs => _delta(t1TapEpochMs, t2DartCommandScheduledEpochMs);
  double? get dartToJsBridgeMs => _delta(t2DartCommandScheduledEpochMs, t3JsBridgeReceivedEpochMs);
  double? get jsBridgeToInsertStartMs => _delta(t3JsBridgeReceivedEpochMs, t4MathLiveInsertStartEpochMs);
  double? get mathLiveInsertMs => _delta(t4MathLiveInsertStartEpochMs, t5MathLiveInsertEndEpochMs);
  double? get insertEndToJsPostMs => _delta(t5MathLiveInsertEndEpochMs, t6JsStatePostEpochMs);
  double? get jsPostToFlutterStateMs => _delta(t6JsStatePostEpochMs, t7FlutterStateReceivedEpochMs);
  double? get flutterStateToFrameMs => _delta(t7FlutterStateReceivedEpochMs, t8FramePaintedEpochMs);
  double? get totalTapDownToFrameMs => _delta(t0TapDownEpochMs, t8FramePaintedEpochMs);

  String _fmt(double? value) {
    if (value == null) return '—';
    return '${value.toStringAsFixed(1)}ms';
  }

  String get compactLine =>
      'seq=$sequence label=$label total=${_fmt(totalTapDownToFrameMs)} '
      'tap=${_fmt(tapDownToTapMs)} dart→js=${_fmt(dartToJsBridgeMs)} '
      'insert=${_fmt(mathLiveInsertMs)} js→flutter=${_fmt(jsPostToFlutterStateMs)} '
      'frame=${_fmt(flutterStateToFrameMs)} pushes=$bridgeNotifyCount/$caretStatePushCount';
}

class _LatencySpanQ382R23 {
  _LatencySpanQ382R23({required this.label, required this.sequence});

  String label;
  int sequence;
  double? t0TapDownEpochMs;
  double? t1TapEpochMs;
  double? t2DartCommandScheduledEpochMs;
  double? t3JsBridgeReceivedEpochMs;
  double? t4MathLiveInsertStartEpochMs;
  double? t5MathLiveInsertEndEpochMs;
  double? t6JsStatePostEpochMs;
  double? t7FlutterStateReceivedEpochMs;
  double? t8FramePaintedEpochMs;
  int bridgeNotifyCount = 0;
  int caretStatePushCount = 0;
  String rawStatus = '';
  bool frameCallbackScheduled = false;

  MathProLatencySnapshotQ382R23 toSnapshot() {
    return MathProLatencySnapshotQ382R23(
      phase: MathProRealDeviceLatencyInstrumentationQ382R23Policy.phase,
      label: label,
      sequence: sequence,
      t0TapDownEpochMs: t0TapDownEpochMs,
      t1TapEpochMs: t1TapEpochMs,
      t2DartCommandScheduledEpochMs: t2DartCommandScheduledEpochMs,
      t3JsBridgeReceivedEpochMs: t3JsBridgeReceivedEpochMs,
      t4MathLiveInsertStartEpochMs: t4MathLiveInsertStartEpochMs,
      t5MathLiveInsertEndEpochMs: t5MathLiveInsertEndEpochMs,
      t6JsStatePostEpochMs: t6JsStatePostEpochMs,
      t7FlutterStateReceivedEpochMs: t7FlutterStateReceivedEpochMs,
      t8FramePaintedEpochMs: t8FramePaintedEpochMs,
      bridgeNotifyCount: bridgeNotifyCount,
      caretStatePushCount: caretStatePushCount,
      rawStatus: rawStatus,
    );
  }
}

class MathProLatencyProbeQ382R23 extends ChangeNotifier {
  MathProLatencyProbeQ382R23._();

  static final MathProLatencyProbeQ382R23 instance = MathProLatencyProbeQ382R23._();

  final Map<int, _LatencySpanQ382R23> _spans = <int, _LatencySpanQ382R23>{};
  MathProLatencySnapshotQ382R23? _latest;
  String _lastTapDownLabel = '';
  String _lastTapLabel = '';
  double? _lastTapDownEpochMs;
  double? _lastTapEpochMs;

  bool get _probeActive =>
      kDebugMode &&
      (KeyboardLatencyClosureQ382R24Policy.latencyProbeEnabledByDefault ||
          MathProAllKeyLatencyCourtQ382R25Policy.enabledByDartDefine);

  MathProLatencySnapshotQ382R23? get latest => _probeActive ? _latest : null;

  double _nowEpochMs() => DateTime.now().microsecondsSinceEpoch / 1000.0;

  void recordPremiumKeyTapDown(String label) {
    if (!_probeActive) return;
    _lastTapDownLabel = label;
    _lastTapDownEpochMs = _nowEpochMs();
    _notifyLightweight();
  }

  void recordPremiumKeyTap(String label) {
    if (!_probeActive) return;
    _lastTapLabel = label;
    _lastTapEpochMs = _nowEpochMs();
    _notifyLightweight();
  }

  void recordDartCommandScheduled({required String label, required int sequence}) {
    if (!_probeActive) return;
    final span = _spans.putIfAbsent(sequence, () => _LatencySpanQ382R23(label: label, sequence: sequence));
    span.label = label;
    span.t2DartCommandScheduledEpochMs = _nowEpochMs();
    if (_lastTapDownLabel == label) span.t0TapDownEpochMs = _lastTapDownEpochMs;
    if (_lastTapLabel == label) span.t1TapEpochMs = _lastTapEpochMs;
    _latest = span.toSnapshot();
    _trimOldSpans();
    notifyListeners();
  }

  void recordFlutterStateReceivedFromJs(String rawMessage) {
    if (!_probeActive) return;
    try {
      final decoded = jsonDecode(rawMessage);
      if (decoded is! Map<String, dynamic>) return;
      final latency = decoded['q382r23LastLatency'];
      if (latency is! Map<String, dynamic>) return;
      final sequence = _asInt(latency['sequence']);
      if (sequence <= 0) return;
      final label = (latency['label'] ?? decoded['lastCommandLabel'] ?? '').toString();
      final span = _spans.putIfAbsent(sequence, () => _LatencySpanQ382R23(label: label, sequence: sequence));
      span.label = label.isNotEmpty ? label : span.label;
      span.t3JsBridgeReceivedEpochMs = _asDouble(latency['t3JsBridgeReceivedEpochMs']);
      span.t4MathLiveInsertStartEpochMs = _asDouble(latency['t4MathLiveInsertStartEpochMs']);
      span.t5MathLiveInsertEndEpochMs = _asDouble(latency['t5MathLiveInsertEndEpochMs']);
      span.t6JsStatePostEpochMs = _asDouble(latency['t6JsStatePostEpochMs']);
      span.t7FlutterStateReceivedEpochMs = _nowEpochMs();
      span.bridgeNotifyCount = _asInt(decoded['bridgeNotifyCount']);
      span.caretStatePushCount = _asInt(decoded['caretStatePushCount']);
      span.rawStatus = (decoded['commandTraceStatus'] ?? decoded['selectionDescription'] ?? '').toString();
      _latest = span.toSnapshot();
      _trimOldSpans();
      notifyListeners();
    } catch (_) {
      return;
    }
  }

  void recordAppShellStateHandled({String label = '', int sequence = 0}) {
    if (!_probeActive) return;
    final target = sequence > 0 ? _spans[sequence] : _latestSpanFor(label: label);
    if (target == null || target.frameCallbackScheduled) return;
    target.frameCallbackScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_probeActive) return;
      target.t8FramePaintedEpochMs = _nowEpochMs();
      target.frameCallbackScheduled = false;
      _latest = target.toSnapshot();
      debugPrint('[Q382R23_LATENCY] ${_latest!.compactLine}');
      notifyListeners();
    });
  }

  _LatencySpanQ382R23? _latestSpanFor({String label = ''}) {
    if (_spans.isEmpty) return null;
    final values = _spans.values.toList()..sort((a, b) => b.sequence.compareTo(a.sequence));
    if (label.isEmpty) return values.first;
    for (final span in values) {
      if (span.label == label) return span;
    }
    return values.first;
  }

  int _asInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse((value ?? '').toString()) ?? 0;
  }

  double? _asDouble(Object? value) {
    if (value is num) return value.toDouble();
    return double.tryParse((value ?? '').toString());
  }

  void _trimOldSpans() {
    if (_spans.length <= 40) return;
    final keys = _spans.keys.toList()..sort();
    for (final key in keys.take(_spans.length - 40)) {
      _spans.remove(key);
    }
  }

  void _notifyLightweight() {
    // Keep T0/T1 visible to the overlay without claiming a completed latency span.
    notifyListeners();
  }
}
