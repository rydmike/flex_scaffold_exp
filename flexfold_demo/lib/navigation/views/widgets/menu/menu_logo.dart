import 'dart:async' show Timer;

import 'package:flutter/material.dart';

import '../../../../app/const/app_fonts.dart';
import '../../../../app/const/app_strings.dart';

// A widget used as logo on the Flexfold menu's app bar.
class MenuLogo extends StatefulWidget {
  const MenuLogo({super.key});

  @override
  State<MenuLogo> createState() => _MenuLogoState();
}

class _MenuLogoState extends State<MenuLogo> {
  late bool swapLogo;
  late Timer timer;

  @override
  void initState() {
    swapLogo = false;
    timer = Timer.periodic(const Duration(milliseconds: 4000), (Timer timer) {
      setState(() {
        swapLogo = !swapLogo;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current color of the appbar from the theme
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final ThemeData theme = Theme.of(context);
    final Color appBarColor = appBarTheme.backgroundColor ?? theme.primaryColor;
    // Set the text color to match the active theme, here we use black
    // transparency on light colored appbar and white transparency on dark.
    final Color textColor =
        ThemeData.estimateBrightnessForColor(appBarColor) == Brightness.light
            ? const Color(0xBB000000)
            : Colors.white70;

    final Widget textFlex = Text(
      AppStrings.flex,
      softWrap: false,
      key: const ValueKey<int>(1),
      textAlign: TextAlign.start,
      style: TextStyle(
        color: textColor,
        fontSize: 30,
        fontFamily: AppFonts.logoFont,
      ),
    );

    final Widget textFold = Text(
      AppStrings.fold,
      key: const ValueKey<int>(2),
      softWrap: false,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: textColor,
        fontSize: 30,
        fontFamily: AppFonts.logoFont,
      ),
    );

    return Padding(
        padding: EdgeInsetsDirectional.zero,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: swapLogo ? textFold : textFlex,
            );
          },
          child: !swapLogo ? textFold : textFlex,
        ));
  }
}
