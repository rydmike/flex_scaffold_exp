import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/const/app_insets.dart';
import '../../../core/utils/breakpoint.dart';
import '../../../core/views/widgets/app/color_picker_inkwell.dart';
import '../../controllers/pods_theme.dart';
import 'color_name_value.dart';

class ThemeColors extends ConsumerWidget {
  const ThemeColors({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Used to enable & disable color selection on the color boxes.
    final bool isCustomTheme = ref.watch(schemeIndexPod) == 1;
    final bool isCustomSurface =
        ref.watch(surfaceStylePod) == FlexSurfaceMode.custom;

    final ThemeData theme = Theme.of(context);
    final TextSelectionThemeData selectionTheme =
        TextSelectionTheme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final Color dividerColor = theme.dividerColor;

    final Color primaryColorDark = theme.primaryColorDark;
    final Color onPrimaryColorDark =
        ThemeData.estimateBrightnessForColor(primaryColorDark) ==
                Brightness.dark
            ? Colors.white
            : Colors.black;
    final Color primaryColorLight = theme.primaryColorLight;
    final Color onPrimaryColorLight =
        ThemeData.estimateBrightnessForColor(primaryColorLight) ==
                Brightness.dark
            ? Colors.white
            : Colors.black;
    final Color secondaryHeaderColor = theme.secondaryHeaderColor;
    final Color onSecondaryHeaderColor =
        ThemeData.estimateBrightnessForColor(secondaryHeaderColor) ==
                Brightness.dark
            ? Colors.white
            : Colors.black;

    final Color scaffoldColor = theme.scaffoldBackgroundColor;
    final Color onScaffoldColor =
        ThemeData.estimateBrightnessForColor(scaffoldColor) == Brightness.dark
            ? Colors.white
            : Colors.black;

    final Color cursorColor =
        selectionTheme.cursorColor ?? theme.colorScheme.primary;
    final Color onCursorColor =
        ThemeData.estimateBrightnessForColor(cursorColor) == Brightness.dark
            ? Colors.white
            : Colors.black;
    final Color selectionColor = selectionTheme.selectionColor ??
        theme.colorScheme.primary.withOpacity(0.40);
    final Color onSelectionColor = isLight ? Colors.black : Colors.white;
    final Color selectionHandleColor =
        selectionTheme.selectionHandleColor ?? theme.primaryColorDark;
    final Color onSelectionHandleColor =
        ThemeData.estimateBrightnessForColor(selectionHandleColor) ==
                Brightness.dark
            ? Colors.white
            : Colors.black;

    final Color appBarColor =
        theme.appBarTheme.backgroundColor ?? theme.primaryColor;
    final Color onAppBarColor =
        ThemeData.estimateBrightnessForColor(appBarColor) == Brightness.dark
            ? Colors.white
            : Colors.black;
    final Color bottomAppBarColor =
        theme.bottomAppBarTheme.color ?? theme.colorScheme.surface;
    final Color onBottomAppBarColor =
        ThemeData.estimateBrightnessForColor(bottomAppBarColor) ==
                Brightness.dark
            ? Colors.white
            : Colors.black;

    final Color indicatorColor = theme.indicatorColor;
    final Color onIndicatorColor =
        ThemeData.estimateBrightnessForColor(indicatorColor) == Brightness.dark
            ? Colors.white
            : Colors.black;
    final Color errorColor = theme.colorScheme.error;

    return SliverLayoutBuilder(
        builder: (BuildContext context, SliverConstraints constraints) {
      final double width = constraints.crossAxisExtent;
      final BoxConstraints box = BoxConstraints.tight(Size(width, 1000));
      final Breakpoint breakpoint = Breakpoint.fromConstraints(
        box,
        type: BreakType.large,
        minColumnSize: 135,
      );
      return SliverPadding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.l,
          vertical: Sizes.l / 2,
        ),
        sliver: SliverGrid.count(
          crossAxisSpacing: breakpoint.gutters / 1.5,
          mainAxisSpacing: breakpoint.gutters / 1.5,
          crossAxisCount: breakpoint.columns,
          childAspectRatio: 1.25,
          children: <Widget>[
            //
            // PrimaryColor color box
            Material(
              elevation: 0,
              color: theme.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: theme.primaryColor,
                textColor: theme.colorScheme.onPrimary,
                label: 'primaryColor',
              ),
            ),
            //
            // primaryColorLight color box
            Material(
              elevation: 0,
              color: primaryColorDark,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: primaryColorDark,
                textColor: onPrimaryColorDark,
                label: 'primaryColor\nDark',
              ),
            ),
            //
            // primaryColorLight color box
            Material(
              elevation: 0,
              color: primaryColorLight,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: primaryColorLight,
                textColor: onPrimaryColorLight,
                label: 'primaryColor\nLight',
              ),
            ),
            //
            // secondaryHeaderColor color box
            Material(
              elevation: 0,
              color: secondaryHeaderColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: secondaryHeaderColor,
                textColor: onSecondaryHeaderColor,
                label: 'secondary\nHeaderColor',
              ),
            ),
            //
            // Accent color color box
            // Material(
            //   elevation: 0,
            //   color: theme.accentColor,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(4),
            //       side: BorderSide(color: dividerColor)),
            //   child: ColorNameValue(
            //     color: theme.accentColor,
            //     textColor: theme.colorScheme.onSecondary,
            //     label: 'accentColor',
            //   ),
            // ),
            //
            // toggleableActiveColor color box
            // Material(
            //   elevation: 0,
            //   color: theme.toggleableActiveColor,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(4),
            //       side: BorderSide(color: dividerColor)),
            //   child: ColorNameValue(
            //     color: theme.toggleableActiveColor,
            //     textColor: theme.colorScheme.onSecondary,
            //     label: 'toggleable\nActiveColor',
            //   ),
            // ),
            //
            // cursorColor color box
            Material(
              elevation: 0,
              color: cursorColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: cursorColor,
                textColor: onCursorColor,
                label: 'cursorColor',
              ),
            ),
            //
            // textSelectionColor color box
            Material(
              elevation: 0,
              color: selectionColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: selectionColor,
                textColor: onSelectionColor,
                label: 'textSelection\nColor',
              ),
            ),
            //
            // textSelectionHandleColor color box
            Material(
              elevation: 0,
              color: selectionHandleColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: selectionHandleColor,
                textColor: onSelectionHandleColor,
                label: 'textSelection\nHandleColor',
              ),
            ),
            //
            // indicatorColor color box
            Material(
              elevation: 0,
              color: indicatorColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: theme.indicatorColor,
                textColor: onIndicatorColor,
                label: 'indicatorColor',
              ),
            ),
            //
            // PICK AppBarColor box
            Material(
              elevation: (isCustomTheme &&
                      ((isLight &&
                              ref.watch(lightAppBarStylePod) ==
                                  FlexAppBarStyle.custom) ||
                          (!isLight &&
                              ref.watch(darkAppBarStylePod) ==
                                  FlexAppBarStyle.custom)))
                  ? 2
                  : 0,
              clipBehavior: Clip.antiAlias,
              color: appBarColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorPickerInkWell(
                color: appBarColor,
                onChanged: (Color color) {
                  if (isLight) {
                    ref.read(lightAppBarPod.notifier).state = color;
                  } else {
                    ref.read(darkAppBarPod.notifier).state = color;
                  }
                },
                wasCancelled: (bool cancelled) {
                  if (cancelled) {
                    if (isLight) {
                      ref.read(lightAppBarPod.notifier).state = appBarColor;
                    } else {
                      ref.read(darkAppBarPod.notifier).state = appBarColor;
                    }
                  }
                },
                enabled: isCustomTheme &&
                    ((isLight &&
                            ref.read(lightAppBarStylePod) ==
                                FlexAppBarStyle.custom) ||
                        (!isLight &&
                            ref.read(darkAppBarStylePod) ==
                                FlexAppBarStyle.custom)),
                child: ColorNameValue(
                  color: appBarColor,
                  textColor: onAppBarColor,
                  label: 'appBarTheme\nColor',
                ),
              ),
            ),
            //
            // bottomAppBarColor box
            Material(
              elevation: 0,
              color: bottomAppBarColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: bottomAppBarColor,
                textColor: onBottomAppBarColor,
                label: 'bottom\nAppBarColor',
              ),
            ),
            //
            // dividerColor color box
            Material(
              elevation: 0,
              color: theme.dividerColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: theme.dividerColor,
                textColor: theme.colorScheme.onSurface,
                label: 'dividerColor',
              ),
            ),
            //
            // disabledColor color box
            Material(
              elevation: 0,
              color: theme.disabledColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: theme.disabledColor,
                textColor: theme.colorScheme.onSurface,
                label: 'disabledColor',
              ),
            ),
            //
            // Background color box
            // Material(
            //   elevation: 0,
            //   color: theme.backgroundColor,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(4),
            //       side: BorderSide(color: dividerColor)),
            //   child: ColorNameValue(
            //     color: theme.backgroundColor,
            //     textColor: theme.colorScheme.onBackground,
            //     label: 'background\nColor',
            //   ),
            // ),

            //
            // Canvas color box
            Material(
              elevation: 0,
              color: theme.canvasColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: theme.canvasColor,
                textColor: theme.colorScheme.onBackground,
                label: 'canvasColor',
              ),
            ),
            //
            // cardColor color box
            Material(
              elevation: 0,
              color: theme.cardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: theme.cardColor,
                textColor: theme.colorScheme.onSurface,
                label: 'cardColor',
              ),
            ),
            //
            // dialogBackgroundColor color box
            Material(
              elevation: 0,
              color: theme.dialogBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: theme.dialogBackgroundColor,
                textColor: theme.colorScheme.onSurface,
                label: 'dialog\nBackgroundColor',
              ),
            ),
            //
            // PICK ScaffoldBackgroundColor color
            Material(
              elevation: isCustomSurface ? 2 : 0,
              clipBehavior: Clip.antiAlias,
              color: scaffoldColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorPickerInkWell(
                color: scaffoldColor,
                onChanged: (Color color) {
                  if (isLight) {
                    ref.read(lightScaffoldPod.notifier).state = color;
                  } else {
                    ref.read(darkScaffoldPod.notifier).state = color;
                  }
                },
                wasCancelled: (bool cancelled) {
                  if (cancelled) {
                    if (isLight) {
                      ref.read(lightScaffoldPod.notifier).state = scaffoldColor;
                    } else {
                      ref.read(darkScaffoldPod.notifier).state = scaffoldColor;
                    }
                  }
                },
                enabled: isCustomSurface,
                child: ColorNameValue(
                  color: scaffoldColor,
                  textColor: onScaffoldColor,
                  label: 'scaffold\nBackgroundColor',
                ),
              ),
            ),
            //
            // PICK Error color
            Material(
              elevation: isCustomTheme ? 2 : 0,
              clipBehavior: Clip.antiAlias,
              color: errorColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorPickerInkWell(
                color: errorColor,
                onChanged: (Color color) {
                  if (isLight) {
                    ref.read(lightErrorPod.notifier).state = color;
                  } else {
                    ref.read(darkErrorPod.notifier).state = color;
                  }
                },
                wasCancelled: (bool cancelled) {
                  if (cancelled) {
                    if (isLight) {
                      ref.read(lightErrorPod.notifier).state = errorColor;
                    } else {
                      ref.read(darkErrorPod.notifier).state = errorColor;
                    }
                  }
                },
                enabled: isCustomTheme,
                child: ColorNameValue(
                  color: errorColor,
                  textColor: theme.colorScheme.onError,
                  label: 'errorColor',
                ),
              ),
            ),
          ],
        ),
        //   },
      );
    });
  }
}
