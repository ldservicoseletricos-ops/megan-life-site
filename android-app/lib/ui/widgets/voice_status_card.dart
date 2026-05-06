import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'megan_glass_card.dart';

class VoiceStatusCard extends StatelessWidget {
  const VoiceStatusCard({
    super.key,
    required this.text,
    this.listening = false,
    this.onTap,
  });

  final String text;
  final bool listening;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return MeganGlassCard(
      padding: const EdgeInsets.all(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Row(
          children: [
            _VoicePulse(active: listening),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(
              listening ? Icons.graphic_eq : Icons.mic_none,
              color: listening ? AppColors.accent2 : AppColors.subText,
            ),
          ],
        ),
      ),
    );
  }
}

class _VoicePulse extends StatefulWidget {
  const _VoicePulse({required this.active});

  final bool active;

  @override
  State<_VoicePulse> createState() => _VoicePulseState();
}

class _VoicePulseState extends State<_VoicePulse> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 950),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = Tween<double>(begin: 0.72, end: 1.0).animate(_controller);

    return ScaleTransition(
      scale: widget.active ? animation : const AlwaysStoppedAnimation(1),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          gradient: widget.active ? AppColors.premiumGradient : null,
          color: widget.active ? null : Colors.white.withOpacity(0.08),
          shape: BoxShape.circle,
          boxShadow: widget.active
              ? [
                  BoxShadow(
                    color: AppColors.accent2.withOpacity(0.34),
                    blurRadius: 22,
                  ),
                ]
              : [],
        ),
        child: Icon(
          widget.active ? Icons.mic : Icons.mic_none,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
