import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../theme/mathpro_tokens.dart';
import 'mathlive_keyboard_bridge_policy.dart';
import 'mathlive_lab_screen_policy.dart';
import 'mathlive_lab_smoke_evidence_export_policy.dart';
import 'mathlive_state_adapter.dart';
import 'mathlive_offline_asset_policy.dart';

/// V172-Q84 — isolated MathLive laboratory screen.
///
/// This is not the main editor and it does not switch MathPro away from the
/// legacy fallback engine. It only opens the local Q83 bootstrap asset inside a
/// controlled WebView when platform views are available. In flutter tests it
/// renders a static policy card instead of constructing a WebView.
class MathLiveLabScreen extends StatefulWidget {
  const MathLiveLabScreen({super.key});

  static const String routeName = '/mathlive-lab';
  static const String phase = 'V172-Q84';

  @override
  State<MathLiveLabScreen> createState() => _MathLiveLabScreenState();
}

class _MathLiveLabScreenState extends State<MathLiveLabScreen> {
  WebViewController? _controller;
  String _status = 'Q90R2 lab ready: runtime smoke waits for official local MathLive bundle evidence; Q86 state adapter and Q87 cursor court remain lab-only gates.';
  String _lastLatex = '';
  String _lastPlainText = '';
  String _lastStateDiagnostic = '';
  String _lastEvidenceCapture = '';

  @override
  void initState() {
    super.initState();
    _bootstrapWebViewIfAllowed();
  }

  Future<void> _bootstrapWebViewIfAllowed() async {
    if (!MathLiveLabScreenPolicy.canUseRuntimeWebView) return;
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..addJavaScriptChannel(
        'MathProMathLiveState',
        onMessageReceived: (message) {
          final snapshot = MathLiveStateAdapter.parseBridgeMessage(message.message);
          if (!mounted) return;
          setState(() {
            _status = 'Q90R2 lab event received through Q86 state adapter; Q87 cursor court still requires real device evidence';
            _lastLatex = snapshot.normalizedLatex;
            _lastPlainText = snapshot.plainText;
            _lastStateDiagnostic = snapshot.parseDiagnostic;
          });
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            final scheme = Uri.tryParse(request.url)?.scheme.toLowerCase() ?? '';
            if (scheme == 'http' || scheme == 'https') {
              setState(() => _status = 'Blocked remote MathLive navigation: ${request.url}');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (_) {
            if (!mounted) return;
            setState(() => _status = 'Q90R2 lab loaded local asset: ${MathLiveLabScreenPolicy.webViewAssetPath}; official runtime smoke remains gated');
          },
          onWebResourceError: (error) {
            if (!mounted) return;
            setState(() => _status = 'Q84 lab asset load error: ${error.description}');
          },
        ),
      );

    await controller.loadFlutterAsset(MathLiveLabScreenPolicy.webViewAssetPath);
    if (!mounted) return;
    setState(() => _controller = controller);
  }

  Future<void> _sendMathProKeyToLab(String label) async {
    final controller = _controller;
    if (controller == null) return;
    final command = MathLiveKeyboardBridgePolicy.commandForLabel(label, lastAnswer: '42');
    final payload = jsonEncode(command.toJson());
    await controller.runJavaScript(
      'window.MathProMathLiveOfflineBridge && '
      'window.MathProMathLiveOfflineBridge.executeMathProCommand($payload);',
    );
  }

  Future<void> _seedFractionDemo() => _sendMathProKeyToLab('□/□');

  Future<void> _runRuntimeSmokeProbe() async {
    final controller = _controller;
    if (controller == null) return;
    await controller.runJavaScript(
      'window.MathProMathLiveOfflineBridge && '
      'window.MathProMathLiveOfflineBridge.runRuntimeSmokeProbe && '
      'window.MathProMathLiveOfflineBridge.runRuntimeSmokeProbe();',
    );
    if (!mounted) return;
    setState(() {
      _status = 'Q90R2 runtime smoke probe requested; read returned bridge state below when the lab posts it.';
    });
  }

  Future<void> _captureRuntimeSmokeEvidence() async {
    final controller = _controller;
    if (controller == null) return;
    final raw = await controller.runJavaScriptReturningResult(
      'window.MathProMathLiveOfflineBridge && '
      'window.MathProMathLiveOfflineBridge.getRuntimeSmokeEvidenceCaptureJson && '
      'window.MathProMathLiveOfflineBridge.getRuntimeSmokeEvidenceCaptureJson();',
    );
    var value = raw.toString();
    if (value.startsWith('"') && value.endsWith('"')) {
      try {
        value = jsonDecode(value) as String;
      } catch (_) {
        // Keep the raw returned value if WebView already returned an object-like string.
      }
    }
    if (!mounted) return;
    setState(() {
      _lastEvidenceCapture = value;
      _status = 'Q90R6 evidence capture generated in Lab only. Copy it into tool/mathlive_lab_runtime_smoke_capture.json, then run the Q90R6/Q90R5 verifier chain.';
    });
  }


  Future<void> _copyRuntimeSmokeEvidenceCapture() async {
    final value = _lastEvidenceCapture.trim();
    if (value.isEmpty) {
      if (!mounted) return;
      setState(() {
        _status = 'Q90R7 copy blocked: generate Lab evidence first, then copy into tool/mathlive_lab_runtime_smoke_capture.json.';
      });
      return;
    }
    await Clipboard.setData(ClipboardData(text: value));
    if (!mounted) return;
    setState(() {
      _status = 'Q90R7 evidence capture copied. Paste it into ${MathLiveLabSmokeEvidenceExportPolicy.manualCaptureInput}, then run node tool/write_mathlive_lab_smoke_evidence.mjs and node tool/verify_mathlive_lab_smoke_evidence.mjs.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final canOpenLab = MathLiveLabScreenPolicy.canOpenLab(
      offlineAssetsDeclared: MathLiveOfflineAssetPolicy.offlineAssetRootDeclared,
      usesRemoteScripts: false,
      protectedSurfacesUnchanged: true,
    );

    return Scaffold(
      backgroundColor: MathProColors.bg,
      appBar: AppBar(
        backgroundColor: MathProColors.bg,
        foregroundColor: MathProColors.text,
        elevation: 0,
        title: const Text('MathLive Lab'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(MathProSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _LabStatusCard(
                canOpenLab: canOpenLab,
                status: _status,
                lastLatex: _lastLatex,
                lastPlainText: _lastPlainText,
                stateDiagnostic: _lastStateDiagnostic,
                evidenceCapture: _lastEvidenceCapture,
              ),
              const SizedBox(height: MathProSpacing.md),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(MathProRadius.lg),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: MathProColors.surface,
                      border: Border.all(color: MathProColors.border),
                      borderRadius: BorderRadius.circular(MathProRadius.lg),
                    ),
                    child: _buildLabSurface(),
                  ),
                ),
              ),
              const SizedBox(height: MathProSpacing.md),
              _LabActionRow(
                onSeedFraction: _controller == null ? null : _seedFractionDemo,
                onInsertSeven: _controller == null ? null : () => _sendMathProKeyToLab('7'),
                onBackspace: _controller == null ? null : () => _sendMathProKeyToLab('⌫'),
                onClear: _controller == null ? null : () => _sendMathProKeyToLab('C'),
                onSmoke: _controller == null ? null : _runRuntimeSmokeProbe,
                onEvidence: _controller == null ? null : _captureRuntimeSmokeEvidence,
                onCopyEvidence: _controller == null ? null : _copyRuntimeSmokeEvidenceCapture,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabSurface() {
    final controller = _controller;
    if (!MathLiveLabScreenPolicy.canUseRuntimeWebView) {
      return const _StaticLabFallback();
    }
    if (controller == null) {
      return const Center(
        child: Text(
          'Loading local MathLive lab asset...',
          key: ValueKey('mathlive-lab-loading'),
          textAlign: TextAlign.center,
          style: TextStyle(color: MathProColors.textSoft),
        ),
      );
    }
    return WebViewWidget(controller: controller);
  }
}

class _LabStatusCard extends StatelessWidget {
  const _LabStatusCard({
    required this.canOpenLab,
    required this.status,
    required this.lastLatex,
    required this.lastPlainText,
    required this.stateDiagnostic,
    required this.evidenceCapture,
  });

  final bool canOpenLab;
  final String status;
  final String lastLatex;
  final String lastPlainText;
  final String stateDiagnostic;
  final String evidenceCapture;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: MathProColors.panel,
        borderRadius: BorderRadius.circular(MathProRadius.lg),
        border: Border.all(color: MathProColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(MathProSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'V172-Q84–Q90R2 Isolated MathLive Lab Screen · Q86/Q87 active',
              key: ValueKey('mathlive-lab-title'),
              style: TextStyle(color: MathProColors.text, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: MathProSpacing.xs),
            Text(
              canOpenLab ? status : 'Q84 lab contract blocked: offline/protected-surface gate failed.',
              key: const ValueKey('mathlive-lab-status'),
              style: const TextStyle(color: MathProColors.textSoft, height: 1.35),
            ),
            const SizedBox(height: MathProSpacing.xs),
            const Text(
              'Main editor switch: disabled · MathLive virtual keyboard: disabled · CDN: forbidden · Q90R2 runtime smoke: lab-only · Q87 cursor court: blocked until device evidence',
              key: ValueKey('mathlive-lab-red-lines'),
              style: TextStyle(color: MathProColors.textMuted, fontSize: 12),
            ),
            const SizedBox(height: MathProSpacing.xs),
            const Text(
              'Q85 bridge: lab-only · MathPro keyboard commands are isolated to the lab surface',
              key: ValueKey('mathlive-lab-q85-bridge-label'),
              style: TextStyle(color: MathProColors.textMuted, fontSize: 12),
            ),
            if (lastLatex.isNotEmpty) ...[
              const SizedBox(height: MathProSpacing.xs),
              Text(
                'Last LaTeX: $lastLatex',
                key: const ValueKey('mathlive-lab-latex'),
                style: const TextStyle(color: MathProColors.accent, fontSize: 12),
              ),
              Text(
                'Plain: $lastPlainText · $stateDiagnostic',
                key: const ValueKey('mathlive-lab-state-adapter'),
                style: const TextStyle(color: MathProColors.textMuted, fontSize: 12),
              ),
            ],
            if (evidenceCapture.isNotEmpty) ...[
              const SizedBox(height: MathProSpacing.xs),
              Text(
                'Q90R7 copy-ready capture: ${evidenceCapture.length} chars · paste into tool/mathlive_lab_runtime_smoke_capture.json',
                key: const ValueKey('mathlive-lab-q90r7-evidence-preview'),
                style: const TextStyle(color: MathProColors.accent, fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StaticLabFallback extends StatelessWidget {
  const _StaticLabFallback();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(MathProSpacing.lg),
        child: Text(
          'Q84–Q90R2 static lab fallback: WebView is skipped in flutter tests. Real device may load assets/mathlive/index.html; Q90R2 only runs a lab runtime smoke gate and still does not switch the main editor.',
          key: ValueKey('mathlive-lab-static-fallback'),
          textAlign: TextAlign.center,
          style: TextStyle(color: MathProColors.textSoft, height: 1.35),
        ),
      ),
    );
  }
}

class _LabActionRow extends StatelessWidget {
  const _LabActionRow({
    required this.onSeedFraction,
    required this.onInsertSeven,
    required this.onBackspace,
    required this.onClear,
    required this.onSmoke,
    required this.onEvidence,
    required this.onCopyEvidence,
  });

  final VoidCallback? onSeedFraction;
  final VoidCallback? onInsertSeven;
  final VoidCallback? onBackspace;
  final VoidCallback? onClear;
  final VoidCallback? onSmoke;
  final VoidCallback? onEvidence;
  final VoidCallback? onCopyEvidence;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: MathProSpacing.sm,
      runSpacing: MathProSpacing.sm,
      children: [
        OutlinedButton(
          key: const ValueKey('mathlive-lab-seed-fraction'),
          onPressed: onSeedFraction,
          child: const Text('□/□'),
        ),
        OutlinedButton(
          key: const ValueKey('mathlive-lab-insert-seven'),
          onPressed: onInsertSeven,
          child: const Text('7'),
        ),
        OutlinedButton(
          key: const ValueKey('mathlive-lab-backspace'),
          onPressed: onBackspace,
          child: const Text('⌫'),
        ),
        OutlinedButton(
          key: const ValueKey('mathlive-lab-clear'),
          onPressed: onClear,
          child: const Text('C'),
        ),
        OutlinedButton(
          key: const ValueKey('mathlive-lab-runtime-smoke'),
          onPressed: onSmoke,
          child: const Text('Smoke'),
        ),
        OutlinedButton(
          key: const ValueKey('mathlive-lab-q90r6-evidence'),
          onPressed: onEvidence,
          child: const Text('Evidence'),
        ),
        OutlinedButton(
          key: const ValueKey('mathlive-lab-q90r7-copy-evidence'),
          onPressed: onCopyEvidence,
          child: const Text('Copy Evidence'),
        ),
      ],
    );
  }
}
