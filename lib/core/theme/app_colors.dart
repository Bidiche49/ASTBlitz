import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // === COULEURS PRIMAIRES ===
  static const Color primaryDark = Color(0xFF1E293B); // slate-800
  static const Color primaryBlue = Color(0xFF3730A3); // indigo-700
  static const Color accentCyan = Color(0xFF22D3EE); // cyan-400

  // === BACKGROUNDS ===
  static const Color background = Color(0xFFFFFFFF); // white
  static const Color backgroundAlt = Color(0xFFF8FAFC); // slate-50
  static const Color backgroundGradientStart = Color(0xFFF8FAFC); // slate-50
  static const Color backgroundGradientEnd = Color(0xFFDBEAFE); // blue-100/50

  // === FOREGROUNDS ===
  static const Color foreground = Color(0xFF0A0A0A); // near-black
  static const Color foregroundMuted = Color(0xFF737373); // gray-500

  // === CARDS ===
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardForeground = Color(0xFF0A0A0A);

  // === BORDERS ===
  static const Color border = Color(0xFFE5E5E5); // gray-200
  static const Color borderLight = Color(0xFFF1F5F9); // slate-100

  // === ETATS ===
  static const Color destructive = Color(0xFFEF4444); // red-500
  static const Color success = Color(0xFF22C55E); // green-500
  static const Color warning = Color(0xFFF59E0B); // amber-500

  // === CHARTS ===
  static const Color chart1 = Color(0xFFEA580C); // orange-600
  static const Color chart2 = Color(0xFF0D9488); // teal-600
  static const Color chart3 = Color(0xFF1E3A5F); // dark blue
  static const Color chart4 = Color(0xFFEAB308); // yellow-500
  static const Color chart5 = Color(0xFFF97316); // orange-500

  // === GRADIENTS ===
  // Module Cards
  static const List<Color> gradientSlate = [
    Color(0xFF334155),
    Color(0xFF0F172A),
  ];
  static const List<Color> gradientAmberOrange = [
    Color(0xFFFBBF24),
    Color(0xFFF97316),
  ];
  static const List<Color> gradientBlueIndigo = [
    Color(0xFF1E40AF),
    Color(0xFF312E81),
  ];

  // Quiz du Jour
  static const List<Color> gradientOrangeRed = [
    Color(0xFFF97316),
    Color(0xFFDC2626),
  ];
  static const List<Color> gradientTealGreen = [
    Color(0xFF14B8A6),
    Color(0xFF16A34A),
  ];

  // BlitzCoin
  static const List<Color> gradientYellowOrange = [
    Color(0xFFFACC15),
    Color(0xFFF97316),
  ];

  // Progress Circle
  static const List<Color> gradientProgress = [
    Color(0xFF1E293B),
    Color(0xFF475569),
  ];
}
