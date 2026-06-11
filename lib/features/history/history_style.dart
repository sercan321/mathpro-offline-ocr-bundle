import 'package:flutter/material.dart';

class HistoryStyle {
  const HistoryStyle._();

  static const Duration drawerAnimationDuration = Duration(milliseconds: 280);
  static const Duration microAnimationDuration = Duration(milliseconds: 160);
  static const Curve drawerCurve = Curves.easeOutCubic;

  static const Color panelBackground = Color(0xFF070809);
  static const Color panelTop = Color(0xFF14181A);
  static const Color panelMid = Color(0xFF0D1012);
  static const Color panelBottom = Color(0xFF050607);
  static const Color cardBackground = Color(0xFF0D1012);
  static const Color cardTop = Color(0xFF14181A);
  static const Color cardBottom = Color(0xFF07090A);
  static const Color innerSurface = Color(0xFF090B0D);
  static const Color elevatedSurface = Color(0xFF15191C);
  static const Color border = Color(0xFF252B30);
  static const Color borderSoft = Color(0xFF22262B);
  static const Color primaryText = Color(0xFFF2F4F5);
  static const Color secondaryText = Color(0xFF9AA0A6);
  static const Color tertiaryText = Color(0xFF687079);
  static const Color accent = Color(0xFF74BEB4);
  static const Color accentSoft = Color(0x3374BEB4);
  static const Color delete = Color(0xFFFF5A4F);
  static const Color resultBlue = Color(0xFF3C88FF);
  static const Color orange = Color(0xFFE28518);
  static const Color glassHighlight = Color(0x1AFFFFFF);
  static const Color graphiteHighlight = Color(0x14FFFFFF);
  static const Color shadow = Color(0xAA000000);
  static const Color deepShadow = Color(0xD9000000);

  static const BorderRadius panelRadius = BorderRadius.vertical(bottom: Radius.circular(28));
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(24));
}
