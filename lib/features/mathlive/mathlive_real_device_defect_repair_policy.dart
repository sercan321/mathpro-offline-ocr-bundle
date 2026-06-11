/// V172-Q190 — Real Device Defect Repair.
///
/// Q189 failed on a real Android device: a single command/template could remain
/// visually stuck in the workspace, the example limit template appeared as a
/// half/raw `lim □` form, and subsequent MathPro key presses no longer flowed
/// reliably into the production MathLive surface. Q190 is not a new feature
/// phase. It only hardens the active production bridge/surface path so Android
/// WebView command dispatch cannot lock the editor after one template insert.
class MathLiveRealDeviceDefectRepairPolicy {
  const MathLiveRealDeviceDefectRepairPolicy._();

  static const String phase = 'V172-Q190';
  static const String failureSource = 'Q189_REAL_ANDROID_DEVICE_FAIL';
  static const String repairScope = 'production-mathlive-freeze-render-bridge-defect';

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

  static const bool productionSurfaceDispatchHardened = true;
  static const bool productionBridgeFireAndStatePush = true;
  static const bool androidReturningResultForKeypressesDisabled = true;
  static const bool commandDispatchSerialized = true;
  static const bool commandTimeoutPreventsQueueLock = true;
  static const bool insertCommitFallbackEnabled = true;
  static const bool postInsertStatePushRequired = true;
  static const bool clearMustPurgeMathLiveState = true;

  static const Duration androidBridgeCommandTimeout = Duration(milliseconds: 850);
  static const Duration androidBridgeTotalCommandBudget = Duration(milliseconds: 1250);
  static const Duration deferredStateRefreshDelay = Duration(milliseconds: 80);

  static const List<String> repairedFailureQuestions = <String>[
    'MathPro key press state neden takılıyor?',
    'Flutter command bus MathLive surface’e gerçekten her tuşta gidiyor mu?',
    'WebView JS bridge insertLatex çağrısı Android’de hata mı veriyor?',
    'insertLatex sonrası notifyFlutterState dönüyor mu?',
    'MathLive mathfield focus kaybediyor mu?',
    'Limit/fraction/sqrt/power/sigma/integral payload’ları editable template olarak gidiyor mu?',
    'Eski fallback/mirror/legacy render layer workspace’e görüntü basıyor mu?',
    'Tuştan sonra pressed/overlay state köprü kilidi yüzünden temizlenmiyor mu?',
    'Hata oluşunca komut kuyruğu kilitleniyor mu?',
    'C tuşu ve clear MathLive state’i temizliyor mu?',
  ];
}
