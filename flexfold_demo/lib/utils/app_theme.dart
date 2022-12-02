import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'app_insets.dart';

class AppTheme {
  // This class is not meant to be instantiated or extended. This constructor
  // prevents external instantiation and extension, plus it does not show up
  // in IDE code completion. We like static classes for constants because it
  // name spaces them and gives them a self documenting group and context that
  // they belong to.
  AppTheme._();

  // These theme definitions are used to give all Material buttons a
  // a Stadium rounded design, consistent with the rounded design of the app.
  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: minButtonSize,
          shape: const StadiumBorder(),
          padding: roundButtonPadding,
        ),
      );

  static OutlinedButtonThemeData outlinedButtonTheme(
          ColorScheme scheme, Color disabledColor) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: minButtonSize,
          shape: const StadiumBorder(),
          padding: roundButtonPadding,
        ).copyWith(
          side: MaterialStateProperty.resolveWith<BorderSide?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return BorderSide(
                  color: disabledColor,
                  width: 0.5,
                );
              }
              if (states.contains(MaterialState.error)) {
                return BorderSide(
                  color: scheme.error,
                  width: AppInsets.outlineThickness,
                );
              }
              return BorderSide(
                  color: scheme.primary, width: AppInsets.outlineThickness);
            },
          ),
        ),
      );

  static TextButtonThemeData get textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: minButtonSize,
          shape: const StadiumBorder(),
          padding: roundButtonPadding,
        ),
      );

  // The stadium rounded buttons generally need a bit more padding to look good,
  // adjust here to tune the padding for all of them globally in the app.
  // Currently using the default padding the old buttons had.
  static const EdgeInsets roundButtonPadding =
      EdgeInsets.symmetric(horizontal: 16);

  // The old buttons had a minimum size that looked better, we keep that.
  static const Size minButtonSize = Size(88, 36);

  // TODO(rydmike): Try different toggle button theme options!
  /// ToggleButtons theme
  static ToggleButtonsThemeData toggleButtonsTheme(
          ColorScheme colorScheme, bool isLight) =>
      ToggleButtonsThemeData(
        selectedColor: colorScheme.onPrimary,
        // color: isLight
        //     ? colorScheme.primary.withOpacity(0.9)
        //     : colorScheme.onSurface.withOpacity(0.85),
        color: colorScheme.onSurface.withOpacity(0.85),
        fillColor: colorScheme.primary, //.withOpacity(0.85),
        hoverColor: colorScheme.primary.withOpacity(0.2),
        focusColor: colorScheme.primary.withOpacity(0.3),
        borderWidth: AppInsets.outlineThickness,
        borderColor: colorScheme.primary,
        selectedBorderColor: colorScheme.primary,
        borderRadius: BorderRadius.circular(AppInsets.buttonRadius),
        constraints: const BoxConstraints(
            minWidth: AppInsets.buttonRadius,
            minHeight: AppInsets.buttonRadius),
      );

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
