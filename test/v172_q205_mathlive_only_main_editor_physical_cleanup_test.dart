import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_mathlive_only_main_editor_physical_cleanup_policy.dart';

void main() {
  group('V172-Q205 MathLive-only main editor physical cleanup', () {
    test('declares MathLive production editor as the single expression authority', () {
      expect(MathLiveOnlyMainEditorPhysicalCleanupPolicy.phase, 'V172-Q205');
      expect(MathLiveOnlyMainEditorPhysicalCleanupPolicy.mathLiveProductionEditorIsSingleExpressionAuthority, isTrue);
      expect(MathLiveOnlyMainEditorPhysicalCleanupPolicy.editorViewportProductionRouteAllowed, isFalse);
      expect(MathLiveOnlyMainEditorPhysicalCleanupPolicy.flutterCaretOverlayProductionRouteAllowed, isFalse);
      expect(MathLiveOnlyMainEditorPhysicalCleanupPolicy.mathJaxEditorSurfaceProductionRouteAllowed, isFalse);
      expect(MathLiveOnlyMainEditorPhysicalCleanupPolicy.graphHistorySolutionAdapterPreserved, isTrue);
    });

    test('production AppShell and Workspace no longer build the legacy editor route', () {
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
      expect(appShell, isNot(contains('MathEditorController.buildSnapshot')));
      expect(appShell, isNot(contains('selectEditorSlot(')));
      expect(appShell, isNot(contains('selectTextCaret(')));
      expect(workspace, contains('MathLiveProductionEditorSurface('));
      expect(workspace, isNot(contains('EditorViewport(')));
      expect(workspace, isNot(contains('_LegacyCursorMainPathDisabledPanel')));
    });

    test('retired editor-render files are physically absent from production source tree', () {
      for (final rel in <String>[
        'lib/features/workspace/editor_viewport.dart',
        'lib/features/workspace/editor_caret_overlay.dart',
        'lib/features/editor/render/mathjax_render_surface.dart',
        'lib/features/editor_adapter/legacy_flutter_slot_editor_adapter.dart',
        'assets/mathjax/tex-svg.js',
      ]) {
        expect(File(rel).existsSync(), isFalse, reason: '$rel must remain physically retired in Q205');
      }
    });
  });
}
