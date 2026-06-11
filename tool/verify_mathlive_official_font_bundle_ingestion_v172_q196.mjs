#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_official_font_bundle_ingestion_v172_q196.mjs', preservedPhase: 'verify_mathlive_official_font_bundle_ingestion_v172_q196' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`Q196_OFFICIAL_FONT_BUNDLE_INGESTION_FAIL: ${m}`); process.exit(1); };
const must = (p, s) => { if (!exists(p) || !read(p).includes(s)) fail(`${p} missing ${s}`); };
const sha256 = (p) => crypto.createHash('sha256').update(fs.readFileSync(path.join(root, p))).digest('hex');

const required = [
  'lib/features/mathlive/mathlive_official_font_bundle_ingestion_policy.dart',
  'test/v172_q196_official_font_bundle_ingestion_test.dart',
  'tool/verify_mathlive_official_font_bundle_ingestion_v172_q196.mjs',
  'docs/evidence/V172_Q196_OFFICIAL_FONT_BUNDLE_INGESTION_EVIDENCE.json',
  'docs/audit/V172_Q196_OFFICIAL_FONT_BUNDLE_INGESTION_AUDIT_REPORT.md',
  'docs/audit/V172_Q196_OFFICIAL_FONT_BUNDLE_INGESTION_CHANGED_FILES_MANIFEST.md',
  'docs/audit/V172_Q196_PROTECTED_FILE_HASH_MANIFEST.md',
  'assets/mathlive/manifest.json',
  'assets/mathlive/vendor/mathlive/runtime_manifest.json',
  'assets/mathlive/main_editor_prod.html',
  'assets/mathlive/vendor/mathlive/mathlive-fonts.css',
  'assets/mathlive/vendor/mathlive/mathlive-static.css',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'pubspec.yaml',
  'README.md',
];
for (const p of required) if (!exists(p)) fail(`missing required file ${p}`);

const fontsCss = read('assets/mathlive/vendor/mathlive/mathlive-fonts.css');
const requiredFontNames = [...new Set([...fontsCss.matchAll(/url\(fonts\/([^\)]+\.woff2)\)/g)].map((m) => m[1]))].sort();
if (requiredFontNames.length !== 20) fail(`expected 20 required official font refs, found ${requiredFontNames.length}`);
const fontDir = 'assets/mathlive/vendor/mathlive/fonts';
if (!exists(fontDir)) fail('missing official fonts directory');
const bundled = fs.readdirSync(path.join(root, fontDir)).filter((f) => f.endsWith('.woff2')).sort();
if (bundled.length !== 20) fail(`expected 20 bundled official woff2 files, found ${bundled.length}`);
for (const name of requiredFontNames) {
  const p = `${fontDir}/${name}`;
  if (!exists(p)) fail(`missing official font file ${p}`);
  const size = fs.statSync(path.join(root, p)).size;
  if (size < 1000) fail(`font file too small/fake: ${p} (${size} bytes)`);
}

must('lib/features/mathlive/mathlive_official_font_bundle_ingestion_policy.dart', "phase = 'V172-Q196'");
must('lib/features/mathlive/mathlive_official_font_bundle_ingestion_policy.dart', 'officialFontFilesBundled = true');
must('lib/features/mathlive/mathlive_official_font_bundle_ingestion_policy.dart', 'productionInlineCssEmbedsOfficialFontDataUrls = true');
must('lib/features/mathlive/mathlive_official_font_bundle_ingestion_policy.dart', 'fakeFontBundleClosureAllowed = false');
must('lib/features/mathlive/mathlive_main_editor_surface.dart', "import 'mathlive_official_font_bundle_ingestion_policy.dart';");
const productionSurfaceFile = 'lib/features/mathlive/mathlive_production_editor_surface.dart';
const combinedSurface = read('lib/features/mathlive/mathlive_main_editor_surface.dart') + '\n' + (exists(productionSurfaceFile) ? read(productionSurfaceFile) : '');
if (!combinedSurface.includes('_q196ProductionCssWithOfficialFontDataUrls')) fail('production implementation missing Q196 CSS data URL helper');
if (!combinedSurface.includes('base64Encode(data)')) fail('production implementation missing font base64 embedding');
if (!combinedSurface.includes('url(data:font/woff2;base64,')) fail('production implementation missing font data URL marker');
if (!combinedSurface.includes('MathLiveOfficialFontBundleIngestionPolicy.requiredOfficialFontFiles')) fail('production implementation missing official font list usage');
if (!combinedSurface.includes("'officialFontBundleIngestionPhase': MathLiveOfficialFontBundleIngestionPolicy.phase")) fail('production implementation missing Q196 payload phase marker');
if (!combinedSurface.includes("'officialFontFilesBundled': MathLiveOfficialFontBundleIngestionPolicy.officialFontFilesBundled")) fail('production implementation missing officialFontFilesBundled payload marker');
must('assets/mathlive/main_editor_prod.html', 'data-mathpro-official-font-bundle-closure="V172-Q196"');
must('assets/mathlive/main_editor_prod.html', 'data-mathpro-local-font-files-bundled="true"');
must('assets/mathlive/main_editor_prod.html', 'data-mathpro-official-font-data-urls="true"');
must('pubspec.yaml', 'assets/mathlive/vendor/mathlive/fonts/');

const surface = combinedSurface;
const productionStart = surface.indexOf('class _MathLiveProductionEditorSurfaceState');
if (productionStart < 0) fail('production class missing');
const production = surface.slice(productionStart);
if (production.includes('runJavaScriptReturningResult')) fail('production class must not use runJavaScriptReturningResult');
if (!production.includes('_q196ProductionCssWithOfficialFontDataUrls')) fail('production class missing Q196 CSS embedding helper');
if (!production.includes("rootBundle.loadString(MathLiveProductionEditorSurface.fontsCssAssetPath)")) fail('production class must still load official fonts CSS');
if (!production.includes("rootBundle.loadString(MathLiveProductionEditorSurface.staticCssAssetPath)")) fail('production class must still load official static CSS');

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
if (!['V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(manifest.latestProductionPhase)) fail('latestProductionPhase must be Q196 or verified Q197/Q198/Q199 successor');
const q = manifest.v172Q196OfficialMathLiveFontBundleIngestion;
if (!q) fail('manifest missing Q196 envelope');
if (q.phase !== 'V172-Q196') fail('manifest Q196 phase mismatch');
if (q.officialFontFilesBundled !== true) fail('manifest must mark officialFontFilesBundled true');
if (q.productionInlineCssEmbedsOfficialFontDataUrls !== true) fail('manifest must mark data URL embedding true');
if (q.productionMayReferenceMissingFontFiles !== false) fail('manifest must forbid missing font refs');
if (q.fakeFontBundleClosureAllowed !== false) fail('manifest must forbid fake font closure');
if (q.requiredOfficialFontCount !== 20 || q.bundledOfficialFontCount !== 20) fail('manifest font count mismatch');
if (!q.officialFontFileSha256) fail('manifest missing font sha256 map');
for (const name of requiredFontNames) {
  const p = `${fontDir}/${name}`;
  if (q.officialFontFileSha256[p] !== sha256(p)) fail(`manifest sha mismatch for ${p}`);
}
if (q.flutterAnalyzePassClaimedByAssistant !== false || q.androidRealDevicePassClaimed !== false || q.premiumSymbolVisualPassClaimed !== false) fail('manifest must not claim Flutter/Android/premium visual PASS');

const rt = JSON.parse(read('assets/mathlive/vendor/mathlive/runtime_manifest.json'));
if (rt.fontFilesBundledInPackage !== true || rt.copiedFontsDirectory !== true) fail('runtime manifest must mark fonts bundled');
if (rt.q196OfficialFontBundleIngestionStatus !== 'CLOSED_OFFICIAL_FONT_FILES_PRESENT') fail('runtime manifest Q196 status mismatch');
if (rt.q196RequiredOfficialFontCount !== 20 || rt.q196BundledOfficialFontCount !== 20) fail('runtime manifest Q196 count mismatch');
if (!rt.q196OfficialFontFileSha256) fail('runtime manifest missing Q196 font sha map');
for (const name of requiredFontNames) {
  if (rt.q196OfficialFontFileSha256[name] !== sha256(`${fontDir}/${name}`)) fail(`runtime manifest sha mismatch for ${name}`);
}

const evidence = JSON.parse(read('docs/evidence/V172_Q196_OFFICIAL_FONT_BUNDLE_INGESTION_EVIDENCE.json'));
if (evidence.requiredFontCount !== 20 || evidence.bundledFontCount !== 20) fail('Q196 evidence font count mismatch');
if (evidence.officialFontFilesBundled !== true || evidence.productionInlineCssEmbedsOfficialFontDataUrls !== true) fail('Q196 evidence truth mismatch');
if (!Array.isArray(evidence.files) || evidence.files.length !== 20) fail('Q196 evidence must list 20 font files');
for (const item of evidence.files) {
  if (!exists(item.path)) fail(`evidence path missing ${item.path}`);
  if (item.sha256 !== sha256(item.path)) fail(`evidence sha mismatch ${item.path}`);
}

const protectedFiles = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/workspace/template_tray.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/graph/graph_controller.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart',
  'lib/features/solution/solution_steps_panel.dart',
];
for (const p of protectedFiles) {
  if (!exists(p)) fail(`missing protected file ${p}`);
  const text = read(p);
  if (text.includes('V172-Q196') || text.includes('OfficialFontBundle')) fail(`protected file polluted by Q196 marker: ${p}`);
}

const forbiddenDirs = ['build', '.dart_tool', '.gradle', '.idea', 'node_modules', '__pycache__', '.pytest_cache'];
function walk(rel) {
  for (const entry of fs.readdirSync(path.join(root, rel), { withFileTypes: true })) {
    const p = path.join(rel, entry.name);
    if (entry.isDirectory()) {
      if (forbiddenDirs.includes(entry.name)) fail(`forbidden directory present: ${p}`);
      walk(p);
    } else if (entry.isFile()) {
      if (entry.name.endsWith('.pyc')) fail(`forbidden pyc present: ${p}`);
      if (entry.name.endsWith('.zip') || entry.name.endsWith('.apk') || entry.name.endsWith('.aab')) fail(`forbidden nested artifact present: ${p}`);
    }
  }
}
walk('.');

must('README.md', 'V172-Q196 — Official MathLive Font Bundle Ingestion');
must('docs/audit/V172_Q196_OFFICIAL_FONT_BUNDLE_INGESTION_AUDIT_REPORT.md', 'V172-Q196 Official MathLive Font Bundle Ingestion');
must('docs/audit/V172_Q196_OFFICIAL_FONT_BUNDLE_INGESTION_CHANGED_FILES_MANIFEST.md', 'V172-Q196 changed files');
must('docs/audit/V172_Q196_PROTECTED_FILE_HASH_MANIFEST.md', 'PROTECTED_HASH_UNCHANGED');

console.log('MATHLIVE_OFFICIAL_FONT_BUNDLE_INGESTION_Q196_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
