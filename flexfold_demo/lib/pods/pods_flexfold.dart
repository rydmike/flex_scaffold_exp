import 'package:flexfold/flexfold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/app_animation_curve.dart';
import '../store/hive_store.dart';
import '../store/key_store.dart';

// This file contains StateProviders that control Flexfold API settings
// demonstrated in this example, including:
//
// - Menu controls, style, width, breakpoints
// - AppBar options
// - Bottom navigation bar
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

// State providers used to control menu control buttons and their behavior.

final StateProvider<bool> menuControlEnabledPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.menuControlEnabled,
          defaultValue: KeyStore.defaults[KeyStore.menuControlEnabled]! as bool)
      as bool;
}, name: KeyStore.menuControlEnabled);

final StateProvider<bool> sidebarControlEnabledPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.sidebarControlEnabled,
      defaultValue:
          KeyStore.defaults[KeyStore.sidebarControlEnabled]! as bool) as bool;
}, name: KeyStore.sidebarControlEnabled);

final StateProvider<bool> cycleViaDrawerPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.cycleViaDrawer,
          defaultValue: KeyStore.defaults[KeyStore.cycleViaDrawer]! as bool)
      as bool;
}, name: KeyStore.cycleViaDrawer);

final StateProvider<bool> useCustomMenuIconsPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.useCustomMenuIcons,
          defaultValue: KeyStore.defaults[KeyStore.useCustomMenuIcons]! as bool)
      as bool;
}, name: KeyStore.useCustomMenuIcons);

// State providers used to control visibility of menu, rail, bottom bar.

final StateProvider<bool> hideMenuPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.hideMenu,
      defaultValue: KeyStore.defaults[KeyStore.hideMenu]! as bool) as bool;
}, name: KeyStore.hideMenu);

final StateProvider<bool> preferRailPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.preferRail,
      defaultValue: KeyStore.defaults[KeyStore.preferRail]! as bool) as bool;
}, name: KeyStore.preferRail);

final StateProvider<bool> hideSidebarPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.hideSidebar,
      defaultValue: KeyStore.defaults[KeyStore.hideSidebar]! as bool) as bool;
}, name: KeyStore.hideSidebar);

final StateProvider<bool> hideBottomBarPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.hideBottomBar,
      defaultValue: KeyStore.defaults[KeyStore.hideBottomBar]! as bool) as bool;
}, name: KeyStore.hideBottomBar);

final StateProvider<bool> hideBottomBarOnScrollPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.hideBottomBarOnScroll,
      defaultValue:
          KeyStore.defaults[KeyStore.hideBottomBarOnScroll]! as bool) as bool;
}, name: KeyStore.hideBottomBarOnScroll);

// This state is modified by scroll listeners, not persisted
final StateProvider<bool> scrollHiddenBottomBarPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return false;
});

final StateProvider<bool> showBottomBarWhenMenuInDrawerPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.showBottomBarWhenMenuInDrawer,
      defaultValue: KeyStore.defaults[KeyStore.showBottomBarWhenMenuInDrawer]!
          as bool) as bool;
}, name: KeyStore.showBottomBarWhenMenuInDrawer);

final StateProvider<bool> showBottomBarWhenMenuShownPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.showBottomBarWhenMenuShown,
      defaultValue: KeyStore.defaults[KeyStore.showBottomBarWhenMenuShown]!
          as bool) as bool;
}, name: KeyStore.showBottomBarWhenMenuShown);

final StateProvider<bool> bottomDestinationsInDrawerPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.bottomDestinationsInDrawer,
      defaultValue: KeyStore.defaults[KeyStore.bottomDestinationsInDrawer]!
          as bool) as bool;
}, name: KeyStore.bottomDestinationsInDrawer);

// State providers used to control menu breakpoints.

final StateProvider<double> breakpointDrawerPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(KeyStore.breakpointDrawer,
          defaultValue: KeyStore.defaults[KeyStore.breakpointDrawer]! as double)
      as double;
}, name: KeyStore.breakpointDrawer);

final StateProvider<double> breakpointRailPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(KeyStore.breakpointRail,
          defaultValue: KeyStore.defaults[KeyStore.breakpointRail]! as double)
      as double;
}, name: KeyStore.breakpointRail);

final StateProvider<double> breakpointMenuPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(KeyStore.breakpointMenu,
          defaultValue: KeyStore.defaults[KeyStore.breakpointMenu]! as double)
      as double;
}, name: KeyStore.breakpointMenu);

final StateProvider<double> breakpointSidebarPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(KeyStore.breakpointSidebar,
      defaultValue:
          KeyStore.defaults[KeyStore.breakpointSidebar]! as double) as double;
}, name: KeyStore.breakpointSidebar);

// State providers used to control menu widths.

final StateProvider<double> menuWidthPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(KeyStore.menuWidth,
      defaultValue: KeyStore.defaults[KeyStore.menuWidth]! as double) as double;
}, name: KeyStore.menuWidth);

final StateProvider<double> railWidthPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(KeyStore.railWidth,
      defaultValue: KeyStore.defaults[KeyStore.railWidth]! as double) as double;
}, name: KeyStore.railWidth);

final StateProvider<double> sidebarWidthPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(KeyStore.sidebarWidth,
          defaultValue: KeyStore.defaults[KeyStore.sidebarWidth]! as double)
      as double;
}, name: KeyStore.sidebarWidth);

// State providers used to control menu style.

final StateProvider<bool> showMenuLeadingPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.showMenuLeading,
          defaultValue: KeyStore.defaults[KeyStore.showMenuLeading]! as bool)
      as bool;
}, name: KeyStore.showMenuLeading);

final StateProvider<bool> showMenuTrailingPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.showMenuTrailing,
          defaultValue: KeyStore.defaults[KeyStore.showMenuTrailing]! as bool)
      as bool;
}, name: KeyStore.showMenuTrailing);

final StateProvider<bool> showMenuFooterPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.showMenuFooter,
          defaultValue: KeyStore.defaults[KeyStore.showMenuFooter]! as bool)
      as bool;
}, name: KeyStore.showMenuFooter);

final StateProvider<FlexIndicatorStyle> menuHighlightTypePod =
    StateProvider<FlexIndicatorStyle>(
        (StateProviderRef<FlexIndicatorStyle> ref) {
  return hiveStore.get(KeyStore.menuHighlightType,
      defaultValue: KeyStore.defaults[KeyStore.menuHighlightType]!
          as FlexIndicatorStyle) as FlexIndicatorStyle;
}, name: KeyStore.menuHighlightType);

final StateProvider<double> menuHighlightHeightPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(KeyStore.menuHighlightHeight,
      defaultValue:
          KeyStore.defaults[KeyStore.menuHighlightHeight]! as double) as double;
}, name: KeyStore.menuHighlightHeight);

final StateProvider<FlexfoldMenuStart> menuStartPod =
    StateProvider<FlexfoldMenuStart>((StateProviderRef<FlexfoldMenuStart> ref) {
  return hiveStore.get(KeyStore.menuStart,
      defaultValue: KeyStore.defaults[KeyStore.menuStart]!
          as FlexfoldMenuStart) as FlexfoldMenuStart;
}, name: KeyStore.menuStart);

final StateProvider<FlexfoldMenuSide> menuSidePod =
    StateProvider<FlexfoldMenuSide>((StateProviderRef<FlexfoldMenuSide> ref) {
  return hiveStore.get(KeyStore.menuSide,
      defaultValue: KeyStore.defaults[KeyStore.menuSide]!
          as FlexfoldMenuSide) as FlexfoldMenuSide;
}, name: KeyStore.menuSide);

// State providers used to control bottom navigation bar.

final StateProvider<FlexfoldBottomBarType> bottomBarTypePod =
    StateProvider<FlexfoldBottomBarType>(
        (StateProviderRef<FlexfoldBottomBarType> ref) {
  return hiveStore.get(KeyStore.bottomBarType,
      defaultValue: KeyStore.defaults[KeyStore.bottomBarType]!
          as FlexfoldBottomBarType) as FlexfoldBottomBarType;
}, name: KeyStore.bottomBarType);

final StateProvider<bool> bottomBarIsTransparentPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.bottomBarIsTransparent,
      defaultValue:
          KeyStore.defaults[KeyStore.bottomBarIsTransparent]! as bool) as bool;
}, name: KeyStore.bottomBarIsTransparent);

final StateProvider<bool> bottomBarBlurPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.bottomBarBlur,
      defaultValue: KeyStore.defaults[KeyStore.bottomBarBlur]! as bool) as bool;
}, name: KeyStore.bottomBarBlur);

final StateProvider<double> bottomBarOpacityPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(KeyStore.bottomBarOpacity,
          defaultValue: KeyStore.defaults[KeyStore.bottomBarOpacity]! as double)
      as double;
}, name: KeyStore.bottomBarOpacity);

final StateProvider<bool> bottomBarTopBorderPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.bottomBarTopBorder,
          defaultValue: KeyStore.defaults[KeyStore.bottomBarTopBorder]! as bool)
      as bool;
}, name: KeyStore.bottomBarTopBorder);

// State providers used to control appbar.

final StateProvider<bool> appBarGradientPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.appBarGradient,
          defaultValue: KeyStore.defaults[KeyStore.appBarGradient]! as bool)
      as bool;
}, name: KeyStore.appBarGradient);

final StateProvider<bool> appBarTransparentPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.appBarTransparent,
          defaultValue: KeyStore.defaults[KeyStore.appBarTransparent]! as bool)
      as bool;
}, name: KeyStore.appBarTransparent);

final StateProvider<bool> appBarBlurPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.appBarBlur,
      defaultValue: KeyStore.defaults[KeyStore.appBarBlur]! as bool) as bool;
}, name: KeyStore.appBarBlur);

final StateProvider<double> appBarOpacityPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(KeyStore.appBarOpacity,
          defaultValue: KeyStore.defaults[KeyStore.appBarOpacity]! as double)
      as double;
}, name: KeyStore.appBarOpacity);

final StateProvider<bool> appBarBorderOnSurfacePod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.appBarBorderOnSurface,
      defaultValue:
          KeyStore.defaults[KeyStore.appBarBorderOnSurface]! as bool) as bool;
}, name: KeyStore.appBarBorderOnSurface);

final StateProvider<bool> appBarBorderPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.appBarBorder,
      defaultValue: KeyStore.defaults[KeyStore.appBarBorder]! as bool) as bool;
}, name: KeyStore.appBarBorder);

final StateProvider<bool> appBarShowScreenSizePod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.appBarShowScreenSize,
      defaultValue:
          KeyStore.defaults[KeyStore.appBarShowScreenSize]! as bool) as bool;
}, name: KeyStore.appBarShowScreenSize);

final StateProvider<bool> appBarFloatPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.appBarFloat,
      defaultValue: KeyStore.defaults[KeyStore.appBarFloat]! as bool) as bool;
}, name: KeyStore.appBarFloat);

final StateProvider<bool> appBarScrimPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.appBarScrim,
      defaultValue: KeyStore.defaults[KeyStore.appBarScrim]! as bool) as bool;
}, name: KeyStore.appBarScrim);

// Other settings

final StateProvider<bool> borderOnMenuPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.borderOnMenu,
      defaultValue: KeyStore.defaults[KeyStore.borderOnMenu]! as bool) as bool;
}, name: KeyStore.borderOnMenu);

final StateProvider<bool> borderOnDarkDrawerPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.borderOnDarkDrawer,
          defaultValue: KeyStore.defaults[KeyStore.borderOnDarkDrawer]! as bool)
      as bool;
}, name: KeyStore.borderOnDarkDrawer);

final StateProvider<bool> sidebarBelongsToBodyPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.sidebarBelongsToBody,
      defaultValue:
          KeyStore.defaults[KeyStore.sidebarBelongsToBody]! as bool) as bool;
}, name: KeyStore.sidebarBelongsToBody);

// Enum state provider representing animations curves we can use in this demo.
// Having them as an enum make it easy to persist the selection.
final StateProvider<AppAnimationCurve> animationCurvePod =
    StateProvider<AppAnimationCurve>((StateProviderRef<AppAnimationCurve> ref) {
  return hiveStore.get(KeyStore.animationCurve,
      defaultValue: KeyStore.defaults[KeyStore.animationCurve]!
          as AppAnimationCurve) as AppAnimationCurve;
}, name: KeyStore.animationCurve);

// A provider that returns the actual animation Curve the enum represents.
final Provider<Curve> flexMenuCurveProvider = Provider<Curve>(
  (ProviderRef<Curve> ref) {
    switch (ref.watch(animationCurvePod)) {
      case AppAnimationCurve.linear:
        return Curves.linear;
      case AppAnimationCurve.easeInOut:
        return Curves.easeInOut;
      case AppAnimationCurve.easeInOutQuart:
        return Curves.easeInOutQuart;
      case AppAnimationCurve.easeInOutExpo:
        return Curves.easeInOutExpo;
      case AppAnimationCurve.bounceOut:
        return Curves.bounceOut;
    }
  },
  name: 'flexMenuCurveProvider',
);

final StateProvider<int> animationDurationPod =
    StateProvider<int>((StateProviderRef<int> ref) {
  return hiveStore.get(KeyStore.animationDuration,
          defaultValue: KeyStore.defaults[KeyStore.animationDuration]! as int)
      as int;
}, name: KeyStore.animationDuration);

// State provider to extend scaffold behind app and bottom bar.

final StateProvider<bool> extendBodyPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.extendBody,
      defaultValue: KeyStore.defaults[KeyStore.extendBody]! as bool) as bool;
}, name: KeyStore.extendBody);

final StateProvider<bool> extendBodyBehindAppBarPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.extendBodyBehindAppBar,
      defaultValue:
          KeyStore.defaults[KeyStore.extendBodyBehindAppBar]! as bool) as bool;
}, name: KeyStore.extendBodyBehindAppBar);

// Application Tooltip state provider.
final StateProvider<bool> useTooltipsPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.useTooltips,
      defaultValue: KeyStore.defaults[KeyStore.useTooltips]! as bool) as bool;
}, name: KeyStore.useTooltips);

// StateProvider for the platform. This one is currently not persisted on
// on purpose. We always want to get it reset to native platform when
// restarting. It is mostly available for debugging purposes.
final StateProvider<TargetPlatform> platformProvider =
    StateProvider<TargetPlatform>((StateProviderRef<TargetPlatform> ref) {
  return defaultTargetPlatform;
});
