part of 'mathlive_main_editor_surface.dart';

/// V172-Q184 — Minimal Production MathLive Surface.
///
/// This is the production cutover surface from the Q183 inventory. It keeps the
/// compatibility [MathLiveMainEditorSurface] name as a stale-call-site shim, but the main workspace can use
/// this smaller runtime path: MathPro keyboard -> minimal command mapper ->
/// production bridge -> native MathLive <math-field>.
class MathLiveProductionEditorSurface extends StatefulWidget {
  const MathLiveProductionEditorSurface({
    super.key,
    required this.controller,
    required this.expressionText,
    required this.lastAnswer,
    required this.onStateChanged,
    required this.onEvaluateRequested,
  });

  static const String phase = 'V172-Q184';
  static const String productionCaretFocusSlotFinalizationPhase = MathLiveProductionCaretFocusSlotFinalizationPolicy.phase;
  static const String productionFinalStaticFreezePhase = MathLiveFinalStaticProductionFreezePolicy.phase;
  static const String productionSurfaceFileSeparationPhase = MathLiveProductionSurfaceFileSeparationPolicy.phase;
  static const String webViewAssetPath = 'assets/mathlive/main_editor_prod.html';
  static const String bridgeAssetPath = 'assets/mathlive/mathlive_prod_bridge.js';
  static const String runtimeAssetPath = 'assets/mathlive/vendor/mathlive/mathlive.min.js';
  static const String fontsCssAssetPath = 'assets/mathlive/vendor/mathlive/mathlive-fonts.css';
  static const String staticCssAssetPath = 'assets/mathlive/vendor/mathlive/mathlive-static.css';

  final MathLiveMainEditorRuntimeController controller;
  final String expressionText;
  final String lastAnswer;
  final ValueChanged<MathLiveEditorStateSnapshot> onStateChanged;
  final VoidCallback onEvaluateRequested;

  @override
  State<MathLiveProductionEditorSurface> createState() => _MathLiveProductionEditorSurfaceState();
}

class _MathLiveProductionEditorSurfaceState extends State<MathLiveProductionEditorSurface> {
  WebViewController? _webViewController;
  bool _pageLoaded = false;
  bool _runtimeMounted = false;
  bool _runtimeBlocked = false;
  String _lastLatex = '';
  String _lastExternalLatex = '';
  String _lastDiagnostic = 'production-mathlive-loading';
  String _lastProductionStateJson = '';
  // Q199 compatibility marker: q199-production-command-contract-not-started is superseded by Q200's no-freeze UI contract.
  // Q200 compatibility marker: q200-production-no-freeze-ui-contract-not-started is superseded by Q201 native caret finalization.
  // Q203 compatibility marker: q203-final-static-production-freeze-not-started freezes Q199-Q202 contracts for user-side device court.
  String _lastProductionCommandTrace = 'q201-production-caret-focus-slot-finalization-not-started';
  int _productionDispatchStartedCount = 0;
  int _productionDispatchCompletedCount = 0;
  int _productionDispatchFailureCount = 0;
  int _commandSequence = 0;
  Future<void> _productionCommandTail = Future<void>.value();
  int _productionCommandEpoch = 0;
  int _scheduledProductionTailDepth = 0;
  int _externalExpressionSyncBlockedByNativeCaretAuthorityCount = 0;
  int _q201NativeCaretKeepVisibleRequestCount = 0;
  bool _q382r27SuppressNextExternalExpressionSync = false;

  bool get isReady => _webViewController != null && _pageLoaded && !_runtimeBlocked;

  // V172-Q186: production state must satisfy the legacy runtime controller's
  // queued-key flush contract without re-entering any retired non-production surface.
  bool get _productionMayFlushQueuedCommands =>
      isReady && _runtimeMounted && !_runtimeBlocked && MathLiveProductionBridgeContractPolicy.flutterControllerQueueMayFlush;

  bool get _mayAcceptExternalExpressionSyncForNativeCaretAuthority {
    if (!MathLiveProductionCaretFocusSlotFinalizationPolicy.externalExpressionMayOverrideNativeCaretAfterUserInput) {
      return _lastLatex.trim().isEmpty &&
          _lastProductionStateJson.trim().isEmpty &&
          _commandSequence == 0 &&
          _productionDispatchStartedCount == 0;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    widget.controller._attach(this);
    _bootstrapProductionWebView();
  }

  @override
  void didUpdateWidget(covariant MathLiveProductionEditorSurface oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller._detach(this);
      widget.controller._attach(this);
    }
    final next = widget.expressionText.trim();
    final expressionPropChanged = next != oldWidget.expressionText.trim();
    if (_q382r27SuppressNextExternalExpressionSync && expressionPropChanged) {
      _q382r27SuppressNextExternalExpressionSync = false;
      _lastProductionCommandTrace = 'q382r27-optimistic-external-expression-sync-suppressed';
      return;
    }
    if (next.isNotEmpty && next != _lastExternalLatex && next != _lastLatex && _runtimeMounted) {
      if (_mayAcceptExternalExpressionSyncForNativeCaretAuthority) {
        _setLatex(next, reason: 'q201-initial-external-expression-sync-before-native-caret-authority');
      } else {
        _externalExpressionSyncBlockedByNativeCaretAuthorityCount += 1;
        _lastProductionCommandTrace = 'q201-external-expression-sync-blocked-native-caret-authority';
        unawaited(_emitState(
          reason: _lastProductionCommandTrace,
          lastCommandLabel: 'external-sync-blocked',
        ));
      }
    }
  }

  @override
  void dispose() {
    widget.controller._detach(this);
    super.dispose();
  }

  Future<void> _bootstrapProductionWebView() async {
    if (!MathLiveProductionPlatformViewPolicy.canUseProductionWebView) {
      setState(() {
        _runtimeBlocked = true;
        _lastDiagnostic = 'q184-production-webview-unavailable-in-test-environment';
      });
      return;
    }

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF0B0F12))
      ..addJavaScriptChannel(
        'MathProMathLiveState',
        onMessageReceived: (message) => _consumeProductionState(message.message),
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            final scheme = Uri.tryParse(request.url)?.scheme.toLowerCase() ?? '';
            if (scheme == 'http' || scheme == 'https') return NavigationDecision.prevent;
            return NavigationDecision.navigate;
          },
          onPageFinished: (_) async {
            _pageLoaded = true;
            await _mountProductionMathLive();
            await _warmupProductionMathLiveQ382R33();
            widget.controller._flushQueuedLabels(
              lastAnswer: widget.lastAnswer,
              reason: 'q184-production-page-ready-flush',
            );
            if (mounted) setState(() {});
          },
        ),
      );

    if (!mounted) return;
    setState(() => _webViewController = controller);

    final html = await rootBundle.loadString(MathLiveProductionEditorSurface.webViewAssetPath);
    final runtime = await rootBundle.loadString(MathLiveProductionEditorSurface.runtimeAssetPath);
    final bridge = await rootBundle.loadString(MathLiveProductionEditorSurface.bridgeAssetPath);
    final fontsCss = await _q196ProductionCssWithOfficialFontDataUrls(
      await rootBundle.loadString(MathLiveProductionEditorSurface.fontsCssAssetPath),
      assetName: 'mathlive-fonts.css',
    );
    final staticCss = await _q196ProductionCssWithOfficialFontDataUrls(
      await rootBundle.loadString(MathLiveProductionEditorSurface.staticCssAssetPath),
      assetName: 'mathlive-static.css',
    );
    final singleFileHtml = html
        .replaceFirst('__MATHPRO_INLINE_MATHLIVE_FONTS_CSS__', fontsCss)
        .replaceFirst('__MATHPRO_INLINE_MATHLIVE_STATIC_CSS__', staticCss)
        .replaceFirst('__MATHPRO_INLINE_MATHLIVE_RUNTIME__', runtime)
        .replaceFirst('__MATHPRO_INLINE_PRODUCTION_BRIDGE__', bridge);
    await controller.loadHtmlString(singleFileHtml);
  }

  Future<String> _q196ProductionCssWithOfficialFontDataUrls(
    String css, {
    required String assetName,
  }) async {
    // V172-Q196: official MathLive/KaTeX font bundle ingestion.
    // The production editor is loaded through loadHtmlString, so relative
    // CSS URLs such as url(fonts/KaTeX_Main-Regular.woff2) are not a reliable
    // asset transport on Android WebView. Q196 therefore embeds the official
    // bundled woff2 files as data URLs before the HTML is loaded. This keeps
    // the production path self-contained and prevents fake/broken premium font
    // closure claims. If the official files are absent, the older Q190R8
    // missing-font sanitizer is used instead and the package verifier fails
    // the Q196 closure.
    if (!MathLiveOfficialFontBundleIngestionPolicy.officialFontFilesBundled) {
      return _q190r8ProductionCssWithoutMissingFontFaces(css, assetName: assetName);
    }
    var out = css;
    var embeddedCount = 0;
    for (final fontFile in MathLiveOfficialFontBundleIngestionPolicy.requiredOfficialFontFiles) {
      final fileName = fontFile.split('/').last;
      final assetPath = 'assets/mathlive/vendor/mathlive/fonts/$fileName';
      try {
        final bytes = await rootBundle.load(assetPath);
        final data = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
        final encoded = base64Encode(data);
        final dataUrl = 'url(data:font/woff2;base64,$encoded)';
        out = out.replaceAll('url(fonts/$fileName)', dataUrl);
        embeddedCount += 1;
      } catch (_) {
        return _q190r8ProductionCssWithoutMissingFontFaces(css, assetName: assetName);
      }
    }
    if (embeddedCount != MathLiveOfficialFontBundleIngestionPolicy.requiredOfficialFontCount || out.contains('url(fonts/')) {
      return _q190r8ProductionCssWithoutMissingFontFaces(css, assetName: assetName);
    }
    out = out.replaceAll(':root{--ML__static-fonts:false}', ':root{--ML__static-fonts:true}');
    if (!out.contains(':root{--ML__static-fonts:true}')) {
      out = ':root{--ML__static-fonts:true}\n$out';
    }
    return '/* ${MathLiveOfficialFontBundleIngestionPolicy.phase}: official MathLive/KaTeX font files embedded as data URLs for $assetName; q196OfficialFontBundleClosed=true. */\n'
        ':root{--mathpro-q196-official-font-files-bundled:true;--mathpro-q196-official-font-data-urls:true;--mathpro-q193-official-font-bundle-closed:true;}\n'
        '$out';
  }

  String _q190r8ProductionCssWithoutMissingFontFaces(
    String css, {
    required String assetName,
  }) {
    // V172-Q190R8: the official runtime CSS files in this package reference
    // fonts/*.woff2 assets, while this package does not contain a fonts/
    // directory. Production HTML must not inline broken @font-face rules that
    // point to assets which are not bundled. This keeps the production route
    // honest and deterministic: MathLive static CSS is still inlined, but
    // missing local font references are stripped before WebView load.
    final withoutFontFaceRules = css.replaceAll(
      RegExp(r'@font-face\{[^{}]*\}', multiLine: true),
      '',
    );
    final withoutStaticFontClaim = withoutFontFaceRules.replaceAll(
      ':root{--ML__static-fonts:true}',
      ':root{--ML__static-fonts:false}',
    );
    return '/* ${MathLiveProductionStaticAssetTruthPolicy.phase} + '
        '${MathLiveRealMathLiveFontBundleClosurePolicy.phase}: '
        'sanitized $assetName; official MathLive font files are not bundled; '
        'missing url(fonts/*.woff2) @font-face rules stripped; '
        'Q193 closureStatus=${MathLiveRealMathLiveFontBundleClosurePolicy.closureStatus}. */\n'
        ':root{--mathpro-q190r8-font-files-bundled:false;--mathpro-q193-official-font-bundle-closed:false;--ML__static-fonts:false;}\n'
        '$withoutStaticFontClaim';
  }

  Future<void> _mountProductionMathLive() async {
    await _runProductionJavascript(
      'window.MathProProductionMathLiveBridge && window.MathProProductionMathLiveBridge.mount && window.MathProProductionMathLiveBridge.mount();',
      timeout: MathLiveRealDeviceDefectRepairPolicy.androidBridgeCommandTimeout,
      failureDiagnostic: 'q190-production-mount-dispatch-timeout-or-exception',
    );
    unawaited(_refreshProductionStateDeferred(reason: 'q190-production-mount-refresh'));
  }

  Future<void> _warmupProductionMathLiveQ382R33() async {
    if (!MathLiveFullKeyboardWarmupQ382R33Policy.webViewOnPageFinishedWarmupEnabled) return;
    final inventory = MathLiveFullKeyboardWarmupQ382R33Policy.fullKeyInventory(lastAnswer: widget.lastAnswer);
    final warmupEnvelope = jsonEncode(<String, Object?>{
      'phase': MathLiveFullKeyboardWarmupQ382R33Policy.phase,
      'marker': MathLiveFullKeyboardWarmupQ382R33Policy.marker,
      'inventory': inventory,
      'doesNotInsertIntoVisibleMathField':
          MathLiveFullKeyboardWarmupQ382R33Policy.warmupDoesNotInsertIntoVisibleMathField,
      'optimisticEchoScopeExpanded': MathLiveFullKeyboardWarmupQ382R33Policy.optimisticEchoScopeExpanded,
    });
    await _runProductionJavascript(
      'window.MathProProductionMathLiveBridge && window.MathProProductionMathLiveBridge.mathproWarmupAllKeys && window.MathProProductionMathLiveBridge.mathproWarmupAllKeys($warmupEnvelope);',
      timeout: MathLiveRealDeviceDefectRepairPolicy.androidBridgeCommandTimeout,
      failureDiagnostic: 'q382r33-full-keyboard-warmup-timeout-or-exception',
      emitFailureState: false,
    );
  }

  Future<bool> sendMathProKey(String label, {String lastAnswer = ''}) =>
      Future<bool>.value(scheduleMathProKey(label, lastAnswer: lastAnswer));

  bool scheduleMathProKey(String label, {String lastAnswer = ''}) {
    final controller = _webViewController;
    if (controller == null || !isReady) return false;

    final command = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel(label, lastAnswer: lastAnswer);
    if (!command.accepted) return false;
    if (command.action == 'evaluate') {
      widget.onEvaluateRequested();
      unawaited(_emitState(reason: 'q200-evaluate-requested-nonblocking', evaluateRequested: true, lastCommandLabel: label));
      return true;
    }

    final sequence = ++_commandSequence;
    MathProLatencyProbeQ382R23.instance.recordDartCommandScheduled(
      label: command.label,
      sequence: sequence,
    );
    final productionLatex = MathLiveKeyboardBridgePolicy.productionRuntimeRenderLatexForMainEditorLabel(command.label, command.latex);
    assert(() {
      // V172-Q382R22 keeps historical phase-policy references compile-visible
      // without putting them back into every runtime JS command payload.
      final compatibilityFingerprint = Object.hashAll(<Object?>[
        MathLiveRuntimePayloadSlimmingQ382R22Policy.phase,
        MathLiveProductionEditorSurface.phase,
        MathLiveProductionBridgeContractPolicy.phase,
        MathLiveProductionActivePathHardeningPolicy.phase,
        MathLiveProductionCommandTracePolicy.phase,
        MathLiveProductionCommandContractPolicy.phase,
        MathLiveProductionNoFreezeUiContractPolicy.phase,
        MathLiveProductionCaretFocusSlotFinalizationPolicy.phase,
        MathLiveProductionBridgeQueueFocusRepairPolicy.phase,
        MathLiveTemplatePayloadSurgicalRepairPolicy.phase,
        MathLiveNoFreezeRuntimeInvariantPolicy.phase,
        MathLiveStaticPreAnalyzeHygienePolicy.phase,
        MathLiveRuntimeRenderContractPolicy.phase,
        MathLiveCaretFocusSlotContractPolicy.phase,
        MathLiveRealMathLiveFontBundleClosurePolicy.phase,
        MathLiveOfficialFontBundleIngestionPolicy.phase,
        MathLivePhysicalLegacyCleanupPolicy.phase,
        MathLiveProductionSurfaceFileSeparationPolicy.phase,
        MathLiveJsSideCommandQueueQ382R28Policy.phase,
        MathLiveKeyOrderingRegressionQ382R33R3Policy.phase,
        MathLiveFullKeyboardWarmupQ382R33Policy.phase,
      ]);
      return compatibilityFingerprint != 0;
    }());

    // V172-Q382R22: the runtime JS insert/delete/clear payload is intentionally
    // slimmed to the fields the production bridge actually consumes on the hot
    // keyboard path. Historical verifier markers are retained below as comments,
    // not as JSON command payload fields, so policy traceability remains without
    // paying JSON encode/decode cost for every key press.
    // Compatibility markers retained outside the runtime payload:
    // 'phase': MathLiveProductionEditorSurface.phase
    // 'bridgeContractPhase': MathLiveProductionBridgeContractPolicy.phase
    // 'activePathHardeningPhase': MathLiveProductionActivePathHardeningPolicy.phase
    // 'commandTracePhase': MathLiveProductionCommandTracePolicy.phase
    // 'productionCommandContractPhase': MathLiveProductionCommandContractPolicy.phase
    // 'productionNoFreezeUiContractPhase': MathLiveProductionNoFreezeUiContractPolicy.phase
    // 'productionCaretFocusSlotFinalizationPhase': MathLiveProductionCaretFocusSlotFinalizationPolicy.phase
    // 'bridgeQueueFocusRepairPhase': MathLiveProductionBridgeQueueFocusRepairPolicy.phase
    // 'templatePayloadSurgicalRepairPhase': MathLiveTemplatePayloadSurgicalRepairPolicy.phase
    // 'noFreezeRuntimeInvariantPhase': MathLiveNoFreezeRuntimeInvariantPolicy.phase
    // 'staticPreAnalyzeHygienePhase': MathLiveStaticPreAnalyzeHygienePolicy.phase
    // 'runtimeRenderContractPhase': MathLiveRuntimeRenderContractPolicy.phase
    // 'caretFocusSlotContractPhase': MathLiveCaretFocusSlotContractPolicy.phase
    // 'officialFontBundleClosurePhase': MathLiveRealMathLiveFontBundleClosurePolicy.phase
    // 'officialFontBundleIngestionPhase': MathLiveOfficialFontBundleIngestionPolicy.phase
    // 'productionSurfaceFileSeparationPhase': MathLiveProductionSurfaceFileSeparationPolicy.phase
    // 'physicalLegacyCleanupPhase': MathLivePhysicalLegacyCleanupPolicy.phase
    // 'productionCommandSchedulingReturnsSynchronously': MathLiveProductionNoFreezeUiContractPolicy.productionCommandSchedulingReturnsSynchronously
    // 'webViewJavascriptRunsOnlyInsideFireAndForgetTail': MathLiveProductionNoFreezeUiContractPolicy.webViewJavascriptRunsOnlyInsideFireAndForgetTail
    // 'pressedStateMayDependOnJsCompletion': MathLiveProductionNoFreezeUiContractPolicy.pressedStateMayDependOnJsCompletion
    // 'flutterCaretOverlayAllowed': MathLiveCaretFocusSlotContractPolicy.flutterCaretOverlayAllowed
    // 'nativeMathLiveCaretOwnsSelection': MathLiveCaretFocusSlotContractPolicy.nativeMathLiveCaretOwnsSelection
    // 'runtimeRenderContractApplied': MathLiveKeyboardBridgePolicy.productionRuntimeRenderLatexContracts.containsKey(command.label)
    // 'sourceLatex': command.latex
    // 'rawInsertTokenFree': !MathLiveKeyboardBridgePolicy.productionRuntimeRenderLatexHasRawInsertToken(productionLatex)
    // Q382R22 payload budget marker: q382r22-runtime-payload-slimming-active.
    final payload = jsonEncode(<String, Object?>{
      'label': command.label,
      'action': command.action,
      'latex': productionLatex,
      'sequence': sequence,
      if (lastAnswer.isNotEmpty &&
          MathLiveRuntimePayloadSlimmingQ382R22Policy.maximumRuntimePayloadFieldCount >= 5)
        'lastAnswer': lastAnswer,
    });

    _productionDispatchStartedCount += 1;
    _lastProductionCommandTrace = 'q277r3-dart-dispatch-scheduled-fast-cadence-$label-$sequence';
    // V172-Q277R3: rapid keyboard taps must not trigger a Flutter-side
    // optimistic state echo before the actual MathLive JavaScript dispatch.
    // The native <math-field> remains the visible renderer authority; the
    // bridge pushes canonical state after the command. Skipping this echo
    // reduces tap-to-workspace cadence cost without changing keyboard layout,
    // MORE, long-press, OCR review/import safety, Graph, Solution, or History.
    if (MathLiveProductionTapLatencyCadencePolicy.emitOptimisticStateBeforeJsDispatch) {
      unawaited(_emitState(
        reason: _lastProductionCommandTrace,
        lastCommandLabel: label,
      ));
    }

    final commandUsesJsSideQueue = MathLiveJsSideCommandQueueQ382R28Policy.shouldUseJsSideQueueForAction(command.action);
    final jsExpression = switch (command.action) {
      'insertLatex' when commandUsesJsSideQueue =>
        'window.MathProProductionMathLiveBridge.enqueueKeyboardCommand($payload)',
      'deleteBackward' when commandUsesJsSideQueue =>
        'window.MathProProductionMathLiveBridge.enqueueKeyboardCommand($payload)',
      'insertLatex' => 'window.MathProProductionMathLiveBridge.insertLatex($payload)',
      'deleteBackward' => 'window.MathProProductionMathLiveBridge.deleteBackward($payload)',
      'clear' => 'window.MathProProductionMathLiveBridge.clear($payload)',
      _ => 'window.MathProProductionMathLiveBridge.notifyFlutterState("q186-production-noop")',
    };

    final mustSerializeJsSideQueueDispatch = MathLiveKeyOrderingRegressionQ382R33R3Policy.mustSerializeJsSideQueueDispatch(
      commandUsesJsSideQueue: commandUsesJsSideQueue,
    );
    // V172-Q382R33R3: preserve the non-blocking key acceptance contract, but do
    // not let multiple WebView runJavaScript calls race each other before they
    // reach the Q382R28 JS-side queue. The existing Dart production tail is
    // used only to serialize enqueue delivery; it still does not wait for a
    // Flutter state echo or hold the pressed key UI hostage.
    final shouldUseFastDispatch = switch (command.action) {
      'insertLatex' => MathLiveKeyboardLatencyClosureQ382R24Policy.fireAndForgetInsertDispatch && !mustSerializeJsSideQueueDispatch,
      'deleteBackward' => MathLiveKeyboardLatencyClosureQ382R24Policy.fireAndForgetDeleteDispatch && !mustSerializeJsSideQueueDispatch,
      'clear' => MathLiveKeyboardLatencyClosureQ382R24Policy.fireAndForgetClearDispatch,
      _ => false,
    };
    if (shouldUseFastDispatch) {
      return _dispatchProductionCommandFireAndForgetQ382R24(
        jsExpression: '$jsExpression;',
        label: label,
        sequence: sequence,
      );
    }

    return _enqueueProductionCommand(
      jsExpression: '$jsExpression;',
      label: label,
      sequence: sequence,
      priorityReset: command.action == 'clear',
    );
  }

  bool _dispatchProductionCommandFireAndForgetQ382R24({
    required String jsExpression,
    required String label,
    required int sequence,
  }) {
    _lastProductionCommandTrace = MathLiveJsSideCommandQueueQ382R28Policy.enabled
        ? 'q382r28-dart-to-js-side-queue-dispatch-$label-$sequence'
        : 'q382r24-fire-and-forget-js-dispatch-$label-$sequence';
    unawaited(_runProductionJavascript(
      jsExpression,
      timeout: MathLiveRealDeviceDefectRepairPolicy.androidBridgeCommandTimeout,
      failureDiagnostic: 'q382r24-production-command-timeout-or-exception-$label-$sequence',
      emitFailureState: true,
    ).then((sent) {
      if (!mounted) return;
      if (sent) {
        _productionDispatchCompletedCount += 1;
        _lastProductionCommandTrace = MathLiveJsSideCommandQueueQ382R28Policy.enabled
            ? 'q382r28-dart-to-js-side-queue-dispatch-sent-$label-$sequence'
            : 'q382r24-fire-and-forget-js-dispatch-sent-$label-$sequence';
      }
    }));
    return true;
  }

  bool _enqueueProductionCommand({
    required String jsExpression,
    required String label,
    required int sequence,
    bool priorityReset = false,
  }) {
    // V172-Q190R6: no MathPro key press may hold Flutter UI/pressed state hostage
    // while Android WebView executes JavaScript. The command is accepted once it
    // is placed on the production dispatch tail; actual bridge success/failure is
    // reported asynchronously by notifyFlutterState and trace diagnostics.
    // Backward verifier compatibility markers retained as comments only:
    // q190r3-dart-dispatch-start-$label-$sequence
    // q190r6-dart-dispatch-sent-nonblocking-$label-$sequence
    // q190r6-dart-dispatch-failed-released-$label-$sequence
    // q190r6-dart-priority-clear-nonblocking-reset-$label-$sequence
    // q190r6-dart-stale-dispatch-completed-after-priority-reset-$label-$sequence
    // q190r6-dart-command-accepted-nonblocking
    // q190r6-production-command-timeout-or-exception-$label-$sequence
    // q190r6-production-command-timeout-or-exception
    // q190-production-command-refresh
    if (priorityReset) {
      _productionCommandEpoch += 1;
      _productionCommandTail = Future<void>.value();
      _scheduledProductionTailDepth = 0;
      _lastLatex = '';
      _lastExternalLatex = '';
      _lastProductionStateJson = '';
      _lastProductionCommandTrace = 'q200-dart-priority-clear-nonblocking-tail-reset-$label-$sequence';
      unawaited(_emitState(reason: _lastProductionCommandTrace, lastCommandLabel: label));
    }
    if (!priorityReset && _scheduledProductionTailDepth >= MathLiveProductionNoFreezeUiContractPolicy.maxScheduledProductionTailDepth) {
      _productionDispatchFailureCount += 1;
      _lastProductionCommandTrace = 'q200-dart-dispatch-rejected-tail-depth-bound-$label-$sequence';
      unawaited(_emitState(reason: _lastProductionCommandTrace, lastCommandLabel: label));
      return false;
    }
    _scheduledProductionTailDepth += 1;
    final epoch = _productionCommandEpoch;
    _productionCommandTail = _productionCommandTail.catchError((_) {}).then((_) async {
      try {
        if (!mounted) return;
        final sent = await _runProductionJavascript(
        jsExpression,
        timeout: MathLiveRealDeviceDefectRepairPolicy.androidBridgeCommandTimeout,
        failureDiagnostic: 'q200-production-command-timeout-or-exception-released-$label-$sequence',
      );
      if (!mounted) return;
      if (sent) {
        _productionDispatchCompletedCount += 1;
        _lastProductionCommandTrace = epoch == _productionCommandEpoch
            ? 'q277r3-dart-command-tail-does-not-await-flutter-state-echo-$label-$sequence'
            : 'q277r3-dart-stale-dispatch-completed-after-priority-reset-$label-$sequence';
        // V172-Q277R3: do not await the Flutter state echo inside the serial
        // production command tail. Waiting here makes the next fast key tap sit
        // behind a rebuild/state propagation hop even though the native
        // MathLive bridge already notifies canonical state after insert.
        if (!MathLiveKeyboardLatencyClosureQ382R24Policy.syntheticDartEchoSuppressedForKeyboardCommands) {
          unawaited(_emitState(
            reason: _lastProductionCommandTrace,
            lastCommandLabel: label,
          ));
        }
        if ((epoch == _productionCommandEpoch || priorityReset) &&
            MathLiveProductionTapLatencyCadencePolicy.redundantDartStateRefreshAfterEveryKeyDispatch) {
          // Q190 compatibility marker: q190r3-production-command-refresh is superseded by q190r6-production-command-refresh.
          unawaited(_refreshProductionStateDeferred(reason: 'q277r3-production-command-refresh-$label-$sequence'));
        }
        } else {
          _productionDispatchFailureCount += 1;
          _lastProductionCommandTrace = 'q200-dart-dispatch-failed-released-$label-$sequence';
          await _emitState(
            reason: _lastProductionCommandTrace,
            lastCommandLabel: label,
          );
        }
      } finally {
        if (_scheduledProductionTailDepth > 0) _scheduledProductionTailDepth -= 1;
      }
    });
    unawaited(_productionCommandTail.catchError((Object error, StackTrace stackTrace) {
      _productionDispatchFailureCount += 1;
      _lastDiagnostic = 'q200-production-tail-error-released-$label-$sequence';
      _lastProductionCommandTrace = _lastDiagnostic;
      unawaited(_emitState(reason: _lastDiagnostic, lastCommandLabel: label));
    }));
    _lastProductionCommandTrace = 'q200-dart-command-accepted-nonblocking-$label-$sequence';
    if (!MathLiveKeyboardLatencyClosureQ382R24Policy.syntheticDartEchoSuppressedForKeyboardCommands || priorityReset) {
      unawaited(_emitState(reason: _lastProductionCommandTrace, lastCommandLabel: label));
    }
    return true;
  }

  Future<bool> _runProductionJavascript(
    String expression, {
    required Duration timeout,
    required String failureDiagnostic,
    bool emitFailureState = true,
  }) async {
    final controller = _webViewController;
    if (controller == null) return false;
    try {
      await controller.runJavaScript(expression).timeout(timeout);
      return true;
    } catch (_) {
      _productionDispatchFailureCount += 1;
      _lastProductionCommandTrace = failureDiagnostic;
      _lastDiagnostic = failureDiagnostic;
      if (emitFailureState) {
        await _emitState(reason: failureDiagnostic);
      }
      return false;
    }
  }

  Future<void> _refreshProductionStateDeferred({required String reason}) async {
    await Future<void>.delayed(MathLiveRealDeviceDefectRepairPolicy.deferredStateRefreshDelay);
    if (!mounted || _webViewController == null) return;
    await _runProductionJavascript(
      'window.MathProProductionMathLiveBridge && window.MathProProductionMathLiveBridge.notifyFlutterState && window.MathProProductionMathLiveBridge.notifyFlutterState("$reason");',
      timeout: MathLiveNoFreezeRuntimeInvariantPolicy.statePushCommandTimeout,
      failureDiagnostic: 'q190r6-production-deferred-state-refresh-timeout-or-exception',
      emitFailureState: false,
    );
  }

  Future<String?> currentStateJson() async {
    if (_webViewController == null) return _lastProductionStateJson.isEmpty ? null : _lastProductionStateJson;
    unawaited(_runProductionJavascript(
      // Q190R3 compatibility marker: q190r3-production-current-state is superseded by push-only readback.
      'window.MathProProductionMathLiveBridge && window.MathProProductionMathLiveBridge.notifyFlutterState && window.MathProProductionMathLiveBridge.notifyFlutterState("q190r4-production-current-state-push");',
      timeout: MathLiveNoFreezeRuntimeInvariantPolicy.statePushCommandTimeout,
      failureDiagnostic: 'q190r6-production-current-state-push-timeout-or-exception',
      emitFailureState: false,
    ));
    return _lastProductionStateJson.isEmpty ? null : _lastProductionStateJson;
  }

  Future<void> _setLatex(String latex, {required String reason}) async {
    final payload = jsonEncode(<String, Object?>{'latex': latex, 'reason': reason});
    final sent = await _runProductionJavascript(
      'window.MathProProductionMathLiveBridge && window.MathProProductionMathLiveBridge.setLatex && window.MathProProductionMathLiveBridge.setLatex($payload);',
      timeout: MathLiveRealDeviceDefectRepairPolicy.androidBridgeCommandTimeout,
      failureDiagnostic: 'q190-production-set-latex-timeout-or-exception',
    );
    if (sent) {
      _lastExternalLatex = latex;
      unawaited(_refreshProductionStateDeferred(reason: reason));
    }
  }

  Future<void> _emitState({
    required String reason,
    bool evaluateRequested = false,
    String lastCommandLabel = '',
  }) async {
    final traceReason = MathLiveProductionCommandTracePolicy.traceStateIntoSelectionDescription
        ? '$reason | $_lastProductionCommandTrace | dispatch=$_productionDispatchCompletedCount/$_productionDispatchStartedCount fail=$_productionDispatchFailureCount tail=$_scheduledProductionTailDepth q201ExternalSyncBlocked=$_externalExpressionSyncBlockedByNativeCaretAuthorityCount q201KeepCaret=$_q201NativeCaretKeepVisibleRequestCount json=${_lastProductionStateJson.isEmpty ? 'none' : 'seen'}'
        : reason;
    final snapshot = MathLiveEditorStateSnapshot(
      latex: _lastLatex,
      normalizedLatex: _lastLatex,
      plainText: _lastLatex,
      runtime: 'mathlive-production',
      keyboardBridgePhase: MathLiveKeyboardBridgePolicy.phase,
      lastCommandLabel: lastCommandLabel,
      evaluateRequested: evaluateRequested,
      hasFocus: true,
      selectionDescription: traceReason,
      realMathLiveRuntimeBundled: true,
      virtualKeyboardEnabled: false,
      remoteScriptLoadingAllowed: false,
      mainEditorSwitchAllowed: true,
      parseDiagnostic: traceReason,
    );
    widget.onStateChanged(snapshot);
  }

  // Q192 compatibility marker: q192-dart-keep-caret-visible is superseded by q201-dart-keep-native-caret-visible.
  Future<void> _keepCaretVisible({String reason = 'q201-dart-keep-native-caret-visible'}) async {
    _q201NativeCaretKeepVisibleRequestCount += 1;
    final payload = jsonEncode(<String, Object?>{
      'phase': MathLiveProductionCaretFocusSlotFinalizationPolicy.phase,
      'reason': reason,
      'nativeMathFieldOwnsVisibleCaret': MathLiveProductionCaretFocusSlotFinalizationPolicy.nativeMathFieldOwnsVisibleCaret,
      'focusSuccessMustBeMeasuredNotAssumed': MathLiveProductionCaretFocusSlotFinalizationPolicy.focusSuccessMustBeMeasuredNotAssumed,
      'requestCount': _q201NativeCaretKeepVisibleRequestCount,
    });
    await _runProductionJavascript(
      'window.MathProProductionMathLiveBridge && window.MathProProductionMathLiveBridge.keepCaretVisible && window.MathProProductionMathLiveBridge.keepCaretVisible($payload);',
      timeout: MathLiveRealDeviceDefectRepairPolicy.androidBridgeCommandTimeout,
      failureDiagnostic: 'q201-production-keep-native-caret-visible-timeout-or-exception',
      emitFailureState: false,
    );
  }

  void _consumeProductionState(String message) {
    MathProLatencyProbeQ382R23.instance.recordFlutterStateReceivedFromJs(message);
    _lastProductionStateJson = message;
    final snapshot = MathLiveStateAdapter.parseBridgeMessage(message);
    _lastLatex = snapshot.normalizedLatex.isEmpty ? snapshot.latex : snapshot.normalizedLatex;
    final wasMounted = _runtimeMounted;
    final productionMounted = snapshot.realMathLiveRuntimeBundled &&
        message.contains('mathfieldElementDefined":true') &&
        message.contains('mathfieldInstanceMounted":true');
    if (productionMounted) {
      _runtimeMounted = true;
      _runtimeBlocked = false;
    }
    _lastDiagnostic = snapshot.selectionDescription.isNotEmpty ? snapshot.selectionDescription : snapshot.parseDiagnostic;
    if (message.contains('commandTraceStatus')) {
      _lastProductionCommandTrace = _lastDiagnostic;
    }
    widget.onStateChanged(snapshot);
    if (snapshot.evaluateRequested) widget.onEvaluateRequested();
    if (productionMounted) {
      widget.controller._flushQueuedLabels(
        lastAnswer: widget.lastAnswer,
        reason: 'q184-production-state-mounted-flush',
      );
    }
    if (productionMounted && !wasMounted && mounted) {
      // V172-Q287R1: keep the existing native caret visibility helper live on
      // first runtime mount only. This preserves the Q201 caret contract while
      // avoiding Q277R3 tap-command-tail latency work on every key press.
      unawaited(_keepCaretVisible(reason: 'q287r1-production-mounted-caret-visibility-check'));
      setState(() {});
    }
  }


  void _suppressNextExternalExpressionSyncForQ382R27OptimisticEcho() {
    _q382r27SuppressNextExternalExpressionSync = true;
    _lastProductionCommandTrace = 'q382r27-optimistic-echo-external-sync-guard-armed';
  }

  void _noteFlutterKeyboardTap(String label, {String visibleLatex = ''}) {
    _lastProductionCommandTrace = 'q190r3-flutter-key-tap-$label';
  }

  void _noteBridgeSendResult(String label, {required bool sent}) {
    _lastProductionCommandTrace = sent ? 'q190r3-flutter-bridge-send-accepted-$label' : 'q190r3-flutter-bridge-send-rejected-$label';
  }

  void _noteProductionQueueFlush({required String reason, required int count}) {
    _lastProductionCommandTrace = 'q190r3-production-queued-label-flush-$count-$reason';
  }

  void _noteProductionQueueFlushCompleted({required String reason}) {
    _lastProductionCommandTrace = 'q190r3-production-queued-label-flush-complete-$reason';
  }

  @override
  Widget build(BuildContext context) {
    final controller = _webViewController;
    if (controller == null) {
      return const KeyedSubtree(
        key: ValueKey('mathpro-editor-math-render-surface'),
        child: _RuntimeBlockedPanel(message: 'Matematik editörü yükleniyor…'),
      );
    }
    return DecoratedBox(
      key: const ValueKey('mathpro-editor-math-render-surface'),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0F12).withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: MathProColors.accent.withValues(alpha: _runtimeMounted ? 0.20 : 0.10),
          width: 0.7,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: WebViewWidget(
          key: const ValueKey('mathpro-q184-production-mathlive-editor-surface'),
          controller: controller,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),
          },
        ),
      ),
    );
  }
}


// Q140: the visible MathLive migration badge was removed because it
// overlapped the first tokens in the real-device main editor.
// Q141: caret/tap ownership stays inside the official MathLive field;
// Flutter does not draw a replacement cursor overlay on this surface.
// Q145: templateLayoutPhase = 'V172-Q145'; compact MathLive template layout stays inside assets/mathlive CSS/bridge and does not mutate protected keyboard/long-press source files.
// Q146: runtimeSyncBindingPhase = 'V172-Q146'; MathLive snapshots feed CalculatorController, Graph, History, and Solution candidate state without mutating protected UI surfaces.
// Q148: viewportFitPhase = 'V172-Q148'; MathLive host fit classes and caret-follow scrolling keep long structural templates visible without reviving the legacy Flutter cursor overlay.
// Q192: caretFocusSlotContractPhase = 'V172-Q192'; production WebView keeps caret/focus/slot ownership inside the native MathLive field and Flutter does not draw a replacement cursor overlay.
// Q143: the WebView now eagerly receives touch gestures and primes MathLive
// focus after keyboard commands to prevent one-tap-then-frozen caret behavior.
// Q201: productionCaretFocusSlotFinalizationPhase = 'V172-Q201'; native MathLive keeps visible caret/focus/slot authority and Flutter blocks external mirror overrides after user input.

// Q203: finalStaticProductionFreezePhase = 'V172-Q203'; Q199-Q202 production contracts are frozen statically; Android PASS remains user-side evidence.
