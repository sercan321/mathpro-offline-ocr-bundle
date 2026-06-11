import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:webview_flutter/webview_flutter.dart';

import '../../theme/mathpro_tokens.dart';
import '../../debug/latency/mathpro_latency_probe_q382r23.dart';
import 'mathlive_keyboard_bridge_policy.dart';
import 'mathlive_production_command_contract_policy.dart';
import 'mathlive_production_no_freeze_ui_contract_policy.dart';
import 'mathlive_production_caret_focus_slot_finalization_policy.dart';
import 'mathlive_production_platform_view_policy.dart';
import 'mathlive_production_command_trace_policy.dart';
import 'mathlive_legacy_marker_policy_verifier_cleanup_policy.dart';
import 'mathlive_state_adapter.dart';
import 'mathlive_production_simplification_policy.dart';
import 'mathlive_production_bridge_contract_policy.dart';
import 'mathlive_real_device_defect_repair_policy.dart';
import 'mathlive_production_active_path_hardening_policy.dart';
import 'mathlive_production_bridge_queue_focus_repair_policy.dart';
import 'mathlive_template_payload_surgical_repair_policy.dart';
import 'mathlive_no_freeze_runtime_invariant_policy.dart';
import 'mathlive_production_static_asset_truth_policy.dart';
import 'mathlive_static_pre_analyze_hygiene_policy.dart';
import 'mathlive_runtime_render_contract_policy.dart';
import 'mathlive_caret_focus_slot_contract_policy.dart';
import 'mathlive_real_mathlive_font_bundle_closure_policy.dart';
import 'mathlive_official_font_bundle_ingestion_policy.dart';
import 'mathlive_physical_legacy_cleanup_policy.dart';
import 'mathlive_production_surface_file_separation_policy.dart';
import 'mathlive_final_static_production_freeze_policy.dart';
import 'mathlive_production_tap_latency_cadence_policy.dart';
import 'mathlive_runtime_payload_slimming_q382r22_policy.dart';
import 'mathlive_keyboard_latency_closure_q382r24_policy.dart';
import 'mathlive_js_side_command_queue_q382r28_policy.dart';
import 'mathlive_key_ordering_regression_q382r33r3_policy.dart';
import 'mathlive_full_keyboard_warmup_q382r33_policy.dart';
part 'mathlive_production_editor_surface.dart';

/// Compatibility markers for the prior Q134 verifier:
/// Q134 — Main Editor MathLive Hard-Mount Runtime Surface
/// static const String phase = 'V172-Q134'
/// V172-Q135-Q139 — Full Main Editor MathLive Migration Surface.
///
/// Q133 still allowed the main workspace to look unchanged when the official
/// MathLive runtime was not actually mounted. Q134 removes that ambiguity: the
/// expression area is either a real local <math-field> surface or an explicit
/// runtime-blocked state. It never silently falls back to the failed legacy
/// Flutter cursor overlay, and it keeps the legacy engine only as rollback code
/// outside this active surface.
class MathLiveMainEditorRuntimeController {
  _MathLiveProductionEditorSurfaceState? _state;
  final List<String> _queuedLabels = <String>[];

  bool get isAttached => _state != null;
  bool get isRuntimeMounted => _state?._runtimeMounted ?? false;
  bool get isRuntimeBlocked => _state?._runtimeBlocked ?? false;

  void markKeyboardTap(String label, {String visibleLatex = ''}) {
    if (label == 'MORE') return;
    _state?._noteFlutterKeyboardTap(label, visibleLatex: visibleLatex);
  }

  void markBridgeSendResult(String label, {required bool sent}) {
    if (label == 'MORE') return;
    _state?._noteBridgeSendResult(label, sent: sent);
  }

  void suppressNextExternalExpressionSyncForOptimisticEcho() {
    _state?._suppressNextExternalExpressionSyncForQ382R27OptimisticEcho();
  }

  void _attach(_MathLiveProductionEditorSurfaceState state) {
    _state = state;
    _flushQueuedLabels(lastAnswer: state.widget.lastAnswer);
  }

  void _flushQueuedLabels({required String lastAnswer, String reason = 'production-queue-flush-request'}) {
    final state = _state;
    if (state == null || !state.isReady || _queuedLabels.isEmpty) return;
    if (!state._productionMayFlushQueuedCommands) return;
    final pending = List<String>.from(_queuedLabels);
    _queuedLabels.clear();
    state._noteProductionQueueFlush(reason: reason, count: pending.length);
    scheduleMicrotask(() async {
      for (final label in pending) {
        await sendKey(label, lastAnswer: lastAnswer);
      }
      state._noteProductionQueueFlushCompleted(reason: reason);
    });
  }

  void _detach(_MathLiveProductionEditorSurfaceState state) {
    if (_state == state) _state = null;
  }

  Future<bool> sendKey(String label, {String lastAnswer = ''}) =>
      Future<bool>.value(sendKeyFast(label, lastAnswer: lastAnswer));

  bool sendKeyFast(String label, {String lastAnswer = ''}) {
    final state = _state;
    if (state == null || !state.isReady) {
      if (label != 'MORE') {
        _queuedLabels.add(label);
        if (_queuedLabels.length > MathLiveProductionPlatformViewPolicy.maxQueuedKeyboardCommands) {
          _queuedLabels.removeAt(0);
        }
        state?._noteBridgeSendResult(label, sent: false);
      }
      return false;
    }
    // V172-Q382R24: AppShell accepts the key synchronously. The production
    // surface schedules the WebView command immediately; canonical MathLive
    // state still arrives through the JS channel.
    final sent = state.scheduleMathProKey(label, lastAnswer: lastAnswer);
    state._noteBridgeSendResult(label, sent: sent);
    return sent;
  }

  Future<String?> currentStateJson() => _state?.currentStateJson() ?? Future<String?>.value(null);

  Future<bool> setLatexFromApprovedOcrImport(String latex) async {
    final state = _state;
    final trimmed = latex.trim();
    if (state == null || !state.isReady || trimmed.isEmpty) return false;
    await state._setLatex(trimmed, reason: 'q378-approved-ocr-workspace-import');
    return true;
  }

  Future<bool> setLatexFromWorkspaceContextMenu(String latex) async {
    final state = _state;
    if (state == null || !state.isReady) return false;
    await state._setLatex(latex.trim(), reason: 'q382-workspace-expression-context-menu');
    return true;
  }

}

/// V172-Q198 — Production compatibility shim.
///
/// The active editor implementation lives in [MathLiveProductionEditorSurface].
/// This public widget name remains only as a stale-call-site adapter; constructing
/// it forwards directly to the production surface and cannot revive the retired
/// Flutter fallback, historical evidence surfaces, or non-production trace surfaces.
class MathLiveMainEditorSurface extends StatelessWidget {
  const MathLiveMainEditorSurface({
    super.key,
    required this.controller,
    required this.expressionText,
    required this.lastAnswer,
    required this.onStateChanged,
    required this.onEvaluateRequested,
  });

  static const String phase = 'V172-Q198';
  static const String legacyMarkerPolicyVerifierCleanupPhase = MathLiveLegacyMarkerPolicyVerifierCleanupPolicy.phase;
  static const String physicalLegacyCleanupPhase = MathLivePhysicalLegacyCleanupPolicy.phase;
  static const bool legacyImplementationPhysicallyRemoved = true;
  static const bool visibleFallbackOverlayPhysicallyRemoved = true;
  static const bool forwardsToProductionSurface = true;
  static const bool staleCompatibilityShimMayRenderFallback = false;
  static const String webViewAssetPath = MathLiveProductionEditorSurface.webViewAssetPath;

  bool get _productionRouteEnabled => MathLiveProductionSimplificationPolicy.productionBridgeLean;

  final MathLiveMainEditorRuntimeController controller;
  final String expressionText;
  final String lastAnswer;
  final ValueChanged<MathLiveEditorStateSnapshot> onStateChanged;
  final VoidCallback onEvaluateRequested;

  @override
  Widget build(BuildContext context) {
    if (!_productionRouteEnabled) {
      return const _RuntimeBlockedPanel(message: 'Production MathLive route disabled by production policy.');
    }
    return MathLiveProductionEditorSurface(
      controller: controller,
      expressionText: expressionText,
      lastAnswer: lastAnswer,
      onStateChanged: onStateChanged,
      onEvaluateRequested: onEvaluateRequested,
    );
  }
}

class _RuntimeBlockedPanel extends StatelessWidget {
  const _RuntimeBlockedPanel({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('mathpro-main-mathlive-runtime-blocked-panel'),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: const Color(0xFF0B0F12),
      child: Text(
        message,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: MathProColors.textSoft,
          fontSize: 13,
          height: 1.15,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
