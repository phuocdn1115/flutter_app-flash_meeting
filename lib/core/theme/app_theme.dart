import 'package:flash_meeting_app/core/theme/app_colors.dart';
import 'package:flash_meeting_app/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      textTheme: TextTheme(
        bodySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: AppFonts.fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: AppFonts.fontFamily,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          fontFamily: AppFonts.fontFamily,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: AppFonts.fontFamily,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          fontFamily: AppFonts.fontFamily,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          fontFamily: AppFonts.fontFamily,
        ),
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.surface,
        secondary: AppColors.secondary,
        onSecondary: AppColors.surface,
        error: Colors.redAccent,
        onError: AppColors.surface,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
          elevation: 0,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.3),
          textStyle: TextStyle(
            fontFamily: AppFonts.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w500
          )
        )
      )
    );
  }
}
