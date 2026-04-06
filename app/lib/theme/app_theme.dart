import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/hub_colors.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
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
    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
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
}
