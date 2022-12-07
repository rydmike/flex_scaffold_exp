import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/widgets/universal/dialogs/platform_alert_dialog.dart';
import '../../controllers/pods_theme.dart';

class CopySchemeToCustom extends ConsumerWidget {
  const CopySchemeToCustom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      // Button disabled when we have selected custom theme, because we
      // cannot (no point) copy custom theme to itself.
      onPressed: ref.read(schemeIndexPod) != 1
          ? () async {
              final bool didCopy = await const PlatformAlertDialog(
                    title: 'Copy to custom theme?',
                    content: 'Copy the entire active color theme to the custom '
                        'theme color?\n'
                        '\n'
                        'The copy will include light and dark theme and their '
                        'surface colors.\n'
                        'Current custom theme will be overwritten!',
                    defaultActionText: 'Copy',
                    cancelActionText: 'Cancel',
                  ).show(context, useRootNavigator: true) ??
                  false;
              if (didCopy) {
                _copyThemeToCustom(ref);
                // TODO(rydmike): Remove this old code
                // _copySurfaceToCustom(ref);
              }
            }
          : null,
      child: const Text('Copy to custom'),
    );
  }
}

void _copyThemeToCustom(WidgetRef ref) {
  final FlexSchemeData fsData = ref.read(currentSchemeProvider.notifier).state;
  ref.read(lightPrimaryPod.notifier).state = fsData.light.primary;
  ref.read(lightPrimaryVariantPod.notifier).state =
      fsData.light.primaryContainer;
  ref.read(lightSecondaryPod.notifier).state = fsData.light.secondary;
  ref.read(lightSecondaryVariantPod.notifier).state =
      fsData.light.secondaryContainer;
  ref.read(lightErrorPod.notifier).state = fsData.light.error!;
  ref.read(lightAppBarPod.notifier).state = fsData.light.appBarColor!;

  ref.read(darkPrimaryPod.notifier).state = fsData.dark.primary;
  ref.read(darkPrimaryVariantPod.notifier).state = fsData.dark.primaryContainer;
  ref.read(darkSecondaryPod.notifier).state = fsData.dark.secondary;
  ref.read(darkSecondaryVariantPod.notifier).state =
      fsData.dark.secondaryContainer;
  ref.read(darkErrorPod.notifier).state = fsData.dark.error!;
  ref.read(darkAppBarPod.notifier).state = fsData.dark.appBarColor!;
}

class CopySurfaceToCustom extends ConsumerWidget {
  const CopySurfaceToCustom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      // Button disabled when we have selected custom surface, because we
      // cannot (no point) copy custom surface colors to itself.
      onPressed: ref.read(surfaceStylePod) != FlexSurfaceMode.custom
          ? () async {
              final bool didCopy = await const PlatformAlertDialog(
                    title: 'Copy surface colors to custom',
                    content:
                        'Copy the active light and dark surface colors to the '
                        'custom surface colors?\n'
                        '\n'
                        'Current custom surface colors will be overwritten!',
                    defaultActionText: 'Copy',
                    cancelActionText: 'Cancel',
                  ).show(context, useRootNavigator: true) ??
                  false;
              // if (didCopy) _copySurfaceToCustom(ref);
            }
          : null,
      child: const Text('Copy to custom'),
    );
  }
}

// TODO(rydmike): Remove this old code

// void _copySurfaceToCustom(WidgetRef ref) {
//   final FlexSchemeSurfaceColors surfaceThemeLight =
//       FlexSchemeSurfaceColors.from(
//     brightness: Brightness.light,
//     surfaceStyle: ref.read(surfaceStylePod),
//     primary: ref.read(currentSchemePod).light.primary,
//   );
//   ref.read(lightSurfacePod.notifier).state = surfaceThemeLight.surface;
//   ref.read(lightBackgroundPod.notifier).state = surfaceThemeLight.background;
//   ref.read(lightScaffoldPod.notifier).state =
//       surfaceThemeLight.scaffoldBackground;
//
//   final FlexSchemeSurfaceColors surfaceThemeDark =
//   FlexSchemeSurfaceColors.from(
//     brightness: Brightness.dark,
//     surfaceStyle: ref.read(surfaceStylePod),
//     primary: ref.read(currentSchemePod).dark.primary,
//   );
//   ref.read(darkSurfacePod.notifier).state = surfaceThemeDark.surface;
//   ref.read(darkBackgroundPod.notifier).state = surfaceThemeDark.background;
//   ref.read(darkScaffoldPod.notifier).state =
//       surfaceThemeDark.scaffoldBackground;
// }
