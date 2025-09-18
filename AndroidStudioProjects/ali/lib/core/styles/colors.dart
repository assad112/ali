import 'package:flutter/material.dart';

class AppColors {
  static const Color primary       = Color(0xFFF6BC56);
  static const Color onPrimary     = Color(0xFF7A4D00);
  static const Color primaryDark   = Color(0xFFE0A43E);
  static const Color primarySoft   = Color(0xFFFFE8B9);

  static const Color background    = Color(0xFFF7F7F7);
  static const Color surface       = Colors.white;
  static const Color surfaceVariant= Color(0xFFF1F5F9);

  static const Color textPrimary   = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color onSurface     = textPrimary;
  static const Color onSurfaceVariant = textSecondary;

  static const Color grey          = Color(0xFFD9D9D9);
  static const Color outline       = Color(0xFF9CA3AF);
  static const Color outlineVariant= Color(0xFFE5E7EB);

  static const Color success       = Color(0xFF16A34A);
  static const Color successContainer     = Color(0xFFD1FAE5);
  static const Color onSuccessContainer   = Color(0xFF064E3B);

  static const Color warning       = Color(0xFFF59E0B);
  static const Color warningContainer     = Color(0xFFFFF7ED);
  static const Color onWarningContainer   = Color(0xFF7C2D12);

  static const Color error         = Color(0xFFDC2626);
  static const Color errorContainer       = Color(0xFFFEE2E2);
  static const Color onErrorContainer     = Color(0xFF7F1D1D);

  static const Color shadowStrong  = Color(0x1F000000);
  static const Color shadowSoft    = Color(0x14000000);
  static const Color scrim         = Color(0x66000000);

  static const Color pillSelectedBg   = primary;
  static const Color pillSelectedFg   = onPrimary;
  static const Color pillUnselectedBg = Colors.white;
  static const Color pillUnselectedFg = textSecondary;

  static const Color secondary            = Color(0xFF475569);
  static const Color onSecondary          = Colors.white;
  static const Color secondaryContainer   = Color(0xFFE2E8F0);
  static const Color onSecondaryContainer = Color(0xFF0F172A);

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    primaryContainer: primarySoft,
    onPrimaryContainer: onPrimary,

    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,

    tertiary: success,
    onTertiary: Colors.white,
    tertiaryContainer: successContainer,
    onTertiaryContainer: onSuccessContainer,

    error: error,
    onError: Colors.white,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,

    background: background,
    onBackground: onSurface,
    surface: surface,
    onSurface: onSurface,
    surfaceVariant: surfaceVariant,
    onSurfaceVariant: onSurfaceVariant,

    outline: outline,
    outlineVariant: outlineVariant,
    shadow: shadowStrong,
    scrim: scrim,

    inverseSurface: Color(0xFF111827),
    inversePrimary: primaryDark,
  );

  static const MaterialColor primarySwatch = MaterialColor(
    0xFFF6BC56,
    <int, Color>{
      50:  Color(0xFFFFF7E9),
      100: Color(0xFFFFEBC9),
      200: Color(0xFFFFDEA3),
      300: Color(0xFFFFD07D),
      400: Color(0xFFFFC664),
      500: Color(0xFFF6BC56),
      600: Color(0xFFE9AE4C),
      700: Color(0xFFD79C40),
      800: Color(0xFFC88F36),
      900: Color(0xFFAC7426),
    },
  );
}
