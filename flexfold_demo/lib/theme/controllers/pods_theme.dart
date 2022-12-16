import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/const/app_fonts.dart';
import '../../core/controllers/app_controllers.dart';
import '../../store/hive_store.dart';
import '../../store/key_store.dart';
import '../models/app_theme.dart';
import 'flex_scaffold_theme_provider.dart';

// This file contains StateProviders that control settings used to control the
// application theme demonstrated in this example.
//
// This example application uses FlexColorScheme for its theming.
//
// StateProviders are really simple and convenient to use for settings that
// toggle and change values for application wide effects. They are easy to
// bake into controls and only the parts that really need to rebuild is built
// when the value is toggled.
//
// The StateProviders also have a name and default value in map.
// Hive and a ProviderObserver is used to store and persist the StateProvider
// whenever its value is changed, and the default value map gives us a way to
// reset the values to their default when so required.
//
// This setup is a bit tedious to setup due to the large number of
// StateProviders that is needed an app like this with many setting. Using
// a custom state object and StateNotifierProvider would be easier. However,
// with it you would have to use select filter if you want to rebuild controls
// based on individual property changes and to update persisted value only for
// the property that changed. The myriad of individual StateProviders gives
// us that desired feature automatically.

/// The [themeModeProvider] is a [StateProvider] to provide the state of
/// the [ThemeMode] used to toggle the application's theme mode.
final StateProvider<ThemeMode> themeModeProvider =
    StateProvider<ThemeMode>((StateProviderRef<ThemeMode> ref) {
  return hiveStore.get(KeyStore.themeMode,
          defaultValue: KeyStore.defaults[KeyStore.themeMode]! as ThemeMode)
      as ThemeMode;
}, name: KeyStore.themeMode);

/// The [lightThemeProvider] is a [StateProvider] to provide the state of
/// the light [ThemeData] used to define the light theme of the app.
final StateProvider<ThemeData> lightThemeProvider =
    StateProvider<ThemeData>((StateProviderRef<ThemeData> ref) {
  // The surface style is needed as means to select and to provide custom
  // surface colors as input to the FlexColorScheme.
  final FlexSurfaceMode surfaceStyle = ref.watch(surfaceStylePod);
  // We need to use the ColorScheme defined by used FlexColorScheme as input
  // to customized sub-theme's, so we create it first.
  return FlexThemeData.light(
    colors: ref.watch(currentSchemeProvider).light,
    surfaceMode: ref.watch(surfaceStylePod),
    tooltipsMatchBackground: ref.watch(tooltipsMatchBackgroundPod),
    appBarStyle: ref.watch(lightAppBarStylePod),
    tabBarStyle: ref.watch(tabBarStylePod),
    transparentStatusBar: false,
    surface: surfaceStyle == FlexSurfaceMode.custom
        ? ref.watch(lightSurfacePod)
        : null,
    background: surfaceStyle == FlexSurfaceMode.custom
        ? ref.watch(lightBackgroundPod)
        : null,
    scaffoldBackground: surfaceStyle == FlexSurfaceMode.custom
        ? ref.watch(lightScaffoldPod)
        : null,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: AppFonts.mainFont,
    platform: ref.watch(platformProvider),
    typography: Typography.material2021(platform: ref.watch(platformProvider)),
    subThemesData: const FlexSubThemesData(),
    extensions: <ThemeExtension<dynamic>>{ref.watch(flexScaffoldThemeProvider)},
  );
});

/// The [darkThemeProvider] is a [StateProvider] to provide the state of
/// the light [ThemeData] used to define the light theme of the app.
final StateProvider<ThemeData> darkThemeProvider =
    StateProvider<ThemeData>((StateProviderRef<ThemeData> ref) {
  // The surface style is needed as means to select and to provide custom
  // surface colors as input to the FlexColorScheme.
  final FlexSurfaceMode surfaceStyle = ref.watch(surfaceStylePod);

  // We need to use the ColorScheme defined by used FlexColorScheme as input
  // to customized sub-theme's, so we create it first.
  return FlexThemeData.dark(
    colors: ref.watch(currentSchemeProvider).dark,
    surfaceMode: ref.watch(surfaceStylePod),
    tooltipsMatchBackground: ref.watch(tooltipsMatchBackgroundPod),
    appBarStyle: ref.watch(darkAppBarStylePod),
    tabBarStyle: ref.watch(tabBarStylePod),
    transparentStatusBar: false,
    surface: surfaceStyle == FlexSurfaceMode.custom
        ? ref.watch(darkSurfacePod)
        : null,
    background: surfaceStyle == FlexSurfaceMode.custom
        ? ref.watch(darkBackgroundPod)
        : null,
    scaffoldBackground: surfaceStyle == FlexSurfaceMode.custom
        ? ref.watch(darkScaffoldPod)
        : null,
    darkIsTrueBlack: ref.watch(darkIsTrueBlackPod),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    fontFamily: AppFonts.mainFont,
    platform: ref.watch(platformProvider),
    typography: Typography.material2021(platform: ref.watch(platformProvider)),
    subThemesData: const FlexSubThemesData(),
    extensions: <ThemeExtension<dynamic>>{ref.watch(flexScaffoldThemeProvider)},
  );
});

// Get the currently selected color scheme.
final StateProvider<FlexSchemeData> currentSchemeProvider =
    StateProvider<FlexSchemeData>((StateProviderRef<FlexSchemeData> ref) {
  return ref.watch(schemesProvider)[ref.watch(schemeIndexPod)];
});

// Create a list with our custom color schemes and add
// all the FlexColorScheme built-in ones as well.
final Provider<List<FlexSchemeData>> schemesProvider =
    Provider<List<FlexSchemeData>>((ProviderRef<List<FlexSchemeData>> ref) {
  return <FlexSchemeData>[
    // Add all our schemes to the list of schemes. By using references to
    // the pods that determine effective colors and computing effective colors
    // and dark mode defined or used compute colors, we can get the entire
    // list of our scheme to update as we change these parameters as well.
    // This overkill, but want to demonstrate the capabilities of Riverpod.
    //
    // A default color scheme unique to Flexfold.
    FlexSchemeData(
      name: 'Flexfold default',
      description: 'This is the default Flexfold theme',
      light: FlexSchemeColor.effective(
        AppTheme.flexfoldLight,
        ref.watch(usedColorsPod),
        swapColors: ref.watch(lightSwapColorsPod),
        brightness: Brightness.light,
      ),
      dark: ref.watch(useToDarkMethodPod)
          ? FlexSchemeColor.effective(
              AppTheme.flexfoldLight,
              ref.watch(usedColorsPod),
              swapColors: ref.watch(darkSwapColorsPod),
              brightness: Brightness.dark,
            ).defaultError.toDark(ref.watch(darkLevelPod))
          : FlexSchemeColor.effective(
              AppTheme.flexfoldDark,
              ref.watch(usedColorsPod),
              swapColors: ref.watch(darkSwapColorsPod),
              brightness: Brightness.dark,
            ),
    ),
    //
    // Add the customizable color scheme unique to Flexfold.
    FlexSchemeData(
      name: 'Custom colors',
      description: 'This color scheme can be customized with a color picker. '
          'Click enabled colors below in ColorScheme and ThemeData to '
          'change them.',
      light: FlexSchemeColor.effective(
        ref.watch(customLightPod),
        ref.watch(usedColorsPod),
        swapColors: ref.watch(lightSwapColorsPod),
        brightness: Brightness.light,
      ),
      dark: ref.watch(useToDarkMethodPod)
          ? FlexSchemeColor.effective(
              ref.watch(customLightPod),
              ref.watch(usedColorsPod),
              swapColors: ref.watch(darkSwapColorsPod),
              brightness: Brightness.dark,
            ).defaultError.toDark(ref.watch(darkLevelPod))
          : FlexSchemeColor.effective(
              ref.watch(customDarkPod),
              ref.watch(usedColorsPod),
              swapColors: ref.watch(darkSwapColorsPod),
              brightness: Brightness.dark,
            ),
    ),
    //
    // Add the image based color scheme unique to Flexfold.
    FlexSchemeData(
      name: 'Image based',
      description: 'Based on prominent colors in the image selected below.',
      light: FlexSchemeColor.effective(
        ref.watch(imgLightPod),
        ref.watch(usedColorsPod),
        swapColors: ref.watch(lightSwapColorsPod),
        brightness: Brightness.light,
      ),
      dark: FlexSchemeColor.effective(
        ref.watch(imgLightPod),
        ref.watch(usedColorsPod),
        swapColors: ref.watch(darkSwapColorsPod),
        brightness: Brightness.dark,
      ).defaultError.toDark(ref.watch(darkLevelPod)),
    ),
    //
    // Add all built in FlexColor schemes, we can try them for inspiration.
    // They also get dynamically changed with used colors count and dark
    // via the computed option as well.
    for (FlexSchemeData data in FlexColor.schemesList)
      FlexSchemeData(
        name: data.name,
        description: data.description,
        light: FlexSchemeColor.effective(
          data.light,
          ref.watch(usedColorsPod),
          swapColors: ref.watch(lightSwapColorsPod),
          brightness: Brightness.light,
        ),
        dark: ref.watch(useToDarkMethodPod)
            ? FlexSchemeColor.effective(
                data.light,
                ref.watch(usedColorsPod),
                swapColors: ref.watch(darkSwapColorsPod),
                swapLegacy: data.light.swapOnMaterial3,
                brightness: Brightness.dark,
              ).defaultError.toDark(ref.watch(darkLevelPod))
            : FlexSchemeColor.effective(
                data.dark,
                ref.watch(usedColorsPod),
                swapColors: ref.watch(darkSwapColorsPod),
                swapLegacy: data.dark.swapOnMaterial3,
                brightness: Brightness.dark,
              ),
      ),
  ];
});

// StateProvider for the custom light theme.
final StateProvider<FlexSchemeColor> customLightPod =
    StateProvider<FlexSchemeColor>((StateProviderRef<FlexSchemeColor> ref) {
  return FlexSchemeColor.from(
    primary: ref.watch(lightPrimaryPod),
    primaryContainer: ref.watch(lightPrimaryVariantPod),
    secondary: ref.watch(lightSecondaryPod),
    secondaryContainer: ref.watch(lightSecondaryVariantPod),
    appBarColor: ref.watch(lightAppBarPod),
    error: ref.watch(lightErrorPod),
  );
});

// StateProvider for the custom dark theme.
final StateProvider<FlexSchemeColor> customDarkPod =
    StateProvider<FlexSchemeColor>((StateProviderRef<FlexSchemeColor> ref) {
  return FlexSchemeColor.from(
    primary: ref.watch(darkPrimaryPod),
    primaryContainer: ref.watch(darkPrimaryVariantPod),
    secondary: ref.watch(darkSecondaryPod),
    secondaryContainer: ref.watch(darkSecondaryVariantPod),
    appBarColor: ref.watch(darkAppBarPod),
    error: ref.watch(darkErrorPod),
  );
});

// StateProvider for the custom light image theme.
final StateProvider<FlexSchemeColor> imgLightPod =
    StateProvider<FlexSchemeColor>((StateProviderRef<FlexSchemeColor> ref) {
  return FlexSchemeColor.from(
    primary: ref.watch(imgLightPrimaryPod),
    primaryContainer: ref.watch(imgLightPrimaryVariantPod),
    secondary: ref.watch(imgLightSecondaryPod),
    secondaryContainer: ref.watch(imgLightSecondaryVariantPod),
    appBarColor: ref.watch(imgLightSecondaryVariantPod),
    error: ref.watch(lightErrorPod),
  );
});

// StateProvider for the recently used colors for color picker  dialog.
final StateProvider<List<Color>> dialogRecentColorsPod =
    StateProvider<List<Color>>((StateProviderRef<List<Color>> ref) {
  // ignore: avoid_dynamic_calls
  return hiveStore
      .get(KeyStore.dialogRecentColors,
          defaultValue:
              KeyStore.defaults[KeyStore.dialogRecentColors]! as List<Color>)
      .cast<Color>() as List<Color>;
}, name: KeyStore.dialogRecentColors);

// StateProvider for FlexColorScheme settings.
//
final StateProvider<int> usedColorsPod =
    StateProvider<int>((StateProviderRef<int> ref) {
  return hiveStore.get(KeyStore.usedColors,
      defaultValue: KeyStore.defaults[KeyStore.usedColors]! as int) as int;
}, name: KeyStore.usedColors);

final StateProvider<FlexSurfaceMode> surfaceStylePod =
    StateProvider<FlexSurfaceMode>((StateProviderRef<FlexSurfaceMode> ref) {
  return hiveStore.get(KeyStore.surfaceMode,
      defaultValue: KeyStore.defaults[KeyStore.surfaceMode]!
          as FlexSurfaceMode) as FlexSurfaceMode;
}, name: KeyStore.surfaceMode);

final StateProvider<FlexTabBarStyle> tabBarStylePod =
    StateProvider<FlexTabBarStyle>((StateProviderRef<FlexTabBarStyle> ref) {
  return hiveStore.get(KeyStore.tabBarStyle,
      defaultValue: KeyStore.defaults[KeyStore.tabBarStyle]!
          as FlexTabBarStyle) as FlexTabBarStyle;
}, name: KeyStore.tabBarStyle);

final StateProvider<int> schemeIndexPod =
    StateProvider<int>((StateProviderRef<int> ref) {
  return hiveStore.get(KeyStore.schemeIndex,
      defaultValue: KeyStore.defaults[KeyStore.schemeIndex]! as int) as int;
}, name: KeyStore.schemeIndex);

final StateProvider<int> schemeImageIndexPod =
    StateProvider<int>((StateProviderRef<int> ref) {
  return hiveStore.get(KeyStore.schemeImageIndex,
          defaultValue: KeyStore.defaults[KeyStore.schemeImageIndex]! as int)
      as int;
}, name: KeyStore.schemeImageIndex);

final StateProvider<int> imgUsedMixPod =
    StateProvider<int>((StateProviderRef<int> ref) {
  return hiveStore.get(KeyStore.imgUsedMix,
      defaultValue: KeyStore.defaults[KeyStore.imgUsedMix]! as int) as int;
}, name: KeyStore.imgUsedMix);

final StateProvider<bool> tooltipsMatchBackgroundPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.tooltipsMatchBackground,
      defaultValue:
          KeyStore.defaults[KeyStore.tooltipsMatchBackground]! as bool) as bool;
}, name: KeyStore.tooltipsMatchBackground);

final StateProvider<FlexAppBarStyle> lightAppBarStylePod =
    StateProvider<FlexAppBarStyle>((StateProviderRef<FlexAppBarStyle> ref) {
  return hiveStore.get(KeyStore.lightAppBarStyle,
      defaultValue: KeyStore.defaults[KeyStore.lightAppBarStyle]!
          as FlexAppBarStyle) as FlexAppBarStyle;
}, name: KeyStore.lightAppBarStyle);

// Provider for swapping primary and secondary colors in light theme mode.
final StateProvider<bool> lightSwapColorsPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.lightSwapColors,
          defaultValue: KeyStore.defaults[KeyStore.lightSwapColors]! as bool)
      as bool;
}, name: KeyStore.lightSwapColors);

final StateProvider<FlexAppBarStyle> darkAppBarStylePod =
    StateProvider<FlexAppBarStyle>((StateProviderRef<FlexAppBarStyle> ref) {
  return hiveStore.get(KeyStore.darkAppBarStyle,
      defaultValue: KeyStore.defaults[KeyStore.darkAppBarStyle]!
          as FlexAppBarStyle) as FlexAppBarStyle;
}, name: KeyStore.darkAppBarStyle);

// Provider for swapping primary and secondary colors in dark theme mode.
final StateProvider<bool> darkSwapColorsPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.darkSwapColors,
          defaultValue: KeyStore.defaults[KeyStore.darkSwapColors]! as bool)
      as bool;
}, name: KeyStore.darkSwapColors);

final StateProvider<bool> useToDarkMethodPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.useToDarkMethod,
          defaultValue: KeyStore.defaults[KeyStore.useToDarkMethod]! as bool)
      as bool;
}, name: KeyStore.useToDarkMethod);

final StateProvider<int> darkLevelPod =
    StateProvider<int>((StateProviderRef<int> ref) {
  return hiveStore.get(KeyStore.darkLevel,
      defaultValue: KeyStore.defaults[KeyStore.darkLevel]! as int) as int;
}, name: KeyStore.darkLevel);

final StateProvider<bool> darkIsTrueBlackPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.darkIsTrueBlack,
          defaultValue: KeyStore.defaults[KeyStore.darkIsTrueBlack]! as bool)
      as bool;
}, name: KeyStore.darkIsTrueBlack);

// StateProviders for the custom light color scheme colors.
final StateProvider<Color> lightPrimaryPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.lightPrimary,
          defaultValue: KeyStore.defaults[KeyStore.lightPrimary]! as Color)
      as Color;
}, name: KeyStore.lightPrimary);

final StateProvider<Color> lightPrimaryVariantPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.lightPrimaryVariant,
      defaultValue:
          KeyStore.defaults[KeyStore.lightPrimaryVariant]! as Color) as Color;
}, name: KeyStore.lightPrimaryVariant);

final StateProvider<Color> lightSecondaryPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.lightSecondary,
          defaultValue: KeyStore.defaults[KeyStore.lightSecondary]! as Color)
      as Color;
}, name: KeyStore.lightSecondary);

final StateProvider<Color> lightSecondaryVariantPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.lightSecondaryVariant,
      defaultValue:
          KeyStore.defaults[KeyStore.lightSecondaryVariant]! as Color) as Color;
}, name: KeyStore.lightSecondaryVariant);

final StateProvider<Color> lightBackgroundPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.lightBackground,
          defaultValue: KeyStore.defaults[KeyStore.lightBackground]! as Color)
      as Color;
}, name: KeyStore.lightBackground);

final StateProvider<Color> lightSurfacePod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.lightSurface,
          defaultValue: KeyStore.defaults[KeyStore.lightSurface]! as Color)
      as Color;
}, name: KeyStore.lightSurface);

final StateProvider<Color> lightScaffoldPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.lightScaffold,
          defaultValue: KeyStore.defaults[KeyStore.lightScaffold]! as Color)
      as Color;
}, name: KeyStore.lightScaffold);

final StateProvider<Color> lightAppBarPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.lightAppBar,
      defaultValue: KeyStore.defaults[KeyStore.lightAppBar]! as Color) as Color;
}, name: KeyStore.lightAppBar);

final StateProvider<Color> lightErrorPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.lightError,
      defaultValue: KeyStore.defaults[KeyStore.lightError]! as Color) as Color;
}, name: KeyStore.lightError);

// StateProviders for the custom dark color scheme colors.
final StateProvider<Color> darkPrimaryPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.darkPrimary,
      defaultValue: KeyStore.defaults[KeyStore.darkPrimary]! as Color) as Color;
}, name: KeyStore.darkPrimary);

final StateProvider<Color> darkPrimaryVariantPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.darkPrimaryVariant,
      defaultValue:
          KeyStore.defaults[KeyStore.darkPrimaryVariant]! as Color) as Color;
}, name: KeyStore.darkPrimaryVariant);

final StateProvider<Color> darkSecondaryPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.darkSecondary,
          defaultValue: KeyStore.defaults[KeyStore.darkSecondary]! as Color)
      as Color;
}, name: KeyStore.darkSecondary);

final StateProvider<Color> darkSecondaryVariantPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.darkSecondaryVariant,
      defaultValue:
          KeyStore.defaults[KeyStore.darkSecondaryVariant]! as Color) as Color;
}, name: KeyStore.darkSecondaryVariant);

final StateProvider<Color> darkBackgroundPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.darkBackground,
          defaultValue: KeyStore.defaults[KeyStore.darkBackground]! as Color)
      as Color;
}, name: KeyStore.darkBackground);

final StateProvider<Color> darkSurfacePod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.darkSurface,
      defaultValue: KeyStore.defaults[KeyStore.darkSurface]! as Color) as Color;
}, name: KeyStore.darkSurface);

final StateProvider<Color> darkScaffoldPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.darkScaffold,
          defaultValue: KeyStore.defaults[KeyStore.darkScaffold]! as Color)
      as Color;
}, name: KeyStore.darkScaffold);

final StateProvider<Color> darkAppBarPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.darkAppBar,
      defaultValue: KeyStore.defaults[KeyStore.darkAppBar]! as Color) as Color;
}, name: KeyStore.darkAppBar);

final StateProvider<Color> darkErrorPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.darkError,
      defaultValue: KeyStore.defaults[KeyStore.darkError]! as Color) as Color;
}, name: KeyStore.darkError);

// StateProviders for the IMage color based light color scheme colors.
final StateProvider<Color> imgLightPrimaryPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.imgLightPrimary,
          defaultValue: KeyStore.defaults[KeyStore.imgLightPrimary]! as Color)
      as Color;
}, name: KeyStore.imgLightPrimary);

final StateProvider<Color> imgLightPrimaryVariantPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.imgLightPrimaryVariant,
      defaultValue: KeyStore.defaults[KeyStore.imgLightPrimaryVariant]!
          as Color) as Color;
}, name: KeyStore.imgLightPrimaryVariant);

final StateProvider<Color> imgLightSecondaryPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.imgLightSecondary,
          defaultValue: KeyStore.defaults[KeyStore.imgLightSecondary]! as Color)
      as Color;
}, name: KeyStore.imgLightSecondary);

final StateProvider<Color> imgLightSecondaryVariantPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(KeyStore.imgLightSecondaryVariant,
      defaultValue: KeyStore.defaults[KeyStore.imgLightSecondaryVariant]!
          as Color) as Color;
}, name: KeyStore.imgLightSecondaryVariant);
