class MathProAllKeyLatencyCourtQ382R25Policy {
  const MathProAllKeyLatencyCourtQ382R25Policy._();

  static const String phase = 'V172-Q382R25';
  static const String contractMarker = 'q382r25-all-key-latency-court-and-inventory-active';

  // Q382R25 is a measurement/inventory phase only.  The court is inert unless
  // the developer explicitly opts into it with:
  // flutter run --dart-define=MATHPRO_LATENCY_COURT=true
  static const bool debugOnly = true;
  static const bool releaseCourtAllowed = false;
  static const bool performanceOptimizationAllowed = false;
  static const bool keyboardBehaviorChangeAllowed = false;
  static const bool mathLiveCommandSemanticsChangeAllowed = false;
  static const bool graphSolutionHistoryOcrAndroidChangeAllowed = false;
  static const bool panDragScrollReintroduced = false;

  static const bool enabledByDartDefine = bool.fromEnvironment(
    'MATHPRO_LATENCY_COURT',
    defaultValue: false,
  );

  static const Duration startupWarmup = Duration(milliseconds: 1650);
  static const Duration dispatchCadence = Duration(milliseconds: 135);
  static const int maxDirectBridgeEntriesPerRun = 240;

  static const bool includeMainKeyboardEntries = true;
  static const bool includeLongPressOptionEntries = true;
  static const bool includeMoreTemplateEntries = true;
  static const bool includeMoreCategoryEntriesInInventory = true;
  static const bool dispatchMoreCategoryEntries = false;
  static const bool dispatchDestructiveOrUiCommands = false;

  static const bool keyboardLayoutOrderLabelsUntouched = true;
  static const bool longPressListsUntouched = true;
  static const bool moreTemplateTrayInventoryUntouched = true;
  static const bool automaticManualPhoneSweepRequired = false;
  static const bool q382r32AllKeyLatencyClosureSummaryEnabled = true;
  static const bool q382r32TemplateMoreLongPressCoverageExpected = true;
}
