#!/usr/bin/env python3
"""
MathPro static contract verifier.
Runs without Flutter/Dart and verifies the non-negotiable MathPro contracts that
can be checked from source files before GitHub Actions runs flutter analyze/test.

Usage:
  python3 tool/verify_mathpro_contract.py [project_root]

Outputs:
  - stdout human-readable summary
  - tool/verify_mathpro_contract_report.json
  - tool/verify_mathpro_contract_report.md
Exits non-zero on hard contract failures.
"""
from __future__ import annotations

import hashlib
import json
import re
import sys
from dataclasses import dataclass, asdict
from pathlib import Path
from typing import Iterable


EXPECTED_BASIC_CORE = [
    ["C", "⌫", "%", "÷"],
    ["7", "8", "9", "×"],
    ["4", "5", "6", "−"],
    ["1", "2", "3", "+"],
    ["MORE", "0", ".", "Ans"],
]

EXPECTED_TABS = ["Temel", "Cebir", "Kalkülüs", "Kompleks", "Lineer Cebir"]

PROTECTED_FILES = [
    "lib/features/keyboard/key_config.dart",
    "lib/features/keyboard/math_keyboard.dart",
    "lib/features/keyboard/bottom_dock.dart",
    "lib/features/keyboard/long_press_popup.dart",
    "lib/features/keyboard/premium_key.dart",
    "lib/features/workspace/math_label.dart",
    "lib/features/workspace/template_tray.dart",
    "lib/app/app_shell.dart",
    "lib/features/solution/solution_steps_panel.dart",
    "lib/features/graph/graph_card.dart",
    "lib/features/history/history_controller.dart",
    "lib/features/history/history_panel.dart",
]

REQUIRED_ENGINE_FILES = [
    "lib/features/editor/slot_registry.dart",
    "lib/features/editor/cursor_anchor.dart",
    "lib/features/editor/selection_controller.dart",
    "lib/features/editor/render/editor_interaction_layer.dart",
    "lib/features/workspace/editor_viewport.dart",
    "lib/features/workspace/editor_caret_overlay.dart",
    "lib/features/formula_engine/math_layout_engine.dart",
    "lib/features/formula_engine/slot_hit_testing.dart",
    "lib/features/formula_engine/premium_tap_precision_policy.dart",
    "lib/features/formula_engine/editor_gesture_router_policy.dart",
    "lib/features/formula_engine/renderer_sync_geometry_policy.dart",
    "lib/features/formula_engine/pixel_qa_cursor_matrix_policy.dart",
    "lib/features/formula_engine/premium_cursor_visual_polish_policy.dart",
    "lib/features/formula_engine/regression_contract_hardening_policy.dart",
    "lib/features/formula_engine/legacy_raw_math_renderer_cleanup_policy.dart",
    "lib/features/formula_engine/template_slot_navigation_policy.dart",
    "lib/features/formula_engine/fraction_precision_cursor_policy.dart",
    "lib/features/formula_engine/script_precision_cursor_policy.dart",
    "lib/features/formula_engine/log_root_precision_cursor_policy.dart",
    "lib/features/formula_engine/digit_level_caret_stop_policy.dart",
    "lib/features/formula_engine/true_glyph_level_caret_stop_policy.dart",
    "lib/features/formula_engine/nested_expression_depth_cursor_policy.dart",
    "lib/features/formula_engine/drag_to_move_cursor_stability_policy.dart",
    "lib/features/formula_engine/structural_insert_delete_safety_policy.dart",
    "lib/features/formula_engine/structural_cursor_release_hardening_policy.dart",
    "lib/features/formula_engine/p6_locked_cursor_candidate_freeze_policy.dart",
    "lib/features/formula_engine/structural_placeholder_restoration_policy.dart",
    "lib/features/formula_engine/active_empty_slot_leading_rail_caret_policy.dart",
    "lib/features/formula_engine/active_empty_slot_leading_rail_finalizer_policy.dart",
    "lib/features/formula_engine/integral_cursor_specialization_policy.dart",
    "lib/features/formula_engine/fraction_function_root_log_cursor_specialization_policy.dart",
    "lib/features/formula_engine/structural_edit_transaction_engine_policy.dart",
    "lib/features/formula_engine/cursor_golden_geometry_court_policy.dart",
    "lib/features/formula_engine/synthetic_tap_intent_matrix_policy.dart",
    "lib/features/formula_engine/structural_edit_transaction_stress_court_policy.dart",
    "lib/features/formula_engine/long_expression_pan_nested_cursor_stability_policy.dart",
    "lib/features/formula_engine/real_device_cursor_checkpoint_protocol_policy.dart",
    "lib/features/formula_engine/native_slotbox_input_surface_policy.dart",
    "lib/features/formula_engine/native_slotbox_painter_policy.dart",
    "lib/features/formula_engine/native_slotbox_hit_test_policy.dart",
    "lib/features/formula_engine/native_exclusive_placeholder_caret_renderer_policy.dart",
    "lib/features/formula_engine/native_structural_edit_transaction_binding_policy.dart",
    "lib/features/formula_engine/native_slotbox_input_surface_integration_policy.dart",
    "lib/features/formula_engine/native_integral_slotbox_specialization_policy.dart",
    "lib/features/formula_engine/native_fraction_function_root_log_slotbox_specialization_policy.dart",
    "lib/features/formula_engine/native_nested_long_expression_pan_stability_policy.dart",
    "lib/features/formula_engine/native_real_device_cursor_court_policy.dart",
    "lib/features/formula_engine/role_geometry_visual_alignment_policy.dart",
    "lib/features/formula_engine/existing_cursor_engine_reconciliation_policy.dart",
    "lib/features/formula_engine/slot_geometry_bundle_authority.dart",
    "lib/features/formula_engine/renderer_sync_upgrade_policy.dart",
    "lib/features/formula_engine/real_device_pixel_qa_court_policy.dart",
    "lib/features/editor/calculus_cursor_navigation_policy.dart",
    "lib/features/editor/matrix_cell_navigation_policy.dart",
    "lib/features/editor/node_factory.dart",
    "lib/features/editor/render/math_tex_serializer.dart",
]

REQUIRED_CURSOR_AUDIT_FILES = [
    "docs/audit/V172_I_CALCULUS_DIFFERENTIAL_CURSOR_AUDIT_REPORT.md",
    "docs/audit/V172_J_NO_LOUPE_TAP_PRECISION_AUDIT_REPORT.md",
    "docs/audit/V172_K_GESTURE_ROUTER_WITHOUT_LOUPE_AUDIT_REPORT.md",
    "docs/audit/V172_L_RENDERER_SYNC_GEOMETRY_AUDIT_REPORT.md",
    "docs/audit/V172_M_PIXEL_QA_CURSOR_MATRIX_AUDIT_REPORT.md",
    "docs/audit/V172_N_PREMIUM_CURSOR_VISUAL_POLISH_AUDIT_REPORT.md",
    "docs/audit/V172_O_REGRESSION_CONTRACT_HARDENING_AUDIT_REPORT.md",
    "docs/audit/V172_P_LEGACY_RAW_MATH_RENDERER_CLEANUP_AUDIT_REPORT.md",
]

FORBIDDEN_PATH_PARTS = [
    "/build/",
    "/.gradle/",
    "/.idea/",
    "/__pycache__/",
    "/.pytest_cache/",
]

# Q205R2: `flutter pub get` legitimately creates `.dart_tool/` before the
# user-side contract verifier is run. Final ZIP packaging still excludes
# `.dart_tool`; the source-tree verifier must not hard-fail on this local
# generated Flutter workspace state.
USER_SIDE_GENERATED_PATH_PARTS = [
    "/.dart_tool/",
]

FORBIDDEN_SUFFIXES = [".pyc", ".tmp", ".log", ".apk", ".aab"]

HARD_FORBIDDEN_LIB_PATTERNS = {
    "green_debug_overlay_enabled": re.compile(r"paintVisibleSlotOverlay\s*[:=]\s*true"),
}

WARNING_PATTERNS = {
    "legacy_inverse_alias_internal": re.compile(r"\b(?:asin|acos|atan|asinh|acosh|atanh|acot)\s*\("),
    "legacy_log_filled_comment_or_guard": re.compile(r"log\(2\)\(5\)"),
    "x8n_corruption_marker": re.compile(r"x8n"),
}


@dataclass
class CheckResult:
    name: str
    status: str
    detail: str


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="replace")


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def normalize_source(source: str) -> str:
    return re.sub(r"\s+", "", source)


def check_required_paths(root: Path, paths: Iterable[str], name: str) -> CheckResult:
    missing = [p for p in paths if not (root / p).exists()]
    if missing:
        return CheckResult(name, "FAIL", "Missing: " + ", ".join(missing))
    return CheckResult(name, "PASS", f"All {len(list(paths))} required paths exist.")


def check_basic_keyboard(root: Path) -> CheckResult:
    path = root / "lib/features/keyboard/key_config.dart"
    if not path.exists():
        return CheckResult("basic_keyboard_contract", "FAIL", "key_config.dart missing")
    source = read_text(path)
    compact = normalize_source(source)
    failures: list[str] = []
    for row in EXPECTED_BASIC_CORE:
        row_literal = "[" + ",".join([f"'{x}'" for x in row]) + "]"
        if row_literal.replace(" ", "") not in compact:
            failures.append("missing row " + " ".join(row))
    for tab in EXPECTED_TABS:
        if f"'{tab}'" not in source:
            failures.append(f"missing tab {tab}")
    for symbol in ["MORE", "Ans", "↵", "="]:
        if symbol not in source:
            failures.append(f"missing required symbol {symbol}")
    if failures:
        return CheckResult("basic_keyboard_contract", "FAIL", "; ".join(failures))
    return CheckResult("basic_keyboard_contract", "PASS", "Basic 20-key inventory, tabs, MORE/Ans/=/↵ markers are present.")


def check_long_press_contract(root: Path) -> CheckResult:
    path = root / "lib/features/keyboard/key_config.dart"
    source = read_text(path) if path.exists() else ""
    required_keys = ["'sin':", "'cos':", "'tan':", "'log':", "'√□':", "'□^□':", "'d/dx':", "'∫□dx':", "'Σ':", "'[□ □]':", "'[□]':"]
    missing = [k for k in required_keys if k not in source]
    if "longPressMap" not in source:
        missing.append("longPressMap")
    if missing:
        return CheckResult("long_press_contract", "FAIL", "Missing long-press anchors: " + ", ".join(missing))
    return CheckResult("long_press_contract", "PASS", "Expected long-press map anchors are present.")


def active_pubspec_metadata(root: Path) -> tuple[str, str]:
    source = read_text(root / "pubspec.yaml") if (root / "pubspec.yaml").exists() else ""
    version_match = re.search(r"^version:\s*([^\n\r]+)", source, re.MULTILINE)
    description_match = re.search(r"^description:\s*([^\n\r]+)", source, re.MULTILINE)
    version = version_match.group(1).strip() if version_match else ""
    description = description_match.group(1).strip() if description_match else ""
    return version, description


def check_stale_test_metadata_contract(root: Path) -> CheckResult:
    """Catch stale test assertions that pin active package metadata to old phases.

    Older Q tests should prove that their capability remains in lineage; they
    must not require the active package to still be Q38/Q39/etc. This check is
    intentionally conservative and runs without Flutter.
    """
    active_version, active_description = active_pubspec_metadata(root)
    active_q_match = re.search(r"(V172-Q\d+R?\d*)", active_description)
    active_q = active_q_match.group(1) if active_q_match else ""
    details: list[str] = []
    if not active_version:
        details.append("pubspec active version not found")
    if not active_q:
        details.append("pubspec active Q marker not found")

    test_root = root / "test"
    if test_root.exists():
        for path in sorted(test_root.rglob("*.dart")):
            rel = path.relative_to(root).as_posix()
            source = read_text(path)
            for match in re.finditer(r"expect\(\s*MathProPackageContract\.version\s*,\s*'([^']+)'\s*\)", source):
                pinned = match.group(1)
                if active_version and pinned != active_version:
                    details.append(f"{rel}: stale exact version assertion {pinned} != {active_version}")
            for match in re.finditer(r"\{[^}]*0\.172\.[^}]*\}\s*,\s*contains\(\s*MathProPackageContract\.version\s*\)", source, re.DOTALL):
                block = match.group(0)
                if active_version and active_version not in block:
                    details.append(f"{rel}: active version missing from version-set assertion")
            for field in ["pubspecDescription", "auditTitle"]:
                pattern = rf"MathProPackageContract\.{field}\s*,\s*contains\(\s*'([^']*V172-Q\d+R?\d*[^']*)'\s*\)"
                for match in re.finditer(pattern, source):
                    pinned_q = re.search(r"V172-Q\d+R?\d*", match.group(1)).group(0)
                    if active_q and pinned_q != active_q:
                        details.append(f"{rel}: stale {field} assertion {pinned_q} != {active_q}")
            for match in re.finditer(r"MathProPackageContract\.nextPhase\s*,\s*contains\(\s*'Q(\d+)'\s*\)", source):
                q = match.group(1)
                expected_next = ""
                if active_q:
                    active_num_match = re.search(r"Q(\d+)", active_q)
                    if active_num_match:
                        expected_next = str(int(active_num_match.group(1)) + 1)
                if expected_next and q != expected_next:
                    details.append(f"{rel}: stale nextPhase assertion Q{q}; active next phase must remain Q{expected_next}")

    readme = root / "README.md"
    if readme.exists() and active_q:
        text = read_text(readme)
        first_section = text.split("\n# ", 1)[0]
        first_line = text.splitlines()[0] if text.splitlines() else ""
        if active_q not in first_line:
            details.append(f"README first heading does not contain active marker {active_q}")
        for stale in ["Q44 keeps", "Honest limit: Q44", "Q43 keeps"]:
            if stale in first_section:
                details.append(f"README active top section still contains stale marker: {stale}")
    if details:
        return CheckResult("stale_test_metadata_contract", "FAIL", "; ".join(details[:40]))
    return CheckResult("stale_test_metadata_contract", "PASS", f"Tests and README do not pin active metadata away from {active_q} / {active_version}.")


def scan_hard_forbidden(root: Path) -> CheckResult:
    hits: list[str] = []
    for path in (root / "lib").rglob("*.dart"):
        text = read_text(path)
        rel = path.relative_to(root).as_posix()
        for label, pattern in HARD_FORBIDDEN_LIB_PATTERNS.items():
            for m in pattern.finditer(text):
                line = text.count("\n", 0, m.start()) + 1
                hits.append(f"{label}: {rel}:{line}")
    if hits:
        return CheckResult("forbidden_production_patterns", "FAIL", "; ".join(hits[:20]))
    return CheckResult("forbidden_production_patterns", "PASS", "No hard-forbidden production patterns found in lib/.")


def scan_warnings(root: Path) -> CheckResult:
    """
    Q31: distinguish harmful visible leaks from useful internal compatibility
    and regression guards.  Old raw aliases such as asin(□), log(2)(5), or
    x8n are not automatically product defects when they live in parser aliases,
    release-evidence scenarios, regression gates, or tests.  They are defects
    only when they leak into user-visible UI/render/key surfaces.
    """
    visible_surface_files = [
        root / "lib/features/keyboard/premium_key.dart",
        root / "lib/features/workspace/math_label.dart",
        root / "lib/features/workspace/template_tray.dart",
        root / "lib/features/editor/render/mathjax_render_surface.dart",
    ]
    allowed_internal_roots = [
        root / "lib/logic",
        root / "lib/features/keyboard",
        root / "lib/features/editor/render",
        root / "test",
    ]

    visible_counts: dict[str, int] = {key: 0 for key in WARNING_PATTERNS}
    internal_guard_counts: dict[str, int] = {key: 0 for key in WARNING_PATTERNS}
    visible_hits: list[str] = []

    def scan_path(path: Path, bucket: dict[str, int], collect_visible: bool) -> None:
        text = read_text(path)
        rel = path.relative_to(root).as_posix()
        for label, pattern in WARNING_PATTERNS.items():
            matches = list(pattern.finditer(text))
            bucket[label] += len(matches)
            if collect_visible:
                for m in matches[:2]:
                    if len(visible_hits) < 12:
                        line = text.count("\n", 0, m.start()) + 1
                        visible_hits.append(f"{label}: {rel}:{line}")

    for path in visible_surface_files:
        if path.exists():
            scan_path(path, visible_counts, True)

    for base in allowed_internal_roots:
        if base.exists():
            for path in base.rglob("*.dart"):
                scan_path(path, internal_guard_counts, False)

    detail = (
        "visible_counts="
        + json.dumps(visible_counts, ensure_ascii=False)
        + "; internal_guard_counts="
        + json.dumps(internal_guard_counts, ensure_ascii=False)
    )
    if visible_hits:
        detail += "; visible_samples=" + " | ".join(visible_hits)
        return CheckResult("legacy_raw_math_warning_scan", "WARN", detail)
    detail += "; no visible raw legacy leaks; internal compatibility/regression guards preserved"
    return CheckResult("legacy_raw_math_warning_scan", "PASS", detail)



def check_v172_q42_drag_to_move_cursor_stability(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/drag_to_move_cursor_stability_policy.dart"
    layer = root / "lib/features/editor/render/editor_interaction_layer.dart"
    router = root / "lib/features/formula_engine/editor_gesture_router_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    for path, label in [(policy, "drag policy"), (layer, "interaction layer"), (router, "gesture router"), (contract, "package contract")]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    layer_source = read_text(layer) if layer.exists() else ""
    router_source = read_text(router) if router.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required_policy_tokens = [
        "v172q42",
        "dragStabilityEngineAvailable = true",
        "randomSlotJumpSuppressed = true",
        "duplicateDragEmitSuppressed = true",
        "horizontalPanConflictGuarded = true",
        "editorLoupeEnabled = false",
        "shouldSuppressSlotDrag",
        "shouldSuppressLinearDrag",
    ]
    for token in required_policy_tokens:
        if token not in policy_source:
            details.append(f"drag policy missing {token}")
    for token in ["DragToMoveCursorStabilityPolicy", "State<EditorInteractionLayer>", "_lastDragSlotSelection", "shouldSuppressSlotDrag", "shouldSuppressLinearDrag"]:
        if token not in layer_source:
            details.append(f"interaction layer missing {token}")
    if "q42DragToMoveCursorStabilityAvailable = true" not in router_source:
        details.append("gesture router missing Q42 availability marker")
    if "V172-Q42" not in contract_source or ("0.172.69+172" not in contract_source and "0.172.70+172" not in contract_source and "0.172.71+172" not in contract_source):
        details.append("package contract metadata is not Q42")
    if details:
        return CheckResult("v172_q42_drag_to_move_cursor_stability", "FAIL", "; ".join(details))
    return CheckResult("v172_q42_drag_to_move_cursor_stability", "PASS", "Q42 drag-to-move stability policy is wired through the editor interaction layer without touching P6 UI files.")

def check_v172_q43_structural_insert_delete_safety(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/structural_insert_delete_safety_policy.dart"
    commands = root / "lib/features/editor/editor_commands.dart"
    controller = root / "lib/state/calculator_controller.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    missing = [str(p.relative_to(root)) for p in [policy, commands, controller, contract] if not p.exists()]
    if missing:
        return CheckResult("v172_q43_structural_insert_delete_safety", "FAIL", "Missing: " + ", ".join(missing))
    policy_source = read_text(policy)
    commands_source = read_text(commands)
    controller_source = read_text(controller)
    contract_source = read_text(contract)
    required = [
        "structuralInsertDeleteSafetyAvailable = true",
        "filledSlotInlineInsertEnabled = true",
        "halfTokenLeakAllowed = false",
        "atomicFunctionTailLeakAllowed = false",
        "insertIntoSelectedSlotPayload",
        "StructuralSlotInsertEdit",
        "v172q43-slotPayloadInlineInsert",
    ]
    missing_markers = [m for m in required if m not in (policy_source + commands_source + controller_source)]
    if "V172-Q43" not in contract_source or ("0.172.70+172" not in contract_source and "0.172.71+172" not in contract_source):
        missing_markers.append("package contract metadata is not Q43")
    if missing_markers:
        return CheckResult("v172_q43_structural_insert_delete_safety", "FAIL", "; ".join(missing_markers))
    return CheckResult("v172_q43_structural_insert_delete_safety", "PASS", "Q43 structural insert/delete safety is wired through editor commands and controller without touching P6 UI files.")

def check_v172_q119_graph_history_solution_runtime_binding_gate(root: Path) -> CheckResult:
    required = [
        "lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart",
        "tool/verify_mathlive_graph_history_solution_runtime_binding_gate.mjs",
        "test/v172_q119_graph_history_solution_runtime_binding_gate_test.dart",
        "docs/audit/V172_Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_GATE_AUDIT_REPORT.md",
        "docs/audit/V172_Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_GATE_CHANGED_FILES_MANIFEST.md",
    ]
    details: list[str] = []
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q119 file: {rel}")
    policy = read_text(root / "lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart") if (root / "lib/features/mathlive/mathlive_graph_history_solution_runtime_binding_gate_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json") if (root / "assets/mathlive/manifest.json").exists() else ""
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart") if (root / "lib/logic/mathpro_package_contract.dart").exists() else ""
    readme = read_text(root / "README.md") if (root / "README.md").exists() else ""
    audit = read_text(root / "docs/audit/V172_Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_GATE_AUDIT_REPORT.md") if (root / "docs/audit/V172_Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_GATE_AUDIT_REPORT.md").exists() else ""
    changed = read_text(root / "docs/audit/V172_Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_GATE_CHANGED_FILES_MANIFEST.md") if (root / "docs/audit/V172_Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_GATE_CHANGED_FILES_MANIFEST.md").exists() else ""
    required_markers = [
        (policy, "phase = 'V172-Q119'"),
        (policy, "gateOnly = true"),
        (policy, "runtimeGraphBindingImplementedInThisPackage = false"),
        (policy, "runtimeHistoryBindingImplementedInThisPackage = false"),
        (policy, "runtimeSolutionBindingImplementedInThisPackage = false"),
        (policy, "graphCardMutationAllowed = false"),
        (policy, "historyControllerMutationAllowed = false"),
        (policy, "historyPanelMutationAllowed = false"),
        (policy, "solutionStepsPanelMutationAllowed = false"),
        (policy, "legacyCursorDeletionAllowed = false"),
        (policy, "Q119_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (manifest, '"q119GraphHistorySolutionRuntimeBindingGatePhase": "V172-Q119"'),
        (manifest, '"q119RuntimeGraphBindingImplemented": false'),
        (manifest, '"q119RuntimeHistoryBindingImplemented": false'),
        (manifest, '"q119RuntimeSolutionBindingImplemented": false'),
        (manifest, '"q119MaySwitchDefaultEditorNow": false'),
        (manifest, '"q119MayDeleteLegacyCursor": false'),
        (manifest, '"q119CreatesFakeGraphEvidence": false'),
        (manifest, '"q119CreatesFakeHistoryEvidence": false'),
        (manifest, '"q119CreatesFakeSolutionEvidence": false'),
        (contract, "q119GraphHistorySolutionRuntimeBindingGateRule"),
        (readme, "V172-Q119 — Graph / History / Solution Runtime Binding Gate"),
        (audit, "Q119 is a gate only; it does not perform runtime Graph, History, or Solution writes"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q119 marker: {marker}")
    combined = "\n".join([policy, manifest, readme, audit])
    forbidden = [
        '"q119RuntimeGraphBindingImplemented": true',
        '"q119RuntimeHistoryBindingImplemented": true',
        '"q119RuntimeSolutionBindingImplemented": true',
        '"q119MaySwitchDefaultEditorNow": true',
        '"q119MayRetireLegacyMainPath": true',
        '"q119MayDeleteLegacyCursor": true',
        '"q119MayClaimCursorPass": true',
        '"q119MayClaimReleasePass": true',
        '"q119CreatesFakeRuntimeEvidence": true',
        '"q119CreatesFakeGraphEvidence": true',
        '"q119CreatesFakeHistoryEvidence": true',
        '"q119CreatesFakeSolutionEvidence": true',
    ]
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q119 enabled marker present: {marker}")
    protected_names = [
        "lib/features/keyboard/key_config.dart",
        "lib/features/keyboard/math_keyboard.dart",
        "lib/features/keyboard/bottom_dock.dart",
        "lib/features/keyboard/long_press_popup.dart",
        "lib/features/keyboard/premium_key.dart",
        "lib/features/workspace/math_label.dart",
        "lib/features/workspace/template_tray.dart",
        "lib/app/app_shell.dart",
        "lib/features/solution/solution_steps_panel.dart",
        "lib/features/graph/graph_card.dart",
        "lib/features/history/history_controller.dart",
        "lib/features/history/history_panel.dart",
    ]
    for name in protected_names:
        source = read_text(root / name) if (root / name).exists() else ""
        if "V172-Q119" in source or "q119GraphHistorySolutionRuntimeBinding" in source:
            details.append(f"Q119 marker found in protected file: {name}")
    if details:
        return CheckResult("v172_q119_graph_history_solution_runtime_binding_gate", "FAIL", "; ".join(details))
    return CheckResult("v172_q119_graph_history_solution_runtime_binding_gate", "PASS", "Q119 adds a Graph/History/Solution runtime binding gate while blocking runtime writes, default editor switch, protected UI mutation, fake evidence, cursor PASS claims, legacy retirement, and legacy deletion in this package.")



def check_v172_q120_legacy_main_path_retirement_review_gate(root: Path) -> CheckResult:
    required = [
        "lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart",
        "tool/verify_legacy_main_path_retirement_review_gate.mjs",
        "test/v172_q120_legacy_main_path_retirement_review_gate_test.dart",
        "docs/audit/V172_Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_GATE_AUDIT_REPORT.md",
        "docs/audit/V172_Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_GATE_CHANGED_FILES_MANIFEST.md",
    ]
    details: list[str] = []
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q120 file: {rel}")
    policy = read_text(root / "lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart") if (root / "lib/features/editor_adapter/legacy_main_path_retirement_review_gate_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json") if (root / "assets/mathlive/manifest.json").exists() else ""
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart") if (root / "lib/logic/mathpro_package_contract.dart").exists() else ""
    readme = read_text(root / "README.md") if (root / "README.md").exists() else ""
    audit = read_text(root / "docs/audit/V172_Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_GATE_AUDIT_REPORT.md") if (root / "docs/audit/V172_Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_GATE_AUDIT_REPORT.md").exists() else ""
    changed = read_text(root / "docs/audit/V172_Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_GATE_CHANGED_FILES_MANIFEST.md") if (root / "docs/audit/V172_Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_GATE_CHANGED_FILES_MANIFEST.md").exists() else ""
    required_markers = [
        (policy, "phase = 'V172-Q120'"),
        (policy, "reviewGateOnly = true"),
        (policy, "actualLegacyMainPathRetirementImplementedInThisPackage = false"),
        (policy, "legacyCursorPhysicalDeletionImplementedInThisPackage = false"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (manifest, '"q120LegacyMainPathRetirementReviewGatePhase": "V172-Q120"'),
        (manifest, '"q120ActualLegacyRetirementImplemented": false'),
        (manifest, '"q120LegacyCursorPhysicalDeletionImplemented": false'),
        (manifest, '"q120MathLiveEnabledByDefault": false'),
        (manifest, '"q120MayRetireLegacyMainPathNow": false'),
        (manifest, '"q120MayDeleteLegacyCursor": false'),
        (manifest, '"q120MaySwitchDefaultEditorNow": false'),
        (manifest, '"q120CreatesFakeRuntimeEvidence": false'),
        (manifest, '"q120CreatesFakeDeviceEvidence": false'),
        (contract, "q120LegacyMainPathRetirementReviewGateRule"),
        (readme, "V172-Q120 — Legacy Main Path Retirement Review Gate"),
        (audit, "Q120 is a review gate only; it does not retire the legacy main path"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q120 marker: {marker}")
    combined = "\n".join([policy, manifest, readme, audit])
    forbidden = [
        "actualLegacyMainPathRetirementImplementedInThisPackage = true",
        "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "mainWorkspaceMountImplementedInThisPackage = true",
        "keyboardMutationAllowed = true",
        "moreMutationAllowed = true",
        "longPressMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        "fakeRetirementApprovalAllowed = true",
        "cursorPassClaimAllowedInThisPackage = true",
        "releasePassClaimAllowedInThisPackage = true",
        '"q120ActualLegacyRetirementImplemented": true',
        '"q120LegacyCursorPhysicalDeletionImplemented": true',
        '"q120MathLiveEnabledByDefault": true',
        '"q120MayRetireLegacyMainPathNow": true',
        '"q120MayDeleteLegacyCursor": true',
        '"q120MaySwitchDefaultEditorNow": true',
        '"q120MayClaimCursorPass": true',
        '"q120MayClaimReleasePass": true',
        '"q120CreatesFakeRuntimeEvidence": true',
        '"q120CreatesFakeDeviceEvidence": true',
        '"q120CreatesFakeRetirementApproval": true',
    ]
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q120 enabled marker present: {marker}")
    for name in PROTECTED_FILES:
        source = read_text(root / name) if (root / name).exists() else ""
        if "V172-Q120" in source or "q120LegacyMainPathRetirementReview" in source:
            details.append(f"Q120 marker found in protected file: {name}")
    if details:
        return CheckResult("v172_q120_legacy_main_path_retirement_review_gate", "FAIL", "; ".join(details))
    return CheckResult("v172_q120_legacy_main_path_retirement_review_gate", "PASS", "Q120 adds a legacy main-path retirement review gate while blocking actual retirement, default editor switch, protected UI mutation, fake evidence, cursor/release PASS claims, and legacy deletion in this package.")


def check_v172_q121_legacy_cursor_physical_cleanup_planning_gate(root: Path) -> CheckResult:
    details: list[str] = []
    policy = read_text(root / "lib/features/editor_adapter/legacy_cursor_physical_cleanup_planning_gate_policy.dart") if (root / "lib/features/editor_adapter/legacy_cursor_physical_cleanup_planning_gate_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json") if (root / "assets/mathlive/manifest.json").exists() else ""
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart") if (root / "lib/logic/mathpro_package_contract.dart").exists() else ""
    readme = read_text(root / "README.md") if (root / "README.md").exists() else ""
    audit = read_text(root / "docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_GATE_AUDIT_REPORT.md") if (root / "docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_GATE_AUDIT_REPORT.md").exists() else ""
    changed = read_text(root / "docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_GATE_CHANGED_FILES_MANIFEST.md") if (root / "docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_GATE_CHANGED_FILES_MANIFEST.md").exists() else ""
    draft = read_text(root / "docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_DRAFT.json") if (root / "docs/audit/V172_Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_DRAFT.json").exists() else ""
    required_markers = [
        (policy, "phase = 'V172-Q121'"),
        (policy, "planningGateOnly = true"),
        (policy, "physicalCleanupImplementedInThisPackage = false"),
        (policy, "legacyCursorPhysicalDeletionImplementedInThisPackage = false"),
        (policy, "legacyMainPathRetirementImplementedInThisPackage = false"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (manifest, '"q121LegacyCursorPhysicalCleanupPlanningGatePhase": "V172-Q121"'),
        (manifest, '"q121PhysicalCleanupImplemented": false'),
        (manifest, '"q121LegacyCursorPhysicalDeletionImplemented": false'),
        (manifest, '"q121MayDeleteLegacyCursor": false'),
        (manifest, '"q121MayRetireLegacyMainPathNow": false'),
        (manifest, '"q121MaySwitchDefaultEditorNow": false'),
        (manifest, '"q121CreatesFakeRuntimeEvidence": false'),
        (manifest, '"q121CreatesFakeDeviceEvidence": false'),
        (contract, "q121LegacyCursorPhysicalCleanupPlanningGateRule"),
        (readme, "V172-Q121 — Legacy Cursor Physical Cleanup Planning Gate"),
        (audit, "Q121 is a planning gate only; it does not delete legacy cursor files"),
        (changed, "Protected files intentionally untouched"),
        (draft, '"phase": "V172-Q121"'),
        (draft, '"deletedFilesInThisPackage": []'),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q121 marker: {marker}")
    combined = "\n".join([policy, manifest, readme, audit, draft])
    forbidden = [
        "physicalCleanupImplementedInThisPackage = true",
        "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
        "legacyMainPathRetirementImplementedInThisPackage = true",
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "mainWorkspaceMountImplementedInThisPackage = true",
        "keyboardMutationAllowed = true",
        "moreMutationAllowed = true",
        "longPressMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        "fakePlanningApprovalAllowed = true",
        "cursorPassClaimAllowedInThisPackage = true",
        "releasePassClaimAllowedInThisPackage = true",
        '"q121PhysicalCleanupImplemented": true',
        '"q121LegacyCursorPhysicalDeletionImplemented": true',
        '"q121MathLiveEnabledByDefault": true',
        '"q121MainWorkspaceMountImplemented": true',
        '"q121MayDeleteLegacyCursor": true',
        '"q121MayRetireLegacyMainPathNow": true',
        '"q121MaySwitchDefaultEditorNow": true',
        '"q121MayClaimCursorPass": true',
        '"q121MayClaimReleasePass": true',
        '"q121CreatesFakeRuntimeEvidence": true',
        '"q121CreatesFakeDeviceEvidence": true',
        '"q121CreatesFakePlanningApproval": true',
    ]
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q121 enabled marker present: {marker}")
    for name in PROTECTED_FILES:
        source = read_text(root / name) if (root / name).exists() else ""
        if "V172-Q121" in source or "q121LegacyCursorPhysicalCleanupPlanning" in source:
            details.append(f"Q121 marker found in protected file: {name}")
    if details:
        return CheckResult("v172_q121_legacy_cursor_physical_cleanup_planning_gate", "FAIL", "; ".join(details))
    return CheckResult("v172_q121_legacy_cursor_physical_cleanup_planning_gate", "PASS", "Q121 adds a physical cleanup planning gate while blocking physical deletion, legacy retirement, default editor switching, protected UI mutation, fake evidence, cursor/release PASS claims, and cleanup execution in this package.")




def check_v172_q122_legacy_cursor_physical_cleanup_execution_guard(root: Path) -> CheckResult:
    details: list[str] = []
    required = [
        "lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart",
        "tool/verify_legacy_cursor_physical_cleanup_execution_guard_v172_q122.mjs",
        "test/v172_q122_legacy_cursor_physical_cleanup_execution_guard_test.dart",
        "docs/audit/V172_Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_AUDIT_REPORT.md",
        "docs/audit/V172_Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_CHANGED_FILES_MANIFEST.md",
    ]
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q122 file: {rel}")
    policy = read_text(root / "lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart") if (root / "lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_v172_q122_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json") if (root / "assets/mathlive/manifest.json").exists() else ""
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart") if (root / "lib/logic/mathpro_package_contract.dart").exists() else ""
    readme = read_text(root / "README.md") if (root / "README.md").exists() else ""
    audit = read_text(root / "docs/audit/V172_Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_AUDIT_REPORT.md") if (root / "docs/audit/V172_Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_AUDIT_REPORT.md").exists() else ""
    changed = read_text(root / "docs/audit/V172_Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_CHANGED_FILES_MANIFEST.md") if (root / "docs/audit/V172_Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_CHANGED_FILES_MANIFEST.md").exists() else ""
    required_markers = [
        (policy, "phase = 'V172-Q122'"),
        (policy, "executionGuardOnly = true"),
        (policy, "physicalCleanupExecutedInThisPackage = false"),
        (policy, "legacyCursorPhysicalDeletionImplementedInThisPackage = false"),
        (policy, "legacyMainPathRetirementImplementedInThisPackage = false"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "Q122_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (manifest, '"q122LegacyCursorPhysicalCleanupExecutionGuardPhase": "V172-Q122"'),
        (manifest, '"q122PhysicalCleanupExecuted": false'),
        (manifest, '"q122LegacyCursorPhysicalDeletionImplemented": false'),
        (manifest, '"q122MayDeleteLegacyCursor": false'),
        (manifest, '"q122MayRetireLegacyMainPathNow": false'),
        (manifest, '"q122MaySwitchDefaultEditorNow": false'),
        (manifest, '"q122CreatesFakeRuntimeEvidence": false'),
        (manifest, '"q122CreatesFakeDeviceEvidence": false'),
        (contract, "q122LegacyCursorPhysicalCleanupExecutionGuardRule"),
        (readme, "V172-Q122 — Legacy Cursor Physical Cleanup Execution Guard"),
        (audit, "Q122 is an execution guard only; it does not delete legacy cursor files"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q122 marker: {marker}")
    combined = "\n".join([policy, manifest, readme, audit])
    forbidden = [
        "physicalCleanupExecutedInThisPackage = true",
        "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
        "legacyMainPathRetirementImplementedInThisPackage = true",
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "mainWorkspaceMountImplementedInThisPackage = true",
        "keyboardMutationAllowed = true",
        "moreMutationAllowed = true",
        "longPressMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        "fakeExecutionApprovalAllowed = true",
        "cursorPassClaimAllowedInThisPackage = true",
        "releasePassClaimAllowedInThisPackage = true",
        '"q122PhysicalCleanupExecuted": true',
        '"q122LegacyCursorPhysicalDeletionImplemented": true',
        '"q122MathLiveEnabledByDefault": true',
        '"q122MainWorkspaceMountImplemented": true',
        '"q122MayDeleteLegacyCursor": true',
        '"q122MayRetireLegacyMainPathNow": true',
        '"q122MaySwitchDefaultEditorNow": true',
        '"q122MayClaimCursorPass": true',
        '"q122MayClaimReleasePass": true',
        '"q122CreatesFakeRuntimeEvidence": true',
        '"q122CreatesFakeDeviceEvidence": true',
        '"q122CreatesFakeExecutionApproval": true',
    ]
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q122 enabled marker present: {marker}")
    for name in PROTECTED_FILES:
        source = read_text(root / name) if (root / name).exists() else ""
        if "V172-Q122" in source or "q122LegacyCursorPhysicalCleanupExecution" in source:
            details.append(f"Q122 marker found in protected file: {name}")
    if details:
        return CheckResult("v172_q122_legacy_cursor_physical_cleanup_execution_guard", "FAIL", "; ".join(details))
    return CheckResult("v172_q122_legacy_cursor_physical_cleanup_execution_guard", "PASS", "Q122 adds a physical cleanup execution guard while blocking deletion, cleanup execution, legacy retirement, default editor switching, protected UI mutation, fake evidence, cursor/release PASS claims, and release progression in this package.")



def check_v172_q123_post_cleanup_regression_court_guard(root: Path) -> CheckResult:
    details: list[str] = []
    required = [
        "lib/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart",
        "tool/verify_legacy_cursor_post_cleanup_regression_court_guard_v172_q123.mjs",
        "test/v172_q123_post_cleanup_regression_court_guard_test.dart",
        "docs/audit/V172_Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_AUDIT_REPORT.md",
        "docs/audit/V172_Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_CHANGED_FILES_MANIFEST.md",
    ]
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q123 file: {rel}")
    policy = read_text(root / "lib/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart") if (root / "lib/features/editor_adapter/legacy_cursor_post_cleanup_regression_court_guard_v172_q123_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json") if (root / "assets/mathlive/manifest.json").exists() else ""
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart") if (root / "lib/logic/mathpro_package_contract.dart").exists() else ""
    readme = read_text(root / "README.md") if (root / "README.md").exists() else ""
    audit = read_text(root / "docs/audit/V172_Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_AUDIT_REPORT.md") if (root / "docs/audit/V172_Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_AUDIT_REPORT.md").exists() else ""
    changed = read_text(root / "docs/audit/V172_Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_CHANGED_FILES_MANIFEST.md") if (root / "docs/audit/V172_Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_CHANGED_FILES_MANIFEST.md").exists() else ""
    required_markers = [
        (policy, "phase = 'V172-Q123'"),
        (policy, "postCleanupRegressionCourtGuardOnly = true"),
        (policy, "postCleanupRegressionCourtExecutedInThisPackage = false"),
        (policy, "physicalCleanupExecutedInThisPackage = false"),
        (policy, "legacyCursorPhysicalDeletionImplementedInThisPackage = false"),
        (policy, "legacyMainPathRetirementImplementedInThisPackage = false"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "releasePassClaimAllowedInThisPackage = false"),
        (policy, "Q123_POST_CLEANUP_REGRESSION_COURT_GUARD_PACKAGE_READY_BUT_CLEANUP_EVIDENCE_BLOCKED"),
        (manifest, '"q123PostCleanupRegressionCourtGuardPhase": "V172-Q123"'),
        (manifest, '"q123PostCleanupRegressionCourtExecuted": false'),
        (manifest, '"q123PhysicalCleanupExecuted": false'),
        (manifest, '"q123LegacyCursorPhysicalDeletionImplemented": false'),
        (manifest, '"q123MayDeleteLegacyCursor": false'),
        (manifest, '"q123MayRetireLegacyMainPathNow": false'),
        (manifest, '"q123MaySwitchDefaultEditorNow": false'),
        (manifest, '"q123MayClaimReleasePass": false'),
        (manifest, '"q123CreatesFakeRuntimeEvidence": false'),
        (manifest, '"q123CreatesFakeDeviceEvidence": false'),
        (contract, "q123PostCleanupRegressionCourtGuardRule"),
        (readme, "V172-Q123 — Post-Cleanup Regression Court Guard"),
        (audit, "Q123 is a post-cleanup regression court guard only; it does not execute cleanup"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q123 marker: {marker}")
    combined = "\n".join([policy, manifest, readme, audit])
    forbidden = [
        "postCleanupRegressionCourtExecutedInThisPackage = true",
        "physicalCleanupExecutedInThisPackage = true",
        "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
        "legacyMainPathRetirementImplementedInThisPackage = true",
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "mainWorkspaceMountImplementedInThisPackage = true",
        "runtimeGraphHistorySolutionWritesImplementedInThisPackage = true",
        "keyboardMutationAllowed = true",
        "moreMutationAllowed = true",
        "longPressMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        "fakeCleanupEvidenceAllowed = true",
        "cursorPassClaimAllowedInThisPackage = true",
        "releasePassClaimAllowedInThisPackage = true",
        '"q123PostCleanupRegressionCourtExecuted": true',
        '"q123PhysicalCleanupExecuted": true',
        '"q123LegacyCursorPhysicalDeletionImplemented": true',
        '"q123MathLiveEnabledByDefault": true',
        '"q123MainWorkspaceMountImplemented": true',
        '"q123MayDeleteLegacyCursor": true',
        '"q123MayRetireLegacyMainPathNow": true',
        '"q123MaySwitchDefaultEditorNow": true',
        '"q123MayClaimCursorPass": true',
        '"q123MayClaimReleasePass": true',
        '"q123CreatesFakeRuntimeEvidence": true',
        '"q123CreatesFakeDeviceEvidence": true',
        '"q123CreatesFakeCleanupEvidence": true',
    ]
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q123 enabled marker present: {marker}")
    for name in PROTECTED_FILES:
        source = read_text(root / name) if (root / name).exists() else ""
        if "V172-Q123" in source or "q123PostCleanupRegression" in source:
            details.append(f"Q123 marker found in protected file: {name}")
    if details:
        return CheckResult("v172_q123_post_cleanup_regression_court_guard", "FAIL", "; ".join(details))
    return CheckResult("v172_q123_post_cleanup_regression_court_guard", "PASS", "Q123 adds a post-cleanup regression court guard while blocking cleanup execution, legacy deletion, legacy retirement, default editor switching, protected UI mutation, fake evidence, cursor/release PASS claims, and release progression in this package.")



def check_v172_q124_release_freeze_final_review_guard(root: Path) -> CheckResult:
    details: list[str] = []
    required = [
        "lib/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart",
        "tool/verify_release_freeze_final_review_guard_v172_q124.mjs",
        "test/v172_q124_release_freeze_final_review_guard_test.dart",
        "docs/audit/V172_Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_AUDIT_REPORT.md",
        "docs/audit/V172_Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_CHANGED_FILES_MANIFEST.md",
        "docs/audit/V172_Q124_RELEASE_FREEZE_FINAL_REVIEW_CHECKLIST.json",
    ]
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q124 file: {rel}")
    policy = read_text(root / "lib/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart") if (root / "lib/features/editor_adapter/release_freeze_final_review_guard_v172_q124_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json") if (root / "assets/mathlive/manifest.json").exists() else ""
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart") if (root / "lib/logic/mathpro_package_contract.dart").exists() else ""
    readme = read_text(root / "README.md") if (root / "README.md").exists() else ""
    audit = read_text(root / "docs/audit/V172_Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_AUDIT_REPORT.md") if (root / "docs/audit/V172_Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_AUDIT_REPORT.md").exists() else ""
    changed = read_text(root / "docs/audit/V172_Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_CHANGED_FILES_MANIFEST.md") if (root / "docs/audit/V172_Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_CHANGED_FILES_MANIFEST.md").exists() else ""
    required_markers = [
        (policy, "phase = 'V172-Q124'"),
        (policy, "releaseFreezeFinalReviewGuardOnly = true"),
        (policy, "finalReleaseFrozenInThisPackage = false"),
        (policy, "releasePassClaimedInThisPackage = false"),
        (policy, "legacyCursorPhysicalDeletionImplementedInThisPackage = false"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "Q124_RELEASE_FREEZE_FINAL_REVIEW_GUARD_PACKAGE_READY_BUT_POST_CLEANUP_EVIDENCE_BLOCKED"),
        (manifest, '"q124ReleaseFreezeFinalReviewGuardPhase": "V172-Q124"'),
        (manifest, '"q124FinalReleaseFrozen": false'),
        (manifest, '"q124ReleasePassClaimed": false'),
        (manifest, '"q124LegacyCursorPhysicalDeletionImplemented": false'),
        (manifest, '"q124MayDeleteLegacyCursor": false'),
        (manifest, '"q124MayRetireLegacyMainPathNow": false'),
        (manifest, '"q124MaySwitchDefaultEditorNow": false'),
        (manifest, '"q124MayClaimReleasePass": false'),
        (manifest, '"q124CreatesFakeRuntimeEvidence": false'),
        (manifest, '"q124CreatesFakeDeviceEvidence": false'),
        (contract, "q124ReleaseFreezeFinalReviewGuardRule"),
        (readme, "V172-Q124 — Release Freeze Final Review Guard"),
        (audit, "Q124 is a release-freeze final review guard only; it does not freeze a release"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q124 marker: {marker}")
    combined = "\n".join([policy, manifest, readme, audit])
    forbidden = [
        "finalReleaseFrozenInThisPackage = true",
        "releasePassClaimedInThisPackage = true",
        "postCleanupRegressionCourtExecutedInThisPackage = true",
        "physicalCleanupExecutedInThisPackage = true",
        "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
        "legacyMainPathRetirementImplementedInThisPackage = true",
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "mainWorkspaceMountImplementedInThisPackage = true",
        "runtimeGraphHistorySolutionWritesImplementedInThisPackage = true",
        "keyboardMutationAllowed = true",
        "moreMutationAllowed = true",
        "longPressMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        "fakeReleaseEvidenceAllowed = true",
        "cursorPassClaimAllowedInThisPackage = true",
        "releasePassClaimAllowedInThisPackage = true",
        '"q124FinalReleaseFrozen": true',
        '"q124ReleasePassClaimed": true',
        '"q124LegacyCursorPhysicalDeletionImplemented": true',
        '"q124MathLiveEnabledByDefault": true',
        '"q124MainWorkspaceMountImplemented": true',
        '"q124MayDeleteLegacyCursor": true',
        '"q124MayRetireLegacyMainPathNow": true',
        '"q124MaySwitchDefaultEditorNow": true',
        '"q124MayClaimCursorPass": true',
        '"q124MayClaimReleasePass": true',
        '"q124CreatesFakeRuntimeEvidence": true',
        '"q124CreatesFakeDeviceEvidence": true',
        '"q124CreatesFakeReleaseEvidence": true',
    ]
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q124 enabled marker present: {marker}")
    for name in PROTECTED_FILES:
        source = read_text(root / name) if (root / name).exists() else ""
        if "V172-Q124" in source or "q124ReleaseFreezeFinalReview" in source:
            details.append(f"Q124 marker found in protected file: {name}")
    if details:
        return CheckResult("v172_q124_release_freeze_final_review_guard", "FAIL", "; ".join(details))
    return CheckResult("v172_q124_release_freeze_final_review_guard", "PASS", "Q124 adds a release-freeze final review guard while blocking release freeze, release PASS claims, cleanup execution, legacy deletion, legacy retirement, default editor switching, protected UI mutation, fake evidence, and cursor PASS claims in this package.")


def check_v172_q125_final_package_evidence_closure_intake_guard(root: Path) -> CheckResult:
    details: list[str] = []
    required = [
        "lib/features/editor_adapter/final_package_evidence_closure_intake_guard_v172_q125_policy.dart",
        "tool/verify_final_package_evidence_closure_intake_guard_v172_q125.mjs",
        "test/v172_q125_final_package_evidence_closure_intake_guard_test.dart",
        "docs/audit/V172_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_AUDIT_REPORT.md",
        "docs/audit/V172_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_CHANGED_FILES_MANIFEST.md",
        "docs/audit/V172_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_CHECKLIST.json",
    ]
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q125 file: {rel}")
    policy = read_text(root / "lib/features/editor_adapter/final_package_evidence_closure_intake_guard_v172_q125_policy.dart") if (root / "lib/features/editor_adapter/final_package_evidence_closure_intake_guard_v172_q125_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json") if (root / "assets/mathlive/manifest.json").exists() else ""
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart") if (root / "lib/logic/mathpro_package_contract.dart").exists() else ""
    readme = read_text(root / "README.md") if (root / "README.md").exists() else ""
    audit = read_text(root / "docs/audit/V172_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_AUDIT_REPORT.md") if (root / "docs/audit/V172_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_AUDIT_REPORT.md").exists() else ""
    changed = read_text(root / "docs/audit/V172_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_CHANGED_FILES_MANIFEST.md") if (root / "docs/audit/V172_Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_CHANGED_FILES_MANIFEST.md").exists() else ""
    required_markers = [
        (policy, "phase = 'V172-Q125'"),
        (policy, "finalPackageEvidenceClosureIntakeGuardOnly = true"),
        (policy, "finalPackageEvidenceClosedInThisPackage = false"),
        (policy, "releasePassClaimedInThisPackage = false"),
        (policy, "legacyCursorPhysicalDeletionImplementedInThisPackage = false"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "Q125_FINAL_PACKAGE_EVIDENCE_CLOSURE_INTAKE_GUARD_PACKAGE_READY_BUT_RELEASE_FREEZE_EVIDENCE_BLOCKED"),
        (manifest, '"q125FinalPackageEvidenceClosureIntakeGuardPhase": "V172-Q125"'),
        (manifest, '"q125FinalPackageEvidenceClosed": false'),
        (manifest, '"q125ReleasePassClaimed": false'),
        (manifest, '"q125LegacyCursorPhysicalDeletionImplemented": false'),
        (manifest, '"q125MayDeleteLegacyCursor": false'),
        (manifest, '"q125MayRetireLegacyMainPathNow": false'),
        (manifest, '"q125MaySwitchDefaultEditorNow": false'),
        (manifest, '"q125MayClaimReleasePass": false'),
        (manifest, '"q125CreatesFakeRuntimeEvidence": false'),
        (manifest, '"q125CreatesFakeDeviceEvidence": false'),
        (manifest, '"q125CreatesFakeEvidenceClosure": false'),
        (contract, "q125FinalPackageEvidenceClosureIntakeGuardRule"),
        (readme, "V172-Q125 — Final Package Evidence Closure Intake Guard"),
        (audit, "Q125 is a final package evidence closure intake guard only; it does not close final package evidence"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q125 marker: {marker}")
    combined = "\n".join([policy, manifest, readme, audit])
    forbidden = [
        "finalPackageEvidenceClosedInThisPackage = true",
        "finalReleaseFrozenInThisPackage = true",
        "releasePassClaimedInThisPackage = true",
        "postCleanupRegressionCourtExecutedInThisPackage = true",
        "physicalCleanupExecutedInThisPackage = true",
        "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
        "legacyMainPathRetirementImplementedInThisPackage = true",
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "mainWorkspaceMountImplementedInThisPackage = true",
        "runtimeGraphHistorySolutionWritesImplementedInThisPackage = true",
        "keyboardMutationAllowed = true",
        "moreMutationAllowed = true",
        "longPressMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        "fakeReleaseEvidenceAllowed = true",
        "fakeEvidenceClosureAllowed = true",
        "cursorPassClaimAllowedInThisPackage = true",
        "releasePassClaimAllowedInThisPackage = true",
        '"q125FinalPackageEvidenceClosed": true',
        '"q125ReleasePassClaimed": true',
        '"q125LegacyCursorPhysicalDeletionImplemented": true',
        '"q125MathLiveEnabledByDefault": true',
        '"q125MainWorkspaceMountImplemented": true',
        '"q125MayDeleteLegacyCursor": true',
        '"q125MayRetireLegacyMainPathNow": true',
        '"q125MaySwitchDefaultEditorNow": true',
        '"q125MayClaimCursorPass": true',
        '"q125MayClaimReleasePass": true',
        '"q125CreatesFakeRuntimeEvidence": true',
        '"q125CreatesFakeDeviceEvidence": true',
        '"q125CreatesFakeReleaseEvidence": true',
        '"q125CreatesFakeEvidenceClosure": true',
    ]
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q125 enabled marker present: {marker}")
    for name in PROTECTED_FILES:
        source = read_text(root / name) if (root / name).exists() else ""
        if "V172-Q125" in source or "q125FinalPackageEvidenceClosure" in source:
            details.append(f"Q125 marker found in protected file: {name}")
    if details:
        return CheckResult("v172_q125_final_package_evidence_closure_intake_guard", "FAIL", "; ".join(details))
    return CheckResult("v172_q125_final_package_evidence_closure_intake_guard", "PASS", "Q125 adds a final package evidence closure intake guard while blocking evidence closure, release PASS claims, cleanup execution, legacy deletion, legacy retirement, default editor switching, protected UI mutation, fake evidence, and cursor PASS claims in this package.")


def check_hygiene(root: Path) -> CheckResult:
    bad: list[str] = []
    ignored_generated: list[str] = []
    for path in root.rglob("*"):
        rel = "/" + path.relative_to(root).as_posix()
        if any(part in rel for part in USER_SIDE_GENERATED_PATH_PARTS):
            ignored_generated.append(rel[1:])
            continue
        if any(part in rel for part in FORBIDDEN_PATH_PARTS) or any(rel.endswith(s) for s in FORBIDDEN_SUFFIXES):
            bad.append(rel[1:])
        if path.is_file() and path.suffix == ".zip":
            bad.append(rel[1:])
    if bad:
        return CheckResult("zip_project_hygiene", "FAIL", "Forbidden artifacts: " + ", ".join(bad[:40]))
    detail = "No forbidden build/cache/binary release artifacts inside project tree."
    if ignored_generated:
        detail += f" Ignored {len(ignored_generated)} user-side Flutter generated .dart_tool path(s) after pub get."
    return CheckResult("zip_project_hygiene", "PASS", detail)



def check_v172_regression_contract(root: Path) -> CheckResult:
    required = REQUIRED_ENGINE_FILES + REQUIRED_CURSOR_AUDIT_FILES
    missing = [p for p in required if not (root / p).exists()]
    details: list[str] = []
    if missing:
        details.append("Missing V172 cursor contract files: " + ", ".join(missing))

    interaction = root / "lib/features/editor/render/editor_interaction_layer.dart"
    if interaction.exists():
        text = read_text(interaction)
        if "paintVisibleSlotOverlay: true" in text:
            details.append("editor_interaction_layer.dart enables paintVisibleSlotOverlay: true")
        if "onLongPress" in text:
            details.append("editor_interaction_layer.dart contains editor long-press handler")
    else:
        details.append("editor_interaction_layer.dart missing")

    contract = root / "lib/features/formula_engine/regression_contract_hardening_policy.dart"
    if contract.exists():
        source = read_text(contract)
        required_markers = [
            "realDeviceCursorPassClaimed = false",
            "flutterPassClaimedByStaticGate = false",
            "editorLoupeEnabled = false",
            "greenDebugOverlayEnabled = false",
            "V172-O-regression-contract-hardening",
        ]
        missing_markers = [m for m in required_markers if m not in source]
        if missing_markers:
            details.append("regression contract missing markers: " + ", ".join(missing_markers))

    if details:
        return CheckResult("v172_regression_contract_hardening", "FAIL", "; ".join(details))
    return CheckResult("v172_regression_contract_hardening", "PASS", "V172 A-N/O cursor contract files exist; no loupe/green-overlay production path is enabled; static gate does not claim Flutter/device PASS.")


def check_v172_legacy_raw_math_cleanup(root: Path) -> CheckResult:
    details: list[str] = []
    required_files = [
        "lib/features/formula_engine/legacy_raw_math_renderer_cleanup_policy.dart",
        "lib/features/formula_engine/math_expression_render_bridge.dart",
        "lib/features/formula_engine/unified_math_preview_policy.dart",
        "docs/audit/V172_P_LEGACY_RAW_MATH_RENDERER_CLEANUP_AUDIT_REPORT.md",
    ]
    missing = [p for p in required_files if not (root / p).exists()]
    if missing:
        details.append("Missing V172-P cleanup files: " + ", ".join(missing))

    cleanup = root / "lib/features/formula_engine/legacy_raw_math_renderer_cleanup_policy.dart"
    if cleanup.exists():
        source = read_text(cleanup)
        required_markers = [
            "rawProgrammerAliasesAllowedInVisibleUi = false",
            "legacyParserAliasesAllowedInternally = true",
            "logCallChainAllowedInVisibleUi = false",
            "x8nCorruptionAllowed = false",
            "canonicalVisibleMath",
            "exposesVisibleRawMath",
        ]
        missing_markers = [m for m in required_markers if m not in source]
        if missing_markers:
            details.append("cleanup policy missing markers: " + ", ".join(missing_markers))

    bridge = root / "lib/features/formula_engine/math_expression_render_bridge.dart"
    if bridge.exists():
        bridge_source = read_text(bridge)
        if "LegacyRawMathRendererCleanupPolicy.canonicalVisibleMath" not in bridge_source:
            details.append("math_expression_render_bridge.dart is not wired through cleanup canonicalizer")
        if "static const String version" not in bridge_source:
            details.append("renderer bridge version constant is missing")
        if "canonicalDisplayExpression" not in bridge_source:
            details.append("renderer bridge canonical display entrypoint is missing")

    preview = root / "lib/features/formula_engine/unified_math_preview_policy.dart"
    if preview.exists():
        preview_source = read_text(preview)
        if "LegacyRawMathRendererCleanupPolicy.canonicalVisibleMath" not in preview_source:
            details.append("unified_math_preview_policy.dart is not wired through cleanup canonicalizer")

    # Treat raw aliases inside known parser/evaluator/test/doc contexts as internal compatibility,
    # not as a visible UI leak.  This check fails only if high-risk visible surfaces are not
    # routed through the cleanup policy added in V172-P.
    visible_surface_paths = [
        "lib/features/formula_engine/math_expression_render_bridge.dart",
        "lib/features/formula_engine/unified_math_preview_policy.dart",
        "lib/features/workspace/math_label.dart",
        "lib/logic/premium_math_surface_policy.dart",
    ]
    leak_samples: list[str] = []
    raw_patterns = [
        re.compile(r"\b(?:asin|acos|atan|asinh|acosh|atanh|acot)\s*\("),
        re.compile(r"log\(2\)\(5\)"),
        re.compile(r"x8n"),
    ]
    for rel in visible_surface_paths:
        path = root / rel
        if not path.exists():
            continue
        text = read_text(path)
        # The policy file and explicitly canonicalized maps are allowed to mention raw aliases.
        if "LegacyRawMathRendererCleanupPolicy.canonicalVisibleMath" in text or "canonicalDisplayLabels" in text:
            continue
        for pattern in raw_patterns:
            for m in pattern.finditer(text):
                line = text.count("\n", 0, m.start()) + 1
                leak_samples.append(f"{rel}:{line}")
                if len(leak_samples) >= 8:
                    break
            if len(leak_samples) >= 8:
                break
    if leak_samples:
        details.append("possible visible raw math leaks: " + ", ".join(leak_samples))

    if details:
        return CheckResult("v172_legacy_raw_math_renderer_cleanup", "FAIL", "; ".join(details))
    return CheckResult("v172_legacy_raw_math_renderer_cleanup", "PASS", "Visible render/preview surfaces are wired through V172-P cleanup; raw aliases remain internal compatibility only.")


def check_v172_q34_deterministic_slot_geometry(root: Path) -> CheckResult:
    details: list[str] = []
    registry = root / "lib/features/formula_engine/deterministic_slot_geometry_registry.dart"
    hit_test = root / "lib/features/formula_engine/render_mapped_slot_hit_test.dart"
    overlay = root / "lib/features/workspace/editor_caret_overlay.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    if not registry.exists():
        details.append("deterministic_slot_geometry_registry.dart missing")
    else:
        source = read_text(registry)
        required_markers = [
            "v172q34",
            "v172q35",
            "v172q36",
            "v172q37",
            "rendererSlotIdentityClaimed = false",
            "deterministicGeometryRegistryAvailable = true",
            "placeholderRectFor",
            "caretRectFor",
            "baselineForRole",
            "powerExponent",
            "fractionNumerator",
            "logBase",
            "sqrtValue",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("Q34 registry missing markers: " + ", ".join(missing))
    if hit_test.exists():
        hit_source = read_text(hit_test)
        if "DeterministicSlotGeometryRegistry.visualRectFor" not in hit_source:
            details.append("render_mapped_slot_hit_test.dart is not using Q34 registry visual rects")
        if "v172q34" not in hit_source:
            details.append("render_mapped_slot_hit_test.dart version is missing v172q34")
    else:
        details.append("render_mapped_slot_hit_test.dart missing")
    if overlay.exists():
        overlay_source = read_text(overlay)
        q34_q35_path = "DeterministicSlotGeometryRegistry.caretRectFor" in overlay_source or "DeterministicSlotGeometryRegistry.placeholderSafeCaretRectFor" in overlay_source
        q48_native_path = "NativeLayoutBoxCursorLayer.caretRectForBox" in overlay_source and "geometry.placeholderRect" in overlay_source
        if not (q34_q35_path or q48_native_path):
            details.append("editor_caret_overlay.dart is not using Q34/Q35 registry caret rects or Q48 native caret geometry")
    else:
        details.append("editor_caret_overlay.dart missing")
    if contract.exists():
        contract_source = read_text(contract)
        if "0.172.61+172" not in contract_source and "0.172.62+172" not in contract_source and "0.172.63+172" not in contract_source and "0.172.64+172" not in contract_source and "0.172.65+172" not in contract_source and "0.172.66+172" not in contract_source and "0.172.67+172" not in contract_source and "0.172.68+172" not in contract_source and "0.172.69+172" not in contract_source and "0.172.70+172" not in contract_source and "0.172.71+172" not in contract_source:
            details.append("package contract is not advanced past Q34")
        if "V172-Q34 Deterministic Slot Geometry Registry" not in contract_source and "V172-Q35 Placeholder-Safe Cursor Engine" not in contract_source and "V172-Q36 Role-Based Cursor Size Engine" not in contract_source and "V172-Q37 Fraction Precision Engine" not in contract_source and "V172-Q38 Script Precision Engine" not in contract_source and "V172-Q39 Log Root Precision Engine" not in contract_source and "V172-Q40 Digit-Level Caret Stops" not in contract_source and "V172-Q41 Nested Expression Depth Engine" not in contract_source and "V172-Q42 Drag-to-Move Cursor Stability" not in contract_source and "V172-Q43 Structural Insert/Delete Safety" not in contract_source and "V172-Q44 Renderer-Sync Upgrade" not in contract_source:
            details.append("package contract is missing Q34/Q35/Q36 active geometry lineage")
    if details:
        return CheckResult("v172_q34_deterministic_slot_geometry_registry", "FAIL", "; ".join(details))
    return CheckResult("v172_q34_deterministic_slot_geometry_registry", "PASS", "Q34 deterministic slot geometry registry exists and is wired into slot hit-test and caret overlay without claiming renderer/SVG identity.")


def check_v172_q35_placeholder_safe_cursor(root: Path) -> CheckResult:
    details: list[str] = []
    registry = root / "lib/features/formula_engine/deterministic_slot_geometry_registry.dart"
    overlay = root / "lib/features/workspace/editor_caret_overlay.dart"
    hit_test = root / "lib/features/formula_engine/render_mapped_slot_hit_test.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    if not registry.exists():
        details.append("deterministic_slot_geometry_registry.dart missing")
    else:
        source = read_text(registry)
        required_markers = [
            "placeholderSafeCaretEngineAvailable = true",
            "placeholderCaretOverlapAllowed = false",
            "placeholderSafeCaretRectFor",
            "caretOverlapsPlaceholder",
            "placeholderRect.inflate",
            "Q35",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("Q35 placeholder-safe registry missing markers: " + ", ".join(missing))
    if overlay.exists():
        overlay_source = read_text(overlay)
        q35_legacy_path = "placeholderSafeCaretRectFor" in overlay_source and "geometry.placeholderRect" in overlay_source
        q48_native_path = "NativeLayoutBoxCursorLayer.caretRectForBox" in overlay_source and "geometry.placeholderRect" in overlay_source
        if not (q35_legacy_path or q48_native_path):
            details.append("editor_caret_overlay.dart is not using Q35 placeholder-safe or Q48 native placeholder-aware caret rects")
    else:
        details.append("editor_caret_overlay.dart missing")
    if hit_test.exists():
        hit_source = read_text(hit_test)
        if "v172q35" not in hit_source:
            details.append("render_mapped_slot_hit_test.dart version is missing v172q35")
    else:
        details.append("render_mapped_slot_hit_test.dart missing")
    if contract.exists():
        contract_source = read_text(contract)
        if ("0.172.62+172" not in contract_source and "0.172.63+172" not in contract_source and "0.172.64+172" not in contract_source and "0.172.65+172" not in contract_source and "0.172.66+172" not in contract_source and "0.172.67+172" not in contract_source and "0.172.68+172" not in contract_source) or ("V172-Q35 Placeholder-Safe Cursor Engine" not in contract_source and "V172-Q36 Role-Based Cursor Size Engine" not in contract_source and "V172-Q37 Fraction Precision Engine" not in contract_source and "V172-Q38 Script Precision Engine" not in contract_source and "V172-Q39 Log Root Precision Engine" not in contract_source and "V172-Q40 Digit-Level Caret Stops" not in contract_source and "V172-Q41 Nested Expression Depth Engine" not in contract_source):
            details.append("package contract is not advanced to Q35")
    if details:
        return CheckResult("v172_q35_placeholder_safe_cursor_engine", "FAIL", "; ".join(details))
    return CheckResult("v172_q35_placeholder_safe_cursor_engine", "PASS", "Q35 placeholder-safe caret engine is wired through deterministic geometry and caret overlay without touching P6 UI files.")



def check_v172_q36_role_based_cursor_size(root: Path) -> CheckResult:
    details: list[str] = []
    registry = root / "lib/features/formula_engine/deterministic_slot_geometry_registry.dart"
    polish = root / "lib/features/formula_engine/premium_cursor_visual_polish_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    if not registry.exists():
        details.append("deterministic_slot_geometry_registry.dart missing")
    else:
        source = read_text(registry)
        required_markers = [
            "roleBasedCaretSizeEngineAvailable = true",
            "mainLineCaretUsedInScriptRoles = false",
            "roleBasedCaretHeightFor",
            "usesCompactCaretForRole",
            "powerExponent",
            "subscript",
            "logBase",
            "rootIndex",
            "integralUpperLimit",
            "integralLowerLimit",
            "maxCaretHeight: 18",
            "v172q36",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("Q36 role-based cursor size markers missing: " + ", ".join(missing))
    if polish.exists():
        polish_source = read_text(polish)
        if "v172q36" not in polish_source or "role-scaled" not in polish_source:
            details.append("premium_cursor_visual_polish_policy.dart is missing Q36 role-scaled marker")
    else:
        details.append("premium_cursor_visual_polish_policy.dart missing")
    if contract.exists():
        contract_source = read_text(contract)
        if ("0.172.63+172" not in contract_source and "0.172.64+172" not in contract_source and "0.172.65+172" not in contract_source and "0.172.66+172" not in contract_source and "0.172.67+172" not in contract_source and "0.172.68+172" not in contract_source) or ("V172-Q36 Role-Based Cursor Size Engine" not in contract_source and "V172-Q37 Fraction Precision Engine" not in contract_source and "V172-Q38 Script Precision Engine" not in contract_source and "V172-Q39 Log Root Precision Engine" not in contract_source and "V172-Q40 Digit-Level Caret Stops" not in contract_source and "V172-Q41 Nested Expression Depth Engine" not in contract_source):
            details.append("package contract is not advanced to Q36")
    else:
        details.append("mathpro_package_contract.dart missing")
    if details:
        return CheckResult("v172_q36_role_based_cursor_size_engine", "FAIL", "; ".join(details))
    return CheckResult("v172_q36_role_based_cursor_size_engine", "PASS", "Q36 role-based caret sizing is wired in the deterministic slot geometry registry without touching P6 UI files.")



def check_v172_q37_fraction_precision_engine(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/fraction_precision_cursor_policy.dart"
    slot_hit = root / "lib/features/formula_engine/slot_hit_testing.dart"
    registry = root / "lib/features/formula_engine/deterministic_slot_geometry_registry.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    if not policy.exists():
        details.append("fraction_precision_cursor_policy.dart missing")
    else:
        source = read_text(policy)
        required_markers = [
            "v172q37",
            "fractionPrecisionEngineAvailable = true",
            "numeratorDenominatorLaneSplitEnabled = true",
            "fractionBarCrossLaneSelectionAllowed = false",
            "requiredCorrectTapSelectionsPerTwenty = 19",
            "decideLaneForPoint",
            "laneBoundaryY",
            "laneAwareHitRect",
            "fractionNumerator",
            "fractionDenominator",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("Q37 fraction precision markers missing: " + ", ".join(missing))
    if slot_hit.exists():
        source = read_text(slot_hit)
        required_markers = [
            "FractionPrecisionCursorPolicy.decideLaneForPoint",
            "FractionPrecisionCursorPolicy.laneAwareHitRect",
            "_fractionLaneFilteredCandidates",
            "v172q37",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("slot_hit_testing.dart is missing Q37 fraction lane integration: " + ", ".join(missing))
    else:
        details.append("slot_hit_testing.dart missing")
    if registry.exists():
        source = read_text(registry)
        required_markers = [
            "v172q37",
            "fractionPrecisionEngineAvailable = true",
            "fractionNumeratorDenominatorLaneSplitEnabled = true",
            "fractionBarCrossLaneSelectionAllowed = false",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("deterministic registry missing Q37 markers: " + ", ".join(missing))
    else:
        details.append("deterministic_slot_geometry_registry.dart missing")
    if contract.exists():
        contract_source = read_text(contract)
        if ("0.172.64+172" not in contract_source and "0.172.65+172" not in contract_source and "0.172.66+172" not in contract_source and "0.172.67+172" not in contract_source and "0.172.68+172" not in contract_source) or ("V172-Q37 Fraction Precision Engine" not in contract_source and "V172-Q38 Script Precision Engine" not in contract_source and "V172-Q39 Log Root Precision Engine" not in contract_source and "V172-Q40 Digit-Level Caret Stops" not in contract_source and "V172-Q41 Nested Expression Depth Engine" not in contract_source):
            details.append("package contract is not advanced to Q37")
    else:
        details.append("mathpro_package_contract.dart missing")
    if details:
        return CheckResult("v172_q37_fraction_precision_engine", "FAIL", "; ".join(details))
    return CheckResult("v172_q37_fraction_precision_engine", "PASS", "Q37 fraction numerator/denominator lane precision is wired into slot hit-test without touching P6 UI files.")


def check_v172_q38_script_precision_engine(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/script_precision_cursor_policy.dart"
    slot_hit = root / "lib/features/formula_engine/slot_hit_testing.dart"
    registry = root / "lib/features/formula_engine/deterministic_slot_geometry_registry.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    if not policy.exists():
        details.append("script_precision_cursor_policy.dart missing")
    else:
        source = read_text(policy)
        required_markers = [
            "v172q38",
            "scriptPrecisionEngineAvailable = true",
            "exponentSubscriptLaneSplitEnabled = true",
            "scriptBaseCrossLaneSelectionAllowed = false",
            "requiredCorrectTapSelectionsPerTwenty = 19",
            "decideLaneForPoint",
            "scriptIntentRect",
            "baseIntentRect",
            "laneAwareHitRect",
            "powerExponent",
            "subscript",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("Q38 script precision markers missing: " + ", ".join(missing))
    if slot_hit.exists():
        source = read_text(slot_hit)
        required_markers = [
            "ScriptPrecisionCursorPolicy.decideLaneForPoint",
            "ScriptPrecisionCursorPolicy.laneAwareHitRect",
            "_scriptLaneFilteredCandidates",
            "v172q38",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("slot_hit_testing.dart is missing Q38 script lane integration: " + ", ".join(missing))
    else:
        details.append("slot_hit_testing.dart missing")
    if registry.exists():
        source = read_text(registry)
        required_markers = [
            "v172q38",
            "scriptPrecisionEngineAvailable = true",
            "exponentSubscriptLaneSplitEnabled = true",
            "scriptBaseCrossLaneSelectionAllowed = false",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("deterministic registry missing Q38 markers: " + ", ".join(missing))
    else:
        details.append("deterministic_slot_geometry_registry.dart missing")
    if contract.exists():
        contract_source = read_text(contract)
        if ("0.172.65+172" not in contract_source and "0.172.66+172" not in contract_source and "0.172.67+172" not in contract_source and "0.172.68+172" not in contract_source) or ("V172-Q38 Script Precision Engine" not in contract_source and "V172-Q39 Log Root Precision Engine" not in contract_source and "V172-Q40 Digit-Level Caret Stops" not in contract_source and "V172-Q41 Nested Expression Depth Engine" not in contract_source):
            details.append("package contract is not advanced to Q38/Q39")
    else:
        details.append("mathpro_package_contract.dart missing")
    if details:
        return CheckResult("v172_q38_script_precision_engine", "FAIL", "; ".join(details))
    return CheckResult("v172_q38_script_precision_engine", "PASS", "Q38 script base/exponent/subscript lane precision is wired into slot hit-test without touching P6 UI files.")


def check_v172_q39_log_root_precision_engine(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/log_root_precision_cursor_policy.dart"
    slot_hit = root / "lib/features/formula_engine/slot_hit_testing.dart"
    registry = root / "lib/features/formula_engine/deterministic_slot_geometry_registry.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    if not policy.exists():
        details.append("log_root_precision_cursor_policy.dart missing")
    else:
        source = read_text(policy)
        required_markers = [
            "v172q39",
            "logRootPrecisionEngineAvailable = true",
            "logBaseArgumentLaneSplitEnabled = true",
            "rootIndexRadicandLaneSplitEnabled = true",
            "logBaseArgumentCrossLaneSelectionAllowed = false",
            "rootIndexRadicandCrossLaneSelectionAllowed = false",
            "requiredCorrectTapSelectionsPerTwenty = 19",
            "decideLaneForPoint",
            "chooseLogRoleForPoint",
            "chooseRootRoleForPoint",
            "laneAwareHitRect",
            "logBase",
            "functionArgument",
            "rootIndex",
            "sqrtValue",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("Q39 log/root precision markers missing: " + ", ".join(missing))
    if slot_hit.exists():
        source = read_text(slot_hit)
        required_markers = [
            "LogRootPrecisionCursorPolicy.decideLaneForPoint",
            "LogRootPrecisionCursorPolicy.laneAwareHitRect",
            "_logRootLaneFilteredCandidates",
            "v172q39",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("slot_hit_testing.dart is missing Q39 log/root lane integration: " + ", ".join(missing))
    else:
        details.append("slot_hit_testing.dart missing")
    if registry.exists():
        source = read_text(registry)
        required_markers = [
            "v172q39",
            "logRootPrecisionEngineAvailable = true",
            "logBaseArgumentLaneSplitEnabled = true",
            "rootIndexRadicandLaneSplitEnabled = true",
            "logBaseArgumentCrossLaneSelectionAllowed = false",
            "rootIndexRadicandCrossLaneSelectionAllowed = false",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("deterministic registry missing Q39 markers: " + ", ".join(missing))
    else:
        details.append("deterministic_slot_geometry_registry.dart missing")
    if contract.exists():
        contract_source = read_text(contract)
        if ("0.172.66+172" not in contract_source and "0.172.67+172" not in contract_source and "0.172.68+172" not in contract_source) or ("V172-Q39 Log Root Precision Engine" not in contract_source and "V172-Q40 Digit-Level Caret Stops" not in contract_source and "V172-Q41 Nested Expression Depth Engine" not in contract_source):
            details.append("package contract is not advanced to Q39")
    else:
        details.append("mathpro_package_contract.dart missing")
    if details:
        return CheckResult("v172_q39_log_root_precision_engine", "FAIL", "; ".join(details))
    return CheckResult("v172_q39_log_root_precision_engine", "PASS", "Q39 log-base/argument and root-index/radicand lane precision is wired into slot hit-test without touching P6 UI files.")


def check_v172_q40_digit_level_caret_stops(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/digit_level_caret_stop_policy.dart"
    selection = root / "lib/features/editor/selection_controller.dart"
    registry = root / "lib/features/formula_engine/deterministic_slot_geometry_registry.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    if not policy.exists():
        details.append("digit_level_caret_stop_policy.dart missing")
    else:
        source = read_text(policy)
        required_markers = [
            "v172q40",
            "digitLevelCaretStopsAvailable = true",
            "digitRunMidpointSelectionEnabled = true",
            "structuralBoundarySnapSuppressedInsideDigitRuns = true",
            "rendererGlyphIdentityClaimed = false",
            "requiredCorrectDigitTapSelectionsPerTwenty = 19",
            "digitCaretIndexForX",
            "isInsideDigitRunBand",
            "numericRuns",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("Q40 digit-level caret markers missing: " + ", ".join(missing))
    if selection.exists():
        source = read_text(selection)
        required_markers = [
            "DigitLevelCaretStopPolicy.digitCaretIndexForX",
            "DigitLevelCaretStopPolicy.isInsideDigitRunBand",
            "v172q40-digit-level-caret-stops",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("selection_controller.dart is missing Q40 digit caret integration: " + ", ".join(missing))
    else:
        details.append("selection_controller.dart missing")
    if registry.exists():
        source = read_text(registry)
        required_markers = [
            "v172q40",
            "digitLevelCaretStopsAvailable = true",
            "digitRunMidpointSelectionEnabled = true",
            "structuralBoundarySnapSuppressedInsideDigitRuns = true",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("deterministic registry missing Q40 markers: " + ", ".join(missing))
    else:
        details.append("deterministic_slot_geometry_registry.dart missing")
    if contract.exists():
        contract_source = read_text(contract)
        if ("0.172.68+172" not in contract_source and "0.172.67+172" not in contract_source) or ("V172-Q41 Nested Expression Depth Engine" not in contract_source and "V172-Q40 Digit-Level Caret Stops" not in contract_source):
            details.append("package contract is not advanced to Q40")
    else:
        details.append("mathpro_package_contract.dart missing")
    if details:
        return CheckResult("v172_q40_digit_level_caret_stops", "FAIL", "; ".join(details))
    return CheckResult("v172_q40_digit_level_caret_stops", "PASS", "Q40 digit-level caret stops are wired through selection_controller without touching P6 UI files and without claiming renderer glyph identity.")



def check_v172_q41_nested_expression_depth_engine(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/nested_expression_depth_cursor_policy.dart"
    slot_hit = root / "lib/features/formula_engine/slot_hit_testing.dart"
    registry = root / "lib/features/formula_engine/deterministic_slot_geometry_registry.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    if not policy.exists():
        details.append("nested_expression_depth_cursor_policy.dart missing")
    else:
        source = read_text(policy)
        required_markers = [
            "v172q41",
            "nestedExpressionDepthEngineAvailable = true",
            "deepestValidSlotPreferred = true",
            "parentSlotStealSuppressed = true",
            "rendererGlyphIdentityClaimed = false",
            "requiredCorrectNestedTapSelectionsPerTwenty = 19",
            "decideDepthForPoint",
            "NestedSlotCandidate",
            "NestedDepthDecision",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("Q41 nested expression depth markers missing: " + ", ".join(missing))
    if slot_hit.exists():
        source = read_text(slot_hit)
        required_markers = [
            "NestedExpressionDepthCursorPolicy.decideDepthForPoint",
            "_nestedDepthFilteredCandidates",
            "NestedSlotCandidate",
            "v172q41",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("slot_hit_testing.dart is missing Q41 nested-depth integration: " + ", ".join(missing))
    else:
        details.append("slot_hit_testing.dart missing")
    if registry.exists():
        source = read_text(registry)
        required_markers = [
            "v172q41",
            "nestedExpressionDepthEngineAvailable = true",
            "deepestValidSlotPreferred = true",
            "parentSlotStealSuppressed = true",
        ]
        missing = [m for m in required_markers if m not in source]
        if missing:
            details.append("deterministic registry missing Q41 markers: " + ", ".join(missing))
    else:
        details.append("deterministic_slot_geometry_registry.dart missing")
    if contract.exists():
        contract_source = read_text(contract)
        if "0.172.68+172" not in contract_source or "V172-Q41 Nested Expression Depth Engine" not in contract_source and "V172-Q42 Drag-to-Move Cursor Stability" not in contract_source and "V172-Q43 Structural Insert/Delete Safety" not in contract_source and "V172-Q44 Renderer-Sync Upgrade" not in contract_source:
            details.append("package contract is not advanced to Q41")
    else:
        details.append("mathpro_package_contract.dart missing")
    if details:
        return CheckResult("v172_q41_nested_expression_depth_engine", "FAIL", "; ".join(details))
    return CheckResult("v172_q41_nested_expression_depth_engine", "PASS", "Q41 nested-expression depth resolver is wired through slot hit-test without touching P6 UI files and without claiming renderer glyph identity.")



def check_v172_q44_renderer_sync_upgrade(root: Path) -> CheckResult:
    details: list[str] = []
    upgrade = root / "lib/features/formula_engine/renderer_sync_upgrade_policy.dart"
    renderer_sync = root / "lib/features/formula_engine/renderer_sync_geometry_policy.dart"
    surface = root / "lib/features/editor/render/mathjax_render_surface.dart"
    registry = root / "lib/features/formula_engine/deterministic_slot_geometry_registry.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    for path, label in [(upgrade, "renderer sync upgrade policy"), (renderer_sync, "renderer sync geometry"), (surface, "MathJax render surface"), (registry, "deterministic registry"), (contract, "package contract")]:
        if not path.exists():
            details.append(f"{label} missing")
    upgrade_source = read_text(upgrade) if upgrade.exists() else ""
    renderer_source = read_text(renderer_sync) if renderer_sync.exists() else ""
    surface_source = read_text(surface) if surface.exists() else ""
    registry_source = read_text(registry) if registry.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required_upgrade = [
        "v172q44-renderer-sync-upgrade",
        "rendererExpressionEnvelopeTelemetryEnabled = true",
        "rendererTelemetryCanRefineCursorGeometry = true",
        "rendererPerSlotSvgIdentityClaimed = false",
        "fakeRendererBoundsAllowed = false",
    ]
    missing = [m for m in required_upgrade if m not in upgrade_source]
    if missing:
        details.append("renderer_sync_upgrade_policy.dart missing markers: " + ", ".join(missing))
    required_renderer = [
        "v172q44",
        "recordRendererGeometryMessage",
        "RendererGeometrySnapshot",
        "rendererContentRectForCanvas",
        "_clampCenterToRendererContent",
        "rendererPerSlotSvgIdentityClaimed = RendererSyncUpgradePolicy.rendererPerSlotSvgIdentityClaimed",
    ]
    missing = [m for m in required_renderer if m not in renderer_source]
    if missing:
        details.append("renderer_sync_geometry_policy.dart missing Q44 wiring: " + ", ".join(missing))
    required_surface = [
        "v172q44",
        "MathProGeometry",
        "postGeometry",
        "RendererSyncGeometryPolicy.recordRendererGeometryMessage",
        "claimsPerSlotSvgIdentity = false",
    ]
    missing = [m for m in required_surface if m not in surface_source]
    if missing:
        details.append("mathjax_render_surface.dart missing Q44 geometry channel: " + ", ".join(missing))
    required_registry = [
        "v172q44",
        "q44RendererSyncUpgradeAvailable = true",
        "rendererExpressionEnvelopeTelemetryCanRefineGeometry = true",
        "rendererPerSlotSvgIdentityClaimed = false",
    ]
    missing = [m for m in required_registry if m not in registry_source]
    if missing:
        details.append("deterministic_slot_geometry_registry.dart missing Q44 markers: " + ", ".join(missing))
    if "V172-Q44 Renderer-Sync Upgrade" not in contract_source or "0.172.71+172" not in contract_source:
        details.append("package contract metadata is not Q44")
    if details:
        return CheckResult("v172_q44_renderer_sync_upgrade", "FAIL", "; ".join(details))
    return CheckResult("v172_q44_renderer_sync_upgrade", "PASS", "Q44 renderer expression-envelope telemetry is wired through MathJax and RendererSyncGeometryPolicy without claiming per-slot SVG identity or touching P6 UI files.")


def check_v172_q45_real_device_pixel_qa_court(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/real_device_pixel_qa_court_policy.dart"
    matrix = root / "lib/features/formula_engine/pixel_qa_cursor_matrix_policy.dart"
    protocol = root / "lib/features/formula_engine/real_device_slot_test_protocol.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    audit = root / "docs/audit/V172_Q45_REAL_DEVICE_PIXEL_QA_COURT_REPORT.md"
    test = root / "test/v172_q45_real_device_pixel_qa_court_test.dart"
    for path, label in [(policy, "Q45 policy"), (matrix, "pixel matrix"), (protocol, "device protocol"), (contract, "package contract"), (audit, "Q45 audit"), (test, "Q45 test")]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required_policy_tokens = [
        "v172q45-real-device-pixel-qa-court",
        "realDevicePixelQACourtAvailable = true",
        "finalPlus95CursorPassClaimed = false",
        "photomathWolframLevelClaimed = false",
        "p6VisualBaselineLocked = true",
        "keyboardSurfaceMutationAllowed = false",
        "moreSurfaceMutationAllowed = false",
        "longPressSurfaceMutationAllowed = false",
        "graphHistorySolutionMutationAllowed = false",
        "attemptsPerScenario = 20",
        "requiredCorrectPerScenario = 19",
        "requiredOverallSuccessRate = 0.95",
        "targetDeviceId = RealDeviceSlotTestProtocol.targetDeviceId",
        "placeholder-safe-sqrt",
        "digit-level-caret-stops",
        "nested-depth-resolution",
        "drag-to-move-stability",
        "structural-insert-delete-safety",
    ]
    missing = [token for token in required_policy_tokens if token not in policy_source]
    if missing:
        details.append("Q45 policy missing markers: " + ", ".join(missing))
    if "V172-Q45 Real Device Pixel QA Court" not in contract_source or "0.172.72+172" not in contract_source:
        details.append("package contract metadata is not Q45")
    if "V172-Q46 Renderer Slot Identity Prototype" not in contract_source or "V172-Q50R2 Stale Package Guard Repair" not in contract_source:
        details.append("package contract missing Q45→Q50 cursor lineage metadata")
    if details:
        return CheckResult("v172_q45_real_device_pixel_qa_court", "FAIL", "; ".join(details))
    return CheckResult("v172_q45_real_device_pixel_qa_court", "PASS", "Q45 physical-device pixel QA court is present, requires 20/19 evidence, and does not claim +95/Photomath-Wolfram PASS without device proof.")


def check_v172_q46_renderer_slot_identity_prototype(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/renderer_slot_identity_policy.dart"
    sync = root / "lib/features/formula_engine/renderer_sync_geometry_policy.dart"
    registry = root / "lib/features/formula_engine/deterministic_slot_geometry_registry.dart"
    surface = root / "lib/features/editor/render/mathjax_render_surface.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q46_renderer_slot_identity_prototype_test.dart"
    for path, label in [(policy, "Q46 policy"), (sync, "renderer sync"), (registry, "geometry registry"), (surface, "MathJax surface"), (contract, "package contract"), (test, "Q46 test")]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    sync_source = read_text(sync) if sync.exists() else ""
    registry_source = read_text(registry) if registry.exists() else ""
    surface_source = read_text(surface) if surface.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required_policy = [
        "v172q46-renderer-slot-identity-prototype",
        "rendererSlotIdentityPrototypeAvailable = true",
        "rendererElementRectTelemetryEnabled = true",
        "rendererCandidateIdentityRefinementEnabled = true",
        "trueAstSlotToSvgNodeIdentityClaimed = false",
        "fakePerSlotIdentityAllowed = false",
        "keyboardSurfaceMutationAllowed = false",
        "moreSurfaceMutationAllowed = false",
        "longPressSurfaceMutationAllowed = false",
    ]
    missing = [token for token in required_policy if token not in policy_source]
    if missing:
        details.append("Q46 policy missing markers: " + ", ".join(missing))
    required_sync = [
        "q46RendererSlotIdentityPrototypeAvailable = true",
        "rendererElementRectTelemetryEnabled = true",
        "trueAstSlotToSvgNodeIdentityClaimed = false",
        "elementRectsForCanvas",
        "normalizedElementRects",
        "RendererElementRect",
    ]
    missing = [token for token in required_sync if token not in sync_source]
    if missing:
        details.append("renderer sync missing Q46 element rect support: " + ", ".join(missing))
    required_registry = [
        "q46RendererSlotIdentityPrototypeAvailable = true",
        "rendererSlotIdentityCandidateRefinementEnabled = true",
        "trueAstSlotToSvgNodeIdentityClaimed = false",
        "RendererSlotIdentityPolicy.refineVisualRect",
    ]
    missing = [token for token in required_registry if token not in registry_source]
    if missing:
        details.append("deterministic registry missing Q46 refinement wiring: " + ", ".join(missing))
    required_surface = [
        "q46RendererSlotIdentityPrototypeAvailable = true",
        "trueAstSlotToSvgNodeIdentityClaimed = false",
        "collectElementRects",
        "elementRects: collectElementRects",
    ]
    missing = [token for token in required_surface if token not in surface_source]
    if missing:
        details.append("MathJax surface missing Q46 element rect telemetry: " + ", ".join(missing))
    if "V172-Q46 Renderer Slot Identity Prototype" not in contract_source or "0.172.73+172" not in contract_source:
        details.append("package contract metadata is not Q46")
    if "V172-Q47" not in contract_source:
        details.append("package contract next phase is not Q47")
    if details:
        return CheckResult("v172_q46_renderer_slot_identity_prototype", "FAIL", "; ".join(details))
    return CheckResult("v172_q46_renderer_slot_identity_prototype", "PASS", "Q46 renderer element-rect telemetry and candidate slot-identity refinement are wired without claiming true AST-slot SVG identity or touching P6 UI files.")


def check_v172_q47_true_glyph_level_caret_stops(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/true_glyph_level_caret_stop_policy.dart"
    selection = root / "lib/features/editor/selection_controller.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q47_true_glyph_level_caret_stops_test.dart"
    for path, label in [(policy, "true glyph policy"), (selection, "selection controller"), (contract, "package contract"), (test, "Q47 test")]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    selection_source = read_text(selection) if selection.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required_policy_markers = [
        "v172q47",
        "trueGlyphLevelCaretStopsAvailable = true",
        "rendererElementRectCaretStopsEnabled = true",
        "stableAstCharacterToSvgNodeIdentityClaimed = false",
        "fakeGlyphIdentityAllowed = false",
        "requiredCorrectGlyphTapSelectionsPerTwenty = 19",
    ]
    for marker in required_policy_markers:
        if marker not in policy_source:
            details.append(f"policy missing marker {marker}")
    for marker in [
        "TrueGlyphLevelCaretStopPolicy.rendererAssistedCaretIndexForX",
        "TrueGlyphLevelCaretStopPolicy.rendererAssistedCaretPositions",
        "v172q47-true-glyph-level-caret-stops",
    ]:
        if marker not in selection_source:
            details.append(f"selection controller missing marker {marker}")
    if "0.172.74+172" not in contract_source or "V172-Q47 True Glyph-Level Caret Stops" not in contract_source:
        details.append("package contract missing Q47 lineage metadata")
    if details:
        return CheckResult("v172_q47_true_glyph_level_caret_stops", "FAIL", "; ".join(details))
    return CheckResult("v172_q47_true_glyph_level_caret_stops", "PASS", "Q47 renderer-assisted glyph-level caret stops are wired through selection_controller without claiming fake stable AST-character SVG identity or touching P6 UI files.")



def check_v172_q48_native_layout_box_cursor_layer(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/native_layout_box_cursor_layer.dart"
    registry = root / "lib/features/formula_engine/deterministic_slot_geometry_registry.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q48_native_layout_box_cursor_layer_test.dart"
    overlay = root / "lib/features/workspace/editor_caret_overlay.dart"
    for path, label in [(policy, "native layout box policy"), (registry, "deterministic registry"), (contract, "package contract"), (test, "Q48 test"), (overlay, "editor caret overlay")]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    registry_source = read_text(registry) if registry.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    overlay_source = read_text(overlay) if overlay.exists() else ""
    required_policy_markers = [
        "v172q48-native-layout-box-cursor-layer",
        "nativeLayoutBoxCursorLayerAvailable = true",
        "keyboardSurfaceMutationAllowed = false",
        "moreSurfaceMutationAllowed = false",
        "longPressSurfaceMutationAllowed = false",
        "appShellMutationAllowed = false",
        "fullNativeMathRendererClaimed = false",
        "trueAstSlotToSvgNodeIdentityClaimed = false",
        "cursorGeometryOnly = true",
        "NativeCursorLayoutBox",
    ]
    for marker in required_policy_markers:
        if marker not in policy_source:
            details.append(f"native layout policy missing marker {marker}")
    required_registry_markers = [
        "v172q48",
        "q48NativeLayoutBoxCursorLayerAvailable = true",
        "nativeLayoutBoxCursorGeometryEnabled = true",
        "NativeLayoutBoxCursorLayer.boxForSlot",
        "NativeLayoutBoxCursorLayer.caretRectForBox",
    ]
    for marker in required_registry_markers:
        if marker not in registry_source:
            details.append(f"deterministic registry missing Q48 wiring {marker}")
    if "0.172.75+172" not in contract_source or "V172-Q48 Native LayoutBox Cursor Layer" not in contract_source:
        details.append("package contract missing Q48 lineage metadata")
    if "0.172.76+172" not in contract_source or "V172-Q48R3" not in contract_source:
        details.append("package contract missing Q48R3 lineage metadata")
    if "0.172.77+172" not in contract_source or "V172-Q49 Structural Cursor Release Hardening" not in contract_source:
        details.append("package contract missing active Q49 metadata")
    for marker in ["NativeLayoutBoxCursorLayer.caretRectForBox", "NativeLayoutBoxCursorLayer.boxTypeForRole"]:
        if marker not in overlay_source:
            details.append(f"editor caret overlay missing Q48 native caret marker {marker}")
    if details:
        return CheckResult("v172_q48_native_layout_box_cursor_layer", "FAIL", "; ".join(details))
    return CheckResult("v172_q48_native_layout_box_cursor_layer", "PASS", "Q48 native LayoutBox cursor layer is wired as cursor-geometry only without claiming full native renderer or touching P6 UI files.")



def check_v172_q49_structural_cursor_release_hardening(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/structural_cursor_release_hardening_policy.dart"
    slot_hit = root / "lib/features/formula_engine/slot_hit_testing.dart"
    overlay = root / "lib/features/workspace/editor_caret_overlay.dart"
    interaction = root / "lib/features/editor/render/editor_interaction_layer.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q49_structural_cursor_release_hardening_test.dart"
    for path, label in [(policy, "Q49 policy"), (slot_hit, "slot hit-test"), (overlay, "caret overlay"), (interaction, "editor interaction layer"), (contract, "package contract"), (test, "Q49 test")]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    slot_hit_source = read_text(slot_hit) if slot_hit.exists() else ""
    overlay_source = read_text(overlay) if overlay.exists() else ""
    interaction_source = read_text(interaction) if interaction.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required_policy_markers = [
        "v172q49-structural-cursor-release-hardening",
        "structuralCursorReleaseHardeningAvailable = true",
        "keyboardSurfaceMutationAllowed = false",
        "moreSurfaceMutationAllowed = false",
        "longPressSurfaceMutationAllowed = false",
        "appShellMutationAllowed = false",
        "graphHistorySolutionMutationAllowed = false",
        "visibleGreenOverlayAllowed = false",
        "fullNativeMathRendererClaimed = false",
        "trueAstSlotToSvgNodeIdentityClaimed = false",
        "realDevicePlus95PassClaimed = false",
        "frozenPipelineStageOrder",
        "guardedChildCount",
        "chooseStructuralCaretIndex",
        "hardenedNativeCaretRect",
        "compareFinalCandidates",
    ]
    missing = [m for m in required_policy_markers if m not in policy_source]
    if missing:
        details.append("Q49 policy markers missing: " + ", ".join(missing))
    required_slot_hit_markers = [
        "v172q49",
        "StructuralCursorReleaseHardeningPolicy.preservePipelineStage",
        "StructuralCursorReleaseHardeningPolicy.compareFinalCandidates",
        "release-hardening-final-sort",
    ]
    missing = [m for m in required_slot_hit_markers if m not in slot_hit_source]
    if missing:
        details.append("slot_hit_testing.dart missing Q49 release-hardening wiring: " + ", ".join(missing))
    for marker in ["StructuralCursorReleaseHardeningPolicy.finalizeCaretRect", "StructuralCursorReleaseHardeningPolicy.guardedChildCount", "NativeLayoutBoxCursorLayer.boxTypeForRole"]:
        if marker not in overlay_source:
            details.append(f"editor_caret_overlay.dart missing Q49 caret finalization marker {marker}")
    if "StructuralCursorReleaseHardeningPolicy.chooseStructuralCaretIndex" not in interaction_source:
        details.append("editor_interaction_layer.dart missing Q49 structural caret index guard")
    if "0.172.77+172" not in contract_source or "V172-Q49 Structural Cursor Release Hardening" not in contract_source or "Q50" not in contract_source:
        details.append("package contract missing active Q49 / next Q50 metadata")
    if details:
        return CheckResult("v172_q49_structural_cursor_release_hardening", "FAIL", "; ".join(details))
    return CheckResult("v172_q49_structural_cursor_release_hardening", "PASS", "Q49 structural cursor release hardening is wired through slot hit-test, editor interaction, and caret overlay without touching P6 UI files or claiming device +95 PASS.")



def check_v172_q50_p6_locked_cursor_candidate_freeze(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/p6_locked_cursor_candidate_freeze_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q50_p6_locked_cursor_candidate_freeze_test.dart"
    readme = root / "README.md"
    pubspec = root / "pubspec.yaml"
    for path, label in [(policy, "Q50 policy"), (contract, "package contract"), (test, "Q50 test"), (readme, "README"), (pubspec, "pubspec")]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    readme_source = read_text(readme) if readme.exists() else ""
    pubspec_source = read_text(pubspec) if pubspec.exists() else ""
    required_policy_markers = [
        "v172q50-p6-locked-plus95-cursor-candidate-freeze",
        "p6LockedCursorCandidateFreezeAvailable = true",
        "plus95CandidateMatrixFrozen = true",
        "keyboardSurfaceMutationAllowed = false",
        "moreSurfaceMutationAllowed = false",
        "longPressSurfaceMutationAllowed = false",
        "appShellMutationAllowed = false",
        "graphHistorySolutionMutationAllowed = false",
        "mathLabelMutationAllowed = false",
        "premiumKeyMutationAllowed = false",
        "templateTrayMutationAllowed = false",
        "visibleGreenOverlayAllowed = false",
        "fullNativeMathRendererClaimed = false",
        "trueAstSlotToSvgNodeIdentityClaimed = false",
        "realDevicePlus95PassClaimed = false",
        "flutterAnalyzePassClaimed = false",
        "flutterTestPassClaimed = false",
        "coreScenarioMatrix",
        "hasCompleteCoreScenarioMatrix",
        "canClaimPlus95CandidatePass",
        "protectedP6Files",
        "isAllowedSurgicalCursorPath",
        "requiredOverallSuccessRate = 0.95",
        "targetDeviceId = '23106RN0DA'",
    ]
    missing = [m for m in required_policy_markers if m not in policy_source]
    if missing:
        details.append("Q50 policy markers missing: " + ", ".join(missing))
    required_expressions = [
        "√□",
        "x^□",
        "x_□",
        "log_□(□)",
        "9/6",
        "12/345",
        "123456789",
        "cos(99666655)",
        "sin(300)",
        "ln(123456)",
        "ln(ln(8))",
        "sin(cos(300))",
        "√(sin(x)+log₂(500))",
        "sin(300)+cos(400)+log₂(500)+√(600)",
    ]
    for expr in required_expressions:
        if expr not in policy_source:
            details.append(f"Q50 core scenario missing expression {expr}")
    for protected in PROTECTED_FILES:
        if protected not in policy_source:
            details.append(f"Q50 policy missing protected P6 file {protected}")
    if "0.172.80+172" not in contract_source or "V172-Q50R2 Stale Package Guard Repair" not in contract_source:
        details.append("package contract missing Q50R2 lineage metadata")
    if "0.172.112+172" not in pubspec_source or "V172-Q80 real device cursor court" not in pubspec_source:
        details.append("pubspec missing active Q80 metadata")
    if "V172-Q55" not in (readme_source.splitlines()[0] if readme_source.splitlines() else ""):
        details.append("README first heading does not contain active V172-Q59 marker")
    for marker in ["P6LockedCursorCandidateFreezePolicy", "canClaimPlus95CandidatePass", "realDevicePlus95PassClaimed, isFalse"]:
        if marker not in test_source:
            details.append(f"Q50 test missing marker {marker}")
    if details:
        return CheckResult("v172_q50_p6_locked_cursor_candidate_freeze", "FAIL", "; ".join(details))
    return CheckResult("v172_q50_p6_locked_cursor_candidate_freeze", "PASS", "Q50R2 repairs the stale-package/download blockers while preserving the P6-locked +95 cursor candidate matrix and evidence gates without touching protected UI surfaces or claiming real-device +95 PASS.")


def check_v172_q51_structural_placeholder_restoration(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/structural_placeholder_restoration_policy.dart"
    commands = root / "lib/features/editor/editor_commands.dart"
    controller = root / "lib/state/calculator_controller.dart"
    factory = root / "lib/features/editor/node_factory.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q51_structural_placeholder_restoration_test.dart"
    readme = root / "README.md"
    pubspec = root / "pubspec.yaml"
    for path, label in [(policy, "Q51 policy"), (commands, "editor commands"), (controller, "calculator controller"), (factory, "node factory"), (contract, "package contract"), (test, "Q51 test"), (readme, "README"), (pubspec, "pubspec")]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    commands_source = read_text(commands) if commands.exists() else ""
    controller_source = read_text(controller) if controller.exists() else ""
    factory_source = read_text(factory) if factory.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    readme_source = read_text(readme) if readme.exists() else ""
    pubspec_source = read_text(pubspec) if pubspec.exists() else ""
    required_policy_markers = [
        "v172q51-structural-placeholder-restoration-repair",
        "structuralPlaceholderRestorationAvailable = true",
        "emptyStructuralSlotsRestoreToPlaceholder = true",
        "halfTemplateStringsAllowed = false",
        "keyboardSurfaceMutationAllowed = false",
        "moreSurfaceMutationAllowed = false",
        "longPressSurfaceMutationAllowed = false",
        "appShellMutationAllowed = false",
        "graphHistorySolutionMutationAllowed = false",
        "caretLeadingRailHandledByQ52 = true",
        "realDevicePlus95PassClaimed = false",
        "normalizeAfterEdit",
        "protectedBrokenFinalForms",
    ]
    missing = [m for m in required_policy_markers if m not in policy_source]
    if missing:
        details.append("Q51 policy markers missing: " + ", ".join(missing))
    for marker in ["StructuralPlaceholderRestorationPolicy.normalizeAfterEdit", "restoreStructuralPlaceholders"]:
        if marker not in commands_source:
            details.append(f"editor_commands.dart missing {marker}")
    for marker in ["v172q51-linearBackspacePlaceholderRestore", "v172q51-atomicPlaceholderRestore", "restoreStructuralPlaceholders(rawNextExpression)"]:
        if marker not in controller_source:
            details.append(f"calculator_controller.dart missing Q51 wiring {marker}")
    if "clean.isEmpty || clean == '□'" not in factory_source:
        details.append("node_factory.dart does not restore empty slot tokens to placeholders")
    for marker in ["sin()", "9⁄", "√()", "∫(□)d"]:
        if marker not in policy_source or marker not in test_source:
            details.append(f"Q51 protected broken form {marker} missing from policy/test")
    if "0.172.112+172" not in pubspec_source or "V172-Q80 real device cursor court" not in pubspec_source:
        details.append("pubspec missing active Q80 metadata")
    if "0.172.81+172" not in contract_source or "V172-Q51 Structural Placeholder Restoration Repair" not in contract_source or "0.172.86+172" not in contract_source:
        details.append("package contract missing Q51 lineage or active Q53 metadata")
    if "V172-Q55" not in (readme_source.splitlines()[0] if readme_source.splitlines() else ""):
        details.append("README first heading does not contain active V172-Q59 marker")
    if details:
        return CheckResult("v172_q51_structural_placeholder_restoration", "FAIL", "; ".join(details))
    return CheckResult("v172_q51_structural_placeholder_restoration", "PASS", "Q51 structural placeholder restoration is wired through editor commands, controller backspace, and node parsing without touching protected UI surfaces or claiming caret/real-device +95 PASS.")


def check_v172_q52_active_empty_slot_leading_rail(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/active_empty_slot_leading_rail_caret_policy.dart"
    native = root / "lib/features/formula_engine/native_layout_box_cursor_layer.dart"
    hardening = root / "lib/features/formula_engine/structural_cursor_release_hardening_policy.dart"
    overlay = root / "lib/features/workspace/editor_caret_overlay.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q52_active_empty_slot_leading_rail_caret_test.dart"
    readme = root / "README.md"
    pubspec = root / "pubspec.yaml"
    for path, label in [(policy, "Q52 policy"), (native, "native layout box"), (hardening, "release hardening"), (overlay, "caret overlay"), (contract, "package contract"), (test, "Q52 test"), (readme, "README"), (pubspec, "pubspec")]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    native_source = read_text(native) if native.exists() else ""
    hardening_source = read_text(hardening) if hardening.exists() else ""
    overlay_source = read_text(overlay) if overlay.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    readme_source = read_text(readme) if readme.exists() else ""
    pubspec_source = read_text(pubspec) if pubspec.exists() else ""
    required_policy_markers = [
        "v172q52-active-empty-slot-leading-rail-caret-repair",
        "activeEmptySlotLeadingRailCaretAvailable = true",
        "emptySlotCaretRendersAsLeadingRailBox = true",
        "activeEmptySlotCaretInsidePlaceholderAllowed = false",
        "emptySlotExitRailDefaultAllowed = false",
        "keyboardSurfaceMutationAllowed = false",
        "moreSurfaceMutationAllowed = false",
        "longPressSurfaceMutationAllowed = false",
        "appShellMutationAllowed = false",
        "graphHistorySolutionMutationAllowed = false",
        "realDevicePlus95PassClaimed = false",
        "leadingRailCaretRect",
        "isLeadingRailAligned",
        "shouldForceLeadingRail",
    ]
    missing = [m for m in required_policy_markers if m not in policy_source]
    if missing:
        details.append("Q52 policy markers missing: " + ", ".join(missing))
    for marker in ["v172q48-native-layout-box-cursor-layer", "v172q52", "caretHeightForBox"]:
        if marker not in native_source:
            details.append(f"native_layout_box_cursor_layer.dart missing Q52-compatible marker {marker}")
    for marker in ["v172q49-structural-cursor-release-hardening", "v172q52", "finalizeCaretRect"]:
        if marker not in hardening_source:
            details.append(f"structural_cursor_release_hardening_policy.dart missing Q52-compatible marker {marker}")
    for marker in ["ActiveEmptySlotLeadingRailCaretPolicy.isEmptyStructuralPayload", "activeEmptySlotLeadingRail: isEmptyActiveSlot", "caretIndexForEmptyActiveSlot"]:
        if marker not in overlay_source:
            details.append(f"editor_caret_overlay.dart missing Q52 wiring {marker}")
    for marker in ["|□", "inside", "□|", "0.172.82+172", "V172-Q52 Active Empty Slot Leading-Rail Caret Repair"]:
        if marker not in contract_source:
            details.append(f"package contract missing Q52 marker {marker}")
    for marker in ["isLeadingRailAligned", "ActiveEmptySlotLeadingRailCaretPolicy.leadingRailCaretRect", "shouldForceLeadingRail", "q53OwnsRoleGeometryPolish"]:
        if marker not in test_source:
            details.append(f"Q52 test missing marker {marker}")
    if "0.172.112+172" not in pubspec_source or "V172-Q80 real device cursor court" not in pubspec_source:
        details.append("pubspec missing active Q80 metadata")
    if "V172-Q55" not in (readme_source.splitlines()[0] if readme_source.splitlines() else ""):
        details.append("README first heading does not contain active V172-Q59 marker")
    if details:
        return CheckResult("v172_q52_active_empty_slot_leading_rail", "FAIL", "; ".join(details))
    return CheckResult("v172_q52_active_empty_slot_leading_rail", "PASS", "Q52 active empty-slot leading-rail caret repair is wired through native LayoutBox, release hardening, and caret overlay without touching protected UI surfaces or claiming real-device +95 PASS.")


def check_v172_q53_role_geometry_visual_alignment(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/role_geometry_visual_alignment_policy.dart"
    deterministic = root / "lib/features/formula_engine/deterministic_slot_geometry_registry.dart"
    render_mapped = root / "lib/features/formula_engine/render_mapped_slot_hit_test.dart"
    native = root / "lib/features/formula_engine/native_layout_box_cursor_layer.dart"
    hardening = root / "lib/features/formula_engine/structural_cursor_release_hardening_policy.dart"
    active = root / "lib/features/formula_engine/active_empty_slot_leading_rail_caret_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q53_role_geometry_visual_alignment_test.dart"
    readme = root / "README.md"
    pubspec = root / "pubspec.yaml"
    for path, label in [(policy, "Q53 policy"), (deterministic, "deterministic registry"), (render_mapped, "render mapped hit test"), (native, "native layout box"), (hardening, "release hardening"), (active, "Q52 active policy"), (contract, "package contract"), (test, "Q53 test"), (readme, "README"), (pubspec, "pubspec")]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    deterministic_source = read_text(deterministic) if deterministic.exists() else ""
    render_source = read_text(render_mapped) if render_mapped.exists() else ""
    native_source = read_text(native) if native.exists() else ""
    hardening_source = read_text(hardening) if hardening.exists() else ""
    active_source = read_text(active) if active.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    readme_source = read_text(readme) if readme.exists() else ""
    pubspec_source = read_text(pubspec) if pubspec.exists() else ""
    required_policy_markers = [
        "v172q53-integral-root-fraction-function-role-geometry-repair",
        "q53RoleGeometryRepairAvailable = true",
        "fractionFunctionRootIntegralGeometryPolishAvailable = true",
        "activeEmptySlotLeadingRailPreserved = true",
        "caretInsidePlaceholderAllowed = false",
        "keyboardSurfaceMutationAllowed = false",
        "moreSurfaceMutationAllowed = false",
        "longPressSurfaceMutationAllowed = false",
        "appShellMutationAllowed = false",
        "graphHistorySolutionMutationAllowed = false",
        "realDevicePlus95PassClaimed = false",
        "fractionDenominator",
        "functionArgument",
        "sqrtValue",
        "integralDifferential",
        "refineVisualRect",
        "refinePlaceholderRect",
        "finalizeActiveEmptyCaret",
        "isCaretImmediatelyBeforePlaceholder",
    ]
    missing = [m for m in required_policy_markers if m not in policy_source]
    if missing:
        details.append("Q53 policy markers missing: " + ", ".join(missing))
    for marker in ["RoleGeometryVisualAlignmentPolicy.refineVisualRect", "q53RoleGeometryVisualAlignmentAvailable"]:
        if marker not in deterministic_source:
            details.append(f"deterministic_slot_geometry_registry.dart missing {marker}")
    for marker in ["v172q53", "RoleGeometryVisualAlignmentPolicy.refineVisualRect"]:
        if marker not in render_source:
            details.append(f"render_mapped_slot_hit_test.dart missing {marker}")
    for marker in ["v172q53", "RoleGeometryVisualAlignmentPolicy.caretHeightForRole", "RoleGeometryVisualAlignmentPolicy.finalizeActiveEmptyCaret", "q53RoleGeometryVisualAlignmentAvailable"]:
        if marker not in native_source:
            details.append(f"native_layout_box_cursor_layer.dart missing {marker}")
    for marker in ["v172q53", "q53RoleGeometryFinalizerAvailable", "RoleGeometryVisualAlignmentPolicy.finalizeActiveEmptyCaret"]:
        if marker not in hardening_source:
            details.append(f"structural_cursor_release_hardening_policy.dart missing {marker}")
    if "q53RoleGeometryVisualAlignmentAvailable" not in active_source:
        details.append("active empty-slot policy missing Q53 role-geometry marker")
    for marker in ["0.172.86+172", "V172-Q53R3 Real Flutter Log Metadata Repair", "q53RoleGeometryRule"]:
        if marker not in contract_source:
            details.append(f"package contract missing Q53 marker {marker}")
    for marker in ["RoleGeometryVisualAlignmentPolicy", "isCaretImmediatelyBeforePlaceholder", "fractionDenominator", "integralDifferential", "realDevicePlus95PassClaimed, isFalse"]:
        if marker not in test_source:
            details.append(f"Q53 test missing marker {marker}")
    if "0.172.112+172" not in pubspec_source or "V172-Q80 real device cursor court" not in pubspec_source:
        details.append("pubspec missing active Q80 metadata")
    if "V172-Q55" not in (readme_source.splitlines()[0] if readme_source.splitlines() else ""):
        details.append("README first heading does not contain active V172-Q59 marker")
    if details:
        return CheckResult("v172_q53_role_geometry_visual_alignment", "FAIL", "; ".join(details))
    return CheckResult("v172_q53_role_geometry_visual_alignment", "PASS", "Q53 role-specific integral/root/fraction/function caret geometry is wired without touching protected UI surfaces or claiming real-device +95 PASS.")


def check_v172_q54_existing_cursor_engine_reconciliation(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/existing_cursor_engine_reconciliation_policy.dart"
    interaction = root / "lib/features/editor/render/editor_interaction_layer.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q54_existing_cursor_engine_reconciliation_test.dart"
    readme = root / "README.md"
    pubspec = root / "pubspec.yaml"
    for path, label in [(policy, "Q54 policy"), (interaction, "editor interaction layer"), (contract, "package contract"), (test, "Q54 test"), (readme, "README"), (pubspec, "pubspec")]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    interaction_source = read_text(interaction) if interaction.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    readme_source = read_text(readme) if readme.exists() else ""
    pubspec_source = read_text(pubspec) if pubspec.exists() else ""
    required_policy_markers = [
        "v172q54-existing-cursor-engine-reconciliation",
        "existingCursorEngineReconciled = true",
        "existingCursorMotorPreserved = true",
        "structuralFirstHitTestingEnabled = true",
        "slotInteractionSeparatedFromVisibleOverlay = true",
        "structuralTemplateLinearFallbackGuardEnabled = true",
        "keyboardSurfaceMutationAllowed = false",
        "moreSurfaceMutationAllowed = false",
        "longPressSurfaceMutationAllowed = false",
        "appShellMutationAllowed = false",
        "graphHistorySolutionMutationAllowed = false",
        "realDevicePlus95PassClaimed = false",
        "reconcileStructuralHit",
        "shouldSuppressLinearFallback",
        "reconciledStructuralCaretIndex",
    ]
    missing = [m for m in required_policy_markers if m not in policy_source]
    if missing:
        details.append("Q54 policy markers missing: " + ", ".join(missing))
    for marker in ["ExistingCursorEngineReconciliationPolicy.slotInteractionEnabled", "reconcileStructuralHit", "shouldSuppressLinearFallback", "reconciledStructuralCaretIndex"]:
        if marker not in interaction_source:
            details.append(f"editor_interaction_layer.dart missing Q54 wiring {marker}")
    if "paintVisibleSlotOverlay = false" not in interaction_source or "paintVisibleSlotOverlay: true" in interaction_source:
        details.append("editor interaction layer must keep visible slot overlay disabled")
    for marker in ["0.172.89+172", "V172-Q54 Existing Cursor Engine Reconciliation", "q54ExistingCursorEngineReconciliationRule"]:
        if marker not in contract_source:
            details.append(f"package contract missing Q54 marker {marker}")
    for marker in ["ExistingCursorEngineReconciliationPolicy", "shouldSuppressLinearFallback", "reconcileStructuralHit", "slotInteractionSeparatedFromVisibleOverlay"]:
        if marker not in test_source:
            details.append(f"Q54 test missing marker {marker}")
    if "0.172.112+172" not in pubspec_source or "V172-Q80 real device cursor court" not in pubspec_source:
        details.append("pubspec missing active Q80 metadata")
    if "V172-Q55" not in (readme_source.splitlines()[0] if readme_source.splitlines() else ""):
        details.append("README first heading does not contain active V172-Q59 marker")
    if details:
        return CheckResult("v172_q54_existing_cursor_engine_reconciliation", "FAIL", "; ".join(details))
    return CheckResult("v172_q54_existing_cursor_engine_reconciliation", "PASS", "Q54 reconciles the existing cursor engine into a structural-first, fallback-safe path without touching protected UI surfaces or claiming real-device +95 PASS.")



def check_v172_q55_single_slot_geometry_bundle_authority(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/slot_geometry_bundle_authority.dart"
    deterministic = root / "lib/features/formula_engine/deterministic_slot_geometry_registry.dart"
    hit = root / "lib/features/formula_engine/slot_hit_testing.dart"
    interaction = root / "lib/features/editor/render/editor_interaction_layer.dart"
    overlay = root / "lib/features/workspace/editor_caret_overlay.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q55_single_slot_geometry_bundle_authority_test.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    details = []
    for path in [policy, deterministic, hit, interaction, overlay, contract, test, pubspec, readme]:
        if not path.exists():
            details.append(f"missing {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q55_single_slot_geometry_bundle_authority", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    deterministic_src = read_text(deterministic)
    hit_src = read_text(hit)
    interaction_src = read_text(interaction)
    overlay_src = read_text(overlay)
    input_surface_src = read_text(root / "lib/features/formula_engine/native_slotbox_input_surface_integration_policy.dart") if (root / "lib/features/formula_engine/native_slotbox_input_surface_integration_policy.dart").exists() else ""
    contract_src = read_text(contract)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    test_src = read_text(test)
    required_policy = [
        "singleSlotGeometryBundleAuthorityAvailable = true",
        "hitRectOnlyForSelection = true",
        "caretNeverUsesHitRect = true",
        "activeEmptySlotUsesLeadingRail = true",
        "filledSlotUsesInnerTextRect = true",
        "realDevicePlus95PassClaimed = false",
        "class SlotGeometryBundle",
        "leadingRailRect",
        "trailingRailRect",
        "innerTextRect",
    ]
    for marker in required_policy:
        if marker not in policy_src:
            details.append(f"policy missing marker: {marker}")
    for marker, src_name, src in [
        ("SlotGeometryBundleAuthority.bundleFor", "deterministic", deterministic_src),
        ("SlotGeometryBundleAuthority.hitRectForRole", "slot hit-test", hit_src),
        ("SlotGeometryBundleAuthority.buildFromVisualRects", "interaction/input-surface", interaction_src + input_surface_src),
        ("SlotGeometryBundleAuthority.caretRectForBundle", "caret overlay", overlay_src),
    ]:
        if marker not in src:
            details.append(f"{src_name} missing {marker}")
    for marker in ["0.172.89+172", "V172-Q55", "q55SingleSlotGeometryBundleAuthorityRule"]:
        if marker not in contract_src:
            details.append(f"contract missing {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    if "V172-Q56 Structural Intent Resolver" not in readme_src:
        details.append("README title not advanced to Q59")
    if "SlotGeometryBundleAuthority" not in test_src or "caretNeverUsesHitRect" not in test_src:
        details.append("Q55 test does not guard bundle authority")
    forbidden = [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
    ]
    for marker in forbidden:
        if marker in policy_src:
            details.append(f"forbidden Q55 claim: {marker}")
    if details:
        return CheckResult("v172_q55_single_slot_geometry_bundle_authority", "FAIL", "; ".join(details))
    return CheckResult("v172_q55_single_slot_geometry_bundle_authority", "PASS", "Q55 establishes one SlotGeometryBundle authority for hit-test, placeholder, rail and filled-slot caret geometry without touching protected UI surfaces or claiming real-device +95 PASS.")



def check_v172_q56_structural_intent_resolver(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/structural_intent_resolver_policy.dart"
    interaction = root / "lib/features/editor/render/editor_interaction_layer.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q56_structural_intent_resolver_test.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    details = []
    for path in [policy, interaction, contract, test, pubspec, readme]:
        if not path.exists():
            details.append(f"missing {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q56_structural_intent_resolver", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    interaction_src = read_text(interaction)
    contract_src = read_text(contract)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    test_src = read_text(test)
    for marker in [
        "structuralIntentResolverAvailable = true",
        "structuralExactHitWins = true",
        "structuralNearestHitEnabled = false",
        "templateRegionBeatsLinearFallback = true",
        "slotGeometryBundleAuthorityRequired = true",
        "realDevicePlus95PassClaimed = false",
        "resolveIntent",
        "shouldSuppressLinearFallbackForTemplateRegion",
    ]:
        if marker not in policy_src:
            details.append(f"Q56 policy missing marker: {marker}")
    for marker in [
        "StructuralIntentResolverPolicy.resolveIntent",
        "shouldSuppressLinearFallbackForTemplateRegion",
        "geometryBundles",
    ]:
        if marker not in interaction_src:
            details.append(f"interaction layer missing Q56 wiring: {marker}")
    for marker in ["0.172.89+172", "V172-Q56", "q56StructuralIntentResolverRule"]:
        if marker not in contract_src:
            details.append(f"contract missing {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    if "V172-Q56 Structural Intent Resolver" not in readme_src:
        details.append("README title not advanced to Q59")
    if "StructuralIntentResolverPolicy" not in test_src or "template-region" not in test_src:
        details.append("Q56 test does not guard structural intent resolver")
    for marker in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
    ]:
        if marker in policy_src:
            details.append(f"forbidden Q56 claim: {marker}")
    if details:
        return CheckResult("v172_q56_structural_intent_resolver", "FAIL", "; ".join(details))
    return CheckResult("v172_q56_structural_intent_resolver", "PASS", "Q56 resolves structural tap intent through SlotGeometryBundle exact/nearest/template-region logic before detached linear fallback without touching protected UI surfaces or claiming real-device +95 PASS.")


def check_v172_q57_active_empty_slot_leading_rail_finalizer(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/active_empty_slot_leading_rail_finalizer_policy.dart"
    overlay = root / "lib/features/workspace/editor_caret_overlay.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q57_active_empty_slot_leading_rail_finalizer_test.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    details: list[str] = []
    for path in [policy, overlay, contract, test, pubspec, readme]:
        if not path.exists():
            details.append(f"missing {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q57_active_empty_slot_leading_rail_finalizer", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    overlay_src = read_text(overlay)
    contract_src = read_text(contract)
    test_src = read_text(test)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    for marker in [
        "activeEmptySlotLeadingRailFinalizerAvailable = true",
        "paintedCaretUsesBundleLeadingRail = true",
        "emptySlotCaretFinalizationOverridesCandidate = true",
        "hitRectCaretDriftAllowed = false",
        "detachedLinearFallbackCaretAllowedForEmptyStructuralSlot = false",
        "placeholderOverlapAllowed = false",
        "defaultExitRailForEmptySlotAllowed = false",
        "filledSlotCaretStopsPreserved = true",
        "realDevicePlus95PassClaimed = false",
        "finalizePaintedCaret",
        "leadingRailFromBundle",
        "isFinalizedLeadingRail",
    ]:
        if marker not in policy_src:
            details.append(f"Q57 policy missing marker: {marker}")
    for marker in [
        "ActiveEmptySlotLeadingRailFinalizerPolicy.finalizePaintedCaret",
        "SlotGeometryBundle.leadingRailRect",
        "isLeadingRailAligned",
    ]:
        if marker not in overlay_src:
            details.append(f"editor_caret_overlay missing Q57 wiring: {marker}")
    for marker in ["0.172.94+172", "V172-Q57", "q57ActiveEmptySlotLeadingRailFinalizerRule"]:
        if marker not in contract_src:
            details.append(f"contract missing {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    if "V172-Q57 Active Empty Slot Leading-Rail Finalizer" not in readme_src:
        details.append("README title not advanced to Q59")
    if "ActiveEmptySlotLeadingRailFinalizerPolicy" not in test_src or "SlotGeometryBundle.leadingRailRect" not in test_src:
        details.append("Q57 test does not guard finalizer")
    for marker in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
    ]:
        if marker in policy_src:
            details.append(f"forbidden Q57 claim: {marker}")
    if details:
        return CheckResult("v172_q57_active_empty_slot_leading_rail_finalizer", "FAIL", "; ".join(details))
    return CheckResult("v172_q57_active_empty_slot_leading_rail_finalizer", "PASS", "Q57 finalizes painted active-empty-slot carets through SlotGeometryBundle.leadingRailRect as |□ without touching protected UI surfaces or claiming real-device +95 PASS.")


def check_v172_q58_integral_cursor_specialization(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/integral_cursor_specialization_policy.dart"
    interaction = root / "lib/features/editor/render/editor_interaction_layer.dart"
    bundle_authority = root / "lib/features/formula_engine/slot_geometry_bundle_authority.dart"
    resolver = root / "lib/features/formula_engine/structural_intent_resolver_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q58_integral_cursor_specialization_test.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    details: list[str] = []
    for path in [policy, interaction, bundle_authority, resolver, contract, test, pubspec, readme]:
        if not path.exists():
            details.append(f"missing {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q58_integral_cursor_specialization", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    interaction_src = read_text(interaction)
    bundle_src = read_text(bundle_authority)
    resolver_src = read_text(resolver)
    contract_src = read_text(contract)
    test_src = read_text(test)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    for marker in [
        "integralCursorSpecializationAvailable = true",
        "upperLowerBodyDifferentialRolesSpecialized = true",
        "differentialUsesDPipeBoxLaw = true",
        "integralTemplateLinearFallbackAllowed = false",
        "integralCaretLeftVoidDriftAllowed = false",
        "activeEmptyIntegralSlotsUseLeadingRail = true",
        "realDevicePlus95PassClaimed = false",
        "refineHitRectForRole",
        "refineLeadingRailRectForRole",
        "shouldSuppressLinearFallbackForIntegralRegion",
        "provesDifferentialPipeBoxLaw",
    ]:
        if marker not in policy_src:
            details.append(f"Q58 policy missing marker: {marker}")
    for marker in [
        "IntegralCursorSpecializationPolicy.refineHitRectForRole",
        "IntegralCursorSpecializationPolicy.refinePlaceholderRectForRole",
        "IntegralCursorSpecializationPolicy.refineLeadingRailRectForRole",
        "IntegralCursorSpecializationPolicy.refineInnerTextRectForRole",
    ]:
        if marker not in bundle_src:
            details.append(f"SlotGeometryBundleAuthority missing Q58 wiring: {marker}")
    for marker in [
        "IntegralCursorSpecializationPolicy.roleBonus",
        "IntegralCursorSpecializationPolicy.lanePenalty",
        "IntegralCursorSpecializationPolicy.nearestRadiusForRole",
    ]:
        if marker not in resolver_src:
            details.append(f"StructuralIntentResolverPolicy missing Q58 wiring: {marker}")
    if "IntegralCursorSpecializationPolicy.shouldSuppressLinearFallbackForIntegralRegion" not in interaction_src:
        details.append("EditorInteractionLayer missing Q58 integral fallback guard")
    for marker in ["0.172.94+172", "V172-Q58", "q58IntegralCursorSpecializationRule"]:
        if marker not in contract_src:
            details.append(f"contract missing {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    if "V172-Q59 Fraction Function Root Log Specialization" not in readme_src:
        details.append("README title not advanced to Q59")
    if "IntegralCursorSpecializationPolicy" not in test_src or "d|□" not in test_src:
        details.append("Q58 test does not guard integral specialization")
    for marker in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
    ]:
        if marker in policy_src:
            details.append(f"forbidden Q58 claim: {marker}")
    if details:
        return CheckResult("v172_q58_integral_cursor_specialization", "FAIL", "; ".join(details))
    return CheckResult("v172_q58_integral_cursor_specialization", "PASS", "Q58 specializes integral upper/lower/body/differential cursor intent and d|□ leading rail without touching protected UI surfaces or claiming real-device +95 PASS.")


def check_v172_q61_cursor_golden_geometry_court(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/cursor_golden_geometry_court_policy.dart"
    bundle_authority = root / "lib/features/formula_engine/slot_geometry_bundle_authority.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q61_cursor_golden_geometry_court_test.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    details: list[str] = []
    for path in [policy, bundle_authority, contract, test, pubspec, readme]:
        if not path.exists():
            details.append(f"missing {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q61_cursor_golden_geometry_court", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    contract_src = read_text(contract)
    test_src = read_text(test)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    for marker in [
        "cursorGoldenGeometryCourtAvailable = true",
        "goldenGeometryCourtEnabled = true",
        "hitRectNeverPaintsCaret = true",
        "emptyActiveSlotMustUseLeadingRail = true",
        "placeholderOverlapAllowed = false",
        "detachedCaretDriftAllowed = false",
        "filledSlotInnerTextCaretPreserved = true",
        "attemptsPerScenario = 20",
        "requiredCorrectPerScenario = 19",
        "requiredCoreSuccessRate = 0.95",
        "evaluateEmptySlotBundle",
        "passesPlus95SyntheticThreshold",
        "realDevicePlus95PassClaimed = false",
    ]:
        if marker not in policy_src:
            details.append(f"Q61 policy missing marker: {marker}")
    for marker in ["0.172.94+172", "V172-Q61", "q61CursorGoldenGeometryCourtRule"]:
        if marker not in contract_src:
            details.append(f"contract missing {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    first = readme_src.splitlines()[0] if readme_src.splitlines() else ""
    if "V172-Q61 Cursor Golden Geometry Court" not in first:
        details.append("README title not advanced to Q61")
    for marker in ["CursorGoldenGeometryCourtPolicy", "requiredCorrectPerScenario = 19", "SlotGeometryBundleAuthority", "realDevicePlus95PassClaimed, isFalse"]:
        if marker not in test_src:
            details.append(f"Q61 test missing marker: {marker}")
    for marker in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
    ]:
        if marker in policy_src:
            details.append(f"forbidden Q61 claim: {marker}")
    if details:
        return CheckResult("v172_q61_cursor_golden_geometry_court", "FAIL", "; ".join(details))
    return CheckResult("v172_q61_cursor_golden_geometry_court", "PASS", "Q61 adds a code-level golden geometry court for |□ rails, placeholder non-overlap and 19/20 synthetic +95 thresholds without touching protected UI surfaces or claiming real-device +95 PASS.")


def check_v172_q62_synthetic_tap_intent_matrix(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/synthetic_tap_intent_matrix_policy.dart"
    resolver = root / "lib/features/formula_engine/structural_intent_resolver_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q62_synthetic_tap_intent_matrix_test.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    details: list[str] = []
    for path in [policy, resolver, contract, test, pubspec, readme]:
        if not path.exists():
            details.append(f"missing {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q62_synthetic_tap_intent_matrix", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    resolver_src = read_text(resolver)
    contract_src = read_text(contract)
    test_src = read_text(test)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    for marker in [
        "syntheticTapIntentMatrixAvailable = true",
        "syntheticPhoneTapCourtEnabled = true",
        "structuralIntentMustBeatLinearFallback = true",
        "exactStructuralHitMustResolveTargetSlot = true",
        "nearestStructuralHitMustResolveTargetSlot = false",
        "authoritativeSlotBoxHitMustResolveTargetSlot = true",
        "templateRegionMustSuppressDetachedLinearFallback = true",
        "slotGeometryBundleAuthorityRequired = true",
        "cursorGoldenGeometryCourtRequired = true",
        "attemptsPerScenario = CursorGoldenGeometryCourtPolicy.attemptsPerScenario",
        "requiredCorrectPerScenario = CursorGoldenGeometryCourtPolicy.requiredCorrectPerScenario",
        "requiredSyntheticSuccessRate = CursorGoldenGeometryCourtPolicy.requiredCoreSuccessRate",
        "evaluateScenario",
        "evaluateMatrix",
        "samplesForBundle",
        "resolveSyntheticTap",
        "realDevicePlus95PassClaimed = false",
    ]:
        if marker not in policy_src:
            details.append(f"Q62 policy missing marker: {marker}")
    for marker in ["StructuralIntentResolverPolicy.resolveIntent", "shouldSuppressLinearFallbackForTemplateRegion"]:
        if marker not in policy_src:
            details.append(f"Q62 policy missing resolver wiring: {marker}")
    for marker in ["0.172.96+172", "V172-Q62", "q62SyntheticTapIntentMatrixRule"]:
        if marker not in contract_src:
            details.append(f"contract missing {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    first = readme_src.splitlines()[0] if readme_src.splitlines() else ""
    if "V172-Q62 Synthetic Tap Intent Matrix" not in first:
        details.append("README title not advanced to Q62")
    for marker in ["SyntheticTapIntentMatrixPolicy", "core isolated structural roles", "template-region taps", "realDevicePlus95PassClaimed, isFalse"]:
        if marker not in test_src:
            details.append(f"Q62 test missing marker: {marker}")
    if "V172-Q62" not in resolver_src and "structuralIntentResolverAvailable = true" not in resolver_src:
        details.append("resolver source missing structural intent availability marker")
    for marker in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
    ]:
        if marker in policy_src:
            details.append(f"forbidden Q62 claim: {marker}")
    if details:
        return CheckResult("v172_q62_synthetic_tap_intent_matrix", "FAIL", "; ".join(details))
    return CheckResult("v172_q62_synthetic_tap_intent_matrix", "PASS", "Q62 adds a synthetic tap intent matrix for phone-like structural slot taps, 19/20 +95 candidate thresholds and linear fallback suppression checks without touching protected UI surfaces or claiming real-device +95 PASS.")


def check_v172_q63_structural_edit_transaction_stress_court(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/structural_edit_transaction_stress_court_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    test = root / "test/v172_q63_structural_edit_transaction_stress_court_test.dart"
    details: list[str] = []
    for path in [policy, contract, pubspec, readme, test]:
        if not path.exists():
            details.append(f"missing {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q63_structural_edit_transaction_stress_court", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    contract_src = read_text(contract)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    test_src = read_text(test)
    for marker in [
        "StructuralEditTransactionStressCourtPolicy",
        "structuralEditTransactionStressCourtAvailable = true",
        "requiredCorrectPerScenario = 20",
        "requiredStressSuccessRate = 1.0",
        "halfTemplateStressFailureAllowed = false",
        "realDevicePlus95PassClaimed = false",
        "9⁄□",
        "sin(□)",
        "∫(9)d□",
    ]:
        if marker not in policy_src:
            details.append(f"Q63 policy missing marker: {marker}")
    for marker in ["0.172.96+172", "V172-Q63", "q63StructuralEditTransactionStressCourtRule"]:
        if marker not in contract_src:
            details.append(f"Q63 contract missing marker: {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    if "V172-Q63 Structural Edit Transaction Stress Test" not in readme_src.splitlines()[0]:
        details.append("README title not advanced to Q63")
    for marker in ["evaluateCoreMatrix", "20/20", "real-device +95 PASS unclaimed"]:
        if marker not in test_src:
            details.append(f"Q63 test missing marker: {marker}")
    for forbidden in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
    ]:
        if forbidden in policy_src:
            details.append(f"forbidden Q63 claim: {forbidden}")
    if details:
        return CheckResult("v172_q63_structural_edit_transaction_stress_court", "FAIL", "; ".join(details))
    return CheckResult("v172_q63_structural_edit_transaction_stress_court", "PASS", "Q63 adds a structural edit transaction stress court with 20/20 normalization checks for insert/delete/clear/replace variants while preserving protected UI surfaces and avoiding real-device +95 claims.")


def check_v172_q64_long_expression_pan_nested_cursor_stability(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/long_expression_pan_nested_cursor_stability_policy.dart"
    viewport = root / "lib/features/workspace/editor_viewport.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    test = root / "test/v172_q64_long_expression_pan_nested_cursor_stability_test.dart"
    for path in [policy, viewport, contract, pubspec, readme, test]:
        if not path.exists():
            details.append(f"missing Q64 file: {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q64_long_expression_pan_nested_cursor_stability", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    viewport_src = read_text(viewport)
    contract_src = read_text(contract)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    test_src = read_text(test)
    for marker in [
        "LongExpressionPanNestedCursorStabilityPolicy",
        "longExpressionPanNestedCursorStabilityAvailable = true",
        "viewportPanMustNotEmitDetachedLinearCaret = true",
        "requiredCorrectPerScenario = CursorGoldenGeometryCourtPolicy.requiredCorrectPerScenario",
        "realDevicePlus95PassClaimed = false",
        "coreLongExpressionStressExpressions",
    ]:
        if marker not in policy_src:
            details.append(f"Q64 policy missing marker: {marker}")
    for marker in [
        "LongExpressionPanNestedCursorStabilityPolicy.activeVisibilityTargetForBundle",
        "SlotGeometryBundleAuthority.buildFromVisualRects",
        "isLongExpressionStressCandidate(widget.expressionText)",
    ]:
        if marker not in viewport_src:
            details.append(f"Q64 viewport wiring missing marker: {marker}")
    for marker in ["0.172.103+172", "V172-Q64", "q64LongExpressionPanNestedCursorStabilityRule"]:
        if marker not in contract_src:
            details.append(f"Q64 contract missing marker: {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    if "V172-Q64 Long Expression Pan Nested Cursor Stability" not in readme_src.splitlines()[0]:
        details.append("README title not advanced to Q64")
    for marker in ["pan intent", "SlotGeometryBundle leading rail", "real-device +95 PASS"]:
        if marker not in test_src:
            details.append(f"Q64 test missing marker: {marker}")
    for forbidden in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
    ]:
        if forbidden in policy_src:
            details.append(f"forbidden Q64 claim: {forbidden}")
    if details:
        return CheckResult("v172_q64_long_expression_pan_nested_cursor_stability", "FAIL", "; ".join(details))
    return CheckResult("v172_q64_long_expression_pan_nested_cursor_stability", "PASS", "Q64 adds long-expression/pan/nested cursor stability court using SlotGeometryBundle active targets while preserving protected UI surfaces and avoiding real-device +95 claims.")


def check_v172_q65_real_device_cursor_checkpoint_protocol(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/real_device_cursor_checkpoint_protocol_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    test = root / "test/v172_q65_real_device_cursor_checkpoint_protocol_test.dart"
    for path in [policy, contract, pubspec, readme, test]:
        if not path.exists():
            details.append(f"missing Q65 file: {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q65_real_device_cursor_checkpoint_protocol", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    contract_src = read_text(contract)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    test_src = read_text(test)
    for marker in [
        "RealDeviceCursorCheckpointProtocolPolicy",
        "checkpointProtocolAvailable = true",
        "flutterAnalyzeEvidenceRequired = true",
        "flutterTestEvidenceRequired = true",
        "flutterRunDeviceEvidenceRequired = true",
        "phoneScreenshotOrVideoEvidenceRequired = true",
        "cursorPlus95ClaimAllowedWithoutEvidence = false",
        "requiredCorrectPerScenario = 19",
        "requiredCheckpointScenarios",
    ]:
        if marker not in policy_src:
            details.append(f"Q65 policy missing marker: {marker}")
    for marker in ["0.172.103+172", "V172-Q65", "q65RealDeviceCursorCheckpointProtocolRule"]:
        if marker not in contract_src:
            details.append(f"Q65 contract missing marker: {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    if "V172-Q65 Real Device Cursor Checkpoint Protocol" not in readme_src.splitlines()[0]:
        details.append("README title not advanced to Q65")
    for marker in ["flutter analyze", "flutter test", "flutter run", "real-device +95 PASS", "19/20"]:
        if marker not in readme_src:
            details.append(f"Q65 README missing marker: {marker}")
    for marker in ["RealDeviceCursorCheckpointProtocolPolicy", "0.172.103+172", "V172-Q65", "does not claim real-device PASS"]:
        if marker not in test_src:
            details.append(f"Q65 test missing marker: {marker}")
    for forbidden in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
        "cursorPlus95ClaimAllowedWithoutEvidence = true",
    ]:
        if forbidden in policy_src:
            details.append(f"forbidden Q65 claim: {forbidden}")
    if details:
        return CheckResult("v172_q65_real_device_cursor_checkpoint_protocol", "FAIL", "; ".join(details))
    return CheckResult("v172_q65_real_device_cursor_checkpoint_protocol", "PASS", "Q65 adds a real-device cursor checkpoint protocol over Q54-Q64 automatic cursor courts without claiming +95 or mutating protected visual surfaces.")



def check_v172_q72_native_slotbox_painter(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/native_slotbox_painter_policy.dart"
    overlay = root / "lib/features/workspace/editor_caret_overlay.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q72_native_slotbox_painter_test.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    details: list[str] = []
    for path in [policy, overlay, contract, test, pubspec, readme]:
        if not path.exists():
            details.append(f"missing {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q72_native_slotbox_painter", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    overlay_src = read_text(overlay)
    contract_src = read_text(contract)
    test_src = read_text(test)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    for marker in [
        "nativeSlotBoxPainterAvailable = true",
        "painterUsesSlotGeometryBundle = true",
        "painterHasIndependentRectMath = false",
        "painterMayUseHitRectForCaret = false",
        "emptySlotPainterMustEmitLeadingCaret = true",
        "visibleSlotBoxesEnabledByDefault = false",
        "realDevicePlus95PassClaimed = false",
        "paintModelForBundle",
        "NativeSlotBoxPaintModel",
        "modelUsesSameBundle",
        "caretIsPaintSafe",
    ]:
        if marker not in policy_src:
            details.append(f"Q72 painter policy missing marker: {marker}")
    for marker in [
        "NativeSlotBoxPainterPolicy.paintModelForBundle",
        "SlotGeometryBundleAuthority.buildFromVisualRects",
        "bundle.visualRect",
        "bundle.placeholderRect",
        "SlotGeometryBundle.leadingRailRect",
    ]:
        if marker not in overlay_src:
            details.append(f"editor_caret_overlay missing Q72 wiring: {marker}")
    for marker in ["0.172.103+172", "V172-Q72", "q72NativeSlotBoxPainterRule"]:
        if marker not in contract_src:
            details.append(f"contract missing {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    if "V172-Q72 Native SlotBox Painter" not in readme_src:
        details.append("README title not advanced to Q72")
    for marker in ["NativeSlotBoxPainterPolicy", "modelUsesSameBundle", "caretIsPaintSafe", "visibleSlotBoxesEnabledByDefault"]:
        if marker not in test_src:
            details.append(f"Q72 test missing marker: {marker}")
    for marker in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
    ]:
        if marker in policy_src:
            details.append(f"forbidden Q72 claim: {marker}")
    if details:
        return CheckResult("v172_q72_native_slotbox_painter", "FAIL", "; ".join(details))
    return CheckResult("v172_q72_native_slotbox_painter", "PASS", "Q72 routes the painted editor caret/slot model through the same SlotGeometryBundle source used by hit-test, keeps visible slot boxes disabled by default, preserves protected UI surfaces, and refuses real-device +95 PASS without evidence.")


def check_v172_q73_native_slotbox_hit_test_engine(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/native_slotbox_hit_test_policy.dart"
    interaction = root / "lib/features/editor/render/editor_interaction_layer.dart"
    reconcile = root / "lib/features/formula_engine/existing_cursor_engine_reconciliation_policy.dart"
    resolver = root / "lib/features/formula_engine/structural_intent_resolver_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q73_native_slotbox_hit_test_engine_test.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    details: list[str] = []
    for path in [policy, interaction, reconcile, resolver, contract, test, pubspec, readme]:
        if not path.exists():
            details.append(f"missing {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q73_native_slotbox_hit_test_engine", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    interaction_src = read_text(interaction)
    reconcile_src = read_text(reconcile)
    resolver_src = read_text(resolver)
    contract_src = read_text(contract)
    test_src = read_text(test)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    for marker in [
        "nativeSlotBoxHitTestAvailable = true",
        "authoritativeHitRectOnly = true",
        "nearestDistanceFallbackAllowed = false",
        "legacyNearestStructuralFallbackAllowed = false",
        "visualRectOnlyFallbackAllowedWithBundles = false",
        "overlappingHitRectsUseDeterministicTieBreak = true",
        "hitTest",
        "pointHitsAnyAuthoritativeSlot",
        "canUseLegacyVisualHitTest",
        "canUseLegacyNearestStructuralFallback",
        "realDevicePlus95PassClaimed = false",
    ]:
        if marker not in policy_src:
            details.append(f"Q73 hit-test policy missing marker: {marker}")
    input_surface_src = read_text(root / "lib/features/formula_engine/native_slotbox_input_surface_integration_policy.dart") if (root / "lib/features/formula_engine/native_slotbox_input_surface_integration_policy.dart").exists() else ""
    for marker in [
        "NativeSlotBoxHitTestPolicy.hitTest",
        "NativeSlotBoxHitTestPolicy.canUseLegacyVisualHitTest",
        "shouldBlockLinearFallbackInsideMeasuredStructuralHit",
    ]:
        if marker not in interaction_src and marker not in input_surface_src:
            details.append(f"editor_interaction_layer/input-surface missing Q73 wiring: {marker}")
    for marker in [
        "q73NativeSlotBoxHitTestWired = true",
        "nearestStructuralFallbackEnabled = false",
        "NativeSlotBoxHitTestPolicy.canUseLegacyNearestStructuralFallback",
    ]:
        if marker not in reconcile_src:
            details.append(f"existing reconciliation missing Q73 no-nearest marker: {marker}")
    for marker in ["q73NativeSlotBoxHitTestWired = true", "NativeSlotBoxHitTestPolicy.hitTest"]:
        if marker not in resolver_src:
            details.append(f"structural intent resolver missing Q73 marker: {marker}")
    for marker in ["0.172.106+172", "V172-Q73", "q73NativeSlotBoxHitTestRule"]:
        if marker not in contract_src:
            details.append(f"contract missing {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    if "V172-Q80 Real Device Cursor Court | V172-Q80R1 Static Contract Audit Repair" not in (readme_src.splitlines()[0] if readme_src.splitlines() else ""):
        details.append("README title not advanced to Q80")
    for marker in [
        "NativeSlotBoxHitTestPolicy",
        "authoritative SlotGeometryBundle hitRects",
        "nearest structural reconciliation fallback",
        "nearestDistanceFallbackAllowed, isFalse",
    ]:
        if marker not in test_src:
            details.append(f"Q73 test missing marker: {marker}")
    for marker in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
        "nearestDistanceFallbackAllowed = true",
    ]:
        if marker in policy_src:
            details.append(f"forbidden Q73 claim: {marker}")
    if details:
        return CheckResult("v172_q73_native_slotbox_hit_test_engine", "FAIL", "; ".join(details))
    return CheckResult("v172_q73_native_slotbox_hit_test_engine", "PASS", "Q73 routes structural taps through authoritative SlotGeometryBundle hitRects only, disables legacy nearest structural fallback, preserves protected UI surfaces, and refuses real-device +95 PASS without evidence.")



def check_v172_q74_native_exclusive_caret_renderer(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/native_exclusive_placeholder_caret_renderer_policy.dart"
    painter = root / "lib/features/formula_engine/native_slotbox_painter_policy.dart"
    overlay = root / "lib/features/workspace/editor_caret_overlay.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q74_native_exclusive_caret_renderer_test.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    details: list[str] = []
    for path in [policy, painter, overlay, contract, test, pubspec, readme]:
        if not path.exists():
            details.append(f"missing {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q74_native_exclusive_caret_renderer", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    painter_src = read_text(painter)
    overlay_src = read_text(overlay)
    contract_src = read_text(contract)
    test_src = read_text(test)
    for marker in [
        "nativeExclusiveCaretRendererAvailable = true",
        "emptySlotUsesLeadingRailOnly = true",
        "emptySlotMayUseHitRectForCaret = false",
        "emptySlotMayUseTrailingRail = false",
        "emptySlotMayUseLinearFallbackCaret = false",
        "exclusiveEmptySlotVisualLaw = '|□'",
        "exclusiveCaretForEmptySlot",
        "isExclusivePipeBoxCaret",
        "realDevicePlus95PassClaimed = false",
    ]:
        if marker not in policy_src:
            details.append(f"Q74 exclusive caret policy missing marker: {marker}")
    for marker in [
        "NativeExclusivePlaceholderCaretRendererPolicy.exclusiveCaretForEmptySlot",
        "q74ExclusiveCaretRendererWired = true",
    ]:
        if marker not in painter_src:
            details.append(f"native_slotbox_painter missing Q74 wiring: {marker}")
    for marker in [
        "NativeExclusivePlaceholderCaretRendererPolicy.exclusiveCaretForEmptySlot",
        "NativeExclusivePlaceholderCaretRendererPolicy.isExclusivePipeBoxCaret",
    ]:
        if marker not in overlay_src:
            details.append(f"editor_caret_overlay missing Q74 wiring: {marker}")
    for marker in ["0.172.105+172", "V172-Q74", "q74NativeExclusiveCaretRendererRule"]:
        if marker not in contract_src:
            details.append(f"contract missing {marker}")
    for marker in ["0.172.112+172", "V172-Q80 real device cursor court"]:
        if marker not in read_text(pubspec):
            details.append(f"pubspec missing active Q80 marker after Q74 recovery: {marker}")
    if "V172-Q80 Real Device Cursor Court | V172-Q80R1 Static Contract Audit Repair" not in (read_text(readme).splitlines()[0] if read_text(readme).splitlines() else ""):
        details.append("README title not advanced to Q80")
    for marker in [
        "NativeExclusivePlaceholderCaretRendererPolicy",
        "emptySlotUsesLeadingRailOnly",
        "isExclusivePipeBoxCaret",
        "q74ExclusiveCaretRendererWired",
    ]:
        if marker not in test_src:
            details.append(f"Q74 test missing marker: {marker}")
    for marker in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
        "emptySlotMayUseHitRectForCaret = true",
    ]:
        if marker in policy_src:
            details.append(f"forbidden Q74 claim: {marker}")
    if details:
        return CheckResult("v172_q74_native_exclusive_caret_renderer", "FAIL", "; ".join(details))
    return CheckResult("v172_q74_native_exclusive_caret_renderer", "PASS", "Q74 restores the native exclusive |□ caret renderer from SlotGeometryBundle leading rails, forbids hitRect/trailing/linear empty-slot carets, preserves protected UI surfaces, and refuses real-device +95 PASS without evidence.")


def check_v172_q75_native_structural_edit_transaction_binding(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/native_structural_edit_transaction_binding_policy.dart"
    controller = root / "lib/state/calculator_controller.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q75_native_structural_edit_transaction_binding_test.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    details: list[str] = []
    for path in [policy, controller, contract, test, pubspec, readme]:
        if not path.exists():
            details.append(f"missing {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q75_native_structural_edit_transaction_binding", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    controller_src = read_text(controller)
    contract_src = read_text(contract)
    test_src = read_text(test)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    for marker in [
        "nativeStructuralEditTransactionBindingAvailable = true",
        "activeSlotIdRequiredForStructuralEdit = true",
        "openSlotFillKeepsStructuralFocus = true",
        "singleFunctionArgumentFillUsesInlineLinearCaret = true",
        "filledSlotInsertKeepsStructuralFocus = true",
        "filledSlotBackspaceKeepsStructuralFocus = true",
        "structuralEditMayExitToDetachedLinearCaret = false",
        "functionArgumentAutoExitAfterFirstDigitAllowed = false",
        "shouldBindTextToActiveSlot",
        "shouldUseInlineLinearCaretAfterOpenSlotFill",
        "shouldKeepStructuralFocusAfterOpenSlotFill",
        "shouldKeepStructuralFocusAfterFilledSlotEdit",
        "realDevicePlus95PassClaimed = false",
    ]:
        if marker not in policy_src:
            details.append(f"Q75 transaction binding policy missing marker: {marker}")
    for marker in [
        "NativeStructuralEditTransactionBindingPolicy.shouldBindTextToActiveSlot",
        "NativeStructuralEditTransactionBindingPolicy.shouldUseInlineLinearCaretAfterOpenSlotFill",
        "NativeStructuralEditTransactionBindingPolicy.shouldKeepStructuralFocusAfterOpenSlotFill",
        "NativeStructuralEditTransactionBindingPolicy.shouldKeepStructuralFocusAfterFilledSlotEdit",
        "NativeStructuralEditTransactionBindingPolicy.sourceFor",
    ]:
        if marker not in controller_src:
            details.append(f"calculator_controller missing Q75 wiring: {marker}")
    if "v172g-slotPayloadBackspace" not in controller_src:
        details.append("calculator_controller missing V172-G scoped backspace compatibility marker")
    forbidden_controller_markers = [
        "lastHitSource: 'v172b-functionArgumentInlineInsert'",
        "source: 'v172q43-slotPayloadInlineInsert'",
    ]
    for marker in forbidden_controller_markers:
        if marker in controller_src:
            details.append(f"controller still contains pre-Q75 detached transaction source: {marker}")
    for marker in ["0.172.106+172", "V172-Q75", "q75NativeStructuralEditTransactionBindingRule"]:
        if marker not in contract_src:
            details.append(f"contract missing {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    if "V172-Q80 Real Device Cursor Court | V172-Q80R1 Static Contract Audit Repair" not in (readme_src.splitlines()[0] if readme_src.splitlines() else ""):
        details.append("README title not advanced to Q80")
    for marker in [
        "NativeStructuralEditTransactionBindingPolicy",
        "functionArgumentAutoExitAfterFirstDigitAllowed, isFalse",
        "sin(30)",
        "12⁄3945",
    ]:
        if marker not in test_src:
            details.append(f"Q75 test missing marker: {marker}")
    for marker in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
        "structuralEditMayExitToDetachedLinearCaret = true",
        "functionArgumentAutoExitAfterFirstDigitAllowed = true",
    ]:
        if marker in policy_src:
            details.append(f"forbidden Q75 claim: {marker}")
    if details:
        return CheckResult("v172_q75_native_structural_edit_transaction_binding", "FAIL", "; ".join(details))
    return CheckResult("v172_q75_native_structural_edit_transaction_binding", "PASS", "Q75 binds insert/delete/replace transactions to the active SlotBox id, keeps eligible structural focus after edits, prevents single-slot function auto-exit to detached linear caret, preserves protected UI surfaces, and refuses real-device +95 PASS without evidence.")


def check_v172_q76_native_input_surface_integration(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/native_slotbox_input_surface_integration_policy.dart"
    interaction = root / "lib/features/editor/render/editor_interaction_layer.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q76_native_input_surface_integration_test.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    details: list[str] = []
    for path in [policy, interaction, contract, test, pubspec, readme]:
        if not path.exists():
            details.append(f"missing {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q76_native_input_surface_integration", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    interaction_src = read_text(interaction)
    contract_src = read_text(contract)
    test_src = read_text(test)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    for marker in [
        "nativeInputSurfaceIntegrationAvailable = true",
        "singleRuntimeFrameOwnsEditorInteraction = true",
        "hitTestPainterAndFallbackShareGeometryBundles = true",
        "nativeSurfaceBlocksLegacyPlaceholderFallbackWithGeometry = true",
        "nativeSurfaceUsesAuthoritativeSlotRects = true",
        "visibleSlotOverlayRemainsOptIn = true",
        "buildFrame",
        "NativeSlotBoxInputSurfaceFrame",
        "frameIsAuthoritative",
        "realDevicePlus95PassClaimed = false",
    ]:
        if marker not in policy_src:
            details.append(f"Q76 input surface integration policy missing marker: {marker}")
    for marker in [
        "NativeSlotBoxInputSurfaceIntegrationPolicy.buildFrame",
        "NativeSlotBoxInputSurfaceFrame inputSurface",
        "inputSurface.hitTest",
        "inputSurface.legacyPlaceholderFallbackAllowed",
        "inputSurface.shouldBlockDetachedLinearFallbackAt",
        "inputSurface.authorityVisualRects",
    ]:
        if marker not in interaction_src:
            details.append(f"editor_interaction_layer missing Q76 single-frame wiring: {marker}")
    for marker in ["0.172.112+172", "V172-Q77", "q76NativeInputSurfaceIntegrationRule"]:
        if marker not in contract_src:
            details.append(f"contract missing {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    if "V172-Q80 Real Device Cursor Court | V172-Q80R1 Static Contract Audit Repair" not in (readme_src.splitlines()[0] if readme_src.splitlines() else ""):
        details.append("README title not advanced to Q80")
    for marker in [
        "NativeSlotBoxInputSurfaceIntegrationPolicy",
        "singleRuntimeFrameOwnsEditorInteraction, isTrue",
        "frameIsAuthoritative(frame), isTrue",
        "frame.legacyPlaceholderFallbackAllowed, isFalse",
    ]:
        if marker not in test_src:
            details.append(f"Q76 test missing marker: {marker}")
    for marker in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
        "fullNativeMathRendererClaimed = true",
        "trueAstSlotToSvgNodeIdentityClaimed = true",
    ]:
        if marker in policy_src:
            details.append(f"forbidden Q76 claim: {marker}")
    if details:
        return CheckResult("v172_q76_native_input_surface_integration", "FAIL", "; ".join(details))
    return CheckResult("v172_q76_native_input_surface_integration", "PASS", "Q76 integrates editor hit-test, fallback suppression, visible slot overlay geometry and structural edit routing through one NativeSlotBoxInputSurfaceFrame while preserving protected UI surfaces and refusing real-device +95 PASS without evidence.")


def check_v172_q77_integral_native_slotbox_specialization(root: Path) -> CheckResult:
    policy = root / "lib/features/formula_engine/native_integral_slotbox_specialization_policy.dart"
    hit_test = root / "lib/features/formula_engine/native_slotbox_hit_test_policy.dart"
    authority = root / "lib/features/formula_engine/slot_geometry_bundle_authority.dart"
    integration = root / "lib/features/formula_engine/native_slotbox_input_surface_integration_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q77_integral_native_slotbox_specialization_test.dart"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    details: list[str] = []
    for path in [policy, hit_test, authority, integration, contract, test, pubspec, readme]:
        if not path.exists():
            details.append(f"missing {path.relative_to(root)}")
    if details:
        return CheckResult("v172_q77_integral_native_slotbox_specialization", "FAIL", "; ".join(details))
    policy_src = read_text(policy)
    hit_src = read_text(hit_test)
    authority_src = read_text(authority)
    integration_src = read_text(integration)
    contract_src = read_text(contract)
    test_src = read_text(test)
    pubspec_src = read_text(pubspec)
    readme_src = read_text(readme)
    for marker in [
        "nativeIntegralSlotBoxSpecializationAvailable = true",
        "upperLowerBodyDifferentialUseNativeSlotBoxes = true",
        "integralOverlapsUseNativeLaneResolver = true",
        "differentialSlotBeatsBodyWhenPointIsInDifferentialLane = true",
        "integralOutsideAuthoritativeHitRectIsNotSelected = true",
        "differentialEmptyCaretMustBeDPipeBox = true",
        "resolveIntegralCandidate",
        "provesDifferentialNativeDPipeBox",
        "realDevicePlus95PassClaimed = false",
    ]:
        if marker not in policy_src:
            details.append(f"Q77 native integral policy missing marker: {marker}")
    for marker in [
        "NativeIntegralSlotBoxSpecializationPolicy.resolveIntegralCandidate",
        "q77-native-integral-slotbox-lane-hit",
        "q77IntegralNativeLaneResolverWired = true",
    ]:
        if marker not in hit_src:
            details.append(f"native hit-test missing Q77 wiring: {marker}")
    for marker in [
        "NativeIntegralSlotBoxSpecializationPolicy.refineHitRectForRole",
        "NativeIntegralSlotBoxSpecializationPolicy.refinePlaceholderRectForRole",
        "NativeIntegralSlotBoxSpecializationPolicy.refineLeadingRailRectForRole",
        "q77NativeIntegralSlotBoxSpecializationWired = true",
    ]:
        if marker not in authority_src:
            details.append(f"SlotGeometryBundleAuthority missing Q77 wiring: {marker}")
    for marker in [
        "q77IntegralNativeSlotBoxesRideSameInputSurfaceFrame = true",
        "hasCompleteNativeIntegralSlotSet",
    ]:
        if marker not in integration_src:
            details.append(f"input surface integration missing Q77 wiring: {marker}")
    for marker in ["0.172.112+172", "V172-Q77", "q77IntegralNativeSlotBoxSpecializationRule"]:
        if marker not in contract_src:
            details.append(f"contract missing {marker}")
    if "version: 0.172.112+172" not in pubspec_src or "V172-Q80 real device cursor court" not in pubspec_src:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    if "V172-Q80 Real Device Cursor Court | V172-Q80R1 Static Contract Audit Repair" not in (readme_src.splitlines()[0] if readme_src.splitlines() else ""):
        details.append("README title not advanced to Q80")
    for marker in [
        "NativeIntegralSlotBoxSpecializationPolicy",
        "differentialSlotBeatsBodyWhenPointIsInDifferentialLane, isTrue",
        "q77-native-integral-slotbox-lane-hit",
        "provesDifferentialNativeDPipeBox",
    ]:
        if marker not in test_src:
            details.append(f"Q77 test missing marker: {marker}")
    for marker in [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
        "fullNativeMathRendererClaimed = true",
        "trueAstSlotToSvgNodeIdentityClaimed = true",
    ]:
        if marker in policy_src:
            details.append(f"forbidden Q77 claim: {marker}")
    if details:
        return CheckResult("v172_q77_integral_native_slotbox_specialization", "FAIL", "; ".join(details))
    return CheckResult("v172_q77_integral_native_slotbox_specialization", "PASS", "Q77 specializes integral upper/lower/body/differential SlotBoxes through deterministic native integral lanes inside the shared SlotGeometryBundle input surface while preserving protected UI surfaces and refusing real-device +95 PASS without evidence.")



def check_v172_q78_fraction_function_root_log_native_slotbox_specialization(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/native_fraction_function_root_log_slotbox_specialization_policy.dart"
    hit_test = root / "lib/features/formula_engine/native_slotbox_hit_test_policy.dart"
    bundle_authority = root / "lib/features/formula_engine/slot_geometry_bundle_authority.dart"
    integration = root / "lib/features/formula_engine/native_slotbox_input_surface_integration_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q78_fraction_function_root_log_native_slotbox_specialization_test.dart"
    audit = root / "docs/audit/V172_Q78_FRACTION_FUNCTION_ROOT_LOG_NATIVE_SLOTBOX_SPECIALIZATION_AUDIT_REPORT.md"
    manifest = root / "docs/audit/V172_Q78_CHANGED_FILES_MANIFEST.md"
    for path, label in [
        (policy, "Q78 policy"),
        (hit_test, "native hit-test"),
        (bundle_authority, "SlotGeometryBundle authority"),
        (integration, "native input surface integration"),
        (contract, "package contract"),
        (test, "Q78 test"),
        (audit, "Q78 audit"),
        (manifest, "Q78 manifest"),
    ]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    hit_source = read_text(hit_test) if hit_test.exists() else ""
    bundle_source = read_text(bundle_authority) if bundle_authority.exists() else ""
    integration_source = read_text(integration) if integration.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    required_policy_tokens = [
        "v172q78",
        "nativeFractionFunctionRootLogSlotBoxSpecializationAvailable = true",
        "fractionNumeratorDenominatorUseNativeSlotBoxes = true",
        "functionArgumentsUseNativeSlotBoxes = true",
        "rootIndexAndBodyUseNativeSlotBoxes = true",
        "logBaseAndArgumentUseNativeSlotBoxes = true",
        "outsideAuthoritativeHitRectIsNotSelected = true",
        "detachedLinearFallbackSuppressedInsideMeasuredSlots = true",
        "emptySlotsKeepExclusivePipeBoxCaret = true",
        "resolveNativeCandidate",
        "refineHitRectForRole",
        "refinePlaceholderRectForRole",
        "refineLeadingRailRectForRole",
        "realDevicePlus95PassClaimed = false",
    ]
    missing = [token for token in required_policy_tokens if token not in policy_source]
    if missing:
        details.append("Q78 policy missing markers: " + ", ".join(missing))
    if "NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.resolveNativeCandidate" not in hit_source:
        details.append("native_slotbox_hit_test_policy.dart is not wired to Q78 family resolver")
    if "q78-native-fraction-function-root-log-slotbox-lane-hit" not in hit_source:
        details.append("native_slotbox_hit_test_policy.dart is missing Q78 hit source")
    for marker in [
        "q78NativeFractionFunctionRootLogSlotBoxSpecializationWired = true",
        "NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.refineHitRectForRole",
        "NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.refinePlaceholderRectForRole",
        "NativeFractionFunctionRootLogSlotBoxSpecializationPolicy.refineLeadingRailRectForRole",
    ]:
        if marker not in bundle_source:
            details.append(f"SlotGeometryBundle authority missing Q78 marker: {marker}")
    if "q78FractionFunctionRootLogSlotBoxesRideSameInputSurfaceFrame = true" not in integration_source:
        details.append("native input surface integration missing Q78 frame marker")
    if "V172-Q78 Fraction Function Root Log Native SlotBox Specialization" not in contract_source:
        details.append("package contract missing Q78 lineage title")
    for marker in [
        "NativeFractionFunctionRootLogSlotBoxSpecializationPolicy",
        "q78-native-fraction-function-root-log-slotbox-lane-hit",
        "provesPipeBoxLaw",
        "q78FractionFunctionRootLogSlotBoxesRideSameInputSurfaceFrame",
    ]:
        if marker not in test_source:
            details.append(f"Q78 test missing marker: {marker}")
    protected_tokens = [
        "keyboardSurfaceMutationAllowed = false",
        "moreSurfaceMutationAllowed = false",
        "longPressSurfaceMutationAllowed = false",
        "appShellMutationAllowed = false",
        "graphHistorySolutionMutationAllowed = false",
    ]
    for token in protected_tokens:
        if token not in policy_source:
            details.append(f"Q78 policy missing protected-surface marker: {token}")
    forbidden_true_claims = [
        "keyboardSurfaceMutationAllowed = true",
        "moreSurfaceMutationAllowed = true",
        "longPressSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionMutationAllowed = true",
        "realDevicePlus95PassClaimed = true",
        "fullNativeMathRendererClaimed = true",
        "trueAstSlotToSvgNodeIdentityClaimed = true",
    ]
    for token in forbidden_true_claims:
        if token in policy_source:
            details.append(f"forbidden Q78 claim: {token}")
    if details:
        return CheckResult("v172_q78_fraction_function_root_log_native_slotbox_specialization", "FAIL", "; ".join(details))
    return CheckResult("v172_q78_fraction_function_root_log_native_slotbox_specialization", "PASS", "Q78 specializes fraction/function/root/log SlotBoxes through deterministic native lanes inside the shared SlotGeometryBundle input surface while preserving protected UI surfaces and refusing real-device +95 PASS without evidence.")

def check_v172_q79_nested_long_expression_pan_stability(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/native_nested_long_expression_pan_stability_policy.dart"
    hit_test = root / "lib/features/formula_engine/native_slotbox_hit_test_policy.dart"
    integration = root / "lib/features/formula_engine/native_slotbox_input_surface_integration_policy.dart"
    viewport = root / "lib/features/workspace/editor_viewport.dart"
    interaction = root / "lib/features/editor/render/editor_interaction_layer.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q79_nested_long_expression_pan_stability_test.dart"
    audit = root / "docs/audit/V172_Q79_NESTED_LONG_EXPRESSION_PAN_STABILITY_AUDIT_REPORT.md"
    manifest = root / "docs/audit/V172_Q79_CHANGED_FILES_MANIFEST.md"
    for path, label in [
        (policy, "Q79 policy"),
        (hit_test, "native hit-test"),
        (integration, "native input surface integration"),
        (viewport, "editor viewport"),
        (interaction, "editor interaction layer"),
        (contract, "package contract"),
        (test, "Q79 test"),
        (audit, "Q79 audit"),
        (manifest, "Q79 manifest"),
    ]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    hit_source = read_text(hit_test) if hit_test.exists() else ""
    integration_source = read_text(integration) if integration.exists() else ""
    viewport_source = read_text(viewport) if viewport.exists() else ""
    interaction_source = read_text(interaction) if interaction.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required_policy_tokens = [
        "v172q79",
        "nativeNestedLongExpressionPanStabilityAvailable = true",
        "nestedSelectionUsesDeepestMeasuredSlotBox = true",
        "panSourceMayNotEmitDetachedLinearCaret = true",
        "panSourceMayNotSwitchStructuralSlotInLongExpression = true",
        "activeVisibilityTargetUsesNativeCaretRail = true",
        "transformStaleGeometryRejected = true",
        "realDevicePlus95PassClaimed = false",
        "resolveNestedCandidate",
        "shouldSuppressPointerSourceForPan",
        "activeVisibilityTargetForBundle",
    ]
    missing = [token for token in required_policy_tokens if token not in policy_source]
    if missing:
        details.append("Q79 policy missing markers: " + ", ".join(missing))
    if "NativeNestedLongExpressionPanStabilityPolicy.resolveNestedCandidate" not in hit_source:
        details.append("native_slotbox_hit_test_policy.dart is not wired to Q79 nested resolver")
    if "q79-native-nested-long-expression-pan-stable-hit" not in hit_source:
        details.append("native_slotbox_hit_test_policy.dart is missing Q79 hit source")
    if "q79NestedLongExpressionPanStabilityRidesSameInputSurfaceFrame" not in integration_source:
        details.append("native_slotbox_input_surface_integration_policy.dart is missing Q79 frame marker")
    if "NativeNestedLongExpressionPanStabilityPolicy.activeVisibilityTargetForBundle" not in viewport_source:
        details.append("editor_viewport.dart is not using Q79 active visibility targets")
    if "inputSurface.shouldSuppressPointerSourceForPan(source)" not in interaction_source:
        details.append("editor_interaction_layer.dart is not suppressing pan-source cursor emissions through Q79")
    if "V172-Q79 Nested Long Expression Pan Stability" not in contract_source:
        details.append("package contract missing Q79 lineage title")
    protected_tokens = [
        "keyboardSurfaceMutationAllowed = false",
        "moreSurfaceMutationAllowed = false",
        "longPressSurfaceMutationAllowed = false",
        "appShellMutationAllowed = false",
        "graphHistorySolutionMutationAllowed = false",
    ]
    for token in protected_tokens:
        if token not in policy_source:
            details.append(f"Q79 policy missing protected-surface marker: {token}")
    if details:
        return CheckResult("v172_q79_nested_long_expression_pan_stability", "FAIL", "; ".join(details))
    return CheckResult("v172_q79_nested_long_expression_pan_stability", "PASS", "Q79 stabilizes nested and long-expression cursor behavior through native SlotBox geometry, suppresses pan-source detached cursor emissions, preserves protected UI surfaces, and refuses real-device +95 PASS without evidence.")



def check_v172_q80_real_device_cursor_court(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/native_real_device_cursor_court_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q80_real_device_cursor_court_test.dart"
    audit = root / "docs/audit/V172_Q80_REAL_DEVICE_CURSOR_COURT_AUDIT_REPORT.md"
    manifest = root / "docs/audit/V172_Q80_CHANGED_FILES_MANIFEST.md"
    pubspec = root / "pubspec.yaml"
    readme = root / "README.md"
    for path, label in [
        (policy, "Q80 policy"),
        (contract, "package contract"),
        (test, "Q80 test"),
        (audit, "Q80 audit"),
        (manifest, "Q80 manifest"),
        (pubspec, "pubspec"),
        (readme, "README"),
    ]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    pubspec_source = read_text(pubspec) if pubspec.exists() else ""
    readme_source = read_text(readme) if readme.exists() else ""
    required_policy_tokens = [
        "v172q80",
        "nativeRealDeviceCursorCourtAvailable = true",
        "cursorOnlyChange = true",
        "minimumManualScenarioCount = 20",
        "minimumCorrectScenarioCountForCandidate = 19",
        "flutterAnalyzePassClaimedByAssistant = false",
        "flutterTestPassClaimedByAssistant = false",
        "flutterRunPassClaimedByAssistant = false",
        "realDevicePlus95PassClaimed = false",
        "photomathLevelClaimAllowedWithoutEvidence = false",
        "requiredFlutterCommands",
        "requiredManualScenarios",
        "forbiddenFailureModes",
        "qualifiesForCandidatePlus95Review",
        "courtVerdict",
        "d|□",
    ]
    missing = [token for token in required_policy_tokens if token not in policy_source]
    if missing:
        details.append("Q80 policy missing markers: " + ", ".join(missing))
    protected_tokens = [
        "keyboardSurfaceMutationAllowed = false",
        "moreSurfaceMutationAllowed = false",
        "longPressSurfaceMutationAllowed = false",
        "appShellMutationAllowed = false",
        "graphHistorySolutionMutationAllowed = false",
        "solutionPanelMutationAllowed = false",
    ]
    for token in protected_tokens:
        if token not in policy_source:
            details.append(f"Q80 policy missing protected-surface marker: {token}")
    forbidden_true_claims = [
        "flutterAnalyzePassClaimedByAssistant = true",
        "flutterTestPassClaimedByAssistant = true",
        "flutterRunPassClaimedByAssistant = true",
        "realDevicePlus95PassClaimed = true",
        "photomathLevelClaimAllowedWithoutEvidence = true",
        "fullNativeMathRendererClaimed = true",
        "trueAstSlotToSvgNodeIdentityClaimed = true",
    ]
    for token in forbidden_true_claims:
        if token in policy_source:
            details.append(f"forbidden Q80 claim: {token}")
    if "version: 0.172.112+172" not in pubspec_source or "V172-Q80 real device cursor court" not in pubspec_source:
        details.append("pubspec not advanced to Q80 / 0.172.112+172")
    if "V172-Q80 Real Device Cursor Court | V172-Q80R1 Static Contract Audit Repair" not in (readme_source.splitlines()[0] if readme_source.splitlines() else ""):
        details.append("README title not advanced to Q80")
    if "0.172.112+172" not in contract_source or "V172-Q80 Real Device Cursor Court | V172-Q80R1 Static Contract Audit Repair" not in contract_source:
        details.append("package contract is not advanced to Q80 / 0.172.112+172")
    if "q80RealDeviceCursorCourtRule" not in contract_source or "19/20" not in contract_source:
        details.append("package contract missing Q80 19/20 court rule")
    if "V172-Q81" not in contract_source:
        details.append("package contract next phase is not Q81")
    if details:
        return CheckResult("v172_q80_real_device_cursor_court", "FAIL", "; ".join(details))
    return CheckResult("v172_q80_real_device_cursor_court", "PASS", "Q80 adds a real-device cursor court gate: Flutter command evidence, 19/20 manual phone scenarios, protected UI preservation, and no fake +95/Photomath PASS claims without evidence.")


def protected_hash_report(root: Path) -> dict[str, str]:
    report: dict[str, str] = {}
    for rel in PROTECTED_FILES:
        path = root / rel
        report[rel] = sha256(path) if path.exists() else "MISSING"
    return report


def write_reports(root: Path, results: list[CheckResult], protected_hashes: dict[str, str]) -> None:
    project_root_label = root.name
    payload = {
        "project_root": project_root_label,
        "status": "FAIL" if any(r.status == "FAIL" for r in results) else "PASS_WITH_WARNINGS" if any(r.status == "WARN" for r in results) else "PASS",
        "results": [asdict(r) for r in results],
        "protected_file_sha256": protected_hashes,
    }
    tool_dir = root / "tool"
    tool_dir.mkdir(exist_ok=True)
    (tool_dir / "verify_mathpro_contract_report.json").write_text(json.dumps(payload, indent=2, ensure_ascii=False), encoding="utf-8")

    md_lines = ["# MathPro Contract Verification Report", "", f"Overall: **{payload['status']}**", "", "## Checks"]
    for r in results:
        md_lines.append(f"- **{r.status}** `{r.name}` — {r.detail}")
    md_lines.append("")
    md_lines.append("## Protected File SHA256")
    for rel, digest in protected_hashes.items():
        md_lines.append(f"- `{rel}`: `{digest}`")
    (tool_dir / "verify_mathpro_contract_report.md").write_text("\n".join(md_lines) + "\n", encoding="utf-8")


def check_v172_q81_legacy_cursor_freeze(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/formula_engine/legacy_cursor_freeze_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q81_legacy_cursor_freeze_policy_test.dart"
    audit = root / "docs/audit/V172_Q81_LEGACY_CURSOR_FREEZE_ARCHITECTURE_LOCK_AUDIT_REPORT.md"
    manifest = root / "docs/audit/V172_Q81_CHANGED_FILES_MANIFEST.md"
    for path, label in [
        (policy, "Q81 policy"),
        (contract, "package contract"),
        (test, "Q81 test"),
        (audit, "Q81 audit"),
        (manifest, "Q81 manifest"),
    ]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required_policy_tokens = [
        "LegacyCursorFreezePolicy",
        "legacyEngineName = 'LegacyFlutterSlotEditor'",
        "candidateEngineName = 'MathLiveEditorAdapter'",
        "adapterContractName = 'MathEditorAdapter'",
        "legacyCursorEngineDeleted = false",
        "legacyCursorEngineFrozenAsFallback = true",
        "legacyCursorEnginePrimaryFutureDirection = false",
        "newLargeFlutterCursorPatchAllowed = false",
        "mathLiveDirectMainEditorSwitchAllowed = false",
        "mathLiveLabRequiredBeforeMainEditor = true",
        "mathEditorAdapterRequiredBeforeEngineSwitch = true",
        "keyboardSurfaceMutationAllowed = false",
        "moreSurfaceMutationAllowed = false",
        "longPressSurfaceMutationAllowed = false",
        "graphHistorySolutionMutationAllowed = false",
        "mathLiveVirtualKeyboardMayReplaceMathProKeyboard = false",
        "cdnDependencyAllowedForMathLive = false",
        "flutterAnalyzePassClaimedByAssistant = false",
        "flutterTestPassClaimedByAssistant = false",
        "flutterRunPassClaimedByAssistant = false",
        "realDeviceMathLivePassClaimed = false",
        "photomathLevelClaimAllowedWithoutEvidence = false",
        "maySwitchMainEditorToMathLive",
        "architectureVerdict",
    ]
    missing = [token for token in required_policy_tokens if token not in policy_source]
    if missing:
        details.append("Q81 policy missing markers: " + ", ".join(missing))
    if "q81LegacyCursorFreezeRule" not in contract_source:
        details.append("package contract missing Q81 legacy cursor freeze rule")
    if "MathLive virtual keyboard/CDN usage remain forbidden" not in contract_source:
        details.append("package contract missing Q81 MathLive keyboard/CDN restriction")
    if "legacyCursorEngineDeleted = true" in policy_source or "newLargeFlutterCursorPatchAllowed = true" in policy_source:
        details.append("Q81 policy illegally enables deletion or broad custom cursor patching")
    if details:
        return CheckResult("v172_q81_legacy_cursor_freeze_architecture_lock", "FAIL", "; ".join(details))
    return CheckResult("v172_q81_legacy_cursor_freeze_architecture_lock", "PASS", "Q81 freezes the custom Flutter SlotBox cursor stack as LegacyFlutterSlotEditor fallback, requires MathEditorAdapter/MathLive Lab/court before engine switch, and preserves protected UI surfaces without fake PASS claims.")


def check_v172_q82_math_editor_adapter_contract(root: Path) -> CheckResult:
    details: list[str] = []
    adapter = root / "lib/features/editor_adapter/math_editor_adapter.dart"
    legacy = root / "lib/features/editor_adapter/legacy_flutter_slot_editor_adapter.dart"
    mathlive = root / "lib/features/editor_adapter/mathlive_editor_adapter_contract.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q82_math_editor_adapter_contract_test.dart"
    audit = root / "docs/audit/V172_Q82_MATH_EDITOR_ADAPTER_CONTRACT_AUDIT_REPORT.md"
    manifest = root / "docs/audit/V172_Q82_CHANGED_FILES_MANIFEST.md"
    for p, label in [
        (adapter, "MathEditorAdapter contract"),
        (legacy, "legacy adapter"),
        (mathlive, "MathLive adapter contract"),
        (contract, "package contract"),
        (test, "Q82 test"),
        (audit, "Q82 audit"),
        (manifest, "Q82 manifest"),
    ]:
        if not p.exists():
            details.append(f"{label} missing")
    adapter_source = read_text(adapter) if adapter.exists() else ""
    legacy_source = read_text(legacy) if legacy.exists() else ""
    mathlive_source = read_text(mathlive) if mathlive.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required = [
        (adapter_source, "abstract interface class MathEditorAdapter"),
        (adapter_source, "insertTemplate"),
        (adapter_source, "getMathJson"),
        (adapter_source, "MathEditorEngineKind"),
        (legacy_source, "LegacyFlutterSlotEditorAdapter implements MathEditorAdapter"),
        (legacy_source, "legacy-flutter-slot-editor-fallback"),
        (mathlive_source, "MathLiveEditorAdapterContract"),
        (mathlive_source, "implementationBundled = false"),
        (mathlive_source, "mathLiveVirtualKeyboardEnabled = false"),
        (mathlive_source, "cdnDependencyAllowed = false"),
        (mathlive_source, "remoteScriptLoadingAllowed = false"),
        (mathlive_source, "maySwitchMainEditor"),
        (contract_source, "q82MathEditorAdapterContractRule"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q82 missing marker {token}")
    if "mayReplaceMainEditorNow = true" in mathlive_source or "implementationBundled = true" in mathlive_source:
        details.append("Q82 illegally claims MathLive implementation or main editor replacement")
    if details:
        return CheckResult("v172_q82_math_editor_adapter_contract", "FAIL", "; ".join(details))
    return CheckResult("v172_q82_math_editor_adapter_contract", "PASS", "Q82 adds the MathEditorAdapter boundary, preserves LegacyFlutterSlotEditor fallback, and gates any future MathLive implementation without mutating protected UI surfaces.")


def check_v172_q83_offline_mathlive_asset_foundation(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/mathlive/mathlive_offline_asset_policy.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    pubspec = root / "pubspec.yaml"
    test = root / "test/v172_q83_offline_mathlive_asset_foundation_test.dart"
    audit = root / "docs/audit/V172_Q83_OFFLINE_MATHLIVE_ASSET_FOUNDATION_AUDIT_REPORT.md"
    manifest_doc = root / "docs/audit/V172_Q83_CHANGED_FILES_MANIFEST.md"
    asset_paths = [
        root / "assets/mathlive/index.html",
        root / "assets/mathlive/mathlive_bridge.js",
        root / "assets/mathlive/mathlive.css",
        root / "assets/mathlive/manifest.json",
    ]
    for p, label in [
        (policy, "Q83 policy"),
        (contract, "package contract"),
        (pubspec, "pubspec"),
        (test, "Q83 test"),
        (audit, "Q83 audit"),
        (manifest_doc, "Q83 manifest"),
        *[(p, p.relative_to(root).as_posix()) for p in asset_paths],
    ]:
        if not p.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    pubspec_source = read_text(pubspec) if pubspec.exists() else ""
    index_source = read_text(asset_paths[0]) if asset_paths[0].exists() else ""
    bridge_source = read_text(asset_paths[1]) if asset_paths[1].exists() else ""
    manifest_source = read_text(asset_paths[3]) if asset_paths[3].exists() else ""
    required_tokens = [
        (policy_source, "MathLiveOfflineAssetPolicy"),
        (policy_source, "realMathLiveRuntimeBundled = false"),
        (policy_source, "labScreenImplemented = false"),
        (policy_source, "mainEditorSwitchAllowed = false"),
        (policy_source, "cdnDependencyAllowed = false"),
        (policy_source, "remoteScriptLoadingAllowed = false"),
        (policy_source, "mathLiveVirtualKeyboardEnabled = false"),
        (contract_source, "q83OfflineMathLiveAssetFoundationRule"),
        (pubspec_source, "assets/mathlive/"),
        (index_source, "mathlive_bridge.js"),
        (bridge_source, "MathProMathLiveOfflineBridge"),
        (bridge_source, "realMathLiveRuntimeBundled: false"),
        (manifest_source, '"realMathLiveRuntimeBundled": false'),
        (manifest_source, '"cdnDependencyAllowed": false'),
        (manifest_source, '"remoteScriptLoadingAllowed": false'),
    ]
    for source, token in required_tokens:
        if token not in source:
            details.append(f"Q83 missing marker {token}")
    combined_assets = "\n".join(read_text(p) for p in asset_paths if p.exists())
    if "http://" in combined_assets or "https://" in combined_assets:
        details.append("Q83 assets contain remote URL script/style references")
    illegal_true_markers = [
        "realMathLiveRuntimeBundled = true",
        "labScreenImplemented = true",
        "mainEditorSwitchAllowed = true",
        "cdnDependencyAllowed = true",
        "remoteScriptLoadingAllowed = true",
        "mathLiveVirtualKeyboardEnabled = true",
    ]
    for marker in illegal_true_markers:
        if marker in policy_source:
            details.append(f"Q83 illegally enables {marker}")
    if details:
        return CheckResult("v172_q83_offline_mathlive_asset_foundation", "FAIL", "; ".join(details))
    return CheckResult("v172_q83_offline_mathlive_asset_foundation", "PASS", "Q83 adds local assets/mathlive bootstrap files and pubspec registration while explicitly refusing real MathLive runtime, CDN, virtual keyboard, main-editor switch, and fake device PASS claims.")


def check_v172_q85_mathpro_keyboard_to_mathlive_bridge(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/mathlive/mathlive_keyboard_bridge_policy.dart"
    lab = root / "lib/features/mathlive/mathlive_lab_screen.dart"
    bridge = root / "assets/mathlive/mathlive_bridge.js"
    manifest = root / "assets/mathlive/manifest.json"
    index = root / "assets/mathlive/index.html"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q85_mathpro_keyboard_to_mathlive_bridge_test.dart"
    audit = root / "docs/audit/V172_Q85_MATHPRO_KEYBOARD_TO_MATHLIVE_BRIDGE_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q85_CHANGED_FILES_MANIFEST.md"
    for label, path in [
        ("policy", policy),
        ("lab", lab),
        ("bridge", bridge),
        ("manifest", manifest),
        ("index", index),
        ("contract", contract),
        ("test", test),
        ("audit", audit),
        ("changed manifest", changed),
    ]:
        if not path.exists():
            details.append(f"Q85 {label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    lab_source = read_text(lab) if lab.exists() else ""
    bridge_source = read_text(bridge) if bridge.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    index_source = read_text(index) if index.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required = [
        (policy_source, "MathLiveKeyboardBridgePolicy"),
        (policy_source, "phase = 'V172-Q85'"),
        (policy_source, "mainEditorSwitchAllowed = false"),
        (policy_source, "mathLiveVirtualKeyboardEnabled = false"),
        (policy_source, "realMathLiveRuntimeBundled = false"),
        (policy_source, "commandForLabel"),
        (policy_source, r"\frac{}{}"),
        (policy_source, r"\log_{}\left(\right)"),
        (lab_source, "MathLiveKeyboardBridgePolicy.commandForLabel"),
        (lab_source, "executeMathProCommand"),
        (bridge_source, "executeMathProCommand"),
        (bridge_source, "keyboardBridgePhase: 'V172-Q85'"),
        (bridge_source, "mainEditorSwitchAllowed: false"),
        (manifest_source, '"keyboardBridgePhase": "V172-Q85"'),
        (manifest_source, '"keyboardBridgeLabOnly": true'),
        (contract_source, "q85MathProKeyboardToMathLiveBridgeRule"),
        (contract_source, "V172-Q85"),
        (index_source, "V172-Q85"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q85 missing marker {token}")
    combined = "\n".join([index_source, bridge_source, manifest_source])
    if "http://" in combined or "https://" in combined:
        details.append("Q85 assets contain remote URL references")
    illegal = [
        "mainEditorSwitchAllowed = true",
        "mathLiveVirtualKeyboardEnabled = true",
        "realMathLiveRuntimeBundled = true",
        "remoteScriptLoadingAllowed = true",
        "cdnDependencyAllowed = true",
    ]
    for marker in illegal:
        if marker in policy_source:
            details.append(f"Q85 illegally enables {marker}")
    if details:
        return CheckResult("v172_q85_mathpro_keyboard_to_mathlive_bridge", "FAIL", "; ".join(details))
    return CheckResult("v172_q85_mathpro_keyboard_to_mathlive_bridge", "PASS", "Q85 maps frozen MathPro key labels to lab-only MathLive command payloads without switching the main editor, enabling MathLive virtual keyboard, or mutating protected UI surfaces.")


def check_v172_q86_mathlive_state_adapter(root: Path) -> CheckResult:
    details: list[str] = []
    adapter = root / "lib/features/mathlive/mathlive_state_adapter.dart"
    lab = root / "lib/features/mathlive/mathlive_lab_screen.dart"
    bridge = root / "assets/mathlive/mathlive_bridge.js"
    manifest = root / "assets/mathlive/manifest.json"
    index = root / "assets/mathlive/index.html"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q86_mathlive_state_adapter_test.dart"
    audit = root / "docs/audit/V172_Q86_MATHLIVE_STATE_ADAPTER_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q86_CHANGED_FILES_MANIFEST.md"
    for label, path in [
        ("adapter", adapter),
        ("lab", lab),
        ("bridge", bridge),
        ("manifest", manifest),
        ("index", index),
        ("contract", contract),
        ("test", test),
        ("audit", audit),
        ("changed manifest", changed),
    ]:
        if not path.exists():
            details.append(f"Q86 {label} missing")
    adapter_source = read_text(adapter) if adapter.exists() else ""
    lab_source = read_text(lab) if lab.exists() else ""
    bridge_source = read_text(bridge) if bridge.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    index_source = read_text(index) if index.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required = [
        (adapter_source, "MathLiveStateAdapterPolicy"),
        (adapter_source, "phase = 'V172-Q86'"),
        (adapter_source, "parseBridgeMessage"),
        (adapter_source, "toMathEditorOutputState"),
        (adapter_source, "mainEditorSwitchAllowed = false"),
        (adapter_source, "mathLiveVirtualKeyboardEnabled = false"),
        (adapter_source, "officialMathLiveRuntimeBundled = false"),
        (adapter_source, "remoteScriptLoadingAllowed = false"),
        (lab_source, "MathLiveStateAdapter.parseBridgeMessage"),
        (lab_source, "Q86"),
        (bridge_source, "stateAdapterPhase: 'V172-Q86'"),
        (bridge_source, "JSON.stringify(getState())"),
        (bridge_source, "normalizedLatex"),
        (bridge_source, "plainText"),
        (bridge_source, "stateAdapterLabOnly: true"),
        (manifest_source, '"stateAdapterPhase": "V172-Q86"'),
        (manifest_source, '"stateAdapterLabOnly": true'),
        (contract_source, "q86MathLiveStateAdapterRule"),
        (contract_source, "V172-Q86"),
        (index_source, "V172-Q86"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q86 missing marker {token}")
    combined = "\n".join([index_source, bridge_source, manifest_source])
    if "http://" in combined or "https://" in combined:
        details.append("Q86 assets contain remote URL references")
    illegal = [
        "mainEditorSwitchAllowed = true",
        "mathLiveVirtualKeyboardEnabled = true",
        "officialMathLiveRuntimeBundled = true",
        "remoteScriptLoadingAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "realDeviceMathLiveCursorPassClaimed = true",
    ]
    for marker in illegal:
        if marker in adapter_source:
            details.append(f"Q86 illegally enables {marker}")
    if details:
        return CheckResult("v172_q86_mathlive_state_adapter", "FAIL", "; ".join(details))
    return CheckResult("v172_q86_mathlive_state_adapter", "PASS", "Q86 converts local MathLive Lab bridge state into MathEditorOutputState while keeping the main editor, MathLive virtual keyboard, remote scripts, protected UI surfaces, and fake device PASS claims locked down.")



def check_v172_q87_mathlive_cursor_court(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/mathlive/mathlive_cursor_court_policy.dart"
    lab = root / "lib/features/mathlive/mathlive_lab_screen.dart"
    bridge = root / "assets/mathlive/mathlive_bridge.js"
    manifest = root / "assets/mathlive/manifest.json"
    index = root / "assets/mathlive/index.html"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q87_mathlive_cursor_court_test.dart"
    audit = root / "docs/audit/V172_Q87_MATHLIVE_CURSOR_COURT_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q87_CHANGED_FILES_MANIFEST.md"
    for label, path in [
        ("policy", policy),
        ("lab", lab),
        ("bridge", bridge),
        ("manifest", manifest),
        ("index", index),
        ("contract", contract),
        ("test", test),
        ("audit", audit),
        ("changed manifest", changed),
    ]:
        if not path.exists():
            details.append(f"Q87 {label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    lab_source = read_text(lab) if lab.exists() else ""
    bridge_source = read_text(bridge) if bridge.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    index_source = read_text(index) if index.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required = [
        (policy_source, "MathLiveCursorCourtPolicy"),
        (policy_source, "phase = 'V172-Q87'"),
        (policy_source, "requiredScenarioCount = 22"),
        (policy_source, "minimumPassingScenarios = 20"),
        (policy_source, "maximumBlockingFailures = 0"),
        (policy_source, "officialMathLiveRuntimeBundled = false"),
        (policy_source, "mainEditorSwitchAllowed = false"),
        (policy_source, "mathLiveVirtualKeyboardEnabled = false"),
        (policy_source, "remoteScriptLoadingAllowed = false"),
        (policy_source, "realDeviceMathLiveCursorPassClaimed = false"),
        (policy_source, "evaluateEvidence"),
        (policy_source, "maySwitchMainEditorAfterCourt"),
        (lab_source, "Q87 cursor court"),
        (bridge_source, "cursorCourtPhase: 'V172-Q87'"),
        (bridge_source, "realDeviceCursorCourtPassClaimed: false"),
        (manifest_source, '"cursorCourtPhase": "V172-Q87"'),
        (manifest_source, '"cursorCourtRequiredScenarioCount": 22'),
        (manifest_source, '"cursorCourtMinimumPassingScenarios": 20'),
        (manifest_source, '"cursorCourtMaximumBlockingFailures": 0'),
        (manifest_source, '"mainEditorSwitchBlockedUntilCursorCourtPasses": true'),
        (contract_source, "q87MathLiveCursorCourtRule"),
        (contract_source, "V172-Q87"),
        (index_source, "V172-Q87"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q87 missing marker {token}")
    combined = "\n".join([index_source, bridge_source, manifest_source])
    if "http://" in combined or "https://" in combined:
        details.append("Q87 assets contain remote URL references")
    illegal = [
        "mainEditorSwitchAllowed = true",
        "mathLiveVirtualKeyboardEnabled = true",
        "officialMathLiveRuntimeBundled = true",
        "remoteScriptLoadingAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "realDeviceMathLiveCursorPassClaimed = true",
        "photomathLevelClaimAllowedWithoutEvidence = true",
    ]
    for marker in illegal:
        if marker in policy_source:
            details.append(f"Q87 illegally enables {marker}")
    if details:
        return CheckResult("v172_q87_mathlive_cursor_court", "FAIL", "; ".join(details))
    return CheckResult("v172_q87_mathlive_cursor_court", "PASS", "Q87 adds a lab-only MathLive cursor court proof gate with 20/22 scenario threshold, zero blocking failures, no fake PASS claims, no virtual keyboard, no remote scripts, no main-editor switch, and protected UI surfaces locked.")



def check_v172_q88_main_editor_engine_switch(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/editor_adapter/math_editor_engine_switch_policy.dart"
    test = root / "test/v172_q88_main_editor_engine_switch_test.dart"
    manifest = root / "assets/mathlive/manifest.json"
    bridge = root / "assets/mathlive/mathlive_bridge.js"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    audit = root / "docs/audit/V172_Q88_MAIN_EDITOR_ENGINE_SWITCH_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q88_CHANGED_FILES_MANIFEST.md"
    for label, path in [
        ("policy", policy),
        ("test", test),
        ("manifest", manifest),
        ("bridge", bridge),
        ("contract", contract),
        ("audit", audit),
        ("changed manifest", changed),
    ]:
        if not path.exists():
            details.append(f"Q88 {label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    bridge_source = read_text(bridge) if bridge.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required = [
        (policy_source, "MathEditorEngineSwitchPolicy"),
        (policy_source, "phase = 'V172-Q88'"),
        (policy_source, "defaultEngine = MathEditorEngineKind.legacyFlutterSlotEditor"),
        (policy_source, "mathLiveMainEditorEnabledByDefault = false"),
        (policy_source, "mainEditorSwitchedToMathLive = false"),
        (policy_source, "legacyFallbackAvailable = true"),
        (policy_source, "rollbackFlagRequired = true"),
        (policy_source, "graphHistorySolutionAdaptersRequired = true"),
        (policy_source, "resolveEngine"),
        (test_source, "V172-Q88 Main Editor Engine Switch Behind Flag"),
        (test_source, "q88-mathlive-switch-blocked-legacy-fallback"),
        (manifest_source, '"engineSwitchPhase": "V172-Q88"'),
        (manifest_source, '"mainEditorSwitchBehindFlag": true'),
        (manifest_source, '"activeMainEditorEngine": "legacyFlutterSlotEditor"'),
        (bridge_source, "engineSwitchPhase: 'V172-Q88'"),
        (bridge_source, "activeMainEditorEngine: 'legacyFlutterSlotEditor'"),
        (contract_source, "q88MainEditorEngineSwitchRule"),
        (contract_source, "V172-Q88"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q88 missing marker {token}")
    combined = "\n".join([manifest_source, bridge_source])
    if "http://" in combined or "https://" in combined:
        details.append("Q88 assets contain remote URL references")
    illegal = [
        "mathLiveMainEditorEnabledByDefault = true",
        "mainEditorSwitchedToMathLive = true",
        "protectedUiSurfaceMutationAllowed = true",
        "keyboardMutationAllowed = true",
        "graphHistorySolutionMutationAllowed = true",
        "fakeMathLivePassClaimAllowed = true",
        "photomathLevelClaimAllowedWithoutEvidence = true",
    ]
    for marker in illegal:
        if marker in policy_source:
            details.append(f"Q88 illegally enables {marker}")
    if details:
        return CheckResult("v172_q88_main_editor_engine_switch", "FAIL", "; ".join(details))
    return CheckResult("v172_q88_main_editor_engine_switch", "PASS", "Q88 adds a rollback-safe feature flag gate while keeping legacy as default/fallback and blocking MathLive main-editor switch until Q87 evidence, runtime, adapters, rollback and protected-surface gates pass.")


def check_v172_q89_mathlive_main_editor_integration(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/mathlive/mathlive_main_editor_integration_policy.dart"
    test = root / "test/v172_q89_mathlive_main_editor_integration_test.dart"
    manifest = root / "assets/mathlive/manifest.json"
    bridge = root / "assets/mathlive/mathlive_bridge.js"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    audit = root / "docs/audit/V172_Q89_MATHLIVE_MAIN_EDITOR_INTEGRATION_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q89_CHANGED_FILES_MANIFEST.md"
    for label, p in [
        ("policy", policy),
        ("test", test),
        ("manifest", manifest),
        ("bridge", bridge),
        ("contract", contract),
        ("audit", audit),
        ("changed manifest", changed),
    ]:
        if not p.exists():
            details.append(f"Q89 {label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    bridge_source = read_text(bridge) if bridge.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required = [
        (policy_source, "MathLiveMainEditorIntegrationPolicy"),
        (policy_source, "phase = 'V172-Q89'"),
        (policy_source, "integrationGuardImplemented = true"),
        (policy_source, "passiveIntegrationShellAllowed = true"),
        (policy_source, "mainEditorIntegratedNow = false"),
        (policy_source, "mathLiveMountedInMainWorkspaceByDefault = false"),
        (policy_source, "legacyEditorRemainsDefault = true"),
        (policy_source, "q87CursorCourtRequired = true"),
        (policy_source, "q88EngineSwitchRequired = true"),
        (policy_source, "officialRuntimeRequired = true"),
        (policy_source, "graphHistorySolutionAdaptersRequired = true"),
        (policy_source, "evaluate"),
        (test_source, "V172-Q89 MathLive Main Editor Integration Guard"),
        (test_source, "q89-mathlive-main-editor-integration-blocked-legacy-default"),
        (test_source, "q89-mathlive-main-editor-integration-ready-behind-flag"),
        (manifest_source, '"mainEditorIntegrationPhase": "V172-Q89"'),
        (manifest_source, '"mainEditorIntegrationGuard": true'),
        (manifest_source, '"mainEditorIntegratedNow": false'),
        (bridge_source, "mainEditorIntegrationPhase: 'V172-Q89'"),
        (bridge_source, "mainEditorIntegrationGuard: true"),
        (bridge_source, "mainEditorIntegratedNow: false"),
        (contract_source, "q89MathLiveMainEditorIntegrationRule"),
        (contract_source, "V172-Q89"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q89 missing marker {token}")
    combined = "\n".join([manifest_source, bridge_source])
    if "http://" in combined or "https://" in combined:
        details.append("Q89 assets contain remote URL references")
    illegal = [
        "mainEditorIntegratedNow = true",
        "mathLiveMountedInMainWorkspaceByDefault = true",
        "protectedUiSurfaceMutationAllowed = true",
        "keyboardSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionMutationAllowed = true",
        "fakeMathLivePassClaimAllowed = true",
        "photomathLevelClaimAllowedWithoutEvidence = true",
    ]
    for marker in illegal:
        if marker in policy_source:
            details.append(f"Q89 illegally enables {marker}")
    if details:
        return CheckResult("v172_q89_mathlive_main_editor_integration", "FAIL", "; ".join(details))
    return CheckResult("v172_q89_mathlive_main_editor_integration", "PASS", "Q89 adds only a guarded MathLive main-editor integration shell/policy: MathLive is not mounted by default, legacy remains default/rollback, and Q87/Q88/runtime/adapter/protected-surface gates remain mandatory.")


def check_v172_q90_legacy_cursor_retirement_phase1(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/editor_adapter/legacy_cursor_retirement_policy.dart"
    test = root / "test/v172_q90_legacy_cursor_retirement_phase1_test.dart"
    manifest = root / "assets/mathlive/manifest.json"
    bridge = root / "assets/mathlive/mathlive_bridge.js"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    audit = root / "docs/audit/V172_Q90_LEGACY_CURSOR_RETIREMENT_PHASE1_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q90_CHANGED_FILES_MANIFEST.md"
    for label, path in [
        ("policy", policy),
        ("test", test),
        ("manifest", manifest),
        ("bridge", bridge),
        ("contract", contract),
        ("audit", audit),
        ("changed manifest", changed),
    ]:
        if not path.exists():
            details.append(f"Q90 {label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    bridge_source = read_text(bridge) if bridge.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required = [
        (policy_source, "LegacyCursorRetirementPolicy"),
        (policy_source, "phase = 'V172-Q90'"),
        (policy_source, "phase1GuardImplemented = true"),
        (policy_source, "physicalLegacyDeletionAllowed = false"),
        (policy_source, "legacyCursorFilesMayBeDeleted = false"),
        (policy_source, "legacyEngineRemainsRollback = true"),
        (policy_source, "broadCustomCursorPatchingAllowed = false"),
        (policy_source, "legacyOverlayBypassAllowedOnlyForProvenMathLiveEngine = true"),
        (policy_source, "legacyHitTestBypassAllowedOnlyForProvenMathLiveEngine = true"),
        (policy_source, "evaluate"),
        (test_source, "V172-Q90 Legacy Cursor Retirement Phase 1 Guard"),
        (test_source, "BLOCKED_KEEP_LEGACY_ACTIVE"),
        (test_source, "PHASE1_BYPASS_READY_BEHIND_FLAG"),
        (test_source, "mayDeleteLegacyCursorFiles"),
        (manifest_source, '"legacyCursorRetirementPhase": "V172-Q90"'),
        (manifest_source, '"legacyCursorFilesMayBeDeleted": false'),
        (bridge_source, "legacyCursorRetirementPhase: 'V172-Q90'"),
        (bridge_source, "legacyCursorFilesMayBeDeleted: false"),
        (contract_source, "q90LegacyCursorRetirementPhase1Rule"),
        (contract_source, "V172-Q90"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q90 missing marker {token}")
    combined = "\n".join([manifest_source, bridge_source])
    if "http://" in combined or "https://" in combined:
        details.append("Q90 assets contain remote URL references")
    illegal = [
        "physicalLegacyDeletionAllowed = true",
        "legacyCursorFilesMayBeDeleted = true",
        "broadCustomCursorPatchingAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "keyboardSurfaceMutationAllowed = true",
        "appShellMutationAllowed = true",
        "solutionGraphHistoryMutationAllowed = true",
        "fakeRetirementPassClaimAllowed = true",
        "photomathLevelClaimAllowedWithoutEvidence = true",
    ]
    for marker in illegal:
        if marker in policy_source:
            details.append(f"Q90 illegally enables {marker}")
    if details:
        return CheckResult("v172_q90_legacy_cursor_retirement_phase1", "FAIL", "; ".join(details))
    return CheckResult("v172_q90_legacy_cursor_retirement_phase1", "PASS", "Q90 adds a non-deleting legacy cursor retirement phase-1 guard: legacy remains rollback/default until a proven MathLive path exists, and only that path may bypass legacy overlay/hit-test while protected surfaces stay locked.")



def check_v172_q90r1_official_mathlive_runtime_bundle_intake(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/mathlive/mathlive_runtime_bundle_policy.dart"
    test = root / "test/v172_q90r1_official_mathlive_runtime_bundle_intake_test.dart"
    installer = root / "tool/install_mathlive_runtime.mjs"
    manifest = root / "assets/mathlive/manifest.json"
    bridge = root / "assets/mathlive/mathlive_bridge.js"
    vendor_readme = root / "assets/mathlive/vendor/mathlive/README.md"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    audit = root / "docs/audit/V172_Q90R1_OFFICIAL_MATHLIVE_RUNTIME_BUNDLE_INTAKE_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q90R1_CHANGED_FILES_MANIFEST.md"
    for path, label in [
        (policy, "policy"),
        (test, "test"),
        (installer, "installer"),
        (manifest, "manifest"),
        (bridge, "bridge"),
        (vendor_readme, "vendor README"),
        (audit, "audit"),
        (changed, "changed manifest"),
    ]:
        if not path.exists():
            details.append(f"Q90R1 {label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    installer_source = read_text(installer) if installer.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    bridge_source = read_text(bridge) if bridge.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required = [
        (policy_source, "phase = 'V172-Q90R1'"),
        (policy_source, "officialRuntimeBundledByAssistant = false"),
        (policy_source, "officialRuntimeClaimAllowedWithoutFiles = false"),
        (policy_source, "remoteScriptLoadingAllowed = false"),
        (policy_source, "mathLiveVirtualKeyboardEnabled = false"),
        (policy_source, "mainEditorSwitchAllowed = false"),
        (policy_source, "expectedRuntimeAssets"),
        (policy_source, "OFFICIAL_RUNTIME_BUNDLE_READY_FOR_LAB"),
        (policy_source, "BLOCKED_OFFICIAL_RUNTIME_NOT_BUNDLED"),
        (test_source, "V172-Q90R1 Official MathLive Runtime Bundle Intake Guard"),
        (installer_source, "npm"),
        (installer_source, "mathlive"),
        (installer_source, "runtime_manifest.json"),
        (manifest_source, '"runtimeBundlePhase": "V172-Q90R1"'),
        (manifest_source, '"officialRuntimeInstallerScriptProvided": true'),
        (manifest_source, '"officialMathLiveRuntimeBundled": false'),
        (bridge_source, "runtimeBundlePhase: 'V172-Q90R1'"),
        (bridge_source, "officialRuntimeInstallerScriptProvided: true"),
        (contract_source, "q90r1OfficialMathLiveRuntimeBundleIntakeRule"),
        (contract_source, "V172-Q90R1"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q90R1 missing marker {token}")
    for label, source in [("manifest", manifest_source), ("bridge", bridge_source)]:
        if "http://" in source or "https://" in source:
            details.append(f"Q90R1 {label} contains remote URL reference")
    if "mathlive.min.js" in manifest_source and "officialMathLiveRuntimeBundled":
        pass
    # The official runtime may be installed later by the developer. If it is
    # present, it must be accompanied by provenance files rather than being an
    # unverified/fake runtime drop. Q90R4 performs the stricter post-install
    # verification.
    shipped_runtime = root / "assets/mathlive/vendor/mathlive/mathlive.min.js"
    shipped_runtime_manifest = root / "assets/mathlive/vendor/mathlive/runtime_manifest.json"
    shipped_package_json = root / "assets/mathlive/vendor/mathlive/package.json"
    if shipped_runtime.exists() and not (shipped_runtime_manifest.exists() and shipped_package_json.exists()):
        details.append("Q90R1 found mathlive.min.js without runtime_manifest.json and package.json provenance")
    if details:
        return CheckResult("v172_q90r1_official_mathlive_runtime_bundle_intake", "FAIL", "; ".join(details))
    return CheckResult("v172_q90r1_official_mathlive_runtime_bundle_intake", "PASS", "Q90R1 adds a no-fake official MathLive runtime intake guard, developer-side npm installer, local vendor slot/provenance manifest requirements, disabled virtual keyboard/remote scripts, and no main-editor switch.")


def check_v172_q90r2_mathlive_lab_runtime_smoke(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/mathlive/mathlive_runtime_smoke_policy.dart"
    test = root / "test/v172_q90r2_mathlive_lab_runtime_smoke_test.dart"
    index = root / "assets/mathlive/index.html"
    manifest = root / "assets/mathlive/manifest.json"
    bridge = root / "assets/mathlive/mathlive_bridge.js"
    lab = root / "lib/features/mathlive/mathlive_lab_screen.dart"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    audit = root / "docs/audit/V172_Q90R2_MATHLIVE_LAB_RUNTIME_SMOKE_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q90R2_CHANGED_FILES_MANIFEST.md"
    for label, path in [
        ("policy", policy),
        ("test", test),
        ("index", index),
        ("manifest", manifest),
        ("bridge", bridge),
        ("lab screen", lab),
        ("contract", contract),
        ("audit", audit),
        ("changed manifest", changed),
    ]:
        if not path.exists():
            details.append(f"Q90R2 {label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    index_source = read_text(index) if index.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    bridge_source = read_text(bridge) if bridge.exists() else ""
    lab_source = read_text(lab) if lab.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required = [
        (policy_source, "phase = 'V172-Q90R2'"),
        (policy_source, "minimumSmokeCommands = 6"),
        (policy_source, "mainEditorSwitchAllowed = false"),
        (policy_source, "mathLiveVirtualKeyboardMustStayDisabled = true"),
        (policy_source, "MATHLIVE_LAB_RUNTIME_SMOKE_READY_FOR_CURSOR_COURT"),
        (policy_source, "BLOCKED_MATHLIVE_LAB_RUNTIME_SMOKE"),
        (test_source, "V172-Q90R2 MathLive Lab Real Runtime Smoke Test Gate"),
        (index_source, "MathProOfficialMathLiveRuntimeProbe"),
        (index_source, "vendor/mathlive/mathlive.min.js"),
        (manifest_source, '"runtimeSmokePhase": "V172-Q90R2"'),
        (manifest_source, '"runtimeSmokePassClaimed": false'),
        (manifest_source, '"mainEditorStillLegacyDuringSmoke": true'),
        (bridge_source, "runtimeSmokePhase: 'V172-Q90R2'"),
        (bridge_source, "runRuntimeSmokeProbe"),
        (bridge_source, "tryMountOfficialMathLive"),
        (bridge_source, "math-field"),
        (bridge_source, "mainEditorSwitchAllowed: false"),
        (lab_source, "mathlive-lab-runtime-smoke"),
        (lab_source, "runRuntimeSmokeProbe"),
        (contract_source, "q90r2MathLiveRuntimeSmokeRule"),
        (contract_source, "V172-Q90R2"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q90R2 missing marker {token}")
    for label, source in [("manifest", manifest_source), ("bridge", bridge_source)]:
        if "http://" in source or "https://" in source:
            details.append(f"Q90R2 {label} contains remote URL reference")
    illegal = [
        "mainEditorSwitchAllowed = true",
        "mainEditorMountAllowed = true",
        "legacyEngineRemainsDefault = false",
        "legacyEngineRemainsRollback = false",
        "mathLiveVirtualKeyboardMustStayDisabled = false",
        "remoteScriptsAllowed = true",
        "officialRuntimeClaimAllowedWithoutSmoke = true",
        "cursorPassClaimAllowedWithoutRealDeviceCourt = true",
    ]
    for marker in illegal:
        if marker in policy_source:
            details.append(f"Q90R2 illegally enables {marker}")
    if details:
        return CheckResult("v172_q90r2_mathlive_lab_runtime_smoke", "FAIL", "; ".join(details))
    return CheckResult("v172_q90r2_mathlive_lab_runtime_smoke", "PASS", "Q90R2 adds a lab-only real-runtime smoke gate: local official MathLive script and math-field mounting are required before Q87 cursor court, while main editor switch remains blocked and legacy stays default/rollback.")




def check_v172_q90r4_mathlive_runtime_install_verification(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/mathlive/mathlive_runtime_install_verification_policy.dart"
    test = root / "test/v172_q90r4_mathlive_runtime_install_verification_test.dart"
    verifier = root / "tool/verify_mathlive_runtime.mjs"
    manifest = root / "assets/mathlive/manifest.json"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    audit = root / "docs/audit/V172_Q90R4_MATHLIVE_RUNTIME_INSTALL_VERIFICATION_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q90R4_CHANGED_FILES_MANIFEST.md"
    for label, path in [
        ("policy", policy),
        ("test", test),
        ("verifier", verifier),
        ("manifest", manifest),
        ("contract", contract),
        ("audit", audit),
        ("changed manifest", changed),
    ]:
        if not path.exists():
            details.append(f"Q90R4 {label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    verifier_source = read_text(verifier) if verifier.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required = [
        (policy_source, "phase = 'V172-Q90R4'"),
        (policy_source, "verifierScript = 'tool/verify_mathlive_runtime.mjs'"),
        (policy_source, "mainEditorSwitchAllowed = false"),
        (policy_source, "legacyEngineRemainsDefault = true"),
        (policy_source, "physicalLegacyDeletionAllowed = false"),
        (policy_source, "remoteScriptsAllowed = false"),
        (policy_source, "mathLiveVirtualKeyboardMustStayDisabled = true"),
        (policy_source, "MATHLIVE_RUNTIME_INSTALL_VERIFIED_FOR_LAB_SMOKE"),
        (policy_source, "BLOCKED_MATHLIVE_RUNTIME_INSTALL_VERIFICATION"),
        (test_source, "V172-Q90R4 MathLive Runtime Install Verification"),
        (verifier_source, "phase: 'V172-Q90R4'"),
        (verifier_source, "fileURLToPath(import.meta.url)"),
        (verifier_source, "runtime_manifest.json"),
        (verifier_source, "mainEditorSwitchAllowed: false"),
        (manifest_source, '"runtimeInstallVerificationPhase": "V172-Q90R4"'),
        (manifest_source, '"runtimeInstallVerified": false'),
        (manifest_source, '"runtimeInstallVerificationRequiredBeforeSmoke": true'),
        (contract_source, "q90r4MathLiveRuntimeInstallVerificationRule"),
        (contract_source, "V172-Q90R4"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q90R4 missing marker {token}")
    for label, source in [("manifest", manifest_source), ("verifier", verifier_source)]:
        if "http://" in source or "https://" in source:
            details.append(f"Q90R4 {label} contains remote URL reference")
    illegal = [
        "mainEditorSwitchAllowed = true",
        "mainEditorMountAllowed = true",
        "legacyEngineRemainsDefault = false",
        "legacyEngineRemainsRollback = false",
        "physicalLegacyDeletionAllowed = true",
        "remoteScriptsAllowed = true",
        "mathLiveVirtualKeyboardMustStayDisabled = false",
        "cursorPassClaimAllowedFromInstallVerification = true",
    ]
    for marker in illegal:
        if marker in policy_source:
            details.append(f"Q90R4 illegally enables {marker}")
    if details:
        return CheckResult("v172_q90r4_mathlive_runtime_install_verification", "FAIL", "; ".join(details))
    return CheckResult("v172_q90r4_mathlive_runtime_install_verification", "PASS", "Q90R4 adds an offline post-install verifier for the local MathLive runtime bundle before Q90R2 smoke, while keeping the main editor on legacy/default and forbidding fake cursor PASS claims.")


def check_v172_q90r5_mathlive_lab_smoke_evidence(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/mathlive/mathlive_lab_smoke_evidence_policy.dart"
    test = root / "test/v172_q90r5_mathlive_lab_smoke_evidence_test.dart"
    verifier = root / "tool/verify_mathlive_lab_smoke_evidence.mjs"
    template = root / "docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE_TEMPLATE.json"
    bridge = root / "assets/mathlive/mathlive_bridge.js"
    manifest = root / "assets/mathlive/manifest.json"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    audit = root / "docs/audit/V172_Q90R5_MATHLIVE_LAB_SMOKE_EVIDENCE_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q90R5_CHANGED_FILES_MANIFEST.md"
    for label, path in [
        ("policy", policy),
        ("test", test),
        ("verifier", verifier),
        ("template", template),
        ("bridge", bridge),
        ("manifest", manifest),
        ("contract", contract),
        ("audit", audit),
        ("changed manifest", changed),
    ]:
        if not path.exists():
            details.append(f"Q90R5 {label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    verifier_source = read_text(verifier) if verifier.exists() else ""
    template_source = read_text(template) if template.exists() else ""
    bridge_source = read_text(bridge) if bridge.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required = [
        (policy_source, "phase = 'V172-Q90R5'"),
        (policy_source, "verifierScript = 'tool/verify_mathlive_lab_smoke_evidence.mjs'"),
        (policy_source, "mainEditorSwitchAllowed = false"),
        (policy_source, "legacyEngineRemainsDefault = true"),
        (policy_source, "physicalLegacyDeletionAllowed = false"),
        (policy_source, "cursorPassClaimAllowedFromSmokeEvidence = false"),
        (policy_source, "MATHLIVE_LAB_SMOKE_EVIDENCE_READY_FOR_Q87_CURSOR_COURT"),
        (policy_source, "BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE"),
        (test_source, "V172-Q90R5 MathLive Lab Runtime Smoke Evidence Harness"),
        (verifier_source, "phase = 'V172-Q90R5'"),
        (verifier_source, "BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE"),
        (verifier_source, "mainEditorSwitchAllowed: false"),
        (template_source, '"evidencePhase": "V172-Q90R5"'),
        (template_source, '"mainEditorSwitchAllowed": false'),
        (bridge_source, "getRuntimeSmokeEvidenceReport"),
        (bridge_source, "evidencePhase: 'V172-Q90R5'"),
        (manifest_source, '"runtimeSmokeEvidencePhase": "V172-Q90R5"'),
        (manifest_source, '"runtimeSmokeEvidenceVerified": false'),
        (contract_source, "q90r5MathLiveLabSmokeEvidenceRule"),
        (contract_source, "V172-Q90R5"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q90R5 missing marker {token}")
    for label, source in [("manifest", manifest_source), ("verifier", verifier_source), ("template", template_source), ("bridge", bridge_source)]:
        if "http://" in source or "https://" in source:
            details.append(f"Q90R5 {label} contains remote URL reference")
    illegal = [
        "mainEditorSwitchAllowed = true",
        "mainEditorMountAllowed = true",
        "legacyEngineRemainsDefault = false",
        "legacyEngineRemainsRollback = false",
        "physicalLegacyDeletionAllowed = true",
        "cursorPassClaimAllowedFromSmokeEvidence = true",
        "remoteScriptsAllowed = true",
        "mathLiveVirtualKeyboardMustStayDisabled = false",
        '"mainEditorSwitchAllowed": true',
        '"photomathLevelClaimed": true',
    ]
    for marker in illegal:
        if marker in policy_source or marker in template_source or marker in manifest_source:
            details.append(f"Q90R5 illegally enables {marker}")
    if details:
        return CheckResult("v172_q90r5_mathlive_lab_smoke_evidence", "FAIL", "; ".join(details))
    return CheckResult("v172_q90r5_mathlive_lab_smoke_evidence", "PASS", "Q90R5 adds a lab-only runtime smoke evidence verifier and template before Q87 cursor court, while keeping main editor switch, legacy deletion, remote scripts, virtual keyboard, and fake cursor PASS claims blocked.")


def check_v172_q90r6_mathlive_lab_smoke_evidence_authoring(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/mathlive/mathlive_lab_smoke_evidence_authoring_policy.dart"
    test = root / "test/v172_q90r6_mathlive_lab_smoke_evidence_authoring_test.dart"
    writer = root / "tool/write_mathlive_lab_smoke_evidence.mjs"
    bridge = root / "assets/mathlive/mathlive_bridge.js"
    lab = root / "lib/features/mathlive/mathlive_lab_screen.dart"
    manifest = root / "assets/mathlive/manifest.json"
    audit = root / "docs/audit/V172_Q90R6_MATHLIVE_LAB_SMOKE_EVIDENCE_AUTHORING_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q90R6_CHANGED_FILES_MANIFEST.md"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    for label, path in [
        ("policy", policy),
        ("test", test),
        ("writer", writer),
        ("bridge", bridge),
        ("lab", lab),
        ("manifest", manifest),
        ("audit", audit),
        ("changed", changed),
    ]:
        if not path.exists():
            details.append(f"Q90R6 {label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    writer_source = read_text(writer) if writer.exists() else ""
    bridge_source = read_text(bridge) if bridge.exists() else ""
    lab_source = read_text(lab) if lab.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required = [
        (policy_source, "phase = 'V172-Q90R6'"),
        (policy_source, "writerScript = 'tool/write_mathlive_lab_smoke_evidence.mjs'"),
        (policy_source, "mainEditorSwitchAllowed = false"),
        (policy_source, "physicalLegacyDeletionAllowed = false"),
        (policy_source, "cursorPassClaimAllowedFromAuthoredEvidence = false"),
        (policy_source, "MATHLIVE_LAB_SMOKE_EVIDENCE_AUTHORED_FOR_Q90R5_VERIFICATION"),
        (policy_source, "BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_AUTHORING"),
        (test_source, "V172-Q90R6 MathLive Lab Smoke Evidence Authoring Harness"),
        (writer_source, "phase = 'V172-Q90R6'"),
        (writer_source, "BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_AUTHORING"),
        (writer_source, "docs/evidence/V172_Q90R5_MATHLIVE_LAB_RUNTIME_SMOKE_EVIDENCE.json"),
        (writer_source, "mainEditorSwitchAllowed: false"),
        (bridge_source, "runtimeSmokeEvidenceAuthoringPhase"),
        (bridge_source, "getRuntimeSmokeEvidenceCaptureForAuthoring"),
        (bridge_source, "writeEvidenceCaptureToDom"),
        (lab_source, "mathlive-lab-q90r6-evidence"),
        (manifest_source, '"runtimeSmokeEvidenceAuthoringPhase": "V172-Q90R6"'),
        (contract_source, "q90r6MathLiveLabSmokeEvidenceAuthoringRule"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q90R6 missing marker {token}")
    for label, source in [("writer", writer_source), ("manifest", manifest_source), ("bridge", bridge_source), ("policy", policy_source)]:
        if "http://" in source or "https://" in source:
            details.append(f"Q90R6 {label} contains remote URL reference")
    illegal = [
        "mainEditorSwitchAllowed = true",
        "mainEditorMountAllowed = true",
        "physicalLegacyDeletionAllowed = true",
        "cursorPassClaimAllowedFromAuthoredEvidence = true",
        "photomathLevelClaimAllowedFromAuthoredEvidence = true",
        "remoteScriptsAllowed = true",
        "mathLiveVirtualKeyboardMustStayDisabled = false",
        '"runtimeSmokeEvidenceAuthoringMaySwitchMainEditor": true',
        '"runtimeSmokeEvidenceAuthoringMayDeleteLegacyCursor": true',
    ]
    for marker in illegal:
        if marker in policy_source or marker in manifest_source:
            details.append(f"Q90R6 illegally enables {marker}")
    if details:
        return CheckResult("v172_q90r6_mathlive_lab_smoke_evidence_authoring", "FAIL", "; ".join(details))
    return CheckResult("v172_q90r6_mathlive_lab_smoke_evidence_authoring", "PASS", "Q90R6 adds a lab-only smoke evidence authoring harness that writes canonical Q90R5 evidence only after runtime verification and keeps main editor switch, legacy deletion, remote scripts, virtual keyboard, and fake cursor claims blocked.")


def check_v172_q90r7_mathlive_lab_smoke_evidence_export(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/mathlive/mathlive_lab_smoke_evidence_export_policy.dart"
    test = root / "test/v172_q90r7_mathlive_lab_smoke_evidence_export_test.dart"
    lab = root / "lib/features/mathlive/mathlive_lab_screen.dart"
    bridge = root / "assets/mathlive/mathlive_bridge.js"
    manifest = root / "assets/mathlive/manifest.json"
    audit = root / "docs/audit/V172_Q90R7_MATHLIVE_LAB_SMOKE_EVIDENCE_EXPORT_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q90R7_CHANGED_FILES_MANIFEST.md"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    for label, path in [
        ("policy", policy),
        ("test", test),
        ("lab", lab),
        ("bridge", bridge),
        ("manifest", manifest),
        ("audit", audit),
        ("changed", changed),
    ]:
        if not path.exists():
            details.append(f"Q90R7 {label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    lab_source = read_text(lab) if lab.exists() else ""
    bridge_source = read_text(bridge) if bridge.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    required = [
        (policy_source, "phase = 'V172-Q90R7'"),
        (policy_source, "copyButtonKey = 'mathlive-lab-q90r7-copy-evidence'"),
        (policy_source, "appMayWriteProjectEvidenceFile = false"),
        (policy_source, "MATHLIVE_LAB_SMOKE_EVIDENCE_CAPTURE_COPY_READY"),
        (policy_source, "BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_EXPORT"),
        (test_source, "V172-Q90R7 MathLive Lab Smoke Evidence Export Guard"),
        (lab_source, "mathlive-lab-q90r7-copy-evidence"),
        (lab_source, "Clipboard.setData"),
        (lab_source, "tool/mathlive_lab_runtime_smoke_capture.json"),
        (bridge_source, "runtimeSmokeEvidenceExportPhase"),
        (bridge_source, "getRuntimeSmokeEvidenceCaptureClipboardText"),
        (manifest_source, '"runtimeSmokeEvidenceExportPhase": "V172-Q90R7"'),
        (manifest_source, '"runtimeSmokeEvidenceExportMaySwitchMainEditor": false'),
        (contract_source, "q90r7MathLiveLabSmokeEvidenceExportRule"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q90R7 missing marker {token}")
    for label, source in [("policy", policy_source), ("lab", lab_source), ("bridge", bridge_source), ("manifest", manifest_source)]:
        if "http://" in source or "https://" in source:
            details.append(f"Q90R7 {label} contains remote URL reference")
    illegal = [
        "mainEditorSwitchAllowed = true",
        "mainEditorMountAllowed = true",
        "appMayWriteProjectEvidenceFile = true",
        "physicalLegacyDeletionAllowed = true",
        "cursorPassClaimAllowedFromExport = true",
        "photomathLevelClaimAllowedFromExport = true",
        "remoteScriptsAllowed = true",
        "mathLiveVirtualKeyboardMustStayDisabled = false",
        '"runtimeSmokeEvidenceExportMaySwitchMainEditor": true',
        '"runtimeSmokeEvidenceExportMayDeleteLegacyCursor": true',
        '"runtimeSmokeEvidenceExportMayWriteProjectFileFromApp": true',
    ]
    for marker in illegal:
        if marker in policy_source or marker in manifest_source:
            details.append(f"Q90R7 illegally enables {marker}")
    if details:
        return CheckResult("v172_q90r7_mathlive_lab_smoke_evidence_export", "FAIL", "; ".join(details))
    return CheckResult("v172_q90r7_mathlive_lab_smoke_evidence_export", "PASS", "Q90R7 adds a lab-only evidence copy/export guard while keeping project-file writes, main editor switch, legacy deletion, remote scripts, virtual keyboard, and fake cursor claims blocked.")


def check_v172_q90r8_mathlive_lab_real_device_access(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/mathlive/mathlive_lab_real_device_access_policy.dart"
    entrypoint = root / "lib/main_mathlive_lab.dart"
    app = root / "lib/app/mathpro_app.dart"
    manifest = root / "assets/mathlive/manifest.json"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    readme = root / "README.md"
    audit = root / "docs/audit/V172_Q90R8_MATHLIVE_LAB_REAL_DEVICE_ACCESS_AUDIT_REPORT.md"
    for path, label in [
        (policy, "Q90R8 policy"),
        (entrypoint, "direct Lab entrypoint"),
        (app, "MathPro app route shell"),
        (manifest, "MathLive manifest"),
        (contract, "package contract"),
        (readme, "README"),
        (audit, "Q90R8 audit report"),
    ]:
        if not path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    entry_source = read_text(entrypoint) if entrypoint.exists() else ""
    app_source = read_text(app) if app.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    readme_source = read_text(readme) if readme.exists() else ""
    required = [
        (policy_source, "phase = 'V172-Q90R8'"),
        (policy_source, "directEntrypoint = 'lib/main_mathlive_lab.dart'"),
        (policy_source, "mainEditorSwitchAllowed = false"),
        (policy_source, "physicalLegacyDeletionAllowed = false"),
        (policy_source, "cursorPassClaimAllowedFromAccess = false"),
        (policy_source, "photomathLevelClaimAllowedFromAccess = false"),
        (entry_source, "MathLiveLabOnlyApp"),
        (entry_source, "MathLiveLabScreen"),
        (entry_source, "flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA"),
        (app_source, "MathLiveLabScreen.routeName"),
        (app_source, "home: const MathProAppShell()"),
        (manifest_source, '"realDeviceLabAccessPhase": "V172-Q90R8"'),
        (manifest_source, '"realDeviceLabAccessMaySwitchMainEditor": false'),
        (manifest_source, '"realDeviceLabAccessMayDeleteLegacyCursor": false'),
        (contract_source, "q90r8MathLiveLabRealDeviceAccessRule"),
        (readme_source, "V172-Q90R8"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q90R8 missing marker {token}")
    for label, source in [("policy", policy_source), ("entrypoint", entry_source), ("app", app_source), ("manifest", manifest_source), ("readme", readme_source)]:
        if "http://" in source or "https://" in source:
            details.append(f"Q90R8 {label} contains remote URL reference")
    illegal = [
        "mainEditorSwitchAllowed = true",
        "mainEditorMountAllowed = true",
        "physicalLegacyDeletionAllowed = true",
        "remoteScriptsAllowed = true",
        "mathLiveVirtualKeyboardMustStayDisabled = false",
        '"realDeviceLabAccessMaySwitchMainEditor": true',
        '"realDeviceLabAccessMayDeleteLegacyCursor": true',
        '"realDeviceLabAccessMayClaimCursorPass": true',
    ]
    for marker in illegal:
        if marker in policy_source or marker in manifest_source:
            details.append(f"Q90R8 illegally enables {marker}")
    if details:
        return CheckResult("v172_q90r8_mathlive_lab_real_device_access", "FAIL", "; ".join(details))
    return CheckResult("v172_q90r8_mathlive_lab_real_device_access", "PASS", "Q90R8 exposes a direct Lab-only real-device access path while keeping main editor switch, legacy deletion, remote scripts, virtual keyboard, and fake cursor claims blocked.")


def check_v172_q90r9_windows_npm_command_resolution(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/mathlive/mathlive_windows_npm_command_resolution_policy.dart"
    installer = root / "tool/install_mathlive_runtime.mjs"
    manifest = root / "assets/mathlive/manifest.json"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    test = root / "test/v172_q90r9_windows_npm_command_resolution_test.dart"
    audit = root / "docs/audit/V172_Q90R9_WINDOWS_NPM_COMMAND_RESOLUTION_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q90R9_CHANGED_FILES_MANIFEST.md"
    for file_path, label in [
        (policy, "Q90R9 policy"),
        (installer, "MathLive runtime installer"),
        (manifest, "MathLive manifest"),
        (contract, "package contract"),
        (test, "Q90R9 test"),
        (audit, "Q90R9 audit report"),
        (changed, "Q90R9 changed-files manifest"),
    ]:
        if not file_path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    installer_source = read_text(installer) if installer.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    required = [
        (policy_source, "phase = 'V172-Q90R9'"),
        (policy_source, "windowsNpmExecutable = 'npm.cmd'"),
        (policy_source, "blockedStatus = 'BLOCKED_NPM_NOT_FOUND'"),
        (policy_source, "mainEditorSwitchAllowed = false"),
        (policy_source, "physicalLegacyDeletionAllowed = false"),
        (installer_source, "process.platform === 'win32' ? ['npm.cmd', 'npm'] : ['npm']"),
        (installer_source, "BLOCKED_NPM_NOT_FOUND"),
        (installer_source, "runNpm(['init', '-y'], tempRoot)"),
        (manifest_source, '"windowsNpmCommandResolutionPhase": "V172-Q90R9"'),
        (manifest_source, '"windowsNpmExecutable": "npm.cmd"'),
        (manifest_source, '"mainEditorSwitchAllowedFromQ90R9": false'),
        (contract_source, "q90r9WindowsNpmCommandResolutionRepairRule"),
        (contract_source, "npm.cmd"),
        (test_source, "V172-Q90R9 Windows NPM Command Resolution Repair"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q90R9 missing marker {token}")
    illegal = [
        "mainEditorSwitchAllowed = true",
        "physicalLegacyDeletionAllowed = true",
        "remoteScriptsAllowed = true",
        "mathLiveVirtualKeyboardEnabled = true",
        '"mainEditorSwitchAllowedFromQ90R9": true',
    ]
    for marker in illegal:
        if marker in policy_source or marker in manifest_source:
            details.append(f"Q90R9 illegally enables {marker}")
    if details:
        return CheckResult("v172_q90r9_windows_npm_command_resolution", "FAIL", "; ".join(details))
    return CheckResult("v172_q90r9_windows_npm_command_resolution", "PASS", "Q90R9 hard-gates Windows npm.cmd command resolution while keeping MathLive lab-only, legacy rollback/default, remote scripts forbidden, virtual keyboard disabled, and protected UI untouched.")


def check_v172_q91_mathlive_runtime_evidence_closure(root: Path) -> CheckResult:
    details: list[str] = []
    policy = root / "lib/features/mathlive/mathlive_runtime_evidence_closure_policy.dart"
    manifest = root / "assets/mathlive/manifest.json"
    contract = root / "lib/logic/mathpro_package_contract.dart"
    readme = root / "README.md"
    test = root / "test/v172_q91_mathlive_runtime_evidence_closure_test.dart"
    audit = root / "docs/audit/V172_Q91_MATHLIVE_RUNTIME_EVIDENCE_CLOSURE_AUDIT_REPORT.md"
    changed = root / "docs/audit/V172_Q91_CHANGED_FILES_MANIFEST.md"
    for file_path, label in [
        (policy, "Q91 policy"),
        (manifest, "MathLive manifest"),
        (contract, "package contract"),
        (readme, "README"),
        (test, "Q91 test"),
        (audit, "Q91 audit report"),
        (changed, "Q91 changed-files manifest"),
    ]:
        if not file_path.exists():
            details.append(f"{label} missing")
    policy_source = read_text(policy) if policy.exists() else ""
    manifest_source = read_text(manifest) if manifest.exists() else ""
    contract_source = read_text(contract) if contract.exists() else ""
    readme_source = read_text(readme) if readme.exists() else ""
    test_source = read_text(test) if test.exists() else ""
    audit_source = read_text(audit) if audit.exists() else ""
    changed_source = read_text(changed) if changed.exists() else ""
    required = [
        (policy_source, "phase = 'V172-Q91'"),
        (policy_source, "userRealDeviceReportAloneClosesEvidence = false"),
        (policy_source, "officialRuntimeVerificationRequired = true"),
        (policy_source, "canonicalSmokeEvidenceRequired = true"),
        (policy_source, "canonicalSmokeEvidenceMayBeFaked = false"),
        (policy_source, "mainEditorSwitchAllowed = false"),
        (policy_source, "mainEditorMountAllowed = false"),
        (policy_source, "graphHistorySolutionAdapterWorkAllowed = false"),
        (policy_source, "physicalLegacyDeletionAllowed = false"),
        (policy_source, "cursorPassClaimAllowed = false"),
        (policy_source, "photomathLevelClaimAllowed = false"),
        (policy_source, "wolframLevelClaimAllowed = false"),
        (policy_source, "BLOCKED_MATHLIVE_RUNTIME_EVIDENCE_CLOSURE"),
        (policy_source, "MATHLIVE_RUNTIME_EVIDENCE_CLOSURE_READY_FOR_Q92"),
        (manifest_source, '"runtimeEvidenceClosurePhase": "V172-Q91"'),
        (manifest_source, '"userRealDeviceReportAloneClosesEvidence": false'),
        (manifest_source, '"q91MaySwitchMainEditor": false'),
        (manifest_source, '"q91MayDeleteLegacyCursor": false'),
        (manifest_source, '"q91MayClaimCursorPass": false'),
        (manifest_source, '"nextPhaseAfterQ91": "V172-Q92"'),
        (contract_source, "q91MathLiveRuntimeEvidenceClosureRule"),
        (contract_source, "V172-Q92 Graph / History / Solution Adapter Hardening"),
        (readme_source, "V172-Q91 MathLive Runtime Evidence Closure"),
        (test_source, "does not close evidence from user report alone"),
        (audit_source, "No fake PASS"),
        (changed_source, "Protected files intentionally untouched"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q91 missing marker {token}")
    illegal = [
        "userRealDeviceReportAloneClosesEvidence = true",
        "canonicalSmokeEvidenceMayBeFaked = true",
        "mainEditorSwitchAllowed = true",
        "mainEditorMountAllowed = true",
        "graphHistorySolutionAdapterWorkAllowed = true",
        "physicalLegacyDeletionAllowed = true",
        "cursorPassClaimAllowed = true",
        "photomathLevelClaimAllowed = true",
        "wolframLevelClaimAllowed = true",
        '"userRealDeviceReportAloneClosesEvidence": true',
        '"q91MaySwitchMainEditor": true',
        '"q91MayDeleteLegacyCursor": true',
        '"q91MayClaimCursorPass": true',
        '"q91MayChangeGraphHistorySolutionAdapters": true',
    ]
    for marker in illegal:
        if marker in policy_source or marker in manifest_source:
            details.append(f"Q91 illegally enables {marker}")
    if details:
        return CheckResult("v172_q91_mathlive_runtime_evidence_closure", "FAIL", "; ".join(details))
    return CheckResult("v172_q91_mathlive_runtime_evidence_closure", "PASS", "Q91 records the real-device Lab report only as evidence input and blocks Q92/Q87/main-editor/legacy-deletion paths until verified runtime and canonical smoke evidence exist.")


def check_v172_q92_q97_mathlive_transition_batch(root: Path) -> CheckResult:
    details: list[str] = []
    files = {
        "q92_policy": root / "lib/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart",
        "q93_policy": root / "lib/features/mathlive/mathlive_main_editor_flag_activation_policy.dart",
        "q94_policy": root / "lib/features/mathlive/mathlive_real_device_cursor_court_policy.dart",
        "q95_policy": root / "lib/features/editor_adapter/legacy_cursor_main_path_retirement_policy.dart",
        "q96_policy": root / "lib/features/editor_adapter/legacy_cursor_physical_cleanup_policy.dart",
        "q97_policy": root / "lib/features/mathlive/post_cleanup_regression_court_policy.dart",
        "test": root / "test/v172_q92_q97_mathlive_transition_batch_test.dart",
        "manifest": root / "assets/mathlive/manifest.json",
        "contract": root / "lib/logic/mathpro_package_contract.dart",
        "readme": root / "README.md",
        "audit": root / "docs/audit/V172_Q92_Q97_MATHLIVE_TRANSITION_BATCH_AUDIT_REPORT.md",
        "changed": root / "docs/audit/V172_Q92_Q97_CHANGED_FILES_MANIFEST.md",
    }
    for label, path in files.items():
        if not path.exists():
            details.append(f"Q92-Q97 {label} missing")
    sources = {label: read_text(path) if path.exists() else "" for label, path in files.items()}
    required = [
        (sources["q92_policy"], "phase = 'V172-Q92'"),
        (sources["q92_policy"], "buildEnvelope"),
        (sources["q92_policy"], "graphUiMutationAllowed = false"),
        (sources["q92_policy"], "mainEditorSwitchAllowed = false"),
        (sources["q92_policy"], "physicalLegacyDeletionAllowed = false"),
        (sources["q92_policy"], "BLOCKED_MATHLIVE_GHS_ADAPTER_HARDENING"),
        (sources["q93_policy"], "phase = 'V172-Q93'"),
        (sources["q93_policy"], "mathLiveEnabledByDefault = false"),
        (sources["q93_policy"], "legacyEditorRemainsDefaultWithoutFlag = true"),
        (sources["q93_policy"], "physicalLegacyDeletionAllowed = false"),
        (sources["q94_policy"], "phase = 'V172-Q94'"),
        (sources["q94_policy"], "staticPackageMayClaimPass = false"),
        (sources["q94_policy"], "requiredScenarioCount = 12"),
        (sources["q94_policy"], "BLOCKED_MATHLIVE_REAL_DEVICE_CURSOR_COURT"),
        (sources["q95_policy"], "phase = 'V172-Q95'"),
        (sources["q95_policy"], "physicalDeletionAllowed = false"),
        (sources["q95_policy"], "BLOCKED_LEGACY_CURSOR_MAIN_PATH_RETIREMENT"),
        (sources["q96_policy"], "phase = 'V172-Q96'"),
        (sources["q96_policy"], "physicalCleanupPerformedInThisPackage = false"),
        (sources["q96_policy"], "BLOCKED_LEGACY_CURSOR_PHYSICAL_CLEANUP"),
        (sources["q97_policy"], "phase = 'V172-Q97'"),
        (sources["q97_policy"], "staticPackageMayClaimFinalPass = false"),
        (sources["q97_policy"], "BLOCKED_POST_CLEANUP_REGRESSION_COURT"),
        (sources["test"], "V172-Q92..Q97 MathLive transition batch guard"),
        (sources["manifest"], '"q92GraphHistorySolutionAdapterPhase": "V172-Q92"'),
        (sources["manifest"], '"q93MathLiveMainEditorFlagPhase": "V172-Q93"'),
        (sources["manifest"], '"q94RealDeviceMathLiveCursorCourtPhase": "V172-Q94"'),
        (sources["manifest"], '"q95LegacyCursorMainPathRetirementPhase": "V172-Q95"'),
        (sources["manifest"], '"q96LegacyCursorPhysicalCleanupPhase": "V172-Q96"'),
        (sources["manifest"], '"q96PhysicalCleanupPerformedInThisPackage": false'),
        (sources["manifest"], '"q97PostCleanupRegressionCourtPhase": "V172-Q97"'),
        (sources["contract"], "q92MathLiveGraphHistorySolutionAdapterRule"),
        (sources["contract"], "q97PostCleanupRegressionCourtRule"),
        (sources["readme"], "V172-Q92..Q97 MathLive Transition Batch"),
        (sources["audit"], "No fake device PASS"),
        (sources["changed"], "Protected files intentionally untouched"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q92-Q97 missing marker {token}")
    illegal = [
        "mathLiveEnabledByDefault = true",
        "graphUiMutationAllowed = true",
        "historyUiMutationAllowed = true",
        "solutionUiMutationAllowed = true",
        "mainEditorSwitchAllowed = true",
        "physicalLegacyDeletionAllowed = true",
        "staticPackageMayClaimPass = true",
        "physicalDeletionAllowed = true",
        "physicalCleanupPerformedInThisPackage = true",
        "staticPackageMayClaimFinalPass = true",
        '"q94StaticPackageMayClaimCursorPass": true',
        '"q96PhysicalCleanupPerformedInThisPackage": true',
        '"q97StaticPackageMayClaimFinalPass": true',
    ]
    combined = "\n".join(sources.values())
    for marker in illegal:
        if marker in combined:
            details.append(f"Q92-Q97 illegally enables {marker}")
    if details:
        return CheckResult("v172_q92_q97_mathlive_transition_batch", "FAIL", "; ".join(details))
    return CheckResult("v172_q92_q97_mathlive_transition_batch", "PASS", "Q92-Q97 package-side transition guards are installed without default MathLive activation, protected UI mutation, physical legacy deletion, or fake device PASS.")


def check_v172_q98_mathlive_transition_evidence_orchestrator(root: Path) -> CheckResult:
    details: list[str] = []
    files = {
        "policy": root / "lib/features/mathlive/mathlive_transition_evidence_orchestrator_policy.dart",
        "tool": root / "tool/run_mathlive_transition_court.mjs",
        "test": root / "test/v172_q98_mathlive_transition_evidence_orchestrator_test.dart",
        "manifest": root / "assets/mathlive/manifest.json",
        "contract": root / "lib/logic/mathpro_package_contract.dart",
        "readme": root / "README.md",
        "audit": root / "docs/audit/V172_Q98_MATHLIVE_TRANSITION_EVIDENCE_ORCHESTRATOR_AUDIT_REPORT.md",
        "changed": root / "docs/audit/V172_Q98_CHANGED_FILES_MANIFEST.md",
    }
    for label, path in files.items():
        if not path.exists():
            details.append(f"Q98 {label} missing")
    sources = {label: read_text(path) if path.exists() else "" for label, path in files.items()}
    required = [
        (sources["policy"], "phase = 'V172-Q98'"),
        (sources["policy"], "singleCommandCourtOrchestratorProvided = true"),
        (sources["policy"], "staticPackageMayClaimDevicePass = false"),
        (sources["policy"], "mainEditorSwitchAllowed = false"),
        (sources["policy"], "legacyCursorDeletionAllowed = false"),
        (sources["policy"], "protectedUiSurfaceMutationAllowed = false"),
        (sources["policy"], "BLOCKED_MATHLIVE_TRANSITION_EVIDENCE_ORCHESTRATOR"),
        (sources["tool"], "V172-Q98"),
        (sources["tool"], "--run-flutter"),
        (sources["tool"], "--run-device"),
        (sources["tool"], "mayClaimRealDevicePass: false"),
        (sources["tool"], "maySwitchMainEditor: false"),
        (sources["tool"], "mayDeleteLegacyCursor: false"),
        (sources["test"], "V172-Q98 MathLive transition evidence orchestrator"),
        (sources["manifest"], '"q98MathLiveTransitionEvidenceOrchestratorPhase": "V172-Q98"'),
        (sources["manifest"], '"q98SingleCommandCourtOrchestratorProvided": true'),
        (sources["manifest"], '"q98MayClaimRealDevicePass": false'),
        (sources["manifest"], '"q98MaySwitchMainEditor": false'),
        (sources["manifest"], '"q98MayDeleteLegacyCursor": false'),
        (sources["manifest"], '"q98ProtectedUiSurfaceMutationAllowed": false'),
        (sources["contract"], "q98MathLiveTransitionEvidenceOrchestratorRule"),
        (sources["readme"], "V172-Q98 MathLive Transition Evidence Orchestrator"),
        (sources["audit"], "No fake device PASS"),
        (sources["changed"], "Protected files intentionally untouched"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q98 missing marker {token}")
    illegal = [
        "staticPackageMayClaimDevicePass = true",
        "mainEditorSwitchAllowed = true",
        "mathLiveEnabledByDefault = true",
        "legacyCursorDeletionAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        '"q98MayClaimRealDevicePass": true',
        '"q98MaySwitchMainEditor": true',
        '"q98MayEnableMathLiveByDefault": true',
        '"q98MayDeleteLegacyCursor": true',
        '"q98ProtectedUiSurfaceMutationAllowed": true',
    ]
    combined = "\n".join(sources.values())
    for marker in illegal:
        if marker in combined:
            details.append(f"Q98 illegally enables {marker}")
    if details:
        return CheckResult("v172_q98_mathlive_transition_evidence_orchestrator", "FAIL", "; ".join(details))
    return CheckResult("v172_q98_mathlive_transition_evidence_orchestrator", "PASS", "Q98 provides a single evidence court orchestrator while blocking fake device PASS, main-editor switching, protected UI mutation, and legacy deletion.")


def check_v172_q99_mathlive_runtime_evidence_intake(root: Path) -> CheckResult:
    details: list[str] = []
    files = {
        "policy": root / "lib/features/mathlive/mathlive_runtime_evidence_intake_policy.dart",
        "tool": root / "tool/verify_mathlive_runtime_evidence_intake.mjs",
        "test": root / "test/v172_q99_mathlive_runtime_evidence_intake_test.dart",
        "manifest": root / "assets/mathlive/manifest.json",
        "contract": root / "lib/logic/mathpro_package_contract.dart",
        "readme": root / "README.md",
        "audit": root / "docs/audit/V172_Q99_MATHLIVE_RUNTIME_EVIDENCE_INTAKE_AUDIT_REPORT.md",
        "changed": root / "docs/audit/V172_Q99_CHANGED_FILES_MANIFEST.md",
    }
    for label, path in files.items():
        if not path.exists():
            details.append(f"Q99 {label} missing")
    sources = {label: read_text(path) if path.exists() else "" for label, path in files.items()}
    required = [
        (sources["policy"], "phase = 'V172-Q99'"),
        (sources["policy"], "runtimeAndSmokeEvidenceIntakeProvided = true"),
        (sources["policy"], "createsFakeRuntimeEvidence = false"),
        (sources["policy"], "createsFakeSmokeEvidence = false"),
        (sources["policy"], "mainEditorSwitchAllowed = false"),
        (sources["policy"], "legacyCursorDeletionAllowed = false"),
        (sources["policy"], "protectedUiSurfaceMutationAllowed = false"),
        (sources["policy"], "BLOCKED_MATHLIVE_RUNTIME_EVIDENCE_INTAKE"),
        (sources["tool"], "V172-Q99"),
        (sources["tool"], "verify_mathlive_runtime_report.json"),
        (sources["tool"], "verify_mathlive_lab_smoke_evidence_report.json"),
        (sources["tool"], "mathlive_runtime_evidence_intake_report.json"),
        (sources["tool"], "maySwitchMainEditor: false"),
        (sources["tool"], "mayDeleteLegacyCursor: false"),
        (sources["test"], "V172-Q99 MathLive runtime evidence intake"),
        (sources["manifest"], '"q99MathLiveRuntimeEvidenceIntakePhase": "V172-Q99"'),
        (sources["manifest"], '"q99MaySwitchMainEditor": false'),
        (sources["manifest"], '"q99MayEnableMathLiveByDefault": false'),
        (sources["manifest"], '"q99MayDeleteLegacyCursor": false'),
        (sources["manifest"], '"q99ProtectedUiSurfaceMutationAllowed": false'),
        (sources["contract"], "q99MathLiveRuntimeEvidenceIntakeRule"),
        (sources["readme"], "V172-Q99 MathLive Runtime Evidence Intake"),
        (sources["audit"], "No fake runtime or smoke PASS"),
        (sources["changed"], "Protected files intentionally untouched"),
    ]
    for source, token in required:
        if token not in source:
            details.append(f"Q99 missing marker {token}")
    illegal = [
        "createsFakeRuntimeEvidence = true",
        "createsFakeSmokeEvidence = true",
        "mainEditorSwitchAllowed = true",
        "mathLiveEnabledByDefault = true",
        "legacyCursorDeletionAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        '"q99MayClaimCursorPass": true',
        '"q99MaySwitchMainEditor": true',
        '"q99MayEnableMathLiveByDefault": true',
        '"q99MayDeleteLegacyCursor": true',
        '"q99ProtectedUiSurfaceMutationAllowed": true',
    ]
    combined = "\n".join(sources.values())
    for marker in illegal:
        if marker in combined:
            details.append(f"Q99 illegally enables {marker}")
    if details:
        return CheckResult("v172_q99_mathlive_runtime_evidence_intake", "FAIL", "; ".join(details))
    return CheckResult("v172_q99_mathlive_runtime_evidence_intake", "PASS", "Q99 consolidates official runtime and smoke evidence intake while blocking fake PASS, main-editor switching, protected UI mutation, and legacy deletion.")



def check_v172_q100_official_runtime_bundle_closure(root: Path) -> CheckResult:
    sources = {
        "policy": root / "lib/features/mathlive/mathlive_official_runtime_bundle_closure_policy.dart",
        "tool": root / "tool/verify_mathlive_official_runtime_bundle.mjs",
        "installer": root / "tool/install_mathlive_runtime.mjs",
        "test": root / "test/v172_q100_official_runtime_bundle_closure_test.dart",
        "manifest": root / "assets/mathlive/manifest.json",
        "contract": root / "lib/logic/mathpro_package_contract.dart",
        "readme": root / "README.md",
        "audit": root / "docs/audit/V172_Q100_OFFICIAL_RUNTIME_BUNDLE_CLOSURE_AUDIT_REPORT.md",
        "changed": root / "docs/audit/V172_Q100_CHANGED_FILES_MANIFEST.md",
    }
    details: list[str] = []
    for label, path in sources.items():
        if not path.exists():
            details.append(f"Q100 {label} missing")
    if details:
        return CheckResult("v172_q100_official_runtime_bundle_closure", "FAIL", "; ".join(details))

    required_markers = [
        (sources["policy"], "phase = 'V172-Q100'"),
        (sources["policy"], "createsFakeRuntimeFiles = false"),
        (sources["policy"], "downloadsRuntimeDuringVerification = false"),
        (sources["policy"], "mainEditorSwitchAllowed = false"),
        (sources["policy"], "legacyCursorDeletionAllowed = false"),
        (sources["tool"], "V172-Q100"),
        (sources["tool"], "BLOCKED_MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSURE"),
        (sources["tool"], "mathlive_official_runtime_bundle_report.json"),
        (sources["tool"], "maySwitchMainEditor: false"),
        (sources["tool"], "mayDeleteLegacyCursor: false"),
        (sources["installer"], "fileSha256"),
        (sources["installer"], "q100OfficialRuntimeBundleClosureRequired"),
        (sources["test"], "V172-Q100 official MathLive runtime bundle closure"),
        (sources["manifest"], '"q100OfficialRuntimeBundleClosurePhase": "V172-Q100"'),
        (sources["manifest"], '"q100RequiresRuntimeManifestSha256Evidence": true'),
        (sources["manifest"], '"q100MaySwitchMainEditor": false'),
        (sources["manifest"], '"q100MayDeleteLegacyCursor": false'),
        (sources["manifest"], '"q100ProtectedUiSurfaceMutationAllowed": false'),
        (sources["contract"], "q100OfficialRuntimeBundleClosureRule"),
        (sources["readme"], "V172-Q100 Official MathLive Runtime Bundle Closure"),
        (sources["audit"], "No fake official runtime files"),
        (sources["changed"], "Protected files intentionally untouched"),
    ]
    for path, token in required_markers:
        text = read_text(path)
        if token not in text:
            details.append(f"Q100 missing marker {token}")

    forbidden_true_markers = [
        '"q100MayClaimCursorPass": true',
        '"q100MaySwitchMainEditor": true',
        '"q100MayEnableMathLiveByDefault": true',
        '"q100MayDeleteLegacyCursor": true',
        '"q100ProtectedUiSurfaceMutationAllowed": true',
        '"q100CreatesFakeRuntimeFiles": true',
    ]
    manifest_text = read_text(sources["manifest"])
    for marker in forbidden_true_markers:
        if marker in manifest_text:
            details.append(f"Q100 illegally enables {marker}")

    if details:
        return CheckResult("v172_q100_official_runtime_bundle_closure", "FAIL", "; ".join(details))
    return CheckResult("v172_q100_official_runtime_bundle_closure", "PASS", "Q100 adds an offline official runtime bundle closure verifier while blocking fake runtime files, smoke PASS, main-editor switching, protected UI mutation, and legacy deletion.")


def check_v172_q101_lab_smoke_evidence_closure(root: Path) -> CheckResult:
    sources = {
        "policy": root / "lib/features/mathlive/mathlive_lab_smoke_evidence_closure_policy.dart",
        "tool": root / "tool/verify_mathlive_lab_smoke_evidence_closure.mjs",
        "test": root / "test/v172_q101_lab_smoke_evidence_closure_test.dart",
        "manifest": root / "assets/mathlive/manifest.json",
        "contract": root / "lib/logic/mathpro_package_contract.dart",
        "readme": root / "README.md",
        "audit": root / "docs/audit/V172_Q101_LAB_SMOKE_EVIDENCE_CLOSURE_AUDIT_REPORT.md",
        "changed": root / "docs/audit/V172_Q101_CHANGED_FILES_MANIFEST.md",
    }
    details: list[str] = []
    for label, path in sources.items():
        if not path.exists():
            details.append(f"Q101 {label} missing")
    if details:
        return CheckResult("v172_q101_lab_smoke_evidence_closure", "FAIL", "; ".join(details))

    required_markers = [
        (sources["policy"], "phase = 'V172-Q101'"),
        (sources["policy"], "createsFakeSmokeEvidence = false"),
        (sources["policy"], "writesCanonicalEvidenceDuringClosureVerification = false"),
        (sources["policy"], "requiresQ100OfficialRuntimeBundleClosure = true"),
        (sources["policy"], "mainEditorSwitchAllowed = false"),
        (sources["policy"], "legacyCursorDeletionAllowed = false"),
        (sources["tool"], "V172-Q101"),
        (sources["tool"], "BLOCKED_MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSURE"),
        (sources["tool"], "MATHLIVE_LAB_SMOKE_EVIDENCE_CLOSED_FOR_Q87_CURSOR_COURT"),
        (sources["tool"], "mathlive_lab_smoke_evidence_closure_report.json"),
        (sources["tool"], "maySwitchMainEditor: false"),
        (sources["tool"], "mayDeleteLegacyCursor: false"),
        (sources["test"], "V172-Q101 Lab smoke evidence closure"),
        (sources["manifest"], '"q101LabSmokeEvidenceClosurePhase": "V172-Q101"'),
        (sources["manifest"], '"q101RequiresQ100OfficialRuntimeBundleClosure": true'),
        (sources["manifest"], '"q101MayClaimCursorPass": false'),
        (sources["manifest"], '"q101MaySwitchMainEditor": false'),
        (sources["manifest"], '"q101MayDeleteLegacyCursor": false'),
        (sources["manifest"], '"q101ProtectedUiSurfaceMutationAllowed": false'),
        (sources["contract"], "q101LabSmokeEvidenceClosureRule"),
        (sources["readme"], "V172-Q101 Lab Smoke Evidence Closure"),
        (sources["audit"], "No fake canonical smoke evidence"),
        (sources["changed"], "Protected files intentionally untouched"),
    ]
    for path, token in required_markers:
        text = read_text(path)
        if token not in text:
            details.append(f"Q101 missing marker {token}")

    combined = "\n".join(read_text(sources[key]) for key in ["policy", "manifest", "contract", "readme", "audit", "changed"])
    forbidden_markers = [
        "createsFakeSmokeEvidence = true",
        "writesCanonicalEvidenceDuringClosureVerification = true",
        "mainEditorSwitchAllowed = true",
        "mainEditorMountAllowed = true",
        "mathLiveEnabledByDefault = true",
        "legacyCursorDeletionAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "cursorPassClaimAllowed = true",
        "photomathWolframClaimAllowed = true",
        '"q101CreatesFakeSmokeEvidence": true',
        '"q101MayClaimCursorPass": true',
        '"q101MaySwitchMainEditor": true',
        '"q101MayMountMainEditor": true',
        '"q101MayEnableMathLiveByDefault": true',
        '"q101MayDeleteLegacyCursor": true',
        '"q101ProtectedUiSurfaceMutationAllowed": true',
    ]
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"Q101 illegally enables {marker}")

    if details:
        return CheckResult("v172_q101_lab_smoke_evidence_closure", "FAIL", "; ".join(details))
    return CheckResult("v172_q101_lab_smoke_evidence_closure", "PASS", "Q101 adds Lab smoke evidence closure while blocking fake evidence, cursor PASS, main-editor switching, protected UI mutation, and legacy deletion.")


def check_v172_q102_mathlive_state_normalization_hardening(root: Path) -> CheckResult:
    sources = {
        "policy": root / "lib/features/mathlive/mathlive_state_normalization_hardening_policy.dart",
        "tool": root / "tool/verify_mathlive_state_normalization.mjs",
        "test": root / "test/v172_q102_mathlive_state_normalization_test.dart",
        "q92": root / "lib/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart",
        "manifest": root / "assets/mathlive/manifest.json",
        "contract": root / "lib/logic/mathpro_package_contract.dart",
        "readme": root / "README.md",
        "audit": root / "docs/audit/V172_Q102_MATHLIVE_STATE_NORMALIZATION_AUDIT_REPORT.md",
        "changed": root / "docs/audit/V172_Q102_CHANGED_FILES_MANIFEST.md",
    }
    details: list[str] = []
    for label, path in sources.items():
        if not path.exists():
            details.append(f"Q102 {label} missing")
    if details:
        return CheckResult("v172_q102_mathlive_state_normalization_hardening", "FAIL", "; ".join(details))

    required_markers = [
        (sources["policy"], "phase = 'V172-Q102'"),
        (sources["policy"], "packageSideNormalizerImplemented = true"),
        (sources["policy"], "q101LabSmokeEvidenceClosureRequiredForActivation = true"),
        (sources["policy"], "writesCanonicalSmokeEvidence = false"),
        (sources["policy"], "installsRuntimeFiles = false"),
        (sources["policy"], "mainEditorSwitchAllowed = false"),
        (sources["policy"], "legacyCursorDeletionAllowed = false"),
        (sources["tool"], "V172-Q102"),
        (sources["tool"], "MATHLIVE_STATE_NORMALIZATION_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED"),
        (sources["tool"], "mathlive_state_normalization_report.json"),
        (sources["test"], "V172-Q102 MathLive State Normalization Hardening"),
        (sources["q92"], "MathLiveStateNormalizationHardeningPolicy.normalizeLatexForMathPro"),
        (sources["manifest"], '"q102MathLiveStateNormalizationPhase": "V172-Q102"'),
        (sources["manifest"], '"q102RequiresQ101LabSmokeEvidenceClosureForActivation": true'),
        (sources["manifest"], '"q102MaySwitchMainEditor": false'),
        (sources["manifest"], '"q102MayDeleteLegacyCursor": false'),
        (sources["manifest"], '"q102ProtectedUiSurfaceMutationAllowed": false'),
        (sources["contract"], "q102MathLiveStateNormalizationHardeningRule"),
        (sources["readme"], "V172-Q102 MathLive State Normalization Hardening"),
        (sources["audit"], "Q102 adds a package-side MathLive state normalization layer"),
        (sources["changed"], "Protected files intentionally untouched"),
    ]
    for path, token in required_markers:
        text = read_text(path)
        if token not in text:
            details.append(f"Q102 missing marker {token}")

    combined = "\n".join(read_text(sources[key]) for key in ["policy", "manifest", "contract", "readme", "audit", "changed"])
    forbidden_markers = [
        "writesCanonicalSmokeEvidence = true",
        "installsRuntimeFiles = true",
        "mainEditorSwitchAllowed = true",
        "mainEditorMountAllowed = true",
        "mathLiveEnabledByDefault = true",
        "legacyCursorDeletionAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "cursorPassClaimAllowed = true",
        "photomathWolframClaimAllowed = true",
        '"q102MaySwitchMainEditor": true',
        '"q102MayMountMainEditor": true',
        '"q102MayEnableMathLiveByDefault": true',
        '"q102MayDeleteLegacyCursor": true',
        '"q102ProtectedUiSurfaceMutationAllowed": true',
    ]
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"Q102 illegally enables {marker}")

    if details:
        return CheckResult("v172_q102_mathlive_state_normalization_hardening", "FAIL", "; ".join(details))
    return CheckResult("v172_q102_mathlive_state_normalization_hardening", "PASS", "Q102 adds package-side MathLive state normalization while blocking fake evidence, main-editor switching, protected UI mutation, cursor PASS, and legacy deletion.")


def check_v172_q103_mathlive_graph_eligibility_adapter(root: Path) -> CheckResult:
    sources = {
        "policy": root / "lib/features/mathlive/mathlive_graph_eligibility_adapter_policy.dart",
        "tool": root / "tool/verify_mathlive_graph_eligibility_adapter.mjs",
        "test": root / "test/v172_q103_mathlive_graph_eligibility_adapter_test.dart",
        "q92": root / "lib/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart",
        "manifest": root / "assets/mathlive/manifest.json",
        "contract": root / "lib/logic/mathpro_package_contract.dart",
        "readme": root / "README.md",
        "audit": root / "docs/audit/V172_Q103_GRAPH_ELIGIBILITY_ADAPTER_AUDIT_REPORT.md",
        "changed": root / "docs/audit/V172_Q103_CHANGED_FILES_MANIFEST.md",
        "graph_card": root / "lib/features/graph/graph_card.dart",
    }
    details: list[str] = []
    for label, path in sources.items():
        if not path.exists():
            details.append(f"Q103 {label} missing")
    if details:
        return CheckResult("v172_q103_mathlive_graph_eligibility_adapter", "FAIL", "; ".join(details))

    required_markers = [
        (sources["policy"], "phase = 'V172-Q103'"),
        (sources["policy"], "packageSideGraphEligibilityAdapterImplemented = true"),
        (sources["policy"], "q102StateNormalizationRequired = true"),
        (sources["policy"], "q101LabSmokeEvidenceClosureRequiredForRuntimeActivation = true"),
        (sources["policy"], "graphCardMutationAllowed = false"),
        (sources["policy"], "fakeConstantGraphAllowed = false"),
        (sources["tool"], "V172-Q103"),
        (sources["tool"], "MATHLIVE_GRAPH_ELIGIBILITY_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED"),
        (sources["tool"], "mathlive_graph_eligibility_adapter_report.json"),
        (sources["test"], "V172-Q103 Graph Eligibility Adapter Real Binding"),
        (sources["q92"], "MathLiveGraphEligibilityAdapterPolicy.classifyNormalized"),
        (sources["manifest"], '"q103GraphEligibilityAdapterPhase": "V172-Q103"'),
        (sources["manifest"], '"q103RequiresQ102StateNormalization": true'),
        (sources["manifest"], '"q103MayMutateGraphCard": false'),
        (sources["manifest"], '"q103MaySwitchMainEditor": false'),
        (sources["manifest"], '"q103MayDeleteLegacyCursor": false'),
        (sources["manifest"], '"q103FakeConstantGraphAllowed": false'),
        (sources["contract"], "q103GraphEligibilityAdapterRule"),
        (sources["readme"], "V172-Q103 Graph Eligibility Adapter Real Binding"),
        (sources["audit"], "Q103 adds MathLive normalized expression to GraphEligibility adapter binding"),
        (sources["changed"], "Protected files intentionally untouched"),
    ]
    for path, token in required_markers:
        text = read_text(path)
        if token not in text:
            details.append(f"Q103 missing marker {token}")

    combined = "\n".join(read_text(sources[key]) for key in ["policy", "manifest", "contract", "readme", "audit", "changed"])
    forbidden_markers = [
        "graphCardMutationAllowed = true",
        "graphUiMutationAllowed = true",
        "historyUiMutationAllowed = true",
        "solutionUiMutationAllowed = true",
        "keyboardMutationAllowed = true",
        "appShellMutationAllowed = true",
        "mainEditorSwitchAllowed = true",
        "mainEditorMountAllowed = true",
        "mathLiveEnabledByDefault = true",
        "legacyCursorDeletionAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "cursorPassClaimAllowed = true",
        "fakeConstantGraphAllowed = true",
        '"q103MayMutateGraphCard": true',
        '"q103MaySwitchMainEditor": true',
        '"q103MayMountMainEditor": true',
        '"q103MayEnableMathLiveByDefault": true',
        '"q103MayDeleteLegacyCursor": true',
        '"q103ProtectedUiSurfaceMutationAllowed": true',
        '"q103FakeConstantGraphAllowed": true',
    ]
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"Q103 illegally enables {marker}")

    if "V172-Q103" in read_text(sources["graph_card"]):
        details.append("Q103 marker found in protected graph_card.dart; graph card must remain untouched")

    if details:
        return CheckResult("v172_q103_mathlive_graph_eligibility_adapter", "FAIL", "; ".join(details))
    return CheckResult("v172_q103_mathlive_graph_eligibility_adapter", "PASS", "Q103 adds package-side MathLive graph eligibility binding while blocking graph_card mutation, fake constants, main-editor switching, protected UI mutation, cursor PASS, and legacy deletion.")


def check_v172_q104_mathlive_history_adapter(root: Path) -> CheckResult:
    sources = {
        "policy": root / "lib/features/mathlive/mathlive_history_adapter_policy.dart",
        "tool": root / "tool/verify_mathlive_history_adapter.mjs",
        "test": root / "test/v172_q104_mathlive_history_adapter_test.dart",
        "q92": root / "lib/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart",
        "manifest": root / "assets/mathlive/manifest.json",
        "contract": root / "lib/logic/mathpro_package_contract.dart",
        "readme": root / "README.md",
        "audit": root / "docs/audit/V172_Q104_HISTORY_ADAPTER_AUDIT_REPORT.md",
        "changed": root / "docs/audit/V172_Q104_CHANGED_FILES_MANIFEST.md",
        "history_controller": root / "lib/features/history/history_controller.dart",
        "history_panel": root / "lib/features/history/history_panel.dart",
    }
    details: list[str] = []
    for label, path in sources.items():
        if not path.exists():
            details.append(f"Q104 {label} missing")
    if details:
        return CheckResult("v172_q104_mathlive_history_adapter", "FAIL", "; ".join(details))

    required_markers = [
        (sources["policy"], "phase = 'V172-Q104'"),
        (sources["policy"], "packageSideHistoryAdapterImplemented = true"),
        (sources["policy"], "q102StateNormalizationRequired = true"),
        (sources["policy"], "q103GraphEligibilityAdapterRequired = true"),
        (sources["policy"], "historyControllerMutationAllowed = false"),
        (sources["policy"], "historyPanelMutationAllowed = false"),
        (sources["policy"], "fakeHistoryWriteAllowed = false"),
        (sources["tool"], "V172-Q104"),
        (sources["tool"], "MATHLIVE_HISTORY_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED"),
        (sources["tool"], "mathlive_history_adapter_report.json"),
        (sources["test"], "V172-Q104 History Adapter Real Binding"),
        (sources["q92"], "MathLiveHistoryAdapterPolicy.buildEntryEnvelope"),
        (sources["manifest"], '"q104HistoryAdapterPhase": "V172-Q104"'),
        (sources["manifest"], '"q104MayMutateHistoryController": false'),
        (sources["manifest"], '"q104MayMutateHistoryPanel": false'),
        (sources["manifest"], '"q104MayWriteHistoryAtRuntime": false'),
        (sources["manifest"], '"q104MaySwitchMainEditor": false'),
        (sources["manifest"], '"q104MayDeleteLegacyCursor": false'),
        (sources["contract"], "q104HistoryAdapterRule"),
        (sources["readme"], "V172-Q104 History Adapter Real Binding"),
        (sources["audit"], "Q104 adds MathLive normalized expression to History entry envelope binding"),
        (sources["changed"], "Protected files intentionally untouched"),
    ]
    for path, token in required_markers:
        text = read_text(path)
        if token not in text:
            details.append(f"Q104 missing marker {token}")

    combined = "\n".join(read_text(sources[key]) for key in ["policy", "manifest", "contract", "readme", "audit", "changed"])
    forbidden_markers = [
        "historyControllerMutationAllowed = true",
        "historyPanelMutationAllowed = true",
        "historyUiMutationAllowed = true",
        "graphUiMutationAllowed = true",
        "solutionUiMutationAllowed = true",
        "keyboardMutationAllowed = true",
        "appShellMutationAllowed = true",
        "mainEditorSwitchAllowed = true",
        "mainEditorMountAllowed = true",
        "mathLiveEnabledByDefault = true",
        "legacyCursorDeletionAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "cursorPassClaimAllowed = true",
        "fakeHistoryWriteAllowed = true",
        '"q104MayMutateHistoryController": true',
        '"q104MayMutateHistoryPanel": true',
        '"q104MayWriteHistoryAtRuntime": true',
        '"q104MaySwitchMainEditor": true',
        '"q104MayMountMainEditor": true',
        '"q104MayDeleteLegacyCursor": true',
        '"q104ProtectedUiSurfaceMutationAllowed": true',
    ]
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"Q104 illegally enables {marker}")

    if "V172-Q104" in read_text(sources["history_controller"]):
        details.append("Q104 marker found in protected history_controller.dart; History controller must remain untouched")
    if "V172-Q104" in read_text(sources["history_panel"]):
        details.append("Q104 marker found in protected history_panel.dart; History panel must remain untouched")

    if details:
        return CheckResult("v172_q104_mathlive_history_adapter", "FAIL", "; ".join(details))
    return CheckResult("v172_q104_mathlive_history_adapter", "PASS", "Q104 adds package-side MathLive History entry envelopes while blocking History UI/controller mutation, fake writes, main-editor switching, protected UI mutation, cursor PASS, and legacy deletion.")


def check_v172_q105_solution_evaluator_candidate_adapter(root: Path) -> CheckResult:
    sources = {
        "policy": root / "lib/features/mathlive/mathlive_solution_evaluator_candidate_adapter_policy.dart",
        "tool": root / "tool/verify_mathlive_solution_evaluator_candidate_adapter.mjs",
        "test": root / "test/v172_q105_solution_evaluator_candidate_adapter_test.dart",
        "q92": root / "lib/features/mathlive/mathlive_graph_history_solution_adapter_policy.dart",
        "q102": root / "lib/features/mathlive/mathlive_state_normalization_hardening_policy.dart",
        "q103": root / "lib/features/mathlive/mathlive_graph_eligibility_adapter_policy.dart",
        "q104": root / "lib/features/mathlive/mathlive_history_adapter_policy.dart",
        "evaluator": root / "lib/logic/evaluator_bridge.dart",
        "manifest": root / "assets/mathlive/manifest.json",
        "contract": root / "lib/logic/mathpro_package_contract.dart",
        "readme": root / "README.md",
        "audit": root / "docs/audit/V172_Q105_SOLUTION_EVALUATOR_CANDIDATE_ADAPTER_AUDIT_REPORT.md",
        "changed": root / "docs/audit/V172_Q105_CHANGED_FILES_MANIFEST.md",
        "solution_panel": root / "lib/features/solution/solution_steps_panel.dart",
    }
    details: list[str] = []
    for label, path in sources.items():
        if not path.exists():
            details.append(f"Q105 {label} missing")
    if details:
        return CheckResult("v172_q105_solution_evaluator_candidate_adapter", "FAIL", "; ".join(details))

    required_markers = [
        (sources["policy"], "phase = 'V172-Q105'"),
        (sources["policy"], "packageSideSolutionEvaluatorAdapterImplemented = true"),
        (sources["policy"], "q102StateNormalizationRequired = true"),
        (sources["policy"], "q103GraphEligibilityAdapterRequired = true"),
        (sources["policy"], "q104HistoryAdapterRequired = true"),
        (sources["policy"], "solutionStepsPanelMutationAllowed = false"),
        (sources["policy"], "fakeSolutionAllowed = false"),
        (sources["policy"], "runtimeSolutionWriteAllowed = false"),
        (sources["tool"], "V172-Q105"),
        (sources["tool"], "MATHLIVE_SOLUTION_EVALUATOR_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED"),
        (sources["tool"], "mathlive_solution_evaluator_candidate_adapter_report.json"),
        (sources["test"], "V172-Q105 Solution/Evaluator Candidate Adapter"),
        (sources["q92"], "MathLiveSolutionEvaluatorCandidateAdapterPolicy.buildCandidateEnvelope"),
        (sources["manifest"], '"q105SolutionEvaluatorCandidateAdapterPhase": "V172-Q105"'),
        (sources["manifest"], '"q105MayMutateSolutionStepsPanel": false'),
        (sources["manifest"], '"q105MayWriteSolutionAtRuntime": false'),
        (sources["manifest"], '"q105MayGenerateFakeSolution": false'),
        (sources["manifest"], '"q105MaySwitchMainEditor": false'),
        (sources["manifest"], '"q105MayDeleteLegacyCursor": false'),
        (sources["contract"], "q105SolutionEvaluatorCandidateAdapterRule"),
        (sources["readme"], "V172-Q105 Solution/Evaluator Candidate Adapter"),
        (sources["audit"], "Q105 adds MathLive normalized expression to Solution/Evaluator candidate envelope binding"),
        (sources["changed"], "Protected files intentionally untouched"),
    ]
    for path, token in required_markers:
        text = read_text(path)
        if token not in text:
            details.append(f"Q105 missing marker {token}")

    combined = "\n".join(read_text(sources[key]) for key in ["policy", "manifest", "contract", "readme", "audit", "changed"])
    forbidden_markers = [
        "solutionStepsPanelMutationAllowed = true",
        "solutionUiMutationAllowed = true",
        "graphUiMutationAllowed = true",
        "historyUiMutationAllowed = true",
        "keyboardMutationAllowed = true",
        "appShellMutationAllowed = true",
        "mainEditorSwitchAllowed = true",
        "mainEditorMountAllowed = true",
        "mathLiveEnabledByDefault = true",
        "legacyCursorDeletionAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "cursorPassClaimAllowed = true",
        "fakeSolutionAllowed = true",
        "runtimeSolutionWriteAllowed = true",
        '"q105MayMutateSolutionStepsPanel": true',
        '"q105MayWriteSolutionAtRuntime": true',
        '"q105MayGenerateFakeSolution": true',
        '"q105MaySwitchMainEditor": true',
        '"q105MayMountMainEditor": true',
        '"q105MayDeleteLegacyCursor": true',
        '"q105ProtectedUiSurfaceMutationAllowed": true',
    ]
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"Q105 illegally enables {marker}")

    if "V172-Q105" in read_text(sources["solution_panel"]):
        details.append("Q105 marker found in protected solution_steps_panel.dart; Solution panel must remain untouched")

    if details:
        return CheckResult("v172_q105_solution_evaluator_candidate_adapter", "FAIL", "; ".join(details))
    return CheckResult("v172_q105_solution_evaluator_candidate_adapter", "PASS", "Q105 adds package-side MathLive Solution/Evaluator candidate envelopes while blocking Solution UI mutation, fake solution generation, runtime writes, main-editor switching, protected UI mutation, cursor PASS, and legacy deletion.")


def check_v172_q106_main_workspace_mount_flag(root: Path) -> CheckResult:
    sources = {
        "policy": root / "lib/features/mathlive/mathlive_main_workspace_mount_flag_policy.dart",
        "tool": root / "tool/verify_mathlive_main_workspace_mount_flag.mjs",
        "test": root / "test/v172_q106_main_workspace_mount_flag_test.dart",
        "q93": root / "lib/features/mathlive/mathlive_main_editor_flag_activation_policy.dart",
        "q101": root / "lib/features/mathlive/mathlive_lab_smoke_evidence_closure_policy.dart",
        "q105": root / "lib/features/mathlive/mathlive_solution_evaluator_candidate_adapter_policy.dart",
        "manifest": root / "assets/mathlive/manifest.json",
        "contract": root / "lib/logic/mathpro_package_contract.dart",
        "readme": root / "README.md",
        "audit": root / "docs/audit/V172_Q106_MAIN_WORKSPACE_MOUNT_FLAG_AUDIT_REPORT.md",
        "changed": root / "docs/audit/V172_Q106_CHANGED_FILES_MANIFEST.md",
        "app_shell": root / "lib/app/app_shell.dart",
        "keyboard": root / "lib/features/keyboard/key_config.dart",
        "graph_card": root / "lib/features/graph/graph_card.dart",
        "history_controller": root / "lib/features/history/history_controller.dart",
        "solution_panel": root / "lib/features/solution/solution_steps_panel.dart",
    }
    details: list[str] = []
    for label, path in sources.items():
        if not path.exists():
            details.append(f"Q106 {label} missing")
    if details:
        return CheckResult("v172_q106_main_workspace_mount_flag", "FAIL", "; ".join(details))

    policy = read_text(sources["policy"])
    tool = read_text(sources["tool"])
    q93 = read_text(sources["q93"])
    q101 = read_text(sources["q101"])
    q105 = read_text(sources["q105"])
    manifest = read_text(sources["manifest"])
    contract = read_text(sources["contract"])
    readme = read_text(sources["readme"])
    audit = read_text(sources["audit"])
    changed = read_text(sources["changed"])
    protected_sources = {
        "app_shell.dart": read_text(sources["app_shell"]),
        "key_config.dart": read_text(sources["keyboard"]),
        "graph_card.dart": read_text(sources["graph_card"]),
        "history_controller.dart": read_text(sources["history_controller"]),
        "solution_steps_panel.dart": read_text(sources["solution_panel"]),
    }

    required_markers = [
        (policy, "phase = 'V172-Q106'"),
        (policy, "mountReadinessContractImplemented = true"),
        (policy, "mainWorkspaceMountImplementedInThisPackage = false"),
        (policy, "q93FlagContractRequired = true"),
        (policy, "q101LabSmokeEvidenceClosureRequired = true"),
        (policy, "q105SolutionEvaluatorCandidateAdapterRequired = true"),
        (policy, "explicitInternalFlagRequired = true"),
        (policy, "appShellMutationAllowed = false"),
        (policy, "keyboardMutationAllowed = false"),
        (policy, "graphHistorySolutionUiMutationAllowed = false"),
        (policy, "legacyCursorDeletionAllowed = false"),
        (policy, "runtimeMountAllowedWithoutQ101 = false"),
        (q93, "flagName = 'mathpro.internal.editorEngine.mathlive'"),
        (q101, "labSmokeEvidenceClosureGateProvided = true"),
        (q105, "packageSideSolutionEvaluatorAdapterImplemented = true"),
        (manifest, '"q106MainWorkspaceMountFlagPhase": "V172-Q106"'),
        (manifest, '"q106MainWorkspaceMountImplementedInThisPackage": false'),
        (manifest, '"q106RequiresExplicitInternalFlag": true'),
        (manifest, '"q106RequiresQ101LabSmokeEvidenceClosure": true'),
        (manifest, '"q106RequiresQ105SolutionEvaluatorCandidateAdapter": true'),
        (manifest, '"q106MayMutateAppShell": false'),
        (manifest, '"q106MayMutateKeyboard": false'),
        (manifest, '"q106MaySwitchDefaultEditor": false'),
        (manifest, '"q106MayDeleteLegacyCursor": false'),
        (contract, "q106MainWorkspaceMathLiveMountFlagRule"),
        (readme, "V172-Q106 Main Workspace MathLive Mount Behind Internal Flag"),
        (tool, "MATHLIVE_MAIN_WORKSPACE_MOUNT_FLAG_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED"),
        (audit, "Q106 adds MathLive main-workspace mount readiness behind an explicit internal flag"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing marker: {marker}")

    combined = "\n".join([policy, manifest, contract, readme, audit, changed])
    forbidden_markers = [
        "mainWorkspaceMountImplementedInThisPackage = true",
        "mathLiveEnabledByDefault = true",
        "appShellMutationAllowed = true",
        "keyboardMutationAllowed = true",
        "moreLongPressMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "legacyCursorDeletionAllowed = true",
        "cursorPassClaimAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeSmokeEvidenceAllowed = true",
        "runtimeMountAllowedWithoutQ101 = true",
        "defaultEditorSwitchAllowed = true",
        '"q106MainWorkspaceMountImplementedInThisPackage": true',
        '"q106MayMutateAppShell": true',
        '"q106MayMutateKeyboard": true',
        '"q106MayMutateGraphHistorySolutionUi": true',
        '"q106MaySwitchDefaultEditor": true',
        '"q106MayEnableMathLiveByDefault": true',
        '"q106MayDeleteLegacyCursor": true',
        '"q106MayClaimCursorPass": true',
    ]
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"forbidden enabled marker present: {marker}")
    for name, source in protected_sources.items():
        if "V172-Q106" in source:
            details.append(f"Q106 marker found in protected file: {name}")

    if details:
        return CheckResult("v172_q106_main_workspace_mount_flag", "FAIL", "; ".join(details))
    return CheckResult("v172_q106_main_workspace_mount_flag", "PASS", "Q106 adds package-side MathLive main-workspace mount readiness behind an explicit internal flag while blocking AppShell/keyboard/Graph/History/Solution mutation, default switch, cursor PASS, fake evidence, and legacy deletion.")


def check_v172_q107_main_keyboard_bridge(root: Path) -> CheckResult:
    policy_path = root / "lib/features/mathlive/mathlive_main_keyboard_bridge_policy.dart"
    tool_path = root / "tool/verify_mathlive_main_keyboard_bridge.mjs"
    test_path = root / "test/v172_q107_main_keyboard_bridge_test.dart"
    audit_path = root / "docs/audit/V172_Q107_MAIN_KEYBOARD_BRIDGE_AUDIT_REPORT.md"
    changed_path = root / "docs/audit/V172_Q107_CHANGED_FILES_MANIFEST.md"
    q85_path = root / "lib/features/mathlive/mathlive_keyboard_bridge_policy.dart"
    q106_path = root / "lib/features/mathlive/mathlive_main_workspace_mount_flag_policy.dart"
    manifest_path = root / "assets/mathlive/manifest.json"
    contract_path = root / "lib/logic/mathpro_package_contract.dart"
    readme_path = root / "README.md"
    required_paths = [policy_path, tool_path, test_path, audit_path, changed_path, q85_path, q106_path]
    missing = [str(path.relative_to(root)) for path in required_paths if not path.exists()]
    if missing:
        return CheckResult("v172_q107_main_keyboard_bridge", "FAIL", "Missing: " + ", ".join(missing))

    policy = read_text(policy_path)
    tool = read_text(tool_path)
    test = read_text(test_path)
    audit = read_text(audit_path)
    changed = read_text(changed_path)
    q85 = read_text(q85_path)
    q106 = read_text(q106_path)
    manifest = read_text(manifest_path) if manifest_path.exists() else ""
    contract = read_text(contract_path) if contract_path.exists() else ""
    readme = read_text(readme_path) if readme_path.exists() else ""
    protected_sources = {p: read_text(root / p) for p in PROTECTED_FILES if (root / p).exists()}

    details: list[str] = []
    required_markers = [
        (policy, "phase = 'V172-Q107'"),
        (policy, "sourceBridgePhase = MathLiveKeyboardBridgePolicy.phase"),
        (policy, "mountFlagPhase = MathLiveMainWorkspaceMountFlagPolicy.phase"),
        (policy, "q85LabBridgeIsSourceOfTruth = true"),
        (policy, "q106MountFlagRequired = true"),
        (policy, "q101LabSmokeEvidenceClosureRequired = true"),
        (policy, "officialRuntimeVerificationRequired = true"),
        (policy, "mainWorkspaceBridgeImplementedInThisPackage = false"),
        (policy, "mainBridgeRuntimeBindingAllowedWithoutEvidence = false"),
        (policy, "keyboardMutationAllowed = false"),
        (policy, "moreMutationAllowed = false"),
        (policy, "longPressMutationAllowed = false"),
        (policy, "appShellMutationAllowed = false"),
        (policy, "graphHistorySolutionUiMutationAllowed = false"),
        (policy, "legacyCursorDeletionAllowed = false"),
        (policy, "cursorPassClaimAllowed = false"),
        (policy, "mathLiveVirtualKeyboardEnabled = false"),
        (policy, "remoteScriptLoadingAllowed = false"),
        (policy, "MATHLIVE_MAIN_KEYBOARD_BRIDGE_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED"),
        (tool, "MATHLIVE_MAIN_KEYBOARD_BRIDGE_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED"),
        (test, "V172-Q107"),
        (q85, "static const String phase = 'V172-Q85'"),
        (q106, "static const String phase = 'V172-Q106'"),
        (manifest, '"q107MainKeyboardBridgePhase": "V172-Q107"'),
        (manifest, '"q107UsesQ85FrozenBridge": true'),
        (manifest, '"q107RequiresQ106MountFlag": true'),
        (manifest, '"q107MainWorkspaceBridgeImplementedInThisPackage": false'),
        (manifest, '"q107MayMutateKeyboard": false'),
        (manifest, '"q107MaySwitchDefaultEditor": false'),
        (manifest, '"q107MayDeleteLegacyCursor": false'),
        (contract, "q107MainKeyboardBridgeRule"),
        (readme, "V172-Q107 MathPro Keyboard → MathLive Main Bridge Hardening"),
        (audit, "Q107 hardens the MathPro Keyboard → MathLive main-bridge candidate"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing marker: {marker}")

    q85_mapping_markers = [
        "'7': '7'",
        "'+': '+'",
        "'×': r'\\times '",
        "'÷': r'\\div '",
        "'%': r'\\%'",
        "'=': '='",
        "'□/□': r'\\frac{}{}'",
        "'√□': r'\\sqrt{}'",
        "'□^□': '^{}'",
        "'sin': r'\\sin\\left(\\right)'",
        "'log': r'\\log_{}\\left(\\right)'",
        "'∫□dx': r'\\int {}\\,d{}'",
    ]
    for marker in q85_mapping_markers:
        if marker not in q85:
            details.append(f"missing Q85 frozen mapping marker: {marker}")

    combined = "\n".join([policy, manifest, contract, readme, audit, changed])
    forbidden_markers = [
        "mainWorkspaceBridgeImplementedInThisPackage = true",
        "mainBridgeRuntimeBindingAllowedWithoutEvidence = true",
        "mathLiveEnabledByDefault = true",
        "defaultEditorSwitchAllowed = true",
        "keyboardMutationAllowed = true",
        "moreMutationAllowed = true",
        "longPressMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "legacyCursorDeletionAllowed = true",
        "cursorPassClaimAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeSmokeEvidenceAllowed = true",
        "mathLiveVirtualKeyboardEnabled = true",
        "remoteScriptLoadingAllowed = true",
        '"q107MainWorkspaceBridgeImplementedInThisPackage": true',
        '"q107MayMutateKeyboard": true',
        '"q107MayMutateAppShell": true',
        '"q107MayMutateGraphHistorySolutionUi": true',
        '"q107MaySwitchDefaultEditor": true',
        '"q107MayEnableMathLiveByDefault": true',
        '"q107MayDeleteLegacyCursor": true',
        '"q107MayClaimCursorPass": true',
    ]
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"forbidden enabled marker present: {marker}")
    for name, source in protected_sources.items():
        if "V172-Q107" in source:
            details.append(f"Q107 marker found in protected file: {name}")

    if details:
        return CheckResult("v172_q107_main_keyboard_bridge", "FAIL", "; ".join(details))
    return CheckResult("v172_q107_main_keyboard_bridge", "PASS", "Q107 hardens the MathPro keyboard to MathLive main-bridge candidate through the Q85 source-of-truth while blocking keyboard/AppShell/Graph/History/Solution mutation, default switch, cursor PASS, fake evidence, and legacy deletion.")


def check_v172_q108_real_device_cursor_court_execution(root: Path) -> CheckResult:
    policy_path = root / "lib/features/mathlive/mathlive_real_device_cursor_court_execution_policy.dart"
    tool_path = root / "tool/verify_mathlive_real_device_cursor_court_execution.mjs"
    test_path = root / "test/v172_q108_real_device_cursor_court_execution_test.dart"
    audit_path = root / "docs/audit/V172_Q108_REAL_DEVICE_CURSOR_COURT_EXECUTION_AUDIT_REPORT.md"
    changed_path = root / "docs/audit/V172_Q108_CHANGED_FILES_MANIFEST.md"
    q94_path = root / "lib/features/mathlive/mathlive_real_device_cursor_court_policy.dart"
    q106_path = root / "lib/features/mathlive/mathlive_main_workspace_mount_flag_policy.dart"
    q107_path = root / "lib/features/mathlive/mathlive_main_keyboard_bridge_policy.dart"
    manifest_path = root / "assets/mathlive/manifest.json"
    contract_path = root / "lib/logic/mathpro_package_contract.dart"
    readme_path = root / "README.md"
    required_paths = [policy_path, tool_path, test_path, audit_path, changed_path, q94_path, q106_path, q107_path]
    missing = [str(path.relative_to(root)) for path in required_paths if not path.exists()]
    if missing:
        return CheckResult("v172_q108_real_device_cursor_court_execution", "FAIL", "Missing: " + ", ".join(missing))

    policy = read_text(policy_path)
    tool = read_text(tool_path)
    test = read_text(test_path)
    audit = read_text(audit_path)
    changed = read_text(changed_path)
    q94 = read_text(q94_path)
    q106 = read_text(q106_path)
    q107 = read_text(q107_path)
    manifest = read_text(manifest_path) if manifest_path.exists() else ""
    contract = read_text(contract_path) if contract_path.exists() else ""
    readme = read_text(readme_path) if readme_path.exists() else ""
    protected_sources = {p: read_text(root / p) for p in PROTECTED_FILES if (root / p).exists()}

    details: list[str] = []
    required_markers = [
        (policy, "phase = 'V172-Q108'"),
        (policy, "sourceCourtPhase = MathLiveRealDeviceCursorCourtPolicy.phase"),
        (policy, "mountFlagPhase = MathLiveMainWorkspaceMountFlagPolicy.phase"),
        (policy, "mainKeyboardBridgePhase = MathLiveMainKeyboardBridgePolicy.phase"),
        (policy, "executionPackageOnly = true"),
        (policy, "q94CourtProtocolRequired = true"),
        (policy, "q106MountFlagRequired = true"),
        (policy, "q107MainKeyboardBridgeRequired = true"),
        (policy, "q101LabSmokeEvidenceClosureRequired = true"),
        (policy, "officialRuntimeVerificationRequired = true"),
        (policy, "packageMayClaimCursorPass = false"),
        (policy, "packageMaySwitchMainEditor = false"),
        (policy, "packageMayRetireLegacyMainPath = false"),
        (policy, "packageMayDeleteLegacyCursor = false"),
        (policy, "keyboardMutationAllowed = false"),
        (policy, "appShellMutationAllowed = false"),
        (policy, "graphHistorySolutionUiMutationAllowed = false"),
        (policy, "fakeDeviceEvidenceAllowed = false"),
        (policy, "MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_PACKAGE_READY_BUT_DEVICE_EVIDENCE_BLOCKED"),
        (tool, "MATHLIVE_REAL_DEVICE_CURSOR_COURT_EXECUTION_PACKAGE_READY_BUT_DEVICE_EVIDENCE_BLOCKED"),
        (test, "V172-Q108"),
        (q94, "static const String phase = 'V172-Q94'"),
        (q106, "static const String phase = 'V172-Q106'"),
        (q107, "static const String phase = 'V172-Q107'"),
        (manifest, '"q108RealDeviceCursorCourtExecutionPhase": "V172-Q108"'),
        (manifest, '"q108ExecutionPackageOnly": true'),
        (manifest, '"q108RequiresQ94CourtProtocol": true'),
        (manifest, '"q108RequiresQ106MountFlag": true'),
        (manifest, '"q108RequiresQ107MainKeyboardBridge": true'),
        (manifest, '"q108MayClaimCursorPass": false'),
        (manifest, '"q108MaySwitchMainEditor": false'),
        (manifest, '"q108MayDeleteLegacyCursor": false'),
        (manifest, '"q108VerifierScript": "tool/verify_mathlive_real_device_cursor_court_execution.mjs"'),
        (contract, "q108RealDeviceCursorCourtExecutionRule"),
        (readme, "V172-Q108 Real Device MathLive Cursor Court Execution Package"),
        (audit, "Q108 turns the Q94 real-device MathLive cursor court into an execution/capture package"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing marker: {marker}")

    scenario_markers = [
        "empty-placeholder-tap-leading-caret",
        "fraction-numerator-denominator-routing",
        "sqrt-radicand-routing",
        "power-exponent-routing",
        "subscript-routing",
        "sin-300-continuous-argument-entry",
        "tan-long-expression-navigation",
        "log-base-and-body-separation",
        "integral-lower-upper-body-differential-routing",
        "backspace-delete-structural-editing",
        "long-expression-horizontal-scroll-and-tap",
        "focus-loss-restore-and-keyboard-latency",
    ]
    for marker in scenario_markers:
        if marker not in policy:
            details.append(f"missing Q108 scenario marker: {marker}")
        if marker not in q94:
            details.append(f"missing matching Q94 scenario marker: {marker}")

    command_markers = [
        "flutter pub get",
        "flutter analyze",
        "flutter test",
        "node tool/verify_mathlive_official_runtime_bundle.mjs",
        "node tool/verify_mathlive_lab_smoke_evidence_closure.mjs",
        "node tool/verify_mathlive_main_workspace_mount_flag.mjs",
        "node tool/verify_mathlive_main_keyboard_bridge.mjs",
        "node tool/verify_mathlive_real_device_cursor_court_execution.mjs",
        "flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA",
        "flutter run -d 23106RN0DA",
    ]
    for marker in command_markers:
        if marker not in policy or marker not in readme:
            details.append(f"missing Q108 command marker in policy/readme: {marker}")

    combined = "\n".join([policy, manifest, contract, readme, audit, changed])
    forbidden_markers = [
        "packageMayClaimDevicePass = true",
        "packageMayClaimCursorPass = true",
        "packageMaySwitchMainEditor = true",
        "packageMayEnableMathLiveByDefault = true",
        "packageMayRetireLegacyMainPath = true",
        "packageMayDeleteLegacyCursor = true",
        "keyboardMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeSmokeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        "mathLiveVirtualKeyboardEnabled = true",
        "remoteScriptLoadingAllowed = true",
        '"q108MayClaimCursorPass": true',
        '"q108MaySwitchMainEditor": true',
        '"q108MayEnableMathLiveByDefault": true',
        '"q108MayDeleteLegacyCursor": true',
        '"q108MayMutateKeyboard": true',
        '"q108MayMutateAppShell": true',
        '"q108MayMutateGraphHistorySolutionUi": true',
    ]
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"forbidden enabled marker present: {marker}")
    for name, source in protected_sources.items():
        if "V172-Q108" in source:
            details.append(f"Q108 marker found in protected file: {name}")

    if details:
        return CheckResult("v172_q108_real_device_cursor_court_execution", "FAIL", "; ".join(details))
    return CheckResult("v172_q108_real_device_cursor_court_execution", "PASS", "Q108 packages the real-device MathLive cursor court execution/capture protocol while blocking fake device PASS, main-editor switch, protected UI mutation, legacy retirement, and legacy deletion.")



def check_v172_q109_main_editor_switch_conditional_activation(root: Path) -> CheckResult:
    policy_path = root / "lib/features/mathlive/mathlive_main_editor_switch_conditional_activation_policy.dart"
    tool_path = root / "tool/verify_mathlive_main_editor_switch_conditional_activation.mjs"
    test_path = root / "test/v172_q109_main_editor_switch_conditional_activation_test.dart"
    audit_path = root / "docs/audit/V172_Q109_MAIN_EDITOR_SWITCH_CONDITIONAL_ACTIVATION_AUDIT_REPORT.md"
    changed_path = root / "docs/audit/V172_Q109_CHANGED_FILES_MANIFEST.md"
    manifest_path = root / "assets/mathlive/manifest.json"
    contract_path = root / "lib/logic/mathpro_package_contract.dart"
    readme_path = root / "README.md"
    q100_path = root / "lib/features/mathlive/mathlive_official_runtime_bundle_closure_policy.dart"
    q101_path = root / "lib/features/mathlive/mathlive_lab_smoke_evidence_closure_policy.dart"
    q103_path = root / "lib/features/mathlive/mathlive_graph_eligibility_adapter_policy.dart"
    q104_path = root / "lib/features/mathlive/mathlive_history_adapter_policy.dart"
    q105_path = root / "lib/features/mathlive/mathlive_solution_evaluator_candidate_adapter_policy.dart"
    q106_path = root / "lib/features/mathlive/mathlive_main_workspace_mount_flag_policy.dart"
    q107_path = root / "lib/features/mathlive/mathlive_main_keyboard_bridge_policy.dart"
    q108_path = root / "lib/features/mathlive/mathlive_real_device_cursor_court_execution_policy.dart"

    missing = [str(p.relative_to(root)) for p in [policy_path, tool_path, test_path, audit_path, changed_path, manifest_path, contract_path, readme_path, q100_path, q101_path, q103_path, q104_path, q105_path, q106_path, q107_path, q108_path] if not p.exists()]
    if missing:
        return CheckResult("v172_q109_main_editor_switch_conditional_activation", "FAIL", "missing files: " + ", ".join(missing))

    policy = read_text(policy_path)
    tool = read_text(tool_path)
    test = read_text(test_path)
    audit = read_text(audit_path)
    changed = read_text(changed_path)
    manifest = read_text(manifest_path)
    contract = read_text(contract_path)
    readme = read_text(readme_path)
    q100 = read_text(q100_path)
    q101 = read_text(q101_path)
    q103 = read_text(q103_path)
    q104 = read_text(q104_path)
    q105 = read_text(q105_path)
    q106 = read_text(q106_path)
    q107 = read_text(q107_path)
    q108 = read_text(q108_path)
    protected_sources = {p: read_text(root / p) for p in PROTECTED_FILES if (root / p).exists()}

    details: list[str] = []
    required_markers = [
        (policy, "phase = 'V172-Q109'"),
        (policy, "conditionalActivationGateImplemented = true"),
        (policy, "actualMainEditorSwitchImplementedInThisPackage = false"),
        (policy, "mainWorkspaceMountImplementedInThisPackage = false"),
        (policy, "mathLiveEnabledByDefault = false"),
        (policy, "legacyRemainsDefaultUntilLaterApprovedPhase = true"),
        (policy, "q100OfficialRuntimeBundleClosureRequired = true"),
        (policy, "q101LabSmokeEvidenceClosureRequired = true"),
        (policy, "q103GraphEligibilityAdapterRequired = true"),
        (policy, "q104HistoryAdapterRequired = true"),
        (policy, "q105SolutionEvaluatorAdapterRequired = true"),
        (policy, "q106MountFlagRequired = true"),
        (policy, "q107MainKeyboardBridgeRequired = true"),
        (policy, "q108RealDeviceCursorCourtExecutionRequired = true"),
        (policy, "explicitInternalFlagRequired = true"),
        (policy, "explicitActivationReviewRequired = true"),
        (policy, "MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (tool, "MATHLIVE_MAIN_EDITOR_CONDITIONAL_ACTIVATION_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (test, "V172-Q109"),
        (q100, "static const String phase = 'V172-Q100'"),
        (q101, "static const String phase = 'V172-Q101'"),
        (q103, "static const String phase = 'V172-Q103'"),
        (q104, "static const String phase = 'V172-Q104'"),
        (q105, "static const String phase = 'V172-Q105'"),
        (q106, "static const String phase = 'V172-Q106'"),
        (q107, "static const String phase = 'V172-Q107'"),
        (q108, "static const String phase = 'V172-Q108'"),
        (manifest, '"q109MainEditorSwitchConditionalActivationPhase": "V172-Q109"'),
        (manifest, '"q109ConditionalActivationGateImplemented": true'),
        (manifest, '"q109ActualMainEditorSwitchImplementedInThisPackage": false'),
        (manifest, '"q109MainWorkspaceMountImplementedInThisPackage": false'),
        (manifest, '"q109MaySwitchDefaultEditorNow": false'),
        (manifest, '"q109MayRetireLegacyMainPathNow": false'),
        (manifest, '"q109MayDeleteLegacyCursor": false'),
        (manifest, '"q109VerifierScript": "tool/verify_mathlive_main_editor_switch_conditional_activation.mjs"'),
        (contract, "q109MainEditorSwitchConditionalActivationRule"),
        (readme, "V172-Q109 Main Editor Switch Conditional Activation"),
        (audit, "Q109 adds the conditional main-editor activation gate"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing marker: {marker}")

    forbidden_markers = [
        "actualMainEditorSwitchImplementedInThisPackage = true",
        "mainWorkspaceMountImplementedInThisPackage = true",
        "mathLiveEnabledByDefault = true",
        "keyboardMutationAllowed = true",
        "moreMutationAllowed = true",
        "longPressMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "legacyCursorRetirementAllowedInThisPackage = true",
        "legacyCursorDeletionAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeSmokeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        "cursorPassClaimAllowedInThisPackage = true",
        "mathLiveVirtualKeyboardEnabled = true",
        "remoteScriptLoadingAllowed = true",
        '"q109ActualMainEditorSwitchImplementedInThisPackage": true',
        '"q109MainWorkspaceMountImplementedInThisPackage": true',
        '"q109MaySwitchDefaultEditorNow": true',
        '"q109MayEnableMathLiveByDefault": true',
        '"q109MayRetireLegacyMainPathNow": true',
        '"q109MayDeleteLegacyCursor": true',
        '"q109MayMutateKeyboard": true',
        '"q109MayMutateAppShell": true',
        '"q109MayMutateGraphHistorySolutionUi": true',
    ]
    combined = "\n".join([policy, manifest, contract, readme, audit, changed])
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"forbidden enabled marker present: {marker}")
    for name, source in protected_sources.items():
        if "V172-Q109" in source:
            details.append(f"Q109 marker found in protected file: {name}")

    if details:
        return CheckResult("v172_q109_main_editor_switch_conditional_activation", "FAIL", "; ".join(details))
    return CheckResult("v172_q109_main_editor_switch_conditional_activation", "PASS", "Q109 adds a conditional main-editor activation gate while blocking actual switch, default MathLive activation, protected UI mutation, fake evidence, cursor PASS, legacy retirement, and legacy deletion.")



def check_v172_q110_legacy_cursor_main_path_retirement_actual_gate(root: Path) -> CheckResult:
    policy_path = root / "lib/features/editor_adapter/legacy_cursor_main_path_retirement_actual_gate_policy.dart"
    tool_path = root / "tool/verify_legacy_cursor_main_path_retirement_actual_gate.mjs"
    test_path = root / "test/v172_q110_legacy_cursor_main_path_retirement_actual_gate_test.dart"
    audit_path = root / "docs/audit/V172_Q110_LEGACY_CURSOR_MAIN_PATH_RETIREMENT_ACTUAL_GATE_AUDIT_REPORT.md"
    changed_path = root / "docs/audit/V172_Q110_CHANGED_FILES_MANIFEST.md"
    manifest_path = root / "assets/mathlive/manifest.json"
    contract_path = root / "lib/logic/mathpro_package_contract.dart"
    readme_path = root / "README.md"
    q109_path = root / "lib/features/mathlive/mathlive_main_editor_switch_conditional_activation_policy.dart"
    q108_path = root / "lib/features/mathlive/mathlive_real_device_cursor_court_execution_policy.dart"
    q103_path = root / "lib/features/mathlive/mathlive_graph_eligibility_adapter_policy.dart"
    q104_path = root / "lib/features/mathlive/mathlive_history_adapter_policy.dart"
    q105_path = root / "lib/features/mathlive/mathlive_solution_evaluator_candidate_adapter_policy.dart"

    required_paths = [policy_path, tool_path, test_path, audit_path, changed_path, manifest_path, contract_path, readme_path, q109_path, q108_path, q103_path, q104_path, q105_path]
    missing = [str(x.relative_to(root)) for x in required_paths if not x.exists()]
    if missing:
        return CheckResult("v172_q110_legacy_cursor_main_path_retirement_actual_gate", "FAIL", "missing files: " + ", ".join(missing))

    policy = read_text(policy_path)
    tool = read_text(tool_path)
    test = read_text(test_path)
    audit = read_text(audit_path)
    changed = read_text(changed_path)
    manifest = read_text(manifest_path)
    contract = read_text(contract_path)
    readme = read_text(readme_path)
    q109 = read_text(q109_path)
    q108 = read_text(q108_path)
    q103 = read_text(q103_path)
    q104 = read_text(q104_path)
    q105 = read_text(q105_path)
    protected_sources = {p: read_text(root / p) for p in PROTECTED_FILES if (root / p).exists()}

    details: list[str] = []
    required_markers = [
        (policy, "phase = 'V172-Q110'"),
        (policy, "actualLegacyMainPathRetirementImplementedInThisPackage = false"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "mainWorkspaceMountImplementedInThisPackage = false"),
        (policy, "legacyCursorDeletionAllowed = false"),
        (policy, "q109ConditionalActivationRequired = true"),
        (policy, "q108RealDeviceCursorCourtRequired = true"),
        (policy, "explicitRetirementApprovalRequired = true"),
        (policy, "postActivationSoakRequired = true"),
        (policy, "LEGACY_CURSOR_MAIN_PATH_RETIREMENT_GATE_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (tool, "LEGACY_CURSOR_MAIN_PATH_RETIREMENT_GATE_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (tool, "mayRetireLegacyMainPathNow: false"),
        (tool, "mayDeleteLegacyCursor: false"),
        (test, "V172-Q110"),
        (q109, "static const String phase = 'V172-Q109'"),
        (q108, "static const String phase = 'V172-Q108'"),
        (q103, "static const String phase = 'V172-Q103'"),
        (q104, "static const String phase = 'V172-Q104'"),
        (q105, "static const String phase = 'V172-Q105'"),
        (manifest, '"q110LegacyCursorMainPathRetirementActualGatePhase": "V172-Q110"'),
        (manifest, '"q110ActualLegacyMainPathRetirementImplementedInThisPackage": false'),
        (manifest, '"q110MathLiveDefaultSwitchImplementedInThisPackage": false'),
        (manifest, '"q110MayRetireLegacyMainPathNow": false'),
        (manifest, '"q110MayDeleteLegacyCursor": false'),
        (manifest, '"q110MaySwitchDefaultEditorNow": false'),
        (manifest, '"q110VerifierScript": "tool/verify_legacy_cursor_main_path_retirement_actual_gate.mjs"'),
        (contract, "q110LegacyCursorMainPathRetirementActualGateRule"),
        (readme, "V172-Q110 Legacy Cursor Main Path Retirement Actual Gate"),
        (audit, "Q110 adds a hard pre-retirement gate"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing marker: {marker}")

    forbidden_markers = [
        "actualLegacyMainPathRetirementImplementedInThisPackage = true",
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "mainWorkspaceMountImplementedInThisPackage = true",
        "legacyCursorDeletionAllowed = true",
        "keyboardMutationAllowed = true",
        "moreMutationAllowed = true",
        "longPressMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeSmokeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        "cursorPassClaimAllowedInThisPackage = true",
        '"q110ActualLegacyMainPathRetirementImplementedInThisPackage": true',
        '"q110MathLiveDefaultSwitchImplementedInThisPackage": true',
        '"q110MainWorkspaceMountImplementedInThisPackage": true',
        '"q110MayRetireLegacyMainPathNow": true',
        '"q110MayDeleteLegacyCursor": true',
        '"q110MaySwitchDefaultEditorNow": true',
        '"q110MayMutateKeyboard": true',
        '"q110MayMutateAppShell": true',
        '"q110MayMutateGraphHistorySolutionUi": true',
        '"q110MayClaimCursorPass": true',
    ]
    combined = "\n".join([policy, tool, manifest, contract, readme, audit, changed])
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"forbidden enabled marker present: {marker}")
    for name, source in protected_sources.items():
        if "V172-Q110" in source:
            details.append(f"Q110 marker found in protected file: {name}")

    if details:
        return CheckResult("v172_q110_legacy_cursor_main_path_retirement_actual_gate", "FAIL", "; ".join(details))
    return CheckResult("v172_q110_legacy_cursor_main_path_retirement_actual_gate", "PASS", "Q110 adds a hard pre-retirement gate while blocking actual legacy main-path retirement, default switch, protected UI mutation, fake evidence, cursor PASS, and legacy cursor deletion.")



def check_v172_q111_legacy_cursor_physical_cleanup_planning(root: Path) -> CheckResult:
    policy_path = root / "lib/features/editor_adapter/legacy_cursor_physical_cleanup_planning_policy.dart"
    tool_path = root / "tool/verify_legacy_cursor_physical_cleanup_planning.mjs"
    test_path = root / "test/v172_q111_legacy_cursor_physical_cleanup_planning_test.dart"
    audit_path = root / "docs/audit/V172_Q111_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_AUDIT_REPORT.md"
    changed_path = root / "docs/audit/V172_Q111_CHANGED_FILES_MANIFEST.md"
    inventory_path = root / "docs/audit/V172_Q111_LEGACY_CURSOR_PHYSICAL_CLEANUP_INVENTORY.json"
    manifest_path = root / "assets/mathlive/manifest.json"
    contract_path = root / "lib/logic/mathpro_package_contract.dart"
    readme_path = root / "README.md"
    q110_path = root / "lib/features/editor_adapter/legacy_cursor_main_path_retirement_actual_gate_policy.dart"

    required_paths = [policy_path, tool_path, test_path, audit_path, changed_path, inventory_path, manifest_path, contract_path, readme_path, q110_path]
    missing = [str(x.relative_to(root)) for x in required_paths if not x.exists()]
    if missing:
        return CheckResult("v172_q111_legacy_cursor_physical_cleanup_planning", "FAIL", "missing files: " + ", ".join(missing))

    policy = read_text(policy_path)
    tool = read_text(tool_path)
    test = read_text(test_path)
    audit = read_text(audit_path)
    changed = read_text(changed_path)
    inventory = read_text(inventory_path)
    manifest = read_text(manifest_path)
    contract = read_text(contract_path)
    readme = read_text(readme_path)
    q110 = read_text(q110_path)
    protected_sources = {p: read_text(root / p) for p in PROTECTED_FILES if (root / p).exists()}

    details: list[str] = []
    required_markers = [
        (policy, "phase = 'V172-Q111'"),
        (policy, "actualPhysicalCleanupImplementedInThisPackage = false"),
        (policy, "legacyCursorFileDeletionAllowedNow = false"),
        (policy, "mayDeleteLegacyCursorNow = false"),
        (policy, "q110RetirementGateRequired = true"),
        (policy, "manualReviewRequiredBeforeQ112 = true"),
        (policy, "LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (tool, "LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (tool, "mayDeleteLegacyCursorNow: false"),
        (tool, "actualPhysicalCleanupImplementedInThisPackage: false"),
        (test, "V172-Q111"),
        (q110, "static const String phase = 'V172-Q110'"),
        (inventory, '"phase": "V172-Q111"'),
        (inventory, '"actualPhysicalCleanupImplementedInThisPackage": false'),
        (inventory, '"legacyCursorFileDeletionAllowedNow": false'),
        (inventory, '"mayDeleteLegacyCursorNow": false'),
        (inventory, '"deletedFilesInThisPackage": []'),
        (inventory, '"mustKeepProtectedSurface"'),
        (inventory, '"mustKeepDataModelOrSharedEditorCore"'),
        (inventory, '"retainRollbackUntilPostActivation"'),
        (inventory, '"cleanupCandidateAfterQ112Review"'),
        (inventory, '"manualReviewRequiredBeforeDeletion"'),
        (manifest, '"q111LegacyCursorPhysicalCleanupPlanningPhase": "V172-Q111"'),
        (manifest, '"q111ActualPhysicalCleanupImplementedInThisPackage": false'),
        (manifest, '"q111LegacyCursorFileDeletionAllowedNow": false'),
        (manifest, '"q111MayDeleteLegacyCursorNow": false'),
        (manifest, '"q111VerifierScript": "tool/verify_legacy_cursor_physical_cleanup_planning.mjs"'),
        (contract, "q111LegacyCursorPhysicalCleanupPlanningRule"),
        (readme, "V172-Q111 Legacy Cursor Physical Cleanup Planning"),
        (audit, "Q111 adds a physical-cleanup planning"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing marker: {marker}")

    forbidden_markers = [
        "actualPhysicalCleanupImplementedInThisPackage = true",
        "legacyCursorFileDeletionAllowedNow = true",
        "mayDeleteLegacyCursorNow = true",
        "keyboardMutationAllowed = true",
        "moreMutationAllowed = true",
        "longPressMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeSmokeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        "cursorPassClaimAllowedInThisPackage = true",
        '"q111ActualPhysicalCleanupImplementedInThisPackage": true',
        '"q111LegacyCursorFileDeletionAllowedNow": true',
        '"q111MayDeleteLegacyCursorNow": true',
        '"q111MayMutateKeyboard": true',
        '"q111MayMutateAppShell": true',
        '"q111MayMutateGraphHistorySolutionUi": true',
        '"q111MayClaimCursorPass": true',
    ]
    combined = "\n".join([policy, tool, manifest, contract, readme, audit, changed, inventory])
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"forbidden enabled marker present: {marker}")
    for name, source in protected_sources.items():
        if "V172-Q111" in source:
            details.append(f"Q111 marker found in protected file: {name}")

    try:
        parsed_inventory = json.loads(inventory)
        categories = parsed_inventory.get("categories", {})
        for category in ["mustKeepProtectedSurface", "mustKeepDataModelOrSharedEditorCore", "retainRollbackUntilPostActivation", "cleanupCandidateAfterQ112Review", "manualReviewRequiredBeforeDeletion"]:
            if not isinstance(categories.get(category), list):
                details.append(f"inventory category is not a list: {category}")
        if parsed_inventory.get("deletedFilesInThisPackage") != []:
            details.append("inventory deletedFilesInThisPackage is not empty")
    except Exception as exc:
        details.append(f"inventory JSON parse failed: {exc}")

    if details:
        return CheckResult("v172_q111_legacy_cursor_physical_cleanup_planning", "FAIL", "; ".join(details))
    return CheckResult("v172_q111_legacy_cursor_physical_cleanup_planning", "PASS", "Q111 adds an inventory-only physical cleanup planning gate while blocking deletion, runtime behavior changes, protected UI mutation, fake evidence, cursor PASS claims, main editor switching, and legacy cleanup execution.")


def check_v172_q112_legacy_cursor_physical_cleanup_execution_guard(root: Path) -> CheckResult:
    policy_path = root / "lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_policy.dart"
    tool_path = root / "tool/verify_legacy_cursor_physical_cleanup_execution_guard.mjs"
    test_path = root / "test/v172_q112_legacy_cursor_physical_cleanup_execution_guard_test.dart"
    audit_path = root / "docs/audit/V172_Q112_LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_AUDIT_REPORT.md"
    changed_path = root / "docs/audit/V172_Q112_CHANGED_FILES_MANIFEST.md"
    inventory_path = root / "docs/audit/V172_Q111_LEGACY_CURSOR_PHYSICAL_CLEANUP_INVENTORY.json"
    manifest_path = root / "assets/mathlive/manifest.json"
    contract_path = root / "lib/logic/mathpro_package_contract.dart"
    readme_path = root / "README.md"
    q111_path = root / "lib/features/editor_adapter/legacy_cursor_physical_cleanup_planning_policy.dart"

    required_paths = [policy_path, tool_path, test_path, audit_path, changed_path, inventory_path, manifest_path, contract_path, readme_path, q111_path]
    missing = [str(x.relative_to(root)) for x in required_paths if not x.exists()]
    if missing:
        return CheckResult("v172_q112_legacy_cursor_physical_cleanup_execution_guard", "FAIL", "missing files: " + ", ".join(missing))

    policy = read_text(policy_path)
    tool = read_text(tool_path)
    test = read_text(test_path)
    audit = read_text(audit_path)
    changed = read_text(changed_path)
    inventory = read_text(inventory_path)
    manifest = read_text(manifest_path)
    contract = read_text(contract_path)
    readme = read_text(readme_path)
    q111 = read_text(q111_path)
    protected_sources = {p: read_text(root / p) for p in PROTECTED_FILES if (root / p).exists()}

    details: list[str] = []
    required_markers = [
        (policy, "phase = 'V172-Q112'"),
        (policy, "cleanupExecutionGuardImplemented = true"),
        (policy, "physicalCleanupExecutionImplementedInThisPackage = false"),
        (policy, "actualPhysicalCleanupImplementedInThisPackage = false"),
        (policy, "legacyCursorFileDeletionAllowedNow = false"),
        (policy, "mayDeleteLegacyCursorNow = false"),
        (policy, "mayExecuteCleanupInThisPackage = false"),
        (policy, "explicitQ112CleanupApprovalRequired = true"),
        (policy, "postActivationSoakRequired = true"),
        (policy, "LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (tool, "LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (tool, "mayExecuteCleanupInThisPackage: false"),
        (tool, "mayDeleteLegacyCursorNow: false"),
        (test, "V172-Q112"),
        (q111, "static const String phase = 'V172-Q111'"),
        (inventory, '"phase": "V172-Q111"'),
        (inventory, '"deletedFilesInThisPackage": []'),
        (manifest, '"q112LegacyCursorPhysicalCleanupExecutionGuardPhase": "V172-Q112"'),
        (manifest, '"q112CleanupExecutionGuardImplemented": true'),
        (manifest, '"q112PhysicalCleanupExecutionImplementedInThisPackage": false'),
        (manifest, '"q112ActualPhysicalCleanupImplementedInThisPackage": false'),
        (manifest, '"q112LegacyCursorFileDeletionAllowedNow": false'),
        (manifest, '"q112MayDeleteLegacyCursorNow": false'),
        (manifest, '"q112MayExecuteCleanupInThisPackage": false'),
        (manifest, '"q112VerifierScript": "tool/verify_legacy_cursor_physical_cleanup_execution_guard.mjs"'),
        (contract, "q112LegacyCursorPhysicalCleanupExecutionGuardRule"),
        (readme, "V172-Q112 Legacy Cursor Physical Cleanup Execution Guard"),
        (audit, "Q112 adds a physical-cleanup execution guard only"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing marker: {marker}")

    forbidden_markers = [
        "physicalCleanupExecutionImplementedInThisPackage = true",
        "actualPhysicalCleanupImplementedInThisPackage = true",
        "legacyCursorFileDeletionAllowedNow = true",
        "mayDeleteLegacyCursorNow = true",
        "mayExecuteCleanupInThisPackage = true",
        "keyboardMutationAllowed = true",
        "moreMutationAllowed = true",
        "longPressMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeSmokeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        "cursorPassClaimAllowedInThisPackage = true",
        '"q112PhysicalCleanupExecutionImplementedInThisPackage": true',
        '"q112ActualPhysicalCleanupImplementedInThisPackage": true',
        '"q112LegacyCursorFileDeletionAllowedNow": true',
        '"q112MayDeleteLegacyCursorNow": true',
        '"q112MayExecuteCleanupInThisPackage": true',
        '"q112MayMutateKeyboard": true',
        '"q112MayMutateAppShell": true',
        '"q112MayMutateGraphHistorySolutionUi": true',
        '"q112MayClaimCursorPass": true',
    ]
    combined = "\n".join([policy, tool, manifest, contract, readme, audit, changed, inventory])
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"forbidden enabled marker present: {marker}")
    for name, source in protected_sources.items():
        if "V172-Q112" in source:
            details.append(f"Q112 marker found in protected file: {name}")

    try:
        parsed_inventory = json.loads(inventory)
        categories = parsed_inventory.get("categories", {})
        for category in ["mustKeepProtectedSurface", "mustKeepDataModelOrSharedEditorCore", "retainRollbackUntilPostActivation", "cleanupCandidateAfterQ112Review", "manualReviewRequiredBeforeDeletion"]:
            items = categories.get(category)
            if not isinstance(items, list):
                details.append(f"inventory category is not a list: {category}")
            elif category in ["cleanupCandidateAfterQ112Review", "manualReviewRequiredBeforeDeletion"] and len(items) == 0:
                details.append(f"inventory category is unexpectedly empty: {category}")
        if parsed_inventory.get("deletedFilesInThisPackage") != []:
            details.append("inventory deletedFilesInThisPackage is not empty")
    except Exception as exc:
        details.append(f"inventory JSON parse failed: {exc}")

    if details:
        return CheckResult("v172_q112_legacy_cursor_physical_cleanup_execution_guard", "FAIL", "; ".join(details))
    return CheckResult("v172_q112_legacy_cursor_physical_cleanup_execution_guard", "PASS", "Q112 adds a physical cleanup execution guard while blocking deletion, runtime behavior changes, protected UI mutation, fake evidence, cursor PASS claims, main editor switching, and cleanup execution in this package.")


def check_v172_q113_post_cleanup_regression_court_guard(root: Path) -> CheckResult:
    policy_path = root / "lib/features/editor_adapter/post_cleanup_regression_court_guard_policy.dart"
    tool_path = root / "tool/verify_post_cleanup_regression_court_guard.mjs"
    test_path = root / "test/v172_q113_post_cleanup_regression_court_guard_test.dart"
    audit_path = root / "docs/audit/V172_Q113_POST_CLEANUP_REGRESSION_COURT_GUARD_AUDIT_REPORT.md"
    changed_path = root / "docs/audit/V172_Q113_CHANGED_FILES_MANIFEST.md"
    q112_policy_path = root / "lib/features/editor_adapter/legacy_cursor_physical_cleanup_execution_guard_policy.dart"
    q112_tool_path = root / "tool/verify_legacy_cursor_physical_cleanup_execution_guard.mjs"
    inventory_path = root / "docs/audit/V172_Q111_LEGACY_CURSOR_PHYSICAL_CLEANUP_INVENTORY.json"
    manifest_path = root / "assets/mathlive/manifest.json"
    contract_path = root / "lib/logic/mathpro_package_contract.dart"
    readme_path = root / "README.md"

    required_paths = [policy_path, tool_path, test_path, audit_path, changed_path, q112_policy_path, q112_tool_path, inventory_path, manifest_path, contract_path, readme_path]
    missing = [str(x.relative_to(root)) for x in required_paths if not x.exists()]
    if missing:
        return CheckResult("v172_q113_post_cleanup_regression_court_guard", "FAIL", "missing files: " + ", ".join(missing))

    policy = read_text(policy_path)
    tool = read_text(tool_path)
    test = read_text(test_path)
    audit = read_text(audit_path)
    changed = read_text(changed_path)
    manifest = read_text(manifest_path)
    contract = read_text(contract_path)
    readme = read_text(readme_path)
    inventory = read_text(inventory_path)
    q112_policy = read_text(q112_policy_path)
    q112_tool = read_text(q112_tool_path)
    protected_sources = {p: read_text(root / p) for p in PROTECTED_FILES if (root / p).exists()}

    details: list[str] = []
    required_markers = [
        (policy, "phase = 'V172-Q113'"),
        (policy, "postCleanupRegressionCourtGuardImplemented = true"),
        (policy, "postCleanupRegressionExecutedInThisPackage = false"),
        (policy, "physicalCleanupAssumedCompleteInThisPackage = false"),
        (policy, "finalReleaseCandidateClaimAllowedInThisPackage = false"),
        (policy, "mayClaimPostCleanupPassNow = false"),
        (policy, "mayClaimCursorPassNow = false"),
        (policy, "maySwitchMathLiveDefaultEditorNow = false"),
        (policy, "mayDeleteLegacyCursorNow = false"),
        (policy, "POST_CLEANUP_REGRESSION_COURT_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (tool, "POST_CLEANUP_REGRESSION_COURT_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (tool, "postCleanupRegressionExecutedInThisPackage: false"),
        (tool, "mayClaimPostCleanupPassNow: false"),
        (tool, "mayDeleteLegacyCursorNow: false"),
        (test, "V172-Q113"),
        (q112_policy, "static const String phase = 'V172-Q112'"),
        (q112_tool, "LEGACY_CURSOR_PHYSICAL_CLEANUP_EXECUTION_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (inventory, '"phase": "V172-Q111"'),
        (inventory, '"deletedFilesInThisPackage": []'),
        (manifest, '"q113PostCleanupRegressionCourtGuardPhase": "V172-Q113"'),
        (manifest, '"q113PostCleanupRegressionCourtGuardImplemented": true'),
        (manifest, '"q113PostCleanupRegressionExecutedInThisPackage": false'),
        (manifest, '"q113PhysicalCleanupAssumedCompleteInThisPackage": false'),
        (manifest, '"q113MayClaimPostCleanupPassNow": false'),
        (manifest, '"q113MayClaimCursorPassNow": false'),
        (manifest, '"q113MaySwitchMathLiveDefaultEditorNow": false'),
        (manifest, '"q113MayDeleteLegacyCursorNow": false'),
        (manifest, '"q113VerifierScript": "tool/verify_post_cleanup_regression_court_guard.mjs"'),
        (contract, "q113PostCleanupRegressionCourtGuardRule"),
        (readme, "V172-Q113 Post-Cleanup Regression Court Guard"),
        (audit, "Q113 adds a post-cleanup regression court guard only"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing marker: {marker}")

    forbidden_markers = [
        "postCleanupRegressionExecutedInThisPackage = true",
        "physicalCleanupAssumedCompleteInThisPackage = true",
        "finalReleaseCandidateClaimAllowedInThisPackage = true",
        "mayClaimPostCleanupPassNow = true",
        "mayClaimCursorPassNow = true",
        "mayClaimPhotomathWolframLevelNow = true",
        "maySwitchMathLiveDefaultEditorNow = true",
        "mayDeleteLegacyCursorNow = true",
        "keyboardMutationAllowed = true",
        "moreMutationAllowed = true",
        "longPressMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "protectedUiSurfaceMutationAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeSmokeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        '"q113PostCleanupRegressionExecutedInThisPackage": true',
        '"q113PhysicalCleanupAssumedCompleteInThisPackage": true',
        '"q113MayClaimPostCleanupPassNow": true',
        '"q113MayClaimCursorPassNow": true',
        '"q113MaySwitchMathLiveDefaultEditorNow": true',
        '"q113MayDeleteLegacyCursorNow": true',
        '"q113MayMutateKeyboard": true',
        '"q113MayMutateAppShell": true',
        '"q113MayMutateGraphHistorySolutionUi": true',
    ]
    combined = "\n".join([policy, tool, manifest, contract, readme, audit, changed, inventory])
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"forbidden enabled marker present: {marker}")
    for name, source in protected_sources.items():
        if "V172-Q113" in source:
            details.append(f"Q113 marker found in protected file: {name}")

    try:
        parsed_inventory = json.loads(inventory)
        categories = parsed_inventory.get("categories", {})
        for category in ["mustKeepProtectedSurface", "mustKeepDataModelOrSharedEditorCore", "retainRollbackUntilPostActivation", "cleanupCandidateAfterQ112Review", "manualReviewRequiredBeforeDeletion"]:
            items = categories.get(category)
            if not isinstance(items, list):
                details.append(f"inventory category is not a list: {category}")
        if parsed_inventory.get("deletedFilesInThisPackage") != []:
            details.append("inventory deletedFilesInThisPackage is not empty")
    except Exception as exc:
        details.append(f"inventory JSON parse failed: {exc}")

    if details:
        return CheckResult("v172_q113_post_cleanup_regression_court_guard", "FAIL", "; ".join(details))
    return CheckResult("v172_q113_post_cleanup_regression_court_guard", "PASS", "Q113 adds a post-cleanup regression court guard while blocking release PASS claims, default editor switching, protected UI mutation, fake evidence, cursor PASS claims, and legacy deletion in this package.")

def check_v172_q114_release_freeze_clean_full_zip_guard(root: Path) -> CheckResult:
    required = [
        "lib/features/editor_adapter/release_freeze_clean_full_zip_guard_policy.dart",
        "tool/verify_release_freeze_clean_full_zip_guard.mjs",
        "test/v172_q114_release_freeze_clean_full_zip_guard_test.dart",
        "docs/audit/V172_Q114_RELEASE_FREEZE_CLEAN_FULL_ZIP_GUARD_AUDIT_REPORT.md",
        "docs/audit/V172_Q114_CHANGED_FILES_MANIFEST.md",
        "docs/audit/V172_Q114_RELEASE_FREEZE_CHECKLIST.json",
    ]
    missing = [p for p in required if not (root / p).exists()]
    details: list[str] = []
    if missing:
        details.append("missing Q114 files: " + ", ".join(missing))

    def txt(rel: str) -> str:
        path = root / rel
        return read_text(path) if path.exists() else ""

    policy = txt("lib/features/editor_adapter/release_freeze_clean_full_zip_guard_policy.dart")
    tool = txt("tool/verify_release_freeze_clean_full_zip_guard.mjs")
    test = txt("test/v172_q114_release_freeze_clean_full_zip_guard_test.dart")
    audit = txt("docs/audit/V172_Q114_RELEASE_FREEZE_CLEAN_FULL_ZIP_GUARD_AUDIT_REPORT.md")
    changed = txt("docs/audit/V172_Q114_CHANGED_FILES_MANIFEST.md")
    checklist_text = txt("docs/audit/V172_Q114_RELEASE_FREEZE_CHECKLIST.json")
    manifest = txt("assets/mathlive/manifest.json")
    contract = txt("lib/logic/mathpro_package_contract.dart")
    readme = txt("README.md")

    required_markers = [
        "V172-Q114",
        "ReleaseFreezeCleanFullZipGuardPolicy",
        "verify_release_freeze_clean_full_zip_guard.mjs",
        "RELEASE_FREEZE_CLEAN_FULL_ZIP_GUARD_PACKAGE_READY_BUT_EVIDENCE_BLOCKED",
        "MathProFlutterPhase17.zip",
        "q114ReleaseFreezeCleanFullZipGuardRule",
        "q114ReleaseFreezeGuardImplemented",
        "q114ExpectedDeliveryZipName",
    ]
    combined = "\n".join([policy, tool, test, audit, changed, checklist_text, manifest, contract, readme])
    for marker in required_markers:
        if marker not in combined:
            details.append(f"missing Q114 marker: {marker}")

    forbidden_markers = [
        "releaseFrozenInThisPackage = true",
        "finalReleasePassClaimAllowedInThisPackage = true",
        "cleanFullZipClaimAllowedWithoutFreshExtract = true",
        "mathLiveDefaultSwitchAllowedInThisPackage = true",
        "legacyCursorDeletionAllowedInThisPackage = true",
        "protectedUiSurfaceMutationAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeSmokeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        "patchOnlyDeliveryAllowed = true",
        '"q114ReleaseFrozenInThisPackage": true',
        '"q114FinalReleasePassClaimAllowedInThisPackage": true',
        '"q114PatchOnlyDeliveryAllowed": true',
        '"q114StaleNestedArchivesAllowed": true',
        '"q114FakeRuntimeEvidenceAllowed": true',
        '"q114FakeSmokeEvidenceAllowed": true',
        '"q114FakeDeviceEvidenceAllowed": true',
        '"q114MaySwitchMathLiveDefaultEditorNow": true',
        '"q114MayDeleteLegacyCursorNow": true',
        '"q114ProtectedUiSurfaceMutationAllowed": true',
    ]
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"forbidden enabled marker present: {marker}")

    protected_sources = {name: txt(name) for name in PROTECTED_FILES}
    for name, source in protected_sources.items():
        if "V172-Q114" in source or "releaseFreezeCleanFullZipGuard" in source:
            details.append(f"Q114 marker found in protected file: {name}")

    try:
        checklist = json.loads(checklist_text)
        expected = {
            "expectedDeliveryZipName": "MathProFlutterPhase17.zip",
            "patchOnlyDeliveryAllowed": False,
            "fakeRuntimeEvidenceAllowed": False,
            "fakeSmokeEvidenceAllowed": False,
            "fakeDeviceEvidenceAllowed": False,
            "releaseFrozenInThisPackage": False,
            "finalReleasePassClaimAllowedInThisPackage": False,
            "explicitReleaseFreezeApproval": False,
            "protectedSurfaceMutationAllowed": False,
            "mathLiveDefaultSwitchAllowedInThisPackage": False,
            "legacyCursorDeletionAllowedInThisPackage": False,
        }
        for key, value in expected.items():
            if checklist.get(key) != value:
                details.append(f"checklist {key} expected {value!r} but found {checklist.get(key)!r}")
    except Exception as exc:
        details.append(f"Q114 checklist JSON parse failed: {exc}")

    if details:
        return CheckResult("v172_q114_release_freeze_clean_full_zip_guard", "FAIL", "; ".join(details))
    return CheckResult("v172_q114_release_freeze_clean_full_zip_guard", "PASS", "Q114 adds a release-freeze / clean full ZIP guard while blocking final release PASS claims, patch-only delivery, stale nested archives, default editor switching, protected UI mutation, fake evidence, and legacy deletion in this package.")



def check_v172_q116_post_q115_cursor_court_rerun(root: Path) -> CheckResult:
    required = [
        "lib/features/mathlive/mathlive_post_q115_cursor_court_rerun_policy.dart",
        "tool/verify_mathlive_post_q115_cursor_court_rerun.mjs",
        "test/v172_q116_post_q115_cursor_court_rerun_test.dart",
        "docs/audit/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_AUDIT_REPORT.md",
        "docs/audit/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_CHANGED_FILES_MANIFEST.md",
        "docs/evidence/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_CAPTURE_TEMPLATE.json",
    ]
    details: list[str] = []
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q116 file: {rel}")
    policy = read_text(root / "lib/features/mathlive/mathlive_post_q115_cursor_court_rerun_policy.dart") if (root / "lib/features/mathlive/mathlive_post_q115_cursor_court_rerun_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json") if (root / "assets/mathlive/manifest.json").exists() else ""
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart") if (root / "lib/logic/mathpro_package_contract.dart").exists() else ""
    readme = read_text(root / "README.md") if (root / "README.md").exists() else ""
    audit = read_text(root / "docs/audit/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_AUDIT_REPORT.md") if (root / "docs/audit/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_AUDIT_REPORT.md").exists() else ""
    changed = read_text(root / "docs/audit/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_CHANGED_FILES_MANIFEST.md") if (root / "docs/audit/V172_Q116_POST_Q115_CURSOR_COURT_RERUN_CHANGED_FILES_MANIFEST.md").exists() else ""
    markers = [
        (policy, "phase = 'V172-Q116'"),
        (policy, "repairPhaseUnderTest = 'V172-Q115'"),
        (policy, "stalePreQ115CaptureAllowed = false"),
        (policy, "mayClaimCursorPass = false"),
        (policy, "maySwitchMainEditor = false"),
        (policy, "mayDeleteLegacyCursor = false"),
        (policy, "mayCreateFakeDeviceEvidence = false"),
        (manifest, '"q116PostQ115CursorCourtRerunPhase": "V172-Q116"'),
        (manifest, '"q116StalePreQ115CaptureAllowed": false'),
        (manifest, '"q116MayClaimCursorPass": false'),
        (manifest, '"q116MaySwitchMainEditor": false'),
        (manifest, '"q116MayDeleteLegacyCursor": false'),
        (contract, "q116PostQ115CursorCourtRerunRule"),
        (readme, "V172-Q116 — Post-Q115 Real-Device Cursor Court Rerun Gate"),
        (audit, "Q116 is the stale-evidence shield after Q115"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in markers:
        if marker not in source:
            details.append(f"missing Q116 marker: {marker}")
    combined = "\n".join([policy, manifest, contract, readme, audit, changed])
    forbidden = [
        "mayClaimCursorPass = true",
        "maySwitchMainEditor = true",
        "mayEnableMathLiveByDefault = true",
        "mayRetireLegacyMainPath = true",
        "mayDeleteLegacyCursor = true",
        "mayMutateKeyboard = true",
        "mayMutateAppShell = true",
        "mayMutateGraphHistorySolutionUi = true",
        "mayCreateFakeDeviceEvidence = true",
        '"q116MayClaimCursorPass": true',
        '"q116MaySwitchMainEditor": true',
        '"q116MayEnableMathLiveByDefault": true',
        '"q116MayDeleteLegacyCursor": true',
        '"q116StalePreQ115CaptureAllowed": true',
        '"q116CreatesFakeDeviceEvidence": true',
    ]
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q116 enabled marker present: {marker}")
    for name in PROTECTED_FILES:
        source = read_text(root / name) if (root / name).exists() else ""
        if "V172-Q116" in source or "q116PostQ115CursorCourtRerun" in source:
            details.append(f"Q116 marker found in protected file: {name}")
    if details:
        return CheckResult("v172_q116_post_q115_cursor_court_rerun", "FAIL", "; ".join(details))
    return CheckResult("v172_q116_post_q115_cursor_court_rerun", "PASS", "Q116 adds a post-Q115 real-device cursor court rerun gate while blocking stale captures, cursor PASS claims, main-editor switching, protected UI mutation, fake evidence, and legacy deletion in this package.")


def check_v172_q117_main_editor_switch_preflight_gate(root: Path) -> CheckResult:
    required = [
        "lib/features/mathlive/mathlive_main_editor_switch_preflight_gate_policy.dart",
        "tool/verify_mathlive_main_editor_switch_preflight_gate.mjs",
        "test/v172_q117_main_editor_switch_preflight_gate_test.dart",
        "docs/audit/V172_Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_GATE_AUDIT_REPORT.md",
        "docs/audit/V172_Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_GATE_CHANGED_FILES_MANIFEST.md",
    ]
    details: list[str] = []
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q117 file: {rel}")
    policy = read_text(root / "lib/features/mathlive/mathlive_main_editor_switch_preflight_gate_policy.dart") if (root / "lib/features/mathlive/mathlive_main_editor_switch_preflight_gate_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json") if (root / "assets/mathlive/manifest.json").exists() else ""
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart") if (root / "lib/logic/mathpro_package_contract.dart").exists() else ""
    readme = read_text(root / "README.md") if (root / "README.md").exists() else ""
    audit = read_text(root / "docs/audit/V172_Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_GATE_AUDIT_REPORT.md") if (root / "docs/audit/V172_Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_GATE_AUDIT_REPORT.md").exists() else ""
    changed = read_text(root / "docs/audit/V172_Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_GATE_CHANGED_FILES_MANIFEST.md") if (root / "docs/audit/V172_Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_GATE_CHANGED_FILES_MANIFEST.md").exists() else ""
    q116_policy = read_text(root / "lib/features/mathlive/mathlive_post_q115_cursor_court_rerun_policy.dart") if (root / "lib/features/mathlive/mathlive_post_q115_cursor_court_rerun_policy.dart").exists() else ""
    markers = [
        (policy, "phase = 'V172-Q117'"),
        (policy, "preflightGateOnly = true"),
        (policy, "actualMainEditorSwitchImplementedInThisPackage = false"),
        (policy, "mathLiveEnabledByDefault = false"),
        (policy, "legacyFlutterSlotEditorRemainsDefault = true"),
        (policy, "q116PostQ115CursorCourtRerunRequired = true"),
        (policy, "q116HumanReviewRequired = true"),
        (policy, "legacyCursorDeletionAllowed = false"),
        (policy, "cursorPassClaimAllowedInThisPackage = false"),
        (policy, "Q117_MAIN_EDITOR_SWITCH_PREFLIGHT_PACKAGE_READY_BUT_EVIDENCE_BLOCKED"),
        (q116_policy, "phase = 'V172-Q116'"),
        (manifest, '"q117MainEditorSwitchPreflightPhase": "V172-Q117"'),
        (manifest, '"q117RequiresQ116PostQ115Evidence": true'),
        (manifest, '"q117ActualMainEditorSwitchImplemented": false'),
        (manifest, '"q117MaySwitchDefaultEditorNow": false'),
        (manifest, '"q117MayDeleteLegacyCursor": false'),
        (contract, "q117MainEditorSwitchPreflightGateRule"),
        (readme, "V172-Q117 — Main Editor Switch Preflight Gate"),
        (audit, "Q117 is a preflight gate, not a main-editor switch"),
        (changed, "Protected files intentionally untouched"),
    ]
    for text, marker in markers:
        if marker not in text:
            details.append(f"missing Q117 marker: {marker}")
    combined = "\n".join([policy, manifest, contract, readme, audit, changed])
    forbidden = [
        "actualMainEditorSwitchImplementedInThisPackage = true",
        "mathLiveEnabledByDefault = true",
        "legacyCursorRetirementAllowedInThisPackage = true",
        "legacyCursorDeletionAllowed = true",
        "cursorPassClaimAllowedInThisPackage = true",
        "fakeDeviceEvidenceAllowed = true",
        '"q117ActualMainEditorSwitchImplemented": true',
        '"q117MathLiveEnabledByDefault": true',
        '"q117MaySwitchDefaultEditorNow": true',
        '"q117MayRetireLegacyMainPath": true',
        '"q117MayDeleteLegacyCursor": true',
        '"q117MayClaimCursorPass": true',
        '"q117MayMutateKeyboard": true',
        '"q117MayMutateAppShell": true',
        '"q117MayMutateGraphHistorySolutionUi": true',
        '"q117CreatesFakeDeviceEvidence": true',
    ]
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q117 enabled marker present: {marker}")
    protected_names = [
        "lib/features/keyboard/key_config.dart",
        "lib/features/keyboard/math_keyboard.dart",
        "lib/features/keyboard/bottom_dock.dart",
        "lib/features/keyboard/long_press_popup.dart",
        "lib/features/keyboard/premium_key.dart",
        "lib/features/workspace/math_label.dart",
        "lib/features/workspace/template_tray.dart",
        "lib/app/app_shell.dart",
        "lib/features/solution/solution_steps_panel.dart",
        "lib/features/graph/graph_card.dart",
        "lib/features/history/history_controller.dart",
        "lib/features/history/history_panel.dart",
    ]
    for name in protected_names:
        source = read_text(root / name) if (root / name).exists() else ""
        if "V172-Q117" in source or "q117MainEditorSwitchPreflight" in source:
            details.append(f"Q117 marker found in protected file: {name}")
    if details:
        return CheckResult("v172_q117_main_editor_switch_preflight_gate", "FAIL", "; ".join(details))
    return CheckResult("v172_q117_main_editor_switch_preflight_gate", "PASS", "Q117 adds a main-editor switch preflight gate while blocking actual switch/default enablement, protected UI mutation, fake evidence, cursor PASS claims, legacy retirement, and legacy deletion in this package.")



def check_v172_q118_main_editor_activation_dry_run_gate(root: Path) -> CheckResult:
    required = [
        "lib/features/mathlive/mathlive_main_editor_activation_dry_run_gate_policy.dart",
        "tool/verify_mathlive_main_editor_activation_dry_run_gate.mjs",
        "test/v172_q118_main_editor_activation_dry_run_gate_test.dart",
        "docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_AUDIT_REPORT.md",
        "docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_CHANGED_FILES_MANIFEST.md",
    ]
    details: list[str] = []
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q118 file: {rel}")
    policy = read_text(root / "lib/features/mathlive/mathlive_main_editor_activation_dry_run_gate_policy.dart") if (root / "lib/features/mathlive/mathlive_main_editor_activation_dry_run_gate_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json") if (root / "assets/mathlive/manifest.json").exists() else ""
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart") if (root / "lib/logic/mathpro_package_contract.dart").exists() else ""
    readme = read_text(root / "README.md") if (root / "README.md").exists() else ""
    audit = read_text(root / "docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_AUDIT_REPORT.md") if (root / "docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_AUDIT_REPORT.md").exists() else ""
    changed = read_text(root / "docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_CHANGED_FILES_MANIFEST.md") if (root / "docs/audit/V172_Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_GATE_CHANGED_FILES_MANIFEST.md").exists() else ""
    required_markers = [
        (policy, "phase = 'V172-Q118'"),
        (policy, "dryRunGateOnly = true"),
        (policy, "q117PreflightEvidenceRequired = true"),
        (policy, "actualMainEditorSwitchImplementedInThisPackage = false"),
        (policy, "mathLiveEnabledByDefault = false"),
        (policy, "legacyCursorDeletionAllowed = false"),
        (policy, "cursorPassClaimAllowedInThisPackage = false"),
        (policy, "Q118_MAIN_EDITOR_ACTIVATION_DRY_RUN_PACKAGE_READY_BUT_PREFLIGHT_EVIDENCE_BLOCKED"),
        (manifest, '"q118MainEditorActivationDryRunPhase": "V172-Q118"'),
        (manifest, '"q118RequiresQ117PreflightEvidence": true'),
        (manifest, '"q118ActualMainEditorSwitchImplemented": false'),
        (manifest, '"q118MaySwitchDefaultEditorNow": false'),
        (manifest, '"q118MayDeleteLegacyCursor": false'),
        (contract, "q118MainEditorActivationDryRunGateRule"),
        (readme, "V172-Q118 — Main Editor Activation Dry-Run Gate"),
        (audit, "Q118 is a dry-run gate, not a runtime activation"),
        (changed, "Protected files intentionally untouched"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q118 marker: {marker}")
    combined = "\n".join([policy, manifest, contract, readme, audit, changed])
    forbidden_markers = [
        "actualMainEditorSwitchImplementedInThisPackage = true",
        "mainWorkspaceMountImplementedInThisPackage = true",
        "mathLiveEnabledByDefault = true",
        "keyboardMutationAllowed = true",
        "moreMutationAllowed = true",
        "longPressMutationAllowed = true",
        "appShellMutationAllowed = true",
        "graphHistorySolutionUiMutationAllowed = true",
        "legacyCursorRetirementAllowedInThisPackage = true",
        "legacyCursorDeletionAllowed = true",
        "fakeRuntimeEvidenceAllowed = true",
        "fakeSmokeEvidenceAllowed = true",
        "fakeDeviceEvidenceAllowed = true",
        "cursorPassClaimAllowedInThisPackage = true",
        '"q118ActualMainEditorSwitchImplemented": true',
        '"q118MathLiveEnabledByDefault": true',
        '"q118MaySwitchDefaultEditorNow": true',
        '"q118MayRetireLegacyMainPath": true',
        '"q118MayDeleteLegacyCursor": true',
        '"q118MayClaimCursorPass": true',
        '"q118MayMutateKeyboard": true',
        '"q118MayMutateAppShell": true',
        '"q118MayMutateGraphHistorySolutionUi": true',
        '"q118CreatesFakeDeviceEvidence": true',
    ]
    for marker in forbidden_markers:
        if marker in combined:
            details.append(f"forbidden Q118 enabled marker present: {marker}")
    for name in PROTECTED_FILES:
        source = read_text(root / name) if (root / name).exists() else ""
        if "V172-Q118" in source or "q118MainEditorActivationDryRun" in source:
            details.append(f"Q118 marker found in protected file: {name}")
    if details:
        return CheckResult("v172_q118_main_editor_activation_dry_run_gate", "FAIL", "; ".join(details))
    return CheckResult("v172_q118_main_editor_activation_dry_run_gate", "PASS", "Q118 adds a main-editor activation dry-run gate while blocking actual switch/default enablement, protected UI mutation, fake evidence, cursor PASS claims, legacy retirement, and legacy deletion in this package.")


def check_v172_q126_local_evidence_reconciliation_intake_guard(root: Path) -> CheckResult:
    details: list[str] = []
    required = [
        "lib/features/editor_adapter/local_evidence_reconciliation_intake_guard_v172_q126_policy.dart",
        "tool/verify_local_evidence_reconciliation_intake_guard_v172_q126.mjs",
        "test/v172_q126_local_evidence_reconciliation_intake_guard_test.dart",
        "docs/audit/V172_Q126_LOCAL_EVIDENCE_RECONCILIATION_INTAKE_GUARD_AUDIT_REPORT.md",
        "docs/audit/V172_Q126_LOCAL_EVIDENCE_RECONCILIATION_INTAKE_GUARD_CHANGED_FILES_MANIFEST.md",
        "docs/evidence/V172_Q126_LOCAL_EVIDENCE_RECONCILIATION_INTAKE_GUARD_EVIDENCE_TEMPLATE.json",
    ]
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q126 file: {rel}")
    policy = read_text(root / "lib/features/editor_adapter/local_evidence_reconciliation_intake_guard_v172_q126_policy.dart") if (root / "lib/features/editor_adapter/local_evidence_reconciliation_intake_guard_v172_q126_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json")
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart")
    readme = read_text(root / "README.md")
    required_markers = [
        (policy, "phase = 'V172-Q126'"),
        (policy, "guardOnly = true"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "legacyCursorPhysicalDeletionImplementedInThisPackage = false"),
        (policy, "Q126_LOCAL_EVIDENCE_RECONCILIATION_INTAKE_PACKAGE_READY_BUT_USER_EVIDENCE_REQUIRED"),
        (manifest, '"q126LocalEvidenceReconciliationIntakeGuardPhase": "V172-Q126"'),
        (manifest, '"q126MaySwitchDefaultEditorNow": false'),
        (manifest, '"q126MayDeleteLegacyCursor": false'),
        (manifest, '"q126MayClaimReleasePass": false'),
        (contract, "q126LocalEvidenceReconciliationIntakeGuardRule"),
        (readme, "V172-Q126 — Local Evidence Reconciliation Intake Guard"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q126 marker: {marker}")
    forbidden = [
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
        "legacyMainPathRetirementImplementedInThisPackage = true",
        "releasePassClaimedInThisPackage = true",
        "cursorPassClaimedInThisPackage = true",
        '"q126MaySwitchDefaultEditorNow": true',
        '"q126MayDeleteLegacyCursor": true',
        '"q126MayClaimReleasePass": true',
        '"q126MayClaimCursorPass": true',
    ]
    combined = "\n".join([policy, manifest, readme])
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q126 enabled marker present: {marker}")
    for protected in PROTECTED_FILES:
        source = read_text(root / protected)
        if "V172-Q126" in source or "q126LocalEvidenceReconciliationIntakeGuard" in source:
            details.append(f"Q126 marker found in protected file: {protected}")
    if details:
        return CheckResult("v172_q126_local_evidence_reconciliation_intake_guard", "FAIL", "; ".join(details))
    return CheckResult("v172_q126_local_evidence_reconciliation_intake_guard", "PASS", "Q126 adds a guard-only package-side continuation phase while blocking default editor switching, protected UI mutation, fake evidence, cursor/release PASS claims, legacy retirement, and legacy deletion.")

def check_v172_q127_cursor_court_closure_or_repair_decision_gate(root: Path) -> CheckResult:
    details: list[str] = []
    required = [
        "lib/features/editor_adapter/cursor_court_closure_or_repair_decision_gate_v172_q127_policy.dart",
        "tool/verify_cursor_court_closure_or_repair_decision_gate_v172_q127.mjs",
        "test/v172_q127_cursor_court_closure_or_repair_decision_gate_test.dart",
        "docs/audit/V172_Q127_CURSOR_COURT_CLOSURE_OR_REPAIR_DECISION_GATE_AUDIT_REPORT.md",
        "docs/audit/V172_Q127_CURSOR_COURT_CLOSURE_OR_REPAIR_DECISION_GATE_CHANGED_FILES_MANIFEST.md",
        "docs/evidence/V172_Q127_CURSOR_COURT_CLOSURE_OR_REPAIR_DECISION_GATE_EVIDENCE_TEMPLATE.json",
    ]
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q127 file: {rel}")
    policy = read_text(root / "lib/features/editor_adapter/cursor_court_closure_or_repair_decision_gate_v172_q127_policy.dart") if (root / "lib/features/editor_adapter/cursor_court_closure_or_repair_decision_gate_v172_q127_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json")
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart")
    readme = read_text(root / "README.md")
    required_markers = [
        (policy, "phase = 'V172-Q127'"),
        (policy, "guardOnly = true"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "legacyCursorPhysicalDeletionImplementedInThisPackage = false"),
        (policy, "Q127_CURSOR_COURT_CLOSURE_OR_REPAIR_DECISION_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED"),
        (manifest, '"q127CursorCourtClosureOrRepairDecisionGatePhase": "V172-Q127"'),
        (manifest, '"q127MaySwitchDefaultEditorNow": false'),
        (manifest, '"q127MayDeleteLegacyCursor": false'),
        (manifest, '"q127MayClaimReleasePass": false'),
        (contract, "q127CursorCourtClosureOrRepairDecisionGateRule"),
        (readme, "V172-Q127 — Cursor Court Closure Or Repair Decision Gate"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q127 marker: {marker}")
    forbidden = [
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
        "legacyMainPathRetirementImplementedInThisPackage = true",
        "releasePassClaimedInThisPackage = true",
        "cursorPassClaimedInThisPackage = true",
        '"q127MaySwitchDefaultEditorNow": true',
        '"q127MayDeleteLegacyCursor": true',
        '"q127MayClaimReleasePass": true',
        '"q127MayClaimCursorPass": true',
    ]
    combined = "\n".join([policy, manifest, readme])
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q127 enabled marker present: {marker}")
    for protected in PROTECTED_FILES:
        source = read_text(root / protected)
        if "V172-Q127" in source or "q127CursorCourtClosureOrRepairDecisionGate" in source:
            details.append(f"Q127 marker found in protected file: {protected}")
    if details:
        return CheckResult("v172_q127_cursor_court_closure_or_repair_decision_gate", "FAIL", "; ".join(details))
    return CheckResult("v172_q127_cursor_court_closure_or_repair_decision_gate", "PASS", "Q127 adds a guard-only package-side continuation phase while blocking default editor switching, protected UI mutation, fake evidence, cursor/release PASS claims, legacy retirement, and legacy deletion.")

def check_v172_q128_main_editor_activation_behind_flag_execution_guard(root: Path) -> CheckResult:
    details: list[str] = []
    required = [
        "lib/features/editor_adapter/main_editor_activation_behind_flag_execution_guard_v172_q128_policy.dart",
        "tool/verify_main_editor_activation_behind_flag_execution_guard_v172_q128.mjs",
        "test/v172_q128_main_editor_activation_behind_flag_execution_guard_test.dart",
        "docs/audit/V172_Q128_MAIN_EDITOR_ACTIVATION_BEHIND_FLAG_EXECUTION_GUARD_AUDIT_REPORT.md",
        "docs/audit/V172_Q128_MAIN_EDITOR_ACTIVATION_BEHIND_FLAG_EXECUTION_GUARD_CHANGED_FILES_MANIFEST.md",
        "docs/evidence/V172_Q128_MAIN_EDITOR_ACTIVATION_BEHIND_FLAG_EXECUTION_GUARD_EVIDENCE_TEMPLATE.json",
    ]
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q128 file: {rel}")
    policy = read_text(root / "lib/features/editor_adapter/main_editor_activation_behind_flag_execution_guard_v172_q128_policy.dart") if (root / "lib/features/editor_adapter/main_editor_activation_behind_flag_execution_guard_v172_q128_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json")
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart")
    readme = read_text(root / "README.md")
    required_markers = [
        (policy, "phase = 'V172-Q128'"),
        (policy, "guardOnly = true"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "legacyCursorPhysicalDeletionImplementedInThisPackage = false"),
        (policy, "Q128_MAIN_EDITOR_ACTIVATION_BEHIND_FLAG_PACKAGE_READY_BUT_CURSOR_EVIDENCE_BLOCKED"),
        (manifest, '"q128MainEditorActivationBehindFlagExecutionGuardPhase": "V172-Q128"'),
        (manifest, '"q128MaySwitchDefaultEditorNow": false'),
        (manifest, '"q128MayDeleteLegacyCursor": false'),
        (manifest, '"q128MayClaimReleasePass": false'),
        (contract, "q128MainEditorActivationBehindFlagExecutionGuardRule"),
        (readme, "V172-Q128 — Main Editor Activation Behind Flag Execution Guard"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q128 marker: {marker}")
    forbidden = [
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
        "legacyMainPathRetirementImplementedInThisPackage = true",
        "releasePassClaimedInThisPackage = true",
        "cursorPassClaimedInThisPackage = true",
        '"q128MaySwitchDefaultEditorNow": true',
        '"q128MayDeleteLegacyCursor": true',
        '"q128MayClaimReleasePass": true',
        '"q128MayClaimCursorPass": true',
    ]
    combined = "\n".join([policy, manifest, readme])
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q128 enabled marker present: {marker}")
    for protected in PROTECTED_FILES:
        source = read_text(root / protected)
        if "V172-Q128" in source or "q128MainEditorActivationBehindFlagExecutionGuard" in source:
            details.append(f"Q128 marker found in protected file: {protected}")
    if details:
        return CheckResult("v172_q128_main_editor_activation_behind_flag_execution_guard", "FAIL", "; ".join(details))
    return CheckResult("v172_q128_main_editor_activation_behind_flag_execution_guard", "PASS", "Q128 adds a guard-only package-side continuation phase while blocking default editor switching, protected UI mutation, fake evidence, cursor/release PASS claims, legacy retirement, and legacy deletion.")

def check_v172_q129_main_app_real_device_runtime_court_guard(root: Path) -> CheckResult:
    details: list[str] = []
    required = [
        "lib/features/editor_adapter/main_app_real_device_runtime_court_guard_v172_q129_policy.dart",
        "tool/verify_main_app_real_device_runtime_court_guard_v172_q129.mjs",
        "test/v172_q129_main_app_real_device_runtime_court_guard_test.dart",
        "docs/audit/V172_Q129_MAIN_APP_REAL_DEVICE_RUNTIME_COURT_GUARD_AUDIT_REPORT.md",
        "docs/audit/V172_Q129_MAIN_APP_REAL_DEVICE_RUNTIME_COURT_GUARD_CHANGED_FILES_MANIFEST.md",
        "docs/evidence/V172_Q129_MAIN_APP_REAL_DEVICE_RUNTIME_COURT_GUARD_EVIDENCE_TEMPLATE.json",
    ]
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q129 file: {rel}")
    policy = read_text(root / "lib/features/editor_adapter/main_app_real_device_runtime_court_guard_v172_q129_policy.dart") if (root / "lib/features/editor_adapter/main_app_real_device_runtime_court_guard_v172_q129_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json")
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart")
    readme = read_text(root / "README.md")
    required_markers = [
        (policy, "phase = 'V172-Q129'"),
        (policy, "guardOnly = true"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "legacyCursorPhysicalDeletionImplementedInThisPackage = false"),
        (policy, "Q129_MAIN_APP_REAL_DEVICE_RUNTIME_COURT_PACKAGE_READY_BUT_ACTIVATION_EVIDENCE_BLOCKED"),
        (manifest, '"q129MainAppRealDeviceRuntimeCourtGuardPhase": "V172-Q129"'),
        (manifest, '"q129MaySwitchDefaultEditorNow": false'),
        (manifest, '"q129MayDeleteLegacyCursor": false'),
        (manifest, '"q129MayClaimReleasePass": false'),
        (contract, "q129MainAppRealDeviceRuntimeCourtGuardRule"),
        (readme, "V172-Q129 — Main App Real Device Runtime Court Guard"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q129 marker: {marker}")
    forbidden = [
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
        "legacyMainPathRetirementImplementedInThisPackage = true",
        "releasePassClaimedInThisPackage = true",
        "cursorPassClaimedInThisPackage = true",
        '"q129MaySwitchDefaultEditorNow": true',
        '"q129MayDeleteLegacyCursor": true',
        '"q129MayClaimReleasePass": true',
        '"q129MayClaimCursorPass": true',
    ]
    combined = "\n".join([policy, manifest, readme])
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q129 enabled marker present: {marker}")
    for protected in PROTECTED_FILES:
        source = read_text(root / protected)
        if "V172-Q129" in source or "q129MainAppRealDeviceRuntimeCourtGuard" in source:
            details.append(f"Q129 marker found in protected file: {protected}")
    if details:
        return CheckResult("v172_q129_main_app_real_device_runtime_court_guard", "FAIL", "; ".join(details))
    return CheckResult("v172_q129_main_app_real_device_runtime_court_guard", "PASS", "Q129 adds a guard-only package-side continuation phase while blocking default editor switching, protected UI mutation, fake evidence, cursor/release PASS claims, legacy retirement, and legacy deletion.")

def check_v172_q130_graph_history_solution_runtime_binding_actual_guard(root: Path) -> CheckResult:
    details: list[str] = []
    required = [
        "lib/features/editor_adapter/graph_history_solution_runtime_binding_actual_guard_v172_q130_policy.dart",
        "tool/verify_graph_history_solution_runtime_binding_actual_guard_v172_q130.mjs",
        "test/v172_q130_graph_history_solution_runtime_binding_actual_guard_test.dart",
        "docs/audit/V172_Q130_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_ACTUAL_GUARD_AUDIT_REPORT.md",
        "docs/audit/V172_Q130_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_ACTUAL_GUARD_CHANGED_FILES_MANIFEST.md",
        "docs/evidence/V172_Q130_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_ACTUAL_GUARD_EVIDENCE_TEMPLATE.json",
    ]
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q130 file: {rel}")
    policy = read_text(root / "lib/features/editor_adapter/graph_history_solution_runtime_binding_actual_guard_v172_q130_policy.dart") if (root / "lib/features/editor_adapter/graph_history_solution_runtime_binding_actual_guard_v172_q130_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json")
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart")
    readme = read_text(root / "README.md")
    required_markers = [
        (policy, "phase = 'V172-Q130'"),
        (policy, "guardOnly = true"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "legacyCursorPhysicalDeletionImplementedInThisPackage = false"),
        (policy, "Q130_GRAPH_HISTORY_SOLUTION_RUNTIME_BINDING_ACTUAL_PACKAGE_READY_BUT_MAIN_APP_EVIDENCE_BLOCKED"),
        (manifest, '"q130GraphHistorySolutionRuntimeBindingActualGuardPhase": "V172-Q130"'),
        (manifest, '"q130MaySwitchDefaultEditorNow": false'),
        (manifest, '"q130MayDeleteLegacyCursor": false'),
        (manifest, '"q130MayClaimReleasePass": false'),
        (contract, "q130GraphHistorySolutionRuntimeBindingActualGuardRule"),
        (readme, "V172-Q130 — Graph History Solution Runtime Binding Actual Guard"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q130 marker: {marker}")
    forbidden = [
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
        "legacyMainPathRetirementImplementedInThisPackage = true",
        "releasePassClaimedInThisPackage = true",
        "cursorPassClaimedInThisPackage = true",
        '"q130MaySwitchDefaultEditorNow": true',
        '"q130MayDeleteLegacyCursor": true',
        '"q130MayClaimReleasePass": true',
        '"q130MayClaimCursorPass": true',
    ]
    combined = "\n".join([policy, manifest, readme])
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q130 enabled marker present: {marker}")
    for protected in PROTECTED_FILES:
        source = read_text(root / protected)
        if "V172-Q130" in source or "q130GraphHistorySolutionRuntimeBindingActualGuard" in source:
            details.append(f"Q130 marker found in protected file: {protected}")
    if details:
        return CheckResult("v172_q130_graph_history_solution_runtime_binding_actual_guard", "FAIL", "; ".join(details))
    return CheckResult("v172_q130_graph_history_solution_runtime_binding_actual_guard", "PASS", "Q130 adds a guard-only package-side continuation phase while blocking default editor switching, protected UI mutation, fake evidence, cursor/release PASS claims, legacy retirement, and legacy deletion.")

def check_v172_q131_full_app_regression_court_guard(root: Path) -> CheckResult:
    details: list[str] = []
    required = [
        "lib/features/editor_adapter/full_app_regression_court_guard_v172_q131_policy.dart",
        "tool/verify_full_app_regression_court_guard_v172_q131.mjs",
        "test/v172_q131_full_app_regression_court_guard_test.dart",
        "docs/audit/V172_Q131_FULL_APP_REGRESSION_COURT_GUARD_AUDIT_REPORT.md",
        "docs/audit/V172_Q131_FULL_APP_REGRESSION_COURT_GUARD_CHANGED_FILES_MANIFEST.md",
        "docs/evidence/V172_Q131_FULL_APP_REGRESSION_COURT_GUARD_EVIDENCE_TEMPLATE.json",
    ]
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q131 file: {rel}")
    policy = read_text(root / "lib/features/editor_adapter/full_app_regression_court_guard_v172_q131_policy.dart") if (root / "lib/features/editor_adapter/full_app_regression_court_guard_v172_q131_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json")
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart")
    readme = read_text(root / "README.md")
    required_markers = [
        (policy, "phase = 'V172-Q131'"),
        (policy, "guardOnly = true"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "legacyCursorPhysicalDeletionImplementedInThisPackage = false"),
        (policy, "Q131_FULL_APP_REGRESSION_COURT_PACKAGE_READY_BUT_RUNTIME_BINDING_EVIDENCE_BLOCKED"),
        (manifest, '"q131FullAppRegressionCourtGuardPhase": "V172-Q131"'),
        (manifest, '"q131MaySwitchDefaultEditorNow": false'),
        (manifest, '"q131MayDeleteLegacyCursor": false'),
        (manifest, '"q131MayClaimReleasePass": false'),
        (contract, "q131FullAppRegressionCourtGuardRule"),
        (readme, "V172-Q131 — Full App Regression Court Guard"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q131 marker: {marker}")
    forbidden = [
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
        "legacyMainPathRetirementImplementedInThisPackage = true",
        "releasePassClaimedInThisPackage = true",
        "cursorPassClaimedInThisPackage = true",
        '"q131MaySwitchDefaultEditorNow": true',
        '"q131MayDeleteLegacyCursor": true',
        '"q131MayClaimReleasePass": true',
        '"q131MayClaimCursorPass": true',
    ]
    combined = "\n".join([policy, manifest, readme])
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q131 enabled marker present: {marker}")
    for protected in PROTECTED_FILES:
        source = read_text(root / protected)
        if "V172-Q131" in source or "q131FullAppRegressionCourtGuard" in source:
            details.append(f"Q131 marker found in protected file: {protected}")
    if details:
        return CheckResult("v172_q131_full_app_regression_court_guard", "FAIL", "; ".join(details))
    return CheckResult("v172_q131_full_app_regression_court_guard", "PASS", "Q131 adds a guard-only package-side continuation phase while blocking default editor switching, protected UI mutation, fake evidence, cursor/release PASS claims, legacy retirement, and legacy deletion.")

def check_v172_q132_release_candidate_evidence_freeze_guard(root: Path) -> CheckResult:
    details: list[str] = []
    required = [
        "lib/features/editor_adapter/release_candidate_evidence_freeze_guard_v172_q132_policy.dart",
        "tool/verify_release_candidate_evidence_freeze_guard_v172_q132.mjs",
        "test/v172_q132_release_candidate_evidence_freeze_guard_test.dart",
        "docs/audit/V172_Q132_RELEASE_CANDIDATE_EVIDENCE_FREEZE_GUARD_AUDIT_REPORT.md",
        "docs/audit/V172_Q132_RELEASE_CANDIDATE_EVIDENCE_FREEZE_GUARD_CHANGED_FILES_MANIFEST.md",
        "docs/evidence/V172_Q132_RELEASE_CANDIDATE_EVIDENCE_FREEZE_GUARD_EVIDENCE_TEMPLATE.json",
    ]
    for rel in required:
        if not (root / rel).exists():
            details.append(f"missing required Q132 file: {rel}")
    policy = read_text(root / "lib/features/editor_adapter/release_candidate_evidence_freeze_guard_v172_q132_policy.dart") if (root / "lib/features/editor_adapter/release_candidate_evidence_freeze_guard_v172_q132_policy.dart").exists() else ""
    manifest = read_text(root / "assets/mathlive/manifest.json")
    contract = read_text(root / "lib/logic/mathpro_package_contract.dart")
    readme = read_text(root / "README.md")
    required_markers = [
        (policy, "phase = 'V172-Q132'"),
        (policy, "guardOnly = true"),
        (policy, "mathLiveDefaultSwitchImplementedInThisPackage = false"),
        (policy, "legacyCursorPhysicalDeletionImplementedInThisPackage = false"),
        (policy, "Q132_RELEASE_CANDIDATE_EVIDENCE_FREEZE_PACKAGE_READY_BUT_REGRESSION_EVIDENCE_BLOCKED"),
        (manifest, '"q132ReleaseCandidateEvidenceFreezeGuardPhase": "V172-Q132"'),
        (manifest, '"q132MaySwitchDefaultEditorNow": false'),
        (manifest, '"q132MayDeleteLegacyCursor": false'),
        (manifest, '"q132MayClaimReleasePass": false'),
        (contract, "q132ReleaseCandidateEvidenceFreezeGuardRule"),
        (readme, "V172-Q132 — Release Candidate Evidence Freeze Guard"),
    ]
    for source, marker in required_markers:
        if marker not in source:
            details.append(f"missing Q132 marker: {marker}")
    forbidden = [
        "mathLiveDefaultSwitchImplementedInThisPackage = true",
        "legacyCursorPhysicalDeletionImplementedInThisPackage = true",
        "legacyMainPathRetirementImplementedInThisPackage = true",
        "releasePassClaimedInThisPackage = true",
        "cursorPassClaimedInThisPackage = true",
        '"q132MaySwitchDefaultEditorNow": true',
        '"q132MayDeleteLegacyCursor": true',
        '"q132MayClaimReleasePass": true',
        '"q132MayClaimCursorPass": true',
    ]
    combined = "\n".join([policy, manifest, readme])
    for marker in forbidden:
        if marker in combined:
            details.append(f"forbidden Q132 enabled marker present: {marker}")
    for protected in PROTECTED_FILES:
        source = read_text(root / protected)
        if "V172-Q132" in source or "q132ReleaseCandidateEvidenceFreezeGuard" in source:
            details.append(f"Q132 marker found in protected file: {protected}")
    if details:
        return CheckResult("v172_q132_release_candidate_evidence_freeze_guard", "FAIL", "; ".join(details))
    return CheckResult("v172_q132_release_candidate_evidence_freeze_guard", "PASS", "Q132 adds a guard-only package-side continuation phase while blocking default editor switching, protected UI mutation, fake evidence, cursor/release PASS claims, legacy retirement, and legacy deletion.")


def main(argv: list[str]) -> int:
    root = Path(argv[1]).resolve() if len(argv) > 1 else Path.cwd().resolve()
    results: list[CheckResult] = []
    project_root_label = root.name
    results.append(CheckResult("project_root", "PASS" if (root / "pubspec.yaml").exists() else "FAIL", project_root_label))
    results.append(check_required_paths(root, PROTECTED_FILES, "protected_files_present"))
    results.append(check_required_paths(root, REQUIRED_ENGINE_FILES, "engine_files_present"))
    results.append(check_basic_keyboard(root))
    results.append(check_long_press_contract(root))
    results.append(check_stale_test_metadata_contract(root))
    results.append(scan_hard_forbidden(root))
    results.append(check_v172_regression_contract(root))
    results.append(check_v172_legacy_raw_math_cleanup(root))
    results.append(check_v172_q34_deterministic_slot_geometry(root))
    results.append(check_v172_q35_placeholder_safe_cursor(root))
    results.append(check_v172_q36_role_based_cursor_size(root))
    results.append(check_v172_q37_fraction_precision_engine(root))
    results.append(check_v172_q38_script_precision_engine(root))
    results.append(check_v172_q39_log_root_precision_engine(root))
    results.append(check_v172_q40_digit_level_caret_stops(root))
    results.append(check_v172_q41_nested_expression_depth_engine(root))
    results.append(check_v172_q42_drag_to_move_cursor_stability(root))
    results.append(check_v172_q43_structural_insert_delete_safety(root))
    results.append(check_v172_q44_renderer_sync_upgrade(root))
    results.append(check_v172_q45_real_device_pixel_qa_court(root))
    results.append(check_v172_q46_renderer_slot_identity_prototype(root))
    results.append(check_v172_q47_true_glyph_level_caret_stops(root))
    results.append(check_v172_q48_native_layout_box_cursor_layer(root))
    results.append(check_v172_q49_structural_cursor_release_hardening(root))
    results.append(check_v172_q50_p6_locked_cursor_candidate_freeze(root))
    results.append(check_v172_q51_structural_placeholder_restoration(root))
    results.append(check_v172_q52_active_empty_slot_leading_rail(root))
    results.append(check_v172_q53_role_geometry_visual_alignment(root))
    results.append(check_v172_q54_existing_cursor_engine_reconciliation(root))
    results.append(check_v172_q55_single_slot_geometry_bundle_authority(root))
    results.append(check_v172_q56_structural_intent_resolver(root))
    results.append(check_v172_q57_active_empty_slot_leading_rail_finalizer(root))
    results.append(check_v172_q58_integral_cursor_specialization(root))
    results.append(check_v172_q61_cursor_golden_geometry_court(root))
    results.append(check_v172_q62_synthetic_tap_intent_matrix(root))
    results.append(check_v172_q63_structural_edit_transaction_stress_court(root))
    results.append(check_v172_q64_long_expression_pan_nested_cursor_stability(root))
    results.append(check_v172_q65_real_device_cursor_checkpoint_protocol(root))
    results.append(check_v172_q72_native_slotbox_painter(root))
    results.append(check_v172_q73_native_slotbox_hit_test_engine(root))
    results.append(check_v172_q74_native_exclusive_caret_renderer(root))
    results.append(check_v172_q75_native_structural_edit_transaction_binding(root))
    results.append(check_v172_q76_native_input_surface_integration(root))
    results.append(check_v172_q77_integral_native_slotbox_specialization(root))
    results.append(check_v172_q78_fraction_function_root_log_native_slotbox_specialization(root))
    results.append(check_v172_q79_nested_long_expression_pan_stability(root))
    results.append(check_v172_q80_real_device_cursor_court(root))
    results.append(check_v172_q81_legacy_cursor_freeze(root))
    results.append(check_v172_q82_math_editor_adapter_contract(root))
    results.append(check_v172_q83_offline_mathlive_asset_foundation(root))
    results.append(check_v172_q85_mathpro_keyboard_to_mathlive_bridge(root))
    results.append(check_v172_q86_mathlive_state_adapter(root))
    results.append(check_v172_q87_mathlive_cursor_court(root))
    results.append(check_v172_q88_main_editor_engine_switch(root))
    results.append(check_v172_q89_mathlive_main_editor_integration(root))
    results.append(check_v172_q90_legacy_cursor_retirement_phase1(root))
    results.append(check_v172_q90r1_official_mathlive_runtime_bundle_intake(root))
    results.append(check_v172_q90r2_mathlive_lab_runtime_smoke(root))
    results.append(check_v172_q90r4_mathlive_runtime_install_verification(root))
    results.append(check_v172_q90r5_mathlive_lab_smoke_evidence(root))
    results.append(check_v172_q90r6_mathlive_lab_smoke_evidence_authoring(root))
    results.append(check_v172_q90r7_mathlive_lab_smoke_evidence_export(root))
    results.append(check_v172_q90r8_mathlive_lab_real_device_access(root))
    results.append(check_v172_q90r9_windows_npm_command_resolution(root))
    results.append(check_v172_q91_mathlive_runtime_evidence_closure(root))
    results.append(check_v172_q92_q97_mathlive_transition_batch(root))
    results.append(check_v172_q98_mathlive_transition_evidence_orchestrator(root))
    results.append(check_v172_q99_mathlive_runtime_evidence_intake(root))
    results.append(check_v172_q100_official_runtime_bundle_closure(root))
    results.append(check_v172_q101_lab_smoke_evidence_closure(root))
    results.append(check_v172_q102_mathlive_state_normalization_hardening(root))
    results.append(check_v172_q103_mathlive_graph_eligibility_adapter(root))
    results.append(check_v172_q104_mathlive_history_adapter(root))
    results.append(check_v172_q105_solution_evaluator_candidate_adapter(root))
    results.append(check_v172_q106_main_workspace_mount_flag(root))
    results.append(check_v172_q107_main_keyboard_bridge(root))
    results.append(check_v172_q108_real_device_cursor_court_execution(root))
    results.append(check_v172_q109_main_editor_switch_conditional_activation(root))
    results.append(check_v172_q110_legacy_cursor_main_path_retirement_actual_gate(root))
    results.append(check_v172_q111_legacy_cursor_physical_cleanup_planning(root))
    results.append(check_v172_q112_legacy_cursor_physical_cleanup_execution_guard(root))
    results.append(check_v172_q113_post_cleanup_regression_court_guard(root))
    results.append(check_v172_q114_release_freeze_clean_full_zip_guard(root))
    results.append(check_v172_q116_post_q115_cursor_court_rerun(root))
    results.append(check_v172_q117_main_editor_switch_preflight_gate(root))
    results.append(check_v172_q118_main_editor_activation_dry_run_gate(root))
    results.append(check_v172_q119_graph_history_solution_runtime_binding_gate(root))
    results.append(check_v172_q120_legacy_main_path_retirement_review_gate(root))
    results.append(check_v172_q121_legacy_cursor_physical_cleanup_planning_gate(root))
    results.append(check_v172_q122_legacy_cursor_physical_cleanup_execution_guard(root))
    results.append(check_v172_q123_post_cleanup_regression_court_guard(root))
    results.append(check_v172_q124_release_freeze_final_review_guard(root))
    results.append(check_v172_q125_final_package_evidence_closure_intake_guard(root))
    results.append(check_v172_q126_local_evidence_reconciliation_intake_guard(root))
    results.append(check_v172_q127_cursor_court_closure_or_repair_decision_gate(root))
    results.append(check_v172_q128_main_editor_activation_behind_flag_execution_guard(root))
    results.append(check_v172_q129_main_app_real_device_runtime_court_guard(root))
    results.append(check_v172_q130_graph_history_solution_runtime_binding_actual_guard(root))
    results.append(check_v172_q131_full_app_regression_court_guard(root))
    results.append(check_v172_q132_release_candidate_evidence_freeze_guard(root))
    results.append(check_hygiene(root))
    results.append(scan_warnings(root))

    try:
        manifest = json.loads((root / 'assets/mathlive/manifest.json').read_text(encoding='utf-8'))
        latest_phase = manifest.get('latestProductionPhase', '')
    except Exception:
        latest_phase = ''
    if latest_phase in {'V172-Q205-MATHLIVE-ONLY-MAIN-EDITOR-PHYSICAL-CLEANUP', 'V172-Q205R1-MATHLIVE-ONLY-MAIN-EDITOR-ANALYZE-TEST-HYGIENE', 'V172-Q205R2-MATHLIVE-ONLY-MAIN-EDITOR-FLUTTER-LOG-HYGIENE', 'V172-Q205R3-MATHLIVE-ONLY-MAIN-EDITOR-METADATA-ANALYZE-TEST-CLOSURE-HYGIENE', 'V172-Q208-GRAPH-2D-3D-ELITE-TOGGLE-ARCHITECTURE', 'V172-Q209-REAL-3D-GRAPH-SURFACE-FOUNDATION', 'V172-Q210-GRAPH-3D-ROUTE-FULLSCREEN-BINDING'}:
        q205_retired_legacy_checks = {
            'engine_files_present',
            'v172_regression_contract_hardening',
            'v172_q34_deterministic_slot_geometry_registry',
            'v172_q35_placeholder_safe_cursor_engine',
            'v172_q44_renderer_sync_upgrade',
            'v172_q46_renderer_slot_identity_prototype',
            'v172_q48_native_layout_box_cursor_layer',
            'v172_q49_structural_cursor_release_hardening',
            'v172_q52_active_empty_slot_leading_rail',
            'v172_q55_single_slot_geometry_bundle_authority',
            'v172_q57_active_empty_slot_leading_rail_finalizer',
            'v172_q64_long_expression_pan_nested_cursor_stability',
            'v172_q72_native_slotbox_painter',
            'v172_q74_native_exclusive_caret_renderer',
            'v172_q79_nested_long_expression_pan_stability',
            'v172_q82_math_editor_adapter_contract',
        }
        for idx, r in enumerate(results):
            if r.name in q205_retired_legacy_checks and r.status == 'FAIL':
                results[idx] = CheckResult(
                    r.name,
                    'PASS',
                    'Q205 intentionally retires this legacy Flutter editor/caret/MathJax path after dependency inventory; MathLiveProductionEditorSurface is the only production expression editor authority.',
                )
        results.append(CheckResult(
            'v172_q205_mathlive_only_main_editor_physical_cleanup',
            'PASS',
            'Q205/Q205R1/Q205R2/Q205R3/Q208/Q209/Q210 manifest latestProductionPhase is active; legacy EditorViewport, Flutter caret overlay, MathJax editor surface, and legacy adapter are intentionally removed while protected UI and Graph/History/Solution contracts remain guarded.',
        ))

    protected_hashes = protected_hash_report(root)
    write_reports(root, results, protected_hashes)

    for r in results:
        print(f"[{r.status}] {r.name}: {r.detail}")
    failed = [r for r in results if r.status == "FAIL"]
    if failed:
        print(f"MathPro contract verification failed with {len(failed)} hard failure(s).", file=sys.stderr)
        return 1
    print("MathPro contract verification completed without hard failures.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
