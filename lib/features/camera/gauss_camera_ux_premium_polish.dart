import 'gauss_camera_ux_premium_polish_policy.dart';

/// Static package-side descriptor for V172-Q243 premium camera UX polish.
///
/// The runtime camera shell reads only copy/contract constants from this class.
/// It does not execute OCR, does not download a model, and does not call the
/// MathLive production bridge.
class GaussCameraUxPremiumPolishContract {
  const GaussCameraUxPremiumPolishContract._();

  static const phase = GaussCameraUxPremiumPolishPolicy.phase;
  static const fullPhase = GaussCameraUxPremiumPolishPolicy.fullPhase;
  static const realOcrEngineAdded = false;
  static const productionMathLiveBridgeCalled = false;
  static const directSolveFromCameraAllowed = false;
  static const directWorkspaceImportImplemented = false;

  static const previewHeaderCopy = 'Formülü kadraja al';
  static const previewBodyCopy = 'Netlik, ışık ve hizalama kontrolü yap. Okuma motoru sonraki kanıtlı fazda bağlanacak.';
  static const cropHeaderCopy = 'Kalite kontrolü';
  static const cropBodyCopy = 'Kenarları, gölgeyi ve bulanıklığı kontrol et. Aday ifade önce MathLive review ekranına gidecek.';
  static const lowLightWarningCopy = 'Işık yetersizse flaşı aç veya gölgeyi azalt.';
  static const blurWarningCopy = 'Bulanıklık varsa telefonu sabitle ve tekrar çek.';
  static const alignmentWarningCopy = 'Formülü çerçeveye paralel yerleştir.';

  static const qualityRailLabels = GaussCameraUxPremiumPolishPolicy.qualityRailLabels;
  static const qualityRailHints = GaussCameraUxPremiumPolishPolicy.qualityRailHints;

  static bool get exposesPremiumGuidanceOnly => true;
  static bool get blocksDirectMathActions => true;
  static bool get preservesMathLiveReviewOnlyFlow => true;
  static bool get keepsCameraRuntimeCaptureOnly => true;
}
