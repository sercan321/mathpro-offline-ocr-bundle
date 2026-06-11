import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/cursor_golden_geometry_court_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/deterministic_slot_geometry_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_geometry_bundle_authority.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q61 cursor golden geometry court', () {
    test('metadata advances to Q61 without claiming real-device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q61 Cursor Golden Geometry Court'));
      expect(MathProPackageContract.q61CursorGoldenGeometryCourtRule, contains('Golden Geometry Court'));
      expect(CursorGoldenGeometryCourtPolicy.cursorGoldenGeometryCourtAvailable, isTrue);
      expect(CursorGoldenGeometryCourtPolicy.realDevicePlus95PassClaimed, isFalse);
    });

    test('core empty slot bundles satisfy |□ geometry invariants', () {
      const canvas = Size(390, 220);
      final entries = <SlotEntry>[
        _entry('fraction-denominator', MathNodeKind.fraction, 'denominator', 'fractionDenominator', const NormalizedSlotBounds(left: 0.52, top: 0.52, width: 0.14, height: 0.13)),
        _entry('function-argument', MathNodeKind.functionCall, 'argument', 'functionArgument', const NormalizedSlotBounds(left: 0.42, top: 0.43, width: 0.16, height: 0.16)),
        _entry('sqrt-value', MathNodeKind.sqrt, 'value', 'sqrtValue', const NormalizedSlotBounds(left: 0.39, top: 0.42, width: 0.18, height: 0.16)),
        _entry('log-base', MathNodeKind.logBase, 'base', 'logBase', const NormalizedSlotBounds(left: 0.36, top: 0.56, width: 0.10, height: 0.12)),
        _entry('integral-upper', MathNodeKind.integral, 'upper', 'integralUpperLimit', const NormalizedSlotBounds(left: 0.45, top: 0.16, width: 0.12, height: 0.12)),
        _entry('integral-differential', MathNodeKind.integral, 'differential', 'integralDifferential', const NormalizedSlotBounds(left: 0.68, top: 0.56, width: 0.12, height: 0.12)),
      ];

      for (final entry in entries) {
        final rect = _rectFromBounds(entry.normalizedBounds, canvas);
        final bundle = DeterministicSlotGeometryRegistry.geometryFor(
          entry: entry,
          rawRect: rect,
          canvasSize: canvas,
        ).bundle;
        final verdict = CursorGoldenGeometryCourtPolicy.evaluateEmptySlotBundle(bundle);
        expect(verdict.passed, isTrue, reason: verdict.summary);
        expect(bundle.leadingRailRect.overlaps(bundle.placeholderRect), isFalse);
        expect(bundle.leadingRailRect.right, lessThanOrEqualTo(bundle.placeholderRect.left));
      }
    });

    test('filled slot carets remain inside innerTextRect and are not forced to |□', () {
      const canvas = Size(390, 220);
      final entry = _entry(
        'sin-argument',
        MathNodeKind.functionCall,
        'argument',
        'functionArgument',
        const NormalizedSlotBounds(left: 0.42, top: 0.43, width: 0.18, height: 0.16),
      );
      final bundle = DeterministicSlotGeometryRegistry.geometryFor(
        entry: entry,
        rawRect: _rectFromBounds(entry.normalizedBounds, canvas),
        canvasSize: canvas,
      ).bundle;
      final caret = SlotGeometryBundleAuthority.caretRectForBundle(
        bundle: bundle,
        caretIndex: 2,
        childCount: 4,
        activeEmptySlotLeadingRail: false,
        canvasSize: canvas,
      );

      expect(CursorGoldenGeometryCourtPolicy.filledCaretIsInsideInnerText(bundle: bundle, caretRect: caret), isTrue);
      expect(CursorGoldenGeometryCourtPolicy.caretUsesExpectedLeadingRail(bundle: bundle, caretRect: caret), isFalse);
    });

    test('synthetic +95 threshold requires at least 19 of 20 correct geometry decisions', () {
      final nineteenOfTwenty = <bool>[for (var i = 0; i < 19; i += 1) true, false];
      final eighteenOfTwenty = <bool>[for (var i = 0; i < 18; i += 1) true, false, false];
      expect(CursorGoldenGeometryCourtPolicy.successRateForResults(nineteenOfTwenty), 0.95);
      expect(CursorGoldenGeometryCourtPolicy.passesPlus95SyntheticThreshold(nineteenOfTwenty), isTrue);
      expect(CursorGoldenGeometryCourtPolicy.passesPlus95SyntheticThreshold(eighteenOfTwenty), isFalse);
    });

    test('Q61 court is source-wired without touching frozen visual surfaces', () {
      final policySource = File('lib/features/formula_engine/cursor_golden_geometry_court_policy.dart').readAsStringSync();
      final contractSource = File('lib/logic/mathpro_package_contract.dart').readAsStringSync();
      final verifierSource = File('tool/verify_mathpro_contract.py').readAsStringSync();
      expect(policySource, contains('CursorGoldenGeometryCourtPolicy'));
      expect(policySource, contains('requiredCorrectPerScenario = 19'));
      expect(policySource, contains('realDevicePlus95PassClaimed = false'));
      expect(contractSource, contains('q61CursorGoldenGeometryCourtRule'));
      expect(verifierSource, contains('check_v172_q61_cursor_golden_geometry_court'));
      expect(policySource, isNot(contains('keyboardSurfaceMutationAllowed = true')));
    });
  });
}

SlotEntry _entry(String id, MathNodeKind kind, String slotKey, String role, NormalizedSlotBounds bounds) {
  return SlotEntry(
    id: id,
    nodeId: 'node-$id',
    nodeKind: kind,
    slotKey: slotKey,
    role: role,
    priority: 120,
    minTouchSize: 72,
    normalizedBounds: bounds,
  );
}

Rect _rectFromBounds(NormalizedSlotBounds bounds, Size canvas) {
  return Rect.fromLTWH(
    bounds.left * canvas.width,
    bounds.top * canvas.height,
    bounds.width * canvas.width,
    bounds.height * canvas.height,
  );
}
