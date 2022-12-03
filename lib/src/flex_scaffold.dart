import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'flex_app_bar.dart';
import 'flex_bottom_bar.dart';
import 'flex_scaffold_constants.dart';
import 'flexfold_destination.dart';
import 'flexfold_drawer.dart';
import 'flexfold_helpers.dart';
import 'flexfold_menu.dart';
import 'flexfold_menu_button.dart';
import 'flexfold_sidebar.dart';
import 'flexfold_sidebar_button.dart';
import 'flexfold_theme.dart';

// Set to true to observe debug prints. In release mode this compile time
// const always evaluate to false, so in theory anything with only an
// if (_kDebugMe) {} should get tree shaken away totally in a release build.
const bool _kDebugMe = kDebugMode && false;

/// A responsive scaffold that animates changes between navigation modes.
///
/// Responsive behaviors:
/// - Two breakpoints can be defined when drawer and endDrawer will be locked
///   as permanently visible menus.
/// - It can be selected if drawer or endDrawer should use first breakpoint.
/// - Drawers can be kept hidden on large screens, despite passing breakpoints.
/// - Main drawer can be show before end drawer when first breakpoint is
///   triggered.
/// - Elevation of drawers can be adjusted when they are shown (locked).
/// - The width of left and right drawers can be adjusted when used as menus
/// - Includes support for a bottom bar
///
class FlexScaffold extends StatefulWidget {
  /// Default constructor
  const FlexScaffold({
    super.key,
    //
    // The theme of the Flexfold responsive scaffold
    this.flexfoldTheme,
    //
    // The main app bar for the body part of the scaffold
    this.appBar,
    //
    // Destination properties for the menu, rail and bottom navigation bar.
    required this.destinations,
    required this.selectedIndex,
    required this.onDestination,
    // Default to using first module.
    this.activeModule = 0,
    //
    // Enable menu and sidebar toggle.
    this.menuControlEnabled = true,
    this.sidebarControlEnabled = true,
    //
    // Menu content properties, other than the destinations.
    this.menuIcon,
    this.menuIconExpand,
    this.menuIconCollapse,
    this.menuIconExpandHidden,
    this.menuAppBar,
    this.menuLeading,
    this.menuTrailing,
    this.menuFooter,
    //
    // Menu state properties and its callbacks.
    this.hideMenu = false,
    this.onHideMenu,
    this.cycleViaDrawer = true,
    this.preferRail = false,
    this.onPreferRail,
    //
    // Sidebar and end drawer properties and its callback.
    this.sidebarIcon,
    this.sidebarIconExpand,
    this.sidebarIconExpandHidden,
    this.sidebarIconCollapse,
    this.sidebarAppBar,
    this.sidebar,
    this.hideSidebar = false,
    this.onHideSidebar,
    this.sidebarBelongsToBody = false,
    //
    // Bottom navigation bar properties.
    this.scrollHiddenBottomBar = false,
    this.hideBottomBar = false,
    this.showBottomBarWhenMenuInDrawer = false,
    this.showBottomBarWhenMenuShown = false,
    this.bottomDestinationsInDrawer = false,
    //
    // Floating action button properties.
    this.floatingActionButton,
    this.floatingActionButtonLocationPhone,
    this.floatingActionButtonLocationTablet,
    this.floatingActionButtonLocationDesktop,
    //
    // Body properties.
    this.extendBody = true,
    this.extendBodyBehindAppBar = true,
    //
    // The actual content that will be in the Flexfold scaffold body.
    this.body,
    //
  }) : assert(
            destinations.length >= 2, 'There must be at least 2 destinations');

  /// The theme for the [FlexScaffold] scaffold.
  ///
  /// The theme contains a large number of style and other properties that
  /// can be modified modify to customize the look of the [FlexScaffold]
  /// responsive scaffold. See [FlexfoldThemeData] for more details.
  ///
  /// Changes to passed in theme's properties are animated. Changes to a
  /// FlexfoldTheme higher up in the widget tree that Flexfold inherits it theme
  /// from will also animate the properties in Flexfold that depends on the
  /// inherited theme data. The passed in theme is merged with any inherited
  /// theme.
  final FlexfoldThemeData? flexfoldTheme;

  /// The appbar for the main scaffold body.
  ///
  /// [FlexScaffold] does not use a standard [AppBar] widget directly, it needs
  /// to inject some functionality into an AppBar and use a data class as an
  /// interface from which the actual app bar is created with the
  /// [FlexAppBar.toAppBar] method.
  /// The [FlexAppBar] has all the same properties as the [AppBar] class
  /// but none of its methods or functionality, it just holds the data needed
  /// to create an app bar.
  final FlexAppBar? appBar;

  /// Defines the appearance of the navigation button items that are listed in
  /// the drawer, rail, menu and bottom bar.
  ///
  /// The value must be a list of two or more [FlexfoldDestination] values.
  final List<FlexfoldDestination> destinations;

  /// The index into [destinations] for the current selected
  /// [FlexfoldDestination].
  final int selectedIndex;

  /// Callback called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the navigation rail needs to keep
  /// track of the index of the selected [FlexfoldDestination] and call
  /// `setState` to rebuild the menu, drawer, rail or bottom bar
  /// with the new [selectedIndex].
  final ValueChanged<FlexfoldDestinationData> onDestination;

  // TODO(rydmike): Implement modules!
  //
  // Consider using a list of destinations, which is List<FlexfoldDestination>,
  // We should then store last used index per module.

  /// Set the active module for the destinations.
  ///
  /// A small app usually has only one module and you can omit this property.
  ///
  /// If you want to create the appearance of your app having multiple modules
  /// with different navigators, you can can give your destinations module
  /// numbers. Destinations with the same module number appear in the same
  /// navigation drawer, menu, rail or bottom navigation, depending on
  /// current layout.
  ///
  /// FlexFold provides the method setModule(module), to change the active
  /// module and swap out the displayed navigation destinations to the
  /// destinations in the selected module.
  ///
  /// Destinations in different modules can used the same named route and via
  /// that provide access to shared destinations (pages).
  ///
  /// The active module number, defaults to 0.
  final int activeModule;

  /// The menu mode can be manually controlled by the user when true.
  ///
  /// If set to false, then the menu can only be opened when it is a drawer,
  /// it cannot be toggled between rail/menu and drawer manually when the
  /// breakpoint constraints would otherwise allow that. This means the user
  /// cannot hide the side menu or the rail, when rail or side navigation mode
  /// is triggered. You can still control it via the API, there just is no
  /// user control over.
  ///
  /// Defaults to true so users can toggle the menu and rail visibility as they
  /// prefer on a large canvas.
  final bool menuControlEnabled;

  /// The sidebar menu mode can be manually controlled by the user when true.
  ///
  /// If set to false, then the menu can only be opened when it is a drawer,
  /// it cannot be toggled between rail/menu and drawer manually when the
  /// breakpoint constraints would otherwise allow that. This means the user
  /// cannot hide the side menu or the rail, when rail or side navigation mode
  /// is triggered. You can still control it via the API, there just is no
  /// user control over.
  ///
  /// Defaults to true so users can toggle the menu and rail visibility as they
  /// prefer on a large canvas.
  final bool sidebarControlEnabled;

  /// A Widget used to open the menu, typically an [Icon] widget is used.
  ///
  /// The same icon will also be used on the AppBar when the menu or rail is
  /// hidden in a drawer. If no icon is provided it defaults to a widget with
  /// value [kFlexfoldMenuIcon].
  final Widget? menuIcon;

  /// A widget used to expand the drawer to a menu from an opened drawer,
  /// typically an [Icon] widget is used.
  ///
  /// If no icon is provided it defaults to a widget with value
  /// [kFlexfoldMenuIconExpand].
  final Widget? menuIconExpand;

  /// A widget used to expand the drawer to a menu when the rail/menu is
  /// hidden but may be expanded based on screen width and breakpoints.
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided it defaults to a widget with value
  /// [kFlexfoldMenuIconExpandHidden].
  final Widget? menuIconExpandHidden;

  /// A widget used to expand the drawer to a menu, typically an [Icon]
  /// widget is used.
  ///
  /// If no icon is provided it defaults to a widget with value
  /// [kFlexfoldMenuIconCollapse].
  final Widget? menuIconCollapse;

  /// Appbar for the menu when used on the drawer, rail and side menu.
  ///
  /// The menu has an appbar on top of it too. It always gets an automatic
  /// leading button to show and collapse it. You can also create actions for
  /// the menu app bar, but beware that there is not a lot of space and
  /// actions are not reachable in rail mode. There is also not so much
  /// space in the title, but you can usually fit a small brand/logo on it.
  final FlexAppBar? menuAppBar;

  /// A widget that appears below the menubar but above the menu items.
  ///
  /// It is placed at the top of the menu, but after the menu bar and above the
  /// [destinations].
  /// This could be an action button like a [FloatingActionButton], but may
  /// also be a non-button, such as a user profile image, bigger company logo,
  /// etc. It needs to fit and look good both in rail and side menu mode.
  ///
  /// The default value is null.
  final Widget? menuLeading;

  /// Trailing menu widget that is placed below the last [FlexfoldDestination].
  ///
  /// It needs to fit and look good both in rail and side menu mode.
  /// The default value is null.
  final Widget? menuTrailing;

  /// A widget that appears at the bottom of the menu. This widget is glued
  /// to the bottom, like the the menu app bar it does not scroll.
  ///
  /// The menu footer needs to fit and look good both in rail and side menu
  /// mode.
  final Widget? menuFooter;

  /// Keep main menu hidden in a drawer, even when its breakpoints are exceeded.
  ///
  /// When true, both the rail and menu will be kept hidden in the drawer, even
  /// if the breakpoint for rail or breakpoint for menu have both been exceeded.
  final bool hideMenu;

  /// Callback that is called when [hideMenu] changes.
  ///
  /// This callback together with its sett [hideMenu] can be used if you
  /// want to control hiding and showing the menu from an external control,
  /// like a user controlled [Switch].
  final ValueChanged<bool>? onHideMenu;

  /// Cycle via drawer menu when opening a hidden menu.
  ///
  /// When the menu may be shown as locked on screen, as a rail or menu, and
  /// we expand it again, it first cycles via the drawer menu option if true.
  /// If set to false it skips the cycle via the drawer and expands it directly
  /// to a rail or side menu, depending on current screen width and if it is
  /// larger than the breakpoint for menu or not. If screen width is below rail
  /// breakpoint this setting has no effect, the only way to show the menu is
  /// as a drawer, so the drawer will be opened.
  final bool cycleViaDrawer;

  /// Prefer rail menu.
  ///
  /// When the menu is locked on screen and it is shown, it will remain as a
  /// rail even if the menu breakpoint is exceeded and it should be shown as a
  /// menu based on set breakpoint value.
  final bool preferRail;

  /// Callback that is called when prefer rail changes.
  ///
  /// Can be used to control and preferRail, via a toggle Switch externally.
  final ValueChanged<bool>? onPreferRail;

  /// A Widget used to open the sidebar menu, typically an [Icon] is used.
  ///
  /// The same icon will also be used on the sidebar menu when the sidebar is
  /// hidden in an end drawer. If no icon is provided it defaults to an
  /// Icon with value [kFlexfoldSidebarIcon].
  final Widget? sidebarIcon;

  /// A Widget used to expand the end drawer to a sidebar, typically a [Icon]
  /// widget is used.
  ///
  /// If no icon is provided it defaults to a widget with value
  /// [kFlexfoldSidebarIconExpand].
  final Widget? sidebarIconExpand;

  /// A widget used to expand the sidebar menu it is hidden but may be
  /// expanded based on screen width and breakpoints.
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided it defaults to a widget with value
  /// [kFlexfoldMenuIconExpandHidden].
  final Widget? sidebarIconExpandHidden;

  /// A Widget used to collapse the sidebar, typically an [Icon]
  /// widget is used.
  ///
  /// If no icon is provided it defaults to a widget with value
  /// [kFlexfoldSidebarIconCollapse].
  final Widget? sidebarIconCollapse;

  /// The appbar for the end drawer and sidebar.
  ///
  /// The side drawer has an appbar in it too. It always gets an automatic
  /// action button to control its appearance and hiding it. There is no
  /// automatic leading button action for it, but you can still create one
  /// manually as well as adding additional actions to it.
  final FlexAppBar? sidebarAppBar;

  /// The end drawer and sidebar, often used as a tools menu.
  final Widget? sidebar;

  /// Keep sidebar hidden in an end drawer, even when its breakpoint is
  /// exceeded.
  final bool hideSidebar;

  /// Callback that is called when [hideSidebar] changes
  final ValueChanged<bool>? onHideSidebar;

  /// When sidebar belongs to the body, it is a vertical end column made in a
  /// row item after the body content.
  ///
  /// This is the default Material design based on the illustration here:
  /// https://material.io/design/layout/responsive-layout-grid.html#ui-regions
  /// Where the app bar stretches over the end drawer that is visible as a
  /// sidebar. An alternative way to display the sidebar as a permanent fixture
  /// is to have it at the same level as app bar, then the design has 3 vertical
  /// columns in one row: menu, appbar with body in same column under it and the
  /// sidebar.
  ///
  /// By default sidebar belongs [sidebarBelongsToBody] = false.
  /// This is an opinionated Flexfold default, it works better if a
  /// bottom navigation bar is used with a sidebar and it also keeps the Flutter
  /// standard FAB locations correctly positioned when the sidebar is visible
  /// as its width is excluded from the positioning when the sidebar is outside
  /// the scaffold body.
  final bool sidebarBelongsToBody;

  /// Use a scrollController to control bottom bar visibility.
  ///
  /// When bottom bar is otherwise visible, if you use a scroll controller and
  /// add listeners to it and set this to true when scrolling down (reverse)
  /// and to false when scrolling up (forward) the bottom navigation will
  /// animate away when you scroll down and animate visible again when you
  /// scroll up.
  ///
  /// Defaults to false, and will be false by default after Flexfold
  /// changes to a new destination, thus the bottom navigation bar will never
  /// be hidden by default due to scrolling, upon entry to a screen. See the
  /// example for more information on how to use this in an application.
  ///
  /// The internal mechanism that controls the hiding and showing of the bottom
  /// navigation bar is actually the same as [hideBottomBar], it is just an
  /// or term on it that is set back to false automatically when you enter a
  /// new screen.
  final bool scrollHiddenBottomBar;

  /// Should the bottom bar be displayed or not?
  ///
  /// Defaults to false, if set to true the bottom navigation bar will not be
  /// shown in bottom navigation mode. Navigation will only be possible via the
  /// drawer menu in a phone sized app.
  final bool hideBottomBar;

  /// Set it to true if bottom bar destinations should be shown as soon as the
  /// menu is hidden in the drawer.
  ///
  /// By default this is false. Normally the bottom navigation bar is not shown
  /// until width is below the breakpoint for showing the bottom navigation
  /// bar. If you set this to true, it will be shown also if the menu and rail
  /// is toggled to be hidden.
  final bool showBottomBarWhenMenuInDrawer;

  /// Set to true if bottom bar should also be shown when the menu is visible.
  ///
  /// This defaults to false. Normally you do not want to see or use the bottom
  /// bar when the rail or menu is shown, if you enable this property it
  /// will however be shown. Use with care, as this can be confusing for users.
  /// It is mainly a toggle to use during testing and development. This feature
  /// can potentially also be used as an accessibility feature.
  final bool showBottomBarWhenMenuShown;

  /// Set it to true if bottom bar destinations should also be included in the
  /// drawer when the bottom navigation mode is being used.
  ///
  /// By default this is false. Normally the bottom destinations are not shown
  /// in the drawer when you are in bottom navigation mode and open the drawer
  /// it only contain none bottom navigation bar items. If you set it to true
  /// the bottom destinations will always be shown in the drawer.
  final bool bottomDestinationsInDrawer;

  /// Floating action button widget for the layout.
  final FloatingActionButton? floatingActionButton;

  // TODO(rydmike): Review nullable or non nullable on the next 3.
  /// Location of the floating action button for phone layout
  ///
  /// Defaults to [FloatingActionButtonLocation.endFloat] if null.
  final FloatingActionButtonLocation? floatingActionButtonLocationPhone;

  /// Location of the floating action button for tablet layout
  ///
  /// Defaults to [FloatingActionButtonLocation.centerFloat] if null.
  final FloatingActionButtonLocation? floatingActionButtonLocationTablet;

  /// Location of the floating action button for desktop layout
  ///
  /// Defaults to [FloatingActionButtonLocation.startFloat] if null.
  final FloatingActionButtonLocation? floatingActionButtonLocationDesktop;

  /// Set to true to extend the body behind bottom bar.
  ///
  /// This is the same property as on standard Scaffold.
  final bool extendBody;

  /// Set to true to extend the body behind the appbar.
  ///
  /// This is the same property as on standard Scaffold.
  final bool extendBodyBehindAppBar;

  /// The body of the scaffold
  ///
  /// The content widget for the Flexfold scaffold screen.
  final Widget? body;

  @override
  State<FlexScaffold> createState() => _FlexScaffoldState();
}

class _FlexScaffoldState extends State<FlexScaffold> {
  // State that might be changed via widget
  late int selectedIndex;
  final FlexfoldIndexTracker indexMenu = FlexfoldIndexTracker();
  final FlexfoldIndexTracker indexBottom = FlexfoldIndexTracker();
  late FlexfoldDestination target;
  late bool hideMenu;
  late bool hideSidebar;
  late bool preferRail;
  late bool isBottomTarget;
  late bool scrollHiddenBottomBar;

  // Local state
  late bool isPhone;
  late bool isPhoneLandscape;
  late bool isTablet;
  late bool isDesktop;
  late bool isMenuInDrawer;
  late bool isMenuInMenu;
  late bool isSidebarInEndDrawer;
  late bool isSidebarInMenu;
  late bool isBottomBarVisible;
  late bool showBottomDestinationsInDrawer;
  late Orientation currentOrientation;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
    indexMenu.setIndex(widget.selectedIndex);
    target = widget.destinations[indexMenu.index];
    final int? bottomIndex =
        FlexfoldDestination.toBottomIndex(target, widget.destinations);
    // TODO(rydmike): This must work when called with null!
    indexBottom.setIndex(bottomIndex);
    isBottomTarget = bottomIndex != null;
    hideMenu = widget.hideMenu;
    hideSidebar = widget.hideSidebar;
    preferRail = widget.preferRail;
    scrollHiddenBottomBar = widget.scrollHiddenBottomBar;
    // TODO(rydmike): Changing orientation with drawer open may break it! Fix?
    // currentOrientation = MediaQuery.of(context).orientation;
  }

  @override
  void didUpdateWidget(FlexScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
      indexMenu.setIndex(widget.selectedIndex);
      target = widget.destinations[indexMenu.index];
      final int? bottomIndex =
          FlexfoldDestination.toBottomIndex(target, widget.destinations);
      indexBottom.setIndex(bottomIndex);
      isBottomTarget = bottomIndex != null;
    }
    if (widget.hideMenu != oldWidget.hideMenu) {
      hideMenu = widget.hideMenu;
    }
    if (widget.hideSidebar != oldWidget.hideSidebar) {
      hideSidebar = widget.hideSidebar;
    }
    if (widget.preferRail != oldWidget.preferRail) {
      preferRail = widget.preferRail;
    }
    if (widget.scrollHiddenBottomBar != oldWidget.scrollHiddenBottomBar) {
      scrollHiddenBottomBar = widget.scrollHiddenBottomBar;
    }
  }

  @override
  Widget build(BuildContext context) {
    // The passed in theme widget and its BottomNavigationBarThemeData have
    // highest priority and its properties will be used first when not null.
    final BottomNavigationBarThemeData? bottomWidget =
        widget.flexfoldTheme?.bottomNavigationBarTheme;
    // The closest inherited Flexfold Theme has the 2nd highest prio for
    // effective theme data.
    final FlexfoldThemeData flexTheme = FlexfoldTheme.of(context);
    // Get its bottom navigation bar theme
    final BottomNavigationBarThemeData? bottomFlex =
        flexTheme.bottomNavigationBarTheme;
    // The bottom navigation bar may as a 3rd prio option also get theme data
    // from an inherited BottomNavigationBarTheme.
    final BottomNavigationBarThemeData bottomBar =
        BottomNavigationBarTheme.of(context);
    // Get the main surrounding theme
    final ThemeData theme = Theme.of(context);
    // As 4th and last option the bottom navigation bar may get theme data
    // from the bottomNavigationBarTheme property in overall inherited Theme.
    final BottomNavigationBarThemeData bottomTheme =
        theme.bottomNavigationBarTheme;
    // Merge all bottom themes, we use the lowest prio as base, which is the
    // bottomNavigationBarTheme from Theme.of(context) stored in [bottomTheme].
    // Then we use any none null property value from highest to lowest priority
    // from:
    // 1. widget.theme.bottomNavigationBarTheme stored in bottomWidget
    // 2. FlexfoldTheme.of(context).bottomNavigationBarTheme in bottomFlex
    // 3. BottomNavigationBarTheme.of(context) stored in bottomBar
    // 4. If appropriate, fallbacks from property values in Theme.of(context)
    // 5. Last some hard coded default fallback values as defined for
    // FlexfoldTheme. See [FlexfoldTheme] for details on default values.
    final BottomNavigationBarThemeData effectiveBottomTheme =
        bottomTheme.copyWith(
      // IMPORTANT: Bottom nav background in FlexFoldTheme may still be null
      // after this. Need to check still in flex bottom widgets!
      backgroundColor: bottomWidget?.backgroundColor ??
          bottomFlex?.backgroundColor ??
          bottomBar.backgroundColor,
      elevation: bottomWidget?.elevation ??
          bottomFlex?.elevation ??
          bottomBar.elevation ??
          0,
      selectedIconTheme: bottomWidget?.selectedIconTheme ??
          bottomFlex?.selectedIconTheme ??
          bottomBar.selectedIconTheme ??
          IconThemeData(color: theme.colorScheme.primary),
      unselectedIconTheme: bottomWidget?.unselectedIconTheme ??
          bottomFlex?.unselectedIconTheme ??
          bottomBar.unselectedIconTheme,
      selectedItemColor: bottomWidget?.selectedItemColor ??
          bottomFlex?.selectedItemColor ??
          bottomBar.selectedItemColor ??
          theme.colorScheme.primary,
      unselectedItemColor: bottomWidget?.unselectedItemColor ??
          bottomFlex?.unselectedItemColor ??
          bottomBar.unselectedItemColor,
      selectedLabelStyle: bottomWidget?.selectedLabelStyle ??
          bottomFlex?.selectedLabelStyle ??
          bottomBar.selectedLabelStyle ??
          theme.primaryTextTheme.bodyText2!
              .copyWith(color: theme.colorScheme.primary),
      unselectedLabelStyle: bottomWidget?.unselectedLabelStyle ??
          bottomFlex?.unselectedLabelStyle ??
          bottomBar.unselectedLabelStyle,
      showSelectedLabels: bottomWidget?.showSelectedLabels ??
          bottomFlex?.showSelectedLabels ??
          bottomBar.showSelectedLabels ??
          true,
      showUnselectedLabels: bottomWidget?.showUnselectedLabels ??
          bottomFlex?.showUnselectedLabels ??
          bottomBar.showUnselectedLabels ??
          true,
      type: bottomWidget?.type ??
          bottomFlex?.type ??
          bottomBar.type ??
          BottomNavigationBarType.fixed,
    );

    // Get Flexfold default theme data
    final FlexfoldThemeData defaultFlexTheme =
        const FlexfoldThemeData().withDefaults(context);

    // Merge the other sub-themes than the Bottom navigation bar with
    // the default values, first merge the inherited Flexfold sub theme
    // values and then the sub theme values passed in via widget.theme
    final TextStyle effectiveUnselectedLabelStyle = defaultFlexTheme
        .unselectedLabelTextStyle!
        .merge(flexTheme.unselectedLabelTextStyle)
        .merge(widget.flexfoldTheme!.unselectedLabelTextStyle);

    final TextStyle effectiveSelectedLabelStyle = defaultFlexTheme
        .selectedLabelTextStyle!
        .merge(flexTheme.selectedLabelTextStyle)
        .merge(widget.flexfoldTheme!.selectedLabelTextStyle);

    final IconThemeData effectiveUnselectedIconTheme = defaultFlexTheme
        .unselectedIconTheme!
        .merge(flexTheme.unselectedIconTheme)
        .merge(widget.flexfoldTheme!.unselectedIconTheme);

    final IconThemeData effectiveSelectedIconTheme = defaultFlexTheme
        .selectedIconTheme!
        .merge(flexTheme.selectedIconTheme)
        .merge(widget.flexfoldTheme!.selectedIconTheme);

    final TextStyle effectiveHeadingTextStyle = defaultFlexTheme
        .headingTextStyle!
        .merge(flexTheme.headingTextStyle)
        .merge(widget.flexfoldTheme!.headingTextStyle);

    // Merge the inherited Flexfold theme with the default Flexfold theme.
    final FlexfoldThemeData flexThemeMerged = defaultFlexTheme.merge(flexTheme);

    // Then merge widget passed in theme, with the above merge theme.
    final FlexfoldThemeData fullFlexTheme =
        flexThemeMerged.merge(widget.flexfoldTheme);

    // Then the fully merged Flexfold theme gets a copy of all the effective
    // effective sub themes it contains, meaning the bottomNavigationBarTheme
    // and all effective text styles and icon themes.
    // This creates a theme that has all the ambient Flexfold theme data
    // and defaults as fallback, in a single summarized merged theme.
    final FlexfoldThemeData effectiveFlexTheme = fullFlexTheme.copyWith(
      bottomNavigationBarTheme: effectiveBottomTheme,
      unselectedLabelTextStyle: effectiveUnselectedLabelStyle,
      selectedLabelTextStyle: effectiveSelectedLabelStyle,
      unselectedIconTheme: effectiveUnselectedIconTheme,
      selectedIconTheme: effectiveSelectedIconTheme,
      headingTextStyle: effectiveHeadingTextStyle,
    );

    // Then make an animated FlexfoldTheme of the final effective theme.
    return AnimatedFlexfoldTheme(
      data: effectiveFlexTheme,
      child: Builder(builder: (BuildContext context) {
        // We a use builder to ensure we have the fully merged FlexfoldTheme
        // next up in the Widget tree, that now also has all the default
        // values. By doing this we do not have to apply any defaults again in
        // the entire Flexfold widget tree and its descendants. They are now
        // guaranteed to with 'FlexfoldTheme.of(context)' get a theme
        // that has been fully merged with provided values in the property
        // passing and inheritance priority order we defined.
        //
        // The only values that may still be null after this merge are:
        // * FlexfoldTheme.menuBackgroundColor
        // * FlexfoldTheme.sidebar.BackgroundColor
        // * FlexfoldTheme.bottomNavigationBarTheme.backgroundColor
        //
        // This makes accessing the correct theme result further down the
        // widget tree easier, since we can always get it like this now:
        final FlexfoldThemeData flexTheme = FlexfoldTheme.of(context);

        // Get media width, height, and safe area padding
        assert(debugCheckHasMediaQuery(context),
            'A valid build context is required for the MediaQuery.');
        final MediaQueryData mediaData = MediaQuery.of(context);
        final double leftPadding = mediaData.padding.left;
        final double rightPadding = mediaData.padding.right;
        final double startPadding =
            Directionality.of(context) == TextDirection.ltr
                ? leftPadding
                : rightPadding;
        final double width = mediaData.size.width;
        final double height = mediaData.size.height;

        // Based on width and breakpoint limit, this is a phone sized layout.
        isPhone = width < flexTheme.breakpointRail!;
        // Based on height and breakpoint, this is a phone landscape layout.
        isPhoneLandscape = height < flexTheme.breakpointDrawer!;
        // Based on width and breakpoint limit, this is a desktop sized layout.
        isDesktop = (width >= flexTheme.breakpointMenu!) && !isPhoneLandscape;
        // The menu will exist as a Drawer widget in the widget tree.
        isMenuInDrawer = isPhone || widget.hideMenu || isPhoneLandscape;
        // The menu is shown as a full sized menu before the body.
        isMenuInMenu = isDesktop && !widget.hideMenu && !widget.preferRail;
        // The sidebar will exist in an end Drawer widget in the widget tree.
        isSidebarInEndDrawer =
            (width < flexTheme.breakpointSidebar! || widget.hideSidebar) &&
                widget.destinations[selectedIndex].hasSidebar &&
                widget.sidebar != null;
        // The sidebar is shown as a widget after the body.
        isSidebarInMenu = width >= flexTheme.breakpointSidebar! &&
            !widget.hideSidebar &&
            widget.destinations[selectedIndex].hasSidebar &&
            widget.sidebar != null;
        // The bottom navigation bar is visible.
        // Tricky logic here, many config options leads to stuff like this.
        isBottomBarVisible = !(widget.hideBottomBar || scrollHiddenBottomBar) &&
            (isPhone ||
                widget.showBottomBarWhenMenuShown ||
                (widget.showBottomBarWhenMenuInDrawer && isMenuInDrawer));
        // The bottom destinations are to be shown and included in the drawer.
        // Again nasty logic, caused by many options and possibilities
        showBottomDestinationsInDrawer = widget.bottomDestinationsInDrawer ||
            !isBottomTarget ||
            widget.hideBottomBar ||
            (!isPhone &&
                (!widget.showBottomBarWhenMenuInDrawer &&
                    !widget.showBottomBarWhenMenuShown));
        // Set location of floating action button (FAB) depending on media
        // size, use default locations if null.
        final FloatingActionButtonLocation effectiveFabLocation = isPhone
            // FAB on phone size
            ? widget.floatingActionButtonLocationPhone ??
                // Default uses end float location, the official standard.
                FloatingActionButtonLocation.endFloat
            : isDesktop
                ? widget.floatingActionButtonLocationDesktop ??
                    // Material default position would be startTop at desktop
                    // size, or possibly also endTop, but the FAB gets in the in
                    // way those locations sometimes so we use centerFloat as
                    // default
                    FloatingActionButtonLocation.centerFloat
                // It is tablet then ...
                : widget.floatingActionButtonLocationTablet ??
                    // Default should be start top, but that is in the way again
                    // we use startFloat, it works well with rail navigation.
                    FloatingActionButtonLocation.startFloat;
        //
        // Build the actual Flexfold content
        return Row(
          children: <Widget>[
            //
            // Main menu, when the menu is shown as a fixed menu
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: flexTheme.menuWidth! + startPadding),
              child: Material(
                color: flexTheme.menuBackgroundColor,
                elevation: flexTheme.menuElevation!,
                child: _buildMenu(context),
              ),
            ),
            //
            // Main part is an Expanded that contains a standard Scaffold.
            Expanded(
              child: Scaffold(
                key: widget.key,
                //
                extendBody: widget.extendBody,
                extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
                //
                // Build the app bar with leading and actions buttons, but only
                // if the destination has an app bar.
                appBar: widget.destinations[selectedIndex].hasAppBar
                    ? _buildMainAppBar(context)
                    : null,
                //
                // The menu when used as a drawer.
                drawer: isMenuInDrawer
                    ? FlexfoldDrawer(
                        elevation: flexTheme.drawerElevation!,
                        drawerWidth: flexTheme.drawerWidth! + startPadding,
                        currentScreenWidth: width,
                        backgroundColor: flexTheme.menuBackgroundColor,
                        child: _buildMenu(context),
                      )
                    : null,
                //
                // The end drawer, ie tools menu when used as an end drawer.
                endDrawer: isSidebarInEndDrawer
                    ? FlexfoldDrawer(
                        elevation: flexTheme.endDrawerElevation!,
                        drawerWidth: flexTheme.endDrawerWidth!,
                        currentScreenWidth: width,
                        backgroundColor: flexTheme.sidebarBackgroundColor,
                        child: FlexfoldSidebar(
                          sidebarIcon: widget.sidebarIcon,
                          sidebarIconExpand: widget.sidebarIconExpand,
                          sidebarIconExpandHidden:
                              widget.sidebarIconExpandHidden,
                          sidebarIconCollapse: widget.sidebarIconCollapse,
                          sidebarToggleEnabled: widget.sidebarControlEnabled,
                          // If no sidebar app bar given make a default one.
                          sidebarAppBar:
                              widget.sidebarAppBar ?? const FlexAppBar(),
                          cycleViaDrawer: widget.cycleViaDrawer,
                          hideSidebar: widget.hideSidebar,
                          onHideSidebar: (bool value) {
                            setState(() {
                              hideSidebar = value;
                              if (widget.onHideSidebar != null) {
                                widget.onHideSidebar?.call(hideSidebar);
                              }
                            });
                            if (_kDebugMe) {
                              debugPrint(
                                  'Flexfold() onHideSidebar: $hideSidebar');
                            }
                          },
                          sidebarBelongsToBody: widget.sidebarBelongsToBody,
                          hasAppBar:
                              widget.destinations[selectedIndex].hasAppBar,
                          child: widget.sidebar,
                        ),
                      )
                    : null,
                //
                // The bottom navigation bar
                bottomNavigationBar: _buildBottomBar(context),
                //
                // Floating action button in its effective location.
                floatingActionButton:
                    widget.destinations[selectedIndex].hasFloatingActionButton
                        ? widget.floatingActionButton
                        : null,
                floatingActionButtonLocation: effectiveFabLocation,
                //
                // Build the actual content in a Row.
                body: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: widget.body ?? Container(),
                    ),
                    //
                    // The Sidebar when shown as a fixed item and it belongs
                    // to the body. Material default sidebar layout.
                    if (widget.destinations[selectedIndex].hasSidebar &&
                        widget.sidebar != null &&
                        widget.sidebarBelongsToBody)
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: flexTheme.sidebarWidth!),
                        child: Material(
                          color: flexTheme.sidebarBackgroundColor,
                          elevation: flexTheme.sidebarElevation!,
                          child: FlexfoldSidebar(
                            sidebarIcon: widget.sidebarIcon,
                            sidebarIconExpand: widget.sidebarIconExpand,
                            sidebarIconExpandHidden:
                                widget.sidebarIconExpandHidden,
                            sidebarIconCollapse: widget.sidebarIconCollapse,
                            sidebarToggleEnabled: widget.sidebarControlEnabled,
                            // If no sidebar app bar given make a default one.
                            sidebarAppBar:
                                widget.sidebarAppBar ?? const FlexAppBar(),
                            cycleViaDrawer: widget.cycleViaDrawer,
                            hideSidebar: widget.hideSidebar,
                            onHideSidebar: (bool value) {
                              setState(() {
                                hideSidebar = value;
                                if (widget.onHideSidebar != null) {
                                  widget.onHideSidebar?.call(hideSidebar);
                                }
                              });
                              if (_kDebugMe) {
                                debugPrint(
                                    'Flexfold() onHideSidebar: $hideSidebar');
                              }
                            },
                            sidebarBelongsToBody: widget.sidebarBelongsToBody,
                            hasAppBar:
                                widget.destinations[selectedIndex].hasAppBar,
                            child: widget.sidebar,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Sidebar may also be in the Row. This happens when it is shown as
            // a fixed sidebar on the screen and it does not "belong to the
            // body", then it is on the same level as the menu. The default
            // Material design is one that it is a part of the body, but this
            // works better if we also show a bottom navigation bar together
            // with the sidebar and it works better with the built-in
            // FAB locations.
            if (widget.destinations[selectedIndex].hasSidebar &&
                widget.sidebar != null &&
                !widget.sidebarBelongsToBody)
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: flexTheme.sidebarWidth!),
                child: Material(
                  color: flexTheme.sidebarBackgroundColor,
                  elevation: flexTheme.sidebarElevation!,
                  child: FlexfoldSidebar(
                    sidebarIcon: widget.sidebarIcon,
                    sidebarIconExpand: widget.sidebarIconExpand,
                    sidebarIconExpandHidden: widget.sidebarIconExpandHidden,
                    sidebarIconCollapse: widget.sidebarIconCollapse,
                    sidebarToggleEnabled: widget.sidebarControlEnabled,
                    // If no sidebar app bar is provided we make a default one.
                    sidebarAppBar: widget.sidebarAppBar ?? const FlexAppBar(),
                    cycleViaDrawer: widget.cycleViaDrawer,
                    hideSidebar: widget.hideSidebar,
                    onHideSidebar: (bool value) {
                      setState(() {
                        hideSidebar = value;
                        if (widget.onHideSidebar != null) {
                          widget.onHideSidebar?.call(hideSidebar);
                        }
                      });
                      if (_kDebugMe) {
                        debugPrint('Flexfold() onHideSidebar: $hideSidebar');
                      }
                    },
                    sidebarBelongsToBody: widget.sidebarBelongsToBody,
                    hasAppBar: widget.destinations[selectedIndex].hasAppBar,
                    child: widget.sidebar,
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

// ****************************************************************************
// Build the widgets for the Flexfold scaffold
// ****************************************************************************

  PreferredSizeWidget _buildMainAppBar(BuildContext context) {
    // If no FlexfoldAppBar was given we make a default one
    final FlexAppBar appbar = widget.appBar ?? const FlexAppBar();
    assert(
        appbar.leading == null,
        'The main app bar in Flexfold cannot have a leading widget '
        'just leave it as null, it will get one assigned automatically. '
        'You can assign it an icon widget separately but its onTap event '
        'handler will be added by Flexfold.');
    // Convert the main FlexfoldAppBar data object to a real AppBar.
    return appbar.toAppBar(
      automaticallyImplyLeading: false,
      // Only add the menu button on the main app bar if menu is in a drawer.
      leading: isMenuInDrawer
          ? FlexfoldMenuButton(
              menuIcon: widget.menuIcon,
              menuIconExpand: widget.menuIconExpand,
              menuIconExpandHidden: widget.menuIconExpandHidden,
              menuIconCollapse: widget.menuIconCollapse,
              isHidden: hideMenu,
              cycleViaDrawer: widget.cycleViaDrawer,
              isRail: preferRail,
              setMenuHidden: (bool value) {
                setState(() {
                  hideMenu = value;
                  if (widget.onHideMenu != null) widget.onHideMenu?.call(value);
                  if (_kDebugMe) {
                    debugPrint('Flexfold(): onHideMenu: $hideMenu');
                  }
                });
              },
              setPreferRail: (bool value) {
                setState(() {
                  preferRail = value;
                  if (widget.onPreferRail != null) {
                    widget.onPreferRail?.call(value);
                  }
                  if (_kDebugMe) {
                    debugPrint('Flexfold(): onPreferRail: $preferRail');
                  }
                });
              },
            )
          : null,
      actions: <Widget>[
        // Insert any pre-existing actions
        ...?widget.appBar?.actions, // TODO(rydmike): Is this safe?
        // In order to not get a default shown end drawer button in the
        // appbar for the sidebar when it is shown as a drawer, we need to
        // insert an invisible widget into the actions list in case it is
        // empty, because if it is totally empty the framework will create
        // a default action button to show the menu, we do not want that.
        const SizedBox.shrink(),
        // Then we insert the sidebar menu button
        if (isSidebarInEndDrawer ||
            (isSidebarInMenu &&
                widget.sidebarBelongsToBody &&
                widget.sidebarControlEnabled))
          FlexfoldSidebarButton(
            menuIcon: widget.sidebarIcon,
            menuIconExpand: widget.sidebarIconExpand,
            menuIconExpandHidden: widget.sidebarIconExpandHidden,
            menuIconCollapse: widget.sidebarIconCollapse,
            cycleViaDrawer: widget.cycleViaDrawer,
            isHidden: hideSidebar,
            setMenuHidden: (bool value) {
              setState(() {
                hideSidebar = value;
                if (widget.onHideSidebar != null) {
                  widget.onHideSidebar?.call(value);
                }
                if (_kDebugMe) {
                  debugPrint('Flexfold(): setMenuHidden: $hideSidebar');
                }
              });
            },
          ),
      ],
    );
  }

  // Widget _buildSidebar(BuildContext context) {
  //   return FlexfoldSidebar(
  //     sidebarIcon: widget.sidebarIcon,
  //     sidebarIconExpand: widget.sidebarIconExpand,
  //     sidebarIconExpandHidden: widget.sidebarIconExpandHidden,
  //     sidebarIconCollapse: widget.sidebarIconCollapse,
  //     sidebarToggleEnabled: widget.sidebarToggleEnabled,
  //     // If no sidebar app bar is provided we make a default one.
  //     sidebarAppBar: widget.sidebarAppBar ?? const FlexAppBar(),
  //     cycleViaDrawer: widget.cycleViaDrawer,
  //     hideSidebar: widget.hideSidebar,
  //     onHideSidebar: (bool value) {
  //       setState(() {
  //         hideSidebar = value;
  //         if (widget.onHideSidebar != null)
  //           widget.onHideSidebar!(hideSidebar);
  //         if (_kDebugMe) {
  //           debugPrint('Flexfold() onHideSidebar: $hideSidebar');
  //         }
  //       });
  //     },
  //     sidebarBelongsToBody: widget.sidebarBelongsToBody,
  //     hasAppBar: widget.destinations[selectedIndex].hasAppBar,
  //     child: widget.sidebar,
  //   );
  // }

  Widget _buildMenu(BuildContext context) {
    return FlexfoldMenu(
      destinations: widget.destinations,
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: (int index) {
        // If we just clicked the current index we don't do anything
        if (index == widget.selectedIndex) return;

        setState(() {
          // After moving to a new destination, bottom bar is not scroll hidden.
          scrollHiddenBottomBar = false;

          selectedIndex = index;
          indexMenu.setIndex(index);
          target = widget.destinations[index];
          final int? bottomIndex =
              FlexfoldDestination.toBottomIndex(target, widget.destinations);
          indexBottom.setIndex(bottomIndex);
          isBottomTarget = bottomIndex != null;

          FlexfoldNavigationSource source = FlexfoldNavigationSource.rail;
          if (isMenuInDrawer) source = FlexfoldNavigationSource.drawer;
          if (isMenuInMenu) source = FlexfoldNavigationSource.menu;

          // Make tap destination data to return
          final FlexfoldDestinationData destination = FlexfoldDestinationData(
            bottomIndex: bottomIndex,
            menuIndex: selectedIndex,
            reverse: indexMenu.reverse,
            source: source,
            route: widget.destinations[index].route,
            useModal: (isPhone && widget.destinations[index].maybeModal) ||
                widget.destinations[index].alwaysModal,
          );
          widget.onDestination(destination);
        });
      },
      menuToggleEnabled: widget.menuControlEnabled,
      menuIcon: widget.menuIcon,
      menuIconExpand: widget.menuIconExpand,
      menuIconExpandHidden: widget.menuIconExpandHidden,
      menuIconCollapse: widget.menuIconCollapse,
      // We have to have a menu app bar, we make a default one so that
      // if nothing is provided so we get a functional menu with control button.
      menuAppBar: widget.menuAppBar ?? const FlexAppBar(),
      menuLeading: widget.menuLeading,
      menuTrailing: widget.menuTrailing,
      menuFooter: widget.menuFooter,
      hideMenu: widget.hideMenu,
      onHideMenu: (bool value) {
        setState(() {
          hideMenu = value;
          if (widget.onHideMenu != null) widget.onHideMenu?.call(hideMenu);
          if (_kDebugMe) {
            debugPrint('Flexfold() onHideMenu: $hideMenu');
          }
        });
      },
      cycleViaDrawer: widget.cycleViaDrawer,
      preferRail: widget.preferRail,
      onPreferRail: (bool value) {
        setState(() {
          preferRail = value;
          if (widget.onPreferRail != null) {
            widget.onPreferRail?.call(preferRail);
          }
          if (_kDebugMe) {
            debugPrint('Flexfold() onPreferRail: $preferRail');
          }
        });
      },
      showBottomDestinationsInDrawer: showBottomDestinationsInDrawer,
    );
  }

  Widget? _buildBottomBar(BuildContext context) {
    // Make a list that only contains the bottom bar options
    final List<FlexfoldDestination> bottomDestinations = widget.destinations
        .where((FlexfoldDestination item) => item.inBottomBar)
        .toList();
    // Current platform
    final TargetPlatform platform = Theme.of(context).platform;
    // Get the custom Flexfold theme, closest inherited one.
    final FlexfoldThemeData theme = FlexfoldTheme.of(context);
    // Resolve the effective bottom bar type
    // TODO(rydmike): Is this always safe?
    FlexfoldBottomBarType effectiveType = theme.bottomBarType!;
    if (effectiveType == FlexfoldBottomBarType.adaptive) {
      if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
        effectiveType = FlexfoldBottomBarType.cupertino;
      } else {
        effectiveType = FlexfoldBottomBarType.material2;
      }
    }
    if (_kDebugMe) {
      debugPrint('Flexfold() effectiveType: $effectiveType');
    }
    // The height of the Material and Cupertino bottom nav bars differ, we need
    // to get the correct height for the effective bottom nav bar.
    // TODO(rydmike): Make this nice handle alwaysHide labels for NavigationBar.
    final double effectiveToolBarHeight =
        effectiveType == FlexfoldBottomBarType.material2
            ? kBottomNavigationBarHeight
            : effectiveType == FlexfoldBottomBarType.material3
                ? kFlexfoldNavigationBarHeight
                : kFlexfoldCupertinoTabBarHeight;
    // If we are not at a destination that is defined to be a bottom target,
    // we are not inserting a bottom nav bar in the widget tree all
    return isBottomTarget
        // This setup with the bottom bar in an animated container inside a
        // Wrap animate the size and it looks like the bottom bar slides
        // down and away when you do that in a Wrap.
        //
        // The effective height in the type of bottom bar also animate between
        // the different sizes the bottom bar has, so when the type is changed
        // if they have different sizes, which Material and Cupertino does, the
        // toggle between them is animated.
        // It is just cool bonus effect of this setup.
        ? AnimatedContainer(
            duration: theme.bottomBarAnimationDuration!,
            curve: theme.bottomBarAnimationCurve!,
            height: isBottomBarVisible ? effectiveToolBarHeight : 0.0,
            child: Wrap(
              children: <Widget>[
                FlexBottomBar(
                  bottomBarType: effectiveType,
                  destinations: bottomDestinations,
                  selectedIndex: indexBottom.index,
                  onDestinationSelected: (int index) {
                    // If we click the current index we don't do anything
                    if (index == indexBottom.index) return;
                    setState(
                      () {
                        // Ensure that after moving to a new destination, that
                        // the bottom navigation bar is never scrollHidden.
                        scrollHiddenBottomBar = false;

                        target = bottomDestinations[index];
                        indexBottom.setIndex(index);
                        selectedIndex = FlexfoldDestination.toMenuIndex(
                            target, widget.destinations);
                        indexMenu.setIndex(selectedIndex);
                        // Make tap destination data to return
                        final FlexfoldDestinationData destination =
                            FlexfoldDestinationData(
                          bottomIndex: index,
                          menuIndex: selectedIndex,
                          reverse: indexMenu.reverse,
                          source: FlexfoldNavigationSource.bottom,
                          route: widget.destinations[selectedIndex].route,
                        );
                        widget.onDestination(destination);
                      },
                    );
                  },
                ),
              ],
            ),
          )
        : null; // TODO(rydmike): Good idea? OR const SizedBox.shrink()?
  }
}

// class _FlexAppBar extends StatelessWidget {
//   const _FlexAppBar({
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class _FlexMenu extends StatelessWidget {
//   const _FlexMenu({
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class _FlexSideBar extends StatelessWidget {
//   const _FlexSideBar({
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class _FlexBottomBar extends StatelessWidget {
//   const _FlexBottomBar({
//     Key? key,
//     required this.destinations,
//     required this.isBottomTarget,
//     required this.isBottomBarVisible,
//     required this.indexBottom,
//     required this.bottomNavigationBar,
//   }) : super(key: key);
//
//   /// Defines the appearance of the navigation button items that are listed in
//   /// the drawer, rail, menu and bottom bar.
//   ///
//   /// The value must be a list of two or more [FlexfoldDestination] values.
//   final List<FlexfoldDestination> destinations;
//
//   /// current target is bottom bar.
//   final bool isBottomTarget;
//
//   final bool isBottomBarVisible;
//
//   final FlexfoldIndexTracker indexBottom;
//
//   final Widget bottomNavigationBar;
//
//   @override
//   Widget build(BuildContext context) {
//     // Make a list that only contains the bottom bar options
//     final List<FlexfoldDestination> bottomDestinations = destinations
//         .where((FlexfoldDestination item) => item.inBottomBar)
//         .toList();
//     // Current platform
//     final TargetPlatform platform = Theme.of(context).platform;
//     // Get the custom Flexfold theme, closest inherited one.
//     final FlexfoldThemeData theme = FlexfoldTheme.of(context);
//     // Resolve the effective bottom bar type
//     //TODO(rydmike): Is this always safe?
//     FlexfoldBottomBarType effectiveType = theme.bottomBarType!;
//     if (effectiveType == FlexfoldBottomBarType.adaptive) {
//       if (platform == TargetPlatform.iOS ||
//       platform == TargetPlatform.macOS) {
//         effectiveType = FlexfoldBottomBarType.cupertino;
//       } else {
//         effectiveType = FlexfoldBottomBarType.material;
//       }
//     }
//     if (_kDebugMe) {
//       debugPrint('Flexfold() effectiveType: $effectiveType');
//     }
//     // The height of the Material and Cupertino bottom nav bars differ,
//     // we need to get the correct height for the effective bottom nav bar.
//     final double effectiveToolBarHeight =
//         effectiveType == FlexfoldBottomBarType.material
//             ? kBottomNavigationBarHeight
//             : kFlexfoldCupertinoTabBarHeight;
//     // If we are not at a destination that is defined to be a bottom target,
//     // we are not inserting a bottom nav bar in the widget tree all
//     return isBottomTarget
//         // This setup with the bottom bar in an animated container inside a
//         // Wrap animate the size and it looks like the bottom bar slides
//         // down and away when you do that in a Wrap.
//         //
//         // The effective height in the type of bottom bar also animate
//         // between the different sizes the bottom bar has, so when the type
//         // is changed if they have different sizes, which Material and
//         // Cupertino does, the toggle between them is animated.
//         // It is just cool bonus effect of this setup.
//         ? AnimatedContainer(
//             duration: theme.bottomBarAnimationDuration!,
//             curve: theme.bottomBarAnimationCurve!,
//             height: isBottomBarVisible ? effectiveToolBarHeight : 0.0,
//             child: Wrap(
//               children: <Widget>[
//                 FlexfoldBottomBar(
//                   bottomBarType: effectiveType,
//                   destinations: bottomDestinations,
//                   selectedIndex: indexBottom.index,
//                   onDestinationSelected: (int index) {
//                     // If we click the current index we don't do anything
//                     if (index == indexBottom.index) return;
//                     setState(
//                       () {
//                         // Ensure that after moving to a new destination,
//                         // that bottom navigation bar is never scrollHidden.
//                         scrollHiddenBottomBar = false;
//
//                         target = bottomDestinations[index];
//                         indexBottom.setIndex(index);
//                         selectedIndex = FlexfoldDestination.toMenuIndex(
//                             target, destinations);
//                         indexMenu.setIndex(selectedIndex);
//                         // Make tap destination data to return
//                         final FlexfoldSelectedDestination destination =
//                             FlexfoldSelectedDestination(
//                           bottomIndex: index,
//                           menuIndex: selectedIndex,
//                           reverse: indexMenu.reverse,
//                           source: FlexfoldNavigationSource.bottom,
//                           route: destinations[selectedIndex].route,
//                         );
//                         widget.onDestinationSelected(destination);
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           )
//         : const SizedBox.shrink();
//   }
// }
