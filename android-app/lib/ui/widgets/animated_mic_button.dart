import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AnimatedMicButton extends StatefulWidget {
  const AnimatedMicButton({
    super.key,
    required this.active,
    required this.onPressed,
  });

  final bool active;
  final VoidCallback onPressed;

  @override
  State<AnimatedMicButton> createState() => _AnimatedMicButtonState();
}

class _AnimatedMicButtonState extends State<AnimatedMicButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scale = Tween<double>(begin: 0.94, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    return ScaleTransition(
      scale: widget.active ? scale : const AlwaysStoppedAnimation(1),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: (widget.active ? AppColors.accent2 : AppColors.accent).withOpacity(0.34),
              blurRadius: 24,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: widget.onPressed,
          backgroundColor: widget.active ? AppColors.accent2 : AppColors.accent,
          foregroundColor: Colors.white,
          elevation: 0,
          child: Icon(widget.active ? Icons.graphic_eq : Icons.mic),
        ),
      ),
    );
  }
}
