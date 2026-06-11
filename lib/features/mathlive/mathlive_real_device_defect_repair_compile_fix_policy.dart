/// V172-Q190R1 — Real Device Defect Repair Compile Fix.
///
/// Q190 correctly targeted the real Android freeze/render/bridge defect, but
/// its production helper methods were accidentally copied into the legacy
/// `_MathLiveMainEditorSurfaceState` class as well as the active production
/// `_MathLiveProductionEditorSurfaceState` class. That made the package unsafe
/// for `flutter analyze/build/run` because the legacy class could reference
/// production-only members such as `_productionCommandTail` and `_emitState`.
///
/// Q190R1 is not a new feature phase. It only scopes the Q190 production helper
/// methods back to the active production MathLive state class, tightens the JS
/// insert commit predicate, and documents the remaining requirement that a real
/// Flutter analyze/test/run pass must be produced on a Flutter-capable machine.
class MathLiveRealDeviceDefectRepairCompileFixPolicy {
  const MathLiveRealDeviceDefectRepairCompileFixPolicy._();

  static const String phase = 'V172-Q190R1';
  static const String baseline = 'V172-Q190_REAL_DEVICE_DEFECT_REPAIR_COMPILE_BLOCKED';
  static const String repairScope = 'production-helper-scope-and-insert-commit-predicate';

  static const bool newFeatureAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool graphControllerMutationAllowed = false;
  static const bool historyControllerMutationAllowed = false;
  static const bool historyPanelMutationAllowed = false;
  static const bool solutionStepsPanelMutationAllowed = false;
  static const bool solverMutationAllowed = false;

  static const bool productionHelpersScopedToProductionState = true;
  static const bool legacyMainEditorStateMustNotReferenceProductionTail = true;
  static const bool legacyMainEditorStateMustNotReferenceProductionEmitState = true;
  static const bool enqueueProductionCommandOnlyInProductionState = true;
  static const bool insertCommitRequiresActualDeltaWhenBeforeIsNonEmpty = true;
  static const bool emptyBeforeMayCommitToNonEmptyAfter = true;

  static const bool flutterAnalyzePassRequiredBeforeRelease = true;
  static const bool assistantFlutterAnalyzePassClaimed = false;
  static const bool androidRealDevicePassClaimed = false;
}
