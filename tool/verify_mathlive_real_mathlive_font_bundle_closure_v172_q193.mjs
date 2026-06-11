#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

import { maybeRunQ204R3PreservedVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
maybeRunQ204R3PreservedVerifier({ verifier: 'tool/verify_mathlive_real_mathlive_font_bundle_closure_v172_q193.mjs', preservedPhase: 'verify_mathlive_real_mathlive_font_bundle_closure_v172_q193' });

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (msg) => { console.error(`Q193_REAL_MATHLIVE_FONT_BUNDLE_CLOSURE_FAIL: ${msg}`); process.exit(1); };
const must = (p, s) => { if (!exists(p) || !read(p).includes(s)) fail(`${p} missing ${s}`); };

const files = {
  policy: 'lib/features/mathlive/mathlive_real_mathlive_font_bundle_closure_policy.dart',
  surface: 'lib/features/mathlive/mathlive_main_editor_surface.dart',
  html: 'assets/mathlive/main_editor_prod.html',
  manifest: 'assets/mathlive/manifest.json',
  runtimeManifest: 'assets/mathlive/vendor/mathlive/runtime_manifest.json',
  fontsCss: 'assets/mathlive/vendor/mathlive/mathlive-fonts.css',
  evidence: 'docs/evidence/V172_Q193_REQUIRED_MATHLIVE_FONT_FILES.json',
};
for (const p of Object.values(files)) if (!exists(p)) fail(`missing required file ${p}`);

must(files.policy, "phase = 'V172-Q193'");
must(files.policy, 'fakeFontBundleClosureClaimAllowed = false');
must(files.surface, "import 'mathlive_real_mathlive_font_bundle_closure_policy.dart';");
const productionSurfacePath = 'lib/features/mathlive/mathlive_production_editor_surface.dart';
const combinedSurface = read(files.surface) + '\n' + (exists(productionSurfacePath) ? read(productionSurfacePath) : '');
if (!combinedSurface.includes('MathLiveOfficialFontBundleIngestionPolicy.phase')) fail('production implementation missing Q196 font phase marker');
if (!combinedSurface.includes('_q196ProductionCssWithOfficialFontDataUrls')) fail('production implementation missing Q196 font data URL helper');
must(files.html, 'data-mathpro-official-font-bundle-closure="V172-Q196"');

const fontRefs = [...read(files.fontsCss).matchAll(/url\(fonts\/([^\)]+\.woff2)\)/g)].map((m) => m[1]);
const uniqueFonts = [...new Set(fontRefs)].sort();
if (uniqueFonts.length !== 20) fail(`expected 20 official MathLive font refs, found ${uniqueFonts.length}`);
const presentFonts = uniqueFonts.filter((f) => exists(`assets/mathlive/vendor/mathlive/fonts/${f}`));

const manifest = JSON.parse(read(files.manifest));
const latest = manifest.latestProductionPhase;
const q196Resolved = ['V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(latest);
const q = manifest.v172Q193RealMathLiveFontBundleClosure;
if (!q) fail('manifest missing Q193 envelope');
if (q.fakeFontBundleClosureClaimAllowed !== false) fail('manifest allows fake font closure claim');
if (q.productionMayReferenceMissingFontFiles !== false) fail('manifest allows production missing font references');
if (q196Resolved) {
  if (presentFonts.length !== 20) fail(`Q196 successor must bundle 20 official fonts, found ${presentFonts.length}`);
  if (q.closureStatus !== 'RESOLVED_BY_Q196_OFFICIAL_FONT_BUNDLE_INGESTION') fail('Q193 status must be resolved by Q196 successor');
  if (q.officialFontFilesBundled !== true || q.presentOfficialFontCount !== 20) fail('Q193 successor font count mismatch');
  if (!manifest.v172Q196OfficialMathLiveFontBundleIngestion) fail('Q196 successor envelope missing');
} else {
  if (!['V172-Q193-REAL-MATHLIVE-FONT-BUNDLE-CLOSURE','V172-Q194-PHYSICAL-LEGACY-CLEANUP','V172-Q195-FINAL-STATIC-RELEASE-FREEZE', 'V172-Q196-OFFICIAL-MATHLIVE-FONT-BUNDLE-INGESTION', 'V172-Q197-PRODUCTION-SURFACE-FILE-SEPARATION', 'V172-Q198-LEGACY-MARKER-POLICY-VERIFIER-CLEANUP', 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION', 'V172-Q200-PRODUCTION-NO-FREEZE-UI-CONTRACT-FINALIZATION', 'V172-Q201-PRODUCTION-CARET-FOCUS-SLOT-FINALIZATION', 'V172-Q202-GRAPH-HISTORY-SOLUTION-PRODUCTION-STATE-FINALIZATION', 'V172-Q203-FINAL-STATIC-PRODUCTION-FREEZE', 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE', 'V172-Q204R1-REAL-DEVICE-EVIDENCE-INTAKE-ANALYZE-TEST-HYGIENE'].includes(latest)) fail('manifest latestProductionPhase is not Q193/Q194/Q195/Q196 successor');
  if (presentFonts.length !== 0) fail(`pre-Q196 no-fake gate expected no bundled official fonts, found ${presentFonts.length}`);
  if (q.closureStatus !== 'BLOCKED_OFFICIAL_FONT_FILES_ABSENT') fail('Q193 closure status must be blocked before Q196');
  if (q.officialFontFilesBundled !== false) fail('manifest falsely claims official fonts bundled before Q196');
}

const runtime = JSON.parse(read(files.runtimeManifest));
if (q196Resolved) {
  if (runtime.fontFilesBundledInPackage !== true || runtime.copiedFontsDirectory !== true) fail('runtime manifest must mark Q196 fonts bundled');
  if (runtime.q196OfficialFontBundleIngestionStatus !== 'CLOSED_OFFICIAL_FONT_FILES_PRESENT') fail('runtime manifest Q196 status mismatch');
} else {
  if (runtime.fontFilesBundledInPackage !== false || runtime.copiedFontsDirectory !== false) fail('runtime manifest falsely claims font files bundled before Q196');
}

const evidence = JSON.parse(read(files.evidence));
if (q196Resolved) {
  if (evidence.presentFontCount !== 20 || evidence.officialFontFilesBundled !== true) fail('Q193 evidence must record Q196 font resolution');
} else {
  if (evidence.presentFontCount !== 0) fail('Q193 evidence should be blocked before Q196');
}

console.log(q196Resolved
  ? 'MATHLIVE_REAL_FONT_BUNDLE_CLOSURE_Q193_RESOLVED_BY_Q196_OFFICIAL_FONT_FILES_PRESENT'
  : 'MATHLIVE_REAL_FONT_BUNDLE_CLOSURE_Q193_BLOCKED_UNTIL_OFFICIAL_FONT_FILES_PRESENT_STATIC_TRUTH_READY');
