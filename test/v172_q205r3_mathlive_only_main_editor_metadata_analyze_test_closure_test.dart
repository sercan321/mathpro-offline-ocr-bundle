import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_only_main_editor_metadata_analyze_test_closure_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  test('V172-Q205R3 preserves MathLive-only editor while restoring historical pubspec metadata compatibility', () {
    expect(MathLiveOnlyMainEditorMetadataAnalyzeTestClosurePolicy.phase, 'V172-Q205R3');
    expect(MathLiveOnlyMainEditorMetadataAnalyzeTestClosurePolicy.q205MathLiveOnlyMainEditorPreserved, isTrue);
    expect(MathLiveOnlyMainEditorMetadataAnalyzeTestClosurePolicy.legacyPubspecDescriptionCompatibilityBlockPresent, isTrue);
    expect(MathLiveOnlyMainEditorMetadataAnalyzeTestClosurePolicy.runReturningResultPathRestored, isFalse);
    expect(MathLiveOnlyMainEditorMetadataAnalyzeTestClosurePolicy.visibleFallbackOverlayRestored, isFalse);
    expect(MathLiveOnlyMainEditorMetadataAnalyzeTestClosurePolicy.legacyMainEditorStateRestored, isFalse);

    final pubspec = File('pubspec.yaml').readAsStringSync();
    expect(pubspec, contains('Q205R3 MathLive-only main editor metadata/analyze-test closure hygiene'));
    expect(pubspec, contains('V172-Q205R3 legacy metadata compatibility block'));
    expect(pubspec, contains(MathProPackageContract.pubspecDescription));
  });

  test('V172-Q205R3 does not restore retired Flutter editor/caret/MathJax artifacts', () {
    for (final path in <String>[
      'lib/features/workspace/editor_viewport.dart',
      'lib/features/workspace/editor_caret_overlay.dart',
      'lib/features/editor/render/mathjax_render_surface.dart',
      'lib/features/editor_adapter/legacy_flutter_slot_editor_adapter.dart',
      'assets/mathjax/tex-svg.js',
    ]) {
      expect(File(path).existsSync(), isFalse, reason: '$path must stay retired');
    }
  });
}
