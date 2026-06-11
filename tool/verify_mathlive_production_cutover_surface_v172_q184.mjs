#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_cutover_surface_v172_q184.mjs', preservedPhase: 'verify_mathlive_production_cutover_surface_v172_q184' });

const files = {
  workspace: 'lib/features/workspace/workspace_panel.dart',
  surface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurface: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  policy: 'lib/features/mathlive/mathlive_production_cutover_surface_policy.dart',
  prodHtml: 'assets/mathlive/main_editor_prod.html',
  prodBridge: 'assets/mathlive/mathlive_prod_bridge.js',
  manifest: 'assets/mathlive/manifest.json',
};
const text = Object.fromEntries(Object.entries(files).map(([k, p]) => [k, fs.readFileSync(p, 'utf8')]));
text.surfaceCombined = `${text.surface}\n${text.prodSurface || ''}`;
const failures = [];
text.prodSurfaceCombined = `${text.prodSurface || ''}\n${text.prodSurfacePart || ''}`;
const has = (name, needle) => { if (!text[name].includes(needle)) failures.push(`${files[name]} missing ${needle}`); };
const lacks = (name, needle) => { if (text[name].includes(needle)) failures.push(`${files[name]} must not contain ${needle}`); };

has('workspace', 'MathLiveProductionEditorSurface');
has('surfaceCombined', 'class MathLiveProductionEditorSurface');
has('surfaceCombined', "static const String phase = 'V172-Q184'");
has('surfaceCombined', 'MathProProductionMathLiveBridge.insertLatex');
has('surfaceCombined', 'MathProProductionMathLiveBridge.notifyFlutterState');
has('surfaceCombined', 'rootBundle.loadString(MathLiveProductionEditorSurface.runtimeAssetPath)');
has('policy', "phase = 'V172-Q184'");
has('prodHtml', 'data-mathpro-production-surface="V172-Q184"');
has('prodHtml', '__MATHPRO_INLINE_MATHLIVE_RUNTIME__');
has('prodHtml', '__MATHPRO_INLINE_PRODUCTION_BRIDGE__');
has('prodHtml', '<math-field id="mathlive-field"');
has('prodBridge', 'window.MathProProductionMathLiveBridge');
has('prodBridge', 'insertLatex');
has('prodBridge', 'notifyFlutterState');
lacks('prodBridge', 'executeMathProCommand');
has('prodBridge', "selectionMode: 'placeholder'");
has('manifest', 'v172Q184ProductionMathLiveCutoverSurface');

for (const selector of ['.ML__placeholder', '.ML__frac-line', '.ML__sqrt-line', '.ML__base', '.ML__cmr', '.ML__mathit', '.ML__mathrm']) {
  lacks('prodHtml', selector);
}

if (failures.length) {
  console.error('MATHLIVE_PRODUCTION_CUTOVER_SURFACE_Q184_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_PRODUCTION_CUTOVER_SURFACE_Q184_PACKAGE_READY_BUT_FLUTTER_DEVICE_EVIDENCE_REQUIRED');
