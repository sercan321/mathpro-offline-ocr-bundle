#!/usr/bin/env node
import fs from 'node:fs';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_html_finalization_v172_q185.mjs', preservedPhase: 'verify_mathlive_production_html_finalization_v172_q185' });

const files = {
  html: 'assets/mathlive/main_editor_prod.html',
  bridge: 'assets/mathlive/mathlive_prod_bridge.js',
  surface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurface: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  policy: 'lib/features/mathlive/mathlive_production_html_finalization_policy.dart',
  manifest: 'assets/mathlive/manifest.json',
};
const text = Object.fromEntries(Object.entries(files).map(([k, p]) => [k, fs.readFileSync(p, 'utf8')]));
text.surfaceCombined = `${text.surface}\n${text.prodSurface || ''}`;
const failures = [];
text.prodSurfaceCombined = `${text.prodSurface || ''}\n${text.prodSurfacePart || ''}`;
const has = (name, needle) => { if (!text[name].includes(needle)) failures.push(`${files[name]} missing ${needle}`); };
const lacks = (name, needle) => { if (text[name].includes(needle)) failures.push(`${files[name]} must not contain ${needle}`); };

has('html', 'V172-Q185: production MathLive HTML finalization');
has('html', 'data-mathpro-production-html="V172-Q185"');
has('html', '__MATHPRO_INLINE_MATHLIVE_RUNTIME__');
has('html', '__MATHPRO_INLINE_PRODUCTION_BRIDGE__');
has('bridge', "const HTML_FINALIZATION_PHASE = 'V172-Q185'");
has('bridge', 'window.MathProProductionMathLiveBridge');
has('bridge', 'pendingCommands');
has('bridge', 'whenDefined');
has('bridge', "selectionMode: 'placeholder'");
has('bridge', 'documentLatexFromInsertPayload');
has('surfaceCombined', 'MathLiveProductionEditorSurface.webViewAssetPath');
has('surfaceCombined', 'MathProProductionMathLiveBridge.insertLatex');
has('surfaceCombined', 'MathProProductionMathLiveBridge.notifyFlutterState');
has('policy', "phase = 'V172-Q185'");
has('manifest', 'v172Q185ProductionMathLiveHtmlFinalization');

for (const selector of ['.ML__placeholder', '.ML__frac-line', '.ML__sqrt-line', '.ML__base', '.ML__cmr', '.ML__mathit', '.ML__mathrm']) {
  lacks('html', selector);
}
for (const forbidden of ['getRealDeviceDiagnosticReport', 'runQ169FinalSelfTestCourt', 'getRuntimeSmokeEvidenceReport', 'COURT_SINGLE_SOURCE']) {
  lacks('bridge', forbidden);
}

if (failures.length) {
  console.error('MATHLIVE_PRODUCTION_HTML_FINALIZATION_Q185_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_PRODUCTION_HTML_FINALIZATION_Q185_PACKAGE_READY_BUT_FLUTTER_DEVICE_EVIDENCE_REQUIRED');
