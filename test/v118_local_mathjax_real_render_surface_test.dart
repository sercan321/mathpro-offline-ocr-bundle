import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_mathlive_only_main_editor_physical_cleanup_policy.dart';

void main() {
  group('V172-Q205 retired legacy editor coverage for v118_local_mathjax_real_render_surface_test', () {
    test('legacy Flutter editor/render artifacts are retired from production source tree', () {
      expect(MathLiveOnlyMainEditorPhysicalCleanupPolicy.phase, 'V172-Q205');
      expect(MathLiveOnlyMainEditorPhysicalCleanupPolicy.mathLiveProductionEditorIsSingleExpressionAuthority, isTrue);
      expect(MathLiveOnlyMainEditorPhysicalCleanupPolicy.editorViewportProductionRouteAllowed, isFalse);
      expect(File('lib/features/workspace/editor_viewport.dart').existsSync(), isFalse);
      expect(File('lib/features/workspace/editor_caret_overlay.dart').existsSync(), isFalse);
      expect(File('lib/features/editor/render/mathjax_render_surface.dart').existsSync(), isFalse);
      expect(File('lib/features/editor_adapter/legacy_flutter_slot_editor_adapter.dart').existsSync(), isFalse);
    });
  });
}
