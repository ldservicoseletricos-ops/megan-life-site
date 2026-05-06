import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF070B14);
  static const background2 = Color(0xFF0B1020);
  static const surface = Color(0xFF111827);
  static const surfaceSoft = Color(0xFF172033);
  static const accent = Color(0xFF5C46FF);
  static const accent2 = Color(0xFF1ABC9C);
  static const danger = Color(0xFFFF4D6D);
  static const warning = Color(0xFFFFC857);
  static const text = Color(0xFFF5F7FA);
  static const subText = Color(0xFF9CA3AF);
  static const border = Color(0x26FFFFFF);

  static LinearGradient get backgroundGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF070B14),
          Color(0xFF0B1020),
          Color(0xFF090D19),
        ],
      );

  static LinearGradient get premiumGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          accent,
          accent2,
        ],
      );

  static LinearGradient get cardGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.10),
          Colors.white.withOpacity(0.045),
        ],
      );
}
