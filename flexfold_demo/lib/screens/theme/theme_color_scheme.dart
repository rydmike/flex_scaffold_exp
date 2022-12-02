import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pods/pods_theme.dart';
import '../../utils/app_insets.dart';
import '../../widgets/breakpoint/breakpoint.dart';
import '../../widgets/color/color_picker_inkwell.dart';
import 'color_name_value.dart';

class ThemeColorScheme extends ConsumerWidget {
  const ThemeColorScheme({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Used to enable & disable color selection on the color boxes.
    final bool isCustomTheme = ref.watch(schemeIndexPod) == 1;
    final bool isCustomSurface =
        ref.watch(surfaceStylePod) == FlexSurfaceMode.custom;

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool isLight = theme.brightness == Brightness.light;
    final Color dividerColor = theme.dividerColor;

    final Color primary = colorScheme.primary;
    final Color primaryVariant = colorScheme.primaryContainer;
    final Color onPrimaryVariant =
        ThemeData.estimateBrightnessForColor(colorScheme.primaryContainer) ==
                Brightness.dark
            ? Colors.white
            : Colors.black;

    final Color secondary = colorScheme.secondary;
    final Color secondaryVariant = colorScheme.secondaryContainer;
    final Color onSecondaryVariant =
        ThemeData.estimateBrightnessForColor(colorScheme.secondaryContainer) ==
                Brightness.dark
            ? Colors.white
            : Colors.black;

    final Color background = colorScheme.background;
    final Color surface = colorScheme.surface;
    final Color errorColor = colorScheme.error;

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
          horizontal: AppInsets.l,
          vertical: AppInsets.m,
        ),
        sliver: SliverGrid.count(
          crossAxisSpacing: breakpoint.gutters / 1.5,
          mainAxisSpacing: breakpoint.gutters / 1.5,
          crossAxisCount: breakpoint.columns,
          childAspectRatio: 1.25,
          children: <Widget>[
            //
            // PICK Primary color
            Material(
              elevation: isCustomTheme ? 2 : 0,
              clipBehavior: Clip.antiAlias,
              color: primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorPickerInkWell(
                color: primary,
                onChanged: (Color color) {
                  if (isLight) {
                    ref.read(lightSwapColorsPod)
                        ? ref.read(lightSecondaryPod.notifier).state = color
                        : ref.read(lightPrimaryPod.notifier).state = color;
                  } else {
                    ref.read(darkSwapColorsPod)
                        ? ref.read(darkSecondaryPod.notifier).state = color
                        : ref.read(darkPrimaryPod.notifier).state = color;
                  }
                },
                wasCancelled: (bool cancelled) {
                  if (cancelled) {
                    if (isLight) {
                      ref.read(lightSwapColorsPod)
                          ? ref.read(lightSecondaryPod.notifier).state = primary
                          : ref.read(lightPrimaryPod.notifier).state = primary;
                    } else {
                      ref.read(darkSwapColorsPod)
                          ? ref.read(darkSecondaryPod.notifier).state = primary
                          : ref.read(darkPrimaryPod.notifier).state = primary;
                    }
                  }
                },
                enabled: isCustomTheme,
                child: ColorNameValue(
                  color: primary,
                  textColor: colorScheme.onPrimary,
                  label: 'primary',
                ),
              ),
            ),
            //
            // PICK Primary variant color
            Material(
              elevation:
                  (isCustomTheme && ref.watch(usedColorsPod) >= 3) ? 2 : 0,
              clipBehavior: Clip.antiAlias,
              color: primaryVariant,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorPickerInkWell(
                color: primaryVariant,
                onChanged: (Color color) {
                  if (isLight) {
                    ref.read(lightSwapColorsPod)
                        ? ref.read(lightSecondaryVariantPod.notifier).state =
                            color
                        : ref.read(lightPrimaryVariantPod.notifier).state =
                            color;
                  } else {
                    ref.read(darkSwapColorsPod)
                        ? ref.read(darkSecondaryVariantPod.notifier).state =
                            color
                        : ref.read(darkPrimaryVariantPod.notifier).state =
                            color;
                  }
                },
                wasCancelled: (bool cancelled) {
                  if (cancelled) {
                    if (isLight) {
                      ref.read(lightSwapColorsPod)
                          ? ref.read(lightSecondaryVariantPod.notifier).state =
                              primaryVariant
                          : ref.read(lightPrimaryVariantPod.notifier).state =
                              primaryVariant;
                    } else {
                      ref.read(darkSwapColorsPod)
                          ? ref.read(darkSecondaryVariantPod.notifier).state =
                              primaryVariant
                          : ref.read(darkPrimaryVariantPod.notifier).state =
                              primaryVariant;
                    }
                  }
                },
                enabled: isCustomTheme && ref.watch(usedColorsPod) >= 3,
                child: ColorNameValue(
                  color: primaryVariant,
                  textColor: onPrimaryVariant,
                  label: 'primary\nVariant',
                ),
              ),
            ),
            //
            // PICK Secondary color
            Material(
              elevation:
                  (isCustomTheme && ref.watch(usedColorsPod) >= 2) ? 2 : 0,
              clipBehavior: Clip.antiAlias,
              color: secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorPickerInkWell(
                color: secondary,
                onChanged: (Color color) {
                  if (isLight) {
                    ref.read(lightSwapColorsPod)
                        ? ref.read(lightPrimaryPod.notifier).state = color
                        : ref.read(lightSecondaryPod.notifier).state = color;
                  } else {
                    ref.read(darkSwapColorsPod)
                        ? ref.read(darkPrimaryPod.notifier).state = color
                        : ref.read(darkSecondaryPod.notifier).state = color;
                  }
                },
                wasCancelled: (bool cancelled) {
                  if (cancelled) {
                    if (isLight) {
                      ref.read(lightSwapColorsPod)
                          ? ref.read(lightPrimaryPod.notifier).state = secondary
                          : ref.read(lightSecondaryPod.notifier).state =
                              secondary;
                    } else {
                      ref.read(darkSwapColorsPod)
                          ? ref.read(darkPrimaryPod.notifier).state = secondary
                          : ref.read(darkSecondaryPod.notifier).state =
                              secondary;
                    }
                  }
                },
                enabled: isCustomTheme && ref.watch(usedColorsPod) >= 2,
                child: ColorNameValue(
                  color: secondary,
                  textColor: colorScheme.onSecondary,
                  label: 'secondary',
                ),
              ),
            ),
            //
            // PICK Secondary variant color
            Material(
              elevation:
                  (isCustomTheme && ref.watch(usedColorsPod) == 4) ? 2 : 0,
              clipBehavior: Clip.antiAlias,
              color: secondaryVariant,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorPickerInkWell(
                color: secondaryVariant,
                onChanged: (Color color) {
                  if (isLight) {
                    ref.read(lightSwapColorsPod)
                        ? ref.read(lightPrimaryVariantPod.notifier).state =
                            color
                        : ref.read(lightSecondaryVariantPod.notifier).state =
                            color;
                  } else {
                    ref.read(darkSwapColorsPod)
                        ? ref.read(darkPrimaryVariantPod.notifier).state = color
                        : ref.read(darkSecondaryVariantPod.notifier).state =
                            color;
                  }
                },
                wasCancelled: (bool cancelled) {
                  if (cancelled) {
                    if (isLight) {
                      ref.read(lightSwapColorsPod)
                          ? ref.read(lightPrimaryVariantPod.notifier).state =
                              secondaryVariant
                          : ref.read(lightSecondaryVariantPod.notifier).state =
                              secondaryVariant;
                    } else {
                      ref.read(darkSwapColorsPod)
                          ? ref.read(darkPrimaryVariantPod.notifier).state =
                              secondaryVariant
                          : ref.read(darkSecondaryVariantPod.notifier).state =
                              secondaryVariant;
                    }
                  }
                },
                enabled: isCustomTheme && ref.watch(usedColorsPod) == 4,
                child: ColorNameValue(
                  color: secondaryVariant,
                  textColor: onSecondaryVariant,
                  label: 'secondary\nVariant',
                ),
              ),
            ),
            //
            // Background color picker
            Material(
              elevation: isCustomSurface ? 2 : 0,
              clipBehavior: Clip.antiAlias,
              color: background,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorPickerInkWell(
                color: background,
                onChanged: (Color color) {
                  if (isLight) {
                    ref.read(lightBackgroundPod.notifier).state = color;
                  } else {
                    ref.read(darkBackgroundPod.notifier).state = color;
                  }
                },
                wasCancelled: (bool cancelled) {
                  if (cancelled) {
                    if (isLight) {
                      ref.read(lightBackgroundPod.notifier).state = background;
                    } else {
                      ref.read(darkBackgroundPod.notifier).state = background;
                    }
                  }
                },
                enabled: isCustomSurface,
                child: ColorNameValue(
                  color: background,
                  textColor: colorScheme.onBackground,
                  label: 'background',
                ),
              ),
            ),
            //
            // PICK Surface color
            Material(
              elevation: isCustomSurface
                  // Use dark lighten of surface, but we do not want it on this
                  // very special cases surface color indicator in dark so we
                  // keep the elevation as 0 in dark mode for this case.
                  ? isLight
                      ? 2
                      : 0
                  : 0,
              clipBehavior: Clip.antiAlias,
              color: surface,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorPickerInkWell(
                color: surface,
                onChanged: (Color color) {
                  if (isLight) {
                    ref.read(lightSurfacePod.notifier).state = color;
                  } else {
                    ref.read(darkSurfacePod.notifier).state = color;
                  }
                },
                wasCancelled: (bool cancelled) {
                  if (cancelled) {
                    if (isLight) {
                      ref.read(lightSurfacePod.notifier).state = surface;
                    } else {
                      ref.read(darkSurfacePod.notifier).state = surface;
                    }
                  }
                },
                enabled: isCustomSurface,
                child: ColorNameValue(
                  color: surface,
                  textColor: colorScheme.onSurface,
                  label: 'surface',
                ),
              ),
            ),
            //
            // On Primary box
            Material(
              elevation: 0,
              color: colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: colorScheme.onPrimary,
                textColor: colorScheme.onPrimary == Colors.white
                    ? Colors.black
                    : Colors.white,
                label: 'onPrimary',
              ),
            ),
            //
            // On Secondary box
            Material(
              elevation: 0,
              color: colorScheme.onSecondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: colorScheme.onSecondary,
                textColor: colorScheme.onSecondary == Colors.white
                    ? Colors.black
                    : Colors.white,
                label: 'onSecondary',
              ),
            ),
            //
            // On BackGround box
            Material(
              elevation: 0,
              color: colorScheme.onBackground,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: colorScheme.onBackground,
                textColor: colorScheme.background,
                label: 'onBackground',
              ),
            ),
            //
            // On Surface box
            Material(
              elevation: 0,
              color: colorScheme.onSurface,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: colorScheme.onSurface,
                textColor: surface,
                label: 'onSurface',
              ),
            ),
            //
            // On Error box
            Material(
              elevation: 0,
              color: colorScheme.onError,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: dividerColor)),
              child: ColorNameValue(
                color: colorScheme.onError,
                textColor: colorScheme.onError == Colors.white
                    ? Colors.black
                    : Colors.white,
                label: 'onError',
              ),
            ),
            //
            // PICK Error color box
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
                  textColor: colorScheme.onError,
                  label: 'error',
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
