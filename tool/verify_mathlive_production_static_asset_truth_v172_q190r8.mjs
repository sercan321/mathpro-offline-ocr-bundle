#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_production_static_asset_truth_v172_q190r8.mjs', preservedPhase: 'verify_mathlive_production_static_asset_truth_v172_q190r8' });

const files = {
  policy: 'lib/features/mathlive/mathlive_production_static_asset_truth_policy.dart',
  test: 'test/v172_q190r8_production_static_asset_truth_test.dart',
  manifest: 'assets/mathlive/manifest.json',
  readme: 'README.md',
  prodSurface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  prodSurfacePart: 'lib/features/mathlive/mathlive_production_editor_surface.dart',
  prodHtml: 'assets/mathlive/main_editor_prod.html',
  fontsCss: 'assets/mathlive/vendor/mathlive/mathlive-fonts.css',
  staticCss: 'assets/mathlive/vendor/mathlive/mathlive-static.css',
  bridge: 'assets/mathlive/mathlive_prod_bridge.js',
  audit: 'docs/audit/V172_Q190R8_PRODUCTION_STATIC_ASSET_TRUTH_AUDIT_REPORT.md',
  changed: 'docs/audit/V172_Q190R8_PRODUCTION_STATIC_ASSET_TRUTH_CHANGED_FILES_MANIFEST.md',
  hash: 'docs/audit/V172_Q190R8_PROTECTED_FILE_HASH_MANIFEST.md',
  keyConfig: 'lib/features/keyboard/key_config.dart',
  mathKeyboard: 'lib/features/keyboard/math_keyboard.dart',
  bottomDock: 'lib/features/keyboard/bottom_dock.dart',
  premiumKey: 'lib/features/keyboard/premium_key.dart',
  longPressPopup: 'lib/features/keyboard/long_press_popup.dart',
  templateTray: 'lib/features/workspace/template_tray.dart',
  graphCard: 'lib/features/graph/graph_card.dart',
  graphController: 'lib/features/graph/graph_controller.dart',
  historyController: 'lib/features/history/history_controller.dart',
  historyPanel: 'lib/features/history/history_panel.dart',
  solutionPanel: 'lib/features/solution/solution_steps_panel.dart',
};

const failures = [];
const text = {};
for (const [name, file] of Object.entries(files)) {
  if (!fs.existsSync(file)) failures.push(`missing required file: ${file}`);
  else text[name] = fs.readFileSync(file, 'utf8');
}
text.prodSurfaceCombined = `${text.prodSurface || ''}\n${text.prodSurfacePart || ''}`;
const has = (name, needle) => {
  if (!text[name]?.includes(needle)) failures.push(`${files[name]} missing ${needle}`);
};
const lacks = (name, needle) => {
  if (text[name]?.includes(needle)) failures.push(`${files[name]} must not contain ${needle}`);
};
function sliceBetween(source, startNeedle, endNeedle) {
  const start = source.indexOf(startNeedle);
  if (start < 0) return '';
  if (!endNeedle) return source.slice(start);
  const end = source.indexOf(endNeedle, start + startNeedle.length);
  return source.slice(start, end < 0 ? source.length : end);
}
function stripFontFaces(css) {
  return css.replace(/@font-face\{[^{}]*\}/g, '').replace(':root{--ML__static-fonts:true}', ':root{--ML__static-fonts:false}');
}

has('policy', "phase = 'V172-Q190R8'");
has('policy', "baseline = 'V172-Q190R7_PRODUCTION_LEGACY_FALLBACK_ISOLATION'");
has('policy', "repairScope = 'production-static-font-asset-truth-closure'");
has('policy', 'productionRouteUsesMathLiveStaticCss = true');
has('policy', 'localMathLiveFontFilesBundled = false');
has('policy', 'stripMissingFontFaceRulesFromProductionInlineCss = true');
has('policy', 'productionInlineCssMayReferenceMissingFontFiles = false');
has('policy', 'premiumSymbolVisualPassClaimed = false');
has('policy', 'androidRealDevicePassClaimed = false');

has('test', 'MathLiveProductionStaticAssetTruthPolicy.phase');
has('test', '_q190r8ProductionCssWithoutMissingFontFaces');
has('test', 'productionInlineCssMayReferenceMissingFontFiles, isFalse');

has('prodSurfaceCombined', "import 'mathlive_production_static_asset_truth_policy.dart';");
has('prodSurfaceCombined', '_q190r8ProductionCssWithoutMissingFontFaces');
has('prodSurfaceCombined', "RegExp(r'@font-face\\{[^{}]*\\}'");
has('prodSurfaceCombined', '--mathpro-q190r8-font-files-bundled:false');
has('prodSurfaceCombined', '--mathpro-q193-official-font-bundle-closed:false');
has('prodSurfaceCombined', '--ML__static-fonts:false');
has('prodSurfaceCombined', 'MathLiveProductionStaticAssetTruthPolicy.phase');
has('prodSurfaceCombined', "rootBundle.loadString(MathLiveProductionEditorSurface.fontsCssAssetPath)");
has('prodSurfaceCombined', "rootBundle.loadString(MathLiveProductionEditorSurface.staticCssAssetPath)");
const surface = text.prodSurfaceCombined || '';
const legacyState = sliceBetween(surface, 'class _MathLiveMainEditorSurfaceState', 'class MathLiveProductionEditorSurface');
const productionState = sliceBetween(surface, 'class _MathLiveProductionEditorSurfaceState', 'class _MathLiveAppShellVisibleFallbackOverlay');
if (!legacyState && !surface.includes('legacyImplementationPhysicallyRemoved = true')) failures.push('legacy state absent before Q194 cleanup marker');
if (!productionState) failures.push('production _MathLiveProductionEditorSurfaceState slice not found');
if (legacyState.includes('q190r8ProductionCssWithoutMissingFontFaces')) failures.push('Q190R8 sanitizer must not be added to legacy state');
if (!productionState.includes('q190r8ProductionCssWithoutMissingFontFaces')) failures.push('Q190R8 sanitizer must be in production state');

has('prodHtml', 'V172-Q190R8: production static asset truth strips missing local @font-face');
has('prodHtml', '__MATHPRO_INLINE_MATHLIVE_FONTS_CSS__');
has('prodHtml', '__MATHPRO_INLINE_MATHLIVE_STATIC_CSS__');
has('bridge', 'NO_FREEZE_RUNTIME_INVARIANT_PHASE');

has('fontsCss', 'url(fonts/KaTeX_Main-Regular.woff2)');
has('staticCss', 'url(fonts/KaTeX_Main-Regular.woff2)');
const sanitizedFonts = stripFontFaces(text.fontsCss || '');
const sanitizedStatic = stripFontFaces(text.staticCss || '');
if (sanitizedFonts.includes('url(fonts/')) failures.push('sanitized mathlive-fonts.css must not reference missing fonts/ urls');
if (sanitizedStatic.includes('url(fonts/')) failures.push('sanitized mathlive-static.css must not reference missing fonts/ urls');
if (!sanitizedStatic.includes('.ML__frac-line')) failures.push('sanitized static CSS must keep MathLive structural CSS rules');
if (!sanitizedStatic.includes(':root{--ML__static-fonts:false}')) failures.push('sanitized static CSS must mark static font truth as false');

const fontFiles = [];
function walk(dir) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full);
    else if (/\.(woff2?|ttf|otf)$/i.test(entry.name)) fontFiles.push(full);
  }
}
walk('assets/mathlive');
const q196Successor = (text.manifest || '').includes('V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION');
if (!q196Successor && fontFiles.length !== 0) failures.push(`Q190R8 pre-Q196 expected no bundled local font files; found ${fontFiles.length}: ${fontFiles.join(', ')}`);
if (q196Successor && fontFiles.length !== 20) failures.push(`Q190R8 verified Q196 successor must bundle 20 official font files; found ${fontFiles.length}`);

has('manifest', 'v172Q190R8ProductionStaticAssetTruthClosure');
has('manifest', 'V172-Q190R8-PRODUCTION-STATIC-ASSET-TRUTH-CLOSURE');
has('manifest', 'localMathLiveFontFilesBundled');
has('manifest', 'productionInlineCssMayReferenceMissingFontFiles');
has('readme', 'V172-Q190R8 — Production Static Asset Truth Closure');
has('audit', 'V172-Q190R8 Production Static Asset Truth Closure Audit Report');
has('changed', 'V172-Q190R8 Production Static Asset Truth Closure Changed Files Manifest');
has('hash', 'V172-Q190R8 Protected File Hash Manifest');
has('hash', 'PROTECTED_HASH_UNCHANGED');

for (const protectedName of ['keyConfig', 'mathKeyboard', 'bottomDock', 'premiumKey', 'longPressPopup', 'templateTray', 'graphCard', 'graphController', 'historyController', 'historyPanel', 'solutionPanel']) {
  lacks(protectedName, 'V172-Q190R8');
  lacks(protectedName, 'Production Static Asset Truth');
}

try {
  const manifest = JSON.parse(text.manifest ?? '{}');
  const q190r8 = manifest.v172Q190R8ProductionStaticAssetTruthClosure;
  if (!q190r8) failures.push('manifest missing v172Q190R8ProductionStaticAssetTruthClosure object');
  else {
    if (q190r8.phase !== 'V172-Q190R8') failures.push('manifest q190r8 phase mismatch');
    if (q190r8.newFeatureAllowed !== false) failures.push('q190r8 must not allow new features');
    if (q190r8.localMathLiveFontFilesBundled !== false) failures.push('q190r8 must record local font files as not bundled');
    if (q190r8.stripMissingFontFaceRulesFromProductionInlineCss !== true) failures.push('q190r8 must strip missing font-face rules');
    if (q190r8.productionInlineCssMayReferenceMissingFontFiles !== false) failures.push('q190r8 must forbid production inline CSS missing font refs');
    if (q190r8.premiumSymbolVisualPassClaimed !== false) failures.push('q190r8 must not claim premium visual PASS');
    if (q190r8.androidRealDevicePassClaimed !== false) failures.push('q190r8 must not claim Android PASS');
  }
  if (![
    'V172-Q190R8-PRODUCTION-STATIC-ASSET-TRUTH-CLOSURE',
    'V172-Q190R9-STATIC-PRE-ANALYZE-HYGIENE-CLOSURE',
  , 'V172-Q191-RUNTIME-RENDER-CONTRACT-CLOSURE', 'V172-Q192-CARET-FOCUS-SLOT-CONTRACT-CLOSURE', 'V172-Q193-REAL-MATHLIVE-FONT-BUNDLE-CLOSURE', 'V172-Q194-PHYSICAL-LEGACY-CLEANUP', 'V172-Q195-FINAL-STATIC-RELEASE-FREEZE', 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) {
    failures.push('manifest latestProductionPhase must point at Q190R8 or a verified successor phase');
  }
} catch (error) {
  failures.push(`manifest JSON parse failed: ${error.message}`);
}

if (failures.length) {
  console.error('MATHLIVE_PRODUCTION_STATIC_ASSET_TRUTH_Q190R8_VERIFICATION_FAILED');
  for (const failure of failures) console.error(`- ${failure}`);
  process.exit(1);
}
console.log('MATHLIVE_PRODUCTION_STATIC_ASSET_TRUTH_Q190R8_STATIC_READY_BUT_FLUTTER_ANALYZE_AND_ANDROID_RETEST_REQUIRED');
