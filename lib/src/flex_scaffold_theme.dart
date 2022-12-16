// import 'dart:ui' show lerpDouble;
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// import 'flex_scaffold.dart';
// import 'flex_scaffold_constants.dart';
//
// /// Defines default property values for descendant [FlexScaffold] widgets.
// ///
// /// Descendant widgets obtain the current [FlexScaffoldThemeData] object
// /// using `FlexfoldTheme.of(context)`. Instances of
// /// [FlexScaffoldThemeData] can be customized with
// /// [FlexScaffoldThemeData.copyWith].
// ///
// /// Typically a [FlexScaffoldThemeData] is passed in to the [FlexScaffold] via
// /// its [FlexScaffoldTheme] property, but it can also be inherited from
// /// [FlexScaffoldTheme] widget higher up in the widget tree. A passed in theme
// /// is merged with the theme higher up in the tree for the effective theme.
// ///
// /// All [FlexScaffoldThemeData] properties are `null` by default.
// /// When null, the [FlexScaffold] will provide its own defaults based on the
// /// overall [Theme]'s [DividerTheme], [BottomNavigationBarTheme] and
// /// [NavigationRailTheme] if they exist, if not it will be based on base
// /// [Theme] property values like textTheme, colorScheme, dividerColor as
// /// well as Flexfold constant values or SDK constants and values matching the
// /// material standards and guidelines.
// ///
// /// See the individual [FlexScaffoldThemeData] properties for default value
// /// details.
// @immutable
// class FlexScaffoldThemeData with Diagnosticable {
//   /// Creates a theme that can be used for [FlexScaffold].
//   const FlexScaffoldThemeData({
//     //
//     // Background color properties
//     this.menuBackgroundColor,
//     this.sidebarBackgroundColor,
//     //
//     // Menu start and side settings
//     this.menuStart,
//     this.menuSide,
//     //
//     // Elevation properties
//     this.menuElevation,
//     this.sidebarElevation,
//     this.drawerElevation,
//     this.endDrawerElevation,
//     //
//     // Width properties
//     this.menuWidth,
//     this.railWidth,
//     this.sidebarWidth,
//     this.drawerWidth,
//     this.endDrawerWidth,
//     //
//     // Navigation type breakpoints
//     this.breakpointDrawer,
//     this.breakpointRail,
//     this.breakpointMenu,
//     this.breakpointSidebar,
//     //
//     // Edge border properties
//     this.borderOnMenu,
//     this.borderOnSidebar,
//     this.borderOnDarkDrawer,
//     this.borderOnLightDrawer,
//     this.borderColor,
//     //
//     // Menu selection and highlight style
//     this.menuHighlightHeight,
//     this.menuHighlightMargins,
//     this.menuSelectedShape,
//     this.menuHighlightShape,
//     this.menuHighlightColor,
//     //
//     // Animation durations and curves for menu and bottom bar animations
//     this.menuAnimationDuration,
//     this.menuAnimationCurve,
//     this.sidebarAnimationDuration,
//     this.sidebarAnimationCurve,
//     this.bottomBarAnimationDuration,
//     this.bottomBarAnimationCurve,
//     //
//     // Bottom navigation bar properties
//     this.bottomNavigationBarTheme,
//     this.bottomBarType = FlexfoldBottomBarType.adaptive,
//     this.bottomBarIsTransparent = true,
//     this.bottomBarBlur = true,
//     this.bottomBarOpacity = 0.9,
//     this.bottomBarTopBorder = true,
//     //
//     // The icon and text styles of the menu and rail
//     this.iconTheme,
//     this.selectedIconTheme,
//     this.labelTextStyle,
//     this.selectedLabelTextStyle,
//     // The text style for headings above menu label items
//     this.headingTextStyle,
//     //
//     // Tooltip properties
//     this.useTooltips,
//     this.menuOpenTooltip,
//     this.menuCloseTooltip,
//     this.menuExpandTooltip,
//     this.menuExpandHiddenTooltip,
//     this.menuCollapseTooltip,
//     this.sidebarOpenTooltip,
//     this.sidebarCloseTooltip,
//     this.sidebarExpandTooltip,
//     this.sidebarExpandHiddenTooltip,
//     this.sidebarCollapseTooltip,
//   })  :
//         // We can have null value for any property, but if it is not null
//         // then some value have ranges that will be asserted in debug mode.
//         assert(menuElevation == null || menuElevation >= 0.0,
//             'menuElevation must be null or >= 0.'),
//         assert(sidebarElevation == null || sidebarElevation >= 0.0,
//             'sidebarElevation must be null or >= 0.'),
//         assert(drawerElevation == null || drawerElevation >= 0.0,
//             'drawerElevation must be null or >= 0.'),
//         assert(endDrawerElevation == null || endDrawerElevation >= 0.0,
//             'endDrawerElevation must be null or >= 0.'),
//         assert(
//             menuWidth == null ||
//                 (menuWidth >= kFlexfoldMenuWidthMin &&
//                     menuWidth <= kFlexfoldMenuWidthMax),
//             'The menuWidth must be null OR between '
//             '$kFlexfoldMenuWidthMin and $kFlexfoldMenuWidthMax.'),
//         assert(
//             railWidth == null ||
//                 (railWidth >= kFlexfoldRailWidthMin &&
//                     railWidth <= kFlexfoldRailWidthMax),
//             'The railWidth must be null OR between '
//             '$kFlexfoldRailWidthMin and $kFlexfoldRailWidthMax.'),
//         assert(
//             sidebarWidth == null ||
//                 (sidebarWidth >= kFlexfoldSidebarWidthMin &&
//                     sidebarWidth <= kFlexfoldSidebarWidthMax),
//             'The menuWidth must be null OR between '
//             '$kFlexfoldSidebarWidthMin and $kFlexfoldSidebarWidthMax.'),
//         assert(
//             drawerWidth == null ||
//                 (drawerWidth >= kFlexfoldDrawerWidthMin &&
//                     drawerWidth <= kFlexfoldDrawerWidthMax),
//             'The drawerWidth must be null OR between '
//             '$kFlexfoldDrawerWidthMin and $kFlexfoldDrawerWidthMax.'),
//         assert(
//             endDrawerWidth == null ||
//                 (endDrawerWidth >= kFlexfoldDrawerWidthMin &&
//                     endDrawerWidth <= kFlexfoldDrawerWidthMax),
//             'The endDrawerWidth must be null OR between '
//             '$kFlexfoldDrawerWidthMin and $kFlexfoldDrawerWidthMax.'),
//         assert(
//             breakpointDrawer == null ||
//                 (breakpointDrawer >= kFlexfoldBreakpointDrawerMin &&
//                     breakpointDrawer <= kFlexfoldBreakpointDrawerMax),
//             'The breakpointDrawer must be null OR between '
//             '$kFlexfoldMenuWidthMin and $kFlexfoldMenuWidthMax.'),
//         assert(
//             breakpointRail == null ||
//                 (breakpointRail >= kFlexfoldBreakpointRailMin &&
//                     breakpointRail <= kFlexfoldBreakpointRailMax),
//             'The breakpointRail must be null OR between '
//             '$kFlexfoldBreakpointDrawerMin and $kFlexfoldBreakpointRailMax.'),
//         assert(
//             breakpointMenu == null ||
//                 (breakpointMenu >= kFlexfoldBreakpointMenuMin &&
//                     breakpointMenu <= kFlexfoldBreakpointMenuMax),
//             'The breakpointMenu must be null OR between '
//             '$kFlexfoldBreakpointMenuMin and $kFlexfoldBreakpointMenuMax.'),
//         assert(
//             breakpointSidebar == null ||
//                 (breakpointSidebar >= kFlexfoldBreakpointSidebarMin &&
//                     breakpointSidebar <= kFlexfoldBreakpointSidebarMax),
//             'The breakpointSidebar must be null OR between '
//             '$kFlexfoldBreakpointSidebarMin and '
//             '$kFlexfoldBreakpointSidebarMax.'),
//         assert(
//             menuHighlightHeight == null ||
//                 (menuHighlightHeight >= kFlexfoldHighlightHeightMin &&
//                     menuHighlightHeight <= kFlexfoldHighlightHeightMax),
//             'The menuHighlightHeight must be null OR between '
//             '$kFlexfoldHighlightHeightMin and $kFlexfoldHighlightHeightMax.'),
//         assert(
//             bottomBarOpacity == null ||
//                 (bottomBarOpacity >= 0.0 && bottomBarOpacity <= 1.0),
//             'The bottomBarOpacity must be null OR between 0 and 1.');
//
//   /// Color to be used for the [FlexScaffold]'s rail, menu and drawer
//   /// background.
//   ///
//   /// The [menuBackgroundColor] value is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuBackgroundColor].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * After this the value will remain null if no value was assigned above,
//   ///   however the background color will default to
//   ///   ThemeData.colorScheme.background from the Material the menu uses.
//   final Color? menuBackgroundColor;
//
//   /// Color to be used for the [FlexScaffold] sidebar background.
//   ///
//   /// The [sidebarBackgroundColor] value is determined in the order:
//   /// * None null value passed in Flexfold.theme.[sidebarBackgroundColor].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * After this the value will remain null if no value was assigned above,
//   ///   however the background color will default to
//   ///   ThemeData.colorScheme.background from the Material the menu uses.
//   final Color? sidebarBackgroundColor;
//
//   /// Enum used to set if menu should start at top or bottom of screen.
//   ///
//   /// The [menuStart] value is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuStart].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * [menuStart] = menuStart.top, by default if null.
//   final FlexfoldMenuStart? menuStart;
//
//   /// Enum used to set if menu should be at the start or end side of the screen.
//   ///
//   /// The LTR and RTL directionality control if left or right side is the start.
//   /// The [menuSide] value is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuSide].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * [menuSide] = MenuSide.start, by default if null.
//   final FlexfoldMenuSide? menuSide;
//
//   // TODO(rydmike): This elevation does not work, why not? Works on sidebar.
//   // Figure out how to fix the elevation. Most likely it is obscured for some
//   // reason by the widget next to it. Elevation of the side menu does not look
//   // nice, so I will never use it, but would be nice to get it to work.
//   //
//   /// The z-coordinate to be used for the menu elevation.
//   ///
//   /// The [menuElevation] value is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuElevation].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * [menuElevation] = 0, by default no elevation is used.
//   final double? menuElevation;
//
//   /// The z-coordinate to be used for the sidebar's elevation.
//   ///
//   /// The [sidebarElevation] value is determined in the order:
//   /// * None null value passed in Flexfold.theme.[sidebarElevation].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * [sidebarElevation] = 0, by default no elevation is used.
//   final double? sidebarElevation;
//
//   /// The z-coordinate to be used for the menu drawer elevation.
//   ///
//   /// The [drawerElevation] value is determined in the order:
//   /// * None null value passed in Flexfold.theme.[drawerElevation].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * [drawerElevation] = 16, default for Material drawer.
//   final double? drawerElevation;
//
//   /// The z-coordinate to be used for the sidebar end drawer elevation.
//   ///
//   /// The [endDrawerElevation] value is determined in the order:
//   /// * None null value passed in Flexfold.theme.[endDrawerElevation].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * [endDrawerElevation] = 16, default for Material end drawer.
//   final double? endDrawerElevation;
//
//   /// Width of main menu, when it is visible as a fixed side menu in
//   /// [FlexScaffold].
//   ///
//   /// The [menuWidth] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuWidth].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then the default value is [kFlexfoldMenuWidth].
//   /// * The const [kFlexfoldMenuWidth] = 250dp.
//   ///
//   /// You may want to adjust the menu width if your labels do not fit. Try
//   /// to keep labels short as they also need to fit on a bottom navigation bar.
//   final double? menuWidth;
//
//   /// Width of the menu when it is used as a rail.
//   ///
//   /// The [railWidth] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[railWidth].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then the default value is [kFlexfoldRailWidth].
//   /// * The [kFlexfoldRailWidth] is set to Flutter SDK constant [kToolbarHeight]
//   ///   which is 56dp.
//   ///
//   /// There is normally no need to adjust this value. For standard icons used
//   /// in the rail, the default value is a good fit and it by default matches
//   /// the standard width of the leading widget width on the app bar.
//   final double? railWidth;
//
//   /// Width of sidebar, when it is visible as a fixed sidebar in [FlexScaffold].
//   ///
//   /// The [sidebarWidth] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[sidebarWidth].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then the default value is [kFlexfoldDrawerWidth].
//   /// * The const [kFlexfoldDrawerWidth] = 304dp, the width of standard drawer.
//   ///
//   /// You may want to adjust the menu width if your labels do not fit. Try
//   /// to keep labels short as they also need to fit on a bottom navigation bar.
//   final double? sidebarWidth;
//
//   /// Width of main menu in a drawer, when it is used as a drawer menu.
//   ///
//   /// The [drawerWidth] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[drawerWidth].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then the default value is [kFlexfoldDrawerWidth].
//   /// * The const [kFlexfoldDrawerWidth] = 304dp, the width of standard drawer.
//   final double? drawerWidth;
//
//   /// Width of the sidebar in an end drawer when it is used as an end drawer.
//   ///
//   /// The [endDrawerWidth] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[endDrawerWidth].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then the default value is [kFlexfoldDrawerWidth].
//   /// * The const [kFlexfoldDrawerWidth] = 304dp, the width of standard drawer.
//   final double? endDrawerWidth;
//
//   /// Screen height breakpoint when the menu/rail is no longer in a drawer.
//   ///
//   /// When the [breakpointDrawer] height is reached, the menu will no longer
//   /// be hidden in a drawer.
//   /// If [breakpointDrawer] height breakpoint is set to zero, the rail/menu
//   /// will never be hidden as a drawer by default. It will always become a
//   /// rail when the [breakpointRail] width breakpoint is exceeded or a menu
//   /// if the [breakpointMenu] width is exceeded.
//   ///
//   /// The [breakpointDrawer] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[breakpointDrawer].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then default value is [kFlexfoldBreakpointDrawer].
//   /// * The const [kFlexfoldBreakpointDrawer] = 550dp.
//   final double? breakpointDrawer;
//
//   /// Screen width breakpoint when rail takes over from bottom bar.
//   ///
//   /// The [breakpointRail] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[breakpointRail].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then default value is [kFlexfoldBreakpointRail].
//   /// * The const [kFlexfoldBreakpointRail] = 600dp.
//   final double? breakpointRail;
//
//   /// Screen width breakpoint when side menu takes over from rail.
//   ///
//   /// The [breakpointMenu] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[breakpointMenu].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then default value is [kFlexfoldBreakpointMenu].
//   /// * The const [kFlexfoldBreakpointMenu] = 1024dp.
//   final double? breakpointMenu;
//
//   /// Screen width breakpoint when the sidebar remains visible.
//   /// Screen width breakpoint when side menu takes over from rail.
//   ///
//   /// The [breakpointSidebar] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[breakpointSidebar].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then default value is [kFlexfoldBreakpointSidebar].
//   /// * The const [kFlexfoldBreakpointSidebar] = 1200dp.
//   final double? breakpointSidebar;
//
//   /// The menu has an edge border towards the body
//   ///
//   /// The [borderOnMenu] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[borderOnMenu].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then default value is true.
//   final bool? borderOnMenu;
//
//   /// The sidebar has an edge border towards the body.
//   ///
//   /// The [borderOnSidebar] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[borderOnSidebar].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then default value is true.
//   final bool? borderOnSidebar;
//
//   /// Draw a border on the visible side edge of a Drawer in dark mode.
//   ///
//   /// A drawer's edge might be difficult to see and look poor in dark mode.
//   /// Enabling a border on it in dark mode ensures that the edge is more
//   /// distinct looking. Defaults to true.
//   ///
//   /// The [borderOnDarkDrawer] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[borderOnDarkDrawer].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then default value is true.
//   final bool? borderOnDarkDrawer;
//
//   /// Draw a border on the visible side edge of a Drawer in light mode.
//   ///
//   /// A drawer's edge is normally fine when using a light background, there
//   /// is normally no need to draw an edge border on it, but it can be enabled.
//   /// Defaults to false.
//   ///
//   /// The [borderOnLightDrawer] is determined in the order:
//   /// * None null passed in Flexfold.theme.[borderOnLightDrawer].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then default value is false.
//   final bool? borderOnLightDrawer;
//
//   /// Color of the edge borders when used.
//   ///
//   /// Applies to all border edges used on drawers and bottom navigation bar.
//   /// If null it defaults to Theme.dividerColor.
//   ///
//   /// The [borderColor] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[borderColor].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then the default value is DividerTheme.color.
//   /// * If all above null, then the default value is Theme.dividerColor.
//   /// * If all above null, then the default value is Color(0x42888888),
//   ///   this should not happen.
//   ///
//   /// If you use FlexfoldAppBar.styled as app bar, it is recommended to use
//   /// the same color on its bottom border too, by default it does.
//   final Color? borderColor;
//
//   /// Height of the menu selection highlight indicator.
//   ///
//   /// The [menuHighlightHeight] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuHighlightHeight].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then defaults to [kFlexfoldHighlightHeight] = 50dp
//   final double? menuHighlightHeight;
//
//   /// Directional margins for the menu highlight and hover shape.
//   ///
//   /// The [menuHighlightMargins] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuHighlightMargins].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, then it defaults to
//   ///   EdgeInsetsDirectional.fromSTEB(
//   ///      kFlexfoldHighlightMarginStart = 0,
//   ///      kFlexfoldHighlightMarginTop = 2,
//   ///      kFlexfoldHighlightMarginEnd = 0,
//   ///      kFlexfoldHighlightMarginBottom = 2),
//   final EdgeInsetsDirectional? menuHighlightMargins;
//
//   /// The shape of the highlight and borders on the selected menu item.
//   ///
//   /// The [menuSelectedShape] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuSelectedShape].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, then it defaults to a rectangle without borders.
//   ///   RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0));
//   final ShapeBorder? menuSelectedShape;
//
//   /// The shape of the mouse over highlight on a menu item.
//   ///
//   /// The shape is normally the same as on the one uses on [menuSelectedShape]
//   /// but without any borders, if it has borders the borders will also be
//   /// drawn on unselected items!
//   ///
//   /// The [menuHighlightShape] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuHighlightShape].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, then it defaults to [menuSelectedShape].
//   final ShapeBorder? menuHighlightShape;
//
//   /// The highlight color of the selected menu item.
//   ///
//   /// The [menuHighlightColor] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuHighlightColor].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null it defaults to
//   ///   Theme.of(context).colorScheme.primary.withAlpha(0x3d), this is the same
//   ///   alpha blend as the default in ChipThemeData for a selected chip.
//   /// * If above fails and is null, then const Color(0x42888888).
//   final Color? menuHighlightColor;
//
//   /// Animation duration for the side menu and rail.
//   ///
//   /// The [menuAnimationDuration] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuAnimationDuration].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then
//   ///   It defaults to [kFlexfoldMenuAnimationDuration] which is set to 246ms
//   ///   that match the value for the drawer.
//   final Duration? menuAnimationDuration;
//
//   /// Animation curve for the side menu and rail.
//   ///
//   /// The [menuAnimationCurve] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuAnimationCurve].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then
//   ///   It defaults to [kFlexfoldMenuAnimationCurve] which is set to
//   ///   [Curves.easeInOut].
//   final Curve? menuAnimationCurve;
//
//   /// Animation duration for the sidebar.
//   ///
//   /// The [sidebarAnimationDuration] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[sidebarAnimationDuration].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then
//   ///   It defaults to [kFlexfoldSidebarAnimationDuration] which is set to 246ms
//   ///   that match the value for the drawer.
//   final Duration? sidebarAnimationDuration;
//
//   /// Animation curve for the sidebar.
//   ///
//   /// The [sidebarAnimationCurve] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[sidebarAnimationCurve].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then
//   ///   It defaults to [kFlexfoldSidebarAnimationCurve] which is set to
//   ///   [Curves.easeInOut].
//   final Curve? sidebarAnimationCurve;
//
//   /// Animation duration for the bottom navigation bar.
//   ///
//   /// The [bottomBarAnimationDuration] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[bottomBarAnimationDuration].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then
//   ///   It defaults to [kFlexfoldBottomAnimationDuration] which is set to 246ms
//   ///   that match the value for the drawer.
//   final Duration? bottomBarAnimationDuration;
//
//   /// Animation curve for the bottom navigation bar.
//   ///
//   /// The [bottomBarAnimationCurve] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[bottomBarAnimationCurve].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above null, then
//   ///   It defaults to [kFlexfoldBottomAnimationCurve] which is set to
//   ///   [Curves.easeInOut].
//   final Curve? bottomBarAnimationCurve;
//
//   /// A theme for customizing the appearance and layout of [BottomNavigationBar]
//   /// widget used in the [FlexScaffold] responsive scaffold.
//   ///
//   /// The effective [bottomNavigationBarTheme] and its effective property
//   /// values are determined in the order:
//   /// * None null values passed in via Flexfold.theme.bottomNavigationBarTheme.
//   /// * None null values of properties in inherited FlexfoldTheme.
//   /// * None null values of properties in inherited bottomNavigationBarTheme.
//   /// * None null values of properties in inherited
//   ///   Theme.bottomNavigationBarTheme.
//   /// * Possible applicable defaults from inherited Theme.
//   /// * Fallback default values for specific properties:
//   ///   * backgroundColor: NONE! It maybe still be NULL!
//   ///   * elevation: 0
//   ///   * type: BottomNavigationBarType.fixed
//   ///   * showSelectedLabels: true
//   ///   * showUnselectedLabels: true
//   final BottomNavigationBarThemeData? bottomNavigationBarTheme;
//
//   /// The type of bottom navigation bar to use.
//   ///
//   /// The [bottomBarType] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[bottomBarType].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If above null, then it default to [FlexfoldBottomBarType.adaptive],
//   ///   which uses a CupertinoTabBar navigation bar on iOs and MacOS and a
//   ///  BottomNavigationBar on all other platforms.
//   final FlexfoldBottomBarType? bottomBarType;
//
//   /// Toggle to turn on and off the transparency on bottom navigation bar.
//   ///
//   /// The [bottomBarIsTransparent] is determined in the order:
//   /// * None null value passed in via Flexfold.theme.[bottomBarIsTransparent].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * Defaults to true if the above are null.
//   final bool? bottomBarIsTransparent;
//
//   /// When the bottom bar has opacity, apply a blur filter if true.
//   ///
//   /// Applies the same blurring effect on a Material on bottom navigation bar
//   /// as the one used on a CupertinoTabBar when it has opacity. This flag has
//   /// no effect on CupertinoTabBar, it always uses the blurring when it has
//   /// opacity other than 1.0.
//   ///
//   /// The filter is bit expensive and is only applied when this flag is
//   /// on and there is opacity < 1 on the bottom navigation bar color. If these
//   /// conditions are not met, the filter call is not made.
//   ///
//   /// The [bottomBarBlur] setting is determined in the order:
//   /// * None null value passed in via Flexfold.theme.[bottomBarBlur].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, defaults to true.
//   final bool? bottomBarBlur;
//
//   /// The opacity value on the bottom navigation bar.
//   ///
//   /// This opacity value is only applied when [bottomBarIsTransparent] is true.
//   ///
//   /// The [bottomBarOpacity] is determined in the order:
//   /// * None null value passed in Flexfold.theme.[bottomBarOpacity].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * Default to 0.90 if above are null.
//   final double? bottomBarOpacity;
//
//   /// The bottom navigation bar has a top edge border.
//   ///
//   /// The [bottomBarTopBorder] is determined in the order:
//   /// * None null value passed in via Flexfold.theme.[bottomBarTopBorder].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If the above values are null, it defaults true.
//   ///
//   /// The color of the top border on bottom bar defaults to divider theme
//   /// color, if not otherwise defined by [borderColor].
//   final bool? bottomBarTopBorder;
//
//   /// The theme to merge with the default icon theme for
//   /// Flexfold destination icons, when the destination is not selected.
//   ///
//   /// The [iconTheme] is determined in the order:
//   /// * None null values passed in via Flexfold.theme.[iconTheme].
//   /// * None null values of the property in the inherited FlexfoldTheme.
//   /// * If above are null or any property in them are null, they default to:
//   ///   size: 24.0
//   ///   color: theme?.colorScheme?.onSurface ?? const Color(0xFF888888)
//   ///   opacity: 0.55
//   final IconThemeData? iconTheme;
//
//   /// The theme to merge with the default icon theme for
//   /// [FlexScaffold] destination icons, when the destination is selected.
//   ///
//   /// The [selectedIconTheme] is determined in the order:
//   /// * None null values passed in via Flexfold.theme.[selectedIconTheme].
//   /// * None null values of the property in the inherited FlexfoldTheme.
//   /// * If above are null or any property in them are null, they default to:
//   ///   size: 24.0
//   ///   color: theme?.colorScheme?.primary ?? const Color(0xFF2196F3)
//   ///   opacity: 1.0
//   final IconThemeData? selectedIconTheme;
//
//   /// The style to merge with the default text style for
//   /// Flexfold destination labels, when the destination is not selected.
//   ///
//   /// The [labelTextStyle] is determined in the order:
//   /// * None null passed in via Flexfold.theme.[labelTextStyle].
//   /// * None null values of the property in the inherited FlexfoldTheme.
//   /// * If the above values are null, defaults to:
//   ///   theme.of(context).textTheme.bodyText1.copyWith(color:
//   ///     theme.colorScheme.onSurface.withOpacity(0.64))
//   final TextStyle? labelTextStyle;
//
//   /// The style to merge with the default text style for
//   /// Flexfold destination labels, when the destination is selected.
//   ///
//   /// The [selectedLabelTextStyle] is determined in the order:
//   /// * None null values passed in via Flexfold.theme.[selectedLabelTextStyle].
//   /// * None null values of the property in the inherited FlexfoldTheme.
//   /// * If the above values are null, defaults to:
//   ///   theme?.primaryTextTheme?.bodyText1?.copyWith(color:
//   ///     theme?.colorScheme?.primary)
//   final TextStyle? selectedLabelTextStyle;
//
//   /// The text style for headings above menu label items.
//   ///
//   /// The style will be merged with the default text style for menu destination
//   /// headers used above menu labels. Typically there is one header for a group
//   /// of menu labels. Current version only support one shared style for all the
//   /// headings, but as you in destination can pass in any Widget, you can pass
//   /// in a Text Widget with its own style for each menu heading and use separate
//   /// style that way. If they are not styled, then shared provided here will be
//   /// used.
//   ///
//   /// The [headingTextStyle] is determined in the order:
//   /// * None null values passed in via Flexfold.theme.[headingTextStyle].
//   /// * None null values of the property in the inherited FlexfoldTheme.
//   /// * If the above values are null, defaults to:
//   ///   fontSize: 16.0
//   //    fontWeight: FontWeight.w700
//   //    color: theme?.colorScheme?.primary ?? const Color(0xFF2196F3)
//   final TextStyle? headingTextStyle;
//
//   /// Use tooltips on the Flexfold widget.
//   ///
//   /// Tooltips are nice when you are new to an app, but when you know it well
//   /// they can get annoying. If your app allows users to select when they are
//   /// tired of seeing tooltips and can turn it off, you can pass the same value
//   /// here and have [FlexScaffold] respect the same wishes.
//   ///
//   /// Tooltips exist by default on the app bar drawer/rail/menu toggle buttons
//   /// and the side bar toggle button and on icons in rail mode.
//   ///
//   /// The rail mode icon tooltips are by default using the label for the
//   /// destination, which is already shown as the label on drawer/menu and
//   /// bottom navigation  items. So this label is never shown as a tooltip in
//   /// those navigation modes.
//   ///
//   /// The [useTooltips] setting is determined in the order:
//   /// * None null value passed in Flexfold.theme.[useTooltips].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null it default to true.
//   final bool? useTooltips;
//
//   /// Tooltip label for opening the drawer menu.
//   ///
//   /// The [menuOpenTooltip] label is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuOpenTooltip].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, then it defaults to:
//   ///   MaterialLocalizations.of(context).openAppDrawerTooltip
//   final String? menuOpenTooltip;
//
//   /// Tooltip label for opening the drawer menu.
//   ///
//   /// The [menuCloseTooltip] label is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuCloseTooltip].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, then it defaults to:
//   ///   MaterialLocalizations.of(context).closeButtonTooltip
//   final String? menuCloseTooltip;
//
//   /// Tooltip label for opening the drawer menu.
//   ///
//   /// The [menuExpandTooltip] label is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuExpandTooltip].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, then it defaults to:
//   ///   MaterialLocalizations.of(context).showMenuTooltip
//   final String? menuExpandTooltip;
//
//   /// Tooltip label for opening the drawer menu.
//   ///
//   /// The [menuExpandHiddenTooltip] label is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuExpandHiddenTooltip].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, then it defaults to:
//   ///   MaterialLocalizations.of(context).showMenuTooltip
//   final String? menuExpandHiddenTooltip;
//
//   /// Tooltip label for opening the drawer menu.
//   ///
//   /// The [menuCollapseTooltip] label is determined in the order:
//   /// * None null value passed in Flexfold.theme.[menuCollapseTooltip].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, then it defaults to:
//   ///   MaterialLocalizations.of(context).expandedIconTapHint
//   final String? menuCollapseTooltip;
//
//   /// Tooltip label for opening the drawer menu.
//   ///
//   /// The [sidebarOpenTooltip] label is determined in the order:
//   /// * None null value passed in Flexfold.theme.[sidebarOpenTooltip].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, then it defaults to:
//   ///   MaterialLocalizations.of(context).openAppDrawerTooltip
//   final String? sidebarOpenTooltip;
//
//   /// Tooltip label for opening the drawer menu.
//   ///
//   /// The [sidebarCloseTooltip] label is determined in the order:
//   /// * None null value passed in Flexfold.theme.[sidebarCloseTooltip].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, then it defaults to:
//   ///   MaterialLocalizations.of(context).closeButtonTooltip
//   final String? sidebarCloseTooltip;
//
//   /// Tooltip label for opening the drawer menu.
//   ///
//   /// The [sidebarExpandTooltip] label is determined in the order:
//   /// * None null value passed in Flexfold.theme.[sidebarExpandTooltip].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, then it defaults to:
//   ///   MaterialLocalizations.of(context).showMenuTooltip
//   final String? sidebarExpandTooltip;
//
//   /// Tooltip label for opening the drawer menu.
//   ///
//   /// The [sidebarExpandHiddenTooltip] label is determined in the order:
//   /// * None null passed in Flexfold.theme.[sidebarExpandHiddenTooltip].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, then it defaults to:
//   ///   MaterialLocalizations.of(context).showMenuTooltip
//   final String? sidebarExpandHiddenTooltip;
//
//   /// Tooltip label for opening the drawer menu.
//   ///
//   /// The [sidebarCollapseTooltip] label is determined in the order:
//   /// * None null value passed in Flexfold.theme.[sidebarCollapseTooltip].
//   /// * None null value of the property in the inherited FlexfoldTheme.
//   /// * If all above are null, then it defaults to:
//   ///   MaterialLocalizations.of(context).expandedIconTapHint
//   final String? sidebarCollapseTooltip;
//
//   /// Merge the other [FlexScaffoldThemeData] with the theme data of this
//   /// instance.
//   ///
//   /// This is typically used to merge a theme data object with some overriding
//   /// properties defined with it's parent inherited theme data, creating
//   /// a resulting merged theme where the 'other' values override any inherited
//   /// data, but none defined values keeps using the inherited values.
//   FlexScaffoldThemeData merge(FlexScaffoldThemeData? other) {
//     if (other == null) {
//       return this;
//     }
//     return copyWith(
//       menuBackgroundColor: other.menuBackgroundColor,
//       sidebarBackgroundColor: other.sidebarBackgroundColor,
//       menuStart: other.menuStart,
//       menuSide: other.menuSide,
//       menuElevation: other.menuElevation,
//       sidebarElevation: other.sidebarElevation,
//       drawerElevation: other.drawerElevation,
//       endDrawerElevation: other.endDrawerElevation,
//       menuWidth: other.menuWidth,
//       railWidth: other.railWidth,
//       sidebarWidth: other.sidebarWidth,
//       drawerWidth: other.drawerWidth,
//       endDrawerWidth: other.endDrawerWidth,
//       breakpointDrawer: other.breakpointDrawer,
//       breakpointRail: other.breakpointRail,
//       breakpointMenu: other.breakpointMenu,
//       breakpointSidebar: other.breakpointSidebar,
//       borderOnMenu: other.borderOnMenu,
//       borderOnSidebar: other.borderOnSidebar,
//       borderOnDarkDrawer: other.borderOnDarkDrawer,
//       borderOnLightDrawer: other.borderOnLightDrawer,
//       borderColor: other.borderColor,
//       menuHighlightHeight: other.menuHighlightHeight,
//       menuHighlightMargins: other.menuHighlightMargins,
//       menuSelectedShape: other.menuSelectedShape,
//       menuHighlightShape: other.menuHighlightShape,
//       menuHighlightColor: other.menuHighlightColor,
//       menuAnimationDuration: other.menuAnimationDuration,
//       menuAnimationCurve: other.menuAnimationCurve,
//       sidebarAnimationDuration: other.sidebarAnimationDuration,
//       sidebarAnimationCurve: other.sidebarAnimationCurve,
//       bottomBarAnimationDuration: other.bottomBarAnimationDuration,
//       bottomBarAnimationCurve: other.bottomBarAnimationCurve,
//       bottomNavigationBarTheme: other.bottomNavigationBarTheme,
//       bottomBarType: other.bottomBarType,
//       bottomBarIsTransparent: other.bottomBarIsTransparent,
//       bottomBarBlur: other.bottomBarBlur,
//       bottomBarOpacity: other.bottomBarOpacity,
//       bottomBarTopBorder: other.bottomBarTopBorder,
//       labelTextStyle: other.labelTextStyle,
//       selectedLabelTextStyle: other.selectedLabelTextStyle,
//       iconTheme: other.iconTheme,
//       selectedIconTheme: other.selectedIconTheme,
//       headingTextStyle: other.headingTextStyle,
//       useTooltips: other.useTooltips,
//       menuOpenTooltip: other.menuOpenTooltip,
//       menuCloseTooltip: other.menuCloseTooltip,
//       menuExpandTooltip: other.menuExpandTooltip,
//       menuExpandHiddenTooltip: other.menuExpandHiddenTooltip,
//       menuCollapseTooltip: other.menuCollapseTooltip,
//       sidebarOpenTooltip: other.sidebarOpenTooltip,
//       sidebarCloseTooltip: other.sidebarCloseTooltip,
//       sidebarExpandTooltip: other.sidebarExpandTooltip,
//       sidebarExpandHiddenTooltip: other.sidebarExpandHiddenTooltip,
//       sidebarCollapseTooltip: other.sidebarCollapseTooltip,
//     );
//   }
//
//   /// Merge this instance of [FlexScaffoldThemeData] with the hard coded default
//   /// values for [FlexScaffoldThemeData] in the build context.
//   FlexScaffoldThemeData withDefaults(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final MaterialLocalizations hints = MaterialLocalizations.of(context);
//     final String openHint = hints.openAppDrawerTooltip;
//     final String closeHint = hints.closeButtonTooltip;
//     final String expandHint = hints.showMenuTooltip;
//     final String collapseHint = hints.expandedIconTapHint;
//
//     return copyWith(
//       // TODO(rydmike): Remove comments when background color has been verified!
//       // Default is null, it then gets it background color via Material.
//       // Old value was: ?? theme?.colorScheme?.background ?? Colors.white,
//       menuBackgroundColor: menuBackgroundColor,
//       // Default is null, it then gets it background color via Material.
//       // Old default was: ?? theme?.colorScheme?.background ?? Colors.white,
//       sidebarBackgroundColor: sidebarBackgroundColor,
//
//       menuStart: menuStart ?? FlexfoldMenuStart.top,
//       menuSide: menuSide ?? FlexfoldMenuSide.start,
//       menuElevation: menuElevation ?? 0,
//       sidebarElevation: sidebarElevation ?? 0,
//       drawerElevation: drawerElevation ?? 16,
//       endDrawerElevation: endDrawerElevation ?? 16,
//       menuWidth: menuWidth ?? kFlexfoldMenuWidth,
//       railWidth: railWidth ?? kFlexfoldRailWidth,
//       sidebarWidth: sidebarWidth ?? kFlexfoldSidebarWidth,
//       drawerWidth: drawerWidth ?? kFlexfoldDrawerWidth,
//       endDrawerWidth: endDrawerWidth ?? kFlexfoldDrawerWidth,
//       breakpointDrawer: breakpointDrawer ?? kFlexfoldBreakpointDrawer,
//       breakpointRail: breakpointRail ?? kFlexfoldBreakpointRail,
//       breakpointMenu: breakpointMenu ?? kFlexfoldBreakpointMenu,
//       breakpointSidebar: breakpointSidebar ?? kFlexfoldBreakpointSidebar,
//       borderOnMenu: borderOnMenu ?? true,
//       borderOnSidebar: borderOnSidebar ?? true,
//       borderOnDarkDrawer: borderOnDarkDrawer ?? true,
//       borderOnLightDrawer: borderOnLightDrawer ?? false,
//       borderColor:
//           borderColor ?? theme.dividerTheme.color ?? theme.dividerColor,
//       menuHighlightHeight: menuHighlightHeight ?? kFlexfoldHighlightHeight,
//       menuHighlightMargins: menuHighlightMargins ??
//           const EdgeInsetsDirectional.fromSTEB(
//               kFlexfoldHighlightMarginStart,
//               kFlexfoldHighlightMarginTop,
//               kFlexfoldHighlightMarginEnd,
//               kFlexfoldHighlightMarginBottom),
//       menuAnimationDuration:
//           menuAnimationDuration ?? kFlexfoldMenuAnimationDuration,
//       menuSelectedShape: menuSelectedShape ??
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//       menuHighlightShape: menuHighlightShape ??
//           menuSelectedShape ??
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//       menuHighlightColor:
//           menuHighlightColor ?? theme.colorScheme.primary.withAlpha(0x3d),
//       menuAnimationCurve: menuAnimationCurve ?? kFlexfoldMenuAnimationCurve,
//       sidebarAnimationDuration:
//           sidebarAnimationDuration ?? kFlexfoldSidebarAnimationDuration,
//       sidebarAnimationCurve:
//           sidebarAnimationCurve ?? kFlexfoldSidebarAnimationCurve,
//       bottomBarAnimationDuration:
//           bottomBarAnimationDuration ?? kFlexfoldBottomAnimationDuration,
//       bottomBarAnimationCurve:
//           bottomBarAnimationCurve ?? kFlexfoldBottomAnimationCurve,
//
//       // The default value for the bottomNavigationBarTheme is handled
//       // in the Flexfold theme merge with default values, here it just gets
//       // a theme data where all its values are null.
//       bottomNavigationBarTheme:
//           bottomNavigationBarTheme ?? const BottomNavigationBarThemeData(),
//       bottomBarType: bottomBarType ?? FlexfoldBottomBarType.adaptive,
//       bottomBarIsTransparent: bottomBarIsTransparent ?? true,
//       bottomBarBlur: bottomBarBlur ?? true,
//       bottomBarOpacity: bottomBarOpacity ?? 0.90,
//       bottomBarTopBorder: bottomBarTopBorder ?? true,
//
//       // The default unselected menu icon styles, provided values from the
//       // passed in IconThemeData are used if the theme was not null and any
//       // property in it had a none null value.
//       iconTheme: IconThemeData(
//           size: iconTheme?.size ?? 24.0,
//           color: iconTheme?.color ?? theme.colorScheme.onSurface,
//           opacity: iconTheme?.opacity ?? 0.55),
//
//       // The default selected menu icon styles, provided values from the
//       // passed in IconThemeData are used if the theme was not null and any
//       // property in it had a none null value.
//       selectedIconTheme: IconThemeData(
//           size: selectedIconTheme?.size ?? 24.0,
//           color: selectedIconTheme?.color ?? theme.colorScheme.primary,
//           opacity: selectedIconTheme?.opacity ?? 1.0),
//
//       // The default unselected label text styles with a merge of the provided
//       // style, if any style was given.
//       labelTextStyle: theme.textTheme.bodyText1!
//           .copyWith(color: theme.colorScheme.onSurface.withOpacity(0.64))
//           .merge(labelTextStyle),
//
//       // The default selected label text styles with a merge of the provided
//       // style, if any style was given.
//       selectedLabelTextStyle: theme.textTheme.bodyText1!
//           .copyWith(color: theme.colorScheme.primary)
//           .merge(selectedLabelTextStyle),
//
//       // style, if any style was given.
//       headingTextStyle: theme.textTheme.bodyText1!
//           .copyWith(
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               color: theme.colorScheme.primary)
//           .merge(headingTextStyle),
//
//       useTooltips: useTooltips ?? true,
//       menuOpenTooltip: menuOpenTooltip ?? openHint,
//       menuCloseTooltip: menuCloseTooltip ?? closeHint,
//       menuExpandTooltip: menuExpandTooltip ?? expandHint,
//       menuExpandHiddenTooltip: menuExpandHiddenTooltip ?? expandHint,
//       menuCollapseTooltip: menuCollapseTooltip ?? collapseHint,
//       sidebarOpenTooltip: sidebarOpenTooltip ?? openHint,
//       sidebarCloseTooltip: sidebarCloseTooltip ?? closeHint,
//       sidebarExpandTooltip: sidebarExpandTooltip ?? expandHint,
//       sidebarExpandHiddenTooltip: sidebarExpandHiddenTooltip ?? expandHint,
//       sidebarCollapseTooltip: sidebarCollapseTooltip ?? collapseHint,
//     );
//   }
//
//   /// Copy this object with the given fields replaced with the new values.
//   FlexScaffoldThemeData copyWith({
//     Color? menuBackgroundColor,
//     Color? sidebarBackgroundColor,
//     FlexfoldMenuStart? menuStart,
//     FlexfoldMenuSide? menuSide,
//     double? menuElevation,
//     double? sidebarElevation,
//     double? drawerElevation,
//     double? endDrawerElevation,
//     double? menuWidth,
//     double? railWidth,
//     double? sidebarWidth,
//     double? drawerWidth,
//     double? endDrawerWidth,
//     double? breakpointDrawer,
//     double? breakpointRail,
//     double? breakpointMenu,
//     double? breakpointSidebar,
//     bool? borderOnMenu,
//     bool? borderOnSidebar,
//     bool? borderOnDarkDrawer,
//     bool? borderOnLightDrawer,
//     Color? borderColor,
//     double? menuHighlightHeight,
//     EdgeInsetsDirectional? menuHighlightMargins,
//     ShapeBorder? menuSelectedShape,
//     ShapeBorder? menuHighlightShape,
//     Color? menuHighlightColor,
//     Duration? menuAnimationDuration,
//     Curve? menuAnimationCurve,
//     Duration? sidebarAnimationDuration,
//     Curve? sidebarAnimationCurve,
//     Duration? bottomBarAnimationDuration,
//     Curve? bottomBarAnimationCurve,
//     BottomNavigationBarThemeData? bottomNavigationBarTheme,
//     FlexfoldBottomBarType? bottomBarType,
//     bool? bottomBarIsTransparent,
//     bool? bottomBarBlur,
//     double? bottomBarOpacity,
//     bool? bottomBarTopBorder,
//     //
//     IconThemeData? iconTheme,
//     IconThemeData? selectedIconTheme,
//     TextStyle? labelTextStyle,
//     TextStyle? selectedLabelTextStyle,
//     TextStyle? headingTextStyle,
//     //
//     bool? useTooltips,
//     String? menuOpenTooltip,
//     String? menuCloseTooltip,
//     String? menuExpandTooltip,
//     String? menuExpandHiddenTooltip,
//     String? menuCollapseTooltip,
//     String? sidebarOpenTooltip,
//     String? sidebarCloseTooltip,
//     String? sidebarExpandTooltip,
//     String? sidebarExpandHiddenTooltip,
//     String? sidebarCollapseTooltip,
//   }) {
//     return FlexScaffoldThemeData(
//       menuBackgroundColor: menuBackgroundColor ?? this.menuBackgroundColor,
//       sidebarBackgroundColor:
//           sidebarBackgroundColor ?? this.sidebarBackgroundColor,
//       menuStart: menuStart ?? this.menuStart,
//       menuSide: menuSide ?? this.menuSide,
//       menuElevation: menuElevation ?? this.menuElevation,
//       sidebarElevation: sidebarElevation ?? this.sidebarElevation,
//       drawerElevation: drawerElevation ?? this.drawerElevation,
//       endDrawerElevation: endDrawerElevation ?? this.endDrawerElevation,
//       menuWidth: menuWidth ?? this.menuWidth,
//       railWidth: railWidth ?? this.railWidth,
//       sidebarWidth: sidebarWidth ?? this.sidebarWidth,
//       drawerWidth: drawerWidth ?? this.drawerWidth,
//       endDrawerWidth: endDrawerWidth ?? this.endDrawerWidth,
//       breakpointDrawer: breakpointDrawer ?? this.breakpointDrawer,
//       breakpointRail: breakpointRail ?? this.breakpointRail,
//       breakpointMenu: breakpointMenu ?? this.breakpointMenu,
//       breakpointSidebar: breakpointSidebar ?? this.breakpointSidebar,
//       borderOnMenu: borderOnMenu ?? this.borderOnMenu,
//       borderOnSidebar: borderOnSidebar ?? this.borderOnSidebar,
//       borderOnDarkDrawer: borderOnDarkDrawer ?? this.borderOnDarkDrawer,
//       borderOnLightDrawer: borderOnLightDrawer ?? this.borderOnLightDrawer,
//       borderColor: borderColor ?? this.borderColor,
//       menuHighlightHeight: menuHighlightHeight ?? this.menuHighlightHeight,
//       menuHighlightMargins: menuHighlightMargins ?? this.menuHighlightMargins,
//       menuSelectedShape: menuSelectedShape ?? this.menuSelectedShape,
//       menuHighlightShape: menuHighlightShape ?? this.menuHighlightShape,
//       menuHighlightColor: menuHighlightColor ?? this.menuHighlightColor,
//       menuAnimationDuration:
//           menuAnimationDuration ?? this.menuAnimationDuration,
//       menuAnimationCurve: menuAnimationCurve ?? this.menuAnimationCurve,
//       sidebarAnimationDuration:
//           sidebarAnimationDuration ?? this.sidebarAnimationDuration,
//       sidebarAnimationCurve:
//           sidebarAnimationCurve ?? this.sidebarAnimationCurve,
//       bottomBarAnimationDuration:
//           bottomBarAnimationDuration ?? this.bottomBarAnimationDuration,
//       bottomBarAnimationCurve:
//           bottomBarAnimationCurve ?? this.bottomBarAnimationCurve,
//       bottomNavigationBarTheme:
//           bottomNavigationBarTheme ?? this.bottomNavigationBarTheme,
//       bottomBarType: bottomBarType ?? this.bottomBarType,
//       bottomBarIsTransparent:
//           bottomBarIsTransparent ?? this.bottomBarIsTransparent,
//       bottomBarBlur: bottomBarBlur ?? this.bottomBarBlur,
//       bottomBarOpacity: bottomBarOpacity ?? this.bottomBarOpacity,
//       bottomBarTopBorder: bottomBarTopBorder ?? this.bottomBarTopBorder,
//       labelTextStyle: labelTextStyle ?? this.labelTextStyle,
//       selectedLabelTextStyle:
//           selectedLabelTextStyle ?? this.selectedLabelTextStyle,
//       iconTheme: iconTheme ?? this.iconTheme,
//       selectedIconTheme: selectedIconTheme ?? this.selectedIconTheme,
//       headingTextStyle: headingTextStyle ?? this.headingTextStyle,
//       useTooltips: useTooltips ?? this.useTooltips,
//       menuOpenTooltip: menuOpenTooltip ?? this.menuOpenTooltip,
//       menuCloseTooltip: menuCloseTooltip ?? this.menuCloseTooltip,
//       menuExpandTooltip: menuExpandTooltip ?? this.menuExpandTooltip,
//       menuExpandHiddenTooltip:
//           menuExpandHiddenTooltip ?? this.menuExpandHiddenTooltip,
//       menuCollapseTooltip: menuCollapseTooltip ?? this.menuCollapseTooltip,
//       sidebarOpenTooltip: sidebarOpenTooltip ?? this.sidebarOpenTooltip,
//       sidebarCloseTooltip: sidebarCloseTooltip ?? this.sidebarCloseTooltip,
//       sidebarExpandTooltip: sidebarExpandTooltip ?? this.sidebarExpandTooltip,
//       sidebarExpandHiddenTooltip:
//           sidebarExpandHiddenTooltip ?? this.sidebarExpandHiddenTooltip,
//       sidebarCollapseTooltip:
//           sidebarCollapseTooltip ?? this.sidebarCollapseTooltip,
//     );
//   }
//
//   /// Linearly interpolate between two Flexfold themes.
//   ///
//   /// If both arguments are null then null is returned.
//   // ignore: prefer_constructors_over_static_methods
//   static FlexScaffoldThemeData lerp(
//       FlexScaffoldThemeData a, FlexScaffoldThemeData b, double t) {
//     return FlexScaffoldThemeData(
//       menuBackgroundColor:
//           Color.lerp(a.menuBackgroundColor, b.menuBackgroundColor, t),
//       sidebarBackgroundColor:
//           Color.lerp(a.sidebarBackgroundColor, b.sidebarBackgroundColor, t),
//       menuStart: t < 0.5 ? a.menuStart : b.menuStart,
//       menuSide: t < 0.5 ? a.menuSide : b.menuSide,
//       menuElevation: lerpDouble(a.menuElevation, b.menuElevation, t),
//       sidebarElevation: lerpDouble(a.sidebarElevation, b.sidebarElevation, t),
//       drawerElevation: lerpDouble(a.drawerElevation, b.drawerElevation, t),
//       endDrawerElevation:
//           lerpDouble(a.endDrawerElevation, b.endDrawerElevation, t),
//       menuWidth: lerpDouble(a.menuWidth, b.menuWidth, t),
//       railWidth: lerpDouble(a.railWidth, b.railWidth, t),
//       sidebarWidth: lerpDouble(a.sidebarWidth, b.sidebarWidth, t),
//       drawerWidth: lerpDouble(a.drawerWidth, b.drawerWidth, t),
//       endDrawerWidth: lerpDouble(a.endDrawerWidth, b.endDrawerWidth, t),
//       breakpointDrawer: lerpDouble(a.breakpointDrawer, b.breakpointDrawer, t),
//       breakpointRail: lerpDouble(a.breakpointRail, b.breakpointRail, t),
//       breakpointMenu: lerpDouble(a.breakpointMenu, b.breakpointMenu, t),
//       breakpointSidebar:
//           lerpDouble(a.breakpointSidebar, b.breakpointSidebar, t),
//       borderOnMenu: t < 0.5 ? a.borderOnMenu : b.borderOnMenu,
//       borderOnSidebar: t < 0.5 ? a.borderOnSidebar : b.borderOnSidebar,
//       borderOnDarkDrawer: t < 0.5 ? a.borderOnDarkDrawer : b.borderOnDarkDrawer,
//       borderOnLightDrawer:
//           t < 0.5 ? a.borderOnLightDrawer : b.borderOnLightDrawer,
//       borderColor: Color.lerp(a.borderColor, b.borderColor, t),
//       menuHighlightHeight:
//           lerpDouble(a.menuHighlightHeight, b.menuHighlightHeight, t),
//       menuHighlightMargins: EdgeInsetsDirectional.lerp(
//           a.menuHighlightMargins, b.menuHighlightMargins, t),
//       menuSelectedShape:
//           ShapeBorder.lerp(a.menuSelectedShape, b.menuSelectedShape, t),
//       menuHighlightShape:
//           ShapeBorder.lerp(a.menuHighlightShape, b.menuHighlightShape, t),
//       menuHighlightColor:
//           Color.lerp(a.menuHighlightColor, b.menuHighlightColor, t),
//       menuAnimationDuration:
//           t < 0.5 ? a.menuAnimationDuration : b.menuAnimationDuration,
//       menuAnimationCurve: t < 0.5 ? a.menuAnimationCurve : b.menuAnimationCurve,
//       sidebarAnimationDuration:
//           t < 0.5 ? a.sidebarAnimationDuration : b.sidebarAnimationDuration,
//       sidebarAnimationCurve:
//           t < 0.5 ? a.sidebarAnimationCurve : b.sidebarAnimationCurve,
//       bottomBarAnimationDuration:
//           t < 0.5 ? a.bottomBarAnimationDuration : b.bottomBarAnimationDuration,
//       bottomBarAnimationCurve:
//           t < 0.5 ? a.bottomBarAnimationCurve : b.bottomBarAnimationCurve,
//       bottomNavigationBarTheme: BottomNavigationBarThemeData.lerp(
//           a.bottomNavigationBarTheme, b.bottomNavigationBarTheme, t),
//       bottomBarType: t < 0.5 ? a.bottomBarType : b.bottomBarType,
//       bottomBarIsTransparent:
//           t < 0.5 ? a.bottomBarIsTransparent : b.bottomBarIsTransparent,
//       bottomBarBlur: t < 0.5 ? a.bottomBarBlur : b.bottomBarBlur,
//       bottomBarOpacity: lerpDouble(a.bottomBarOpacity, b.bottomBarOpacity, t),
//       bottomBarTopBorder: t < 0.5 ? a.bottomBarTopBorder : b.bottomBarTopBorder,
//       //
//       iconTheme: IconThemeData.lerp(a.iconTheme, b.iconTheme, t),
//       selectedIconTheme:
//           IconThemeData.lerp(a.selectedIconTheme, b.selectedIconTheme, t),
//       labelTextStyle: TextStyle.lerp(a.labelTextStyle, b.labelTextStyle, t),
//       selectedLabelTextStyle:
//           TextStyle.lerp(a.selectedLabelTextStyle, b.selectedLabelTextStyle, t),
//       headingTextStyle:
//           TextStyle.lerp(a.headingTextStyle, b.headingTextStyle, t),
//       //
//       useTooltips: t < 0.5 ? a.useTooltips : b.useTooltips,
//       menuOpenTooltip: t < 0.5 ? a.menuOpenTooltip : b.menuOpenTooltip,
//       menuCloseTooltip: t < 0.5 ? a.menuCloseTooltip : b.menuCloseTooltip,
//       menuExpandTooltip: t < 0.5 ? a.menuExpandTooltip : b.menuExpandTooltip,
//       menuExpandHiddenTooltip:
//           t < 0.5 ? a.menuExpandHiddenTooltip : b.menuExpandHiddenTooltip,
//       menuCollapseTooltip:
//           t < 0.5 ? a.menuCollapseTooltip : b.menuCollapseTooltip,
//       sidebarOpenTooltip: t < 0.5 ? a.sidebarOpenTooltip : b.sidebarOpenTooltip,
//       sidebarCloseTooltip:
//           t < 0.5 ? a.sidebarCloseTooltip : b.sidebarCloseTooltip,
//       sidebarExpandTooltip:
//           t < 0.5 ? a.sidebarExpandTooltip : b.sidebarExpandTooltip,
//       sidebarExpandHiddenTooltip:
//           t < 0.5 ? a.sidebarExpandHiddenTooltip : b.sidebarExpandHiddenTooltip,
//       sidebarCollapseTooltip:
//           t < 0.5 ? a.sidebarCollapseTooltip : b.sidebarCollapseTooltip,
//     );
//   }
//
//   @override
//   int get hashCode => Object.hashAll(<Object?>[
//         menuBackgroundColor,
//         sidebarBackgroundColor,
//         menuStart,
//         menuSide,
//         menuElevation,
//         sidebarElevation,
//         drawerElevation,
//         endDrawerElevation,
//         menuWidth,
//         railWidth,
//         sidebarWidth,
//         drawerWidth,
//         endDrawerWidth,
//         breakpointDrawer,
//         breakpointRail,
//         breakpointMenu,
//         breakpointSidebar,
//         borderOnMenu,
//         borderOnSidebar,
//         borderOnDarkDrawer,
//         borderOnLightDrawer,
//         borderColor,
//         menuHighlightHeight,
//         menuHighlightMargins,
//         menuSelectedShape,
//         menuHighlightShape,
//         menuHighlightColor,
//         menuAnimationDuration,
//         menuAnimationCurve,
//         sidebarAnimationDuration,
//         sidebarAnimationCurve,
//         bottomBarAnimationDuration,
//         bottomBarAnimationCurve,
//         bottomNavigationBarTheme,
//         bottomBarType,
//         bottomBarIsTransparent,
//         bottomBarBlur,
//         bottomBarOpacity,
//         bottomBarTopBorder,
//         //
//         iconTheme,
//         selectedIconTheme,
//         labelTextStyle,
//         selectedLabelTextStyle,
//         headingTextStyle,
//         //
//         useTooltips,
//         menuOpenTooltip,
//         menuCloseTooltip,
//         menuExpandTooltip,
//         menuExpandHiddenTooltip,
//         menuCollapseTooltip,
//         sidebarOpenTooltip,
//         sidebarCloseTooltip,
//         sidebarExpandTooltip,
//         sidebarExpandHiddenTooltip,
//         sidebarCollapseTooltip,
//       ]);
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     if (other.runtimeType != runtimeType) return false;
//     return other is FlexScaffoldThemeData &&
//         other.menuBackgroundColor == menuBackgroundColor &&
//         other.sidebarBackgroundColor == sidebarBackgroundColor &&
//         other.menuStart == menuStart &&
//         other.menuSide == menuSide &&
//         other.menuElevation == menuElevation &&
//         other.sidebarElevation == sidebarElevation &&
//         other.drawerElevation == drawerElevation &&
//         other.endDrawerElevation == endDrawerElevation &&
//         other.menuWidth == menuWidth &&
//         other.railWidth == railWidth &&
//         other.sidebarWidth == sidebarWidth &&
//         other.drawerWidth == drawerWidth &&
//         other.endDrawerWidth == endDrawerWidth &&
//         other.breakpointDrawer == breakpointDrawer &&
//         other.breakpointRail == breakpointRail &&
//         other.breakpointMenu == breakpointMenu &&
//         other.breakpointSidebar == breakpointSidebar &&
//         other.borderOnMenu == borderOnMenu &&
//         other.borderOnSidebar == borderOnSidebar &&
//         other.borderOnDarkDrawer == borderOnDarkDrawer &&
//         other.borderOnLightDrawer == borderOnLightDrawer &&
//         other.borderColor == borderColor &&
//         other.menuHighlightHeight == menuHighlightHeight &&
//         other.menuHighlightMargins == menuHighlightMargins &&
//         other.menuSelectedShape == menuSelectedShape &&
//         other.menuHighlightShape == menuHighlightShape &&
//         other.menuHighlightColor == menuHighlightColor &&
//         other.menuAnimationDuration == menuAnimationDuration &&
//         other.menuAnimationCurve == menuAnimationCurve &&
//         other.sidebarAnimationDuration == sidebarAnimationDuration &&
//         other.sidebarAnimationCurve == sidebarAnimationCurve &&
//         other.bottomBarAnimationDuration == bottomBarAnimationDuration &&
//         other.bottomBarAnimationCurve == bottomBarAnimationCurve &&
//         other.bottomNavigationBarTheme == bottomNavigationBarTheme &&
//         other.bottomBarType == bottomBarType &&
//         other.bottomBarIsTransparent == bottomBarIsTransparent &&
//         other.bottomBarBlur == bottomBarBlur &&
//         other.bottomBarOpacity == bottomBarOpacity &&
//         other.bottomBarTopBorder == bottomBarTopBorder &&
//         //
//         other.iconTheme == iconTheme &&
//         other.selectedIconTheme == selectedIconTheme &&
//         other.labelTextStyle == labelTextStyle &&
//         other.selectedLabelTextStyle == selectedLabelTextStyle &&
//         other.headingTextStyle == headingTextStyle &&
//         //
//         other.useTooltips == useTooltips &&
//         other.menuOpenTooltip == menuOpenTooltip &&
//         other.menuCloseTooltip == menuCloseTooltip &&
//         other.menuExpandTooltip == menuExpandTooltip &&
//         other.menuExpandHiddenTooltip == menuExpandHiddenTooltip &&
//         other.menuCollapseTooltip == menuCollapseTooltip &&
//         other.sidebarOpenTooltip == sidebarOpenTooltip &&
//         other.sidebarCloseTooltip == sidebarCloseTooltip &&
//         other.sidebarExpandTooltip == sidebarExpandTooltip &&
//         other.sidebarExpandHiddenTooltip == sidebarExpandHiddenTooltip &&
//         other.sidebarCollapseTooltip == sidebarCollapseTooltip;
//   }
//
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     const FlexScaffoldThemeData defaultData = FlexScaffoldThemeData();
//
//     properties.add(ColorProperty('menuBackgroundColor', menuBackgroundColor,
//         defaultValue: defaultData.menuBackgroundColor,
//         level: DiagnosticLevel.debug));
//     properties.add(ColorProperty(
//         'sidebarBackgroundColor', sidebarBackgroundColor,
//         defaultValue: defaultData.sidebarBackgroundColor,
//         level: DiagnosticLevel.debug));
//
//     properties.add(DiagnosticsProperty<FlexfoldMenuStart>(
//         'menuStart', menuStart,
//         defaultValue: defaultData.menuStart, level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<FlexfoldMenuSide>('menuSide', menuSide,
//         defaultValue: defaultData.menuSide, level: DiagnosticLevel.debug));
//
//     properties.add(DoubleProperty('menuElevation', menuElevation,
//         defaultValue: defaultData.menuElevation, level: DiagnosticLevel.debug));
//     properties.add(DoubleProperty('sidebarElevation', sidebarElevation,
//         defaultValue: defaultData.sidebarElevation,
//         level: DiagnosticLevel.debug));
//     properties.add(DoubleProperty('drawerElevation', drawerElevation,
//         defaultValue: defaultData.drawerElevation,
//         level: DiagnosticLevel.debug));
//     properties.add(DoubleProperty('endDrawerElevation', endDrawerElevation,
//         defaultValue: defaultData.endDrawerElevation,
//         level: DiagnosticLevel.debug));
//
//     properties.add(DoubleProperty('menuWidth', menuWidth,
//         defaultValue: defaultData.menuWidth, level: DiagnosticLevel.debug));
//     properties.add(DoubleProperty('railWidth', railWidth,
//         defaultValue: defaultData.railWidth, level: DiagnosticLevel.debug));
//     properties.add(DoubleProperty('sidebarWidth', sidebarWidth,
//         defaultValue: defaultData.sidebarWidth, level: DiagnosticLevel.debug));
//     properties.add(DoubleProperty('drawerWidth', drawerWidth,
//         defaultValue: defaultData.drawerWidth, level: DiagnosticLevel.debug));
//     properties.add(DoubleProperty('endDrawerWidth', endDrawerWidth,
//         defaultValue: defaultData.endDrawerWidth,
//         level: DiagnosticLevel.debug));
//
//     properties.add(DoubleProperty('breakpointDrawer', breakpointDrawer,
//         defaultValue: defaultData.breakpointDrawer,
//         level: DiagnosticLevel.debug));
//     properties.add(DoubleProperty('breakpointRail', breakpointRail,
//         defaultValue: defaultData.breakpointRail,
//         level: DiagnosticLevel.debug));
//     properties.add(DoubleProperty('breakpointMenu', breakpointMenu,
//         defaultValue: defaultData.breakpointMenu,
//         level: DiagnosticLevel.debug));
//     properties.add(DoubleProperty('breakpointSidebar', breakpointSidebar,
//         defaultValue: defaultData.breakpointSidebar,
//         level: DiagnosticLevel.debug));
//
//     properties.add(DiagnosticsProperty<bool>('borderOnMenu', borderOnMenu,
//         defaultValue: defaultData.borderOnMenu, level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<bool>('borderOnSidebar', borderOnSidebar,
//         defaultValue: defaultData.borderOnSidebar,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<bool>(
//         'borderOnDrawerEdgeInDarkMode', borderOnDarkDrawer,
//         defaultValue: defaultData.borderOnDarkDrawer,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<bool>(
//         'borderOnDrawerEdgeInLightMode', borderOnLightDrawer,
//         defaultValue: defaultData.borderOnLightDrawer,
//         level: DiagnosticLevel.debug));
//     properties.add(ColorProperty('borderColor', borderColor,
//         defaultValue: defaultData.borderColor, level: DiagnosticLevel.debug));
//
//     properties.add(DoubleProperty('menuHighlightHeight', menuHighlightHeight,
//         defaultValue: defaultData.menuHighlightHeight,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<EdgeInsetsDirectional>(
//         'menuHighlightMargins', menuHighlightMargins,
//         defaultValue: defaultData.menuHighlightMargins,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<ShapeBorder>(
//         'menuSelectedShape', menuSelectedShape,
//         defaultValue: defaultData.menuSelectedShape,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<ShapeBorder>(
//         'menuHighlightShape', menuHighlightShape,
//         defaultValue: defaultData.menuHighlightShape,
//         level: DiagnosticLevel.debug));
//     properties.add(ColorProperty('menuHighlightColor', menuHighlightColor,
//         defaultValue: defaultData.menuHighlightColor,
//         level: DiagnosticLevel.debug));
//
//     properties.add(DiagnosticsProperty<Duration>(
//         'menuAnimationDuration', menuAnimationDuration,
//         defaultValue: defaultData.menuAnimationDuration,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<Curve>(
//         'menuAnimationCurve', menuAnimationCurve,
//         defaultValue: defaultData.menuAnimationCurve,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<Duration>(
//         'sidebarAnimationDuration', sidebarAnimationDuration,
//         defaultValue: defaultData.sidebarAnimationDuration,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<Curve>(
//         'sidebarAnimationCurve', sidebarAnimationCurve,
//         defaultValue: defaultData.sidebarAnimationCurve,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<Duration>(
//         'bottomBarAnimationDuration', bottomBarAnimationDuration,
//         defaultValue: defaultData.bottomBarAnimationDuration,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<Curve>(
//         'bottomBarAnimationCurve', bottomBarAnimationCurve,
//         defaultValue: defaultData.bottomBarAnimationCurve,
//         level: DiagnosticLevel.debug));
//
//     properties.add(DiagnosticsProperty<BottomNavigationBarThemeData>(
//         'bottomNavigationBarTheme', bottomNavigationBarTheme,
//         defaultValue: defaultData.bottomNavigationBarTheme,
//         level: DiagnosticLevel.debug));
//     properties.add(EnumProperty<FlexfoldBottomBarType>(
//         'bottomBarType', bottomBarType,
//         defaultValue: defaultData.bottomBarType, level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<bool>(
//         'bottomBarIsTransparent', bottomBarIsTransparent,
//         defaultValue: defaultData.bottomBarIsTransparent,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<bool>('bottomBarBlur', bottomBarBlur,
//         defaultValue: defaultData.bottomBarBlur, level: DiagnosticLevel.debug));
//     properties.add(DoubleProperty('bottomBarOpacity', bottomBarOpacity,
//         defaultValue: defaultData.bottomBarOpacity,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<bool>(
//         'bottomBarHasTopBorder', bottomBarTopBorder,
//         defaultValue: defaultData.bottomBarTopBorder,
//         level: DiagnosticLevel.debug));
//
//     properties.add(DiagnosticsProperty<IconThemeData>(
//         'unselectedIconTheme', iconTheme,
//         defaultValue: defaultData.iconTheme, level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<IconThemeData>(
//         'selectedIconTheme', selectedIconTheme,
//         defaultValue: defaultData.selectedIconTheme,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<TextStyle>(
//         'unselectedLabelTextStyle', labelTextStyle,
//         defaultValue: defaultData.labelTextStyle,
//         level: DiagnosticLevel.debug));
//     properties.add(DiagnosticsProperty<TextStyle>(
//         'selectedLabelTextStyle', selectedLabelTextStyle,
//         defaultValue: defaultData.selectedLabelTextStyle,
//         level: DiagnosticLevel.debug));
//
//     properties.add(DiagnosticsProperty<TextStyle>(
//         'headingTextStyle', headingTextStyle,
//         defaultValue: defaultData.headingTextStyle,
//         level: DiagnosticLevel.debug));
//
//     properties.add(DiagnosticsProperty<bool>('useTooltips', useTooltips,
//         defaultValue: defaultData.useTooltips, level: DiagnosticLevel.debug));
//     properties.add(StringProperty('menuOpenTooltipLabel', menuOpenTooltip,
//         defaultValue: defaultData.menuOpenTooltip,
//         level: DiagnosticLevel.debug));
//     properties.add(StringProperty('menuCloseTooltipLabel', menuCloseTooltip,
//         defaultValue: defaultData.menuCloseTooltip,
//         level: DiagnosticLevel.debug));
//     properties.add(StringProperty('menuExpandTooltipLabel', menuExpandTooltip,
//         defaultValue: defaultData.menuExpandTooltip,
//         level: DiagnosticLevel.debug));
//     properties.add(StringProperty(
//         'menuExpandHiddenTooltipLabel', menuExpandHiddenTooltip,
//         defaultValue: defaultData.menuExpandHiddenTooltip,
//         level: DiagnosticLevel.debug));
//     properties.add(StringProperty(
//         'menuCollapseTooltipLabel', menuCollapseTooltip,
//         defaultValue: defaultData.menuCollapseTooltip,
//         level: DiagnosticLevel.debug));
//     properties.add(StringProperty('sidebarOpenTooltipLabel', sidebarOpenTooltip,
//         defaultValue: defaultData.sidebarOpenTooltip,
//         level: DiagnosticLevel.debug));
//     properties.add(StringProperty(
//         'sidebarCloseTooltipLabel', sidebarCloseTooltip,
//         defaultValue: defaultData.sidebarCloseTooltip,
//         level: DiagnosticLevel.debug));
//     properties.add(StringProperty(
//         'sidebarExpandTooltipLabel', sidebarExpandTooltip,
//         defaultValue: defaultData.sidebarExpandTooltip,
//         level: DiagnosticLevel.debug));
//     properties.add(StringProperty(
//         'sidebarExpandHiddenTooltipLabel', sidebarExpandHiddenTooltip,
//         defaultValue: defaultData.sidebarExpandHiddenTooltip,
//         level: DiagnosticLevel.debug));
//     properties.add(StringProperty(
//         'sidebarCollapseTooltipLabel', sidebarCollapseTooltip,
//         defaultValue: defaultData.sidebarCollapseTooltip,
//         level: DiagnosticLevel.debug));
//   }
// }
//
// /// An inherited widget that defines visual properties for [FlexScaffold] and
// /// Flexfold destinations in this widget's subtree.
// ///
// /// Values specified here are used for [FlexScaffold] properties that are not
// /// given an explicit non-null value.
// class FlexScaffoldTheme extends InheritedTheme {
//   /// Creates a flexfold theme that controls the
//   /// [FlexScaffoldThemeData] properties for a [FlexScaffold] scaffold.
//   ///
//   /// The data argument must not be null.
//   const FlexScaffoldTheme({
//     super.key,
//     required this.data,
//     required super.child,
//   });
//
//   /// Specifies visual style, layout and some functional properties for
//   /// for descendant [FlexScaffold] widgets.
//   final FlexScaffoldThemeData data;
//
//   /// The closest instance of this class that encloses the given context.
//   ///
//   /// If there is no enclosing [FlexScaffoldTheme] widget, then a default
//   /// FlexfoldThemeData() object will be created and returned, resulting in
//   /// all null values that will result in [FlexScaffold] determining its own
//   /// default values, some of which depend on [Theme] and some on Material
//   /// standards and guidelines.
//   ///
//   /// See the individual [FlexScaffoldThemeData] properties for details.
//   ///
//   /// Typical usage is as follows:
//   ///
//   /// ```dart
//   /// FlexfoldThemeData theme = FlexfoldTheme.of(context);
//   /// ```
//   /// The above theme data, will never be null, but the data values in it will
//   /// be null if not defined in any inherited widget.
//   static FlexScaffoldThemeData of(BuildContext context) {
//     final FlexScaffoldTheme? flexfoldTheme =
//         context.dependOnInheritedWidgetOfExactType<FlexScaffoldTheme>();
//     return flexfoldTheme?.data ?? const FlexScaffoldThemeData();
//   }
//
//   @override
//   Widget wrap(BuildContext context, Widget child) {
//     final FlexScaffoldTheme? ancestorTheme =
//         context.findAncestorWidgetOfExactType<FlexScaffoldTheme>();
//     return identical(this, ancestorTheme)
//         ? child
//         : FlexScaffoldTheme(data: data, child: child);
//   }
//
//   @override
//   bool updateShouldNotify(FlexScaffoldTheme oldWidget) =>
//       data != oldWidget.data;
// }
//
// /// An interpolation between two [FlexScaffoldThemeData]s.
// ///
// /// This class specializes the interpolation of [Tween<FlexfoldThemeData>]
// /// to call the [FlexScaffoldThemeData.lerp] method.
// ///
// /// See [Tween] for a discussion on how to use interpolation objects.
// class FlexScaffoldThemeDataTween extends Tween<FlexScaffoldThemeData> {
//   /// Creates a [FlexScaffoldThemeData] tween.
//   ///
//   /// The [begin] and [end] properties must be non-null before the tween is
//   /// first used, but the arguments can be null if the values are going to be
//   /// filled in later.
//   FlexScaffoldThemeDataTween({super.begin, super.end});
//
//   @override
//   FlexScaffoldThemeData lerp(double t) =>
//       FlexScaffoldThemeData.lerp(begin!, end!, t);
// }
//
// /// Animated version of [FlexScaffoldTheme] which automatically transitions the
// /// colors, etc, over a given duration whenever the given theme changes.
// ///
// /// See also:
// ///
// ///  * [FlexScaffoldTheme], which [AnimatedFlexfoldTheme] uses to actually apply
// ///    the interpolated theme.
// class AnimatedFlexfoldTheme extends ImplicitlyAnimatedWidget {
//   /// Creates an animated Flexfold theme.
//   ///
//   /// By default, the theme transition uses a linear curve. The [data] and
//   /// [child] arguments must not be null.
//   const AnimatedFlexfoldTheme({
//     super.key,
//     required this.data,
//     super.curve,
//     super.duration = kThemeAnimationDuration,
//     super.onEnd,
//     required this.child,
//   });
//
//   /// Specifies the theme for descendant widgets.
//   final FlexScaffoldThemeData data;
//
//   /// The widget below this widget in the tree.
//   ///
//   /// {@macro flutter.widgets.child}
//   final Widget child;
//
//   @override
//   ImplicitlyAnimatedWidgetState<AnimatedFlexfoldTheme> createState() =>
//       _AnimatedFlexfoldThemeState();
// }
//
// class _AnimatedFlexfoldThemeState
//     extends AnimatedWidgetBaseState<AnimatedFlexfoldTheme> {
//   FlexScaffoldThemeDataTween? _data;
//
//   @override
//   void forEachTween(TweenVisitor<dynamic> visitor) {
//     _data = visitor(
//             _data,
//             widget.data,
//             (dynamic value) => FlexScaffoldThemeDataTween(
//                 begin: value as FlexScaffoldThemeData))!
//         as FlexScaffoldThemeDataTween;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FlexScaffoldTheme(
//       data: _data!.evaluate(animation),
//       child: widget.child,
//     );
//   }
//
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder description) {
//     super.debugFillProperties(description);
//     description.add(DiagnosticsProperty<FlexScaffoldThemeDataTween>(
//         'data', _data,
//         showName: false, defaultValue: null));
//   }
// }
