import 'package:flutter/material.dart';

import '../app/app_routes.dart';
import '../core/brain/megan_brain.dart';
import '../core/services/voice/speech_service.dart';
import '../core/services/voice/tts_service.dart';
import '../ui/theme/app_colors.dart';
import '../ui/widgets/animated_mic_button.dart';
import '../ui/widgets/brain_status_panel.dart';
import '../ui/widgets/megan_chat_bubble.dart';
import '../ui/widgets/megan_glass_card.dart';
import '../ui/widgets/typing_indicator.dart';
import '../ui/widgets/voice_status_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MeganBrain _brain = MeganBrain();
  final TtsService _tts = TtsService();
  final SpeechService _speech = SpeechService();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [
    const _ChatMessage(
      text: 'Oi Luiz, sou a Megan Life. Brain local pronto, visual premium ativo e conexão Render preparada.',
      isUser: false,
    ),
  ];

  String _status = 'Brain local pronto';
  String _voiceStatus = 'Toque no microfone e fale seu comando.';
  bool _loading = false;
  bool _listening = false;
  bool _speechReady = false;
  String _lastPartialVoiceText = '';

  @override
  void initState() {
    super.initState();
    _bootVoice();
  }

  Future<void> _bootVoice() async {
    final ready = await _speech.initialize();
    if (!mounted) return;

    setState(() {
      _speechReady = ready;
      _voiceStatus = ready
          ? 'Voz pronta. Toque no microfone e fale.'
          : 'Reconhecimento de voz indisponível. Use o campo de texto.';
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _speech.cancelListening();
    super.dispose();
  }

  Future<void> _send([String? forcedText]) async {
    final command = (forcedText ?? _controller.text).trim();
    if (command.isEmpty || _loading) return;

    await _speech.stopListening();

    setState(() {
      _listening = false;
      _lastPartialVoiceText = '';
      _messages.add(_ChatMessage(text: command, isUser: true));
      _controller.clear();
      _status = 'Processando comando...';
      _voiceStatus = 'Megan analisando intenção no Brain.';
      _loading = true;
    });

    _scrollToBottom();

    try {
      final response = await _brain.execute(command);

      if (!mounted) return;

      setState(() {
        _messages.add(_ChatMessage(text: response, isUser: false));
        _status = 'Pronta';
        _voiceStatus = 'Resposta concluída. Toque no microfone para falar de novo.';
        _loading = false;
      });

      _scrollToBottom();
      await _tts.speak(response);
    } catch (e) {
      if (!mounted) return;

      final errorMessage = 'Luiz, encontrei um erro ao processar esse comando: $e';

      setState(() {
        _messages.add(_ChatMessage(text: errorMessage, isUser: false));
        _status = 'Erro controlado';
        _voiceStatus = 'Falha protegida. Você pode tentar novamente.';
        _loading = false;
      });

      _scrollToBottom();
      await _tts.speak(errorMessage);
    }
  }

  Future<void> _toggleMic() async {
    if (_loading) return;

    if (_listening) {
      await _speech.stopListening();
      if (!mounted) return;

      setState(() {
        _listening = false;
        _voiceStatus = 'Microfone pausado. Toque novamente para falar.';
      });
      return;
    }

    if (!_speechReady) {
      final ready = await _speech.initialize();
      if (!mounted) return;

      setState(() {
        _speechReady = ready;
      });

      if (!ready) {
        setState(() {
          _voiceStatus = 'Não consegui iniciar a voz. Verifique a permissão de microfone.';
        });
        return;
      }
    }

    setState(() {
      _listening = true;
      _lastPartialVoiceText = '';
      _voiceStatus = 'Ouvindo... fale seu comando.';
    });

    await _speech.startListening(
      onPartialResult: (text) {
        if (!mounted || !_listening || _loading) return;

        setState(() {
          _lastPartialVoiceText = text;
          _voiceStatus = 'Ouvindo: $text';
        });
      },
      onFinalResult: (text) async {
        if (!mounted || _loading) return;
        await _send(text);
      },
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 120,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Megan Life'),
          actions: [
            IconButton(
              tooltip: 'Chat',
              icon: const Icon(Icons.chat_bubble_outline),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.chat),
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: 'Configurações',
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
            ),
            const SizedBox(width: 12),
          ],
        ),
        floatingActionButton: AnimatedMicButton(
          active: _listening,
          onPressed: _toggleMic,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 110),
                  children: [
                    BrainStatusPanel(
                      status: _status,
                      localStatus: 'Brain local online',
                      cloudStatus: 'Render preparado',
                    ),
                    const SizedBox(height: 12),
                    VoiceStatusCard(
                      text: _voiceStatus,
                      listening: _listening,
                      onTap: _toggleMic,
                    ),
                    if (_lastPartialVoiceText.trim().isNotEmpty) ...[
                      const SizedBox(height: 10),
                      MeganGlassCard(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          _lastPartialVoiceText,
                          style: const TextStyle(
                            color: AppColors.subText,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),
                    _QuickActions(
                      onPermissions: () => Navigator.pushNamed(context, AppRoutes.permissions),
                      onSettings: () => Navigator.pushNamed(context, AppRoutes.settings),
                    ),
                    const SizedBox(height: 18),
                    ..._messages.map(
                      (message) => MeganChatBubble(
                        text: message.text,
                        isUser: message.isUser,
                      ),
                    ),
                    if (_loading)
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 4, top: 2, bottom: 12),
                          child: MeganGlassCard(
                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            child: TypingIndicator(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              _InputDock(
                controller: _controller,
                loading: _loading,
                onSend: () => _send(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({
    required this.onPermissions,
    required this.onSettings,
  });

  final VoidCallback onPermissions;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionCard(
            icon: Icons.security,
            title: 'Permissões',
            subtitle: 'Microfone, notificações e acesso',
            onTap: onPermissions,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _ActionCard(
            icon: Icons.tune,
            title: 'Sistema',
            subtitle: 'Ajustes da Megan Life',
            onTap: onSettings,
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MeganGlassCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, size: 19, color: AppColors.accent2),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.text,
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.subText,
                        fontSize: 11,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputDock extends StatelessWidget {
  const _InputDock({
    required this.controller,
    required this.loading,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool loading;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.92),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.32),
            blurRadius: 26,
            offset: const Offset(0, -14),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: const InputDecoration(
                hintText: 'Ex: abrir YouTube, que horas são, mande mensagem...',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.premiumGradient,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.28),
                  blurRadius: 18,
                ),
              ],
            ),
            child: IconButton(
              onPressed: loading ? null : onSend,
              icon: loading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({
    required this.text,
    required this.isUser,
  });

  final String text;
  final bool isUser;
}
