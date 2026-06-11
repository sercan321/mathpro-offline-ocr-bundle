import 'dart:math' as math;
import 'dart:ui';

import '../editor/slot_registry.dart';
import 'renderer_sync_geometry_policy.dart';

/// V172-Q46 renderer slot identity prototype for the P6-locked cursor track.
///
/// This is deliberately a prototype, not a fake final identity system.  MathJax
/// now reports real rendered SVG element rectangles, and this policy can use
/// those rectangles as role candidates for cursor geometry.  It does not claim
/// stable AST-slot -> SVG-node identity yet because no slot ids are embedded in
/// MathJax output.  The only safe claim is candidate identity refinement.
class RendererSlotIdentityPolicy {
  const RendererSlotIdentityPolicy._();

  static const String version = 'mathpro-v172q46-renderer-slot-identity-prototype-p6-locked-v1';

  static const bool p6VisualFilesLocked = true;
  static const bool rendererSlotIdentityPrototypeAvailable = true;
  static const bool rendererElementRectTelemetryEnabled = true;
  static const bool rendererCandidateIdentityRefinementEnabled = true;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool fakePerSlotIdentityAllowed = false;
  static const bool fallbackMustBeExplicit = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;

  static const double maxCandidateCenterDistance = 54.0;
  static const double maxCandidateRectAreaFactor = 3.8;
  static const double rendererCandidateBlend = 0.42;

  static bool supportsRole(String role) {
    return switch (role) {
      'fractionNumerator' ||
      'fractionDenominator' ||
      'powerExponent' ||
      'subscript' ||
      'logBase' ||
      'functionArgument' ||
      'sqrtValue' ||
      'rootIndex' ||
      'integralUpperLimit' ||
      'integralLowerLimit' ||
      'limitTarget' ||
      'limitVariable' => true,
      _ => false,
    };
  }

  /// Refines deterministic geometry with the best renderer element candidate.
  /// This must stay conservative: a candidate can nudge the existing rect
  /// toward measured SVG content but it cannot replace semantic slot geometry
  /// unless true AST-slot id mapping exists in a later phase.
  static Rect refineVisualRect({
    required SlotEntry entry,
    required Rect deterministicRect,
    required Size canvasSize,
  }) {
    if (!supportsRole(entry.role) || canvasSize.isEmpty) return deterministicRect;
    final snapshot = RendererSyncGeometryPolicy.latestSnapshot;
    if (snapshot == null || !RendererSyncGeometryPolicy.hasRecentRendererExpressionEnvelope) {
      return deterministicRect;
    }
    final candidates = snapshot.elementRectsForCanvas(canvasSize);
    if (candidates.isEmpty) return deterministicRect;
    final candidate = _bestCandidateForRole(
      role: entry.role,
      deterministicRect: deterministicRect,
      candidates: candidates,
      canvasSize: canvasSize,
      rendererContent: snapshot.contentRectForCanvas(canvasSize),
    );
    if (candidate == null) return deterministicRect;
    return _blendRects(deterministicRect, candidate.rect, rendererCandidateBlend, canvasSize);
  }

  static RendererElementRect? _bestCandidateForRole({
    required String role,
    required Rect deterministicRect,
    required List<RendererElementRect> candidates,
    required Size canvasSize,
    required Rect rendererContent,
  }) {
    RendererElementRect? best;
    var bestScore = double.infinity;
    for (final candidate in candidates) {
      if (!_candidateCanRepresentRole(role, candidate.rect, rendererContent)) continue;
      final distance = (candidate.rect.center - deterministicRect.center).distance;
      if (distance > maxCandidateCenterDistance) continue;
      final candidateArea = math.max(1.0, candidate.rect.width * candidate.rect.height);
      final deterministicArea = math.max(1.0, deterministicRect.width * deterministicRect.height);
      final areaRatio = candidateArea > deterministicArea
          ? candidateArea / deterministicArea
          : deterministicArea / candidateArea;
      if (areaRatio > maxCandidateRectAreaFactor) continue;
      final score = distance + areaRatio * 5.0 + _roleLanePenalty(role, candidate.rect, rendererContent);
      if (score < bestScore) {
        bestScore = score;
        best = candidate;
      }
    }
    return best;
  }

  static bool _candidateCanRepresentRole(String role, Rect rect, Rect content) {
    if (rect.isEmpty || content.isEmpty) return false;
    final centerY = content.center.dy;
    final highBand = content.top + content.height * 0.38;
    final lowBand = content.top + content.height * 0.62;
    final topish = rect.center.dy <= highBand;
    final bottomish = rect.center.dy >= lowBand;
    final middle = rect.center.dy > highBand && rect.center.dy < lowBand;
    return switch (role) {
      'fractionNumerator' || 'powerExponent' || 'rootIndex' || 'integralUpperLimit' => topish || rect.center.dy < centerY,
      'fractionDenominator' || 'subscript' || 'logBase' || 'integralLowerLimit' || 'limitTarget' || 'limitVariable' => bottomish || rect.center.dy > centerY,
      'functionArgument' || 'sqrtValue' => middle || rect.overlaps(content.deflate(math.min(10.0, content.shortestSide * 0.12))),
      _ => true,
    };
  }

  static double _roleLanePenalty(String role, Rect rect, Rect content) {
    if (content.isEmpty) return 0;
    final centerY = content.center.dy;
    final signed = rect.center.dy - centerY;
    final wantsUpper = switch (role) {
      'fractionNumerator' || 'powerExponent' || 'rootIndex' || 'integralUpperLimit' => true,
      _ => false,
    };
    final wantsLower = switch (role) {
      'fractionDenominator' || 'subscript' || 'logBase' || 'integralLowerLimit' || 'limitTarget' || 'limitVariable' => true,
      _ => false,
    };
    if (wantsUpper && signed > 0) return 24.0;
    if (wantsLower && signed < 0) return 24.0;
    return 0.0;
  }

  static Rect _blendRects(Rect a, Rect b, double blend, Size canvasSize) {
    final safeBlend = blend.clamp(0.0, 1.0).toDouble();
    final center = Offset(
      _mix(a.center.dx, b.center.dx, safeBlend),
      _mix(a.center.dy, b.center.dy, safeBlend),
    );
    final width = _mix(a.width, b.width, safeBlend * 0.32).clamp(18.0, math.max(18.0, canvasSize.width * 0.42)).toDouble();
    final height = _mix(a.height, b.height, safeBlend * 0.32).clamp(16.0, math.max(16.0, canvasSize.height * 0.58)).toDouble();
    final rect = Rect.fromCenter(center: center, width: width, height: height);
    return Rect.fromLTRB(
      rect.left.clamp(0.0, math.max(0.0, canvasSize.width)).toDouble(),
      rect.top.clamp(0.0, math.max(0.0, canvasSize.height)).toDouble(),
      rect.right.clamp(0.0, math.max(0.0, canvasSize.width)).toDouble(),
      rect.bottom.clamp(0.0, math.max(0.0, canvasSize.height)).toDouble(),
    );
  }

  static double _mix(double a, double b, double blend) => a + (b - a) * blend;
}
