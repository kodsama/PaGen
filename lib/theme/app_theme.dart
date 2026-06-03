import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Playful palette inspired by friendly learning apps (warm, high contrast, fun).
abstract final class AppColors {
  static const cream = Color(0xFFFFF8F0);
  static const lemon = Color(0xFFFFE566);
  static const coral = Color(0xFFFF6B4A);
  static const ink = Color(0xFF2D3142);
  static const inkMuted = Color(0xFF6B7280);
  static const notePaper = Color(0xFFFFFDF5);
  static const postIt = Color(0xFFF2EFBD);
  static const mint = Color(0xFF58C9B9);
  static const lilac = Color(0xFFB8B5FF);
}

abstract final class AppTheme {
  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.coral,
        primary: AppColors.coral,
        secondary: AppColors.mint,
        surface: AppColors.cream,
        onSurface: AppColors.ink,
      ),
      scaffoldBackgroundColor: AppColors.cream,
      cardTheme: CardThemeData(
        color: AppColors.notePaper,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cream,
        foregroundColor: AppColors.ink,
        elevation: 0,
        centerTitle: true,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.notePaper,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.coral,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: GoogleFonts.nunito(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: AppColors.lemon,
        labelStyle: GoogleFonts.nunito(
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
        side: const BorderSide(color: Color(0xFFE8E4DC)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.nunitoTextTheme(base.textTheme).apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      ),
    );
  }
}
