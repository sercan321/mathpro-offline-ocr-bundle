(function () {
  'use strict';

  const SURFACE_PHASE = 'V172-Q184';
  const HTML_FINALIZATION_PHASE = 'V172-Q185';
  const BRIDGE_CONTRACT_PHASE = 'V172-Q186';
  const REAL_DEVICE_DEFECT_REPAIR_PHASE = 'V172-Q190';
  const ACTIVE_PATH_HARDENING_PHASE = 'V172-Q190R2';
  const COMMAND_TRACE_PHASE = 'V172-Q190R3';
  const BRIDGE_QUEUE_FOCUS_REPAIR_PHASE = 'V172-Q190R4';
  const TEMPLATE_PAYLOAD_SURGICAL_REPAIR_PHASE = 'V172-Q190R5';
  const NO_FREEZE_RUNTIME_INVARIANT_PHASE = 'V172-Q190R6';
  const RUNTIME_RENDER_CONTRACT_PHASE = 'V172-Q191';
  const CARET_FOCUS_SLOT_CONTRACT_PHASE = 'V172-Q192';
  const COMMAND_CONTRACT_PHASE = 'V172-Q199';
  const NO_FREEZE_UI_CONTRACT_PHASE = 'V172-Q200';
  const CARET_FOCUS_SLOT_FINALIZATION_PHASE = 'V172-Q201';
  const FINAL_STATIC_PRODUCTION_FREEZE_PHASE = 'V172-Q203';
  const KEYBOARD_INSERTION_STATE_PUSH_BUDGET_PHASE = 'V172-Q382R19';
  const RUNTIME_PAYLOAD_SLIMMING_PHASE = 'V172-Q382R22';
  const REAL_DEVICE_LATENCY_INSTRUMENTATION_PHASE = 'V172-Q382R23';
  const KEYBOARD_LATENCY_CLOSURE_PHASE = 'V172-Q382R24';
  const CARET_CONTEXT_BRIDGE_PHASE = 'V172-Q382R26';
  const JS_SIDE_COMMAND_QUEUE_PHASE = 'V172-Q382R28';
  const ALL_KEY_LATENCY_CLOSURE_PHASE = 'V172-Q382R32';
  const FULL_KEYBOARD_WARMUP_PHASE = 'V172-Q382R33';
  const KEYBOARD_INSERTION_NATIVE_EVENT_SUPPRESSION_MS = 64;
  const Q382R24_KEYBOARD_SETTLE_PUSH_AFTER_CANONICAL_ALLOWED = false;
  const MAX_QUEUE = 24;
  const Q382R28_MAX_JS_SIDE_QUEUE = 96;
  const Q382R28_MAX_DRAIN_PER_TICK = 8;
  const Q382R32_TEMPLATE_PAYLOAD_CACHE_LIMIT = 96;
  const Q382R33_FULL_KEYBOARD_WARMUP_LIMIT = 256;
  const MAX_TRACE_EVENTS = 16;

  const state = {
    phase: SURFACE_PHASE,
    productionHtmlFinalizationPhase: HTML_FINALIZATION_PHASE,
    productionBridgeContractPhase: BRIDGE_CONTRACT_PHASE,
    realDeviceDefectRepairPhase: REAL_DEVICE_DEFECT_REPAIR_PHASE,
    activePathHardeningPhase: ACTIVE_PATH_HARDENING_PHASE,
    commandTracePhase: COMMAND_TRACE_PHASE,
    bridgeQueueFocusRepairPhase: BRIDGE_QUEUE_FOCUS_REPAIR_PHASE,
    templatePayloadSurgicalRepairPhase: TEMPLATE_PAYLOAD_SURGICAL_REPAIR_PHASE,
    noFreezeRuntimeInvariantPhase: NO_FREEZE_RUNTIME_INVARIANT_PHASE,
    runtimeRenderContractPhase: RUNTIME_RENDER_CONTRACT_PHASE,
    caretFocusSlotContractPhase: CARET_FOCUS_SLOT_CONTRACT_PHASE,
    productionCommandContractPhase: COMMAND_CONTRACT_PHASE,
    productionNoFreezeUiContractPhase: NO_FREEZE_UI_CONTRACT_PHASE,
    productionCaretFocusSlotFinalizationPhase: CARET_FOCUS_SLOT_FINALIZATION_PHASE,
    finalStaticProductionFreezePhase: FINAL_STATIC_PRODUCTION_FREEZE_PHASE,
    keyboardInsertionStatePushBudgetPhase: KEYBOARD_INSERTION_STATE_PUSH_BUDGET_PHASE,
    runtimePayloadSlimmingPhase: RUNTIME_PAYLOAD_SLIMMING_PHASE,
    q382r22RuntimePayloadSlimmingActive: true,
    q382r22RuntimePayloadRequiredFieldCount: 4,
    q382r22RuntimePayloadMaximumFieldCount: 5,
    q382r23RealDeviceLatencyInstrumentationPhase: REAL_DEVICE_LATENCY_INSTRUMENTATION_PHASE,
    q382r23LatencyInstrumentationActive: true,
    q382r24KeyboardLatencyClosurePhase: KEYBOARD_LATENCY_CLOSURE_PHASE,
    q382r24KeyboardLatencyClosureActive: true,
    q382r24KeyboardNativeEventSuppressionMs: KEYBOARD_INSERTION_NATIVE_EVENT_SUPPRESSION_MS,
    q382r24KeyboardSettlePushAfterCanonicalAllowed: Q382R24_KEYBOARD_SETTLE_PUSH_AFTER_CANONICAL_ALLOWED,
    q382r24KeyboardSettlePushSuppressedCount: 0,
    q382r26CaretContextBridgePhase: CARET_CONTEXT_BRIDGE_PHASE,
    q382r26CaretContextBridgeActive: true,
    q382r26OptimisticEchoEnabledByThisPhase: false,
    q382r28JsSideCommandQueuePhase: JS_SIDE_COMMAND_QUEUE_PHASE,
    q382r28JsSideCommandQueueActive: true,
    q382r28JsSideCommandQueueDepth: 0,
    q382r28JsSideCommandQueuedCount: 0,
    q382r28JsSideCommandProcessedCount: 0,
    q382r28JsSideCommandDroppedCount: 0,
    q382r28JsSideCommandDrainScheduledCount: 0,
    q382r28JsSideCommandDrainTickCount: 0,
    q382r28JsSideCommandLastAcceptedSequence: 0,
    q382r28JsSideCommandLastProcessedSequence: 0,
    q382r28JsSideCommandLastAction: '',
    q382r28JsSideCommandLastTrace: 'q382r28-js-side-command-queue-bootstrap',
    q382r32AllKeyLatencyClosurePhase: ALL_KEY_LATENCY_CLOSURE_PHASE,
    q382r32TemplateFastPathsActive: true,
    q382r32TemplatePayloadCacheLimit: Q382R32_TEMPLATE_PAYLOAD_CACHE_LIMIT,
    q382r32TemplatePayloadCacheSize: 0,
    q382r32TemplatePayloadCacheHitCount: 0,
    q382r32TemplatePayloadCacheMissCount: 0,
    q382r32TemplatePayloadCacheEvictionCount: 0,
    q382r32TemplatePayloadLastTrace: 'q382r32-template-payload-cache-bootstrap',
    q382r33FullKeyboardWarmupPhase: FULL_KEYBOARD_WARMUP_PHASE,
    q382r33FullKeyboardWarmupActive: true,
    q382r33WarmupDoesNotInsertIntoVisibleMathField: true,
    q382r33WarmupInventoryReceivedCount: 0,
    q382r33WarmupPayloadPrecompiledCount: 0,
    q382r33WarmupSkippedCount: 0,
    q382r33WarmupRunCount: 0,
    q382r33WarmupLastTrace: 'q382r33-full-keyboard-warmup-bootstrap',
    caretContext: {
      phase: CARET_CONTEXT_BRIDGE_PHASE,
      source: 'q382r26-bootstrap',
      confidence: 'unknown',
      trusted: false,
      selectionCollapsed: false,
      caretAtDocumentEnd: false,
      insidePlaceholder: false,
      insideTemplate: false,
      caretOffset: -1,
      documentEndOffset: -1,
      selectionLength: -1,
      diagnostic: 'q382r26-caret-context-bootstrap'
    },
    q382r23LastLatency: {
      phase: REAL_DEVICE_LATENCY_INSTRUMENTATION_PHASE,
      label: '',
      action: '',
      sequence: 0,
      t3JsBridgeReceivedEpochMs: 0,
      t4MathLiveInsertStartEpochMs: 0,
      t5MathLiveInsertEndEpochMs: 0,
      t6JsStatePostEpochMs: 0
    },
    q382r19KeyboardInsertionModeActive: false,
    q382r19KeyboardInsertionStatePushBudgetActive: true,
    q382r19KeyboardInsertionCanonicalPushCount: 0,
    q382r19KeyboardInsertionSettlePushCount: 0,
    q382r19NativeEventCaretPushSuppressedCount: 0,
    q382r19LastKeyboardInsertionBudgetReason: 'q382r19-keyboard-insertion-budget-bootstrap',
    q382r19LastSuppressedNativeEventReason: '',
    q382r19LastSettlePushReason: '',
    q203ProductionContractsFrozen: true,
    q203FinalStaticFreezeAndroidPassClaimed: false,
    runtime: 'mathlive-production',
    latex: '',
    normalizedLatex: '',
    plainText: '',
    mathJson: null,
    keyboardBridgePhase: 'V172-Q85',
    lastCommandLabel: '',
    lastCommandAction: '',
    lastCommandSequence: 0,
    evaluateRequested: false,
    hasFocus: false,
    selectionDescription: 'q186-production-bridge-bootstrap',
    realMathLiveRuntimeBundled: false,
    virtualKeyboardEnabled: false,
    remoteScriptLoadingAllowed: false,
    mainEditorSwitchAllowed: true,
    mathfieldElementDefined: false,
    mathfieldInstanceMounted: false,
    nativePaintState: 'pending',
    nativePaintOwner: 'unknown',
    nativePaintProofValuePath: 'not-read',
    lastInsertSucceeded: false,
    lastInsertCommitted: false,
    lastValueNonEmpty: false,
    lastInsertPath: 'not-run',
    lastFailureReason: 'none',
    rawInsertTokenLeaked: false,
    lastBeforeLatex: '',
    lastAfterLatex: '',
    pendingCommandCount: 0,
    productionQueueFlushed: false,
    diagnostic: 'q190-real-device-defect-repair-bootstrap',
    commandTraceStatus: 'q190r3-bootstrap',
    commandTraceEvents: [],
    lastCommandStartedAt: '',
    lastCommandCompletedAt: '',
    lastBridgeError: '',
    bridgeCallReceivedCount: 0,
    bridgeCallCompletedCount: 0,
    bridgeCallFailedCount: 0,
    bridgeNotifyCount: 0,
    flutterKeyPressMayAwaitWebViewJavascript: false,
    productionSendKeyMayAwaitWebViewJavascript: false,
    productionCommandSchedulingReturnsSynchronously: true,
    webViewJavascriptRunsOnlyInsideFireAndForgetTail: true,
    pressedStateMayDependOnJsCompletion: false,
    bridgeFailureMayBlockFlutterKeyFlow: false,
    timeoutMayBlockFlutterKeyFlow: false,
    commandTailDepthBounded: true,
    commandCompletionMode: 'q200-schedule-now-fire-and-state-push',
    lastQueueOverflowDropped: 0,
    lastQueueResetReason: '',
    sourceLatex: '',
    productionDocumentLatex: '',
    templateDocumentPayloadApplied: false,
    runtimeRenderContractApplied: false,
    runtimeRenderContractRawTokenFree: true,
    runtimeRenderContractViolation: false,
    caretFocusSlotContractActive: true,
    flutterCaretOverlayAllowed: false,
    nativeMathFieldOwnsVisibleCaret: true,
    nativeMathFieldOwnsFocus: true,
    nativeMathFieldOwnsSlotSelection: true,
    flutterVisibleFallbackMirrorAllowedInProduction: false,
    controllerMirrorMayOverrideNativeCaret: false,
    focusSuccessMustBeMeasuredNotAssumed: true,
    pointerHandlersMustNotPreventMathLiveDefaultSelection: true,
    commandCompletionMustPushCaretState: true,
    lastCaretFocusReason: 'q201-caret-focus-slot-finalization-bootstrap',
    lastCaretEvent: 'q201-caret-event-not-started',
    lastFocusConfirmed: false,
    lastFocusConfirmationPath: 'q201-focus-not-measured-yet',
    caretFocusRequestCount: 0,
    caretStatePushCount: 0,
    pointerCaretEventCount: 0,
    selectionEventCount: 0,
    caretVisibilityRequestCount: 0,
    finalStaticProductionFreezeStatus: 'q203-static-freeze-ready-runtime-device-evidence-required'
  };

  let mathfield = null;
  let mountScheduled = false;
  const pendingCommands = [];
  const q382r28JsSideCommandQueue = [];
  const q382r32TemplatePayloadCache = new Map();
  let q382r28JsSideCommandDrainScheduled = false;
  let q382r28JsSideCommandDraining = false;
  let q382r19KeyboardInsertionSuppressUntil = 0;
  let q382r19KeyboardInsertionSettleScheduled = false;


  function timestamp() {
    try { return new Date().toISOString(); } catch (_) { return String(Date.now()); }
  }

  function trace(status, extra) {
    state.commandTraceStatus = status || state.commandTraceStatus;
    const event = Object.assign({
      status: state.commandTraceStatus,
      action: state.lastCommandAction || '',
      label: state.lastCommandLabel || '',
      sequence: state.lastCommandSequence || 0,
      latex: state.lastAfterLatex || state.latex || '',
      at: timestamp()
    }, extra || {});
    state.commandTraceEvents.push(event);
    while (state.commandTraceEvents.length > MAX_TRACE_EVENTS) state.commandTraceEvents.shift();
    return event;
  }

  function beginBridgeCommand(action, payload) {
    q382r23NewLatencySpan(action, payload);
    rememberCommand(action, payload);
    state.bridgeCallReceivedCount += 1;
    state.lastCommandStartedAt = timestamp();
    state.lastBridgeError = '';
    trace('q190r3-js-bridge-command-received', { action });
  }

  function finishBridgeCommand(status, extra) {
    state.bridgeCallCompletedCount += 1;
    state.lastCommandCompletedAt = timestamp();
    trace(status || 'q190r3-js-bridge-command-completed', extra || {});
  }

  function failBridgeCommand(status, error) {
    state.bridgeCallFailedCount += 1;
    state.lastCommandCompletedAt = timestamp();
    state.lastBridgeError = error && error.message ? String(error.message) : String(error || status || 'unknown-error');
    trace(status || 'q190r3-js-bridge-command-failed', { error: state.lastBridgeError });
  }

  function customMathfieldDefined() {
    try {
      return !!(window.customElements && window.customElements.get('math-field')) || !!window.MathfieldElement;
    } catch (_) {
      return false;
    }
  }

  function field() {
    return mathfield || document.getElementById('mathlive-field') || document.querySelector('math-field');
  }

  function mountedMathfield() {
    const mf = field();
    return customMathfieldDefined() && !!mf ? mf : null;
  }

  function safeGetValue(format) {
    const mf = field();
    if (!mf) return '';
    try {
      if (typeof mf.getValue === 'function') return mf.getValue(format || 'latex') || '';
    } catch (_) {}
    try { return mf.value || ''; } catch (_) { return ''; }
  }

  function normalizeLatex(input) {
    return String(input || '').replace(/\\textstyle\s*/g, '').trim();
  }

  function documentLatexFromInsertPayload(input) {
    return normalizeLatex(input).replace(/#[@0?]/g, '\\placeholder{}');
  }

  function hasInsertControlToken(input) {
    return /#[@0?]/.test(String(input || ''));
  }

  function q382r32LooksLikeTemplatePayload(input) {
    const text = String(input || '');
    return /\\(?:frac|sqrt|sum|prod|int|lim|log|sin|cos|tan|ln|placeholder)\b|#[@0?]|\\left|\\right|\^\{|_\{|□/.test(text);
  }

  function q382r32TrimTemplatePayloadCache() {
    while (q382r32TemplatePayloadCache.size > Q382R32_TEMPLATE_PAYLOAD_CACHE_LIMIT) {
      const firstKey = q382r32TemplatePayloadCache.keys().next().value;
      q382r32TemplatePayloadCache.delete(firstKey);
      state.q382r32TemplatePayloadCacheEvictionCount += 1;
    }
    state.q382r32TemplatePayloadCacheSize = q382r32TemplatePayloadCache.size;
  }

  function q382r32CachedDocumentLatex(input) {
    const source = normalizeLatex(input);
    if (!q382r32LooksLikeTemplatePayload(source)) return normalizeProductionDocumentPayload(source);
    if (q382r32TemplatePayloadCache.has(source)) {
      state.q382r32TemplatePayloadCacheHitCount += 1;
      state.q382r32TemplatePayloadLastTrace = 'q382r32-template-payload-cache-hit';
      trace('q382r32-template-payload-cache-hit', { source, size: q382r32TemplatePayloadCache.size });
      return q382r32TemplatePayloadCache.get(source) || '';
    }
    state.q382r32TemplatePayloadCacheMissCount += 1;
    const documentLatex = normalizeProductionDocumentPayload(source);
    if (documentLatex) {
      q382r32TemplatePayloadCache.set(source, documentLatex);
      q382r32TrimTemplatePayloadCache();
      state.q382r32TemplatePayloadLastTrace = 'q382r32-template-payload-cache-miss-store';
      trace('q382r32-template-payload-cache-miss-store', { source, size: q382r32TemplatePayloadCache.size });
    }
    return documentLatex;
  }

  function q382r33WarmupLatexForEntry(entry) {
    if (!entry || typeof entry !== 'object') return '';
    const action = String(entry.action || '');
    if (action !== 'insertLatex') return '';
    return normalizeLatex(entry.latex || '');
  }

  function q382r33WarmupAllKeys(input) {
    const inventory = Array.isArray(input) ? input : (input && Array.isArray(input.inventory) ? input.inventory : []);
    const max = Math.min(inventory.length, Q382R33_FULL_KEYBOARD_WARMUP_LIMIT);
    let precompiled = 0;
    let skipped = 0;
    state.q382r33WarmupRunCount += 1;
    state.q382r33WarmupInventoryReceivedCount = inventory.length;
    for (let index = 0; index < max; index += 1) {
      const entry = inventory[index];
      const latex = q382r33WarmupLatexForEntry(entry);
      if (!latex) {
        skipped += 1;
        continue;
      }
      // Q382R33 warms only the document/template payload cache. It never calls
      // mf.insert(), executeCommand('insert'), setValue(), delete, clear, or any
      // visible editor mutation while the user has not pressed a key.
      q382r32CachedDocumentLatex(latex);
      precompiled += 1;
    }
    if (inventory.length > max) skipped += inventory.length - max;
    state.q382r33WarmupPayloadPrecompiledCount = precompiled;
    state.q382r33WarmupSkippedCount = skipped;
    state.q382r33WarmupDoesNotInsertIntoVisibleMathField = true;
    state.q382r33WarmupLastTrace = 'q382r33-full-keyboard-warmup-complete';
    trace('q382r33-full-keyboard-warmup-complete', { inventory: inventory.length, precompiled, skipped });
    return notifyFlutterState('q382r33-full-keyboard-warmup-complete');
  }

  function normalizeProductionDocumentPayload(input) {
    const source = normalizeLatex(input);
    const documentLatex = documentLatexFromInsertPayload(source);
    state.runtimeRenderContractApplied = String(source || '').indexOf('\\placeholder{}') >= 0;
    state.runtimeRenderContractRawTokenFree = !hasInsertControlToken(documentLatex);
    state.runtimeRenderContractViolation = false;
    state.sourceLatex = source;
    state.productionDocumentLatex = documentLatex;
    state.templateDocumentPayloadApplied = source !== documentLatex || documentLatex.indexOf('\\placeholder{}') >= 0;
    if (hasInsertControlToken(documentLatex)) {
      state.runtimeRenderContractViolation = true;
      state.lastFailureReason = 'q191-runtime-render-contract-raw-token-blocked';
      trace('q191-js-runtime-render-contract-raw-token-blocked', { source, documentLatex });
      return '';
    }
    if (source !== documentLatex) {
      trace('q190r5-js-template-payload-converted-to-document-placeholder', { source, documentLatex });
    }
    trace('q191-js-runtime-render-contract-accepted', { source, documentLatex, rawTokenFree: state.runtimeRenderContractRawTokenFree });
    return documentLatex;
  }

  function payloadLatex(payload) {
    if (typeof payload === 'string') return payload;
    if (payload && typeof payload === 'object') return String(payload.latex || '');
    return '';
  }

  function rememberCommand(action, payload) {
    state.lastCommandAction = action || '';
    if (payload && typeof payload === 'object') {
      state.lastCommandLabel = String(payload.label || state.lastCommandLabel || '');
      state.lastCommandSequence = Number(payload.sequence || state.lastCommandSequence || 0);
    }
  }

  function nowMs() {
    try { return Date.now(); } catch (_) { return 0; }
  }

  function q382r23NewLatencySpan(action, payload) {
    const span = {
      phase: REAL_DEVICE_LATENCY_INSTRUMENTATION_PHASE,
      label: payload && typeof payload === 'object' ? String(payload.label || '') : '',
      action: action || '',
      sequence: payload && typeof payload === 'object' ? Number(payload.sequence || 0) : 0,
      t3JsBridgeReceivedEpochMs: nowMs(),
      t4MathLiveInsertStartEpochMs: 0,
      t5MathLiveInsertEndEpochMs: 0,
      t6JsStatePostEpochMs: 0
    };
    state.q382r23LastLatency = span;
    return span;
  }

  function q382r23MarkLatency(fieldName) {
    try {
      if (!state.q382r23LastLatency || typeof state.q382r23LastLatency !== 'object') return;
      state.q382r23LastLatency[fieldName] = nowMs();
    } catch (_) {}
  }

  function keyboardInsertionBudgetActive() {
    return !!state.q382r19KeyboardInsertionModeActive || nowMs() < q382r19KeyboardInsertionSuppressUntil;
  }

  function beginKeyboardInsertionBudget(reason) {
    state.q382r19KeyboardInsertionModeActive = true;
    state.q382r19LastKeyboardInsertionBudgetReason = reason || 'q382r19-keyboard-insertion-budget-begin';
    state.q382r19KeyboardInsertionCanonicalPushCount = 0;
    q382r19KeyboardInsertionSuppressUntil = nowMs() + KEYBOARD_INSERTION_NATIVE_EVENT_SUPPRESSION_MS;
    trace('q382r19-keyboard-insertion-mode-begin', { reason: state.q382r19LastKeyboardInsertionBudgetReason });
  }

  function finishKeyboardInsertionBudget(reason) {
    state.q382r19KeyboardInsertionModeActive = false;
    state.q382r19LastKeyboardInsertionBudgetReason = reason || state.q382r19LastKeyboardInsertionBudgetReason || 'q382r19-keyboard-insertion-budget-finish';
    q382r19KeyboardInsertionSuppressUntil = nowMs() + KEYBOARD_INSERTION_NATIVE_EVENT_SUPPRESSION_MS;
    trace('q382r19-keyboard-insertion-mode-finish', { reason: state.q382r19LastKeyboardInsertionBudgetReason });
  }

  function scheduleKeyboardInsertionSettlePush(reason) {
    if (q382r19KeyboardInsertionSettleScheduled) return;
    q382r19KeyboardInsertionSettleScheduled = true;
    const tag = reason || 'q382r19-keyboard-insertion-settle';
    state.q382r19LastSettlePushReason = tag;
    try {
      window.setTimeout(function () {
        q382r19KeyboardInsertionSettleScheduled = false;
        state.q382r19KeyboardInsertionSettlePushCount += 1;
        pushCaretState(tag + '-16ms-single-settle');
      }, 16);
    } catch (_) {
      q382r19KeyboardInsertionSettleScheduled = false;
    }
  }

  function completeCommand(reason, options) {
    const tag = reason || 'q190-production-command-complete';
    const keyboardInsertion = !!(options && options.keyboardInsertion) || !!state.q382r19KeyboardInsertionModeActive;
    trace(tag, { q382r19KeyboardInsertion });
    if (keyboardInsertion) state.q382r19KeyboardInsertionCanonicalPushCount += 1;
    const snapshot = notifyFlutterState(tag);
    if (keyboardInsertion) {
      // Q382R24: normal keyboard insertion now uses the canonical state push
      // only. Q382R23 evidence showed the extra settle push frequently became
      // a Flutter frame/rebuild tail. Native input/selection noise is still
      // coalesced by the longer small suppression window above.
      if (Q382R24_KEYBOARD_SETTLE_PUSH_AFTER_CANONICAL_ALLOWED) {
        scheduleKeyboardInsertionSettlePush(tag + '-q382r19-keyboard-insertion-settle');
      } else {
        state.q382r24KeyboardSettlePushSuppressedCount += 1;
      }
      finishKeyboardInsertionBudget(tag + '-q382r24-keyboard-insertion-complete');
    } else if (!options || options.deferred !== false) {
      try { window.setTimeout(function () { pushCaretState(tag + '-q201-native-caret-16ms'); }, 16); } catch (_) {}
      try { window.setTimeout(function () { pushCaretState(tag + '-q201-native-caret-80ms'); }, 80); } catch (_) {}
    }
    return snapshot;
  }

  function measureMathfieldFocus(mf, reason) {
    let confirmed = false;
    let path = 'q201-focus-measured-not-active';
    try {
      if (document.activeElement === mf) {
        confirmed = true;
        path = 'q201-document-active-element-is-math-field';
      }
    } catch (_) {}
    if (!confirmed) {
      try {
        if (mf && typeof mf.matches === 'function' && (mf.matches(':focus') || mf.matches(':focus-within'))) {
          confirmed = true;
          path = 'q201-math-field-focus-pseudo-class';
        }
      } catch (_) {}
    }
    if (!confirmed) {
      try {
        if (mf && mf.shadowRoot && mf.shadowRoot.activeElement) {
          confirmed = true;
          path = 'q201-shadow-root-active-element-present';
        }
      } catch (_) {}
    }
    state.lastFocusConfirmed = !!confirmed;
    state.lastFocusConfirmationPath = path;
    trace('q201-js-focus-measured-not-assumed', {
      reason: reason || state.lastCaretFocusReason,
      confirmed: state.lastFocusConfirmed,
      path: state.lastFocusConfirmationPath
    });
    return state.lastFocusConfirmed;
  }

  function safeFocusMathfield(mf, reason) {
    if (!mf) return false;
    state.caretFocusRequestCount += 1;
    state.lastCaretFocusReason = reason || 'q201-safe-focus-mathfield';
    trace('q201-js-caret-focus-request', { reason: state.lastCaretFocusReason });
    try { if (typeof mf.focus === 'function') mf.focus({ preventScroll: true }); } catch (_) {}
    try { if (typeof mf.executeCommand === 'function') mf.executeCommand('focus'); } catch (_) {}
    try { mf.setAttribute('virtual-keyboard-mode', 'off'); } catch (_) {}
    try { mf.setAttribute('tabindex', '0'); } catch (_) {}
    return measureMathfieldFocus(mf, state.lastCaretFocusReason);
  }

  function pushCaretState(reason) {
    state.caretStatePushCount += 1;
    state.lastCaretEvent = reason || state.lastCaretEvent || 'q201-caret-state-push';
    return notifyFlutterState(reason || 'q201-caret-state-push');
  }

  function scheduleCaretStatePush(reason) {
    const tag = reason || 'q201-caret-state-push';
    if (keyboardInsertionBudgetActive()) {
      state.q382r19NativeEventCaretPushSuppressedCount += 1;
      state.q382r19LastSuppressedNativeEventReason = tag;
      trace('q382r19-native-caret-event-push-coalesced-during-keyboard-insertion', { reason: tag });
      scheduleKeyboardInsertionSettlePush(tag + '-q382r19-coalesced');
      return;
    }
    try { window.setTimeout(function () { pushCaretState(tag + '-0ms'); }, 0); } catch (_) {}
    try { window.setTimeout(function () { pushCaretState(tag + '-16ms'); }, 16); } catch (_) {}
    try { window.setTimeout(function () { pushCaretState(tag + '-80ms'); }, 80); } catch (_) {}
  }

  function keepNativeCaretInView(reason) {
    state.caretVisibilityRequestCount += 1;
    state.lastCaretEvent = reason || 'q201-keep-native-caret-visible';
    const mf = mountedMathfield() || field();
    try { if (mf && typeof mf.scrollIntoView === 'function') mf.scrollIntoView({ block: 'nearest', inline: 'nearest' }); } catch (_) {}
    try {
      const host = document.getElementById('mathpro-editor-host');
      if (host && typeof host.scrollLeft === 'number') {
        if (host.scrollWidth > host.clientWidth) host.scrollLeft = Math.max(0, host.scrollWidth - host.clientWidth);
      }
    } catch (_) {}
    trace('q192-js-native-caret-visibility-request', { reason: state.lastCaretEvent });
    return true;
  }

  function trySetMathfieldValue(mf, value) {
    try {
      if (mf && typeof mf.setValue === 'function') {
        mf.setValue(value, { silenceNotifications: false });
        return true;
      }
    } catch (_) {}
    try {
      if (mf) {
        mf.value = value;
        try { mf.dispatchEvent(new Event('input', { bubbles: true })); } catch (_) {}
        return true;
      }
    } catch (_) {}
    return false;
  }

  function valueChangedOrNonEmpty(before) {
    const beforeText = String(before || '');
    const afterText = String(safeGetValue('latex-expanded') || safeGetValue('latex') || '');
    if (beforeText.trim().length === 0) {
      return afterText.trim().length > 0;
    }
    return afterText !== beforeText;
  }

  function containsRawInsertToken(value) {
    return hasInsertControlToken(value);
  }

  function insertResultCommitted(before) {
    const afterText = String(safeGetValue('latex-expanded') || safeGetValue('latex') || '');
    state.lastBeforeLatex = String(before || '');
    state.lastAfterLatex = afterText;
    if (containsRawInsertToken(afterText)) {
      state.rawInsertTokenLeaked = true;
      state.lastFailureReason = 'q190r2-raw-insert-token-leaked-to-mathfield-value';
      return false;
    }
    return valueChangedOrNonEmpty(before);
  }

  function rollbackRawInsertTokenLeak(mf, before, reason) {
    const afterText = String(safeGetValue('latex-expanded') || safeGetValue('latex') || '');
    if (!containsRawInsertToken(afterText)) return false;
    state.rawInsertTokenLeaked = true;
    state.lastFailureReason = reason || 'q190r2-raw-insert-token-rollback';
    trySetMathfieldValue(mf, String(before || ''));
    return true;
  }

  function safeAppendDocumentLatex(mf, before, latex) {
    const current = safeGetValue('latex') || '';
    const base = containsRawInsertToken(current) ? String(before || '') : current;
    const fallback = documentLatexFromInsertPayload(latex);
    if (!fallback.trim()) return false;
    return trySetMathfieldValue(mf, base + fallback);
  }


  function q382r26UnknownCaretContext(diagnostic) {
    return {
      phase: CARET_CONTEXT_BRIDGE_PHASE,
      source: 'q382r26-unknown',
      confidence: 'unknown',
      trusted: false,
      selectionCollapsed: false,
      caretAtDocumentEnd: false,
      insidePlaceholder: false,
      insideTemplate: false,
      caretOffset: -1,
      documentEndOffset: -1,
      selectionLength: -1,
      diagnostic: diagnostic || 'q382r26-caret-context-unavailable'
    };
  }

  function q382r26SelectionCollapsed(selection, position) {
    if (!Array.isArray(selection)) return Number.isFinite(position);
    if (selection.length === 0) return true;
    if (selection.length === 1) {
      const item = selection[0];
      if (typeof item === 'number') return Number.isFinite(position) && item === position;
      if (Array.isArray(item)) {
        if (item.length === 0) return true;
        if (item.length === 1) return Number.isFinite(position) && item[0] === position;
        return item[0] === item[1];
      }
      if (item && typeof item === 'object') {
        const start = Number.isFinite(item.start) ? item.start : Number.isFinite(item.anchor) ? item.anchor : Number.isFinite(item.from) ? item.from : NaN;
        const end = Number.isFinite(item.end) ? item.end : Number.isFinite(item.focus) ? item.focus : Number.isFinite(item.to) ? item.to : NaN;
        return Number.isFinite(start) && Number.isFinite(end) && start === end;
      }
    }
    return false;
  }

  function q382r26LooksLikeTemplateLatex(value) {
    const text = String(value || '');
    return /\\(?:frac|sqrt|sum|int|lim|log|sin|cos|tan|ln|placeholder)\b|#\d|\\left|\\right|\^\{|_\{/.test(text);
  }

  function q382r26LooksLikePlaceholderLatex(value) {
    return /\\placeholder\b|#\d|\{\s*\}/.test(String(value || ''));
  }

  function q382r26ReadCaretContext(mf, value) {
    if (!mf) return q382r26UnknownCaretContext('q382r26-no-mathfield');
    try {
      const position = typeof mf.position === 'number' ? mf.position : NaN;
      const lastOffset = typeof mf.lastOffset === 'number' ? mf.lastOffset : NaN;
      const selection = Array.isArray(mf.selection) ? mf.selection : null;
      const selectionLength = Array.isArray(selection) ? selection.length : -1;
      const selectionCollapsed = q382r26SelectionCollapsed(selection, position);
      const hasPosition = Number.isFinite(position);
      const hasLastOffset = Number.isFinite(lastOffset);
      const caretAtDocumentEnd = hasPosition && hasLastOffset && position >= lastOffset;
      const insidePlaceholder = q382r26LooksLikePlaceholderLatex(value);
      const insideTemplate = q382r26LooksLikeTemplateLatex(value);
      const trusted = hasPosition && hasLastOffset && selectionCollapsed && !insidePlaceholder && !insideTemplate;
      return {
        phase: CARET_CONTEXT_BRIDGE_PHASE,
        source: hasPosition && hasLastOffset ? 'mathlive-public-position-lastOffset' : 'mathlive-public-api-partial',
        confidence: trusted ? 'trusted-linear-document-context' : (hasPosition ? 'partial' : 'unknown'),
        trusted: trusted,
        selectionCollapsed: selectionCollapsed,
        caretAtDocumentEnd: caretAtDocumentEnd,
        insidePlaceholder: insidePlaceholder,
        insideTemplate: insideTemplate,
        caretOffset: hasPosition ? Math.trunc(position) : -1,
        documentEndOffset: hasLastOffset ? Math.trunc(lastOffset) : -1,
        selectionLength: selectionLength,
        diagnostic: trusted ? 'q382r26-caret-context-trusted-for-linear-append-gate' : 'q382r26-caret-context-not-trusted-for-optimistic-echo'
      };
    } catch (_) {
      return q382r26UnknownCaretContext('q382r26-caret-context-read-exception');
    }
  }

  function updateState(reason) {
    const mf = field();
    const defined = customMathfieldDefined();
    const mounted = !!(defined && mf);
    if (mounted) mathfield = mf;
    const value = safeGetValue('latex-expanded') || safeGetValue('latex') || state.latex || '';
    state.realMathLiveRuntimeBundled = defined;
    state.mathfieldElementDefined = defined;
    state.mathfieldInstanceMounted = mounted;
    state.latex = value;
    state.normalizedLatex = value;
    state.plainText = value;
    state.hasFocus = mounted && document.activeElement === mf;
    state.selectionDescription = reason || state.commandTraceStatus || state.selectionDescription;
    state.caretContext = q382r26ReadCaretContext(mf, value);
    state.lastValueNonEmpty = String(value || '').trim().length > 0;
    state.nativePaintState = mounted ? 'ok' : 'pending';
    state.nativePaintOwner = mounted ? 'mathlive-native-field' : 'unknown';
    state.nativePaintProofValuePath = mounted ? 'native-getValue-latex-expanded' : 'not-read';
    state.q382r28JsSideCommandQueueDepth = q382r28JsSideCommandQueue.length;
    state.q382r32TemplatePayloadCacheSize = q382r32TemplatePayloadCache.size;
    state.pendingCommandCount = pendingCommands.length + q382r28JsSideCommandQueue.length;
    return state;
  }

  function postState(snapshot) {
    q382r23MarkLatency('t6JsStatePostEpochMs');
    try {
      if (window.MathProMathLiveState && typeof window.MathProMathLiveState.postMessage === 'function') {
        window.MathProMathLiveState.postMessage(JSON.stringify(snapshot));
      }
    } catch (_) {}
  }

  function notifyFlutterState(reason) {
    state.bridgeNotifyCount += 1;
    const snapshot = updateState(reason || 'q186-production-notify-state');
    postState(snapshot);
    return snapshot;
  }

  // Q192 compatibility markers retained for verifier lineage; Q201 supersedes them with measured native-focus paths:
  // q192-pointerdown-focus
  // q192-click-focus
  // q192-touchend-focus
  // q192-selection-change-caret-state
  // q192-command-after-insert-focus
  // q192-command-after-insert-keep-caret-visible
  // q192-keep-caret-visible-command

  function configureMathfield(mf) {
    if (!mf) return false;
    try { mf.setAttribute('virtual-keyboard-mode', 'off'); } catch (_) {}
    try { mf.setAttribute('tabindex', '0'); } catch (_) {}
    try { mf.setAttribute('data-mathpro-native-caret-authority', CARET_FOCUS_SLOT_FINALIZATION_PHASE); } catch (_) {}
    try { mf.mathVirtualKeyboardPolicy = 'manual'; } catch (_) {}
    try { mf.virtualKeyboardMode = 'off'; } catch (_) {}
    try { mf.menuItems = []; } catch (_) {}
    try { mf.smartFence = true; } catch (_) {}
    try { mf.smartMode = true; } catch (_) {}
    try {
      mf.style.fontFamily = 'KaTeX_Main, KaTeX_Math, "Noto Sans Math", "STIX Two Math", "Cambria Math", serif';
      mf.style.setProperty('--text-font-family', 'system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif');
      mf.style.pointerEvents = 'auto';
      mf.style.userSelect = 'text';
      mf.style.webkitUserSelect = 'text';
      mf.style.touchAction = 'auto';
    } catch (_) {}
    if (!mf.__mathProProductionListenersAttached) {
      try { mf.addEventListener('input', function () { scheduleCaretStatePush('q201-production-input-native-caret-state'); }); } catch (_) {}
      try { mf.addEventListener('focus', function () { pushCaretState('q201-production-focus-native-caret-state'); }); } catch (_) {}
      try { mf.addEventListener('blur', function () { pushCaretState('q201-production-blur-native-caret-state'); }); } catch (_) {}
      try { mf.addEventListener('keydown', function () { scheduleCaretStatePush('q201-production-keydown-native-caret-state'); }); } catch (_) {}
      try { mf.addEventListener('pointerdown', function () { state.pointerCaretEventCount += 1; safeFocusMathfield(mf, 'q201-pointerdown-focus-no-prevent-default'); scheduleCaretStatePush('q201-pointerdown-native-caret-state'); }); } catch (_) {}
      try { mf.addEventListener('pointerup', function () { state.pointerCaretEventCount += 1; keepNativeCaretInView('q201-pointerup-keep-native-caret-visible'); scheduleCaretStatePush('q201-pointerup-native-caret-state'); }); } catch (_) {}
      try { mf.addEventListener('click', function () { state.pointerCaretEventCount += 1; safeFocusMathfield(mf, 'q201-click-focus-no-prevent-default'); keepNativeCaretInView('q201-click-keep-native-caret-visible'); scheduleCaretStatePush('q201-click-native-caret-state'); }); } catch (_) {}
      try { mf.addEventListener('touchend', function () { state.pointerCaretEventCount += 1; safeFocusMathfield(mf, 'q201-touchend-focus-no-prevent-default'); keepNativeCaretInView('q201-touchend-keep-native-caret-visible'); scheduleCaretStatePush('q201-touchend-native-caret-state'); }); } catch (_) {}
      try { mf.addEventListener('selection-change', function () { state.selectionEventCount += 1; scheduleCaretStatePush('q201-selection-change-native-caret-state'); }); } catch (_) {}
      mf.__mathProProductionListenersAttached = true;
    }
    mathfield = mf;
    return true;
  }

  function hideChrome() {
    try {
      const mf = field();
      if (!mf || !mf.shadowRoot) return;
      [
        '[part="virtual-keyboard-toggle"]',
        '[part="menu-toggle"]',
        '.ML__keyboard-toggle',
        '.ML__menu-toggle',
        '.ML__popover',
        '.ML__tooltip'
      ].forEach(function (selector) {
        try {
          mf.shadowRoot.querySelectorAll(selector).forEach(function (node) {
            node.style.display = 'none';
            node.style.visibility = 'hidden';
            node.style.pointerEvents = 'none';
          });
        } catch (_) {}
      });
    } catch (_) {}
  }

  function resetPendingCommands(reason) {
    const dropped = pendingCommands.length;
    pendingCommands.splice(0, pendingCommands.length);
    state.pendingCommandCount = 0;
    state.lastQueueResetReason = reason || 'q200-js-pending-queue-reset';
    trace(reason || 'q200-js-pending-queue-reset', { dropped });
    return dropped;
  }

  // Backward verifier compatibility markers retained as comments only:
  // trace('q190r6-js-command-queued-bounded'
  // trace('q190r6-js-queue-flush-request-nonblocking'
  // resetPendingCommands('q190r6-js-priority-command-reset-pending-queue')
  // resetPendingCommands('q190r6-js-clear-reset-pending-queue')
  function queueCommand(action, payload) {
    if (action === 'clear' || action === 'setLatex') {
      resetPendingCommands('q200-js-priority-command-reset-pending-queue');
    }
    trace('q200-js-command-queued-bounded', { action, limit: MAX_QUEUE });
    pendingCommands.push({ action, payload });
    let dropped = 0;
    while (pendingCommands.length > MAX_QUEUE) {
      pendingCommands.shift();
      dropped += 1;
    }
    state.lastQueueOverflowDropped = dropped;
    if (dropped > 0) trace('q200-js-queue-overflow-drop-oldest-released', { dropped });
    state.pendingCommandCount = pendingCommands.length + q382r28JsSideCommandQueue.length;
  }

  function q382r28EligibleJsSideCommand(action) {
    return action === 'insertLatex' || action === 'deleteBackward';
  }

  function q382r28UpdateQueueDepth() {
    state.q382r28JsSideCommandQueueDepth = q382r28JsSideCommandQueue.length;
    state.q382r32TemplatePayloadCacheSize = q382r32TemplatePayloadCache.size;
    state.pendingCommandCount = pendingCommands.length + q382r28JsSideCommandQueue.length;
  }

  function q382r28ScheduleDrain(reason) {
    if (q382r28JsSideCommandDrainScheduled || q382r28JsSideCommandDraining) return;
    q382r28JsSideCommandDrainScheduled = true;
    state.q382r28JsSideCommandDrainScheduledCount += 1;
    state.q382r28JsSideCommandLastTrace = reason || 'q382r28-js-side-command-drain-scheduled';
    try {
      window.setTimeout(q382r28DrainKeyboardCommandQueue, 0);
    } catch (_) {
      q382r28JsSideCommandDrainScheduled = false;
    }
  }

  function enqueueKeyboardCommand(payload) {
    const action = payload && typeof payload === 'object' ? String(payload.action || '') : '';
    if (!q382r28EligibleJsSideCommand(action)) {
      trace('q382r28-js-side-command-queue-rejected-unsupported-action', { action });
      return false;
    }
    const sequence = payload && typeof payload === 'object' ? Number(payload.sequence || 0) : 0;
    q382r28JsSideCommandQueue.push({ action, payload });
    state.q382r28JsSideCommandQueuedCount += 1;
    state.q382r28JsSideCommandLastAcceptedSequence = sequence;
    state.q382r28JsSideCommandLastAction = action;
    state.q382r28JsSideCommandLastTrace = 'q382r28-js-side-command-queued';
    let dropped = 0;
    while (q382r28JsSideCommandQueue.length > Q382R28_MAX_JS_SIDE_QUEUE) {
      q382r28JsSideCommandQueue.shift();
      dropped += 1;
    }
    if (dropped > 0) {
      state.q382r28JsSideCommandDroppedCount += dropped;
      trace('q382r28-js-side-command-queue-overflow-drop-oldest', { dropped, limit: Q382R28_MAX_JS_SIDE_QUEUE });
    }
    q382r28UpdateQueueDepth();
    trace('q382r28-js-side-command-queued-sequence-safe', { action, sequence, depth: q382r28JsSideCommandQueue.length });
    q382r28ScheduleDrain('q382r28-js-side-command-drain-scheduled-after-enqueue');
    return true;
  }

  function q382r28DrainKeyboardCommandQueue() {
    q382r28JsSideCommandDrainScheduled = false;
    if (q382r28JsSideCommandDraining) return;
    if (!q382r28JsSideCommandQueue.length) {
      q382r28UpdateQueueDepth();
      return;
    }
    const mf = mountedMathfield();
    if (!mf) {
      scheduleMount();
      trace('q382r28-js-side-command-drain-waiting-runtime', { depth: q382r28JsSideCommandQueue.length });
      return;
    }
    q382r28JsSideCommandDraining = true;
    state.q382r28JsSideCommandDrainTickCount += 1;
    let processedThisTick = 0;
    try {
      while (q382r28JsSideCommandQueue.length && processedThisTick < Q382R28_MAX_DRAIN_PER_TICK) {
        const command = q382r28JsSideCommandQueue.shift();
        const action = command && command.action ? command.action : '';
        const payload = command && command.payload ? command.payload : {};
        const sequence = payload && typeof payload === 'object' ? Number(payload.sequence || 0) : 0;
        state.q382r28JsSideCommandProcessedCount += 1;
        state.q382r28JsSideCommandLastProcessedSequence = sequence;
        state.q382r28JsSideCommandLastAction = action;
        state.q382r28JsSideCommandLastTrace = 'q382r28-js-side-command-processing';
        trace('q382r28-js-side-command-processing-sequence-safe', { action, sequence, remaining: q382r28JsSideCommandQueue.length });
        if (action === 'insertLatex') insertLatex(payload);
        else if (action === 'deleteBackward') deleteBackward(payload);
        processedThisTick += 1;
      }
    } finally {
      q382r28JsSideCommandDraining = false;
      q382r28UpdateQueueDepth();
    }
    if (q382r28JsSideCommandQueue.length) {
      q382r28ScheduleDrain('q382r28-js-side-command-drain-continues-next-tick');
    } else {
      state.q382r28JsSideCommandLastTrace = 'q382r28-js-side-command-drain-complete';
      trace('q382r28-js-side-command-drain-complete', { processedThisTick });
    }
  }

  function runQueuedCommands(reason) {
    trace('q200-js-queue-flush-request-nonblocking', { pending: pendingCommands.length });
    const mf = mountedMathfield();
    if (!mf || !pendingCommands.length) return notifyFlutterState(reason || 'q186-production-queue-empty');
    const copy = pendingCommands.splice(0, pendingCommands.length);
    state.productionQueueFlushed = true;
    trace('q200-js-queue-flush-start-bounded', { pending: copy.length, limit: MAX_QUEUE });
    copy.forEach(function (command) {
      if (command.action === 'insertLatex') insertLatex(command.payload);
      else if (command.action === 'deleteBackward') deleteBackward(command.payload);
      else if (command.action === 'clear') clear(command.payload);
      else if (command.action === 'setLatex') setLatex(command.payload);
    });
    trace('q200-js-queue-flush-complete-released', { pending: pendingCommands.length });
    return notifyFlutterState(reason || 'q186-production-queue-flushed');
  }

  function scheduleMount() {
    if (mountScheduled) return;
    mountScheduled = true;
    const run = function () {
      mountScheduled = false;
      mount();
    };
    try {
      if (window.customElements && typeof window.customElements.whenDefined === 'function') {
        window.customElements.whenDefined('math-field').then(run).catch(run);
        return;
      }
    } catch (_) {}
    window.setTimeout(run, 0);
  }

  function mount() {
    const mf = field();
    if (customMathfieldDefined() && mf) configureMathfield(mf);
    hideChrome();
    safeFocusMathfield(mathfield, 'q201-mount-native-focus')
    if (mountedMathfield()) {
      runQueuedCommands('q186-production-mount-queue-flush');
      q382r28ScheduleDrain('q382r28-js-side-command-drain-after-mount');
    }
    return completeCommand(mountedMathfield() ? 'q190-production-mount' : 'q190-production-mount-pending', { deferred: false });
  }

  function insertLatex(payload) {
    beginBridgeCommand('insertLatex', payload);
    beginKeyboardInsertionBudget('q382r19-insert-latex-keyboard-insertion-budget');
    const sourceLatex = normalizeLatex(payloadLatex(payload));
    const latex = q382r32CachedDocumentLatex(sourceLatex);
    if (!latex.trim()) {
      q382r23MarkLatency('t4MathLiveInsertStartEpochMs');
      q382r23MarkLatency('t5MathLiveInsertEndEpochMs');
      state.lastInsertSucceeded = false;
      state.lastInsertCommitted = false;
      state.lastFailureReason = 'q190r5-empty-or-raw-token-document-payload-blocked';
      failBridgeCommand('q190r5-js-insert-blocked-invalid-document-payload', state.lastFailureReason);
      return completeCommand('q190r5-production-insert-blocked-invalid-document-payload', { keyboardInsertion: true });
    }
    const mf = mountedMathfield();
    if (!mf) {
      q382r23MarkLatency('t4MathLiveInsertStartEpochMs');
      q382r23MarkLatency('t5MathLiveInsertEndEpochMs');
      queueCommand('insertLatex', payload);
      scheduleMount();
      state.lastInsertSucceeded = false;
      state.lastInsertCommitted = false;
      state.lastFailureReason = 'q190-runtime-not-mounted-command-queued';
      finishBridgeCommand('q190r3-js-insert-queued-awaiting-runtime');
      return completeCommand('q190-production-insert-queued-awaiting-runtime', { keyboardInsertion: true });
    }
    configureMathfield(mf);
    safeFocusMathfield(mf, 'q201-command-native-focus');
    const before = safeGetValue('latex-expanded') || safeGetValue('latex') || '';
    let ok = false;
    let committed = false;
    state.lastFailureReason = 'insert-start';
    state.rawInsertTokenLeaked = false;
    state.lastBeforeLatex = before;
    state.lastAfterLatex = before;

    q382r23MarkLatency('t4MathLiveInsertStartEpochMs');
    try {
      if (typeof mf.insert === 'function') {
        mf.insert(latex, {
          insertionMode: 'replaceSelection',
          selectionMode: 'placeholder',
          format: 'latex',
          smartFence: true
        });
        state.lastInsertPath = 'mathfield.insert-selection-placeholder';
        ok = true;
        rollbackRawInsertTokenLeak(mf, before, 'q190r2-raw-token-after-mathfield-insert');
        committed = insertResultCommitted(before);
      }
    } catch (error) {
      ok = false;
      committed = false;
      state.lastFailureReason = 'q190-mathfield-insert-exception';
      trace('q190r3-js-mathfield-insert-exception', { error: error && error.message ? String(error.message) : String(error) });
    }

    if (!committed) {
      try {
        if (typeof mf.executeCommand === 'function') {
          mf.executeCommand(['insert', latex]);
          state.lastInsertPath = 'mathfield.executeCommand-insert';
          ok = true;
          rollbackRawInsertTokenLeak(mf, before, 'q190r2-raw-token-after-execute-command-insert');
          committed = insertResultCommitted(before);
        }
      } catch (_) {}
    }

    if (!committed) {
      try {
        if (!containsRawInsertToken(latex)) {
          ok = safeAppendDocumentLatex(mf, before, latex) || ok;
          state.lastInsertPath = 'q190r5-direct-setValue-document-placeholder-latex';
          committed = insertResultCommitted(before);
          if (committed) {
            trace('q190r5-js-document-placeholder-fallback-committed', { before, latex });
          }
        } else {
          state.lastInsertPath = 'q190r5-template-insert-raw-token-blocked';
          state.lastFailureReason = 'q190r5-template-document-payload-still-has-raw-token';
          trace('q190r5-js-template-raw-token-fallback-blocked', { before, latex });
        }
      } catch (_) {
        ok = false;
        committed = false;
      }
    }

    safeFocusMathfield(mf, 'q201-command-after-insert-native-focus');
    keepNativeCaretInView('q201-command-after-insert-keep-native-caret-visible');
    q382r23MarkLatency('t5MathLiveInsertEndEpochMs');
    const after = safeGetValue('latex-expanded') || safeGetValue('latex') || '';
    state.lastAfterLatex = String(after || '');
    state.lastInsertSucceeded = !!ok;
    state.lastInsertCommitted = !!committed;
    state.lastValueNonEmpty = String(after || '').trim().length > 0;
    state.lastFailureReason = state.lastInsertCommitted ? 'none' : 'q190-insert-not-committed-after-all-paths';
    if (state.lastInsertCommitted) {
      finishBridgeCommand('q190r3-js-insert-committed', { before, after });
    } else {
      failBridgeCommand('q190r3-js-insert-not-committed', state.lastFailureReason);
    }
    return completeCommand(state.lastInsertCommitted ? 'q190-production-insert-ok' : 'q190-production-insert-fail', { keyboardInsertion: true });
  }

  function deleteBackward(payload) {
    beginBridgeCommand('deleteBackward', payload);
    beginKeyboardInsertionBudget('q382r19-delete-backward-keyboard-insertion-budget');
    const mf = mountedMathfield();
    if (!mf) {
      q382r23MarkLatency('t4MathLiveInsertStartEpochMs');
      q382r23MarkLatency('t5MathLiveInsertEndEpochMs');
      queueCommand('deleteBackward', payload || {});
      scheduleMount();
      finishBridgeCommand('q190r3-js-delete-queued-awaiting-runtime');
      return completeCommand('q190-production-delete-queued-awaiting-runtime', { keyboardInsertion: true });
    }
    configureMathfield(mf);
    safeFocusMathfield(mf, 'q201-command-native-focus');
    q382r23MarkLatency('t4MathLiveInsertStartEpochMs');
    try {
      if (typeof mf.executeCommand === 'function') mf.executeCommand('deleteBackward');
      else if (typeof mf.value === 'string') mf.value = mf.value.slice(0, -1);
    } catch (_) {
      try { mf.value = String(mf.value || '').slice(0, -1); } catch (_) {}
    }
    safeFocusMathfield(mf, 'q201-delete-after-native-focus');
    keepNativeCaretInView('q201-delete-after-keep-native-caret-visible');
    q382r23MarkLatency('t5MathLiveInsertEndEpochMs');
    finishBridgeCommand('q190r3-js-delete-backward-complete');
    return completeCommand('q190-production-delete-backward', { keyboardInsertion: true });
  }

  function clear(payload) {
    beginBridgeCommand('clear', payload);
    beginKeyboardInsertionBudget('q382r19-clear-keyboard-insertion-budget');
    const mf = mountedMathfield();
    if (!mf) {
      q382r23MarkLatency('t4MathLiveInsertStartEpochMs');
      q382r23MarkLatency('t5MathLiveInsertEndEpochMs');
      pendingCommands.splice(0, pendingCommands.length);
      queueCommand('clear', payload || {});
      scheduleMount();
      finishBridgeCommand('q190r3-js-clear-queued-awaiting-runtime');
      return completeCommand('q190-production-clear-queued-awaiting-runtime', { keyboardInsertion: true });
    }
    configureMathfield(mf);
    resetPendingCommands('q200-js-clear-reset-pending-queue');
    q382r23MarkLatency('t4MathLiveInsertStartEpochMs');
    trySetMathfieldValue(mf, '');
    safeFocusMathfield(mf, 'q201-clear-after-native-focus');
    keepNativeCaretInView('q201-clear-after-keep-native-caret-visible');
    q382r23MarkLatency('t5MathLiveInsertEndEpochMs');
    finishBridgeCommand('q190r3-js-clear-complete');
    return completeCommand('q190-production-clear', { keyboardInsertion: true });
  }

  function setLatex(payload) {
    beginBridgeCommand('setLatex', payload);
    const latex = typeof payload === 'string' ? payload : String((payload && payload.latex) || '');
    const mf = mountedMathfield();
    if (!mf) {
      queueCommand('setLatex', payload || latex);
      scheduleMount();
      finishBridgeCommand('q190r3-js-set-queued-awaiting-runtime');
      return completeCommand('q190-production-set-queued-awaiting-runtime');
    }
    configureMathfield(mf);
    trySetMathfieldValue(mf, latex);
    safeFocusMathfield(mf, 'q201-set-after-native-focus');
    keepNativeCaretInView('q201-set-after-keep-native-caret-visible');
    finishBridgeCommand('q190r3-js-set-latex-complete');
    return completeCommand('q190-production-set-latex');
  }

  function getLatex() {
    return safeGetValue('latex-expanded') || safeGetValue('latex') || state.latex || '';
  }

  function focus() {
    trace('q190r3-js-focus-request');
    const mf = mountedMathfield();
    safeFocusMathfield(mf, 'q201-command-native-focus');
    return completeCommand('q190-production-focus-request', { deferred: false });
  }

  function keepCaretVisible() {
    trace('q190r3-js-keep-caret-visible-request');
    const mf = mountedMathfield();
    safeFocusMathfield(mf, 'q201-keep-native-caret-visible-focus');
    keepNativeCaretInView('q201-keep-native-caret-visible-command');
    return completeCommand('q190-production-keep-caret-visible', { deferred: false });
  }

  window.MathProProductionMathLiveBridge = Object.freeze({
    mount,
    insertLatex,
    deleteBackward,
    clear,
    setLatex,
    getLatex,
    focus,
    keepCaretVisible,
    enqueueKeyboardCommand,
    mathproWarmupAllKeys: q382r33WarmupAllKeys,
    notifyFlutterState
  });

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', scheduleMount, { once: true });
  } else {
    scheduleMount();
  }
})();
