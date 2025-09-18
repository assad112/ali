import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static OutlineInputBorder _outline(ColorScheme scheme, {double r = 22, Color? color, double w = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(r),
      borderSide: BorderSide(color: color ?? scheme.outlineVariant, width: w),
    );
  }

  static ThemeData _base(ColorScheme scheme, {bool dark = false}) {
    final isDark = dark;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark ? scheme.background : AppColors.background,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: scheme.primary,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 1.5,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: AppColors.shadowSoft,
        margin: EdgeInsets.zero,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        elevation: 8,
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.primary.withOpacity(0.18),
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>((states) {
          final selected = states.contains(MaterialState.selected);
          return TextStyle(fontWeight: selected ? FontWeight.w600 : FontWeight.w500);
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: _outline(scheme),
        enabledBorder: _outline(scheme),
        focusedBorder: _outline(scheme, color: scheme.primary, w: 1.5),
        errorBorder: _outline(scheme, color: scheme.error),
        focusedErrorBorder: _outline(scheme, color: scheme.error, w: 1.5),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surface,
        selectedColor: scheme.primary.withOpacity(0.16),
        disabledColor: scheme.surfaceVariant,
        labelStyle: TextStyle(color: scheme.onSurface),
        secondaryLabelStyle: TextStyle(color: scheme.onPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: scheme.primary,
        textColor: scheme.onSurface,
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      splashColor: scheme.primary.withOpacity(0.08),
      highlightColor: scheme.primary.withOpacity(0.06),
    );
  }

  static ThemeData get light {
    const scheme = AppColors.lightScheme;
    return _base(scheme, dark: false);
  }

  static ThemeData get dark {
    final darkScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    );
    return _base(darkScheme, dark: true);
  }
}
