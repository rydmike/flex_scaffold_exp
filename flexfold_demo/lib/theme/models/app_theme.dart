import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const FlexSchemeColor flexfoldLight = FlexSchemeColor(
    primary: Color(0xFF0E8479),
    primaryContainer: Color(0xFF58AAA2),
    secondary: Color(0xFFFF5E2B),
    secondaryContainer: Color(0xFFFF6F42),
    tertiary: Color(0xFF4A635F),
    tertiaryContainer: Color(0xFFCCE8E3),
    appBarColor: Color(0xFF4A635F),
  );

  static const FlexSchemeColor flexfoldDark = FlexSchemeColor(
    primary: Color(0xFF58AAA2),
    primaryContainer: Color(0xFF0E8479),
    secondary: Color(0xFFFF6F42),
    secondaryContainer: Color(0xFFFF5E2B),
    tertiary: Color(0xFFB1CCC7),
    tertiaryContainer: Color(0xFF324B48),
    appBarColor: Color(0xFFB1CCC7),
  );
}
