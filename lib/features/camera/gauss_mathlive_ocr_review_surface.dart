import 'package:flutter/material.dart';

import '../../theme/mathpro_tokens.dart';
import '../../theme/mathpro_typography.dart';
import 'gauss_camera_ocr_candidate_review_workspace_import_binding_q386r1.dart';
import 'gauss_deferred_math_ocr_model_manager.dart';
import 'gauss_formula_crop_scan_frame_policy.dart';
import 'gauss_mathlive_ocr_review_surface_policy.dart';
import 'gauss_ocr_mathlive_review_import.dart';
import 'gauss_real_camera_ocr_user_flow_binding_q378.dart';
import 'gauss_real_editable_review_approved_workspace_import_binding_q376.dart';

typedef GaussDeferredModelInstallCallback = Future<GaussMathOcrModelSnapshot> Function(
  ValueChanged<GaussMathOcrModelSnapshot> onProgress,
);

class GaussMathLiveOcrReviewDraft {
  const GaussMathLiveOcrReviewDraft({
    required this.capturePath,
    required this.rotationQuarterTurns,
    required this.primaryLatexCandidate,
    required this.alternativeLatexCandidates,
    required this.hasRealOcrCandidate,
    required this.userApprovedForWorkspaceImport,
    required this.source,
    required this.candidateConfidence,
    required this.blockedReason,
    this.q376ReviewDraft,
  });

  factory GaussMathLiveOcrReviewDraft.pending({
    required String capturePath,
    required int rotationQuarterTurns,
    String blockedReason = 'ocr-candidate-pending',
  }) {
    return GaussMathLiveOcrReviewDraft(
      capturePath: capturePath,
      rotationQuarterTurns: rotationQuarterTurns,
      primaryLatexCandidate: r'\text{OCR candidate pending}',
      alternativeLatexCandidates: const <String>[],
      hasRealOcrCandidate: false,
      userApprovedForWorkspaceImport: false,
      source: GaussMathLiveOcrReviewSurfacePolicy.fullPhase,
      candidateConfidence: 0.0,
      blockedReason: blockedReason,
    );
  }

  factory GaussMathLiveOcrReviewDraft.fromQ250Import({
    required String capturePath,
    required int rotationQuarterTurns,
    required GaussOcrMathLiveReviewImportDraft importDraft,
  }) {
    final primary = importDraft.primaryCandidate;
    return GaussMathLiveOcrReviewDraft(
      capturePath: capturePath,
      rotationQuarterTurns: rotationQuarterTurns,
      primaryLatexCandidate: primary?.editableLatex ?? r'\text{OCR candidate pending}',
      alternativeLatexCandidates: importDraft.alternativeCandidates.map((candidate) => candidate.editableLatex).toList(growable: false),
      hasRealOcrCandidate: primary != null && (importDraft.canOpenEditableMathLiveReview || importDraft.canImportToWorkspaceAfterUserApproval),
      userApprovedForWorkspaceImport: importDraft.canImportToWorkspaceAfterUserApproval,
      source: GaussOcrMathLiveReviewImport.phase,
      candidateConfidence: 0.0,
      blockedReason: primary == null ? 'q250-import-primary-candidate-missing' : '',
    );
  }

  factory GaussMathLiveOcrReviewDraft.fromQ378Evidence({
    required String capturePath,
    required int rotationQuarterTurns,
    required GaussRealCameraOcrUserFlowBindingQ378Evidence evidence,
  }) {
    return GaussMathLiveOcrReviewDraft(
      capturePath: capturePath,
      rotationQuarterTurns: rotationQuarterTurns,
      primaryLatexCandidate: evidence.hasDecodedCandidate ? evidence.decodedCandidate.candidateLatex : r'\text{OCR candidate pending}',
      alternativeLatexCandidates: const <String>[],
      hasRealOcrCandidate: evidence.hasDecodedCandidate,
      userApprovedForWorkspaceImport: false,
      source: evidence.phase,
      candidateConfidence: evidence.decodedCandidate.candidateConfidence,
      blockedReason: evidence.blockedReason,
      q376ReviewDraft: evidence.reviewDraft,
    );
  }

  final String capturePath;
  final int rotationQuarterTurns;
  final String primaryLatexCandidate;
  final List<String> alternativeLatexCandidates;
  final bool hasRealOcrCandidate;
  final bool userApprovedForWorkspaceImport;
  final String source;
  final double candidateConfidence;
  final String blockedReason;
  final GaussEditableOcrReviewDraftQ376? q376ReviewDraft;

  bool get canImportToWorkspace => hasRealOcrCandidate && userApprovedForWorkspaceImport;
  bool get canEvaluate => false;
  bool get canGraph => false;
  bool get canWriteHistory => false;
  int get rotationDegrees => (rotationQuarterTurns % 4) * 90;
}

class GaussMathLiveOcrReviewSheet extends StatefulWidget {
  const GaussMathLiveOcrReviewSheet({
    super.key,
    required this.capturePath,
    required this.rotationQuarterTurns,
    required this.modelSnapshot,
    required this.modelSnapshotLoading,
    required this.onQueueModel,
    this.initialDraft,
    this.evidenceStatusText,
    this.onApprovedLatexImport,
  });

  final String capturePath;
  final int rotationQuarterTurns;
  final GaussMathOcrModelSnapshot modelSnapshot;
  final bool modelSnapshotLoading;
  final GaussDeferredModelInstallCallback onQueueModel;
  final GaussMathLiveOcrReviewDraft? initialDraft;
  final String? evidenceStatusText;
  final Future<void> Function(String approvedLatex)? onApprovedLatexImport;

  @override
  State<GaussMathLiveOcrReviewSheet> createState() => _GaussMathLiveOcrReviewSheetState();
}

class _GaussMathLiveOcrReviewSheetState extends State<GaussMathLiveOcrReviewSheet> {
  late final GaussMathLiveOcrReviewDraft _draft;
  late final TextEditingController _reviewController;
  late GaussMathOcrModelSnapshot _modelSnapshot;
  late bool _modelSnapshotLoading;
  bool _importing = false;
  bool _modelInstallRunning = false;
  bool _reviewTextHasContent = false;

  @override
  void initState() {
    super.initState();
    _draft = widget.initialDraft ?? GaussMathLiveOcrReviewDraft.pending(
      capturePath: widget.capturePath,
      rotationQuarterTurns: widget.rotationQuarterTurns,
    );
    _reviewController = TextEditingController(
      text: _draft.hasRealOcrCandidate ? _draft.primaryLatexCandidate : '',
    );
    _reviewTextHasContent = _reviewController.text.trim().isNotEmpty;
    _reviewController.addListener(_handleReviewTextChanged);
    _modelSnapshot = widget.modelSnapshot;
    _modelSnapshotLoading = widget.modelSnapshotLoading;
  }

  @override
  void dispose() {
    _reviewController.removeListener(_handleReviewTextChanged);
    _reviewController.dispose();
    super.dispose();
  }

  void _handleReviewTextChanged() {
    final next = _reviewController.text.trim().isNotEmpty;
    if (next == _reviewTextHasContent) return;
    if (!mounted) return;
    setState(() => _reviewTextHasContent = next);
  }

  GaussQ386R1WorkspaceImportGate get _q386r1WorkspaceImportGate =>
      GaussQ386R1WorkspaceImportGate.evaluate(
        hasRealOcrCandidate: _draft.hasRealOcrCandidate,
        hasEditableReviewDraft: _draft.q376ReviewDraft != null,
        workspaceImportCallbackAvailable: widget.onApprovedLatexImport != null,
        explicitUserApproval: true,
        approvedLatex: _reviewController.text,
      );


  Future<void> _installDeferredModel() async {
    if (_modelInstallRunning || _modelSnapshot.isQueuedOrActive) return;
    setState(() {
      _modelInstallRunning = true;
      _modelSnapshotLoading = false;
    });
    final snapshot = await widget.onQueueModel((progressSnapshot) {
      if (!mounted) return;
      setState(() {
        _modelSnapshot = progressSnapshot;
        _modelSnapshotLoading = false;
      });
    });
    if (!mounted) return;
    setState(() {
      _modelSnapshot = snapshot;
      _modelSnapshotLoading = false;
      _modelInstallRunning = false;
    });
    _showNotice(
      snapshot.canRunOffline
          ? 'Ana model SHA256 ile doğrulandı; yan dosyalar varlık/boyut kontrolünden geçti. OCR çalışma motoru ayrıca hazır olunca kamera okuma aktif olur.'
          : snapshot.productCopy,
    );
  }

  Future<void> _approveAndImport() async {
    final callback = widget.onApprovedLatexImport;
    final q376Draft = _draft.q376ReviewDraft;
    final approvedLatex = _reviewController.text.trim();
    final q386r1Gate = _q386r1WorkspaceImportGate;
    if (!q386r1Gate.canSubmit || callback == null || q376Draft == null) {
      _showNotice(q386r1Gate.blockedReason);
      return;
    }
    final importResult = GaussRealCameraOcrUserFlowBindingQ378.prepareApprovedImport(
      reviewDraft: q376Draft,
      approvedLatex: approvedLatex,
      explicitUserApproval: true,
    );
    if (!importResult.workspaceImportReady) {
      _showNotice(importResult.command.blockedReason.isEmpty ? 'Workspace aktarımı hazır değil.' : importResult.command.blockedReason);
      return;
    }
    setState(() => _importing = true);
    await callback(importResult.command.approvedLatex);
    if (!mounted) return;
    setState(() => _importing = false);
    Navigator.of(context).maybePop();
  }

  void _showNotice(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: MathProColors.surfaceAlt,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(20, 0, 20, 18),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFF1D2528),
              Color(0xFF101518),
              Color(0xFF070A0C),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: MathProColors.accent.withValues(alpha: 0.24), width: 0.9),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              blurRadius: 26,
              spreadRadius: -18,
              color: Color.fromRGBO(116, 190, 180, 0.24),
              offset: Offset(0, -2),
            ),
            BoxShadow(
              blurRadius: 28,
              spreadRadius: -14,
              color: Color.fromRGBO(0, 0, 0, 0.84),
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const _ReviewHeader(),
                const SizedBox(height: 12),
                Text(
                  _draft.hasRealOcrCandidate
                      ? 'OCR adayı bulundu. İfadeyi kontrol edip düzenle; yalnızca onayından sonra workspace’e aktarılır.'
                      : 'OCR adayı henüz hazır değil. Workspace aktarımı, çözüm ve grafik kapalı kalır.',
                  style: MathProTypography.workspaceHint.copyWith(
                    color: MathProColors.textSoft.withValues(alpha: 0.88),
                    fontSize: 12.5,
                    height: 1.36,
                  ),
                ),
                if ((widget.evidenceStatusText ?? '').trim().isNotEmpty) ...<Widget>[
                  const SizedBox(height: 8),
                  _EvidenceStatusStrip(statusText: widget.evidenceStatusText!.trim()),
                ],
                const SizedBox(height: 10),
                _CaptureMetadataStrip(draft: _draft),
                const SizedBox(height: 12),
                _MathLiveReviewContractCard(
                  draft: _draft,
                  reviewController: _reviewController,
                ),
                const SizedBox(height: 12),
                _DeferredModelStatusCard(
                  snapshot: _modelSnapshot,
                  loading: _modelSnapshotLoading || _modelInstallRunning,
                  onQueueModel: _installDeferredModel,
                ),
                const SizedBox(height: 12),
                _SafetyContractCard(draft: _draft),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: _importing ? null : () => Navigator.of(context).maybePop(),
                      style: TextButton.styleFrom(
                        foregroundColor: MathProColors.textSoft,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('İptal'),
                    ),
                    const SizedBox(width: 10),
                    FilledButton(
                      onPressed: _q386r1WorkspaceImportGate.canSubmit && _reviewTextHasContent && !_importing ? _approveAndImport : null,
                      style: FilledButton.styleFrom(
                        backgroundColor: MathProColors.accent,
                        foregroundColor: const Color(0xFF041010),
                        disabledBackgroundColor: MathProColors.accent.withValues(alpha: 0.18),
                        disabledForegroundColor: MathProColors.textFaint,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(_importing ? 'Aktarılıyor...' : 'Workspace’e aktar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewHeader extends StatelessWidget {
  const _ReviewHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: MathProColors.accent.withValues(alpha: 0.12),
            border: Border.all(color: MathProColors.accent.withValues(alpha: 0.34), width: 0.9),
          ),
          child: const Icon(Icons.functions_rounded, size: 20, color: MathProColors.accent),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'MathLive OCR review',
                style: MathProTypography.keyText.copyWith(
                  color: MathProColors.text,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'OCR sonucu önce burada düzenlenir',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: MathProTypography.workspaceHint.copyWith(
                  color: MathProColors.textFaint.withValues(alpha: 0.82),
                  fontSize: 10.8,
                  height: 1.16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EvidenceStatusStrip extends StatelessWidget {
  const _EvidenceStatusStrip({required this.statusText});

  final String statusText;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: MathProColors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: MathProColors.accent.withValues(alpha: 0.18), width: 0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
        child: Text(
          statusText,
          style: MathProTypography.workspaceHint.copyWith(
            color: MathProColors.textSoft.withValues(alpha: 0.86),
            fontSize: 10.7,
            height: 1.24,
          ),
        ),
      ),
    );
  }
}

class _CaptureMetadataStrip extends StatelessWidget {
  const _CaptureMetadataStrip({required this.draft});

  final GaussMathLiveOcrReviewDraft draft;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.035),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MathProColors.borderSoft, width: 0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 9, 12, 9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Çerçeve: ${GaussFormulaCropScanFramePolicy.normalizedFrameDescription} · Döndürme: ${draft.rotationDegrees}° · Güven: ${(draft.candidateConfidence * 100).round()}%',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: MathProTypography.workspaceHint.copyWith(
                color: MathProColors.textSoft.withValues(alpha: 0.78),
                fontSize: 10.8,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              draft.capturePath,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: MathProTypography.workspaceHint.copyWith(
                color: MathProColors.textFaint.withValues(alpha: 0.70),
                fontSize: 10.5,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MathLiveReviewContractCard extends StatelessWidget {
  const _MathLiveReviewContractCard({
    required this.draft,
    required this.reviewController,
  });

  final GaussMathLiveOcrReviewDraft draft;
  final TextEditingController reviewController;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      key: const ValueKey('mathpro-mathlive-ocr-review-surface-q378-real-flow'),
      decoration: BoxDecoration(
        color: const Color(0xFF070C0E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MathProColors.accent.withValues(alpha: 0.22), width: 0.9),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 18,
            spreadRadius: -13,
            color: Color.fromRGBO(116, 190, 180, 0.22),
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 12, 13, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.edit_note_rounded, color: MathProColors.accent, size: 18),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'Düzenlenebilir OCR adayı',
                    style: MathProTypography.workspaceHint.copyWith(
                      color: MathProColors.textSoft,
                      fontSize: 11.8,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                _ReviewStatePill(ready: draft.hasRealOcrCandidate),
              ],
            ),
            const SizedBox(height: 10),
            if (draft.hasRealOcrCandidate)
              TextField(
                controller: reviewController,
                minLines: 1,
                maxLines: 3,
                style: MathProTypography.keyText.copyWith(
                  color: MathProColors.text,
                  fontSize: 13.2,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.05,
                ),
                cursorColor: MathProColors.accent,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.black.withValues(alpha: 0.24),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.07), width: 0.8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.07), width: 0.8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: MathProColors.accent.withValues(alpha: 0.58), width: 1.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.24),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.07), width: 0.8),
                ),
                child: Text(
                  draft.blockedReason.isEmpty ? draft.primaryLatexCandidate : draft.blockedReason,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: MathProTypography.keyText.copyWith(
                    color: MathProColors.textFaint,
                    fontSize: 12.4,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.05,
                  ),
                ),
              ),
            const SizedBox(height: 9),
            Text(
              'Onaydan sonra yalnızca workspace ifadesi güncellenir; çözüm, grafik, Solution ve History otomatik çalışmaz.',
              style: MathProTypography.workspaceHint.copyWith(
                color: MathProColors.textSoft.withValues(alpha: 0.82),
                fontSize: 10.8,
                height: 1.28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewStatePill extends StatelessWidget {
  const _ReviewStatePill({required this.ready});

  final bool ready;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: MathProColors.accent.withValues(alpha: ready ? 0.14 : 0.07),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: MathProColors.accent.withValues(alpha: ready ? 0.34 : 0.18), width: 0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        child: Text(
          ready ? 'Aday var' : 'Bekliyor',
          style: MathProTypography.workspaceHint.copyWith(
            color: ready ? MathProColors.accent : MathProColors.textFaint,
            fontSize: 9.8,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
      ),
    );
  }
}

// Q389R6L legacy OCR review verifier marker: Gelişmiş model yöneticisi
class _DeferredModelStatusCard extends StatelessWidget {
  const _DeferredModelStatusCard({
    required this.snapshot,
    required this.loading,
    required this.onQueueModel,
  });

  final GaussMathOcrModelSnapshot snapshot;
  final bool loading;
  final Future<void> Function() onQueueModel;

  @override
  Widget build(BuildContext context) {
    final queuedOrActive = snapshot.isQueuedOrActive;
    // Q384R1 legacy verifier marker: user-facing download action remains 'Modeli indir'.
    final downloadActionSemantics = snapshot.downloadActionLabel;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: MathProColors.accent.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: MathProColors.accent.withValues(alpha: 0.18), width: 0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: MathProColors.accent.withValues(alpha: 0.12),
                    border: Border.all(color: MathProColors.accent.withValues(alpha: 0.26), width: 0.8),
                  ),
                  child: loading
                      ? const Padding(
                          padding: EdgeInsets.all(8.5),
                          child: CircularProgressIndicator(strokeWidth: 1.7, color: MathProColors.accent),
                        )
                      : Icon(
                          queuedOrActive ? Icons.downloading_rounded : Icons.cloud_download_outlined,
                          size: 16,
                          color: MathProColors.accent,
                        ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'PP-FormulaNet-S modeli',
                        style: MathProTypography.workspaceHint.copyWith(
                          color: MathProColors.textSoft,
                          fontSize: 11.8,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        loading ? 'Durum okunuyor' : snapshot.statusLabel,
                        style: MathProTypography.workspaceHint.copyWith(
                          color: MathProColors.accent,
                          fontSize: 10.6,
                          fontWeight: FontWeight.w800,
                          height: 1.12,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: loading || queuedOrActive ? null : () async {
                    await onQueueModel();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: MathProColors.accent,
                    disabledForegroundColor: MathProColors.textFaint.withValues(alpha: 0.42),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    minimumSize: const Size(0, 34),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                  ),
                  child: Text(snapshot.downloadActionLabel, semanticsLabel: downloadActionSemantics),
                ),
              ],
            ),
            if (queuedOrActive || snapshot.status == GaussMathOcrModelInstallStatus.downloading || snapshot.status == GaussMathOcrModelInstallStatus.verifying) ...<Widget>[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: snapshot.progress > 0 ? snapshot.progress.clamp(0, 1).toDouble() : null,
                  minHeight: 5,
                  backgroundColor: Colors.black.withValues(alpha: 0.22),
                ),
              ),
            ],
            const SizedBox(height: 8),
            Text(
              loading ? 'Model durumu hazırlanıyor.' : snapshot.productCopy,
              style: MathProTypography.workspaceHint.copyWith(
                color: MathProColors.textSoft.withValues(alpha: 0.82),
                fontSize: 10.8,
                height: 1.28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SafetyContractCard extends StatelessWidget {
  const _SafetyContractCard({required this.draft});

  final GaussMathLiveOcrReviewDraft draft;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.030),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MathProColors.borderSoft, width: 0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.verified_user_outlined, color: MathProColors.accent, size: 16),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                draft.hasRealOcrCandidate
                    ? 'Gerçek OCR adayı review içindedir. Workspace aktarımı yalnızca bu ekrandaki onayla yapılır; otomatik çözüm/grafik/history yoktur.'
                    : 'OCR adayı yok: workspace aktarımı, çözüm ve grafik kapalı. Blok sebebi: ${draft.blockedReason.isEmpty ? 'candidate pending' : draft.blockedReason}',
                style: MathProTypography.workspaceHint.copyWith(
                  color: MathProColors.textSoft.withValues(alpha: 0.82),
                  fontSize: 10.8,
                  height: 1.28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
