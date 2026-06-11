/// Single source of truth for MathPro package/release metadata used by tests
/// and audit code.  Keeping the active version here prevents older V-test files
/// from becoming stale every time the package advances.
class MathProPackageContract {
  const MathProPackageContract._();

  static const String phase = 'V172';
  static const String version = '0.172.112+172';
  static const String pubspecDescription =
      'MathPro Flutter phase 17 - V172-Q80 real device cursor court; final native SlotBox cursor court requires user-side flutter pub get/analyze/test/run evidence plus 19/20 real-device manual scenarios before any +95 cursor claim while protected UI surfaces remain unchanged; V172-Q80R1 static contract audit repair verifies Q78 in the static gate, closes stale Q62 nearest-fallback wording, and hard-blocks direct legacy nearest structural fallback; V172-Q80R2 repairs the real Flutter analyze syntax failure in this contract file and replaces invalid Q78 root enum usage while keeping protected UI surfaces untouched; V172-Q80R4 restores V172-B in-function linear caret continuation and V172-G scoped backspace source compatibility without changing protected UI surfaces. V172-Q81 freezes the failed custom cursor stack as LegacyFlutterSlotEditor fallback; V172-Q82 introduces the MathEditorAdapter contract; V172-Q83 adds an offline MathLive asset foundation without bundling a real MathLive runtime, without enabling MathLive virtual keyboard, without CDN/remote scripts, and without switching the main editor; V172-Q84 adds an isolated MathLive Lab Screen shell that loads only local assets, keeps the main editor unchanged, keeps MathLive virtual keyboard disabled, and makes no real MathLive cursor PASS claim; V172-Q85 adds a lab-only MathPro Keyboard to MathLive bridge command mapper without switching the main editor, without enabling MathLive virtual keyboard, and without mutating protected keyboard/UI surfaces; V172-Q86 adds a lab-only MathLive State Adapter that converts local bridge JSON/raw LaTeX into MathEditorOutputState without switching the main editor, without enabling MathLive virtual keyboard, and without mutating protected UI surfaces; V172-Q87 adds a lab-only MathLive Cursor Court / Runtime Proof Gate requiring official runtime evidence, real-device focus/cursor evidence, 20/22 manual scenarios, zero blocking failures, disabled MathLive virtual keyboard, no remote scripts, and unchanged protected UI surfaces before any MathLive cursor PASS or main-editor switch can be considered; V172-Q88 adds a rollback-safe Main Editor Engine Switch behind a disabled-by-default feature flag, keeps legacy as the active default, blocks MathLive main-editor selection until Q87 court evidence, official runtime, real-device lab proof, Graph/History/Solution adapter readiness, rollback availability, disabled virtual keyboard, no remote scripts, and unchanged protected UI surfaces are all proven; V172-Q89 adds a guarded MathLive Main Editor Integration policy without mounting MathLive in the main workspace, keeps legacy as default/rollback, and requires Q87/Q88 proof, official runtime, Graph/History/Solution adapter readiness, disabled virtual keyboard, no remote scripts, and unchanged protected UI surfaces before any main-editor MathLive mount; V172-Q90 adds Legacy Cursor Retirement Phase 1 as a non-deleting guard: legacy cursor files remain fallback/rollback, legacy overlay and hit-test bypass may only occur on a proven MathLive engine path, and protected UI surfaces remain locked; V172-Q90R1 adds the Official MathLive Runtime Bundle Intake Guard with a developer-side npm installer, local vendor slot, provenance manifest requirements, and no fake official runtime claim while MathLive remains lab-only and legacy stays default/rollback; V172-Q90R2 adds the MathLive Lab Real Runtime Smoke Test Gate: after the official local runtime is installed, the isolated lab must load the local mathlive.min.js, define and mount a math-field, pass keyboard bridge insert/delete/export smoke commands, keep MathLive virtual keyboard disabled, forbid remote scripts, keep protected UI surfaces unchanged, and still keep the main editor on legacy/default until later court evidence. V172-Q90R3 repairs the Windows-safe installer project-root path resolution; V172-Q90R4 adds an offline MathLive runtime install verification script and gate before Q90R2 Lab smoke may be considered; V172-Q90R5 adds a lab-only MathLive runtime smoke evidence harness and verifier; it exports/validates Q90R2 smoke evidence only after Q90R4 install verification, keeps MathLive out of the main editor, keeps legacy as default/rollback, and still forbids cursor PASS, Photomath/Wolfram claims, remote scripts, virtual keyboard, and legacy deletion without Q87 court evidence. V172-Q90R6 adds a lab-only MathLive smoke evidence authoring harness that converts a copied isolated-Lab bridge capture into the canonical Q90R5 evidence file only after Q90R4 runtime verification, while keeping MathLive out of the main editor, legacy as default/rollback, virtual keyboard disabled, remote scripts forbidden, and cursor/Photomath/Wolfram PASS claims blocked. V172-Q90R7 adds a Lab-only smoke evidence export/copy guard so the capture can be copied into tool/mathlive_lab_runtime_smoke_capture.json without app-side project writes, main editor switching, legacy deletion, remote scripts, virtual keyboard, or cursor PASS claims. V172-Q90R8 adds direct real-device MathLive Lab access through lib/main_mathlive_lab.dart without switching the main editor, mounting MathLive in the main workspace, deleting legacy cursor files, enabling MathLive virtual keyboard, allowing remote scripts, mutating protected UI surfaces, or claiming cursor PASS / Photomath / Wolfram level. V172-Q90R9 repairs Windows npm command resolution for the MathLive runtime installer, keeps npm intake blocked with a clear error when npm is not available, and cleans Lab metadata/analyzer string escapes while keeping MathLive lab-only, legacy as default/rollback, remote scripts forbidden, virtual keyboard disabled, and protected UI surfaces untouched; V172-Q91 adds MathLive Runtime Evidence Closure: the user real-device Lab report is recorded only as an input to evidence closure, but Q90R4 official runtime verification and the canonical Q90R5 Lab smoke evidence file must both verify before Q92 adapter hardening; MathLive remains lab-only, legacy stays default/rollback, Graph/History/Solution are not changed, protected UI surfaces remain locked, and cursor PASS / Photomath / Wolfram claims, main-editor switching, and legacy deletion remain blocked. V172-Q92-Q97 package-side transition batch adds guarded MathLive Graph/History/Solution adapter envelopes, an explicit main-editor flag contract, a real-device cursor court protocol, legacy main-path retirement and physical cleanup gates, and a post-cleanup regression court without switching the main editor by default, deleting legacy cursor files, touching protected UI surfaces, or claiming device PASS; V172-Q98 adds a single MathLive transition evidence orchestrator that aggregates contract, runtime, smoke-evidence, optional Flutter, and optional real-device court results into one report while still forbidding fake PASS, main-editor switching, protected-surface mutation, and legacy deletion; V172-Q99 adds MathLive Runtime Evidence Intake Closure: official runtime vendor files, Q90R4 runtime verification, canonical Q90R5 smoke evidence, and the Q98 court report are consolidated into one intake gate, while main-editor switching, MathLive default activation, legacy cursor deletion, protected UI mutation, and cursor PASS claims remain blocked; V172-Q100 adds Official MathLive Runtime Bundle Closure: a stricter offline bundle verifier checks the real local vendor files, npm/mathlive provenance, runtime manifest, sha256 file evidence, Q90R4 verification, disabled remote scripts, disabled virtual keyboard, unchanged protected surfaces, and still blocks fake runtime files, smoke PASS, main-editor switching, MathLive default activation, protected UI mutation, and legacy deletion; V172-Q101 adds Lab Smoke Evidence Closure: tool/verify_mathlive_lab_smoke_evidence_closure.mjs consolidates Q100 official runtime bundle closure, Q90R6 smoke evidence authoring, Q90R5 canonical smoke evidence verification, and the canonical evidence file before Q87 cursor court may run, while still blocking fake evidence, cursor PASS, main-editor switching, MathLive default activation, protected UI mutation, and legacy deletion; V172-Q102 adds MathLive State Normalization Hardening: MathLive Lab LaTeX/plainText/mathJson snapshots can be converted into deterministic MathPro Graph/History/Solution/evaluator candidate payloads, while Q101 evidence closure remains required before runtime binding, and main-editor switching, MathLive default activation, protected UI mutation, fake evidence, cursor PASS claims, and legacy cursor deletion remain blocked; V172-Q103 adds Graph Eligibility Adapter Real Binding: Q102 normalized MathLive expressions are routed into existing GraphEligibility-style package-side envelopes for explicit functions, y=f(x), verified numeric constant suggestions, and implicit-pending equations without mutating graph_card.dart, Graph/History/Solution UI, keyboard/MORE/long-press/AppShell surfaces, switching or mounting the main editor, enabling MathLive by default, faking constant graph results, claiming cursor PASS, or deleting legacy cursor files; V172-Q104 adds History Adapter Real Binding: Q102/Q103 MathLive normalized graph/evaluator candidates are wrapped into deterministic History entry envelopes with inputEngine mathlive while history_controller.dart, history_panel.dart, History UI, protected UI surfaces, main-editor switching, runtime History writes, fake evidence, cursor PASS claims, and legacy cursor deletion remain blocked; V172-Q105 adds Solution/Evaluator Candidate Adapter: Q102/Q103/Q104 MathLive normalized graph/history candidates are wrapped into deterministic Solution/Evaluator candidate envelopes with honest evaluator output, semantic unsupported reasons, and no fake solution steps, while solution_steps_panel.dart, Solution UI, protected UI surfaces, runtime Solution writes, main-editor switching, fake evidence, cursor PASS claims, and legacy cursor deletion remain blocked; V172-Q106 adds Main Workspace MathLive Mount Behind Internal Flag as a guard-only mount readiness contract: it keeps MathLive disabled by default, keeps legacyFlutterSlotEditor as default/rollback, requires Q93 flag contract, Q101 Lab smoke evidence closure, Q105 adapter readiness, official runtime verification, explicit internal flag, disabled virtual keyboard, no remote scripts, unchanged protected surfaces, and no AppShell/keyboard/Graph/History/Solution mutation before any runtime mount; it does not switch the default editor, mount MathLive in this package, claim cursor/device PASS, fake evidence, or delete legacy cursor files. V172-Q145 adds MathLive Premium Template Layout: large structural operators and named series/system templates stay real mathematical LaTeX while being compact/no-wrap for phone-sized MathLive main-editor rendering; Taylor/3 Denklem/n Denklem cannot fall back to raw text, MathLive badge/virtual keyboard remain hidden, protected keyboard/MORE/long-press/Graph/History/Solution surfaces remain locked, and Flutter/device/Photomath PASS remains unclaimed without user-side evidence.';
  static const String readmeTitle =
      'MathProFlutterPhase17 — V172-Q53 Integral Root Fraction Function Role Geometry Repair | V172-Q53R1 Real Flutter Log Repair | V172-Q53R2 Real Flutter Log and Stale-Version Guard Repair | V172-Q53R3 Real Flutter Log Metadata Repair | V172-Q54 Existing Cursor Engine Reconciliation | V172-Q55 Single SlotGeometryBundle Authority | V172-Q56 Structural Intent Resolver | V172-Q57 Active Empty Slot Leading-Rail Finalizer | V172-Q58 Integral Cursor Specialization | V172-Q59 Fraction Function Root Log Specialization | V172-Q60 Structural Edit Transaction Engine | V172-Q61 Cursor Golden Geometry Court | V172-Q62 Synthetic Tap Intent Matrix | V172-Q63 Structural Edit Transaction Stress Test | V172-Q64 Long Expression Pan Nested Cursor Stability | V172-Q65 Real Device Cursor Checkpoint Protocol | V172-Q65R1 Real Flutter Log Repair | V172-Q65R2 Stale Generic Zip Guard Repair | V172-Q65R3 Integral Fallback Boundary Repair | V172-Q71 Native SlotBox Input Surface Foundation | V172-Q72 Native SlotBox Painter | V172-Q73 Native SlotBox Hit-Test Engine | V172-Q74 Native Exclusive |□ Caret Renderer | V172-Q75 Native Structural Edit Transaction Binding | V172-Q76 Native Input Surface Integration | V172-Q77 Integral Native SlotBox Specialization | V172-Q78 Fraction Function Root Log Native SlotBox Specialization | V172-Q79 Nested Long Expression Pan Stability | V172-Q80 Real Device Cursor Court | V172-Q80R1 Static Contract Audit Repair | V172-Q80R2 Real Flutter Analyze Repair | V172-Q81 Legacy Cursor Freeze | V172-Q82 MathEditorAdapter Contract | V172-Q83 Offline MathLive Asset Foundation | V172-Q84 MathLive Lab Screen | V172-Q85 MathPro Keyboard to MathLive Bridge | V172-Q86 MathLive State Adapter | V172-Q87 MathLive Cursor Court | V172-Q88 Main Editor Engine Switch | V172-Q89 MathLive Main Editor Integration Guard | V172-Q90 Legacy Cursor Retirement Phase 1 Guard | V172-Q90R1 Official MathLive Runtime Bundle Intake Guard | V172-Q90R2 MathLive Lab Runtime Smoke Gate | V172-Q90R3 Windows MathLive Runtime Installer Path Repair | V172-Q90R4 MathLive Runtime Install Verification | V172-Q90R5 MathLive Lab Runtime Smoke Evidence Harness | V172-Q90R6 MathLive Lab Smoke Evidence Authoring Harness | V172-Q90R7 MathLive Lab Smoke Evidence Export Guard | V172-Q90R8 MathLive Lab Real Device Access Guard | V172-Q90R9 Windows NPM Command Resolution Repair | V172-Q91 MathLive Runtime Evidence Closure | V172-Q92 MathLive GHS Adapter | V172-Q93 MathLive Main Editor Flag | V172-Q94 Real Device MathLive Cursor Court | V172-Q95 Legacy Main Path Retirement | V172-Q96 Legacy Physical Cleanup Guard | V172-Q97 Post Cleanup Regression Court | V172-Q98 MathLive Evidence Orchestrator | V172-Q99 MathLive Runtime Evidence Intake | V172-Q100 Official Runtime Bundle Closure | V172-Q101 Lab Smoke Evidence Closure | V172-Q102 MathLive State Normalization Hardening | V172-Q103 Graph Eligibility Adapter Real Binding | V172-Q104 History Adapter Real Binding | V172-Q105 Solution/Evaluator Candidate Adapter | V172-Q109 Main Editor Switch Conditional Activation';
  static const String title = readmeTitle;
  static const String auditTitle = 'V172-Q61 Cursor Golden Geometry Court | V172-Q62 Synthetic Tap Intent Matrix | V172-Q63 Structural Edit Transaction Stress Test | V172-Q64 Long Expression Pan Nested Cursor Stability | V172-Q65 Real Device Cursor Checkpoint Protocol | V172-Q65R1 Real Flutter Log Repair | V172-Q65R2 Stale Generic Zip Guard Repair | V172-Q65R3 Integral Fallback Boundary Repair | V172-Q71 Native SlotBox Input Surface Foundation | V172-Q72 Native SlotBox Painter | V172-Q73 Native SlotBox Hit-Test Engine | V172-Q74 Native Exclusive |□ Caret Renderer | V172-Q75 Native Structural Edit Transaction Binding | V172-Q76 Native Input Surface Integration | V172-Q77 Integral Native SlotBox Specialization | V172-Q78 Fraction Function Root Log Native SlotBox Specialization | V172-Q79 Nested Long Expression Pan Stability | V172-Q80 Real Device Cursor Court | V172-Q80R1 Static Contract Audit Repair Closure | V172-Q80R2 Real Flutter Analyze Repair | V172-Q81 Legacy Cursor Freeze | V172-Q82 MathEditorAdapter Contract | V172-Q83 Offline MathLive Asset Foundation | V172-Q84 MathLive Lab Screen | V172-Q85 MathPro Keyboard to MathLive Bridge | V172-Q86 MathLive State Adapter | V172-Q87 MathLive Cursor Court | V172-Q88 Main Editor Engine Switch | V172-Q89 MathLive Main Editor Integration Guard | V172-Q90 Legacy Cursor Retirement Phase 1 Guard | V172-Q90R1 Official MathLive Runtime Bundle Intake Guard | V172-Q90R2 MathLive Lab Runtime Smoke Gate | V172-Q90R3 Windows MathLive Runtime Installer Path Repair | V172-Q90R4 MathLive Runtime Install Verification | V172-Q90R5 MathLive Lab Runtime Smoke Evidence Harness | V172-Q90R6 MathLive Lab Smoke Evidence Authoring Harness | V172-Q90R7 MathLive Lab Smoke Evidence Export Guard | V172-Q90R8 MathLive Lab Real Device Access Guard | V172-Q91 MathLive Runtime Evidence Closure | V172-Q92 MathLive GHS Adapter | V172-Q93 MathLive Main Editor Flag | V172-Q94 Real Device MathLive Cursor Court | V172-Q95 Legacy Main Path Retirement | V172-Q96 Legacy Physical Cleanup Guard | V172-Q97 Post Cleanup Regression Court | V172-Q98 MathLive Evidence Orchestrator | V172-Q99 MathLive Runtime Evidence Intake | V172-Q100 Official Runtime Bundle Closure | V172-Q101 Lab Smoke Evidence Closure | V172-Q102 MathLive State Normalization Hardening | V172-Q103 Graph Eligibility Adapter Real Binding | V172-Q104 History Adapter Real Binding | V172-Q105 Solution/Evaluator Candidate Adapter | V172-Q109 Main Editor Switch Conditional Activation';
  static const String nextPhase =
      'V172-Q114 Release Freeze / Clean Full ZIP Guard remains active as guard-only; Q81 Legacy Cursor Freeze lineage and Native SlotBox Painter lineage remain preserved for stale metadata tests; V172-Q92 Graph / History / Solution Adapter Hardening remains the post-Q91 adapter marker; external real-device/runtime evidence intake remains required before any release PASS or physical cleanup claim.';

  static const String cursorLineageVersions =
      '0.172.61+172 0.172.62+172 0.172.63+172 0.172.64+172 0.172.65+172 0.172.66+172 0.172.67+172 0.172.68+172 0.172.69+172 0.172.70+172 0.172.71+172 0.172.72+172 0.172.73+172 0.172.74+172 0.172.75+172 0.172.76+172 0.172.77+172 0.172.78+172 0.172.79+172 0.172.80+172 0.172.81+172 0.172.82+172 0.172.83+172 0.172.84+172 0.172.85+172 0.172.86+172 0.172.87+172 0.172.88+172 0.172.89+172 0.172.90+172 0.172.91+172 0.172.92+172 0.172.93+172 0.172.94+172 0.172.95+172 0.172.96+172 0.172.97+172 0.172.98+172 0.172.99+172 0.172.100+172 0.172.101+172 0.172.102+172 0.172.103+172 0.172.104+172 0.172.105+172 0.172.106+172 0.172.107+172 0.172.108+172 0.172.109+172 0.172.110+172 0.172.111+172 0.172.112+172 0.172.112+172';
  static const String cursorLineageTitles =
      'V172-Q34 Deterministic Slot Geometry Registry | V172-Q35 Placeholder-Safe Cursor Engine | V172-Q36 Role-Based Cursor Size Engine | V172-Q37 Fraction Precision Engine | V172-Q38 Script Precision Engine | V172-Q39 Log Root Precision Engine | V172-Q40 Digit-Level Caret Stops | V172-Q41 Nested Expression Depth Engine | V172-Q42 Drag-to-Move Cursor Stability | V172-Q43 Structural Insert/Delete Safety | V172-Q44 Renderer-Sync Upgrade | V172-Q45 Real Device Pixel QA Court | V172-Q46 Renderer Slot Identity Prototype | V172-Q47 True Glyph-Level Caret Stops | V172-Q48 Native LayoutBox Cursor Layer | V172-Q48R1 Test Contract Repair | V172-Q48R2 Verifier Hardening | V172-Q48R3 Cursor Integration Evidence | V172-Q49 Structural Cursor Release Hardening | V172-Q50 P6-Locked +95 Cursor Candidate Freeze | V172-Q50R1 Real Flutter Log Repair | V172-Q50R2 Stale Package Guard Repair | V172-Q51 Structural Placeholder Restoration Repair | V172-Q52 Active Empty Slot Leading-Rail Caret Repair | V172-Q53 Integral Root Fraction Function Role Geometry Repair | V172-Q53R1 Real Flutter Log Repair | V172-Q53R2 Real Flutter Log and Stale-Version Guard Repair | V172-Q53R3 Real Flutter Log Metadata Repair | V172-Q54 Existing Cursor Engine Reconciliation | V172-Q55 Single SlotGeometryBundle Authority | V172-Q56 Structural Intent Resolver | V172-Q57 Active Empty Slot Leading-Rail Finalizer | V172-Q58 Integral Cursor Specialization | V172-Q59 Fraction Function Root Log Specialization | V172-Q60 Structural Edit Transaction Engine | V172-Q61 Cursor Golden Geometry Court | V172-Q62 Synthetic Tap Intent Matrix | V172-Q63 Structural Edit Transaction Stress Test | V172-Q64 Long Expression Pan Nested Cursor Stability | V172-Q65 Real Device Cursor Checkpoint Protocol | V172-Q65R1 Real Flutter Log Repair | V172-Q65R2 Stale Generic Zip Guard Repair | V172-Q65R3 Integral Fallback Boundary Repair | V172-Q71 Native SlotBox Input Surface Foundation | V172-Q72 Native SlotBox Painter | V172-Q73 Native SlotBox Hit-Test Engine | V172-Q74 Native Exclusive |□ Caret Renderer | V172-Q75 Native Structural Edit Transaction Binding | V172-Q76 Native Input Surface Integration | V172-Q77 Integral Native SlotBox Specialization | V172-Q78 Fraction Function Root Log Native SlotBox Specialization | V172-Q79 Nested Long Expression Pan Stability | V172-Q80 Real Device Cursor Court | V172-Q80R1 Static Contract Audit Repair | V172-Q80R2 Real Flutter Analyze Repair | V172-Q81 Legacy Cursor Freeze | V172-Q82 MathEditorAdapter Contract | V172-Q83 Offline MathLive Asset Foundation | V172-Q84 MathLive Lab Screen | V172-Q85 MathPro Keyboard to MathLive Bridge | V172-Q86 MathLive State Adapter | V172-Q87 MathLive Cursor Court | V172-Q88 Main Editor Engine Switch | V172-Q89 MathLive Main Editor Integration Guard | V172-Q90 Legacy Cursor Retirement Phase 1 Guard | V172-Q90R1 Official MathLive Runtime Bundle Intake Guard | V172-Q90R2 MathLive Lab Runtime Smoke Gate | V172-Q90R3 Windows MathLive Runtime Installer Path Repair | V172-Q90R4 MathLive Runtime Install Verification | V172-Q90R5 MathLive Lab Runtime Smoke Evidence Harness | V172-Q90R6 MathLive Lab Smoke Evidence Authoring Harness | V172-Q90R7 MathLive Lab Smoke Evidence Export Guard | V172-Q90R8 MathLive Lab Real Device Access Guard | V172-Q90R9 Windows NPM Command Resolution Repair | V172-Q91 MathLive Runtime Evidence Closure | V172-Q92 MathLive GHS Adapter | V172-Q93 MathLive Main Editor Flag | V172-Q94 Real Device MathLive Cursor Court | V172-Q95 Legacy Main Path Retirement | V172-Q96 Legacy Physical Cleanup Guard | V172-Q97 Post Cleanup Regression Court | V172-Q98 MathLive Evidence Orchestrator | V172-Q99 MathLive Runtime Evidence Intake | V172-Q100 Official Runtime Bundle Closure | V172-Q101 Lab Smoke Evidence Closure | V172-Q102 MathLive State Normalization Hardening | V172-Q103 Graph Eligibility Adapter Real Binding | V172-Q104 History Adapter Real Binding | V172-Q105 Solution/Evaluator Candidate Adapter | V172-Q109 Main Editor Switch Conditional Activation';


  static const List<String> q50CoreCursorCandidateExpressions = <String>[
    '√□',
    'x^□',
    'x_□',
    'log_□(□)',
    '9/6',
    '12/345',
    '123456789',
    'cos(99666655)',
    'sin(300)',
    'ln(123456)',
    'ln(ln(8))',
    'sin(cos(300))',
    '√(sin(x)+log₂(500))',
    'sin(300)+cos(400)+log₂(500)+√(600)',
  ];

  static const String q50EvidenceRule =
      'Q50 freezes a +95 cursor candidate matrix only; Flutter analyze/test and real-device Pixel QA evidence are required before any +95 final PASS claim.';


  static const List<String> q51ProtectedBrokenFinalForms = <String>[
    'sin()',
    'cos()',
    'tan()',
    'ln()',
    'log()',
    '9⁄',
    '9/',
    '⁄6',
    '/6',
    '√()',
    '∫(□)d',
  ];

  static const String q51RepairRule =
      'Q51 restores empty structural slots to □ after deletion and forbids half templates such as sin(), 9⁄, √(), and d without a differential slot. Q52 owns the |□ leading-rail caret optical finalization.';



  static const String q52CaretRule =
      'Q52 active empty structural slots render the caret as |□: the caret stays on the leading rail immediately before the placeholder, never inside the box and never as the default □| exit rail. Q53 preserves that law and adds role-specific integral/root/fraction/function geometry polish so the caret uses the visible placeholder edge instead of a detached hit rectangle. Q54 reconciles hit-test and fallback behavior; Q57 finalizes painted empty-slot carets through SlotGeometryBundle leadingRailRect so |□ cannot drift into hitRect/linear fallback space; Q58 specializes integral upper/lower/body/differential rails including d|□ while real-device +95 remains unclaimed until Q62 device court evidence. Q59 applies the same structural-first pipe-box law to fraction/function/root/log families without touching protected P6 visual surfaces. Q64 adds long-expression pan/nested stability so viewport drag and nested cursor targets do not emit detached linear carets. Q65 defines the real-device cursor checkpoint protocol for accumulated Q54-Q64 courts while still refusing any +95 PASS claim without user-side evidence.';


  static const String q71NativeSlotBoxInputSurfaceRule =
      'Q71 makes native SlotBox geometry the active structural cursor selection authority: nearest structural fallback is disabled, legacy linear placeholder fallback is blocked when SlotGeometryBundle geometry exists, and empty slots preserve the exclusive |□ leading-caret law. Protected keyboard/UI/Graph/History/Solution surfaces remain locked.';

  static const String q72NativeSlotBoxPainterRule =
      'Q72 makes the painted editor caret/slot paint model use the same SlotGeometryBundle authority as hit-test: visualRect, placeholderRect, hitRect, leading/trailing rails and inner text rect come from one bundle. Visible slot boxes stay disabled by default; protected keyboard/UI/Graph/History/Solution surfaces remain locked; no real-device +95 PASS is claimed.';

  static const String q73NativeSlotBoxHitTestRule =
      "Q73 makes structural tap selection run through the native SlotBox hit-test engine: if SlotGeometryBundle geometry exists, a structural slot can be selected only by that slot's authoritative hitRect; nearest-distance structural fallback and visual-rect-only guessing remain disabled. Overlapping measured hitRects use deterministic role/depth/geometry tie-breaks. Protected keyboard/UI/Graph/History/Solution surfaces remain locked and no real-device +95 PASS is claimed.";



  static const String q74NativeExclusiveCaretRendererRule =
      'Q74 makes empty structural slots render through the native exclusive |□ caret renderer: the caret must come from the leading rail, must not overlap the placeholder, must not use hitRect/trailing rail/linear fallback, and protected keyboard/UI/Graph/History/Solution surfaces remain locked.';

  static const String q75NativeStructuralEditTransactionBindingRule =
      'Q75 binds structural edits to the active SlotBox id: insert/delete/replace operations stay scoped to the selected structural slot, eligible single-slot function/root/log/fraction payloads keep structural focus after the first character instead of exiting to detached linear caret, protected keyboard/UI/Graph/History/Solution surfaces remain locked, and no real-device +95 PASS is claimed.';

  static const String q76NativeInputSurfaceIntegrationRule =
      'Q76 integrates Q71-Q75 through one native input surface frame / single runtime frame: editor hit-test, legacy fallback suppression, visible slot overlay geometry, and structural edit transaction routing all share the same SlotGeometryBundle map. The keyboard, MORE, long-press popup, app shell, MathLabel, template tray, Solution, Graph, and History remain locked; no real-device +95 PASS is claimed.';

  static const String q77IntegralNativeSlotBoxSpecializationRule =
      'Q77 specializes the integral family inside the native SlotBox input surface: upper limit, lower limit, body, and differential d□ taps resolve through authoritative SlotGeometryBundle hitRects and deterministic native integral lanes; differential taps produce d|□ rather than body/linear fallback; protected keyboard/UI/Graph/History/Solution surfaces remain locked and no real-device +95 PASS is claimed.';


  static const String q78FractionFunctionRootLogNativeSlotBoxSpecializationRule =
      'Q78 specializes fraction/function/root/log families inside the native SlotBox input surface: numerator, denominator, function argument, root index, root body, log base, and log argument taps resolve through authoritative SlotGeometryBundle hitRects and deterministic native lanes; empty slots keep |□; protected keyboard/UI/Graph/History/Solution surfaces remain locked and no real-device +95 PASS is claimed.';

  static const String q79NestedLongExpressionPanStabilityRule =
      'Q79 stabilizes nested and long-expression cursor behavior inside the native SlotBox input surface: nested hit resolution prefers deepest measured SlotBoxes, pan sources cannot emit detached linear carets or random structural switches, active visibility targets use native caret rails, protected keyboard/UI/Graph/History/Solution surfaces remain locked, and no real-device +95 PASS is claimed.';

  static const Set<String> staleVersionMarkers = <String>{
    'version: 0.172.22+172',
    'version: 0.172.21+172',
    'version: 0.172.20+172',
    'version: 0.172.19+172',
    'version: 0.172.18+172',
    'version: 0.172.17+172',
    'version: 0.172.16+172',
    'version: 0.170.0+170',
    'version: 0.169.0+169',
    'version: 0.168.0+168',
    'version: 0.167.0+167',
    'version: 0.166.0+166',
    'version: 0.165.0+165',
    'version: 0.164.0+164',
    'version: 0.163.0+163',
    'version: 0.162.0+162',
    'version: 0.131.0+131',
    'version: 0.132.0+132',
    'version: 0.133.0+133',
    'version: 0.134.0+134',
    'version: 0.135.0+135',
    'version: 0.136.0+136',
    'version: 0.137.0+137',
    'version: 0.138.0+138',
    'version: 0.139.0+139',
    'version: 0.140.0+140',
    'version: 0.141.0+141',
    'version: 0.142.0+142',
    'version: 0.143.0+143',
    'version: 0.144.0+144',
    'version: 0.145.0+145',
    'version: 0.160.0+160',
    'version: 0.161.0+161',
    'version: 0.159.0+159',
    'version: 0.158.0+158',
    'version: 0.157.0+157',
    'version: 0.156.0+156',
    'version: 0.155.0+155',
    'version: 0.154.0+154',
    'version: 0.153.0+153',
    'version: 0.152.0+152',
    'version: 0.151.0+151',
    'version: 0.150.0+150',
    'version: 0.149.0+149',
    'version: 0.148.0+148',
    'version: 0.147.0+147',
    'version: 0.146.0+146',
    'version: 0.172.86+172',
    'version: 0.172.96+172',
    'version: 0.172.87+172',
    'version: 0.172.88+172',
    'version: 0.172.89+172',
    'version: 0.172.90+172',
    'version: 0.172.91+172',
    'version: 0.172.92+172',
    'version: 0.172.93+172',
    'version: 0.172.94+172',
    'version: 0.172.95+172',
    'version: 0.172.97+172',
    'version: 0.172.98+172',
    'version: 0.172.101+172',
    'version: 0.172.102+172',
    'version: 0.172.103+172',
    'version: 0.172.104+172',
    'version: 0.172.105+172',
  };
  static const String q53RoleGeometryRule =
      'Q53 repairs role-specific editor geometry for fraction numerator/denominator, function arguments, root/radicand slots, integral upper/lower/body/differential slots, log base, powers and subscripts while keeping Q52 |□ leading rail and all P6 protected visual surfaces locked.';

  static const String q54ExistingCursorEngineReconciliationRule =
      'Q54 preserves the existing MathPro cursor motor but reconciles it into a structural-first, fallback-safe path: slot interaction is separated from visible overlay painting, structural intent beats linear fallback inside template regions, and active empty slots continue to resolve as |□ leading rail. Real-device +95 remains unclaimed.';


  static const String q55SingleSlotGeometryBundleAuthorityRule =
      'Q55 makes SlotGeometryBundle the single cursor geometry authority: hitRect is only for selection, while active-empty caret uses leadingRailRect, filled slots use innerTextRect, and structural intent shares the same bundle without touching protected P6 visual surfaces or claiming real-device +95 PASS.';


  static const String q56StructuralIntentResolverRule =
      'Q56 resolves tap intent structural-first through SlotGeometryBundle: exact bundle hit, nearest structural hit, and template-region intent beat detached linear fallback, while empty slots preserve |□ and protected P6 visual surfaces remain untouched. Real-device +95 PASS remains unclaimed.';


  static const String q57ActiveEmptySlotLeadingRailFinalizerRule =
      'Q57 makes the painted active-empty-slot caret finalize from SlotGeometryBundle.leadingRailRect: empty structural slots render as |□, the caret must not enter the placeholder, must not drift to detached linear fallback space, and protected P6 visual surfaces remain untouched. Real-device +95 PASS remains unclaimed.';


  static const String q58IntegralCursorSpecializationRule =
      'Q58 specializes the existing MathPro cursor motor for integral upper/lower/body/differential slots: structural intent beats linear fallback inside the integral envelope, active empty integral slots preserve |□, differential targets render as d|□, and protected P6 visual surfaces remain untouched. Real-device +95 PASS remains unclaimed.';


  static const String q59FractionFunctionRootLogSpecializationRule =
      'Q59 specializes the existing MathPro cursor motor for fraction numerator/denominator, function arguments, root/radicand and log base/argument slots: structural intent beats linear fallback inside these core template envelopes, active empty slots preserve |□, and protected P6 visual surfaces remain untouched. Real-device +95 PASS remains unclaimed.';


  static const String q60StructuralEditTransactionEngineRule =
      'Q60 routes insert/delete/template edit results through a structural transaction normalizer: half templates such as 9/, /6, sin(), √(), log(), and a bare differential d cannot survive as final editor state; empty slots restore to □ while protected P6 visual surfaces remain untouched and real-device +95 PASS remains unclaimed.';


  static const String q61CursorGoldenGeometryCourtRule =
      'Q61 adds a Cursor Golden Geometry Court for core cursor roles: active-empty slots must use |□ leadingRailRect, the caret must not overlap or detach from placeholderRect, filled slots must stay inside innerTextRect, synthetic cursor confidence requires at least 19/20 correct decisions, protected P6 visual surfaces remain untouched, and real-device +95 PASS remains unclaimed.';


  static const String q62SyntheticTapIntentMatrixRule =
      'Q62 adds a Synthetic Tap Intent Matrix for core cursor roles: phone-like tap samples around exact hit areas, nearby rails, placeholder edges and template envelopes must resolve to the intended structural slot before linear fallback; each scenario requires at least 19/20 correct synthetic taps, protected P6 visual surfaces remain untouched, and real-device +95 PASS remains unclaimed.';


  static const String q63StructuralEditTransactionStressCourtRule =
      'Q63 adds a Structural Edit Transaction Stress Court: insert/delete/clear/replace/cut/paste/template transaction variants must normalize 20/20 attempts per scenario, forbid half-template final states such as 9/, /6, sin(), √(), log(), bare d and broken integral differentials, preserve protected P6 visual surfaces, and keep real-device +95 PASS unclaimed until the checkpoint court.';



  static const String q64LongExpressionPanNestedCursorStabilityRule =
      'Q64 adds a Long Expression / Pan / Nested Cursor Stability Court: long and nested expressions reserve drag for viewport pan, active structural targets stay visible through SlotGeometryBundle rails, tap-vs-pan conflict must not emit detached linear carets, core nested roles require at least 19/20 synthetic stability decisions, protected P6 visual surfaces remain untouched, and real-device +95 PASS remains unclaimed.';


  static const String q65RealDeviceCursorCheckpointProtocolRule =
      'Q65 adds a Real Device Cursor Checkpoint Protocol over the accumulated Q54-Q64 cursor courts: Flutter analyze/test logs, flutter run evidence, minimal phone screenshots/video for integral, fraction, function, root, log and long-expression cursor scenarios, and 19/20 core selection evidence are required before any +95 cursor PASS claim. The protocol itself preserves protected P6 visual surfaces and does not claim real-device PASS.';


  static const String q80RealDeviceCursorCourtRule =
      'Q80 is the real-device cursor court gate: the package itself does not claim Flutter/device/+95 PASS. Candidate review requires flutter pub get, flutter analyze, flutter test, flutter run -d 23106RN0DA evidence plus at least 19/20 manual real-device cursor scenarios and zero blocking failure modes such as detached linear caret, □| empty slot, wrong log/fraction/integral slot routing, or pan-induced slot jumps.';


  static const String q81LegacyCursorFreezeRule =
      'Q81 freezes the custom Flutter SlotBox cursor stack as LegacyFlutterSlotEditor fallback instead of deleting it; no new large Flutter cursor patch is the primary product direction, MathEditorAdapter and an offline MathLive Lab must precede any main-editor engine switch, MathLive virtual keyboard/CDN usage remain forbidden, and protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces remain locked.';


  static const String q82MathEditorAdapterContractRule =
      'Q82 introduces MathEditorAdapter as the engine-neutral contract between the frozen MathPro keyboard/MORE/long-press surfaces and either LegacyFlutterSlotEditorAdapter or a future MathLiveEditorAdapter; it does not switch the main editor and does not enable MathLive WebView runtime.';

  static const String q83OfflineMathLiveAssetFoundationRule =
      'Q83 declares local assets/mathlive/ bootstrap assets and pubspec asset registration for a future isolated MathLive Lab, while explicitly recording that a real MathLive runtime is not bundled yet, remote scripts/CDN are forbidden, MathLive virtual keyboard is disabled, protected UI surfaces are untouched, and the main editor cannot switch before Q84+ real-device lab evidence.';


  static const String q84MathLiveLabScreenRule =
      'Q84 creates an isolated MathLiveLabScreen shell that may load only assets/mathlive/index.html through a WebView on real devices, renders a static fallback in flutter tests, keeps the main editor on the legacy/fallback path, keeps MathLive virtual keyboard disabled, forbids CDN/remote scripts, preserves protected UI surfaces, and does not claim real MathLive cursor PASS because the official MathLive runtime is not bundled yet.';

  static const String q80r2RealFlutterAnalyzeRepairRule =
      'Q80R2 is a real user-log repair: it fixes the Dart syntax break caused by an unescaped apostrophe in q73NativeSlotBoxHitTestRule, replaces invalid MathNodeKind.root references with MathNodeKind.indexedRoot in Q78 tests, and removes an unused structural resolver helper warning without changing protected UI surfaces or claiming device PASS.';

  static const String q85MathProKeyboardToMathLiveBridgeRule =
      'Q85 adds a lab-only MathPro Keyboard to MathLive bridge: frozen MathPro key labels map to deterministic MathLive command payloads, executeMathProCommand is exposed only inside assets/mathlive/mathlive_bridge.js, MORE stays a MathPro tray command, ↵ remains a MathPro evaluate bridge, MathLive virtual keyboard stays disabled, the main editor still cannot switch, and protected UI/keyboard surfaces remain untouched.';

  static const String q86MathLiveStateAdapterRule =
      'Q86 adds a lab-only MathLive State Adapter: local bridge JSON or raw LaTeX is normalized into MathEditorOutputState for future Graph/History/Solution adapters, while the main editor stays on legacy fallback, MathLive virtual keyboard remains disabled, remote scripts remain forbidden, protected UI surfaces remain untouched, and real-device MathLive cursor PASS remains unclaimed.';

  static const String q87MathLiveCursorCourtRule =
      'Q87 adds a lab-only MathLive Cursor Court / Runtime Proof Gate: MathLive cannot become the main editor and no MathLive cursor PASS can be claimed until official runtime bundling, flutter analyze/test/run evidence, real-device lab focus, Q85 keyboard bridge, Q86 state adapter, disabled MathLive virtual keyboard, no remote scripts, unchanged protected UI surfaces, at least 20/22 manual cursor scenarios, and zero blocking failures are proven.';


  static const String q88MainEditorEngineSwitchRule =
      'Q88 adds a rollback-safe Main Editor Engine Switch behind a disabled-by-default feature flag: the legacy Flutter editor remains the default and fallback, MathLive cannot become the main editor unless Q87 cursor court evidence, official runtime bundling, real-device lab proof, Q85 keyboard bridge, Q86 state adapter, Graph/History/Solution adapter readiness, rollback flag availability, disabled MathLive virtual keyboard, no remote scripts, and unchanged protected UI surfaces are all proven.';



  static const String q89MathLiveMainEditorIntegrationRule =
      'Q89 adds the MathLive Main Editor Integration Guard: the package may prepare a passive integration shell, but MathLive is not mounted in the main workspace and legacy remains the default/rollback engine until Q87 cursor court, Q88 engine switch selection, official runtime bundling, Graph/History/Solution adapter readiness, rollback availability, disabled MathLive virtual keyboard, no remote scripts, and unchanged protected UI surfaces are all proven.';


  static const String q90LegacyCursorRetirementPhase1Rule =
      'Q90 adds Legacy Cursor Retirement Phase 1 as a non-deleting guard: legacy cursor files cannot be deleted, LegacyFlutterSlotEditor remains rollback/default unless a proven MathLive main-editor path is selected, and only the active MathLive path may bypass legacy overlay/hit-test while protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces remain locked.';


  static const String q90r1OfficialMathLiveRuntimeBundleIntakeRule =
      'Q90R1 adds the Official MathLive Runtime Bundle Intake Guard: the package prepares a local vendor slot and developer-side npm installer for the official MathLive runtime, but does not fake bundling mathlive.min.js, does not enable MathLive virtual keyboard, does not allow remote scripts/CDN, does not switch the main editor, and keeps legacy as default/rollback until real local runtime evidence and device court proof exist.';


  static const String q90r2MathLiveRuntimeSmokeRule =
      'Q90R2 adds the MathLive Lab Real Runtime Smoke Test Gate: after official local runtime intake, the isolated lab must load local vendor/mathlive/mathlive.min.js, define and mount a math-field, pass Q85 keyboard bridge insert/delete/export smoke commands, feed Q86 state adapter output, keep MathLive virtual keyboard disabled, forbid remote scripts/CDN, keep protected UI surfaces unchanged, and still block main-editor switch until later real-device cursor court proof.';


  static const String q90r3WindowsMathLiveRuntimeInstallerPathRepairRule =
      'Q90R3 repairs the Windows-safe MathLive runtime installer path handling by deriving projectRoot through fileURLToPath(import.meta.url), preventing C:\\C:\\... path duplication while keeping MathLive lab-only, legacy as default/rollback, remote scripts forbidden, and protected UI surfaces untouched.';

  static const String q90r4MathLiveRuntimeInstallVerificationRule =
      'Q90R4 adds MathLive Runtime Install Verification: tool/verify_mathlive_runtime.mjs validates the local npm MathLive vendor bundle, package.json, runtime_manifest.json, disabled remote scripts, disabled MathLive virtual keyboard, and protected-surface lock before Q90R2 Lab smoke may run; it still does not switch the main editor, delete legacy cursor files, or claim MathLive cursor PASS.';


  static const String q90r5MathLiveLabSmokeEvidenceRule =
      'Q90R5 adds MathLive Lab Runtime Smoke Evidence Harness: a captured Q90R2 Lab smoke report must be verified by tool/verify_mathlive_lab_smoke_evidence.mjs after Q90R4 install verification before Q87 cursor court can run; it keeps MathLive lab-only, legacy as default/rollback, main editor switch disabled, virtual keyboard disabled, remote scripts forbidden, protected UI surfaces locked, and forbids cursor PASS or Photomath/Wolfram claims.';


  static const String q90r6MathLiveLabSmokeEvidenceAuthoringRule =
      'Q90R6 adds the MathLive Lab Smoke Evidence Authoring Harness: tool/write_mathlive_lab_smoke_evidence.mjs converts a copied isolated-Lab bridge capture into docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json only after Q90R4 runtime verification has passed, then requires the Q90R5 verifier before Q87 cursor court; it keeps MathLive lab-only, legacy as default/rollback, main editor switch disabled, physical legacy deletion forbidden, virtual keyboard disabled, remote scripts forbidden, protected UI surfaces locked, and cursor PASS or Photomath/Wolfram claims blocked.';


  static const String q90r7MathLiveLabSmokeEvidenceExportRule =
      'Q90R7 adds the MathLive Lab Smoke Evidence Export Guard: the isolated Lab may expose a copyable runtime-smoke evidence capture for the user to paste into tool/mathlive_lab_runtime_smoke_capture.json before running the Q90R6 writer and Q90R5 verifier, but the app may not write project evidence files, switch or mount the main editor, delete legacy cursor files, enable MathLive virtual keyboard, allow remote scripts, mutate protected UI surfaces, or claim cursor PASS / Photomath / Wolfram level.';


  static const String q90r8MathLiveLabRealDeviceAccessRule =
      'Q90R8 adds the MathLive Lab Real Device Access Guard: a direct lib/main_mathlive_lab.dart entrypoint and a registered /mathlive-lab route let the isolated Lab be opened on a real device for evidence review without switching or mounting the main editor, deleting legacy cursor files, enabling MathLive virtual keyboard, allowing remote scripts, mutating protected UI surfaces, or claiming cursor PASS / Photomath / Wolfram level.';



  static const String q90r9WindowsNpmCommandResolutionRepairRule =
      'Q90R9 repairs Windows npm command resolution in tool/install_mathlive_runtime.mjs by using npm.cmd on Windows and a clear BLOCKED_NPM_NOT_FOUND error when npm is unavailable; it also preserves lab-only MathLive runtime intake, keeps legacy as default/rollback, forbids remote scripts and MathLive virtual keyboard, avoids main-editor switching and physical legacy deletion, and cleans analyzer string escapes without touching protected UI surfaces.';


  static const String q91MathLiveRuntimeEvidenceClosureRule =
      'V172-Q91 adds MathLive Runtime Evidence Closure: the user real-device MathLive Lab report may be recorded, but it cannot close evidence by itself; Q90R4 official local runtime verification and canonical Q90R5 Lab smoke evidence must both verify before Q92 Graph/History/Solution Adapter Hardening may begin. Q91 keeps MathLive lab-only, legacy as default/rollback, Graph/History/Solution untouched, protected UI surfaces locked, remote scripts forbidden, MathLive virtual keyboard disabled, main-editor switching blocked, physical legacy deletion forbidden, and cursor/Photomath/Wolfram PASS claims blocked.';


  static const String q92MathLiveGraphHistorySolutionAdapterRule =
      'V172-Q92 adds package-side MathLive Graph/History/Solution Adapter Hardening: MathLive LaTeX is normalized into a Graph/History/Solution envelope, graph eligibility and evaluator input can be prepared, but Q91 verified runtime/evidence closure remains required before flagged main-editor use. Q92 does not mutate Graph/History/Solution UI files, does not switch the main editor, keeps legacy as default/rollback, forbids physical legacy deletion, and makes no cursor PASS claim.';

  static const String q93MathLiveMainEditorFlagActivationRule =
      'V172-Q93 defines Main Editor MathLive Activation Behind Flag: MathLive remains disabled by default, legacyFlutterSlotEditor remains default without an explicit internal flag, rollback is mandatory, and no keyboard/MORE/long-press/AppShell/Graph/History/Solution surface may change. Q93 does not physically delete legacy cursor files and does not claim cursor PASS.';

  static const String q94RealDeviceMathLiveCursorCourtRule =
      'V172-Q94 defines the Real Device MathLive Cursor Court: flutter analyze, flutter test, real-device run evidence, the Q93 behind-flag path, protected-surface integrity, 12/12 cursor scenarios, and zero blocking failures are required before any MathLive cursor PASS or legacy main-path retirement can be considered. Static package checks alone cannot pass Q94.';

  static const String q95LegacyCursorMainPathRetirementRule =
      'V172-Q95 defines Legacy Cursor Main Path Retirement as non-deleting retirement only: after Q93 and Q94 are genuinely proven, the legacy cursor overlay/hit-test may leave the active MathLive main path, but rollback remains required and physical file deletion is still forbidden.';

  static const String q96LegacyCursorPhysicalCleanupRule =
      'V172-Q96 defines Legacy Cursor Physical Cleanup as a guarded cleanup manifest only: physical deletion requires passed Q95, explicit cleanup approval, rollback no longer required by contract, post-retirement soak, protected-surface integrity, and a reviewed deletion manifest. This package performs no physical legacy cleanup.';

  static const String q97PostCleanupRegressionCourtRule =
      'V172-Q97 defines the Post-Cleanup Regression Court: flutter pub get, flutter analyze, flutter test, main app real-device run, MathLive Lab real-device run, keyboard/MORE/long-press/Ans/enter/equality preservation, Graph/History/Solution runtime checks, no legacy overlay on MathLive path, rollback verification, and package hygiene are all required before any final post-cleanup PASS can be claimed.';

  static const String q98MathLiveTransitionEvidenceOrchestratorRule =
      'V172-Q98 adds the MathLive Transition Evidence Orchestrator: tool/run_mathlive_transition_court.mjs aggregates the contract verifier, runtime verifier, smoke-evidence writer/verifier, optional Flutter pub get/analyze/test, and optional real-device Lab/main-app runs into one evidence ledger. Q98 reduces repeated local-test burden but still cannot claim real-device PASS, switch the main editor, enable MathLive by default, delete legacy cursor files, or mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces.';


  static const String q99MathLiveRuntimeEvidenceIntakeRule =
      'V172-Q99 adds MathLive Runtime Evidence Intake Closure: tool/verify_mathlive_runtime_evidence_intake.mjs consolidates official runtime vendor presence, Q90R4 runtime verification, canonical Q90R5 smoke evidence, and the Q98 transition court report into one intake ledger. Q99 may mark evidence intake ready for Q92 review only when those reports are real and verified; it still cannot claim cursor PASS, switch or mount the main editor, enable MathLive by default, delete legacy cursor files, or mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces.';


  static const String q100OfficialRuntimeBundleClosureRule =
      'V172-Q100 adds Official MathLive Runtime Bundle Closure: tool/verify_mathlive_official_runtime_bundle.mjs verifies the local vendor MathLive runtime files, npm/mathlive provenance, runtime_manifest.json, sha256 file evidence, Q90R4 runtime verification, disabled remote scripts, disabled MathLive virtual keyboard, clean package hygiene, and unchanged protected UI surfaces. Q100 may only unlock Q101 Lab smoke evidence after real bundle closure; it cannot create fake runtime files, write fake smoke evidence, claim cursor PASS, switch or mount the main editor, enable MathLive by default, delete legacy cursor files, or mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces.';


  static const String q101LabSmokeEvidenceClosureRule =
      'V172-Q101 adds Lab Smoke Evidence Closure: tool/verify_mathlive_lab_smoke_evidence_closure.mjs consolidates Q100 official runtime bundle closure, Q90R6 smoke evidence authoring, Q90R5 canonical smoke evidence verification, and the canonical evidence file into one closure report. Q101 may only unlock Q87 cursor court when all real evidence is present; it cannot create fake evidence, claim cursor PASS, switch or mount the main editor, enable MathLive by default, delete legacy cursor files, or mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces.';


  static const String q102MathLiveStateNormalizationHardeningRule =
      'V172-Q102 adds MathLive State Normalization Hardening: MathLive Lab LaTeX/plainText/mathJson snapshots are converted into deterministic MathPro Graph/History/Solution/evaluator candidate payloads through a package-side normalizer and offline verifier. Q102 may be package-side ready, but Q101 Lab smoke evidence closure remains required before Q103 binding; it cannot write fake evidence, install runtime files, claim cursor PASS, switch or mount the main editor, enable MathLive by default, delete legacy cursor files, or mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces.';


  static const String q103GraphEligibilityAdapterRule =
      'V172-Q103 adds Graph Eligibility Adapter Real Binding: MathLive Q102 normalized expression payloads are classified through a package-side adapter that mirrors the existing GraphEligibility contract. Explicit x functions, y=f(x), verified numeric constant suggestions, and implicit-pending x/y equations are distinguished deterministically; unsupported numeric-looking candidates such as log_2(8) cannot become fake constant graph suggestions unless the evaluator bridge actually returns a numeric result. Q103 cannot mutate graph_card.dart or Graph/History/Solution UI, switch or mount the main editor, enable MathLive by default, claim cursor/device PASS, fake runtime/smoke evidence, or delete legacy cursor files.';


  static const String q104HistoryAdapterRule =
      'V172-Q104 adds History Adapter Real Binding: MathLive Q102 normalized expressions and Q103 GraphEligibility metadata are wrapped into deterministic History entry envelopes with inputEngine mathlive, stable IDs, normalized/display expressions, evaluator metadata, graph metadata, and solution candidate references. Q104 cannot mutate history_controller.dart, history_panel.dart, History UI, Graph/Solution UI, keyboard/MORE/long-press/AppShell, switch or mount the main editor, enable MathLive by default, write runtime History records, claim cursor/device PASS, fake runtime/smoke evidence, or delete legacy cursor files.';


  static const String q105SolutionEvaluatorCandidateAdapterRule =
      'V172-Q105 adds Solution/Evaluator Candidate Adapter: MathLive Q102 normalized expressions, Q103 GraphEligibility metadata, and Q104 History envelopes are wrapped into deterministic Solution/Evaluator candidate envelopes with inputEngine mathlive, evaluator candidate expression, solution candidate expression, semantic classification, evaluator result/unsupported reason, graph metadata, and History reference fields. Q105 cannot mutate solution_steps_panel.dart, Solution UI, Graph/History UI, keyboard/MORE/long-press/AppShell, switch or mount the main editor, enable MathLive by default, write runtime Solution records, generate fake solution steps, claim cursor/device PASS, fake runtime/smoke evidence, or delete legacy cursor files.';


  static const String q106MainWorkspaceMathLiveMountFlagRule =
      'V172-Q106 adds Main Workspace MathLive Mount Behind Internal Flag: MathLive main-workspace mounting is represented only as a readiness contract behind the explicit internal flag mathpro.internal.editorEngine.mathlive. Q106 requires Q93 flag contract, Q101 Lab smoke evidence closure, Q105 Solution/Evaluator adapter readiness, official runtime verification, rollback availability, disabled MathLive virtual keyboard, no remote scripts, unchanged protected surfaces, and no AppShell/keyboard/Graph/History/Solution mutation before any runtime mount can be considered. This package does not implement the mount, does not switch the default editor, does not enable MathLive by default, does not claim cursor/device PASS, does not fake runtime/smoke evidence, and does not delete legacy cursor files; V172-Q107 adds MathPro Keyboard → MathLive Main Bridge Hardening: the frozen Q85 key-command mapper is reused as the source of truth for future main-bridge command envelopes while keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces remain untouched, MathLive is not mounted or enabled by default, runtime binding remains blocked without Q101 evidence, official runtime verification, and explicit internal flag, and legacy cursor deletion/cursor PASS claims remain forbidden.';



  static const String q107MainKeyboardBridgeRule =
      'V172-Q107 adds MathPro Keyboard → MathLive Main Bridge Hardening: the frozen Q85 key-command mapper remains the source of truth for future main-workspace MathLive keyboard command envelopes. Q107 requires Q106 mount-readiness, Q101 Lab smoke evidence closure, official runtime verification, explicit internal flag, disabled MathLive virtual keyboard, no remote scripts, unchanged protected surfaces, and legacy rollback before any runtime main-keyboard bridge binding can be considered. This package does not implement runtime binding, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, does not mount or enable MathLive by default, does not claim cursor/device PASS, does not fake runtime/smoke evidence, and does not delete legacy cursor files.';



  static const String q108RealDeviceCursorCourtExecutionRule =
      'V172-Q108 adds Real Device MathLive Cursor Court Execution Package: the Q94 real-device cursor court is converted into a single execution/capture package with required Flutter commands, Lab/main real-device run evidence, Q106/Q107 readiness, Q101 smoke evidence closure, official runtime verification, 12 Q94-aligned cursor scenarios, and zero blocking failures. Q108 is package-side execution tooling only; it cannot claim cursor/device PASS, switch or mount the main editor, enable MathLive by default, retire or delete legacy cursor files, fake runtime/smoke/device evidence, or mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces.';


  static const String q109MainEditorSwitchConditionalActivationRule =
      'V172-Q109 adds Main Editor Switch Conditional Activation as a conditional gate only: it keeps legacyFlutterSlotEditor as default and rollback, treats MathLive only as a candidate engine behind the explicit internal flag, requires Q100 official runtime closure, Q101 Lab smoke evidence closure, Q103/Q104/Q105 adapter readiness, Q106 mount-readiness, Q107 main keyboard bridge readiness, Q108 real-device cursor court evidence, Flutter analyze/test PASS evidence, explicit internal flag enablement, and explicit activation review approval before any later phase may review activation. Q109 does not implement the switch, does not mount MathLive in the main workspace, does not enable MathLive by default, does not mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, does not claim cursor/device PASS, and does not retire or delete legacy cursor files.';


  static const String q110LegacyCursorMainPathRetirementActualGateRule =
      'V172-Q110 adds Legacy Cursor Main Path Retirement Actual Gate as a hard pre-retirement gate only: it keeps legacyFlutterSlotEditor as the selected default and rollback, requires Q109 conditional activation review readiness, MathLive activation behind the explicit internal flag, Q108 real-device cursor court PASS evidence, Flutter analyze/test PASS evidence, Q103/Q104/Q105 adapter readiness, rollback availability, post-activation soak evidence, unchanged protected surfaces, no fake evidence, and explicit retirement approval before any later phase may review actual legacy main-path retirement. Q110 does not retire the legacy main path, does not mount or switch MathLive, does not enable MathLive by default, does not mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, does not claim cursor/device PASS, and does not delete legacy cursor files; V172-Q111 adds Legacy Cursor Physical Cleanup Planning as an inventory-only cleanup manifest and verifier: it classifies legacy cursor files before Q112, preserves protected UI/rollback/shared data-path files, blocks physical deletion and runtime behavior changes, requires Q110/Q109/Q108/Flutter/manual approval evidence before cleanup review, and still forbids cursor PASS claims, fake evidence, MathLive default switching, and legacy deletion in this package.';


  static const String q111LegacyCursorPhysicalCleanupPlanningRule =
      'V172-Q111 adds Legacy Cursor Physical Cleanup Planning as an inventory-only pre-cleanup phase: it creates a cleanup manifest that classifies protected UI surfaces, shared editor/data-path files, rollback-required files, later Q112 cleanup candidates, and manual-review-required files. Q111 requires Q110 retirement-gate readiness, Q109 conditional activation readiness, Q108 real-device cursor court PASS evidence, Flutter analyze/test PASS evidence, manual inventory review, and explicit cleanup approval before any later phase may review physical cleanup. Q111 does not delete files, does not retire the legacy main path, does not mount or switch MathLive, does not enable MathLive by default, does not mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, does not claim cursor/device PASS, and does not create fake evidence; V172-Q112 adds Legacy Cursor Physical Cleanup Execution Guard and still performs no deletion.';


  static const String q112LegacyCursorPhysicalCleanupExecutionGuardRule =
      'V172-Q112 adds Legacy Cursor Physical Cleanup Execution Guard as a guard-only phase: it consumes the Q111 cleanup inventory and verifies that protected surfaces, rollback files, shared data-path files, cleanup candidates, and manual-review files remain present before any later cleanup execution can be reviewed. Q112 requires Q111 planning readiness, Q110 retirement-gate readiness, Q109 conditional activation readiness, Q108 real-device cursor court PASS evidence, Flutter analyze/test PASS evidence, post-activation soak evidence, manual inventory review, and explicit Q112 cleanup approval. This package does not delete files, does not execute cleanup, does not retire the legacy main path, does not mount or switch MathLive, does not enable MathLive by default, does not mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, does not claim cursor/device PASS, and does not create fake evidence; V172-Q113 adds Post-Cleanup Regression Court Guard and still performs no cleanup, no release PASS claim, and no default editor switch.';


  static const String q113PostCleanupRegressionCourtGuardRule =
      'V172-Q113 adds Post-Cleanup Regression Court Guard as a guard-only phase after Q112: it requires separately approved cleanup execution evidence, a cleanup delta manifest, flutter pub get/analyze/test PASS evidence, MathLive Lab and main-app real-device PASS evidence, Q108 cursor court PASS evidence, Graph/History/Solution runtime verification, rollback verification, absence of legacy cursor overlay on the MathLive path, unchanged protected surfaces, clean package hygiene, no fake evidence, and explicit post-cleanup release approval before any later release review. This package does not execute cleanup, does not delete files, does not retire the legacy main path, does not mount or switch MathLive, does not enable MathLive by default, does not mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, does not claim cursor/device/post-cleanup PASS, and does not create fake evidence.';


  static const String legacyQ91ExpectedQ92Marker =
      'V172-Q92 Graph / History / Solution Adapter Hardening';

  static const String q114ReleaseFreezeCleanFullZipGuardRule =
      'V172-Q114 adds Release Freeze / Clean Full ZIP Guard as a guard-only final package freeze phase after Q113: it requires Q113 post-cleanup regression court readiness, Flutter pub get/analyze/test PASS evidence, MathLive Lab and main-app real-device PASS evidence, Graph/History/Solution runtime verification, rollback verification, final ZIP integrity, fresh extract verification, clean package hygiene, no stale nested artifacts, full ZIP delivery named MathProFlutterPhase17.zip, no fake evidence, and explicit release-freeze approval before any final release review can be considered. This package does not freeze a release, does not claim final release PASS, does not execute cleanup, does not delete files, does not retire the legacy main path, does not mount or switch MathLive, does not enable MathLive by default, does not mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not create fake evidence.';


  static const String q116PostQ115CursorCourtRerunRule =
      'V172-Q116 adds a Post-Q115 Real-Device Cursor Court Rerun Gate: the 12 Q108 cursor scenarios must be rerun after the V172-Q115 structural caret anchor geometry repair, the capture must explicitly reference V172-Q115 as the repair under test, stale pre-Q115 captures are forbidden, structural caret anchor/geometry misalignment must be explicitly cleared, and blockingFailureCount must remain zero before human review. Q116 does not claim cursor/device PASS, does not switch or mount MathLive as the default/main editor, does not retire or delete legacy cursor files, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not create fake runtime/smoke/device evidence.';



  static const String q117MainEditorSwitchPreflightGateRule =
      'V172-Q117 adds a Main Editor Switch Preflight Gate after Q116: it requires complete Q116 post-Q115 real-device cursor court rerun evidence, Q116 human review approval, Q109 conditional activation package readiness, Q100/Q101 runtime and smoke evidence closure, Q103/Q104/Q105 adapter readiness, Q106/Q107 mount and keyboard bridge readiness, Flutter analyze/test evidence, explicit internal flag enablement, and explicit activation-review approval before any later MathLive main-editor activation review may proceed. Q117 does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not retire or delete the legacy cursor stack, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, does not claim cursor/device PASS, and does not create fake runtime/smoke/device evidence.';


  static const String q118MainEditorActivationDryRunGateRule =
      'V172-Q118 adds a Main Editor Activation Dry-Run Gate after Q117: it requires Q117 preflight package readiness, complete Q117 preflight evidence, Q117 human review approval, explicit runtime MathLive main-editor flag enablement, explicit Q118 activation approval, Flutter analyze/test evidence, MathLive Lab and main-app real-device run evidence, Graph/History/Solution runtime verification, unchanged protected surfaces, legacy rollback availability, disabled MathLive virtual keyboard, no remote scripts, and no fake evidence before any later runtime activation review may proceed. Q118 is a dry-run gate only: it does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not retire or delete the legacy cursor stack, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor/device/release PASS.';


  static const String q119GraphHistorySolutionRuntimeBindingGateRule =
      'V172-Q119 adds a Graph / History / Solution Runtime Binding Gate after Q118: it requires complete Q118 activation dry-run evidence, Q118 human review approval, explicit Q119 runtime-binding approval, Q103/Q104/Q105 adapter readiness, Flutter analyze/test evidence, MathLive Lab and main-app real-device run evidence, Graph/History/Solution runtime scenario evidence, unchanged protected surfaces, legacy rollback availability, no fake Graph/History/Solution/runtime/device evidence, and no default editor switch before any later runtime Graph/History/Solution binding review may proceed. Q119 is a gate only: it does not write Graph, History, or Solution runtime state, does not mutate graph_card.dart, history_controller.dart, history_panel.dart, or solution_steps_panel.dart, does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not retire or delete the legacy cursor stack, and does not claim cursor/device/release PASS.';


  static const String q120LegacyMainPathRetirementReviewGateRule =
      'V172-Q120 adds a Legacy Main Path Retirement Review Gate after Q119: it requires complete Q119 runtime-binding evidence, Q119 human review approval, explicit Q120 retirement-review approval, Flutter analyze/test evidence, MathLive Lab and main-app real-device run evidence, Graph/History/Solution runtime evidence, post-activation soak evidence, unchanged protected surfaces, legacy rollback availability, no fake runtime/device/approval evidence, and no default editor switch before any later legacy main-path retirement review may proceed. Q120 is a review gate only: it does not retire the legacy main path, does not delete legacy cursor files, does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor/device/release PASS.';



  static const String q121LegacyCursorPhysicalCleanupPlanningGateRule =
      'V172-Q121 adds a Legacy Cursor Physical Cleanup Planning Gate after Q120: it requires Q120 retirement-review package readiness, complete Q120 retirement-review evidence, Q120 human review approval, explicit Q121 cleanup-planning approval, Flutter analyze/test evidence, MathLive Lab and main-app real-device evidence, Graph/History/Solution runtime evidence, post-activation soak evidence, a cleanup planning draft with protected/rollback/shared-data/manual-review categories, unchanged protected surfaces, legacy rollback availability, no fake runtime/device/planning approval evidence, and no default editor switch before any later physical cleanup execution review may proceed. Q121 is a planning gate only: it does not delete legacy cursor files, does not retire the legacy main path, does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor/device/release PASS.';


  static const String q122LegacyCursorPhysicalCleanupExecutionGuardRule =
      'V172-Q122 adds a Legacy Cursor Physical Cleanup Execution Guard after Q121: it requires Q121 planning package readiness, complete Q121 planning evidence, Q121 human review approval, explicit Q122 physical cleanup execution approval, Flutter analyze/test evidence, MathLive Lab and main-app real-device evidence, Graph/History/Solution runtime evidence, post-activation soak evidence, cleanup delta manifest preparation, rollback verification, unchanged protected surfaces, legacy rollback availability, no fake runtime/device/execution approval evidence, and no default editor switch before any later physical cleanup execution review may proceed. Q122 is an execution guard only: it does not delete legacy cursor files, does not execute physical cleanup, does not retire the legacy main path, does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor/device/release PASS.';


  static const String q123PostCleanupRegressionCourtGuardRule =
      'V172-Q123 adds a Post-Cleanup Regression Court Guard after Q122: it requires Q122 execution-guard package readiness, complete Q122 cleanup execution evidence, Q122 human review approval, approved cleanup actually executed, a cleanup delta manifest, Flutter pub get/analyze/test evidence, MathLive Lab and main-app real-device evidence, Q108/Q116 cursor court PASS evidence, Graph/History/Solution runtime evidence, legacy cursor overlay absence on the MathLive path, rollback verification, unchanged protected surfaces, clean package hygiene, no fake runtime/device/cleanup evidence, and explicit Q123 post-cleanup regression court approval before any later post-cleanup regression or release review may proceed. Q123 is a guard only: it does not run the post-cleanup court, does not execute cleanup, does not delete legacy cursor files, does not retire the legacy main path, does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor/post-cleanup/release PASS.';


  static const String q124ReleaseFreezeFinalReviewGuardRule =
      'V172-Q124 adds a Release Freeze Final Review Guard after Q123: it requires Q123 post-cleanup regression guard package readiness, complete Q123 post-cleanup regression evidence, Q123 human review approval, Flutter pub get/analyze/test evidence, MathLive Lab and main-app real-device evidence, Q108/Q116 cursor court PASS evidence, Graph/History/Solution runtime evidence, rollback verification, clean full ZIP/fresh-extract hygiene, no stale nested artifacts, unchanged protected surfaces, no fake runtime/device/release evidence, and explicit Q124 release-freeze approval before any later final release-freeze review may proceed. Q124 is a guard only: it does not freeze a release, does not claim release PASS, does not run the post-cleanup court, does not execute cleanup, does not delete legacy cursor files, does not retire the legacy main path, does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor PASS.';



  static const String q125FinalPackageEvidenceClosureIntakeGuardRule =
      'V172-Q125 adds a Final Package Evidence Closure Intake Guard after Q124: it requires Q124 release-freeze final review guard package readiness, complete Q124 release-freeze final review evidence, Q124 human review approval, explicit Q124 release-freeze approval, Flutter pub get/analyze/test evidence, MathLive Lab and main-app real-device evidence, Q108/Q116 cursor court PASS evidence, Graph/History/Solution runtime evidence, rollback verification, final evidence ledger, frozen defect ledger, touched-files manifest, selected verifier reports, clean full ZIP/fresh-extract hygiene, no stale nested artifacts, unchanged protected surfaces, no fake runtime/device/release/evidence-closure evidence, and explicit Q125 evidence-closure approval before any later final package evidence closure may proceed. Q125 is a guard only: it does not close final package evidence, does not freeze a release, does not claim release PASS, does not run the post-cleanup court, does not execute cleanup, does not delete legacy cursor files, does not retire the legacy main path, does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor PASS.';


  static const String q126LocalEvidenceReconciliationIntakeGuardRule =
      'V172-Q126 adds Local Evidence Reconciliation Intake Guard as part of the bundled package-side continuation after Q125: it collects and validates the user-machine evidence set in one place before later runtime activation or release gates may progress. Q126 requires Q125 final package evidence closure intake guard package readiness, Flutter analyze/test evidence, MathLive Lab and main-app real-device evidence, unchanged protected surfaces, no fake runtime/device/release evidence, and explicit human approval before any real progression may proceed. Q126 is guard-only: it does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not delete legacy cursor files, does not retire the legacy main path, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor/device/release PASS.';

  static const String q127CursorCourtClosureOrRepairDecisionGateRule =
      'V172-Q127 adds Cursor Court Closure Or Repair Decision Gate as part of the bundled package-side continuation after Q125: it forces a clean decision between Q116 cursor-court closure and Q115R repair before any activation work continues. Q127 requires Q126 reconciled local evidence intake, Flutter analyze/test evidence, MathLive Lab and main-app real-device evidence, unchanged protected surfaces, no fake runtime/device/release evidence, and explicit human approval before any real progression may proceed. Q127 is guard-only: it does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not delete legacy cursor files, does not retire the legacy main path, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor/device/release PASS.';

  static const String q128MainEditorActivationBehindFlagExecutionGuardRule =
      'V172-Q128 adds Main Editor Activation Behind Flag Execution Guard as part of the bundled package-side continuation after Q125: it keeps MathLive main-editor activation behind an explicit internal flag and blocks activation while Q127 cursor evidence is absent or failed. Q128 requires Q127 cursor court closure decision, Flutter analyze/test evidence, MathLive Lab and main-app real-device evidence, unchanged protected surfaces, no fake runtime/device/release evidence, and explicit human approval before any real progression may proceed. Q128 is guard-only: it does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not delete legacy cursor files, does not retire the legacy main path, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor/device/release PASS.';

  static const String q129MainAppRealDeviceRuntimeCourtGuardRule =
      'V172-Q129 adds Main App Real Device Runtime Court Guard as part of the bundled package-side continuation after Q125: it requires a real-device main-app runtime court after any flag-gated activation before downstream runtime bindings can proceed. Q129 requires Q128 flag-gated activation evidence, Flutter analyze/test evidence, MathLive Lab and main-app real-device evidence, unchanged protected surfaces, no fake runtime/device/release evidence, and explicit human approval before any real progression may proceed. Q129 is guard-only: it does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not delete legacy cursor files, does not retire the legacy main path, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor/device/release PASS.';

  static const String q130GraphHistorySolutionRuntimeBindingActualGuardRule =
      'V172-Q130 adds Graph History Solution Runtime Binding Actual Guard as part of the bundled package-side continuation after Q125: it blocks actual Graph/History/Solution runtime writes until the main-app runtime court is complete and explicitly approved. Q130 requires Q129 main-app runtime court evidence, Flutter analyze/test evidence, MathLive Lab and main-app real-device evidence, unchanged protected surfaces, no fake runtime/device/release evidence, and explicit human approval before any real progression may proceed. Q130 is guard-only: it does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not delete legacy cursor files, does not retire the legacy main path, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor/device/release PASS.';

  static const String q131FullAppRegressionCourtGuardRule =
      'V172-Q131 adds Full App Regression Court Guard as part of the bundled package-side continuation after Q125: it requires full-app regression evidence across keyboard/editor/cursor/Graph/History/Solution/MathLive before release-candidate review. Q131 requires Q130 Graph/History/Solution runtime binding evidence, Flutter analyze/test evidence, MathLive Lab and main-app real-device evidence, unchanged protected surfaces, no fake runtime/device/release evidence, and explicit human approval before any real progression may proceed. Q131 is guard-only: it does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not delete legacy cursor files, does not retire the legacy main path, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor/device/release PASS.';

  static const String q132ReleaseCandidateEvidenceFreezeGuardRule =
      'V172-Q132 adds Release Candidate Evidence Freeze Guard as part of the bundled package-side continuation after Q125: it freezes the remaining release-candidate evidence requirements without claiming release PASS or final release readiness. Q132 requires Q131 full-app regression court evidence, Flutter analyze/test evidence, MathLive Lab and main-app real-device evidence, unchanged protected surfaces, no fake runtime/device/release evidence, and explicit human approval before any real progression may proceed. Q132 is guard-only: it does not switch or mount MathLive as the main/default editor, keeps legacyFlutterSlotEditor as default and rollback, does not delete legacy cursor files, does not retire the legacy main path, does not mutate keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not claim cursor/device/release PASS.';


  static const String q135Q139MathLiveFullMainEditorMigrationRule =
      'V172-Q135-Q139 performs the real MathLive full main editor migration batch: legacy Flutter cursor overlay and hit-test are disabled on the active main editor route, MathLive becomes the mandatory visible main expression surface, the protected MathPro keyboard routes into the MathLive bridge, and MathLive state syncs back into CalculatorController for evaluate, Graph, History, and Solution candidates. This batch does not mutate protected keyboard/MORE/long-press/Graph/History/Solution files, does not physically delete legacy cursor files yet, keeps rollback code outside the active path, and does not claim cursor/device/release PASS without user-side evidence.';

}
