import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';

import '../model/app_animation_curve.dart';
import '../model/app_text_direction.dart';

// Constants used as key values for storing, ie persisting all the
// settings and options used in this Flexfold demo app.
//
// The key store constants are also used in a [KeyStore.defaults] map as
// key to an object map that holds the default value for the stored key.
//
// Additionally the keys are used as names for Riverpod "pod" providers. This
// allows us to observe named providers in a single ProviderObserver and
// persist any named provider that also has KeyStore key whenever its provider
// value is updated.
class KeyStore {
  // This class is not meant to be instantiated or extended, this constructor
  // prevents external instantiation and extension.
  KeyStore._();

  // Key for storing the used theme mode.
  static const String themeMode = 'themeMode';
  // Key for storing used test direction.
  static const String appTextDirection = 'customTextDirection';
  // Key for selected recent colors.
  static const String dialogRecentColors = 'dialogRecentColors';
  // Keys for storing FlexColorScheme settings.
  static const String usedColors = 'usedColors';
  static const String surfaceMode = 'surfaceMode';
  static const String blendLevel = 'blendLevel';
  static const String tabBarStyle = 'tabBarStyle';
  static const String schemeIndex = 'schemeIndex';

  static const String tooltipsMatchBackground = 'tooltipsMatchBackground';

  static const String lightAppBarStyle = 'lightAppBarStyle';
  static const String lightSwapColors = 'lightSwapColors';

  static const String darkAppBarStyle = 'darkAppBarStyle';
  static const String darkSwapColors = 'darkSwapColors';

  static const String useToDarkMethod = 'useToDarkMethod';
  static const String darkLevel = 'darkLevel';
  static const String darkIsTrueBlack = 'darkIsTrueBlack';

  // Keys for storing the colors used for the custom light color scheme.
  static const String lightPrimary = 'lightPrimary';
  static const String lightPrimaryVariant = 'lightPrimaryVariant';
  static const String lightSecondary = 'lightSecondary';
  static const String lightSecondaryVariant = 'lightSecondaryVariant';
  static const String lightBackground = 'lightBackground';
  static const String lightSurface = 'lightSurface';
  static const String lightScaffold = 'lightScaffold';
  static const String lightAppBar = 'lightAppBar';
  static const String lightError = 'lightError';

  // Keys for storing the colors used for the custom dark color scheme.
  static const String darkPrimary = 'darkPrimary';
  static const String darkPrimaryVariant = 'darkPrimaryVariant';
  static const String darkSecondary = 'darkSecondary';
  static const String darkSecondaryVariant = 'darkSecondaryVariant';
  static const String darkBackground = 'darkBackground';
  static const String darkSurface = 'darkSurface';
  static const String darkScaffold = 'darkScaffold';
  static const String darkAppBar = 'darkAppBar';
  static const String darkError = 'darkError';

  // Keys for storing the colors used for the image based color scheme.
  // There are only colors for a light theme based on an image, the
  // corresponding image based dark theme is computed by FlexColorScheme.
  static const String imgLightPrimary = 'imgLightPrimary';
  static const String imgLightPrimaryVariant = 'imgLightPrimaryVariant';
  static const String imgLightSecondary = 'imgLightSecondary';
  static const String imgLightSecondaryVariant = 'imgLightSecondaryVariant';
  static const String imgUsedMix = 'imgUsedMix';
  static const String schemeImageIndex = 'schemeImageIndex';

  // Below string key lookup values for all Flexfold properties.
  // These are used as key for storing the properties if/when they are
  // persisted and as lookup value for defaults for stored properties.
  // All of them are not persisted, some keys were defined in advance.

  // Menu, drawer, rail, sidebar state properties and its callbacks.
  static const String menuControlEnabled = 'menuControlEnabled';
  static const String sidebarControlEnabled = 'sidebarControlEnabled';
  static const String cycleViaDrawer = 'cycleViaDrawer';
  static const String useCustomMenuIcons = 'useCustomMenuIcons';
  static const String hideMenu = 'hideMenu';
  static const String preferRail = 'preferRail';
  static const String hideSidebar = 'hideSidebar';

  // Bottom navigation bar visibility properties.
  static const String hideBottomBarOnScroll = 'hideBottomBarOnScroll';
  static const String hideBottomBar = 'hideBottomBar';
  static const String showBottomBarWhenMenuInDrawer =
      'showBottomBarWhenMenuInDrawer';
  static const String showBottomBarWhenMenuShown = 'showBottomBarWhenMenuShown';
  static const String bottomDestinationsInDrawer = 'bottomDestinationsInDrawer';

  // Navigation type breakpoints
  static const String breakpointDrawer = 'breakpointDrawer';
  static const String breakpointRail = 'breakpointRail';
  static const String breakpointMenu = 'breakpointMenu';
  static const String breakpointSidebar = 'breakpointSidebar';

  // Width properties
  static const String menuWidth = 'menuWidth';
  static const String railWidth = 'railWidth';
  static const String sidebarWidth = 'sidebarWidth';

  // Menu style settings
  static const String showMenuLeading = 'showMenuLeading';
  static const String showMenuTrailing = 'showMenuTrailing';
  static const String showMenuFooter = 'showMenuFooter';
  static const String menuHighlightType = 'menuHighlightType';

  // Menu selection and highlight style
  static const String menuHighlightHeight = 'menuHighlightHeight';
  // Menu start and side settings
  static const String menuStart = 'menuStart';
  static const String menuSide = 'menuSide';

  // Edge border properties
  static const String borderOnMenu = 'borderOnMenu';
  static const String borderOnDarkDrawer = 'borderOnDarkDrawer';
  static const String sidebarBelongsToBody = 'sidebarBelongsToBody';
  //
  // Bottom navigation bar properties
  static const String bottomBarType = 'bottomBarType';
  static const String bottomBarIsTransparent = 'bottomBarIsTransparent';
  static const String bottomBarBlur = 'bottomBarBlur';
  static const String bottomBarOpacity = 'bottomBarOpacity';
  static const String bottomBarTopBorder = 'bottomBarTopBorder';

  // Below string key lookup values for all Flexfold AppBar.Styled properties.
  // These are used as key for storing the properties if/when they are
  // persisted and as lookup value for defaults for stored properties.
  // All of them are not persisted, some keys were defined in advance.
  static const String appBarGradient = 'appBarGradient';
  static const String appBarBlur = 'appBarBlur';
  static const String appBarTransparent = 'appBarTransparent';
  static const String appBarOpacity = 'appBarOpacity';
  static const String appBarBorderOnSurface = 'appBarBorderOnSurface';
  static const String appBarBorder = 'appBarBorder';
  static const String appBarShowScreenSize = 'appBarShowScreenSize';
  // Experimental new AppBar.styled feature
  static const String appBarFloat = 'appBarFloat';
  static const String appBarScrim = 'appBarScrim';

  // Scaffold extend body properties.
  static const String extendBody = 'extendBody';
  static const String extendBodyBehindAppBar = 'extendBodyBehindAppBar';

  // Animations
  static const String animationCurve = 'animationCurve';
  static const String animationDuration = 'animationDuration';

  // Application Setting
  static const String useTooltips = 'useTooltips';
  static const String appDirectionality = 'appDirectionality';
  static const String useModalRoutes = 'useModalRoutes';
  static const String plasmaBackground = 'plasmaBackground';

  // Map with default values for all KeyStore values that are persisted and
  // have a Riverpod "pod" state provider value.
  static const Map<String, Object> defaults = <String, Object>{
    // Default for theme related values.
    themeMode: ThemeMode.light,

    dialogRecentColors: <Color>[],
    usedColors: 4,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 10,
    tabBarStyle: FlexTabBarStyle.forBackground,
    schemeIndex: 26, // FlexScheme.bigStone,

    tooltipsMatchBackground: true,

    lightAppBarStyle: FlexAppBarStyle.primary,
    lightSwapColors: false,

    darkAppBarStyle: FlexAppBarStyle.material,
    darkSwapColors: false,

    useToDarkMethod: false,
    darkLevel: 35,
    darkIsTrueBlack: false,

    // TODO(rydmike): change default custom colors!
    // Defaults for custom light color scheme related values.
    lightPrimary: Color(0xFFEF6C00), // orange800
    lightPrimaryVariant: Color(0xFFE65100), // orange900
    lightSecondary: Color(0xFF2979FF), // blueAccent400
    lightSecondaryVariant: Color(0xFF2962FF), // blueAccent700
    lightBackground: Colors.white, // Material default light bg
    lightSurface: Colors.white, // Material default light bg
    lightScaffold: Colors.white, // Material default light bg
    lightAppBar: Color(0xFF2962FF), // blueAccent700
    lightError: Color(0xFFB00020), // Material default light error color
    // Defaults for custom dark color scheme related values.
    darkPrimary: Color(0xFFFFB74D), // orange300
    darkPrimaryVariant: Color(0xFFFFA726), // orange400
    darkSecondary: Color(0xFF82B1FF), // blueAccent100
    darkSecondaryVariant: Color(0xFF448AFF), // blueAccent200
    darkBackground: Color(0xFF121212), // Material default dark bg
    darkSurface: Color(0xFF121212), // Material default dark bg
    darkScaffold: Color(0xFF121212), // Material default dark bg
    darkAppBar: Color(0xFF448AFF), // blueAccent200
    darkError: Color(0xFFCF6679), // Material default dark error color
    // Default for image based color
    imgLightPrimary: Color(0xFFEF6C00), // orange800
    imgLightPrimaryVariant: Color(0xFFE65100), // orange900
    imgLightSecondary: Color(0xFF2979FF), // blueAccent400
    imgLightSecondaryVariant: Color(0xFF2962FF), // blueAccent700
    imgUsedMix: 1,
    schemeImageIndex: 0,

    // Menu control default values.
    menuControlEnabled: true,
    sidebarControlEnabled: true,
    cycleViaDrawer: false,
    useCustomMenuIcons: false,

    // Visibility controls.
    hideMenu: false,
    preferRail: false,
    hideSidebar: false,
    hideBottomBar: false,
    hideBottomBarOnScroll: true,
    showBottomBarWhenMenuInDrawer: true,
    showBottomBarWhenMenuShown: false,
    bottomDestinationsInDrawer: false,

    // Menu breakpoint default values.
    breakpointDrawer: 550.0,
    breakpointRail: 600.0,
    breakpointMenu: 1024.0,
    breakpointSidebar: 1200.0,

    // Menu width default values.
    menuWidth: 250.0,
    railWidth: 56.0,
    sidebarWidth: 304.0,

    // Menu style default values.
    showMenuLeading: true,
    showMenuTrailing: true,
    showMenuFooter: true,
    menuHighlightType: FlexIndicatorStyle.endStadium,
    menuHighlightHeight: 50.0,
    menuStart: FlexfoldMenuStart.top,
    menuSide: FlexfoldMenuSide.start,

    // Bottom bar properties.
    bottomBarType: FlexfoldBottomBarType.adaptive,
    bottomBarIsTransparent: true,
    bottomBarBlur: true,
    bottomBarOpacity: 0.7,
    bottomBarTopBorder: true,

    // AppBar properties
    appBarGradient: true,
    appBarTransparent: true,
    appBarBlur: true,
    appBarOpacity: 0.7,
    appBarBorderOnSurface: true,
    appBarBorder: false,
    appBarShowScreenSize: false,
    // Experimental new AppBar.styled feature
    appBarFloat: false,
    appBarScrim: false,

    // Extend scaffold behind app and bottom bar properties.
    extendBody: true,
    extendBodyBehindAppBar: true,

    // Other settings
    borderOnMenu: true,
    borderOnDarkDrawer: true,
    sidebarBelongsToBody: false,

    // Animations
    animationCurve: AppAnimationCurve.linear,
    animationDuration: 246,

    // Application setting properties.
    useTooltips: true,
    appTextDirection: AppTextDirection.localeBased,
    useModalRoutes: true,
    plasmaBackground: false,
  };
}
