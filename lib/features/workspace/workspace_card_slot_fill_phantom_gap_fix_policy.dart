/// V172-Q229R4 — Workspace Card Slot Fill / Phantom Gap Root Fix.
///
/// Guard-only policy for the root layout repair after Q229/Q229R2.  The parent
/// workspace slot and the visible question/result card must use the same
/// vertical contract: the card may keep small premium margins, but it must not
/// cap itself at legacy 292/316/348px heights while the parent slot is taller.
/// This phase does not authorize keyboard, MathLive, Graph engine, MORE
/// content, History, Solution engine, startup, or Android changes.
class WorkspaceCardSlotFillPhantomGapFixPolicy {
  const WorkspaceCardSlotFillPhantomGapFixPolicy._();

  static const String phase = 'V172-Q229R4-WORKSPACE-CARD-SLOT-FILL-PHANTOM-GAP-FIX';
  static const String rootCause = 'cardSlotHeight minus cardVisualHeight created phantom gap';
  static const bool keyboardLayoutMayChange = false;
  static const bool mathLiveProductionEditorMayChange = false;
  static const bool graphEngineMayChange = false;
  static const bool solutionEngineMayChange = false;
  static const bool moreTemplateTrayContentMayChange = false;
  static const bool appShellCoordinationMayChange = false;
  static const bool workspaceCardMayFillAllocatedSlot = true;
  static const bool legacyIdleCapsRemoved = true;
  static const bool legacyMoreCapsRemoved = true;
  static const bool legacyGraphCapsRemoved = true;
  static const double maxExpectedSlotVisualDeltaTallIdle = 13;
  static const double maxExpectedSlotVisualDeltaMore = 20;
  static const double maxExpectedSlotVisualDeltaGraph = 20;
  static const double maxExpectedSlotVisualDeltaSolution = 19;
  static const String protectedIntent =
      'Workspace card fills its allocated slot in Idle/MORE/Graph/Solution states; only small margin breathing remains.';
}
