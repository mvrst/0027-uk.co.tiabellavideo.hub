import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/hub_colors.dart';

abstract final class AppTheme {
  static ThemeData _lightBase() {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      primaryColor: HubColors.charcoal,
      scaffoldBackgroundColor: HubColors.pageBg,
      colorScheme: const ColorScheme.light(
        primary: HubColors.charcoal,
        secondary: HubColors.accentRed,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSurface: HubColors.charcoal,
      ),
    );
  }

  static ThemeData _lightWithTextTheme(TextTheme textTheme) {
    final base = _lightBase();
    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: HubColors.charcoal,
        elevation: 0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: HubColors.charcoal,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  static ThemeData get light {
    final base = _lightBase();
    return _lightWithTextTheme(GoogleFonts.interTextTheme(base.textTheme));
  }

  /// Same chrome as [light] but uses embedded Material text styles (no Inter fetch).
  /// Use with [GoogleFonts.config.allowRuntimeFetching] false in widget goldens / offline CI.
  static ThemeData get lightForGoldens {
    final base = _lightBase();
    return _lightWithTextTheme(
      base.textTheme.apply(
        bodyColor: HubColors.charcoal,
        displayColor: HubColors.charcoal,
      ),
    );
  }
}
