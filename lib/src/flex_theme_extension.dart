import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'flex_scaffold.dart';
import 'flex_scaffold_constants.dart';

/// Defines default property values for descendant [FlexScaffold] widgets.
///
/// To use this theme you need to insert it into the application [ThemeData] as
/// an extension:
///
/// ```dart
///  theme: ThemeData(
///    extensions: <ThemeExtension<dynamic>>{
///      // Customize properties as needed.
///      FlexTheme(),
///    },
///  ),
/// ```
///
/// Descendant widgets can then obtain the current [FlexTheme] object
/// using:
///
/// ```dart
/// final FlexTheme flexTheme = `Theme.of(context).extension<FlexTheme>();
/// ```
/// [FlexTheme] can be customized with [FlexTheme.copyWith].
///
/// All [FlexTheme] properties are `null` by default.
///
/// When null, the [FlexScaffold] will provide its own defaults based on the
/// overall [Theme]'s [ColorScheme], [DividerTheme], [BottomNavigationBarTheme],
/// [NavigationBarTheme], [NavigationRailTheme] and [IconTheme] as well as its
/// own defaults if they exist, if not it will be based on base
/// [Theme] property values like textTheme, colorScheme, dividerColor as
/// well as Flexfold constant values or SDK constants and values matching the
/// material standards and guidelines.
///
/// See the individual [FlexTheme] properties for default value details.
@immutable
class FlexTheme extends ThemeExtension<FlexTheme> with Diagnosticable {
  /// Creates a theme that can be used to customize the [FlexScaffold] look
  /// and behavior.
  const FlexTheme({
    //
    // Sub-theme priority selections
    this.bottomNavigationBarPreferSubTheme,
    this.navigationBarPreferSubTheme,
    this.railPreferSubTheme,
    //
    // Background color properties
    this.menuBackgroundColor,
    this.sidebarBackgroundColor,
    this.bottomBackgroundColor,
    //
    // Menu start and side settings
    this.menuStart,
    this.menuSide,
    //
    // Elevation properties
    this.menuElevation,
    this.sidebarElevation,
    this.drawerElevation,
    this.endDrawerElevation,
    this.bottomElevation,
    //
    // Width properties
    this.menuWidth,
    this.railWidth,
    this.sidebarWidth,
    this.drawerWidth,
    this.endDrawerWidth,
    //
    // Navigation type breakpoints
    this.breakpointDrawer,
    this.breakpointRail,
    this.breakpointMenu,
    this.breakpointSidebar,
    //
    // Edge border properties
    this.borderOnMenu,
    this.borderOnSidebar,
    this.borderOnDarkDrawer,
    this.borderOnLightDrawer,
    this.borderColor,
    //
    // Menu selection and highlight style
    this.menuHighlightHeight,
    this.menuHighlightMargins,
    this.menuSelectedShape,
    this.menuHighlightShape,
    this.menuHighlightColor,
    //
    // Animation durations and curves for menus and bottom bar animations
    this.menuAnimationDuration,
    this.menuAnimationCurve,
    this.sidebarAnimationDuration,
    this.sidebarAnimationCurve,
    this.bottomBarAnimationDuration,
    this.bottomBarAnimationCurve,
    //
    // Bottom navigation bar properties
    this.bottomType,
    this.bottomIsTransparent,
    this.bottomBlur,
    this.bottomOpacity,
    this.bottomTopBorder,
    //
    // The icon and text styles of the menu, rail and bottom bar.
    this.iconTheme,
    this.selectedIconTheme,
    this.labelTextStyle,
    this.selectedLabelTextStyle,
    // The text style for headings above menu label items
    this.headingTextStyle,
    //
    // Tooltip properties
    this.useTooltips,
    this.menuOpenTooltip,
    this.menuCloseTooltip,
    this.menuExpandTooltip,
    this.menuExpandHiddenTooltip,
    this.menuCollapseTooltip,
    this.sidebarOpenTooltip,
    this.sidebarCloseTooltip,
    this.sidebarExpandTooltip,
    this.sidebarExpandHiddenTooltip,
    this.sidebarCollapseTooltip,
  })  :
        // We can have null value for any property, but if it is not null
        // then some value have ranges that will be asserted in debug mode.
        assert(menuElevation == null || menuElevation >= 0.0,
            'menuElevation must be null or >= 0.'),
        assert(sidebarElevation == null || sidebarElevation >= 0.0,
            'sidebarElevation must be null or >= 0.'),
        assert(drawerElevation == null || drawerElevation >= 0.0,
            'drawerElevation must be null or >= 0.'),
        assert(endDrawerElevation == null || endDrawerElevation >= 0.0,
            'endDrawerElevation must be null or >= 0.'),
        assert(bottomElevation == null || bottomElevation >= 0.0,
            'bottomElevation must be null or >= 0.'),
        assert(
            menuWidth == null ||
                (menuWidth >= kFlexfoldMenuWidthMin &&
                    menuWidth <= kFlexfoldMenuWidthMax),
            'The menuWidth must be null OR between '
            '$kFlexfoldMenuWidthMin and $kFlexfoldMenuWidthMax.'),
        assert(
            railWidth == null ||
                (railWidth >= kFlexfoldRailWidthMin &&
                    railWidth <= kFlexfoldRailWidthMax),
            'The railWidth must be null OR between '
            '$kFlexfoldRailWidthMin and $kFlexfoldRailWidthMax.'),
        assert(
            sidebarWidth == null ||
                (sidebarWidth >= kFlexfoldSidebarWidthMin &&
                    sidebarWidth <= kFlexfoldSidebarWidthMax),
            'The menuWidth must be null OR between '
            '$kFlexfoldSidebarWidthMin and $kFlexfoldSidebarWidthMax.'),
        assert(
            drawerWidth == null ||
                (drawerWidth >= kFlexfoldDrawerWidthMin &&
                    drawerWidth <= kFlexfoldDrawerWidthMax),
            'The drawerWidth must be null OR between '
            '$kFlexfoldDrawerWidthMin and $kFlexfoldDrawerWidthMax.'),
        assert(
            endDrawerWidth == null ||
                (endDrawerWidth >= kFlexfoldDrawerWidthMin &&
                    endDrawerWidth <= kFlexfoldDrawerWidthMax),
            'The endDrawerWidth must be null OR between '
            '$kFlexfoldDrawerWidthMin and $kFlexfoldDrawerWidthMax.'),
        assert(
            breakpointDrawer == null ||
                (breakpointDrawer >= kFlexfoldBreakpointDrawerMin &&
                    breakpointDrawer <= kFlexfoldBreakpointDrawerMax),
            'The breakpointDrawer must be null OR between '
            '$kFlexfoldMenuWidthMin and $kFlexfoldMenuWidthMax.'),
        assert(
            breakpointRail == null ||
                (breakpointRail >= kFlexfoldBreakpointRailMin &&
                    breakpointRail <= kFlexfoldBreakpointRailMax),
            'The breakpointRail must be null OR between '
            '$kFlexfoldBreakpointDrawerMin and $kFlexfoldBreakpointRailMax.'),
        assert(
            breakpointMenu == null ||
                (breakpointMenu >= kFlexfoldBreakpointMenuMin &&
                    breakpointMenu <= kFlexfoldBreakpointMenuMax),
            'The breakpointMenu must be null OR between '
            '$kFlexfoldBreakpointMenuMin and $kFlexfoldBreakpointMenuMax.'),
        assert(
            breakpointSidebar == null ||
                (breakpointSidebar >= kFlexfoldBreakpointSidebarMin &&
                    breakpointSidebar <= kFlexfoldBreakpointSidebarMax),
            'The breakpointSidebar must be null OR between '
            '$kFlexfoldBreakpointSidebarMin and '
            '$kFlexfoldBreakpointSidebarMax.'),
        assert(
            menuHighlightHeight == null ||
                (menuHighlightHeight >= kFlexfoldHighlightHeightMin &&
                    menuHighlightHeight <= kFlexfoldHighlightHeightMax),
            'The menuHighlightHeight must be null OR between '
            '$kFlexfoldHighlightHeightMin and $kFlexfoldHighlightHeightMax.'),
        assert(
            bottomOpacity == null ||
                (bottomOpacity >= 0.0 && bottomOpacity <= 1.0),
            'The bottomBarOpacity must be null OR between 0 and 1.');

  /// Set to true to let [BottomNavigationBarTheme] properties that are defined
  /// have priority over [FlexTheme] settings.
  ///
  /// If set to false [BottomNavigationBarTheme] properties will use [FlexTheme]
  /// properties like [iconTheme], [selectedIconTheme], [labelTextStyle] and
  /// [selectedLabelTextStyle] as well as highlight styles when they are defined
  /// with higher priority than in [ThemeData] defined
  /// [BottomNavigationBarTheme] properties.
  ///
  /// Keeping it false, gives you consistent style across the [FlexScaffold] by
  /// just defining its theme and style. Properties in
  /// [BottomNavigationBarTheme] that don't have a counterpart in [FlexTheme]
  /// still come into effect from [BottomNavigationBarTheme] when defined, even
  /// if this value is false.
  ///
  /// Setting this value to true, enables different style for the side
  /// navigation and the bottom navigation.
  ///
  /// This setting only has any impact when [BottomNavigationBar] is used as
  /// bottom navigation.
  ///
  /// Defaults to false.
  final bool? bottomNavigationBarPreferSubTheme;

  /// Set to true to let [NavigationBarTheme] properties that are defined have
  /// priority over [FlexTheme] settings.
  ///
  /// If set to false [NavigationBarTheme] properties will use [FlexTheme]
  /// properties like [iconTheme], [selectedIconTheme], [labelTextStyle] and
  /// [selectedLabelTextStyle] as well as highlight styles when they are defined
  /// with higher priority than in [ThemeData] defined [NavigationBarTheme]
  /// properties.
  ///
  /// Keeping it false, gives you consistent style across the [FlexScaffold] by
  /// just defining its theme and style. Properties in [NavigationBarTheme]
  /// that don't have a counterpart in [FlexTheme] still come into effect from
  /// [NavigationBarTheme] when defined, even if this value is false.
  ///
  /// Setting this value to true, enables different style for the side
  /// navigation and the bottom navigation.
  ///
  /// This setting only has any impact when [NavigationBar] is used as
  /// bottom navigation.
  ///
  /// Defaults to false.
  final bool? navigationBarPreferSubTheme;

  /// Set to true to let [NavigationRailTheme] properties that are defined have
  /// priority over [FlexTheme] settings.
  ///
  /// If set to false [NavigationRail] properties will use [FlexTheme]
  /// properties like [iconTheme], [selectedIconTheme], [labelTextStyle] and
  /// [selectedLabelTextStyle] as well as highlight styles when they are defined
  /// with higher priority than in [ThemeData] defined [NavigationRailTheme]
  /// properties.
  ///
  /// Keeping it false, gives you consistent style across the [FlexScaffold] by
  /// just defining its theme and style. Properties in [NavigationRailTheme]
  /// that don't have a counterpart in [FlexTheme] still come into effect from
  /// [NavigationRailTheme] when defined, even if this value is false.
  ///
  /// Setting this value to true, enables different style for the side
  /// navigation and the bottom navigation.
  ///
  /// This setting only has any impact when [NavigationRail] is used for
  /// side navigation instead of [FlexScaffold]'s own side navigation widget.
  ///
  /// Defaults to false.
  final bool? railPreferSubTheme;

  /// Color to be used for the [FlexScaffold]'s rail, menu and drawer
  /// background.
  ///
  /// The [menuBackgroundColor] value is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuBackgroundColor].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * After this the value will remain null if no value was assigned above,
  ///   however the background color will default to
  ///   ThemeData.colorScheme.background from the Material the menu uses.
  final Color? menuBackgroundColor;

  /// Color to be used for the [FlexScaffold] sidebar background.
  ///
  /// The [sidebarBackgroundColor] value is determined in the order:
  /// * None null value passed in Flexfold.theme.[sidebarBackgroundColor].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * After this the value will remain null if no value was assigned above,
  ///   however the background color will default to
  ///   ThemeData.colorScheme.background from the Material the menu uses.
  final Color? sidebarBackgroundColor;

  /// Color to be used for the [FlexScaffold]'s bottom navigation background.
  ///
  /// The [menuBackgroundColor] value is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuBackgroundColor].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * After this the value will remain null if no value was assigned above,
  ///   however the background color will default to
  ///   ThemeData.colorScheme.background from the Material the menu uses.
  final Color? bottomBackgroundColor;

  /// Enum used to set if menu should start at top or bottom of screen.
  ///
  /// The [menuStart] value is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuStart].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * [menuStart] = menuStart.top, by default if null.
  final FlexfoldMenuStart? menuStart;

  /// Enum used to set if menu should be at the start or end side of the screen.
  ///
  /// The LTR and RTL directionality control if left or right side is the start.
  /// The [menuSide] value is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuSide].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * [menuSide] = MenuSide.start, by default if null.
  final FlexfoldMenuSide? menuSide;

  // TODO(rydmike): This elevation does not work, why not? Works on sidebar.
  // Figure out how to fix the elevation. Most likely it is obscured for some
  // reason by the widget next to it. Elevation of the side menu does not look
  // nice, so I will never use it, but would be nice to get it to work.
  //
  /// The z-coordinate to be used for the menu elevation.
  ///
  /// The [menuElevation] value is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuElevation].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * [menuElevation] = 0, by default no elevation is used.
  final double? menuElevation;

  /// The z-coordinate to be used for the sidebar's elevation.
  ///
  /// The [sidebarElevation] value is determined in the order:
  /// * None null value passed in Flexfold.theme.[sidebarElevation].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * [sidebarElevation] = 0, by default no elevation is used.
  final double? sidebarElevation;

  /// The z-coordinate to be used for the menu drawer elevation.
  ///
  /// The [drawerElevation] value is determined in the order:
  /// * None null value passed in Flexfold.theme.[drawerElevation].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * [drawerElevation] = 16, default for Material drawer.
  final double? drawerElevation;

  /// The z-coordinate to be used for the sidebar end drawer elevation.
  ///
  /// The [endDrawerElevation] value is determined in the order:
  /// * None null value passed in Flexfold.theme.[endDrawerElevation].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * [endDrawerElevation] = 16, default for Material end drawer.
  final double? endDrawerElevation;

  /// The z-coordinate to be used for the sidebar end drawer elevation.
  ///
  /// The [bottomElevation] value is determined in the order:
  /// * None null value passed in Flexfold.theme.[bottomElevation].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * [bottomElevation] = 16, default for Material end drawer.
  final double? bottomElevation;

  /// Width of main menu, when it is visible as a fixed side menu in
  /// [FlexScaffold].
  ///
  /// The [menuWidth] is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuWidth].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then the default value is [kFlexfoldMenuWidth].
  /// * The const [kFlexfoldMenuWidth] = 250dp.
  ///
  /// You may want to adjust the menu width if your labels do not fit. Try
  /// to keep labels short as they also need to fit on a bottom navigation bar.
  final double? menuWidth;

  /// Width of the menu when it is used as a rail.
  ///
  /// The [railWidth] is determined in the order:
  /// * None null value passed in Flexfold.theme.[railWidth].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then the default value is [kFlexfoldRailWidth].
  /// * The [kFlexfoldRailWidth] is set to Flutter SDK constant [kToolbarHeight]
  ///   which is 56dp.
  ///
  /// There is normally no need to adjust this value. For standard icons used
  /// in the rail, the default value is a good fit and it by default matches
  /// the standard width of the leading widget width on the app bar.
  final double? railWidth;

  /// Width of sidebar, when it is visible as a fixed sidebar in [FlexScaffold].
  ///
  /// The [sidebarWidth] is determined in the order:
  /// * None null value passed in Flexfold.theme.[sidebarWidth].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then the default value is [kFlexfoldDrawerWidth].
  /// * The const [kFlexfoldDrawerWidth] = 304dp, the width of standard drawer.
  ///
  /// You may want to adjust the menu width if your labels do not fit. Try
  /// to keep labels short as they also need to fit on a bottom navigation bar.
  final double? sidebarWidth;

  /// Width of main menu in a drawer, when it is used as a drawer menu.
  ///
  /// The [drawerWidth] is determined in the order:
  /// * None null value passed in Flexfold.theme.[drawerWidth].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then the default value is [kFlexfoldDrawerWidth].
  /// * The const [kFlexfoldDrawerWidth] = 304dp, the width of standard drawer.
  final double? drawerWidth;

  /// Width of the sidebar in an end drawer when it is used as an end drawer.
  ///
  /// The [endDrawerWidth] is determined in the order:
  /// * None null value passed in Flexfold.theme.[endDrawerWidth].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then the default value is [kFlexfoldDrawerWidth].
  /// * The const [kFlexfoldDrawerWidth] = 304dp, the width of standard drawer.
  final double? endDrawerWidth;

  /// Screen height breakpoint when the menu/rail is no longer in a drawer.
  ///
  /// When the [breakpointDrawer] height is reached, the menu will no longer
  /// be hidden in a drawer.
  /// If [breakpointDrawer] height breakpoint is set to zero, the rail/menu
  /// will never be hidden as a drawer by default. It will always become a
  /// rail when the [breakpointRail] width breakpoint is exceeded or a menu
  /// if the [breakpointMenu] width is exceeded.
  ///
  /// The [breakpointDrawer] is determined in the order:
  /// * None null value passed in Flexfold.theme.[breakpointDrawer].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then default value is [kFlexfoldBreakpointDrawer].
  /// * The const [kFlexfoldBreakpointDrawer] = 550dp.
  final double? breakpointDrawer;

  /// Screen width breakpoint when rail takes over from bottom bar.
  ///
  /// The [breakpointRail] is determined in the order:
  /// * None null value passed in Flexfold.theme.[breakpointRail].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then default value is [kFlexfoldBreakpointRail].
  /// * The const [kFlexfoldBreakpointRail] = 600dp.
  final double? breakpointRail;

  /// Screen width breakpoint when side menu takes over from rail.
  ///
  /// The [breakpointMenu] is determined in the order:
  /// * None null value passed in Flexfold.theme.[breakpointMenu].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then default value is [kFlexfoldBreakpointMenu].
  /// * The const [kFlexfoldBreakpointMenu] = 1024dp.
  final double? breakpointMenu;

  /// Screen width breakpoint when the sidebar remains visible.
  /// Screen width breakpoint when side menu takes over from rail.
  ///
  /// The [breakpointSidebar] is determined in the order:
  /// * None null value passed in Flexfold.theme.[breakpointSidebar].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then default value is [kFlexfoldBreakpointSidebar].
  /// * The const [kFlexfoldBreakpointSidebar] = 1200dp.
  final double? breakpointSidebar;

  /// The menu has an edge border towards the body
  ///
  /// The [borderOnMenu] is determined in the order:
  /// * None null value passed in Flexfold.theme.[borderOnMenu].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then default value is true.
  final bool? borderOnMenu;

  /// The sidebar has an edge border towards the body.
  ///
  /// The [borderOnSidebar] is determined in the order:
  /// * None null value passed in Flexfold.theme.[borderOnSidebar].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then default value is true.
  final bool? borderOnSidebar;

  /// Draw a border on the visible side edge of a Drawer in dark mode.
  ///
  /// A drawer's edge might be difficult to see and look poor in dark mode.
  /// Enabling a border on it in dark mode ensures that the edge is more
  /// distinct looking. Defaults to true.
  ///
  /// The [borderOnDarkDrawer] is determined in the order:
  /// * None null value passed in Flexfold.theme.[borderOnDarkDrawer].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then default value is true.
  final bool? borderOnDarkDrawer;

  /// Draw a border on the visible side edge of a Drawer in light mode.
  ///
  /// A drawer's edge is normally fine when using a light background, there
  /// is normally no need to draw an edge border on it, but it can be enabled.
  /// Defaults to false.
  ///
  /// The [borderOnLightDrawer] is determined in the order:
  /// * None null passed in Flexfold.theme.[borderOnLightDrawer].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then default value is false.
  final bool? borderOnLightDrawer;

  /// Color of the edge borders when used.
  ///
  /// Applies to all border edges used on drawers and bottom navigation bar.
  /// If null it defaults to Theme.dividerColor.
  ///
  /// The [borderColor] is determined in the order:
  /// * None null value passed in Flexfold.theme.[borderColor].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then the default value is DividerTheme.color.
  /// * If all above null, then the default value is Theme.dividerColor.
  /// * If all above null, then the default value is Color(0x42888888),
  ///   this should not happen.
  ///
  /// If you use FlexfoldAppBar.styled as app bar, it is recommended to use
  /// the same color on its bottom border too, by default it does.
  final Color? borderColor;

  /// Height of the menu selection highlight indicator.
  ///
  /// The [menuHighlightHeight] is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuHighlightHeight].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then defaults to [kFlexfoldHighlightHeight] = 50dp
  final double? menuHighlightHeight;

  /// Directional margins for the menu highlight and hover shape.
  ///
  /// The [menuHighlightMargins] is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuHighlightMargins].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, then it defaults to
  ///   EdgeInsetsDirectional.fromSTEB(
  ///      kFlexfoldHighlightMarginStart = 0,
  ///      kFlexfoldHighlightMarginTop = 2,
  ///      kFlexfoldHighlightMarginEnd = 0,
  ///      kFlexfoldHighlightMarginBottom = 2),
  final EdgeInsetsDirectional? menuHighlightMargins;

  /// The shape of the highlight and borders on the selected menu item.
  ///
  /// The [menuSelectedShape] is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuSelectedShape].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, then it defaults to a rectangle without borders.
  ///   RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0));
  final ShapeBorder? menuSelectedShape;

  /// The shape of the mouse over highlight on a menu item.
  ///
  /// The shape is normally the same as on the one uses on [menuSelectedShape]
  /// but without any borders, if it has borders the borders will also be
  /// drawn on unselected items!
  ///
  /// The [menuHighlightShape] is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuHighlightShape].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, then it defaults to [menuSelectedShape].
  final ShapeBorder? menuHighlightShape;

  /// The highlight color of the selected menu item.
  ///
  /// The [menuHighlightColor] is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuHighlightColor].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null it defaults to
  ///   Theme.of(context).colorScheme.primary.withAlpha(0x3d), this is the same
  ///   alpha blend as the default in ChipThemeData for a selected chip.
  /// * If above fails and is null, then const Color(0x42888888).
  final Color? menuHighlightColor;

  /// Animation duration for the side menu and rail.
  ///
  /// The [menuAnimationDuration] is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuAnimationDuration].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then
  ///   It defaults to [kFlexfoldMenuAnimationDuration] which is set to 246ms
  ///   that match the value for the drawer.
  final Duration? menuAnimationDuration;

  /// Animation curve for the side menu and rail.
  ///
  /// The [menuAnimationCurve] is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuAnimationCurve].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then
  ///   It defaults to [kFlexfoldMenuAnimationCurve] which is set to
  ///   [Curves.easeInOut].
  final Curve? menuAnimationCurve;

  /// Animation duration for the sidebar.
  ///
  /// The [sidebarAnimationDuration] is determined in the order:
  /// * None null value passed in Flexfold.theme.[sidebarAnimationDuration].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then
  ///   It defaults to [kFlexfoldSidebarAnimationDuration] which is set to 246ms
  ///   that match the value for the drawer.
  final Duration? sidebarAnimationDuration;

  /// Animation curve for the sidebar.
  ///
  /// The [sidebarAnimationCurve] is determined in the order:
  /// * None null value passed in Flexfold.theme.[sidebarAnimationCurve].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then
  ///   It defaults to [kFlexfoldSidebarAnimationCurve] which is set to
  ///   [Curves.easeInOut].
  final Curve? sidebarAnimationCurve;

  /// Animation duration for the bottom navigation bar.
  ///
  /// The [bottomBarAnimationDuration] is determined in the order:
  /// * None null value passed in Flexfold.theme.[bottomBarAnimationDuration].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then
  ///   It defaults to [kFlexfoldBottomAnimationDuration] which is set to 246ms
  ///   that match the value for the drawer.
  final Duration? bottomBarAnimationDuration;

  /// Animation curve for the bottom navigation bar.
  ///
  /// The [bottomBarAnimationCurve] is determined in the order:
  /// * None null value passed in Flexfold.theme.[bottomBarAnimationCurve].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above null, then
  ///   It defaults to [kFlexfoldBottomAnimationCurve] which is set to
  ///   [Curves.easeInOut].
  final Curve? bottomBarAnimationCurve;

  /// The type of bottom navigation bar to use.
  ///
  /// The [bottomType] is determined in the order:
  /// * None null value passed in Flexfold.theme.[bottomType].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If above null, then it default to [FlexfoldBottomBarType.adaptive],
  ///   which uses a CupertinoTabBar navigation bar on iOs and MacOS and a
  ///  BottomNavigationBar on all other platforms.
  final FlexfoldBottomBarType? bottomType;

  /// Toggle to turn on and off the transparency on bottom navigation bar.
  ///
  /// The [bottomIsTransparent] is determined in the order:
  /// * None null value passed in via Flexfold.theme.[bottomIsTransparent].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * Defaults to true if the above are null.
  final bool? bottomIsTransparent;

  /// When the bottom bar has opacity, apply a blur filter if true.
  ///
  /// Applies the same blurring effect on a Material on bottom navigation bar
  /// as the one used on a CupertinoTabBar when it has opacity. This flag has
  /// no effect on CupertinoTabBar, it always uses the blurring when it has
  /// opacity other than 1.0.
  ///
  /// The filter is bit expensive and is only applied when this flag is
  /// on and there is opacity < 1 on the bottom navigation bar color. If these
  /// conditions are not met, the filter call is not made.
  ///
  /// The [bottomBlur] setting is determined in the order:
  /// * None null value passed in via Flexfold.theme.[bottomBlur].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, defaults to true.
  final bool? bottomBlur;

  /// The opacity value on the bottom navigation bar.
  ///
  /// This opacity value is only applied when [bottomIsTransparent] is true.
  ///
  /// The [bottomOpacity] is determined in the order:
  /// * None null value passed in Flexfold.theme.[bottomOpacity].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * Default to 0.90 if above are null.
  final double? bottomOpacity;

  /// The bottom navigation bar has a top edge border.
  ///
  /// The [bottomTopBorder] is determined in the order:
  /// * None null value passed in via Flexfold.theme.[bottomTopBorder].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If the above values are null, it defaults true.
  ///
  /// The color of the top border on bottom bar defaults to divider theme
  /// color, if not otherwise defined by [borderColor].
  final bool? bottomTopBorder;

  /// The theme to merge with the default icon theme for
  /// Flexfold destination icons, when the destination is not selected.
  ///
  /// The [iconTheme] is determined in the order:
  /// * None null values passed in via Flexfold.theme.[iconTheme].
  /// * None null values of the property in the inherited FlexfoldTheme.
  /// * If above are null or any property in them are null, they default to:
  ///   size: 24.0
  ///   color: theme?.colorScheme?.onSurface ?? const Color(0xFF888888)
  ///   opacity: 0.55
  final IconThemeData? iconTheme;

  /// The theme to merge with the default icon theme for
  /// [FlexScaffold] destination icons, when the destination is selected.
  ///
  /// The [selectedIconTheme] is determined in the order:
  /// * None null values passed in via Flexfold.theme.[selectedIconTheme].
  /// * None null values of the property in the inherited FlexfoldTheme.
  /// * If above are null or any property in them are null, they default to:
  ///   size: 24.0
  ///   color: theme?.colorScheme?.primary ?? const Color(0xFF2196F3)
  ///   opacity: 1.0
  final IconThemeData? selectedIconTheme;

  /// The style to merge with the default text style for
  /// Flexfold destination labels, when the destination is not selected.
  ///
  /// The [labelTextStyle] is determined in the order:
  /// * None null passed in via Flexfold.theme.[labelTextStyle].
  /// * None null values of the property in the inherited FlexfoldTheme.
  /// * If the above values are null, defaults to:
  ///   theme.of(context).textTheme.bodyText1.copyWith(color:
  ///     theme.colorScheme.onSurface.withOpacity(0.64))
  final TextStyle? labelTextStyle;

  /// The style to merge with the default text style for
  /// Flexfold destination labels, when the destination is selected.
  ///
  /// The [selectedLabelTextStyle] is determined in the order:
  /// * None null values passed in via Flexfold.theme.[selectedLabelTextStyle].
  /// * None null values of the property in the inherited FlexfoldTheme.
  /// * If the above values are null, defaults to:
  ///   theme?.primaryTextTheme?.bodyText1?.copyWith(color:
  ///     theme?.colorScheme?.primary)
  final TextStyle? selectedLabelTextStyle;

  /// The text style for headings above menu label items.
  ///
  /// The style will be merged with the default text style for menu destination
  /// headers used above menu labels. Typically there is one header for a group
  /// of menu labels. Current version only support one shared style for all the
  /// headings, but as you in destination can pass in any Widget, you can pass
  /// in a Text Widget with its own style for each menu heading and use separate
  /// style that way. If they are not styled, then shared provided here will be
  /// used.
  ///
  /// The [headingTextStyle] is determined in the order:
  /// * None null values passed in via Flexfold.theme.[headingTextStyle].
  /// * None null values of the property in the inherited FlexfoldTheme.
  /// * If the above values are null, defaults to:
  ///   fontSize: 16.0
  //    fontWeight: FontWeight.w700
  //    color: theme?.colorScheme?.primary ?? const Color(0xFF2196F3)
  final TextStyle? headingTextStyle;

  /// Use tooltips on the Flexfold widget.
  ///
  /// Tooltips are nice when you are new to an app, but when you know it well
  /// they can get annoying. If your app allows users to select when they are
  /// tired of seeing tooltips and can turn it off, you can pass the same value
  /// here and have [FlexScaffold] respect the same wishes.
  ///
  /// Tooltips exist by default on the app bar drawer/rail/menu toggle buttons
  /// and the side bar toggle button and on icons in rail mode.
  ///
  /// The rail mode icon tooltips are by default using the label for the
  /// destination, which is already shown as the label on drawer/menu and
  /// bottom navigation  items. So this label is never shown as a tooltip in
  /// those navigation modes.
  ///
  /// The [useTooltips] setting is determined in the order:
  /// * None null value passed in Flexfold.theme.[useTooltips].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null it default to true.
  final bool? useTooltips;

  /// Tooltip label for opening the drawer menu.
  ///
  /// The [menuOpenTooltip] label is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuOpenTooltip].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, then it defaults to:
  ///   MaterialLocalizations.of(context).openAppDrawerTooltip
  final String? menuOpenTooltip;

  /// Tooltip label for opening the drawer menu.
  ///
  /// The [menuCloseTooltip] label is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuCloseTooltip].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, then it defaults to:
  ///   MaterialLocalizations.of(context).closeButtonTooltip
  final String? menuCloseTooltip;

  /// Tooltip label for opening the drawer menu.
  ///
  /// The [menuExpandTooltip] label is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuExpandTooltip].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, then it defaults to:
  ///   MaterialLocalizations.of(context).showMenuTooltip
  final String? menuExpandTooltip;

  /// Tooltip label for opening the drawer menu.
  ///
  /// The [menuExpandHiddenTooltip] label is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuExpandHiddenTooltip].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, then it defaults to:
  ///   MaterialLocalizations.of(context).showMenuTooltip
  final String? menuExpandHiddenTooltip;

  /// Tooltip label for opening the drawer menu.
  ///
  /// The [menuCollapseTooltip] label is determined in the order:
  /// * None null value passed in Flexfold.theme.[menuCollapseTooltip].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, then it defaults to:
  ///   MaterialLocalizations.of(context).expandedIconTapHint
  final String? menuCollapseTooltip;

  /// Tooltip label for opening the drawer menu.
  ///
  /// The [sidebarOpenTooltip] label is determined in the order:
  /// * None null value passed in Flexfold.theme.[sidebarOpenTooltip].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, then it defaults to:
  ///   MaterialLocalizations.of(context).openAppDrawerTooltip
  final String? sidebarOpenTooltip;

  /// Tooltip label for opening the drawer menu.
  ///
  /// The [sidebarCloseTooltip] label is determined in the order:
  /// * None null value passed in Flexfold.theme.[sidebarCloseTooltip].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, then it defaults to:
  ///   MaterialLocalizations.of(context).closeButtonTooltip
  final String? sidebarCloseTooltip;

  /// Tooltip label for opening the drawer menu.
  ///
  /// The [sidebarExpandTooltip] label is determined in the order:
  /// * None null value passed in Flexfold.theme.[sidebarExpandTooltip].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, then it defaults to:
  ///   MaterialLocalizations.of(context).showMenuTooltip
  final String? sidebarExpandTooltip;

  /// Tooltip label for opening the drawer menu.
  ///
  /// The [sidebarExpandHiddenTooltip] label is determined in the order:
  /// * None null passed in Flexfold.theme.[sidebarExpandHiddenTooltip].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, then it defaults to:
  ///   MaterialLocalizations.of(context).showMenuTooltip
  final String? sidebarExpandHiddenTooltip;

  /// Tooltip label for opening the drawer menu.
  ///
  /// The [sidebarCollapseTooltip] label is determined in the order:
  /// * None null value passed in Flexfold.theme.[sidebarCollapseTooltip].
  /// * None null value of the property in the inherited FlexfoldTheme.
  /// * If all above are null, then it defaults to:
  ///   MaterialLocalizations.of(context).expandedIconTapHint
  final String? sidebarCollapseTooltip;

  /// Merge the other [FlexTheme] with the theme data of this
  /// instance.
  ///
  /// This is typically used to merge a theme data object with some overriding
  /// properties defined with it's parent inherited theme data, creating
  /// a resulting merged theme where the 'other' values override any inherited
  /// data, but none defined values keeps using the inherited values.
  FlexTheme merge(FlexTheme? other) {
    if (other == null) {
      return this;
    }
    return copyWith(
      //
      // Sub-theme priority selections
      bottomNavigationBarPreferSubTheme:
          other.bottomNavigationBarPreferSubTheme,
      navigationBarPreferSubTheme: other.navigationBarPreferSubTheme,
      railPreferSubTheme: other.railPreferSubTheme,
      //
      // Background color properties
      menuBackgroundColor: other.menuBackgroundColor,
      sidebarBackgroundColor: other.sidebarBackgroundColor,
      bottomBackgroundColor: other.bottomBackgroundColor,
      //
      // Menu start and side settings
      menuStart: other.menuStart,
      menuSide: other.menuSide,
      //
      // Elevation properties
      menuElevation: other.menuElevation,
      sidebarElevation: other.sidebarElevation,
      drawerElevation: other.drawerElevation,
      endDrawerElevation: other.endDrawerElevation,
      bottomElevation: other.bottomElevation,
      //
      // Width properties
      menuWidth: other.menuWidth,
      railWidth: other.railWidth,
      sidebarWidth: other.sidebarWidth,
      drawerWidth: other.drawerWidth,
      endDrawerWidth: other.endDrawerWidth,
      //
      // Navigation type breakpoints
      breakpointDrawer: other.breakpointDrawer,
      breakpointRail: other.breakpointRail,
      breakpointMenu: other.breakpointMenu,
      breakpointSidebar: other.breakpointSidebar,
      //
      // Edge border properties
      borderOnMenu: other.borderOnMenu,
      borderOnSidebar: other.borderOnSidebar,
      borderOnDarkDrawer: other.borderOnDarkDrawer,
      borderOnLightDrawer: other.borderOnLightDrawer,
      borderColor: other.borderColor,
      //
      // Menu selection and highlight style
      menuHighlightHeight: other.menuHighlightHeight,
      menuHighlightMargins: other.menuHighlightMargins,
      menuSelectedShape: other.menuSelectedShape,
      menuHighlightShape: other.menuHighlightShape,
      menuHighlightColor: other.menuHighlightColor,
      //
      // Animation durations and curves for menu and bottom bar animations
      menuAnimationDuration: other.menuAnimationDuration,
      menuAnimationCurve: other.menuAnimationCurve,
      sidebarAnimationDuration: other.sidebarAnimationDuration,
      sidebarAnimationCurve: other.sidebarAnimationCurve,
      bottomBarAnimationDuration: other.bottomBarAnimationDuration,
      bottomBarAnimationCurve: other.bottomBarAnimationCurve,
      //
      // Bottom navigation bar properties
      bottomBarType: other.bottomType,
      bottomBarIsTransparent: other.bottomIsTransparent,
      bottomBarBlur: other.bottomBlur,
      bottomBarOpacity: other.bottomOpacity,
      bottomBarTopBorder: other.bottomTopBorder,
      //
      // The icon and text styles of the menu, rail and bottom bar.
      iconTheme: other.iconTheme,
      selectedIconTheme: other.selectedIconTheme,
      labelTextStyle: other.labelTextStyle,
      selectedLabelTextStyle: other.selectedLabelTextStyle,
      // The text style for headings above menu label items
      headingTextStyle: other.headingTextStyle,
      //
      // Tooltip properties
      useTooltips: other.useTooltips,
      menuOpenTooltip: other.menuOpenTooltip,
      menuCloseTooltip: other.menuCloseTooltip,
      menuExpandTooltip: other.menuExpandTooltip,
      menuExpandHiddenTooltip: other.menuExpandHiddenTooltip,
      menuCollapseTooltip: other.menuCollapseTooltip,
      sidebarOpenTooltip: other.sidebarOpenTooltip,
      sidebarCloseTooltip: other.sidebarCloseTooltip,
      sidebarExpandTooltip: other.sidebarExpandTooltip,
      sidebarExpandHiddenTooltip: other.sidebarExpandHiddenTooltip,
      sidebarCollapseTooltip: other.sidebarCollapseTooltip,
    );
  }

  /// Merge this instance of [FlexTheme] with the hard coded default
  /// values for [FlexTheme] in the build context.
  FlexTheme withDefaults(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool useMaterial3 = theme.useMaterial3;
    final MaterialLocalizations hints = MaterialLocalizations.of(context);
    final String openHint = hints.openAppDrawerTooltip;
    final String closeHint = hints.closeButtonTooltip;
    final String expandHint = hints.showMenuTooltip;
    final String collapseHint = hints.expandedIconTapHint;

    return copyWith(
      //
      // Sub-theme priority selections
      bottomNavigationBarPreferSubTheme:
          bottomNavigationBarPreferSubTheme ?? false,
      navigationBarPreferSubTheme: navigationBarPreferSubTheme ?? false,
      railPreferSubTheme: railPreferSubTheme ?? false,
      //
      // Background color properties
      menuBackgroundColor: menuBackgroundColor ?? theme.colorScheme.background,
      sidebarBackgroundColor:
          sidebarBackgroundColor ?? theme.colorScheme.background,
      bottomBackgroundColor:
          bottomBackgroundColor ?? theme.colorScheme.background,
      //
      // Menu start and side settings
      menuStart: menuStart ?? FlexfoldMenuStart.top,
      menuSide: menuSide ?? FlexfoldMenuSide.start,
      //
      // Elevation properties
      menuElevation: menuElevation ?? 0,
      sidebarElevation: sidebarElevation ?? 0,
      drawerElevation: drawerElevation ?? (useMaterial3 ? 1 : 16),
      endDrawerElevation: endDrawerElevation ?? (useMaterial3 ? 1 : 16),
      bottomElevation: bottomElevation ?? 0,
      //
      // Width properties
      menuWidth: menuWidth ?? kFlexfoldMenuWidth,
      railWidth: railWidth ?? kFlexfoldRailWidth,
      sidebarWidth: sidebarWidth ?? kFlexfoldSidebarWidth,
      drawerWidth: drawerWidth ?? kFlexfoldDrawerWidth,
      //
      // Navigation type breakpoints
      endDrawerWidth: endDrawerWidth ?? kFlexfoldDrawerWidth,
      breakpointDrawer: breakpointDrawer ?? kFlexfoldBreakpointDrawer,
      breakpointRail: breakpointRail ?? kFlexfoldBreakpointRail,
      breakpointMenu: breakpointMenu ?? kFlexfoldBreakpointMenu,
      breakpointSidebar: breakpointSidebar ?? kFlexfoldBreakpointSidebar,
      //
      // Edge border properties
      borderOnMenu: borderOnMenu ?? true,
      borderOnSidebar: borderOnSidebar ?? true,
      borderOnDarkDrawer: borderOnDarkDrawer ?? true,
      borderOnLightDrawer: borderOnLightDrawer ?? false,
      borderColor:
          borderColor ?? theme.dividerTheme.color ?? theme.dividerColor,
      //
      // Menu selection and highlight style
      menuHighlightHeight: menuHighlightHeight ?? kFlexfoldHighlightHeight,
      menuHighlightMargins: menuHighlightMargins ??
          const EdgeInsetsDirectional.fromSTEB(
              kFlexfoldHighlightMarginStart,
              kFlexfoldHighlightMarginTop,
              kFlexfoldHighlightMarginEnd,
              kFlexfoldHighlightMarginBottom),
      menuSelectedShape: menuSelectedShape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      menuHighlightShape: menuHighlightShape ??
          menuSelectedShape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      menuHighlightColor:
          menuHighlightColor ?? theme.colorScheme.primary.withAlpha(0x3d),
      //
      // Animation durations and curves for menu and bottom bar animations
      menuAnimationDuration:
          menuAnimationDuration ?? kFlexfoldMenuAnimationDuration,
      menuAnimationCurve: menuAnimationCurve ?? kFlexfoldMenuAnimationCurve,
      sidebarAnimationDuration:
          sidebarAnimationDuration ?? kFlexfoldSidebarAnimationDuration,
      sidebarAnimationCurve:
          sidebarAnimationCurve ?? kFlexfoldSidebarAnimationCurve,
      bottomBarAnimationDuration:
          bottomBarAnimationDuration ?? kFlexfoldBottomAnimationDuration,
      bottomBarAnimationCurve:
          bottomBarAnimationCurve ?? kFlexfoldBottomAnimationCurve,
      //
      // Bottom navigation bar properties
      bottomBarType: bottomType ?? FlexfoldBottomBarType.adaptive,
      bottomBarIsTransparent: bottomIsTransparent ?? true,
      bottomBarBlur: bottomBlur ?? true,
      bottomBarOpacity: bottomOpacity ?? 0.90,
      bottomBarTopBorder: bottomTopBorder ?? true,
      //
      // TODO(rydmike): Review default against M2 & M3 for icons and text.
      // The default unselected menu icon styles, provided values from the
      // passed in IconThemeData are used if the theme was not null and any
      // property in it had a none null value. If some value is missing they
      // get FlexScaffold defaults.
      iconTheme: IconThemeData(
          size: iconTheme?.size ?? 24.0,
          color: iconTheme?.color ?? theme.colorScheme.onSurface,
          opacity: iconTheme?.opacity ?? 0.55),
      // The default selected menu icon styles, provided values from the
      // passed in IconThemeData are used if the theme was not null and any
      // property in it had a none null value. If some value is missing they
      // get FlexScaffold defaults.
      selectedIconTheme: IconThemeData(
          size: selectedIconTheme?.size ?? 24.0,
          color: selectedIconTheme?.color ?? theme.colorScheme.primary,
          opacity: selectedIconTheme?.opacity ?? 1.0),
      // The default unselected label text styles with a merge of the provided
      // style, if any style was given.
      labelTextStyle: theme.textTheme.bodyText1!
          .copyWith(color: theme.colorScheme.onSurface.withOpacity(0.64))
          .merge(labelTextStyle),
      // The default selected label text styles with a merge of the provided
      // style, if any style was given.
      selectedLabelTextStyle: theme.textTheme.bodyText1!
          .copyWith(color: theme.colorScheme.primary)
          .merge(selectedLabelTextStyle),
      // style, if any style was given.
      headingTextStyle: theme.textTheme.bodyText1!
          .copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.primary)
          .merge(headingTextStyle),
      //
      // Tooltip properties
      useTooltips: useTooltips ?? true,
      menuOpenTooltip: menuOpenTooltip ?? openHint,
      menuCloseTooltip: menuCloseTooltip ?? closeHint,
      menuExpandTooltip: menuExpandTooltip ?? expandHint,
      menuExpandHiddenTooltip: menuExpandHiddenTooltip ?? expandHint,
      menuCollapseTooltip: menuCollapseTooltip ?? collapseHint,
      sidebarOpenTooltip: sidebarOpenTooltip ?? openHint,
      sidebarCloseTooltip: sidebarCloseTooltip ?? closeHint,
      sidebarExpandTooltip: sidebarExpandTooltip ?? expandHint,
      sidebarExpandHiddenTooltip: sidebarExpandHiddenTooltip ?? expandHint,
      sidebarCollapseTooltip: sidebarCollapseTooltip ?? collapseHint,
    );
  }

  /// Copy this object with the given fields replaced with the new values.
  @override
  FlexTheme copyWith({
    //
    // Sub-theme priority selections
    bool? bottomNavigationBarPreferSubTheme,
    bool? navigationBarPreferSubTheme,
    bool? railPreferSubTheme,
    //
    // Background color properties
    Color? menuBackgroundColor,
    Color? sidebarBackgroundColor,
    Color? bottomBackgroundColor,
    //
    // Menu start and side settings
    FlexfoldMenuStart? menuStart,
    FlexfoldMenuSide? menuSide,
    //
    // Elevation properties
    double? menuElevation,
    double? sidebarElevation,
    double? drawerElevation,
    double? endDrawerElevation,
    double? bottomElevation,
    //
    // Width properties
    double? menuWidth,
    double? railWidth,
    double? sidebarWidth,
    double? drawerWidth,
    double? endDrawerWidth,
    //
    // Navigation type breakpoints
    double? breakpointDrawer,
    double? breakpointRail,
    double? breakpointMenu,
    double? breakpointSidebar,
    //
    // Edge border properties
    bool? borderOnMenu,
    bool? borderOnSidebar,
    bool? borderOnDarkDrawer,
    bool? borderOnLightDrawer,
    Color? borderColor,
    //
    // Menu selection and highlight style
    double? menuHighlightHeight,
    EdgeInsetsDirectional? menuHighlightMargins,
    ShapeBorder? menuSelectedShape,
    ShapeBorder? menuHighlightShape,
    Color? menuHighlightColor,
    //
    // Animation durations and curves for menu and bottom bar animations
    Duration? menuAnimationDuration,
    Curve? menuAnimationCurve,
    Duration? sidebarAnimationDuration,
    Curve? sidebarAnimationCurve,
    Duration? bottomBarAnimationDuration,
    Curve? bottomBarAnimationCurve,
    //
    // Bottom navigation bar properties
    FlexfoldBottomBarType? bottomBarType,
    bool? bottomBarIsTransparent,
    bool? bottomBarBlur,
    double? bottomBarOpacity,
    bool? bottomBarTopBorder,
    //
    // The icon and text styles of the menu, rail and bottom bar.
    IconThemeData? iconTheme,
    IconThemeData? selectedIconTheme,
    TextStyle? labelTextStyle,
    TextStyle? selectedLabelTextStyle,
    // The text style for headings above menu label items
    TextStyle? headingTextStyle,
    //
    // Tooltip properties
    bool? useTooltips,
    String? menuOpenTooltip,
    String? menuCloseTooltip,
    String? menuExpandTooltip,
    String? menuExpandHiddenTooltip,
    String? menuCollapseTooltip,
    String? sidebarOpenTooltip,
    String? sidebarCloseTooltip,
    String? sidebarExpandTooltip,
    String? sidebarExpandHiddenTooltip,
    String? sidebarCollapseTooltip,
  }) {
    return FlexTheme(
      //
      // Sub-theme priority selections
      bottomNavigationBarPreferSubTheme: bottomNavigationBarPreferSubTheme ??
          this.bottomNavigationBarPreferSubTheme,
      navigationBarPreferSubTheme:
          navigationBarPreferSubTheme ?? this.navigationBarPreferSubTheme,
      railPreferSubTheme: railPreferSubTheme ?? this.railPreferSubTheme,
      //
      // Background color properties
      menuBackgroundColor: menuBackgroundColor ?? this.menuBackgroundColor,
      sidebarBackgroundColor:
          sidebarBackgroundColor ?? this.sidebarBackgroundColor,
      bottomBackgroundColor:
          bottomBackgroundColor ?? this.bottomBackgroundColor,
      //
      // Menu start and side settings
      menuStart: menuStart ?? this.menuStart,
      menuSide: menuSide ?? this.menuSide,
      //
      // Elevation properties
      menuElevation: menuElevation ?? this.menuElevation,
      sidebarElevation: sidebarElevation ?? this.sidebarElevation,
      drawerElevation: drawerElevation ?? this.drawerElevation,
      endDrawerElevation: endDrawerElevation ?? this.endDrawerElevation,
      bottomElevation: bottomElevation ?? this.bottomElevation,
      //
      // Width properties
      menuWidth: menuWidth ?? this.menuWidth,
      railWidth: railWidth ?? this.railWidth,
      sidebarWidth: sidebarWidth ?? this.sidebarWidth,
      drawerWidth: drawerWidth ?? this.drawerWidth,
      endDrawerWidth: endDrawerWidth ?? this.endDrawerWidth,
      //
      // Navigation type breakpoints
      breakpointDrawer: breakpointDrawer ?? this.breakpointDrawer,
      breakpointRail: breakpointRail ?? this.breakpointRail,
      breakpointMenu: breakpointMenu ?? this.breakpointMenu,
      breakpointSidebar: breakpointSidebar ?? this.breakpointSidebar,
      //
      // Edge border properties
      borderOnMenu: borderOnMenu ?? this.borderOnMenu,
      borderOnSidebar: borderOnSidebar ?? this.borderOnSidebar,
      borderOnDarkDrawer: borderOnDarkDrawer ?? this.borderOnDarkDrawer,
      borderOnLightDrawer: borderOnLightDrawer ?? this.borderOnLightDrawer,
      borderColor: borderColor ?? this.borderColor,
      //
      // Menu selection and highlight style
      menuHighlightHeight: menuHighlightHeight ?? this.menuHighlightHeight,
      menuHighlightMargins: menuHighlightMargins ?? this.menuHighlightMargins,
      menuSelectedShape: menuSelectedShape ?? this.menuSelectedShape,
      menuHighlightShape: menuHighlightShape ?? this.menuHighlightShape,
      menuHighlightColor: menuHighlightColor ?? this.menuHighlightColor,
      //
      // Animation durations and curves for menus and bottom bar animations
      menuAnimationDuration:
          menuAnimationDuration ?? this.menuAnimationDuration,
      menuAnimationCurve: menuAnimationCurve ?? this.menuAnimationCurve,
      sidebarAnimationDuration:
          sidebarAnimationDuration ?? this.sidebarAnimationDuration,
      sidebarAnimationCurve:
          sidebarAnimationCurve ?? this.sidebarAnimationCurve,
      bottomBarAnimationDuration:
          bottomBarAnimationDuration ?? this.bottomBarAnimationDuration,
      bottomBarAnimationCurve:
          bottomBarAnimationCurve ?? this.bottomBarAnimationCurve,
      //
      // Bottom navigation bar properties
      bottomType: bottomBarType ?? this.bottomType,
      bottomIsTransparent: bottomBarIsTransparent ?? this.bottomIsTransparent,
      bottomBlur: bottomBarBlur ?? this.bottomBlur,
      bottomOpacity: bottomBarOpacity ?? this.bottomOpacity,
      bottomTopBorder: bottomBarTopBorder ?? this.bottomTopBorder,
      //
      // The icon and text styles of the menu, rail and bottom bar.
      iconTheme: iconTheme ?? this.iconTheme,
      selectedIconTheme: selectedIconTheme ?? this.selectedIconTheme,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      selectedLabelTextStyle:
          selectedLabelTextStyle ?? this.selectedLabelTextStyle,
      // The text style for headings above menu label items
      headingTextStyle: headingTextStyle ?? this.headingTextStyle,
      //
      // Tooltip properties
      useTooltips: useTooltips ?? this.useTooltips,
      menuOpenTooltip: menuOpenTooltip ?? this.menuOpenTooltip,
      menuCloseTooltip: menuCloseTooltip ?? this.menuCloseTooltip,
      menuExpandTooltip: menuExpandTooltip ?? this.menuExpandTooltip,
      menuExpandHiddenTooltip:
          menuExpandHiddenTooltip ?? this.menuExpandHiddenTooltip,
      menuCollapseTooltip: menuCollapseTooltip ?? this.menuCollapseTooltip,
      sidebarOpenTooltip: sidebarOpenTooltip ?? this.sidebarOpenTooltip,
      sidebarCloseTooltip: sidebarCloseTooltip ?? this.sidebarCloseTooltip,
      sidebarExpandTooltip: sidebarExpandTooltip ?? this.sidebarExpandTooltip,
      sidebarExpandHiddenTooltip:
          sidebarExpandHiddenTooltip ?? this.sidebarExpandHiddenTooltip,
      sidebarCollapseTooltip:
          sidebarCollapseTooltip ?? this.sidebarCollapseTooltip,
    );
  }

  /// Linearly interpolate between two [FlexTheme] themes.
  @override
  FlexTheme lerp(ThemeExtension<FlexTheme>? other, double t) {
    if (other is! FlexTheme) {
      return this;
    }
    return FlexTheme(
      //
      // Sub-theme priority selections
      bottomNavigationBarPreferSubTheme: t < 0.5
          ? bottomNavigationBarPreferSubTheme
          : other.bottomNavigationBarPreferSubTheme,
      navigationBarPreferSubTheme: t < 0.5
          ? navigationBarPreferSubTheme
          : other.navigationBarPreferSubTheme,
      railPreferSubTheme:
          t < 0.5 ? railPreferSubTheme : other.railPreferSubTheme,
      //
      // Background color properties
      menuBackgroundColor:
          Color.lerp(menuBackgroundColor, other.menuBackgroundColor, t),
      sidebarBackgroundColor:
          Color.lerp(sidebarBackgroundColor, other.sidebarBackgroundColor, t),
      bottomBackgroundColor:
          Color.lerp(bottomBackgroundColor, other.bottomBackgroundColor, t),
      //
      // Menu start and side settings
      menuStart: t < 0.5 ? menuStart : other.menuStart,
      menuSide: t < 0.5 ? menuSide : other.menuSide,
      //
      // Elevation properties
      menuElevation: lerpDouble(menuElevation, other.menuElevation, t),
      sidebarElevation: lerpDouble(sidebarElevation, other.sidebarElevation, t),
      drawerElevation: lerpDouble(drawerElevation, other.drawerElevation, t),
      endDrawerElevation:
          lerpDouble(endDrawerElevation, other.endDrawerElevation, t),
      bottomElevation: lerpDouble(bottomElevation, other.bottomElevation, t),
      //
      // Width properties
      menuWidth: lerpDouble(menuWidth, other.menuWidth, t),
      railWidth: lerpDouble(railWidth, other.railWidth, t),
      sidebarWidth: lerpDouble(sidebarWidth, other.sidebarWidth, t),
      drawerWidth: lerpDouble(drawerWidth, other.drawerWidth, t),
      endDrawerWidth: lerpDouble(endDrawerWidth, other.endDrawerWidth, t),
      //
      // Navigation type breakpoints
      breakpointDrawer: lerpDouble(breakpointDrawer, other.breakpointDrawer, t),
      breakpointRail: lerpDouble(breakpointRail, other.breakpointRail, t),
      breakpointMenu: lerpDouble(breakpointMenu, other.breakpointMenu, t),
      breakpointSidebar:
          lerpDouble(breakpointSidebar, other.breakpointSidebar, t),
      //
      // Edge border properties
      borderOnMenu: t < 0.5 ? borderOnMenu : other.borderOnMenu,
      borderOnSidebar: t < 0.5 ? borderOnSidebar : other.borderOnSidebar,
      borderOnDarkDrawer:
          t < 0.5 ? borderOnDarkDrawer : other.borderOnDarkDrawer,
      borderOnLightDrawer:
          t < 0.5 ? borderOnLightDrawer : other.borderOnLightDrawer,
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      //
      // Menu selection and highlight style
      menuHighlightHeight:
          lerpDouble(menuHighlightHeight, other.menuHighlightHeight, t),
      menuHighlightMargins: EdgeInsetsDirectional.lerp(
          menuHighlightMargins, other.menuHighlightMargins, t),
      menuSelectedShape:
          ShapeBorder.lerp(menuSelectedShape, other.menuSelectedShape, t),
      menuHighlightShape:
          ShapeBorder.lerp(menuHighlightShape, other.menuHighlightShape, t),
      menuHighlightColor:
          Color.lerp(menuHighlightColor, other.menuHighlightColor, t),
      //
      // Animation durations and curves for menus and bottom bar animations
      menuAnimationDuration:
          t < 0.5 ? menuAnimationDuration : other.menuAnimationDuration,
      menuAnimationCurve:
          t < 0.5 ? menuAnimationCurve : other.menuAnimationCurve,
      sidebarAnimationDuration:
          t < 0.5 ? sidebarAnimationDuration : other.sidebarAnimationDuration,
      sidebarAnimationCurve:
          t < 0.5 ? sidebarAnimationCurve : other.sidebarAnimationCurve,
      bottomBarAnimationDuration: t < 0.5
          ? bottomBarAnimationDuration
          : other.bottomBarAnimationDuration,
      bottomBarAnimationCurve:
          t < 0.5 ? bottomBarAnimationCurve : other.bottomBarAnimationCurve,
      //
      // Bottom navigation bar properties
      bottomType: t < 0.5 ? bottomType : other.bottomType,
      bottomIsTransparent:
          t < 0.5 ? bottomIsTransparent : other.bottomIsTransparent,
      bottomBlur: t < 0.5 ? bottomBlur : other.bottomBlur,
      bottomOpacity: lerpDouble(bottomOpacity, other.bottomOpacity, t),
      bottomTopBorder: t < 0.5 ? bottomTopBorder : other.bottomTopBorder,
      //
      // The icon and text styles of the menu, rail and bottom bar.
      iconTheme: IconThemeData.lerp(iconTheme, other.iconTheme, t),
      selectedIconTheme:
          IconThemeData.lerp(selectedIconTheme, other.selectedIconTheme, t),
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t),
      selectedLabelTextStyle: TextStyle.lerp(
          selectedLabelTextStyle, other.selectedLabelTextStyle, t),
      // The text style for headings above menu label items
      headingTextStyle:
          TextStyle.lerp(headingTextStyle, other.headingTextStyle, t),
      //
      // Tooltip properties
      useTooltips: t < 0.5 ? useTooltips : other.useTooltips,
      menuOpenTooltip: t < 0.5 ? menuOpenTooltip : other.menuOpenTooltip,
      menuCloseTooltip: t < 0.5 ? menuCloseTooltip : other.menuCloseTooltip,
      menuExpandTooltip: t < 0.5 ? menuExpandTooltip : other.menuExpandTooltip,
      menuExpandHiddenTooltip:
          t < 0.5 ? menuExpandHiddenTooltip : other.menuExpandHiddenTooltip,
      menuCollapseTooltip:
          t < 0.5 ? menuCollapseTooltip : other.menuCollapseTooltip,
      sidebarOpenTooltip:
          t < 0.5 ? sidebarOpenTooltip : other.sidebarOpenTooltip,
      sidebarCloseTooltip:
          t < 0.5 ? sidebarCloseTooltip : other.sidebarCloseTooltip,
      sidebarExpandTooltip:
          t < 0.5 ? sidebarExpandTooltip : other.sidebarExpandTooltip,
      sidebarExpandHiddenTooltip: t < 0.5
          ? sidebarExpandHiddenTooltip
          : other.sidebarExpandHiddenTooltip,
      sidebarCollapseTooltip:
          t < 0.5 ? sidebarCollapseTooltip : other.sidebarCollapseTooltip,
    );
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
        //
        // Sub-theme priority selections
        bottomNavigationBarPreferSubTheme,
        navigationBarPreferSubTheme,
        railPreferSubTheme,
        //
        // Background color properties
        menuBackgroundColor,
        sidebarBackgroundColor,
        bottomBackgroundColor,
        //
        // Menu start and side settings
        menuStart,
        menuSide,
        //
        // Elevation properties
        menuElevation,
        sidebarElevation,
        drawerElevation,
        endDrawerElevation,
        bottomElevation,
        //
        // Width properties
        menuWidth,
        railWidth,
        sidebarWidth,
        drawerWidth,
        endDrawerWidth,
        //
        // Navigation type breakpoints
        breakpointDrawer,
        breakpointRail,
        breakpointMenu,
        breakpointSidebar,
        //
        // Edge border properties
        borderOnMenu,
        borderOnSidebar,
        borderOnDarkDrawer,
        borderOnLightDrawer,
        borderColor,
        //
        // Menu selection and highlight style
        menuHighlightHeight,
        menuHighlightMargins,
        menuSelectedShape,
        menuHighlightShape,
        menuHighlightColor,
        //
        // Animation durations and curves for menus and bottom bar animations
        menuAnimationDuration,
        menuAnimationCurve,
        sidebarAnimationDuration,
        sidebarAnimationCurve,
        bottomBarAnimationDuration,
        bottomBarAnimationCurve,
        //
        // Bottom navigation bar properties
        bottomType,
        bottomIsTransparent,
        bottomBlur,
        bottomOpacity,
        bottomTopBorder,
        //
        // The icon and text styles of the menu, rail and bottom bar.
        iconTheme,
        selectedIconTheme,
        labelTextStyle,
        selectedLabelTextStyle,
        // The text style for headings above menu label items
        headingTextStyle,
        //
        // Tooltip properties
        useTooltips,
        menuOpenTooltip,
        menuCloseTooltip,
        menuExpandTooltip,
        menuExpandHiddenTooltip,
        menuCollapseTooltip,
        sidebarOpenTooltip,
        sidebarCloseTooltip,
        sidebarExpandTooltip,
        sidebarExpandHiddenTooltip,
        sidebarCollapseTooltip,
      ]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is FlexTheme &&
        //
        // Sub-theme priority selections
        other.bottomNavigationBarPreferSubTheme ==
            bottomNavigationBarPreferSubTheme &&
        other.navigationBarPreferSubTheme == navigationBarPreferSubTheme &&
        other.railPreferSubTheme == railPreferSubTheme &&
        //
        // Background color properties
        other.menuBackgroundColor == menuBackgroundColor &&
        other.sidebarBackgroundColor == sidebarBackgroundColor &&
        other.bottomBackgroundColor == bottomBackgroundColor &&
        //
        // Menu start and side settings
        other.menuStart == menuStart &&
        other.menuSide == menuSide &&
        //
        // Elevation properties
        other.menuElevation == menuElevation &&
        other.sidebarElevation == sidebarElevation &&
        other.drawerElevation == drawerElevation &&
        other.endDrawerElevation == endDrawerElevation &&
        other.bottomElevation == bottomElevation &&
        //
        // Width properties
        other.menuWidth == menuWidth &&
        other.railWidth == railWidth &&
        other.sidebarWidth == sidebarWidth &&
        other.drawerWidth == drawerWidth &&
        other.endDrawerWidth == endDrawerWidth &&
        //
        // Navigation type breakpoints
        other.breakpointDrawer == breakpointDrawer &&
        other.breakpointRail == breakpointRail &&
        other.breakpointMenu == breakpointMenu &&
        other.breakpointSidebar == breakpointSidebar &&
        //
        // Edge border properties
        other.borderOnMenu == borderOnMenu &&
        other.borderOnSidebar == borderOnSidebar &&
        other.borderOnDarkDrawer == borderOnDarkDrawer &&
        other.borderOnLightDrawer == borderOnLightDrawer &&
        other.borderColor == borderColor &&
        //
        // Menu selection and highlight style
        other.menuHighlightHeight == menuHighlightHeight &&
        other.menuHighlightMargins == menuHighlightMargins &&
        other.menuSelectedShape == menuSelectedShape &&
        other.menuHighlightShape == menuHighlightShape &&
        other.menuHighlightColor == menuHighlightColor &&
        //
        // Animation durations and curves for menus and bottom bar animations
        other.menuAnimationDuration == menuAnimationDuration &&
        other.menuAnimationCurve == menuAnimationCurve &&
        other.sidebarAnimationDuration == sidebarAnimationDuration &&
        other.sidebarAnimationCurve == sidebarAnimationCurve &&
        other.bottomBarAnimationDuration == bottomBarAnimationDuration &&
        other.bottomBarAnimationCurve == bottomBarAnimationCurve &&
        //
        // Bottom navigation bar properties
        other.bottomType == bottomType &&
        other.bottomIsTransparent == bottomIsTransparent &&
        other.bottomBlur == bottomBlur &&
        other.bottomOpacity == bottomOpacity &&
        other.bottomTopBorder == bottomTopBorder &&
        //
        // The icon and text styles of the menu, rail and bottom bar.
        other.iconTheme == iconTheme &&
        other.selectedIconTheme == selectedIconTheme &&
        other.labelTextStyle == labelTextStyle &&
        other.selectedLabelTextStyle == selectedLabelTextStyle &&
        // The text style for headings above menu label items
        other.headingTextStyle == headingTextStyle &&
        //
        // Tooltip properties
        other.useTooltips == useTooltips &&
        other.menuOpenTooltip == menuOpenTooltip &&
        other.menuCloseTooltip == menuCloseTooltip &&
        other.menuExpandTooltip == menuExpandTooltip &&
        other.menuExpandHiddenTooltip == menuExpandHiddenTooltip &&
        other.menuCollapseTooltip == menuCollapseTooltip &&
        other.sidebarOpenTooltip == sidebarOpenTooltip &&
        other.sidebarCloseTooltip == sidebarCloseTooltip &&
        other.sidebarExpandTooltip == sidebarExpandTooltip &&
        other.sidebarExpandHiddenTooltip == sidebarExpandHiddenTooltip &&
        other.sidebarCollapseTooltip == sidebarCollapseTooltip;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    const FlexTheme defaultData = FlexTheme();
    //
    // Sub-theme priority selections
    properties.add(DiagnosticsProperty<bool>(
        'bottomNavigationBarPreferSubTheme', bottomNavigationBarPreferSubTheme,
        defaultValue: defaultData.bottomNavigationBarPreferSubTheme,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<bool>(
        'navigationBarPreferSubTheme', navigationBarPreferSubTheme,
        defaultValue: defaultData.navigationBarPreferSubTheme,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<bool>(
        'railPreferSubTheme', railPreferSubTheme,
        defaultValue: defaultData.railPreferSubTheme,
        level: DiagnosticLevel.debug));
    //
    // Background color properties
    properties.add(ColorProperty('menuBackgroundColor', menuBackgroundColor,
        defaultValue: defaultData.menuBackgroundColor,
        level: DiagnosticLevel.debug));
    properties.add(ColorProperty(
        'sidebarBackgroundColor', sidebarBackgroundColor,
        defaultValue: defaultData.sidebarBackgroundColor,
        level: DiagnosticLevel.debug));
    properties.add(ColorProperty('bottomBackgroundColor', bottomBackgroundColor,
        defaultValue: defaultData.bottomBackgroundColor,
        level: DiagnosticLevel.debug));
    //
    // Menu start and side settings
    properties.add(DiagnosticsProperty<FlexfoldMenuStart>(
        'menuStart', menuStart,
        defaultValue: defaultData.menuStart, level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<FlexfoldMenuSide>('menuSide', menuSide,
        defaultValue: defaultData.menuSide, level: DiagnosticLevel.debug));
    //
    // Elevation properties
    properties.add(DoubleProperty('menuElevation', menuElevation,
        defaultValue: defaultData.menuElevation, level: DiagnosticLevel.debug));
    properties.add(DoubleProperty('sidebarElevation', sidebarElevation,
        defaultValue: defaultData.sidebarElevation,
        level: DiagnosticLevel.debug));
    properties.add(DoubleProperty('drawerElevation', drawerElevation,
        defaultValue: defaultData.drawerElevation,
        level: DiagnosticLevel.debug));
    properties.add(DoubleProperty('endDrawerElevation', endDrawerElevation,
        defaultValue: defaultData.endDrawerElevation,
        level: DiagnosticLevel.debug));
    properties.add(DoubleProperty('bottomElevation', bottomElevation,
        defaultValue: defaultData.bottomElevation,
        level: DiagnosticLevel.debug));
    //
    // Width properties
    properties.add(DoubleProperty('menuWidth', menuWidth,
        defaultValue: defaultData.menuWidth, level: DiagnosticLevel.debug));
    properties.add(DoubleProperty('railWidth', railWidth,
        defaultValue: defaultData.railWidth, level: DiagnosticLevel.debug));
    properties.add(DoubleProperty('sidebarWidth', sidebarWidth,
        defaultValue: defaultData.sidebarWidth, level: DiagnosticLevel.debug));
    properties.add(DoubleProperty('drawerWidth', drawerWidth,
        defaultValue: defaultData.drawerWidth, level: DiagnosticLevel.debug));
    properties.add(DoubleProperty('endDrawerWidth', endDrawerWidth,
        defaultValue: defaultData.endDrawerWidth,
        level: DiagnosticLevel.debug));
    //
    // Navigation type breakpoints
    properties.add(DoubleProperty('breakpointDrawer', breakpointDrawer,
        defaultValue: defaultData.breakpointDrawer,
        level: DiagnosticLevel.debug));
    properties.add(DoubleProperty('breakpointRail', breakpointRail,
        defaultValue: defaultData.breakpointRail,
        level: DiagnosticLevel.debug));
    properties.add(DoubleProperty('breakpointMenu', breakpointMenu,
        defaultValue: defaultData.breakpointMenu,
        level: DiagnosticLevel.debug));
    properties.add(DoubleProperty('breakpointSidebar', breakpointSidebar,
        defaultValue: defaultData.breakpointSidebar,
        level: DiagnosticLevel.debug));
    //
    // Edge border properties
    properties.add(DiagnosticsProperty<bool>('borderOnMenu', borderOnMenu,
        defaultValue: defaultData.borderOnMenu, level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<bool>('borderOnSidebar', borderOnSidebar,
        defaultValue: defaultData.borderOnSidebar,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<bool>(
        'borderOnDrawerEdgeInDarkMode', borderOnDarkDrawer,
        defaultValue: defaultData.borderOnDarkDrawer,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<bool>(
        'borderOnDrawerEdgeInLightMode', borderOnLightDrawer,
        defaultValue: defaultData.borderOnLightDrawer,
        level: DiagnosticLevel.debug));
    properties.add(ColorProperty('borderColor', borderColor,
        defaultValue: defaultData.borderColor, level: DiagnosticLevel.debug));
    //
    // Menu selection and highlight style
    properties.add(DoubleProperty('menuHighlightHeight', menuHighlightHeight,
        defaultValue: defaultData.menuHighlightHeight,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<EdgeInsetsDirectional>(
        'menuHighlightMargins', menuHighlightMargins,
        defaultValue: defaultData.menuHighlightMargins,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<ShapeBorder>(
        'menuSelectedShape', menuSelectedShape,
        defaultValue: defaultData.menuSelectedShape,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<ShapeBorder>(
        'menuHighlightShape', menuHighlightShape,
        defaultValue: defaultData.menuHighlightShape,
        level: DiagnosticLevel.debug));
    properties.add(ColorProperty('menuHighlightColor', menuHighlightColor,
        defaultValue: defaultData.menuHighlightColor,
        level: DiagnosticLevel.debug));
    //
    // Animation durations and curves for menus and bottom bar animations
    properties.add(DiagnosticsProperty<Duration>(
        'menuAnimationDuration', menuAnimationDuration,
        defaultValue: defaultData.menuAnimationDuration,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<Curve>(
        'menuAnimationCurve', menuAnimationCurve,
        defaultValue: defaultData.menuAnimationCurve,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<Duration>(
        'sidebarAnimationDuration', sidebarAnimationDuration,
        defaultValue: defaultData.sidebarAnimationDuration,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<Curve>(
        'sidebarAnimationCurve', sidebarAnimationCurve,
        defaultValue: defaultData.sidebarAnimationCurve,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<Duration>(
        'bottomBarAnimationDuration', bottomBarAnimationDuration,
        defaultValue: defaultData.bottomBarAnimationDuration,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<Curve>(
        'bottomBarAnimationCurve', bottomBarAnimationCurve,
        defaultValue: defaultData.bottomBarAnimationCurve,
        level: DiagnosticLevel.debug));
    //
    // Bottom navigation bar properties
    properties.add(EnumProperty<FlexfoldBottomBarType>(
        'bottomBarType', bottomType,
        defaultValue: defaultData.bottomType, level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<bool>(
        'bottomBarIsTransparent', bottomIsTransparent,
        defaultValue: defaultData.bottomIsTransparent,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<bool>('bottomBarBlur', bottomBlur,
        defaultValue: defaultData.bottomBlur, level: DiagnosticLevel.debug));
    properties.add(DoubleProperty('bottomBarOpacity', bottomOpacity,
        defaultValue: defaultData.bottomOpacity, level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<bool>(
        'bottomBarHasTopBorder', bottomTopBorder,
        defaultValue: defaultData.bottomTopBorder,
        level: DiagnosticLevel.debug));
    //
    // The icon and text styles of the menu, rail and bottom bar.
    properties.add(DiagnosticsProperty<IconThemeData>(
        'unselectedIconTheme', iconTheme,
        defaultValue: defaultData.iconTheme, level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<IconThemeData>(
        'selectedIconTheme', selectedIconTheme,
        defaultValue: defaultData.selectedIconTheme,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<TextStyle>(
        'unselectedLabelTextStyle', labelTextStyle,
        defaultValue: defaultData.labelTextStyle,
        level: DiagnosticLevel.debug));
    properties.add(DiagnosticsProperty<TextStyle>(
        'selectedLabelTextStyle', selectedLabelTextStyle,
        defaultValue: defaultData.selectedLabelTextStyle,
        level: DiagnosticLevel.debug));
    // The text style for headings above menu label items
    properties.add(DiagnosticsProperty<TextStyle>(
        'headingTextStyle', headingTextStyle,
        defaultValue: defaultData.headingTextStyle,
        level: DiagnosticLevel.debug));
    //
    // Tooltip properties
    properties.add(DiagnosticsProperty<bool>('useTooltips', useTooltips,
        defaultValue: defaultData.useTooltips, level: DiagnosticLevel.debug));
    properties.add(StringProperty('menuOpenTooltipLabel', menuOpenTooltip,
        defaultValue: defaultData.menuOpenTooltip,
        level: DiagnosticLevel.debug));
    properties.add(StringProperty('menuCloseTooltipLabel', menuCloseTooltip,
        defaultValue: defaultData.menuCloseTooltip,
        level: DiagnosticLevel.debug));
    properties.add(StringProperty('menuExpandTooltipLabel', menuExpandTooltip,
        defaultValue: defaultData.menuExpandTooltip,
        level: DiagnosticLevel.debug));
    properties.add(StringProperty(
        'menuExpandHiddenTooltipLabel', menuExpandHiddenTooltip,
        defaultValue: defaultData.menuExpandHiddenTooltip,
        level: DiagnosticLevel.debug));
    properties.add(StringProperty(
        'menuCollapseTooltipLabel', menuCollapseTooltip,
        defaultValue: defaultData.menuCollapseTooltip,
        level: DiagnosticLevel.debug));
    properties.add(StringProperty('sidebarOpenTooltipLabel', sidebarOpenTooltip,
        defaultValue: defaultData.sidebarOpenTooltip,
        level: DiagnosticLevel.debug));
    properties.add(StringProperty(
        'sidebarCloseTooltipLabel', sidebarCloseTooltip,
        defaultValue: defaultData.sidebarCloseTooltip,
        level: DiagnosticLevel.debug));
    properties.add(StringProperty(
        'sidebarExpandTooltipLabel', sidebarExpandTooltip,
        defaultValue: defaultData.sidebarExpandTooltip,
        level: DiagnosticLevel.debug));
    properties.add(StringProperty(
        'sidebarExpandHiddenTooltipLabel', sidebarExpandHiddenTooltip,
        defaultValue: defaultData.sidebarExpandHiddenTooltip,
        level: DiagnosticLevel.debug));
    properties.add(StringProperty(
        'sidebarCollapseTooltipLabel', sidebarCollapseTooltip,
        defaultValue: defaultData.sidebarCollapseTooltip,
        level: DiagnosticLevel.debug));
  }
}
