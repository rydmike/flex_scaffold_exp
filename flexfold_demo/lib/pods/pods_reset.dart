import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/app_text_direction.dart';
import '../store/key_store.dart';
import 'pods_application.dart';
import 'pods_theme.dart';

/// This file contains functions to reset all provider values for themes,
/// colors and Flexfold and some app setting to their defaults, as defined
/// in the [KeyStore.defaults] map. When values are reset they are updated and
/// updated and also persisted by the [ProviderObserver].
///
/// The coded defaults are used only when a Hive persisted provider has never
/// been changed and does not exist in the Hive box, otherwise persisted pod
/// values are always restored from the Hive box.
///
/// In this demo we wanted a design that persist each individual setting as it
/// is changed. We could have bundled all the props in one or two big data
/// property classes. However that would then involve storing all properties in
/// an the immutable data class a record as an new version is create when we
/// change a property. This design only updates the updated property and it
/// does it very quickly. Each settings property is treated as its own
/// individual state, and typically has control widget associated with it,
/// that only rebuilds when its property value is changed. UI wise many
/// of the properties may or may not trigger extensive rebuilds, because of
/// the nature of what they control.
///
/// The setup is very simple to use, setup is easy, but there is just a lot of
/// persisted pod values, it easy to miss one and we have to remember to
/// add any new tracked state provider property to the list to be reset.
/// But other than that, this is pretty handy.

/// Reset all app related settings to their default values.
void resetAppSettingsPods(WidgetRef ref) {
  // Reset the platform to actual real current platform.
  //***************************************************************************
  ref.read(platformPod.notifier).state = defaultTargetPlatform;

  // Reset the custom text direction Riverpod "Pod" providers to default value.
  //***************************************************************************
  ref.read(appTextDirectionPod.notifier).state =
      KeyStore.defaults[KeyStore.appTextDirection]! as AppTextDirection;
}

/// Reset all theme related settings to their default values.
void resetThemePods(WidgetRef ref) {
  // Reset the theme mode Riverpod "Pod" providers to default value.
  //***************************************************************************
  ref.read(themeModePod.notifier).state =
      KeyStore.defaults[KeyStore.themeMode]! as ThemeMode;

  // Reset the all the FlexColorScheme Riverpod "Pod" providers to defaults.
  //***************************************************************************
  ref.read(usedColorsPod.notifier).state =
      KeyStore.defaults[KeyStore.usedColors]! as int;

  ref.read(surfaceStylePod.notifier).state =
      KeyStore.defaults[KeyStore.surfaceMode]! as FlexSurfaceMode;

  ref.read(tabBarStylePod.notifier).state =
      KeyStore.defaults[KeyStore.tabBarStyle]! as FlexTabBarStyle;

  ref.read(schemeIndexPod.notifier).state =
      KeyStore.defaults[KeyStore.schemeIndex]! as int;

  ref.read(tooltipsMatchBackgroundPod.notifier).state =
      KeyStore.defaults[KeyStore.tooltipsMatchBackground]! as bool;

  ref.read(lightAppBarStylePod.notifier).state =
      KeyStore.defaults[KeyStore.lightAppBarStyle]! as FlexAppBarStyle;

  ref.read(darkAppBarStylePod.notifier).state =
      KeyStore.defaults[KeyStore.darkAppBarStyle]! as FlexAppBarStyle;

  ref.read(useToDarkMethodPod.notifier).state =
      KeyStore.defaults[KeyStore.useToDarkMethod]! as bool;

  ref.read(darkLevelPod.notifier).state =
      KeyStore.defaults[KeyStore.darkLevel]! as int;

  ref.read(darkIsTrueBlackPod.notifier).state =
      KeyStore.defaults[KeyStore.darkIsTrueBlack]! as bool;
}

/// Reset all custom theme colors related settings to their default values.
void resetCustomColorPods(WidgetRef ref) {
  // Reset the all custom light color scheme "Pod" providers to defaults.
  //***************************************************************************

  ref.read(lightPrimaryPod.notifier).state =
      KeyStore.defaults[KeyStore.lightPrimary]! as Color;

  ref.read(lightPrimaryVariantPod.notifier).state =
      KeyStore.defaults[KeyStore.lightPrimaryVariant]! as Color;

  ref.read(lightSecondaryPod.notifier).state =
      KeyStore.defaults[KeyStore.lightSecondary]! as Color;

  ref.read(lightSecondaryVariantPod.notifier).state =
      KeyStore.defaults[KeyStore.lightSecondaryVariant]! as Color;

  ref.read(lightBackgroundPod.notifier).state =
      KeyStore.defaults[KeyStore.lightBackground]! as Color;

  ref.read(lightSurfacePod.notifier).state =
      KeyStore.defaults[KeyStore.lightSurface]! as Color;

  ref.read(lightScaffoldPod.notifier).state =
      KeyStore.defaults[KeyStore.lightScaffold]! as Color;

  ref.read(lightAppBarPod.notifier).state =
      KeyStore.defaults[KeyStore.lightAppBar]! as Color;

  ref.read(lightErrorPod.notifier).state =
      KeyStore.defaults[KeyStore.lightError]! as Color;

  // Reset the all custom dark color scheme "Pod" providers to defaults.
  //***************************************************************************

  ref.read(darkPrimaryPod.notifier).state =
      KeyStore.defaults[KeyStore.darkPrimary]! as Color;

  ref.read(darkPrimaryVariantPod.notifier).state =
      KeyStore.defaults[KeyStore.darkPrimaryVariant]! as Color;

  ref.read(darkSecondaryPod.notifier).state =
      KeyStore.defaults[KeyStore.darkSecondary]! as Color;

  ref.read(darkSecondaryVariantPod.notifier).state =
      KeyStore.defaults[KeyStore.darkSecondaryVariant]! as Color;

  ref.read(darkBackgroundPod.notifier).state =
      KeyStore.defaults[KeyStore.darkBackground]! as Color;

  ref.read(darkSurfacePod.notifier).state =
      KeyStore.defaults[KeyStore.darkSurface]! as Color;

  ref.read(darkScaffoldPod.notifier).state =
      KeyStore.defaults[KeyStore.darkScaffold]! as Color;

  ref.read(darkAppBarPod.notifier).state =
      KeyStore.defaults[KeyStore.darkAppBar]! as Color;

  ref.read(darkErrorPod.notifier).state =
      KeyStore.defaults[KeyStore.darkError]! as Color;
}
