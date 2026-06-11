import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'gauss_deferred_math_ocr_model_manager.dart';
import 'gauss_formula_crop_scan_frame_policy.dart';
import 'gauss_mathlive_ocr_review_surface.dart';
import 'gauss_real_camera_ocr_user_flow_binding_q378.dart';
import 'gauss_camera_ux_premium_polish.dart';

import '../../theme/mathpro_tokens.dart';
import '../../theme/mathpro_typography.dart';

/// V172-Q239B/Q239C/Q243 — Camera capture plus premium formula crop/scan-frame shell.
///
/// Q243 adds premium guidance copy, quality rail hints, and a cleaner camera
/// UX hierarchy without adding OCR, model runtime, direct MathLive import, or
/// solver handoff.
///
/// This screen previews the camera, lets the user take a photo, and then opens
/// a bounded formula crop-review surface. Q239C intentionally stops at crop
/// review metadata: it does not run OCR, does not mutate the MathLive editor,
/// and never sends camera output directly to the solver.
class GaussCameraCaptureShell extends StatefulWidget {
  const GaussCameraCaptureShell({
    super.key,
    this.onApprovedLatexImport,
  });

  final Future<void> Function(String approvedLatex)? onApprovedLatexImport;

  @override
  State<GaussCameraCaptureShell> createState() => _GaussCameraCaptureShellState();
}

class _GaussCameraCaptureShellState extends State<GaussCameraCaptureShell> {
  CameraController? _controller;
  List<CameraDescription> _cameras = const <CameraDescription>[];
  int _selectedCameraIndex = 0;
  bool _loading = true;
  bool _capturing = false;
  bool _torchEnabled = false;
  bool _cropReviewOpen = false;
  int _cropRotationQuarterTurns = 0;
  String? _errorMessage;
  XFile? _lastCapture;
  GaussMathOcrModelSnapshot _mathOcrModelSnapshot = GaussMathOcrModelSnapshot.initial();
  bool _mathOcrModelSnapshotLoading = true;
  bool _ocrUserFlowRunning = false;

  @override
  void initState() {
    super.initState();
    _bootstrapCamera();
    _loadMathOcrModelSnapshot();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _bootstrapCamera() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final cameras = await availableCameras();
      if (!mounted) return;
      if (cameras.isEmpty) {
        setState(() {
          _cameras = const <CameraDescription>[];
          _loading = false;
          _errorMessage = 'Bu cihazda kullanılabilir kamera bulunamadı.';
        });
        return;
      }

      _cameras = cameras;
      _selectedCameraIndex = _bestDefaultCameraIndex(cameras);
      await _attachCamera(cameras[_selectedCameraIndex]);
    } on CameraException catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _errorMessage = _cameraErrorCopy(error);
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _errorMessage = 'Kamera başlatılamadı. İzinleri ve cihaz kamerasını kontrol et.';
      });
    }
  }

  int _bestDefaultCameraIndex(List<CameraDescription> cameras) {
    final backIndex = cameras.indexWhere((camera) => camera.lensDirection == CameraLensDirection.back);
    return backIndex >= 0 ? backIndex : 0;
  }

  Future<void> _attachCamera(CameraDescription camera) async {
    final previous = _controller;
    _controller = null;
    await previous?.dispose();
    if (!mounted) return;

    final controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    setState(() {
      _loading = true;
      _errorMessage = null;
      _torchEnabled = false;
      _cropReviewOpen = false;
      _cropRotationQuarterTurns = 0;
      _lastCapture = null;
    });

    try {
      await controller.initialize();
      await controller.setFlashMode(FlashMode.off);
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _loading = false;
      });
    } on CameraException catch (error) {
      await controller.dispose();
      if (!mounted) return;
      setState(() {
        _loading = false;
        _errorMessage = _cameraErrorCopy(error);
      });
    } catch (_) {
      await controller.dispose();
      if (!mounted) return;
      setState(() {
        _loading = false;
        _errorMessage = 'Kamera önizlemesi hazırlanamadı.';
      });
    }
  }

  String _cameraErrorCopy(CameraException error) {
    switch (error.code) {
      case 'CameraAccessDenied':
      case 'CameraAccessDeniedWithoutPrompt':
      case 'CameraAccessRestricted':
        return 'Kamera izni verilmedi. Gauss içinde kamera ile ifade almak için kamera iznini açmalısın.';
      case 'AudioAccessDenied':
        return 'Ses izni gerekli değil; kamera yalnızca fotoğraf için başlatılıyor. Kamerayı tekrar açmayı dene.';
      default:
        return 'Kamera başlatılamadı: ${error.code}';
    }
  }
  Future<void> _loadMathOcrModelSnapshot() async {
    try {
      final snapshot = await GaussDeferredMathOcrModelManager.load();
      if (!mounted) return;
      setState(() {
        _mathOcrModelSnapshot = snapshot;
        _mathOcrModelSnapshotLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _mathOcrModelSnapshot = GaussMathOcrModelSnapshot.initial();
        _mathOcrModelSnapshotLoading = false;
      });
    }
  }

  Future<GaussMathOcrModelSnapshot> _installDeferredMathOcrModel(ValueChanged<GaussMathOcrModelSnapshot> onProgress) async {
    setState(() {
      _mathOcrModelSnapshotLoading = false;
    });
    final snapshot = await GaussDeferredMathOcrModelManager.installDeviceOnlyFormulaOcrBundleQ389R4Offline(
      onProgress: (progressSnapshot) {
        onProgress(progressSnapshot);
        if (!mounted) return;
        setState(() {
          _mathOcrModelSnapshot = progressSnapshot;
          _mathOcrModelSnapshotLoading = false;
        });
      },
    );
    if (!mounted) return snapshot;
    setState(() {
      _mathOcrModelSnapshot = snapshot;
      _mathOcrModelSnapshotLoading = false;
    });
    _showInlineNotice(
      snapshot.canRunOffline
          ? 'Offline Formula OCR paketi doğrulandı. Artık internet kapalıyken cihaz içi formula OCR denenir; sonuç review’den onayla workspace’e aktarılır.'
          : snapshot.productCopy,
    );
    return snapshot;
  }


  Future<void> _switchCamera() async {
    if (_cameras.length < 2 || _loading || _capturing) return;
    final nextIndex = (_selectedCameraIndex + 1) % _cameras.length;
    setState(() {
      _selectedCameraIndex = nextIndex;
    });
    await _attachCamera(_cameras[nextIndex]);
  }

  Future<void> _toggleTorch() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized || _loading || _capturing) return;
    final nextTorchState = !_torchEnabled;
    try {
      await controller.setFlashMode(nextTorchState ? FlashMode.torch : FlashMode.off);
      if (!mounted) return;
      setState(() {
        _torchEnabled = nextTorchState;
      });
    } on CameraException catch (error) {
      if (!mounted) return;
      _showInlineNotice(_cameraErrorCopy(error));
    }
  }

  Future<void> _capturePhoto() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized || _loading || _capturing) return;

    setState(() {
      _capturing = true;
      _errorMessage = null;
    });

    try {
      final capture = await controller.takePicture();
      if (!mounted) return;
      setState(() {
        _lastCapture = capture;
        _cropReviewOpen = true;
        _cropRotationQuarterTurns = 0;
        _capturing = false;
      });
    } on CameraException catch (error) {
      if (!mounted) return;
      setState(() {
        _capturing = false;
        _errorMessage = _cameraErrorCopy(error);
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _capturing = false;
        _errorMessage = 'Fotoğraf alınamadı. Kamerayı tekrar deneyebilirsin.';
      });
    }
  }

  void _showInlineNotice(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: MathProColors.surfaceAlt,
      ),
    );
  }

  void _retakeCapture() {
    setState(() {
      _cropReviewOpen = false;
      _cropRotationQuarterTurns = 0;
      _lastCapture = null;
    });
  }

  void _rotateCropReview() {
    setState(() {
      _cropRotationQuarterTurns = (_cropRotationQuarterTurns + 1) % 4;
    });
  }

  Future<void> _acceptCropFrame() async {
    final capture = _lastCapture;
    if (capture == null || _ocrUserFlowRunning) return;

    setState(() {
      _ocrUserFlowRunning = true;
      _errorMessage = null;
    });

    GaussMathLiveOcrReviewDraft draft;
    String evidenceStatusText;
    try {
      final evidence = await GaussRealCameraOcrUserFlowBindingQ378.captureAndPrepareReview(
        imagePath: capture.path,
        rotationQuarterTurns: _cropRotationQuarterTurns,
        modelSourcePath: _mathOcrModelSnapshot.installPath ?? '',
      );
      draft = GaussMathLiveOcrReviewDraft.fromQ378Evidence(
        capturePath: capture.path,
        rotationQuarterTurns: _cropRotationQuarterTurns,
        evidence: evidence,
      );
      final nativeMessage = evidence.nativeEvidence['userFacingMessage'] as String?;
      evidenceStatusText = evidence.hasDecodedCandidate
          ? 'OCR adayı hazır: review edip onaylarsan workspace güncellenecek.'
          : (nativeMessage?.trim().isNotEmpty == true
              ? nativeMessage!.trim()
              : 'OCR adayı üretilemedi: ${evidence.blockedReason}');
    } catch (error) {
      draft = GaussMathLiveOcrReviewDraft.pending(
        capturePath: capture.path,
        rotationQuarterTurns: _cropRotationQuarterTurns,
        blockedReason: 'q378-camera-ocr-flow-exception: $error',
      );
      evidenceStatusText = 'OCR akışı güvenli şekilde durdu: $error';
    }

    if (!mounted) return;
    setState(() {
      _ocrUserFlowRunning = false;
    });

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.48),
      builder: (context) => GaussMathLiveOcrReviewSheet(
        capturePath: capture.path,
        rotationQuarterTurns: _cropRotationQuarterTurns,
        modelSnapshot: _mathOcrModelSnapshot,
        modelSnapshotLoading: _mathOcrModelSnapshotLoading,
        onQueueModel: _installDeferredMathOcrModel,
        initialDraft: draft,
        evidenceStatusText: evidenceStatusText,
        onApprovedLatexImport: widget.onApprovedLatexImport,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeCapture = _lastCapture;
    final reviewingCrop = _cropReviewOpen && activeCapture != null;

    return Scaffold(
      backgroundColor: MathProColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          child: Column(
            children: <Widget>[
              _CameraTopBar(onClose: () => Navigator.of(context).maybePop()),
              const SizedBox(height: 14),
              Expanded(
                child: reviewingCrop
                    ? _FormulaCropReviewCard(
                        key: const ValueKey('mathpro-formula-crop-review-card'),
                        capturePath: activeCapture.path,
                        rotationQuarterTurns: _cropRotationQuarterTurns,
                      )
                    : _CameraPreviewCard(
                        controller: _controller,
                        loading: _loading,
                        errorMessage: _errorMessage,
                        onRetry: _bootstrapCamera,
                      ),
              ),
              const SizedBox(height: 14),
              if (reviewingCrop)
                _FormulaCropReviewControls(
                  rotationQuarterTurns: _cropRotationQuarterTurns,
                  onRetake: _retakeCapture,
                  onRotate: _rotateCropReview,
                  onUseFrame: _acceptCropFrame,
                  ocrRunning: _ocrUserFlowRunning,
                )
              else
                _CameraCaptureControls(
                  canSwitch: _cameras.length > 1 && !_loading && !_capturing,
                  torchEnabled: _torchEnabled,
                  capturing: _capturing,
                  captureReady: _controller?.value.isInitialized ?? false,
                  lastCapturePath: _lastCapture?.path,
                  onSwitchCamera: _switchCamera,
                  onToggleTorch: _toggleTorch,
                  onCapture: _capturePhoto,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CameraTopBar extends StatelessWidget {
  const _CameraTopBar({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _CameraRoundButton(
          tooltip: 'Kapat',
          icon: Icons.close_rounded,
          onPressed: onClose,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Kamera ile ifade al',
                style: MathProTypography.keyText.copyWith(
                  fontSize: 15.2,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Fotoğrafı al; OCR adayı önce review içinde düzenlenip onayla workspace’e aktarılır.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: MathProTypography.workspaceHint.copyWith(
                  color: MathProColors.textFaint.withValues(alpha: 0.82),
                  fontSize: 10.8,
                  height: 1.18,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: MathProColors.accent.withValues(alpha: 0.20), width: 0.8),
            color: MathProColors.accent.withValues(alpha: 0.08),
          ),
          child: Text(
            'Kamera',
            style: MathProTypography.workspaceHint.copyWith(
              color: MathProColors.accent,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _CameraPreviewCard extends StatelessWidget {
  const _CameraPreviewCard({
    required this.controller,
    required this.loading,
    required this.errorMessage,
    required this.onRetry,
  });

  final CameraController? controller;
  final bool loading;
  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final readyController = controller;
    final previewReady = readyController != null && readyController.value.isInitialized && !loading && errorMessage == null;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: MathProColors.accent.withValues(alpha: 0.22), width: 0.95),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF11181A),
            Color(0xFF070A0C),
            Color(0xFF020405),
          ],
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 32,
            spreadRadius: -18,
            color: Color.fromRGBO(116, 190, 180, 0.18),
            offset: Offset(0, 10),
          ),
          BoxShadow(
            blurRadius: 28,
            spreadRadius: -14,
            color: Color.fromRGBO(0, 0, 0, 0.80),
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            if (previewReady)
              ColoredBox(
                color: Colors.black,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: readyController.value.aspectRatio,
                    child: CameraPreview(readyController),
                  ),
                ),
              )
            else
              _CameraIdleSurface(
                loading: loading,
                errorMessage: errorMessage,
                onRetry: onRetry,
              ),
            const _FormulaScanFrame(),
            const Positioned(
              left: 16,
              right: 16,
              top: 14,
              child: _CameraUxQualityRail(
                title: GaussCameraUxPremiumPolishContract.previewHeaderCopy,
                body: GaussCameraUxPremiumPolishContract.previewBodyCopy,
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 14,
              child: _CameraModeHint(previewReady: previewReady),
            ),
          ],
        ),
      ),
    );
  }
}

class _CameraIdleSurface extends StatelessWidget {
  const _CameraIdleSurface({
    required this.loading,
    required this.errorMessage,
    required this.onRetry,
  });

  final bool loading;
  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: MathProColors.accent.withValues(alpha: 0.10),
                border: Border.all(color: MathProColors.accent.withValues(alpha: 0.26), width: 0.9),
              ),
              child: loading
                  ? const Padding(
                      padding: EdgeInsets.all(17),
                      child: CircularProgressIndicator(strokeWidth: 2.1, color: MathProColors.accent),
                    )
                  : const Icon(Icons.photo_camera_outlined, color: MathProColors.accent, size: 25),
            ),
            const SizedBox(height: 14),
            Text(
              loading ? 'Kamera hazırlanıyor' : 'Kamera kullanılamadı',
              textAlign: TextAlign.center,
              style: MathProTypography.keyText.copyWith(fontSize: 15, letterSpacing: 0.1),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage ?? 'İzin ve kamera önizlemesi hazırlanıyor.',
              textAlign: TextAlign.center,
              style: MathProTypography.workspaceHint.copyWith(
                color: MathProColors.textFaint.withValues(alpha: 0.86),
                fontSize: 12,
                height: 1.32,
              ),
            ),
            if (!loading && errorMessage != null) ...<Widget>[
              const SizedBox(height: 14),
              TextButton(
                onPressed: onRetry,
                style: TextButton.styleFrom(
                  foregroundColor: MathProColors.accent,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Tekrar dene'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FormulaScanFrame extends StatelessWidget {
  const _FormulaScanFrame();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.78,
          heightFactor: 0.34,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: MathProColors.accent.withValues(alpha: 0.48), width: 1.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  blurRadius: 18,
                  spreadRadius: -14,
                  color: Color.fromRGBO(116, 190, 180, 0.38),
                ),
              ],
            ),
            child: CustomPaint(painter: _ScanCornerPainter()),
          ),
        ),
      ),
    );
  }
}

class _ScanCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MathProColors.accent.withValues(alpha: 0.76)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const corner = 24.0;
    const inset = 1.0;

    canvas.drawLine(const Offset(inset, corner), const Offset(inset, inset), paint);
    canvas.drawLine(const Offset(inset, inset), const Offset(corner, inset), paint);
    canvas.drawLine(Offset(size.width - corner, inset), Offset(size.width - inset, inset), paint);
    canvas.drawLine(Offset(size.width - inset, inset), Offset(size.width - inset, corner), paint);
    canvas.drawLine(Offset(inset, size.height - corner), Offset(inset, size.height - inset), paint);
    canvas.drawLine(Offset(inset, size.height - inset), Offset(corner, size.height - inset), paint);
    canvas.drawLine(Offset(size.width - corner, size.height - inset), Offset(size.width - inset, size.height - inset), paint);
    canvas.drawLine(Offset(size.width - inset, size.height - inset), Offset(size.width - inset, size.height - corner), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CameraModeHint extends StatelessWidget {
  const _CameraModeHint({required this.previewReady});

  final bool previewReady;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.46),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08), width: 0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        child: Row(
          children: <Widget>[
            Icon(
              previewReady ? Icons.center_focus_strong_rounded : Icons.lock_outline_rounded,
              color: MathProColors.accent,
              size: 16,
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                previewReady
                    ? 'Formülü çerçeve içine al. Çerçeveyi kullanınca OCR review akışı başlar.'
                    : 'Kamera izni ve önizleme bekleniyor.',
                style: MathProTypography.workspaceHint.copyWith(
                  color: MathProColors.textSoft.withValues(alpha: 0.90),
                  fontSize: 11.2,
                  height: 1.22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CameraUxQualityRail extends StatelessWidget {
  const _CameraUxQualityRail({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MathProColors.accent.withValues(alpha: 0.18), width: 0.8),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 18,
            spreadRadius: -12,
            color: Color.fromRGBO(116, 190, 180, 0.20),
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 11, 13, 11),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.auto_awesome_rounded, color: MathProColors.accent, size: 15),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: MathProTypography.workspaceHint.copyWith(
                      color: MathProColors.textSoft,
                      fontSize: 11.4,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: MathProTypography.workspaceHint.copyWith(
                color: MathProColors.textFaint.withValues(alpha: 0.84),
                fontSize: 10.4,
                height: 1.18,
              ),
            ),
            const SizedBox(height: 9),
            const _CameraQualityChipRow(),
          ],
        ),
      ),
    );
  }
}

class _CameraQualityChipRow extends StatelessWidget {
  const _CameraQualityChipRow();

  @override
  Widget build(BuildContext context) {
    const labels = GaussCameraUxPremiumPolishContract.qualityRailLabels;
    const hints = GaussCameraUxPremiumPolishContract.qualityRailHints;
    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: <Widget>[
        for (var index = 0; index < labels.length; index += 1)
          _CameraQualityChip(
            label: labels[index],
            hint: hints[index],
          ),
      ],
    );
  }
}

class _CameraQualityChip extends StatelessWidget {
  const _CameraQualityChip({required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: hint,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: MathProColors.accent.withValues(alpha: 0.09),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: MathProColors.accent.withValues(alpha: 0.22), width: 0.75),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
          child: Text(
            label,
            style: MathProTypography.workspaceHint.copyWith(
              color: MathProColors.accent,
              fontSize: 9.7,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.18,
            ),
          ),
        ),
      ),
    );
  }
}

class _CameraUxCompactQualityPill extends StatelessWidget {
  const _CameraUxCompactQualityPill();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.48),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: MathProColors.accent.withValues(alpha: 0.18), width: 0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.tune_rounded, color: MathProColors.accent, size: 14),
            const SizedBox(width: 7),
            Text(
              GaussCameraUxPremiumPolishContract.cropHeaderCopy,
              style: MathProTypography.workspaceHint.copyWith(
                color: MathProColors.textSoft,
                fontSize: 10.8,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _FormulaCropReviewCard extends StatelessWidget {
  const _FormulaCropReviewCard({
    super.key,
    required this.capturePath,
    required this.rotationQuarterTurns,
  });

  final String capturePath;
  final int rotationQuarterTurns;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: MathProColors.accent.withValues(alpha: 0.24), width: 0.95),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF11181A),
            Color(0xFF070A0C),
            Color(0xFF020405),
          ],
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 32,
            spreadRadius: -18,
            color: Color.fromRGBO(116, 190, 180, 0.18),
            offset: Offset(0, 10),
          ),
          BoxShadow(
            blurRadius: 28,
            spreadRadius: -14,
            color: Color.fromRGBO(0, 0, 0, 0.82),
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ColoredBox(
              color: Colors.black,
              child: Center(
                child: RotatedBox(
                  quarterTurns: rotationQuarterTurns % 4,
                  child: Image.file(
                    File(capturePath),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                    errorBuilder: (context, error, stackTrace) => const _FormulaCropImageError(),
                  ),
                ),
              ),
            ),
            Container(color: Colors.black.withValues(alpha: 0.12)),
            const _FormulaCropFrameOverlay(),
            Positioned(
              left: 16,
              top: 14,
              child: _FormulaCropHeaderPill(rotationQuarterTurns: rotationQuarterTurns),
            ),
            const Positioned(
              right: 16,
              top: 14,
              child: _CameraUxCompactQualityPill(),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 14,
              child: _FormulaCropModeHint(capturePath: capturePath),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormulaCropImageError extends StatelessWidget {
  const _FormulaCropImageError();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: MathProColors.accent.withValues(alpha: 0.10),
              border: Border.all(color: MathProColors.accent.withValues(alpha: 0.26), width: 0.9),
            ),
            child: const Icon(Icons.broken_image_outlined, color: MathProColors.accent, size: 25),
          ),
          const SizedBox(height: 14),
          Text(
            'Fotoğraf önizlenemedi',
            textAlign: TextAlign.center,
            style: MathProTypography.keyText.copyWith(fontSize: 15, letterSpacing: 0.1),
          ),
          const SizedBox(height: 8),
          Text(
            'Tekrar çekerek güvenli kırpma önizlemesini yenileyebilirsin.',
            textAlign: TextAlign.center,
            style: MathProTypography.workspaceHint.copyWith(
              color: MathProColors.textFaint.withValues(alpha: 0.86),
              fontSize: 12,
              height: 1.32,
            ),
          ),
        ],
      ),
    );
  }
}

class _FormulaCropFrameOverlay extends StatelessWidget {
  const _FormulaCropFrameOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: GaussFormulaCropScanFramePolicy.normalizedFrameWidth,
          heightFactor: GaussFormulaCropScanFramePolicy.normalizedFrameHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: MathProColors.accent.withValues(alpha: 0.58), width: 1.05),
              color: Colors.black.withValues(alpha: 0.06),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  blurRadius: 20,
                  spreadRadius: -13,
                  color: Color.fromRGBO(116, 190, 180, 0.42),
                ),
              ],
            ),
            child: CustomPaint(painter: _ScanCornerPainter()),
          ),
        ),
      ),
    );
  }
}

class _FormulaCropHeaderPill extends StatelessWidget {
  const _FormulaCropHeaderPill({required this.rotationQuarterTurns});

  final int rotationQuarterTurns;

  @override
  Widget build(BuildContext context) {
    final degrees = (rotationQuarterTurns % 4) * 90;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.50),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: MathProColors.accent.withValues(alpha: 0.18), width: 0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.crop_free_rounded, color: MathProColors.accent, size: 15),
            const SizedBox(width: 8),
            Text(
              degrees == 0 ? 'Kırpma çerçevesi' : 'Kırpma çerçevesi · $degrees°',
              style: MathProTypography.workspaceHint.copyWith(
                color: MathProColors.textSoft,
                fontSize: 11.2,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormulaCropModeHint extends StatelessWidget {
  const _FormulaCropModeHint({required this.capturePath});

  final String capturePath;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.54),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08), width: 0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.center_focus_strong_rounded, color: MathProColors.accent, size: 16),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    GaussCameraUxPremiumPolishContract.cropBodyCopy,
                    style: MathProTypography.workspaceHint.copyWith(
                      color: MathProColors.textSoft.withValues(alpha: 0.92),
                      fontSize: 11.2,
                      height: 1.22,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              capturePath,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: MathProTypography.workspaceHint.copyWith(
                color: MathProColors.textFaint.withValues(alpha: 0.62),
                fontSize: 9.8,
                height: 1.16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormulaCropReviewControls extends StatelessWidget {
  const _FormulaCropReviewControls({
    required this.rotationQuarterTurns,
    required this.onRetake,
    required this.onRotate,
    required this.onUseFrame,
    required this.ocrRunning,
  });

  final int rotationQuarterTurns;
  final VoidCallback onRetake;
  final VoidCallback onRotate;
  final VoidCallback onUseFrame;
  final bool ocrRunning;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: MathProColors.borderSoft, width: 0.9),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF14191B),
            Color(0xFF090C0D),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Row(
          children: <Widget>[
            _CameraRoundButton(
              tooltip: 'Tekrar çek',
              icon: Icons.refresh_rounded,
              onPressed: onRetake,
            ),
            const SizedBox(width: 10),
            _CameraRoundButton(
              tooltip: 'Döndür',
              icon: Icons.rotate_90_degrees_ccw_rounded,
              active: rotationQuarterTurns % 4 != 0,
              onPressed: onRotate,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _FormulaCropPrimaryButton(
                onPressed: onUseFrame,
                busy: ocrRunning,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormulaCropPrimaryButton extends StatelessWidget {
  const _FormulaCropPrimaryButton({
    required this.onPressed,
    required this.busy,
  });

  final VoidCallback onPressed;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Kırpma çerçevesini kullan',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: busy ? null : onPressed,
          child: Container(
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: MathProColors.accent.withValues(alpha: 0.16),
              border: Border.all(color: MathProColors.accent.withValues(alpha: 0.48), width: 0.95),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  blurRadius: 17,
                  spreadRadius: -9,
                  color: Color.fromRGBO(116, 190, 180, 0.28),
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (busy)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 1.8, color: MathProColors.accent),
                  )
                else
                  const Icon(Icons.check_rounded, color: MathProColors.accent, size: 18),
                const SizedBox(width: 8),
                Text(
                  busy ? 'OCR hazırlanıyor' : 'Çerçeveyi kullan',
                  style: MathProTypography.keyText.copyWith(
                    color: MathProColors.accent,
                    fontSize: 13.2,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CameraCaptureControls extends StatelessWidget {
  const _CameraCaptureControls({
    required this.canSwitch,
    required this.torchEnabled,
    required this.capturing,
    required this.captureReady,
    required this.lastCapturePath,
    required this.onSwitchCamera,
    required this.onToggleTorch,
    required this.onCapture,
  });

  final bool canSwitch;
  final bool torchEnabled;
  final bool capturing;
  final bool captureReady;
  final String? lastCapturePath;
  final VoidCallback onSwitchCamera;
  final VoidCallback onToggleTorch;
  final VoidCallback onCapture;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: MathProColors.borderSoft, width: 0.9),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF14191B),
            Color(0xFF090C0D),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Row(
          children: <Widget>[
            _CameraRoundButton(
              tooltip: 'Kamera değiştir',
              icon: Icons.cameraswitch_outlined,
              enabled: canSwitch,
              onPressed: onSwitchCamera,
            ),
            const SizedBox(width: 10),
            _CameraRoundButton(
              tooltip: torchEnabled ? 'Işığı kapat' : 'Işığı aç',
              icon: torchEnabled ? Icons.flash_on_rounded : Icons.flash_off_rounded,
              active: torchEnabled,
              enabled: captureReady && !capturing,
              onPressed: onToggleTorch,
            ),
            const Spacer(),
            _CaptureButton(
              enabled: captureReady && !capturing,
              capturing: capturing,
              onPressed: onCapture,
            ),
            const Spacer(),
            _CaptureStatusPill(path: lastCapturePath),
          ],
        ),
      ),
    );
  }
}

class _CaptureButton extends StatelessWidget {
  const _CaptureButton({
    required this.enabled,
    required this.capturing,
    required this.onPressed,
  });

  final bool enabled;
  final bool capturing;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Fotoğraf çek',
      child: GestureDetector(
        onTap: enabled ? onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: enabled ? MathProColors.accent.withValues(alpha: 0.18) : MathProColors.surfaceSoft.withValues(alpha: 0.36),
            border: Border.all(
              color: enabled ? MathProColors.accent.withValues(alpha: 0.74) : MathProColors.borderSoft,
              width: 1.4,
            ),
            boxShadow: enabled
                ? const <BoxShadow>[
                    BoxShadow(
                      blurRadius: 18,
                      spreadRadius: -8,
                      color: Color.fromRGBO(116, 190, 180, 0.34),
                      offset: Offset(0, 7),
                    ),
                  ]
                : const <BoxShadow>[],
          ),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: capturing ? 24 : 48,
              height: capturing ? 24 : 48,
              decoration: BoxDecoration(
                shape: capturing ? BoxShape.rectangle : BoxShape.circle,
                borderRadius: capturing ? BorderRadius.circular(8) : null,
                color: enabled ? MathProColors.accent : MathProColors.textFaint.withValues(alpha: 0.38),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CameraRoundButton extends StatelessWidget {
  const _CameraRoundButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.enabled = true,
    this.active = false,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;
  final bool enabled;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final foreground = active ? MathProColors.accent : MathProColors.textSoft;
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: enabled ? onPressed : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: active ? MathProColors.accent.withValues(alpha: 0.12) : Colors.white.withValues(alpha: enabled ? 0.042 : 0.018),
              border: Border.all(
                color: active
                    ? MathProColors.accent.withValues(alpha: 0.46)
                    : MathProColors.accent.withValues(alpha: enabled ? 0.20 : 0.08),
                width: 0.9,
              ),
            ),
            child: Icon(
              icon,
              color: enabled ? foreground : MathProColors.textFaint.withValues(alpha: 0.38),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _CaptureStatusPill extends StatelessWidget {
  const _CaptureStatusPill({required this.path});

  final String? path;

  @override
  Widget build(BuildContext context) {
    final captured = path != null;
    return Container(
      width: 58,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: captured ? MathProColors.accent.withValues(alpha: 0.10) : Colors.white.withValues(alpha: 0.030),
        border: Border.all(
          color: captured ? MathProColors.accent.withValues(alpha: 0.34) : MathProColors.borderSoft,
          width: 0.85,
        ),
      ),
      child: Icon(
        captured ? Icons.check_rounded : Icons.image_outlined,
        color: captured ? MathProColors.accent : MathProColors.textFaint,
        size: 20,
      ),
    );
  }
}
