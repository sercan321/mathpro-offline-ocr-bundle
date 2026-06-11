import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Q204R2 migrated production-surface contract: v172 q169r29 analyzer contract repair', () {
    test('shim remains only a compatibility forwarder', () {
      final shim = File('lib/features/mathlive/mathlive_main_editor_surface.dart').readAsStringSync();
      expect(shim, contains('class MathLiveMainEditorSurface extends StatelessWidget'));
      expect(shim, contains('return MathLiveProductionEditorSurface('));
      expect(shim, contains('forwardsToProductionSurface = true'));
      expect(shim, contains('staleCompatibilityShimMayRenderFallback = false'));
      expect(shim, contains('webViewAssetPath = MathLiveProductionEditorSurface.webViewAssetPath'));
    });

    test('active production implementation, bridge, and HTML own runtime behavior', () {
      final production = File('lib/features/mathlive/mathlive_production_editor_surface.dart').readAsStringSync();
      final bridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();
      final html = File('assets/mathlive/main_editor_prod.html').readAsStringSync();

      expect(production, contains('class MathLiveProductionEditorSurface extends StatefulWidget'));
      expect(production, contains('scheduleMathProKey'));
      expect(production, contains('_enqueueProductionCommand'));
      expect(production, contains('MathLiveFinalStaticProductionFreezePolicy.phase'));
      expect(bridge, contains('q203ProductionContractsFrozen: true'));
      expect(bridge, contains('function insertLatex'));
      expect(bridge, contains('function keepCaretVisible'));
      expect(html, contains('<math-field id="mathlive-field"'));
      expect(html, contains('data-mathpro-final-static-production-freeze="V172-Q203"'));
      expect(html, contains('data-mathpro-native-caret-authority="mathlive"'));
    });
  });
}
