import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/const/app_tooltips.dart';
import '../../settings/controllers/pods_flexfold.dart';

/// A provider for our used [FlexScaffoldThemeData].
final Provider<FlexScaffoldThemeData> flexScaffoldThemeProvider =
    Provider<FlexScaffoldThemeData>(
  (ProviderRef<FlexScaffoldThemeData> ref) {
    // TODO(rydmike): Remove the context usage, somehow.
    // We use the Flexfold menu highlight helper class to make
    // border shapes and let it adjust margins for the shapes.
    // It is possible to make totally custom highlight and hover
    // shapes and they don't even have to be the same.

    // final TextDirection directionality = Directionality.of(context);
    const TextDirection directionality = TextDirection.ltr;

    // The style of the selected highlighted item.
    final FlexMenuIndicator menuSelected = FlexMenuIndicator(
      highlightType: ref.watch(menuHighlightTypePod),
      // borderColor: Theme.of(context).primaryColor,
      // highlightColor: Theme.of(context).colorScheme.primary.withAlpha(0x3d),
      height: ref.watch(menuHighlightHeightPod),
      borderRadius: ref.watch(menuHighlightHeightPod) / 6,
      directionality: directionality,
    );
    // The style of the item that is hovered on web and desktop.
    final FlexMenuIndicator menuHover = FlexMenuIndicator(
      highlightType: ref.watch(menuHighlightTypePod),
      borderColor: Colors.transparent,
      highlightColor: Colors.transparent,
      height: ref.watch(menuHighlightHeightPod),
      borderRadius: ref.watch(menuHighlightHeightPod) / 6,
      directionality: directionality,
    );

    return FlexScaffoldThemeData(
      // TODO(rydmike): Uncomment to test background colors via properties.
      // menuBackgroundColor: isLight ? Color(0xFFE9EFEA) : Color(0xFF18231B),
      //     Theme.of(context).backgroundColor, //Colors.pink[100],
      // sidebarBackgroundColor: Colors.yellow[100],

      // Set if we start from top or bottom of screen
      menuStart: ref.watch(menuStartPod),
      // Set if we have the menu on start or end side of screen
      menuSide: ref.watch(menuSidePod),

      // Uncomment to see that menuElevation elevation works.
      // TODO(rydmike): This elevation does not work! Figure out why not.
      // Not going to using it in this demo even if it would work because
      // it is ugly (opinionated), but it should of course be a supported
      // feature.
      menuElevation: 0,
      // Uncomment to use sidebarElevation.
      // Not used in this demo because it is not so pretty (opinionated).
      sidebarElevation: 0,
      // We use same width value for the drawer and the menu in this demo,
      // but they can of course be different.
      menuWidth: ref.watch(menuWidthPod),
      drawerWidth: ref.watch(menuWidthPod),
      // Rail width
      railWidth: ref.watch(railWidthPod),
      // We use same width value for end drawer and sidebar in this demo,
      // but they can of course be different.
      sidebarWidth: ref.watch(sidebarWidthPod),
      endDrawerWidth: ref.watch(sidebarWidthPod),
      // Breakpoint settings
      breakpointDrawer: ref.watch(breakpointDrawerPod),
      breakpointRail: ref.watch(breakpointRailPod),
      breakpointMenu: ref.watch(breakpointMenuPod),
      breakpointSidebar: ref.watch(breakpointSidebarPod),
      // Border edge configurations
      borderOnMenu: ref.watch(borderOnMenuPod),
      borderOnSidebar: ref.watch(borderOnMenuPod),
      borderOnDarkDrawer: ref.watch(borderOnDarkDrawerPod),
      borderOnLightDrawer: false,
      // borderColor: Colors.green[400], // You can control the color too
      // Menu design and layout properties
      menuHighlightHeight: ref.watch(menuHighlightHeightPod),
      menuHighlightMargins: menuSelected.margins,
      menuHighlightShape: menuHover.shape(),
      menuSelectedShape: menuSelected.shape(),
      menuHighlightColor: menuSelected.highlight,
      // Individual animation durations are available, but for this
      // demo they all share the same setting.
      menuAnimationDuration:
          Duration(milliseconds: ref.watch(animationDurationPod)),
      sidebarAnimationDuration:
          Duration(milliseconds: ref.watch(animationDurationPod)),
      bottomBarAnimationDuration:
          Duration(milliseconds: ref.watch(animationDurationPod)),
      //
      // The animation curve for rail/menu, sidebar and bottom bar
      // can be set separately, but this demo uses the same setting for all.
      menuAnimationCurve: ref.watch(flexMenuCurveProvider),
      sidebarAnimationCurve: ref.watch(flexMenuCurveProvider),
      bottomBarAnimationCurve: ref.watch(flexMenuCurveProvider),
      //
      // Bottom navigation bar theme and additional visual properties for
      // the bottom navigation bar.
      bottomBarType: ref.watch(bottomBarTypePod),
      bottomBarIsTransparent: ref.watch(bottomBarIsTransparentPod),
      bottomBarBlur: ref.watch(bottomBarBlurPod),
      bottomBarOpacity: ref.watch(bottomBarOpacityPod),
      bottomBarTopBorder: ref.watch(bottomBarTopBorderPod),
      //
      // Tooltip settings
      useTooltips: ref.watch(useTooltipsPod),
      menuOpenTooltip: AppTooltips.openMenu,
      menuCloseTooltip: AppTooltips.closeMenu,
      menuExpandTooltip: AppTooltips.expandMenu,
      menuExpandHiddenTooltip: AppTooltips.expandHiddenMenu,
      menuCollapseTooltip: AppTooltips.collapseMenu,
      sidebarOpenTooltip: AppTooltips.openSidebar,
      sidebarCloseTooltip: AppTooltips.closeSidebar,
      sidebarExpandTooltip: AppTooltips.expandSidebar,
      sidebarExpandHiddenTooltip: AppTooltips.expandHiddenSidebar,
      sidebarCollapseTooltip: AppTooltips.collapseSidebar,
    );
  },
  name: 'lightThemeProvider',
);
