import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_state_adapter.dart';

void main() {
  group('V172-Q382R26 Caret Context Bridge', () {
    test('parses explicit caret context without enabling optimistic echo', () {
      expect(MathLiveCaretContextBridgeQ382R26Policy.phase, 'V172-Q382R26');
      expect(MathLiveCaretContextBridgeQ382R26Policy.bridgePayloadCarriesCaretContext, isTrue);
      expect(MathLiveCaretContextBridgeQ382R26Policy.flutterParsesCaretContext, isTrue);
      expect(MathLiveCaretContextBridgeQ382R26Policy.optimisticEchoEnabledByThisPhase, isFalse);
      expect(MathLiveCaretContextBridgeQ382R26Policy.nativeMathLiveCaretAuthorityPreserved, isTrue);
      expect(MathLiveCaretContextBridgeQ382R26Policy.privateShadowDomCaretReadAllowed, isFalse);

      final snapshot = MathLiveStateAdapter.parseBridgeMessage(jsonEncode(<String, Object?>{
        'latex': '123',
        'normalizedLatex': '123',
        'plainText': '123',
        'runtime': 'mathlive-production',
        'caretContext': <String, Object?>{
          'phase': 'V172-Q382R26',
          'source': 'mathlive-public-position-lastOffset',
          'confidence': 'trusted-linear-document-context',
          'trusted': true,
          'selectionCollapsed': true,
          'caretAtDocumentEnd': true,
          'insidePlaceholder': false,
          'insideTemplate': false,
          'caretOffset': 3,
          'documentEndOffset': 3,
          'selectionLength': 0,
          'diagnostic': 'q382r26-caret-context-trusted-for-linear-append-gate',
        },
      }));

      expect(snapshot.caretContext.phase, 'V172-Q382R26');
      expect(snapshot.caretContext.trusted, isTrue);
      expect(snapshot.caretContext.selectionCollapsed, isTrue);
      expect(snapshot.caretContext.caretAtDocumentEnd, isTrue);
      expect(snapshot.caretContext.insidePlaceholder, isFalse);
      expect(snapshot.caretContext.insideTemplate, isFalse);
      expect(snapshot.mayAllowOptimisticLinearAppend, isTrue);
      expect(snapshot.toJson()['caretContext'], isA<Map<String, Object?>>());
    });

    test('keeps missing caret context unknown and blocks optimistic gate', () {
      final snapshot = MathLiveStateAdapter.parseBridgeMessage(jsonEncode(<String, Object?>{
        'latex': r'\frac{}{}',
        'normalizedLatex': r'\frac{}{}',
      }));

      expect(snapshot.caretContext.phase, 'V172-Q382R26');
      expect(snapshot.caretContext.trusted, isFalse);
      expect(snapshot.mayAllowOptimisticLinearAppend, isFalse);
    });

    test('production bridge emits caretContext from public MathLive state only', () {
      final bridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();
      expect(bridge, contains("const CARET_CONTEXT_BRIDGE_PHASE = 'V172-Q382R26'"));
      expect(bridge, contains('q382r26ReadCaretContext'));
      expect(bridge, contains('caretContext'));
      expect(bridge, contains('mathlive-public-position-lastOffset'));
      final q382r26Reader = bridge.substring(
        bridge.indexOf('function q382r26ReadCaretContext'),
        bridge.indexOf('function updateState'),
      );
      expect(q382r26Reader, isNot(contains('shadowRoot')));
      expect(q382r26Reader, isNot(contains('ML__caret')));
    });
  });
}
