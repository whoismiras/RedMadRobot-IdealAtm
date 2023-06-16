import 'package:flutter/material.dart';
import 'package:ideal_atm/main/presentation/utils/design_color_constants.dart';

ThemeData themeLight() => ThemeData(
      colorScheme: ColorScheme.light(
        primary: primaryLight,
        onPrimary: onPrimaryLight,
        primaryContainer: primaryContainerLight,
        onPrimaryContainer: onPrimaryContainerLight,
        secondary: secondaryLight,
        onSecondary: onSecondaryLight,
        secondaryContainer: secondaryContainerLight,
        onSecondaryContainer: onSecondaryContainerLight,
        surface: surfaceLight,
        onSurface: onSurfaceLight,
        tertiary: tertiaryLight,
        onTertiary: onTertiaryLight,
        outline: outlineLight,
      ),
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: surfaceLight,
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.red,
      ),
    );

ThemeData themeDark() => ThemeData(
      colorScheme: ColorScheme.dark(
        primary: primaryDark,
        onPrimary: onPrimaryDark,
        primaryContainer: primaryContainerDark,
        onPrimaryContainer: onPrimaryContainerDark,
        secondary: secondaryDark,
        onSecondary: onSecondaryDark,
        secondaryContainer: secondaryContainerDark,
        onSecondaryContainer: onSecondaryContainerDark,
        surface: surfaceDark,
        onSurface: onSurfaceDark,
        tertiary: tertiaryDark,
        onTertiary: onTertiaryDark,
        outline: outlineDark,
      ),
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: surfaceDark,
    );
