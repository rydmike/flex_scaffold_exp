import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'flex_app_bar.dart';
import 'flex_bottom_bar.dart';
import 'flex_destination.dart';
import 'flex_drawer.dart';
import 'flex_menu.dart';
import 'flex_scaffold_app_bar.dart';
import 'flex_scaffold_constants.dart';
import 'flex_scaffold_helpers.dart';
import 'flex_sidebar.dart';
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
    this.hideBottomBar = false,
    this.showBottomBarWhenMenuInDrawer = false,
    this.showBottomBarWhenMenuShown = false,
    this.bottomDestinationsInDrawer = false,
    this.customBottomNavigator,
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
  /// responsive scaffold. See [FlexScaffoldThemeData] for more details.
  ///
  /// Changes to passed in theme's properties are animated. Changes to a
  /// FlexfoldTheme higher up in the widget tree that Flexfold inherits it theme
  /// from will also animate the properties in Flexfold that depends on the
  /// inherited theme data. The passed in theme is merged with any inherited
  /// theme.
  final FlexScaffoldThemeData? flexfoldTheme;

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
  /// The value must be a list of two or more [FlexDestination] values.
  final List<FlexDestination> destinations;

  /// The index into [destinations] for the current selected
  /// [FlexDestination].
  final int selectedIndex;

  /// Callback called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the navigation rail needs to keep
  /// track of the index of the selected [FlexDestination] and call
  /// `setState` to rebuild the menu, drawer, rail or bottom bar
  /// with the new [selectedIndex].
  final ValueChanged<FlexDestinationTarget> onDestination;

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

  /// An [AppBar] for the menu when used on the drawer, rail and side menu.
  ///
  /// The menu has an AppBar on top of it too. It always gets an automatic
  /// leading button to show and collapse it. You can also create actions for
  /// the menu app bar, but beware that there is not a lot of space and
  /// actions are not reachable in rail mode. There is also not so much
  /// space in the title, but you can fit a small brand/logo/app text on it.
  final FlexAppBar? menuAppBar;

  /// A widget that appears below the menu AppBar but above the menu items.
  ///
  /// It is placed at the top of the menu, but after the menu bar and above the
  /// [destinations].
  /// This could be an action button like a [FloatingActionButton], but may
  /// also be a non-button, such as a user profile image, bigger company logo,
  /// etc. It needs to fit and look good both in rail and side menu mode.
  ///
  /// The default value is null.
  final Widget? menuLeading;

  /// Trailing menu widget that is placed below the last [FlexDestination].
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

  /// Callback that is called when menu is hidden via its menu button control.
  ///
  /// This callback together with its sett [hideMenu] can be used if you
  /// want to control hiding and showing the menu from an external control,
  /// like a user controlled [Switch], you can then use this callback to change
  /// the state of such a switch when user has operated hiding/showing the menu
  /// via its menu control button.
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

  /// To use [FlexScaffold] with custom bottom navigators, e.g. from
  /// packages, pass it in here.
  ///
  /// See package documentation and examples on how to configure custom bottom
  /// navigation bars.
  ///
  /// Typically this property is null and the FlexScaffoldTheme.type
  /// is used to determine if [CupertinoTabBar], [NavigationBar] ot
  /// [BottomNavigationBar] is used to
  /// determine if the [FlexScaffold] use [CupertinoBottomBar],
  ///
  /// The type is determined by [FlexScaffoldThemeData.bottomBarType], which
  /// defaults to [FlexfoldBottomBarType.adaptive]. Which will result in
  /// [CupertinoTabBar] on iOS and macOS and other platforms in
  /// [BottomNavigationBar] if [ThemeData.useMaterial3] is false and in
  /// [NavigationBar] if [ThemeData.useMaterial3] is true.
  final Widget? customBottomNavigator;

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

  /// Finds the [FlexScaffoldState] from the closest instance of this class that
  /// encloses the given context.
  ///
  /// If no instance of this class encloses the given context, will cause an
  /// assert in debug mode, and throw an exception in release mode.
  ///
  /// This method can be expensive (it walks the element tree).
  ///
  /// Typical usage of the [FlexScaffold.of] function is to call it from
  /// within the `build` method of a child of a [FlexScaffold].
  ///
  /// When the [FlexScaffold] is actually created in the same `build` function,
  /// the `context` argument to the `build` function can't be used to find the
  /// [FlexScaffold] (since it's "above" the widget being returned in the widget
  /// tree). In such cases, the wrapping `body` with a [Builder] can be used
  /// to provide a new scope with a [BuildContext] that is "under" the
  /// [FlexScaffold].
  ///
  /// A more efficient solution is to split your build function into several
  /// widgets. This introduces a new context from which you can obtain the
  /// [FlexScaffold]. In this solution, you would have an outer widget that
  /// creates the [FlexScaffold] populated by instances of your new inner
  /// widgets, and then in these inner widgets you would use [FlexScaffold.of].
  ///
  /// A less elegant but more expedient solution is assign a [GlobalKey] to the
  /// [FlexScaffold], then use the `key.currentState` property to obtain the
  /// [FlexScaffoldState] rather than using the [FlexScaffold.of] function.
  ///
  /// If there is no [FlexScaffold] in scope, then this will throw an exception.
  static FlexScaffoldState of(BuildContext context) {
    final _InheritedFlexScaffold? result =
        context.dependOnInheritedWidgetOfExactType<_InheritedFlexScaffold>();
    if (result != null) {
      return result.data;
    }
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
        'FlexScaffold.of() called with a context that does not '
        'contain a FlexScaffold.',
      ),
      ErrorDescription(
        'No FlexScaffoldState ancestor could be found starting from the '
        'context that was passed to FlexScaffold.of(). '
        'This usually happens when the context provided is from the same '
        'StatefulWidget as that whose build function actually creates the '
        'FlexScaffold widget being sought.',
      ),
      ErrorHint(
        'There are several ways to avoid this problem. The simplest is to use '
        'a Builder to get a context that is "under" the FlexScaffold. '
        'For a similar example of this, please see the '
        'documentation for Scaffold.of():\n'
        '  https://api.flutter.dev/flutter/material/Scaffold/of.html',
      ),
      ErrorHint(
        'A more efficient solution is to split your build function into '
        'several widgets. This introduces a new context from which you can '
        'obtain the FlexScaffold. In this solution, you would have an outer '
        'widget that creates the FlexScaffold populated by instances of '
        'your new inner widgets, and then in these inner widgets you would use '
        'FlexScaffold.of().\n'
        'A less elegant but more expedient solution is assign a GlobalKey to '
        'the FlexScaffold, then use the key.currentState property to obtain '
        'the FlexScaffoldState rather than using the FlexScaffold.of() '
        'function.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  /// Finds the [FlexScaffoldState] from the closest instance of this class that
  /// encloses the given context.
  ///
  /// If no instance of this class encloses the given context, will return null.
  /// To throw an exception instead, use [of] instead of this function.
  ///
  /// This method can be expensive (it walks the element tree).
  ///
  /// See also:
  ///
  ///  * [of], a similar function to this one that throws if no instance
  ///    encloses the given context.
  static FlexScaffoldState? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedFlexScaffold>()
        ?.data;
  }

  /// A static helper function intended to be used as a scroll controller
  /// listener to show and hide the bottom navigation bar in a [FlexScaffold].
  ///
  /// The [scrollController] is the [ScrollController] being listened to.
  ///
  /// The boolean [ValueChanged] callback [hide] is called with true if the
  /// [scrollController] scrolling direction is reverse and we should hide
  /// the bottom navigation bar. If [scrollController] direction is forward
  /// it is called with false, indicating we should show the bottom bar again.
  ///
  /// You use the FlexScaffold.of(context).scrollHideBottomBar(bool) function
  /// to actually hide and show the bottom navigation bar.
  ///
  /// Set the [useHide] to false to not use the function at all, this can be
  /// used as external control of if the hide function is even used or e.g.
  /// turned OFF via a setting in the app.
  static void hideBottomBarOnScroll(
    ScrollController scrollController,
    ValueChanged<bool> hide, [
    bool useHide = true,
  ]) {
    // If scroll hiding is used we do the hide/show callback, else nop.
    if (useHide) {
      // Reverse direction is scrolling down, we hide it, if not hidden.
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // if not already set to hidden, we set it to hidden.
        hide(true);
      }
      // Forward direction is scrolling up, we show it, if not shown already.
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // If it is hidden, we set it to not be hidden anymore.
        hide(false);
      }
    }
  }

  @override
  State<FlexScaffold> createState() => FlexScaffoldState();
}

/// State for a [FlexScaffold].
///
/// Retrieve a [ScaffoldState] from the current
/// [BuildContext] using [FlexScaffold.of].
class FlexScaffoldState extends State<FlexScaffold> {
  // State that might be changed via widget
  late int _selectedIndex;
  final IndexTracker _indexMenu = IndexTracker();
  final IndexTracker _indexBottom = IndexTracker();
  late FlexDestination _target;
  late bool _hideMenu;
  late bool _hideSidebar;
  late bool _preferRail;
  late bool _isBottomTarget;
  late bool _scrollHiddenBottomBar;
  late List<FlexDestination> _bottomDestinations;

  // Local state
  late bool _isPhone;
  late bool _isPhoneLandscape;
  late bool _isTablet;
  late bool _isDesktop;
  late bool _isMenuInDrawer;
  late bool _isMenuInMenu;
  late bool _isSidebarInEndDrawer;
  late bool _isSidebarInMenu;
  late bool _isBottomBarVisible;
  late bool _showBottomDestinationsInDrawer;
  late Orientation _currentOrientation;

  /// Returns true if the menu is currently in the Drawer.
  bool get isMenuInDrawer => _isMenuInDrawer;

  /// Returns true if the menu is currently hidden.
  bool get menuIsHidden => _hideMenu;

  /// Set the FlexScaffold menu to be hidden. If set to false, the menu will be
  /// shown as a rail or menu when it should, based on its breakpoints.
  void hideMenu(bool value) {
    if (value != _hideMenu) {
      setState(() {
        _hideMenu = value;
        _scrollHiddenBottomBar = false;
        widget.onHideMenu?.call(value);
        if (_kDebugMe) {
          debugPrint('FlexScaffold: menuIsHidden set to $_hideMenu');
        }
      });
    }
  }

  /// Returns true if the menu is currently preferring to be a rail.
  ///
  /// If the menu has been set to be a Rail or breakpoint settings forces the
  /// the menu to current be a rail, this is true.
  bool get menuPrefersRail => _preferRail;

  /// Set the FlexScaffold menu to prefer rail state.
  void setMenuPrefersRail(bool value) {
    setState(() {
      _preferRail = value;
      widget.onPreferRail?.call(value);
      if (_kDebugMe) {
        debugPrint('FlexScaffold: menuPrefersRail set to $_preferRail');
      }
    });
  }

  /// Returns true if the sidebar is currently in the EndDrawer.
  bool get isSidebarInEndDrawer => _isSidebarInEndDrawer;

  /// Returns true if the sidebar is currently in the locked menu state.
  bool get isSidebarInMenu => _isSidebarInMenu;

  /// Returns true if the sidebar is currently hidden.
  bool get sidebarIsHidden => _hideSidebar;

  /// Set the FlexScaffold sidebar to be hidden. If set to false, the sidebar
  /// will be shown when it should automatically, based on its breakpoint.
  void hideSidebar(bool value) {
    setState(() {
      _hideSidebar = value;
      widget.onHideSidebar?.call(value);
      if (_kDebugMe) {
        debugPrint('FlexScaffold: sidebarIsHidden set to $_hideSidebar');
      }
    });
  }

  /// Returns the implied AppBar string title for current destination
  String get currentImpliedTitle =>
      widget.destinations[widget.selectedIndex].label;

  /// Returns true if the currently selected destination is a bottom
  /// navigation target.
  // bool get isBottomTarget => _isBottomTarget;

  /// Returns true if a bottom navigator is visible.
  // bool get isBottomBarVisible => _isBottomBarVisible;

  /// Returns all bottom navigation destinations for the current module.
  List<FlexDestination> get bottomDestinations => _bottomDestinations;

  /// Returns the index tracker for bottom index.
  IndexTracker get indexBottom => _indexBottom;

  /// Returns true if the bottom navigation is scroll hidden.
  bool get isBottomBarScrollHidden => _scrollHiddenBottomBar;

  /// Set the FlexScaffold bottom navigation bar scroll visibility.
  /// When set to true, the bottom bar animates down to become hidden
  /// when set to false, it animates back into view.
  void scrollHideBottomBar(bool value) {
    setState(() {
      _scrollHiddenBottomBar = value;
      if (_kDebugMe) {
        debugPrint('FlexScaffold: scrollHideBottomBar '
            'set to $_scrollHiddenBottomBar');
      }
    });
  }

  /// Navigate to selected bottom bar index.
  void navigateToBottomIndex(int index) {
    // If we click the current index we don't do anything
    if (index == _indexBottom.index) return;
    setState(
      () {
        // Ensure that after moving to a new destination, that
        // the bottom navigation bar is never scrollHidden.
        _scrollHiddenBottomBar = false;

        _target = bottomDestinations[index];
        _indexBottom.setIndex(index);
        _selectedIndex = toMenuIndex(_target);
        _indexMenu.setIndex(_selectedIndex);
        // Make tap destination data to return
        final FlexDestinationTarget destination = FlexDestinationTarget(
          index: _selectedIndex,
          bottomIndex: index,
          route: widget.destinations[_selectedIndex].route,
          icon: widget.destinations[_selectedIndex].icon,
          selectedIcon: widget.destinations[_selectedIndex].selectedIcon,
          label: widget.destinations[_selectedIndex].label,
          reverse: _indexMenu.reverse,
          source: FlexNavigation.bottom,
        );
        widget.onDestination(destination);
        if (_kDebugMe) {
          debugPrint('FlexScaffold: navigate to bottom $_target');
        }
      },
    );
  }

  /// Given a [FlexDestination], return its bottom navigation bar index.
  ///
  /// If the destination does not exist in the valid destinations, null will
  /// be returned to indicate that destination was not found in the bottom
  /// navigation bar. The destination could still exist in the destinations
  /// none bottom navigation part, null is a valid result of this function.
  int? toBottomIndex(FlexDestination destination) {
    // Check for valid target and destinations
    if (widget.destinations.length < 2) {
      // Bad input, but let's return the 0 index to use first destination.
      return 0;
    }
    int countBottomIndex = 0;
    for (int i = 0; i < widget.destinations.length; i++) {
      if (widget.destinations[i].inBottomNavigation) {
        if (destination.route == widget.destinations[i].route) {
          return countBottomIndex;
        }
        countBottomIndex++;
      }
    }
    // There was no match for bottom index, it could still be a destination
    // that is only available in the rail or menu.
    // Null is a valid result of this function!
    // ignore: avoid_returning_null
    return null;
  }

  /// Given a [FlexDestination], return its menu index.
  ///
  /// If the destination is not found in the given destinations or the
  /// destinations input is invalid, this function always returns zero, which
  /// will correspond to the first destination in any list of destinations.
  int toMenuIndex(FlexDestination destination) {
    // Check for valid target and destinations
    if (widget.destinations.length < 2) {
      // Bad input, but let's return the 0 index to use first option in any
      // destinations lists.
      return 0;
    }
    for (int i = 0; i < widget.destinations.length; i++) {
      if (destination.route == widget.destinations[i].route) return i;
    }
    // The destination was not found, we return 0 index to use first destination
    // in any valid destinations list.
    return 0;
  }

  /// For a given route return the [FlexDestination].
  ///
  /// If no route is found, the first destination is returned.
  FlexDestination forRoute(String route) {
    // Check for valid target and destinations
    if (widget.destinations.length < 2) {
      // Bad input, but let's return the first one if destinations is not empty
      return widget.destinations.isNotEmpty
          ? widget.destinations[0]
          // If it was empty, then it was really bad we return a default
          // const destination, not very helpful, but caller can check for it.
          : const FlexDestination();
    }
    for (int i = 0; i < widget.destinations.length; i++) {
      if (route == widget.destinations[i].route) return widget.destinations[i];
    }
    // We did not find the given route, in that case we return
    // the first destination. Case of bad input, bad output.
    return widget.destinations[0];
  }

  /// Create a [FlexDestinationTarget] from a [route], with
  /// optional values for navigation source and reverse direction.
  ///
  /// The String [route] is required.
  FlexDestinationTarget fromRoute(
    String route, {
    FlexNavigation source = FlexNavigation.custom,
    bool reverse = false,
    bool preferPush = false,
  }) {
    // Get the destination
    final FlexDestination destination = forRoute(route);
    final int index = toMenuIndex(destination);
    return FlexDestinationTarget(
      index: index,
      bottomIndex: toBottomIndex(destination),
      route: route,
      icon: widget.destinations[index].icon,
      selectedIcon: widget.destinations[index].selectedIcon,
      label: widget.destinations[index].label,
      source: source,
      reverse: reverse,
      preferPush: preferPush,
    );
  }

  void _assumePushed() {
    _selectedIndex = widget.selectedIndex;
    _indexMenu.setIndex(widget.selectedIndex);
    _target = widget.destinations[_indexMenu.index];
    final int? bottomIndex = toBottomIndex(_target);
    _indexBottom.setIndex(bottomIndex);
    _isBottomTarget = bottomIndex != null;
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _indexMenu.setIndex(widget.selectedIndex);
    _target = widget.destinations[_indexMenu.index];
    _bottomDestinations = widget.destinations
        .where((FlexDestination item) => item.inBottomNavigation)
        .toList();
    final int? bottomIndex = toBottomIndex(_target);
    _indexBottom.setIndex(bottomIndex);
    _isBottomTarget = bottomIndex != null;
    _hideMenu = widget.hideMenu;
    _hideSidebar = widget.hideSidebar;
    _preferRail = widget.preferRail;
    _scrollHiddenBottomBar = false; // widget.scrollHiddenBottomBar;
    // TODO(rydmike): Changing orientation with drawer open may break it! Fix?
    // currentOrientation = MediaQuery.of(context).orientation;
  }

  @override
  void didUpdateWidget(FlexScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _selectedIndex = widget.selectedIndex;
      _indexMenu.setIndex(widget.selectedIndex);
      _target = widget.destinations[_indexMenu.index];
      final int? bottomIndex = toBottomIndex(_target);
      _indexBottom.setIndex(bottomIndex);
      _isBottomTarget = bottomIndex != null;
    }
    if (widget.hideMenu != oldWidget.hideMenu) {
      _hideMenu = widget.hideMenu;
    }
    if (widget.hideSidebar != oldWidget.hideSidebar) {
      _hideSidebar = widget.hideSidebar;
    }
    if (widget.preferRail != oldWidget.preferRail) {
      _preferRail = widget.preferRail;
    }
    if (widget.destinations != oldWidget.destinations) {
      _bottomDestinations = widget.destinations
          .where((FlexDestination item) => item.inBottomNavigation)
          .toList();
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
    final FlexScaffoldThemeData flexTheme = FlexScaffoldTheme.of(context);
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
    final FlexScaffoldThemeData defaultFlexTheme =
        const FlexScaffoldThemeData().withDefaults(context);

    // Merge the other sub-themes than the Bottom navigation bar with
    // the default values, first merge the inherited Flexfold sub theme
    // values and then the sub theme values passed in via widget.theme
    final TextStyle effectiveUnselectedLabelStyle = defaultFlexTheme
        .labelTextStyle!
        .merge(flexTheme.labelTextStyle)
        .merge(widget.flexfoldTheme!.labelTextStyle);

    final TextStyle effectiveSelectedLabelStyle = defaultFlexTheme
        .selectedLabelTextStyle!
        .merge(flexTheme.selectedLabelTextStyle)
        .merge(widget.flexfoldTheme!.selectedLabelTextStyle);

    final IconThemeData effectiveUnselectedIconTheme = defaultFlexTheme
        .iconTheme!
        .merge(flexTheme.iconTheme)
        .merge(widget.flexfoldTheme!.iconTheme);

    final IconThemeData effectiveSelectedIconTheme = defaultFlexTheme
        .selectedIconTheme!
        .merge(flexTheme.selectedIconTheme)
        .merge(widget.flexfoldTheme!.selectedIconTheme);

    final TextStyle effectiveHeadingTextStyle = defaultFlexTheme
        .headingTextStyle!
        .merge(flexTheme.headingTextStyle)
        .merge(widget.flexfoldTheme!.headingTextStyle);

    // Merge the inherited Flexfold theme with the default Flexfold theme.
    final FlexScaffoldThemeData flexThemeMerged =
        defaultFlexTheme.merge(flexTheme);

    // Then merge widget passed in theme, with the above merge theme.
    final FlexScaffoldThemeData fullFlexTheme =
        flexThemeMerged.merge(widget.flexfoldTheme);

    // Then the fully merged Flexfold theme gets a copy of all the effective
    // effective sub themes it contains, meaning the bottomNavigationBarTheme
    // and all effective text styles and icon themes.
    // This creates a theme that has all the ambient Flexfold theme data
    // and defaults as fallback, in a single summarized merged theme.
    final FlexScaffoldThemeData effectiveFlexTheme = fullFlexTheme.copyWith(
      bottomNavigationBarTheme: effectiveBottomTheme,
      labelTextStyle: effectiveUnselectedLabelStyle,
      selectedLabelTextStyle: effectiveSelectedLabelStyle,
      iconTheme: effectiveUnselectedIconTheme,
      selectedIconTheme: effectiveSelectedIconTheme,
      headingTextStyle: effectiveHeadingTextStyle,
    );

    // Then make an animated FlexfoldTheme of the final effective theme.
    return _InheritedFlexScaffold(
      data: this,
      child: AnimatedFlexfoldTheme(
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
          final FlexScaffoldThemeData flexTheme = FlexScaffoldTheme.of(context);

          // TODO(rydmike): When MediaQuery as InheritedModel lands use it.
          //   reference: https://github.com/flutter/flutter/pull/114459
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
          _isPhone = width < flexTheme.breakpointRail!;
          // Based on height and breakpoint, this is a phone landscape layout.
          _isPhoneLandscape = height < flexTheme.breakpointDrawer!;
          // Based on width & breakpoint limit, this is a desktop sized layout.
          _isDesktop =
              (width >= flexTheme.breakpointMenu!) && !_isPhoneLandscape;
          // This is only based on that we are not doing phone or desktop size.
          _isTablet = !_isPhone && !_isDesktop;

          // The menu will exist as a Drawer widget in the widget tree.
          _isMenuInDrawer = _isPhone || widget.hideMenu || _isPhoneLandscape;
          // The menu is shown as a full sized menu before the body.
          _isMenuInMenu = _isDesktop && !widget.hideMenu && !widget.preferRail;
          // The sidebar will exist in an end Drawer widget in the widget tree.
          _isSidebarInEndDrawer =
              (width < flexTheme.breakpointSidebar! || widget.hideSidebar) &&
                  widget.destinations[_selectedIndex].hasSidebar &&
                  widget.sidebar != null;
          // The sidebar is shown as a widget after the body.
          _isSidebarInMenu = width >= flexTheme.breakpointSidebar! &&
              !widget.hideSidebar &&
              widget.destinations[_selectedIndex].hasSidebar &&
              widget.sidebar != null;
          // The bottom navigation bar is visible.
          // Complex logic here, many config options leads to stuff like this.
          _isBottomBarVisible = !(widget.hideBottomBar ||
                  _scrollHiddenBottomBar) &&
              (_isPhone ||
                  widget.showBottomBarWhenMenuShown ||
                  (widget.showBottomBarWhenMenuInDrawer && _isMenuInDrawer));
          // The bottom destinations are to be shown and included in the drawer.
          // Again complex logic, caused by many options and possibilities
          _showBottomDestinationsInDrawer = widget.bottomDestinationsInDrawer ||
              !_isBottomTarget ||
              widget.hideBottomBar ||
              (!_isPhone &&
                  (!widget.showBottomBarWhenMenuInDrawer &&
                      !widget.showBottomBarWhenMenuShown));
          // Set location of floating action button (FAB) depending on media
          // size, use default locations if null.
          final FloatingActionButtonLocation effectiveFabLocation = _isPhone
              // FAB on phone size
              ? widget.floatingActionButtonLocationPhone ??
                  // Default uses end float location, the official standard.
                  FloatingActionButtonLocation.endFloat
              : _isDesktop
                  ? widget.floatingActionButtonLocationDesktop ??
                      // Material default position would be startTop at desktop
                      // size, or possibly also endTop, but the FAB gets in the
                      // way in those locations sometimes so we use centerFloat
                      // as default.
                      FloatingActionButtonLocation.centerFloat
                  // It is tablet then ...
                  : widget.floatingActionButtonLocationTablet ??
                      // Default should be start top, but that is in the way so
                      // we use startFloat, it works well with rail navigation.
                      FloatingActionButtonLocation.startFloat;
          //
          // Build the actual FlexScaffold content
          return Row(
            children: <Widget>[
              //
              // Main menu, when the menu is shown as a fixed menu
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: flexTheme.menuWidth! + startPadding),
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
                  // Add AppBar with leading and actions buttons, but only
                  // if the destination has an app bar.
                  appBar: widget.destinations[_selectedIndex].hasAppBar
                      ? FlexScaffoldAppBar(appBar: widget.appBar)
                      : null,
                  //
                  // The menu when used as a drawer.
                  drawer: _isMenuInDrawer
                      ? FlexDrawer(
                          elevation: flexTheme.drawerElevation!,
                          drawerWidth: flexTheme.drawerWidth! + startPadding,
                          currentScreenWidth: width,
                          backgroundColor: flexTheme.menuBackgroundColor,
                          child: _buildMenu(context),
                        )
                      : null,
                  //
                  // The end drawer, ie tools menu when used as an end drawer.
                  endDrawer: _isSidebarInEndDrawer
                      ? FlexDrawer(
                          elevation: flexTheme.endDrawerElevation!,
                          drawerWidth: flexTheme.endDrawerWidth!,
                          currentScreenWidth: width,
                          backgroundColor: flexTheme.sidebarBackgroundColor,
                          child: FlexSidebar(
                            sidebarIcon: widget.sidebarIcon,
                            sidebarIconExpand: widget.sidebarIconExpand,
                            sidebarIconExpandHidden:
                                widget.sidebarIconExpandHidden,
                            sidebarIconCollapse: widget.sidebarIconCollapse,
                            sidebarToggleEnabled: widget.sidebarControlEnabled,
                            // If no sidebar app bar given make a default one.
                            sidebarAppBar:
                                widget.sidebarAppBar ?? const FlexAppBar(),
                            sidebarBelongsToBody: widget.sidebarBelongsToBody,
                            hasAppBar:
                                widget.destinations[_selectedIndex].hasAppBar,
                            child: widget.sidebar,
                          ),
                        )
                      : null,
                  //
                  // The bottom navigation bar
                  bottomNavigationBar: _FlexScaffoldBottomBar(
                    isBottomTarget: _isBottomTarget,
                    isBottomBarVisible: _isBottomBarVisible,
                    customNavBar: widget.customBottomNavigator,
                  ),
                  //
                  // Floating action button in its effective location.
                  floatingActionButton: widget
                          .destinations[_selectedIndex].hasFloatingActionButton
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
                      if (widget.destinations[_selectedIndex].hasSidebar &&
                          widget.sidebar != null &&
                          widget.sidebarBelongsToBody)
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: flexTheme.sidebarWidth!),
                          child: Material(
                            color: flexTheme.sidebarBackgroundColor,
                            elevation: flexTheme.sidebarElevation!,
                            child: FlexSidebar(
                              sidebarIcon: widget.sidebarIcon,
                              sidebarIconExpand: widget.sidebarIconExpand,
                              sidebarIconExpandHidden:
                                  widget.sidebarIconExpandHidden,
                              sidebarIconCollapse: widget.sidebarIconCollapse,
                              sidebarToggleEnabled:
                                  widget.sidebarControlEnabled,
                              // If no sidebar app bar given make a default one.
                              sidebarAppBar:
                                  widget.sidebarAppBar ?? const FlexAppBar(),
                              sidebarBelongsToBody: widget.sidebarBelongsToBody,
                              hasAppBar:
                                  widget.destinations[_selectedIndex].hasAppBar,
                              child: widget.sidebar,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Sidebar may also be in the Row. This happens when it is shown
              // as a fixed sidebar on the screen and it does not "belong to the
              // body", then it is on the same level as the menu. The default
              // Material design is one that it is a part of the body, but this
              // works better if we also show a bottom navigation bar together
              // with the sidebar and it works better with the built-in
              // FAB locations.
              if (widget.destinations[_selectedIndex].hasSidebar &&
                  widget.sidebar != null &&
                  !widget.sidebarBelongsToBody)
                ConstrainedBox(
                  constraints:
                      BoxConstraints(maxWidth: flexTheme.sidebarWidth!),
                  child: Material(
                    color: flexTheme.sidebarBackgroundColor,
                    elevation: flexTheme.sidebarElevation!,
                    child: FlexSidebar(
                      sidebarIcon: widget.sidebarIcon,
                      sidebarIconExpand: widget.sidebarIconExpand,
                      sidebarIconExpandHidden: widget.sidebarIconExpandHidden,
                      sidebarIconCollapse: widget.sidebarIconCollapse,
                      sidebarToggleEnabled: widget.sidebarControlEnabled,
                      // If no Sidebar AppBar is provided we make a default one.
                      sidebarAppBar: widget.sidebarAppBar ?? const FlexAppBar(),
                      sidebarBelongsToBody: widget.sidebarBelongsToBody,
                      hasAppBar: widget.destinations[_selectedIndex].hasAppBar,
                      child: widget.sidebar,
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

// ****************************************************************************
// Build the widgets for the Flexfold scaffold
// ****************************************************************************

  Widget _buildMenu(BuildContext context) {
    return FlexMenu(
      destinations: widget.destinations,
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: (int index) {
        // If we just clicked the current index we don't do anything
        if (index == widget.selectedIndex) return;

        setState(() {
          // After moving to a new destination, bottom bar is not scroll hidden.
          _scrollHiddenBottomBar = false;

          _selectedIndex = index;
          _indexMenu.setIndex(index);
          _target = widget.destinations[index];
          final int? bottomIndex = toBottomIndex(_target);
          _indexBottom.setIndex(bottomIndex);
          _isBottomTarget = bottomIndex != null;

          FlexNavigation source = FlexNavigation.rail;
          if (_isMenuInDrawer) source = FlexNavigation.drawer;
          if (_isMenuInMenu) source = FlexNavigation.menu;

          final bool preferPush =
              (_isPhone && widget.destinations[index].maybePush) ||
                  widget.destinations[index].alwaysPush;

          // Make tap destination data to return
          final FlexDestinationTarget destination = FlexDestinationTarget(
            index: _selectedIndex,
            bottomIndex: bottomIndex,
            route: widget.destinations[index].route,
            icon: widget.destinations[index].icon,
            selectedIcon: widget.destinations[index].selectedIcon,
            label: widget.destinations[index].label,
            source: source,
            reverse: _indexMenu.reverse,
            preferPush: preferPush,
          );
          widget.onDestination(destination);
          if (preferPush) _assumePushed();
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
          _hideMenu = value;
          if (widget.onHideMenu != null) widget.onHideMenu?.call(_hideMenu);
          if (_kDebugMe) {
            debugPrint('Flexfold() onHideMenu: $_hideMenu');
          }
        });
      },
      cycleViaDrawer: widget.cycleViaDrawer,
      preferRail: widget.preferRail,
      onPreferRail: (bool value) {
        setState(() {
          _preferRail = value;
          if (widget.onPreferRail != null) {
            widget.onPreferRail?.call(_preferRail);
          }
          if (_kDebugMe) {
            debugPrint('Flexfold() onPreferRail: $_preferRail');
          }
        });
      },
      showBottomDestinationsInDrawer: _showBottomDestinationsInDrawer,
    );
  }
}

/// Specifies a part of [FlexScaffoldState] to depend on.
///
/// [FlexScaffoldState] contains a large number of related properties.
/// Widgets frequently depend on only a few of these attributes. For example, a
/// widget that needs to
/// rebuild when the [MediaQueryData.textScaleFactor] changes does not need to
/// be notified when the [MediaQueryData.size] changes. Specifying an aspect avoids
/// unnecessary rebuilds.
enum _FlexScaffoldAspect {
  /// Specifies the aspect corresponding to [FlexScaffoldState.isMenuInDrawer].
  isMenuInDrawer,

  /// Specifies the aspect corresponding to [FlexScaffoldState.menuIsHidden].
  menuIsHidden,

  /// Specifies the aspect corresponding to [FlexScaffoldState.menuPrefersRail].
  menuPrefersRail,

  /// Specifies the aspect corresponding to
  /// [FlexScaffoldState.isSidebarInEndDrawer].
  isSidebarInEndDrawer,

  /// Specifies the aspect corresponding to [FlexScaffoldState.isSidebarInMenu].
  isSidebarInMenu,

  /// Specifies the aspect corresponding to [FlexScaffoldState.sidebarIsHidden].
  sidebarIsHidden,

  /// Specifies the aspect corresponding to
  /// [FlexScaffoldState.currentImpliedTitle].
  currentImpliedTitle,

  /// Specifies the aspect corresponding to [FlexScaffoldState.isBottomTarget].
  isBottomTarget,

  /// Specifies the aspect corresponding to
  /// [FlexScaffoldState.isBottomBarVisible].
  isBottomBarVisible,

  /// Specifies the aspect corresponding to
  /// [FlexScaffoldState.isBottomBarScrollHidden].
  isBottomBarScrollHidden,

  /// Specifies the aspect corresponding to [FlexScaffoldState.indexBottom].
  indexBottom,

  /// Specifies the aspect corresponding to
  /// [FlexScaffoldState.bottomDestinations].
  bottomDestinations,
}

/// FlexScaffold implementation of InheritedWidget.
///
/// Used for to find the current FlexScaffold in the widget tree. This is useful
/// when reading FlexScaffold properties and using it methods from anywhere
/// in your app.
class _InheritedFlexScaffold extends InheritedWidget {
  /// Data is the entire FlexScaffoldState.
  final FlexScaffoldState data;

  /// You must pass through a child and your state.
  const _InheritedFlexScaffold({
    required this.data,
    required super.child,
  });

  /// We only notify [FlexScaffoldState] descendants of changes that needs to
  /// be used and tracked by its own sub widgets and custom widget usage.
  ///
  /// If some additional properties needs change notification raise issue/PR.
  @override
  bool updateShouldNotify(_InheritedFlexScaffold oldWidget) {
    if (oldWidget.data.isMenuInDrawer != data.isMenuInDrawer ||
        oldWidget.data.menuIsHidden != data.menuIsHidden ||
        oldWidget.data.menuPrefersRail != data.menuPrefersRail ||
        //
        oldWidget.data.isSidebarInEndDrawer != data.isSidebarInEndDrawer ||
        oldWidget.data.isSidebarInMenu != data.isSidebarInMenu ||
        oldWidget.data.sidebarIsHidden != data.sidebarIsHidden ||
        //
        oldWidget.data.currentImpliedTitle != data.currentImpliedTitle ||
        //
        // oldWidget.data.isBottomTarget != data.isBottomTarget ||
        // oldWidget.data.isBottomBarVisible != data.isBottomBarVisible ||
        oldWidget.data.isBottomBarScrollHidden !=
            data.isBottomBarScrollHidden ||
        //
        oldWidget.data.indexBottom != data.indexBottom ||
        oldWidget.data.bottomDestinations != data.bottomDestinations ||
        //
        oldWidget.data.widget.destinations != data.widget.destinations ||
        //
        oldWidget.data.widget.menuIcon != data.widget.menuIcon ||
        oldWidget.data.widget.menuIconExpand != data.widget.menuIconExpand ||
        oldWidget.data.widget.menuIconExpandHidden !=
            data.widget.menuIconExpandHidden ||
        oldWidget.data.widget.menuIconCollapse !=
            data.widget.menuIconCollapse ||
        //
        oldWidget.data.widget.sidebarIcon != data.widget.sidebarIcon ||
        oldWidget.data.widget.sidebarIconExpand !=
            data.widget.sidebarIconExpand ||
        oldWidget.data.widget.sidebarIconExpandHidden !=
            data.widget.sidebarIconExpandHidden ||
        oldWidget.data.widget.sidebarIconCollapse !=
            data.widget.sidebarIconCollapse ||
        //
        oldWidget.data.widget.cycleViaDrawer != data.widget.cycleViaDrawer ||
        oldWidget.data.widget.sidebarBelongsToBody !=
            data.widget.sidebarBelongsToBody ||
        //
        oldWidget.data.widget.menuControlEnabled !=
            data.widget.menuControlEnabled ||
        oldWidget.data.widget.sidebarControlEnabled !=
            data.widget.sidebarControlEnabled) {
      return true;
    }
    return false;
  }
}

/// A bottom bar wrapper used by [FlexScaffold] to use and operate the
/// default built-in and custom bottom navigation options in Flutter.
///
/// It can also use custom navigation bars and pre-made packages, by passing
/// it in using appropriate FlexScaffold features in its destinations, index and
/// on change callbacks.
///
/// See the example for how to use FlexScaffold with a few custom bottom
/// navigation bar packages.
class _FlexScaffoldBottomBar extends StatelessWidget {
  /// Default constructor for [_FlexScaffoldBottomBar].
  const _FlexScaffoldBottomBar({
    required this.isBottomTarget,
    required this.isBottomBarVisible,
    this.customNavBar,
  });

  final bool isBottomTarget;
  final bool isBottomBarVisible;
  final Widget? customNavBar;

  @override
  Widget build(BuildContext context) {
    // Current platform and useMaterial3?
    final ThemeData theme = Theme.of(context);
    final TargetPlatform platform = theme.platform;
    final bool useMaterial3 = theme.useMaterial3;

    // Get the custom Flexfold theme, closest inherited one.
    final FlexScaffoldThemeData flexTheme = FlexScaffoldTheme.of(context);
    // Resolve the effective bottom bar type
    FlexfoldBottomBarType effectiveType =
        flexTheme.bottomBarType ?? FlexfoldBottomBarType.adaptive;
    if (effectiveType == FlexfoldBottomBarType.adaptive) {
      if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
        effectiveType = FlexfoldBottomBarType.cupertino;
      } else {
        effectiveType = useMaterial3
            ? FlexfoldBottomBarType.material3
            : FlexfoldBottomBarType.material2;
      }
    }
    if (_kDebugMe) {
      debugPrint('FlexScaffoldBottomBar: effectiveType = $effectiveType');
    }
    // The height of the bottom nav bars may differ, we need
    // to get the correct height for the effective bottom nav bar.
    final double effectiveToolBarHeight =
        effectiveType == FlexfoldBottomBarType.material2
            ? kBottomNavigationBarHeight
            : effectiveType == FlexfoldBottomBarType.material3
                ? (NavigationBarTheme.of(context).height ??
                    kFlexfoldNavigationBarHeight)
                : kFlexfoldCupertinoTabBarHeight;

    final FlexScaffoldState flexScaffold = FlexScaffold.of(context);

    // If we are not at a destination that is defined to be a bottom target,
    // we are not inserting a bottom nav bar in the widget tree all
    return isBottomTarget
        // This setup with an animated size, with a wrap inside the AnimatedSize
        // that contains the used bottom navigation bar looks like the bottom
        // bar slides down and away when you do that in a Wrap that goe to zero
        // height.
        //
        // The effective height in the type of bottom bar also animate between
        // the different sizes the bottom bar has, so when the type is changed
        // if they have different sizes, which Material and Cupertino does, the
        // toggle between them is animated.
        // It is just cool bonus effect of this setup.
        ? AnimatedSize(
            duration: flexTheme.bottomBarAnimationDuration!,
            curve: flexTheme.bottomBarAnimationCurve!,
            child: SizedBox(
              height: isBottomBarVisible ? effectiveToolBarHeight : 0.0,
              child: Wrap(
                children: <Widget>[
                  if (customNavBar == null)
                    if (effectiveType == FlexfoldBottomBarType.cupertino)
                      CupertinoBottomBar(
                        destinations: flexScaffold.bottomDestinations,
                        selectedIndex: flexScaffold.indexBottom.index,
                        onDestinationSelected:
                            flexScaffold.navigateToBottomIndex,
                      )
                    else if (effectiveType == FlexfoldBottomBarType.material3)
                      Material3BottomBar(
                        destinations: flexScaffold.bottomDestinations,
                        selectedIndex: flexScaffold.indexBottom.index,
                        onDestinationSelected:
                            flexScaffold.navigateToBottomIndex,
                      )
                    else
                      Material2BottomBar(
                        destinations: flexScaffold.bottomDestinations,
                        selectedIndex: flexScaffold.indexBottom.index,
                        onDestinationSelected:
                            flexScaffold.navigateToBottomIndex,
                      )
                  else
                    customNavBar!,
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
