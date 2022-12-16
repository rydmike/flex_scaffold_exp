import 'package:flutter/foundation.dart' show Diagnosticable, kDebugMode;
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
import 'flex_theme_extension.dart';

// ignore_for_file: comment_references

// Set to true to observe debug prints. In release mode this compile time
// const always evaluate to false, so in theory anything with only an
// if (_kDebugMe) {} should get tree shaken away totally in a release build.
const bool _kDebugMe = kDebugMode && true;

// TODO(rydmike): Review existing implementations.
// - Add a controller that contain menu of the control properties?
// - Or keep as is?
// - See controller in eg.
//   * https://pub.dev/packages/sidebarx
//   * https://pub.dev/packages/scroll_bottom_navigation_bar scroll controller.
//
// Examples of sidebars/menus:
// - https://pub.dev/packages/sidebarx 212 like
// - https://pub.dev/packages/side_navigation 78 likes
// - https://pub.dev/packages/easy_sidemenu 178 likes
// - https://pub.dev/packages/flutter_side_menu 12 likes
// - https://pub.dev/packages/navigation_drawer_menu 23 likes (findlay)
// -
//
// Examples of adaptive scaffold:
// - by Flutter https://pub.dev/packages/flutter_adaptive_scaffold 120 likes
// - by material.io https://pub.dev/packages/adaptive_navigation 96 likes
// - https://pub.dev/packages/flutter_admin_scaffold 124 likes
// - Rody's thing no-NS https://pub.dev/packages/responsive_scaffold 172 likes
// - https://pub.dev/packages/auto_scaffold
// - https://pub.dev/packages/adaptive_scaffold 10 likes
// - https://pub.dev/packages/scaffold_responsive 15 likes
//
// - https://pub.dev/packages/master_detail_scaffold 18 likes
// - by material.io https://pub.dev/packages/adaptive_components 56 like
//
// Example of bottom navigation bars:
// - Flutter favorite: https://pub.dev/packages/convex_bottom_bar 2037 likes
// - https://pub.dev/packages/persistent_bottom_nav_bar 1580 likes
// - https://pub.dev/packages/curved_navigation_bar. Nice 1542 likes
// - https://pub.dev/packages/bottom_navy_bar 1068 likes
// - https://pub.dev/packages/google_nav_bar design Salomon, 969 likes (nice)
// - https://pub.dev/packages/animated_bottom_navigation_bar 728 likes
// - https://pub.dev/packages/salomon_bottom_bar by Luke Pighetti 626 likes
// - https://pub.dev/packages/custom_navigation_bar 407 likes
// - https://pub.dev/packages/flutter_snake_navigationbar 495 likes
// - https://pub.dev/packages/dot_navigation_bar floating, not bottom? 237 likes
// - https://pub.dev/packages/fancy_bottom_navigation 221 likes
// - https://pub.dev/packages/scroll_bottom_navigation_bar 133 like
// - https://pub.dev/packages/responsive_navigation_bar 28 likes

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
    // this.flexfoldTheme,
    //
    // The main app bar for the body part of the scaffold
    this.appBar,
    //
    // Destination properties for the menu, rail and bottom navigation bar.
    required this.destinations,
    required this.selectedIndex,
    required this.onDestination,
    // Default to using first module.
    // TODO(rydmike): Implement modules.
    this.activeModule = 0,
    // Menu, its control and content properties, other than the destinations.
    required this.menu,
    this.menuControlEnabled = true,
    this.menuIcon,
    this.menuIconExpand,
    this.menuIconCollapse,
    this.menuIconExpandHidden,
    // Menu state properties and its callbacks.
    this.menuHide = false,
    this.onMenuHide,
    this.menuPrefersRail = false,
    this.onMenuPrefersRail,
    // Behaviour for menu and sidebar.
    this.cycleViaDrawer = true,
    //
    // Sidebar, its control and icons.
    this.sidebar,
    this.sidebarControlEnabled = true,
    this.sidebarIcon,
    this.sidebarIconExpand,
    this.sidebarIconExpandHidden,
    this.sidebarIconCollapse,
    // Sidebar state properties and its callback.
    this.sidebarHide = false,
    this.onSidebarHide,
    this.sidebarBelongsToBody = false,
    //
    // Bottom navigation bar properties.
    this.hideBottomBar = false,
    this.showBottomBarWhenMenuInDrawer = false,
    this.showBottomBarWhenMenuShown = false,
    this.bottomDestinationsInDrawer = false,
    this.customBottomNavigator,
    this.customNavigationBarHeight,
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

  // /// The theme for the [FlexScaffold] scaffold.
  // ///
  // /// The theme contains a large number of style and other properties that
  // /// can be modified modify to customize the look of the [FlexScaffold]
  // /// responsive scaffold. See [FlexScaffoldThemeData] for more details.
  // ///
  // /// Changes to passed in theme's properties are animated. Changes to a
  // /// FlexfoldTheme higher up in the widget tree that Flexfold inherits it theme
  // /// from will also animate the properties in Flexfold that depends on the
  // /// inherited theme data. The passed in theme is merged with any inherited
  // /// theme.
  // final FlexScaffoldThemeData? flexfoldTheme;

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
  final ValueChanged<GoFlexDestination> onDestination;

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

  /// The widget used by [FlexScaffold] to show the content used in the
  /// rail, side menu and drawer.
  ///
  /// Typically a [FlexMenu].
  ///
  /// It can have an AppBar, leading, trailer and footer widget.
  ///
  /// By default it builds its own menu items from [FlexScaffold.destinations],
  /// but it is possible to provide a custom menu as well. You might not need to
  /// as the [FlexMenu] default menu is pretty configurable.
  ///
  /// If you make a custom rail/menu or use a package for one you can use the
  /// Flutter [NavigationRail] example as a guide for how to implement it.
  final Widget menu;

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

  /// A Widget used on the menu button when the menu is operated as a Drawer.
  ///
  /// Typically an [Icon] widget is used with the hamburger menu icon.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, it defaults to a widget
  /// with value [kFlexfoldMenuIcon], the hamburger icon.
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? menuIcon;

  /// A widget used on an opened drawer menu button when operating it will
  /// change it to a side menu.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [menuIcon] was not
  /// defined, it defaults to a widget with value [kFlexfoldMenuIconExpand].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? menuIconExpand;

  /// A widget used on the menu button when operating it will expand the
  /// menu to a rail or to a side menu.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [menuIcon] was not
  /// defined, it defaults to a widget with value
  /// [kFlexfoldMenuIconExpandHidden].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? menuIconExpandHidden;

  /// A widget used on the menu button when it is shown as a menu or rail,
  /// and operating it will collapse it to its next state, from menu to rail to
  /// hidden.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [menuIcon] was not
  /// defined, it defaults to a widget with value [kFlexfoldMenuIconCollapse].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? menuIconCollapse;

  /// Keep main menu hidden in a drawer, even when its breakpoints are exceeded.
  ///
  /// When true, both the rail and menu will be kept hidden in the drawer, even
  /// if the breakpoint for rail or breakpoint for menu have both been exceeded.
  final bool menuHide;

  /// Callback that is called when menu is hidden via its menu button control.
  ///
  /// This callback together with its sett [menuHide] can be used if you
  /// want to control hiding and showing the menu from an external control,
  /// like a user controlled [Switch], you can then use this callback to change
  /// the state of such a switch when user has operated hiding/showing the menu
  /// via its menu control button.
  final ValueChanged<bool>? onMenuHide;

  /// Prefer rail as size for the menu.
  ///
  /// When the menu is locked on screen and it is shown, it will remain as a
  /// rail even if the menu breakpoint is exceeded and it should be shown as a
  /// menu, based on defined breakpoint value for when the rail changes to menu.
  final bool menuPrefersRail;

  /// Callback that is called when prefer rail changes.
  ///
  /// Can be used to control and preferRail, via a toggle Switch externally.
  final ValueChanged<bool>? onMenuPrefersRail;

  /// Cycle via Drawer when opening a hidden menu, rail or sidebar.
  ///
  /// When the menu or sidebar can be locked on screen, as a rail, menu or
  /// sidebar, and we expand it again, it first cycles via the Drawer if true.
  ///
  /// If set to false it skips the cycle via the drawer and expands it directly
  /// to a rail, menu or sidebar, depending on current screen width and if it is
  /// larger than the breakpoint for menu or not. If screen width is below rail
  /// breakpoint this setting has no effect, the only way to show the menu is
  /// as a drawer, so the drawer will be opened.
  ///
  /// Affects both drawer and sidebar end drawer.
  final bool cycleViaDrawer;

  /// The end drawer and sidebar, often used as a tools menu, filters etc.
  ///
  /// Typically a [FlexSidebar], but you can make a custom version of it too.
  ///
  /// It can have a FlexAppBar and child widget.
  final Widget? sidebar;

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

  /// A Widget used on the sidebar button when the sidebar is operated as an
  /// end Drawer.
  ///
  /// Typically an [Icon] widget is used with the hamburger menu icon.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, it defaults to a widget
  /// with value [kFlexfoldSidebarIcon], the hamburger icon.
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? sidebarIcon;

  /// A widget used on an opened end drawer sidebar button when operating it
  /// will change it to a fixed sidebar.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [menuIcon] was not
  /// defined, it defaults to a widget with value [kFlexfoldSidebarIconExpand].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? sidebarIconExpand;

  /// A widget used on the sidebar button when operating it will expand the
  /// hidden sidebar to a fixed side menu.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [menuIcon] was not
  /// defined, it defaults to a widget with value
  /// [kFlexfoldSidebarIconExpandHidden].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? sidebarIconExpandHidden;

  /// A widget used on the sidebar button when it is shown as a fixed sidebar,
  /// and operating it will collapse it to its hidden state.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [menuIcon] was not
  /// defined, it defaults to a widget with value
  /// [kFlexfoldSidebarIconCollapse].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? sidebarIconCollapse;

  /// Keep sidebar hidden in an end drawer, even when its breakpoint is
  /// exceeded.
  final bool sidebarHide;

  /// Callback that is called when [sidebarHide] changes
  final ValueChanged<bool>? onSidebarHide;

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
  /// The type is determined by [FlexScaffoldThemeData.bottomType], which
  /// defaults to [FlexfoldBottomBarType.adaptive]. Which will result in
  /// [CupertinoTabBar] on iOS and macOS and other platforms in
  /// [BottomNavigationBar] if [ThemeData.useMaterial3] is false and in
  /// [NavigationBar] if [ThemeData.useMaterial3] is true.
  final Widget? customBottomNavigator;

  /// The height of the custom navigation bar.
  ///
  /// If not provided it assumed to be same height as Material 2 bottom
  /// navigation bar height, which is [kBottomNavigationBarHeight].
  final double? customNavigationBarHeight;

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

  // TODO(rydmike): Remove the build flag when sure it is not needed.

  /// Finds the [FlexScaffoldState] from the closest instance of this class that
  /// encloses the given context.
  ///
  /// If no instance of this class encloses the given context, will cause an
  /// assert in debug mode, and throw an exception in release mode.
  ///
  /// This method can be expensive (it walks the element tree).
  ///
  /// Typical usage of the [FlexScaffold.use] function is to call it from
  /// within the `build` method of a child of a [FlexScaffold].
  ///
  /// The [FlexScaffold.use] will only read and use the current
  /// [FlexScaffoldState], give you access to its state methods and
  /// [StatefulWidget] properties. Changes to widget properties will
  /// no trigger rebuilds, but if needed you can get access to them.
  /// The [FlexScaffold.use] is primarily intended to be used to get
  /// access to methods on the state of the inherited [FlexScaffoldState].
  /// To listen to properties in the in [FlexScaffold]'s [StatefulWidget]
  /// and rebuild as they change individually, use the [FlexScaffold.aspectOf]
  /// of properties, like e.g. [FlexScaffold.isMenuHiddenOf].
  /// Such properties and the [FlexScaffoldState]
  ///
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
  /// widgets, and then in these inner widgets you would use [FlexScaffold.use].
  ///
  /// A less elegant but more expedient solution is assign a [GlobalKey] to the
  /// [FlexScaffold], then use the `key.currentState` property to obtain the
  /// [FlexScaffoldState] rather than using the [FlexScaffold.use] function.
  ///
  /// If there is no [FlexScaffold] in scope, then this will throw an exception.
  static FlexScaffoldState use(BuildContext context, {bool build = false}) {
    final _InheritedFlexScaffold? result = build
        ? context.dependOnInheritedWidgetOfExactType<_InheritedFlexScaffold>()
        : context.findAncestorWidgetOfExactType<_InheritedFlexScaffold>();
    if (result != null) {
      return result.data;
    }
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
        'FlexScaffold.use() called with a context that does not '
        'contain a FlexScaffold.',
      ),
      ErrorDescription(
        'No FlexScaffoldState ancestor could be found starting from the '
        'context that was passed to FlexScaffold.use(). '
        'This usually happens when the context provided is from the same '
        'StatefulWidget as that whose build function actually creates the '
        'FlexScaffold widget being sought.',
      ),
      ErrorHint(
        'There are several ways to avoid this problem. The simplest is to use '
        'a Builder to get a context that is "under" the FlexScaffold.',
      ),
      ErrorHint(
        'A more efficient solution is to split your build function into '
        'several widgets. This introduces a new context from which you can '
        'obtain the FlexScaffold. In this solution, you would have an outer '
        'widget that creates the FlexScaffold populated by instances of '
        'your new inner widgets, and then in these inner widgets you would use '
        'FlexScaffold.use().\n'
        'A less elegant but more expedient solution is assign a GlobalKey to '
        'the FlexScaffold, then use the key.currentState property to obtain '
        'the FlexScaffoldState rather than using the FlexScaffold.use() '
        'function.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  // TODO(rydmike): Remove function, probably not needed at all.

  /// Finds the [FlexScaffoldState] from the closest instance of this class that
  /// encloses the given context.
  ///
  /// If no instance of this class encloses the given context, will return null.
  /// To throw an exception instead, use [use] instead of this function.
  ///
  /// This method can be expensive (it walks the element tree).
  ///
  /// See also:
  ///
  ///  * [use], a similar function to this one that throws if no instance
  ///    encloses the given context.
  static FlexScaffoldState? maybeUse(BuildContext context,
      {bool build = false}) {
    return build
        ? context
            .dependOnInheritedWidgetOfExactType<_InheritedFlexScaffold>()
            ?.data
        : context.findAncestorWidgetOfExactType<_InheritedFlexScaffold>()?.data;
  }

  // TODO(rydmike): Add throw error like on [use] function above.
  /// A helper to make it easier to create model property aspectOf dependents.
  static _FlexScaffoldData _of(BuildContext context,
      [_FlexScaffoldAspect? aspect]) {
    return InheritedModel.inheritFrom<_FlexScaffoldModel>(context,
            aspect: aspect)!
        .data;
  }

  /// Returns true if the [FlexScaffold] menu is in the drawer.
  static bool isMenuInDrawerOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.isMenuInDrawer).isMenuInDrawer;

  /// Returns true if the [FlexScaffold] menu is hidden.
  ///
  /// The menu can be hidden either via internal menu toggle, or
  /// [FlexScaffold.menuHide] can be set to true.
  static bool isMenuHiddenOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.isMenuHidden).isMenuHidden;

  /// Returns true if the [FlexScaffold] menu prefers to stay as a rail.
  static bool menuPrefersRailOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.menuPrefersRail).menuPrefersRail;

  /// Returns true if the [FlexScaffold] sidebar is in the end drawer.
  static bool isSidebarInEndDrawerOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.isSidebarInEndDrawer)
          .isSidebarInEndDrawer;

  /// Returns true if the [FlexScaffold] sidebar is a menu sidebar.
  static bool isSidebarInMenuOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.isSidebarInMenu).isSidebarInMenu;

  /// Returns true if the [FlexScaffold] sidebar is hidden.
  ///
  /// The sidebar can be hidden either via internal sidebar toggle, or
  /// [FlexScaffold.sidebarHide] can be set to true.
  static bool isSidebarHiddenOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.isSidebarHidden).isSidebarHidden;

  /// Returns true if the [FlexScaffold] menu manual control is enabled.
  static bool menuControlEnabledOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.menuControlEnabled).menuControlEnabled;

  /// Returns true if the [FlexScaffold] sidebar manual control is enabled.
  static bool sidebarControlEnabledOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.sidebarControlEnabled)
          .sidebarControlEnabled;

  /// Returns true if the [FlexScaffold] menu and sidebar ar set to cycle
  /// via a drawer before expanding back to fixed menu or sidebar.
  ///
  /// When it is false, the menu and sidebar do not show up as a Drawer or
  /// end Drawer if the breakpoints for being a menu or sidebar have been
  /// exceeded.
  static bool cycleViaDrawerOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.cycleViaDrawer).cycleViaDrawer;

  /// Returns true if the [FlexScaffold] menu is rendered as a part
  /// of the underlying scaffold.
  ///
  /// If false the menu is a row and with the underlying Scaffold on the side.
  static bool menuBelongsToBodyOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.menuBelongsToBody).menuBelongsToBody;

  /// Returns true if the [FlexScaffold] sidebar is rendered as a part
  /// of the underlying scaffold.
  ///
  /// If false the menu is a row and with the underlying Scaffold on the side.
  static bool sidebarBelongsToBodyOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.sidebarBelongsToBody)
          .sidebarBelongsToBody;

  // TODO(rydmike): Consider using selectedDestinationOf or onDestinationOf?
  /// Returns true if the [FlexScaffold] currently selected item is a bottom
  /// navigation target.
  static bool isBottomTargetOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.isBottomTarget).isBottomTarget;

  /// Returns true if the [FlexScaffold] bottom navigation bar is visisble.
  static bool isBottomBarVisibleOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.isBottomBarVisible).isBottomBarVisible;

  /// Returns the [FlexScaffold]'s currently selected index.
  static int selectedIndexOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.selectedIndex).selectedIndex;

  /// Returns true if the [FlexScaffold] is currently showing its bottom
  /// navigation destinations in the drawer.
  static bool showBottomDestinationsInDrawerOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.showBottomDestinationsInDrawer)
          .showBottomDestinationsInDrawer;

  /// Returns the currently selected [GoFlexDestination] definition of the
  /// [FlexScaffold], as defined by [FlexScaffoldState.widget] and
  /// [selectedIndex].
  static GoFlexDestination selectedDestinationOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.selectedDestination).selectedDestination;

  /// Returns the latest [GoFlexDestination] definition used in the
  /// [FlexScaffold.onDestinationOf] callback.
  ///
  /// This is different from the [selectedDestinationOf] as it is the selection
  /// before it has been fed back into the [FlexScaffold] via
  /// [FlexScaffold.selectedIndex].
  static GoFlexDestination onDestinationOf(BuildContext context) =>
      _of(context, _FlexScaffoldAspect.onDestination).onDestination;

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
/// [BuildContext] using [FlexScaffold.use].
class FlexScaffoldState extends State<FlexScaffold> {
  // Use an inherited model of key properties to propagate them down the tree.
  static const _FlexScaffoldData _data = _FlexScaffoldData();
  // State that might be changed via widget
  late int _selectedIndex;
  final IndexTracker _indexMenu = IndexTracker();
  final IndexTracker _indexBottom = IndexTracker();
  late FlexDestination _target;
  late bool _isMenuHidden;
  late bool _isSidebarHidden;
  late bool _menuPrefersRail;
  late bool _isBottomTarget;
  late bool _scrollHiddenBottomBar;
  late List<FlexDestination> _bottomDestinations;
  double _breakpointSidebar = kFlexfoldBreakpointSidebar;
  double _width = 600;

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
  GoFlexDestination _onDestination = const GoFlexDestination();
  GoFlexDestination _selectedDestination = const GoFlexDestination();

  /// Set the FlexScaffold menu to be hidden. If set to false, the menu will be
  /// shown as a rail or menu when it should, based on its breakpoints.
  void hideMenu(bool value) {
    if (value != _isMenuHidden) {
      setState(() {
        _isMenuHidden = value;
        _scrollHiddenBottomBar = false;
        widget.onMenuHide?.call(value);
        if (_kDebugMe) {
          debugPrint('FlexScaffold: hideMenu set to $_isMenuHidden');
        }
      });
    }
  }

  /// Set the FlexScaffold menu to prefer rail state.
  void setMenuPrefersRail(bool value) {
    setState(() {
      _menuPrefersRail = value;
      widget.onMenuPrefersRail?.call(value);
      if (_kDebugMe) {
        debugPrint('FlexScaffold: menuPrefersRail set to $_menuPrefersRail');
      }
    });
  }

  /// Set the FlexScaffold sidebar to be hidden. If set to false, the sidebar
  /// will be shown when it should automatically, based on its breakpoint.
  void hideSidebar(bool value) {
    setState(() {
      _isSidebarHidden = value;
      _isSidebarInEndDrawer =
          (value || _width < _breakpointSidebar || _isSidebarHidden) &&
              widget.destinations[_selectedIndex].hasSidebar &&
              widget.sidebar != null;
      widget.onSidebarHide?.call(value);
      if (_kDebugMe) {
        debugPrint('FlexScaffold: sidebarIsHidden set to $_isSidebarHidden');
      }
    });
  }

  /// Returns the implied AppBar string title for current destination
  String get currentImpliedTitle =>
      widget.destinations[widget.selectedIndex].label;

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

  /// Set menu/rail selected index to given index value on current
  /// [FlexScaffoldState].
  ///
  /// Triggers call to [FlexScaffold.onDestination] with new destination info.
  void setSelectedIndex(int index) {
    // If we just clicked the current index we don't do anything
    if (index == widget.selectedIndex) return;
    setState(() {
      // After moving to a new destination, ensure that the bottom
      // navigation bar is never scroll hidden.
      _scrollHiddenBottomBar = false;
      _selectedIndex = index;
      _target = widget.destinations[_selectedIndex];
      _indexMenu.setIndex(_selectedIndex);
      final int? bottomIndex = toBottomIndex(_target);
      _indexBottom.setIndex(bottomIndex);
      _isBottomTarget = bottomIndex != null;
      FlexNavigation source = FlexNavigation.rail;
      if (_isMenuInDrawer) source = FlexNavigation.drawer;
      if (_isMenuInMenu) source = FlexNavigation.menu;
      final bool preferPush =
          (_isPhone && widget.destinations[_selectedIndex].maybePush) ||
              widget.destinations[_selectedIndex].alwaysPush;
      // Make destination data to return in onDestination call.
      final GoFlexDestination destination = GoFlexDestination(
        index: _selectedIndex,
        bottomIndex: bottomIndex,
        route: widget.destinations[_selectedIndex].route,
        icon: widget.destinations[_selectedIndex].icon,
        selectedIcon: widget.destinations[_selectedIndex].selectedIcon,
        label: widget.destinations[_selectedIndex].label,
        source: source,
        reverse: _indexMenu.reverse,
        preferPush: preferPush,
        hasAppBar: widget.destinations[_selectedIndex].hasAppBar,
      );
      widget.onDestination(destination);
      _onDestination = destination;
      if (_kDebugMe) {
        debugPrint('FlexScaffold: navigate to bottom $_target');
      }
      if (preferPush) _assumePushed();
    });
  }

  /// Set bottom index to given index value on current [FlexScaffoldState].
  ///
  /// Triggers call to [FlexScaffold.onDestination] with new destination info.
  void setBottomIndex(int index) {
    // If we click the current index we don't do anything
    if (index == _indexBottom.index) return;
    setState(
      () {
        // After moving to a new destination, ensure that the bottom
        // navigation bar is never scroll hidden.
        _scrollHiddenBottomBar = false;
        _target = bottomDestinations[index];
        _indexBottom.setIndex(index);
        _selectedIndex = toMenuIndex(_target);
        _indexMenu.setIndex(_selectedIndex);
        // Make tap destination data to return
        final GoFlexDestination destination = GoFlexDestination(
          index: _selectedIndex,
          bottomIndex: index,
          route: widget.destinations[_selectedIndex].route,
          icon: widget.destinations[_selectedIndex].icon,
          selectedIcon: widget.destinations[_selectedIndex].selectedIcon,
          label: widget.destinations[_selectedIndex].label,
          reverse: _indexMenu.reverse,
          source: FlexNavigation.bottom,
          hasAppBar: widget.destinations[_selectedIndex].hasAppBar,
        );
        widget.onDestination(destination);
        _onDestination = destination;
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

  /// Create a [GoFlexDestination] from a [route], with
  /// optional values for navigation source and reverse direction.
  ///
  /// The String [route] is required.
  GoFlexDestination fromRoute(
    String route, {
    FlexNavigation source = FlexNavigation.custom,
    bool reverse = false,
    bool preferPush = false,
  }) {
    // Get the destination
    final FlexDestination destination = forRoute(route);
    final int index = toMenuIndex(destination);
    return GoFlexDestination(
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
    _isMenuHidden = widget.menuHide;
    _isSidebarHidden = widget.sidebarHide;
    _menuPrefersRail = widget.menuPrefersRail;
    _scrollHiddenBottomBar = false;
    // Selected destination.

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
      FlexNavigation source = FlexNavigation.rail;
      if (_isMenuInDrawer) source = FlexNavigation.drawer;
      if (_isMenuInMenu) source = FlexNavigation.menu;
      final bool preferPush =
          (_isPhone && widget.destinations[_selectedIndex].maybePush) ||
              widget.destinations[_selectedIndex].alwaysPush;
      _selectedDestination = GoFlexDestination(
        index: _selectedIndex,
        bottomIndex: bottomIndex,
        route: widget.destinations[_selectedIndex].route,
        icon: widget.destinations[_selectedIndex].icon,
        selectedIcon: widget.destinations[_selectedIndex].selectedIcon,
        label: widget.destinations[_selectedIndex].label,
        source: source,
        reverse: _indexMenu.reverse,
        preferPush: preferPush,
        hasAppBar: widget.destinations[_selectedIndex].hasAppBar,
      );
    }
    if (widget.menuHide != oldWidget.menuHide) {
      _isMenuHidden = widget.menuHide;
    }
    if (widget.sidebarHide != oldWidget.sidebarHide) {
      _isSidebarHidden = widget.sidebarHide;
    }
    if (widget.menuPrefersRail != oldWidget.menuPrefersRail) {
      _menuPrefersRail = widget.menuPrefersRail;
    }
    if (widget.destinations != oldWidget.destinations) {
      _bottomDestinations = widget.destinations
          .where((FlexDestination item) => item.inBottomNavigation)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the main surrounding theme
    final ThemeData theme = Theme.of(context);
    // Get effective FlexTheme:
    //  1. If one exist in Theme, use it, fill undefined props with default
    //  2. If no FlexTheme in Theme, fallback to one with all default values.
    final FlexTheme flexTheme =
        theme.extension<FlexTheme>()?.withDefaults(context) ??
            const FlexTheme().withDefaults(context);

    // // The passed in theme widget and its BottomNavigationBarThemeData have
    // // highest priority and its properties will be used first when not null.
    // final BottomNavigationBarThemeData? bottomWidget =
    //     widget.flexfoldTheme?.bottomNavigationBarTheme;
    // // The closest inherited Flexfold Theme has the 2nd highest prio for
    // // effective theme data.
    // final FlexScaffoldThemeData flexTheme = FlexScaffoldTheme.of(context);
    // // Get its bottom navigation bar theme
    // final BottomNavigationBarThemeData? bottomFlex =
    //     flexTheme.bottomNavigationBarTheme;
    // // The bottom navigation bar may as a 3rd prio option also get theme data
    // // from an inherited BottomNavigationBarTheme.
    // final BottomNavigationBarThemeData bottomBar =
    //     BottomNavigationBarTheme.of(context);
    // // Get the main surrounding theme
    // final ThemeData theme = Theme.of(context);
    // // As 4th and last option the bottom navigation bar may get theme data
    // // from the bottomNavigationBarTheme property in overall inherited Theme.
    // final BottomNavigationBarThemeData bottomTheme =
    //     theme.bottomNavigationBarTheme;
    // // Merge all bottom themes, we use the lowest prio as base, which is the
    // // bottomNavigationBarTheme from Theme.of(context) stored in [bottomTheme].
    // // Then we use any none null property value from highest to lowest priority
    // // from:
    // // 1. widget.theme.bottomNavigationBarTheme stored in bottomWidget
    // // 2. FlexfoldTheme.of(context).bottomNavigationBarTheme in bottomFlex
    // // 3. BottomNavigationBarTheme.of(context) stored in bottomBar
    // // 4. If appropriate, fallbacks from property values in Theme.of(context)
    // // 5. Last some hard coded default fallback values as defined for
    // // FlexfoldTheme. See [FlexfoldTheme] for details on default values.
    // final BottomNavigationBarThemeData effectiveBottomTheme =
    //     bottomTheme.copyWith(
    //   // IMPORTANT: Bottom nav background in FlexFoldTheme may still be null
    //   // after this. Need to check still in flex bottom widgets!
    //   backgroundColor: bottomWidget?.backgroundColor ??
    //       bottomFlex?.backgroundColor ??
    //       bottomBar.backgroundColor,
    //   elevation: bottomWidget?.elevation ??
    //       bottomFlex?.elevation ??
    //       bottomBar.elevation ??
    //       0,
    //   selectedIconTheme: bottomWidget?.selectedIconTheme ??
    //       bottomFlex?.selectedIconTheme ??
    //       bottomBar.selectedIconTheme ??
    //       IconThemeData(color: theme.colorScheme.primary),
    //   unselectedIconTheme: bottomWidget?.unselectedIconTheme ??
    //       bottomFlex?.unselectedIconTheme ??
    //       bottomBar.unselectedIconTheme,
    //   selectedItemColor: bottomWidget?.selectedItemColor ??
    //       bottomFlex?.selectedItemColor ??
    //       bottomBar.selectedItemColor ??
    //       theme.colorScheme.primary,
    //   unselectedItemColor: bottomWidget?.unselectedItemColor ??
    //       bottomFlex?.unselectedItemColor ??
    //       bottomBar.unselectedItemColor,
    //   selectedLabelStyle: bottomWidget?.selectedLabelStyle ??
    //       bottomFlex?.selectedLabelStyle ??
    //       bottomBar.selectedLabelStyle ??
    //       theme.primaryTextTheme.bodyText2!
    //           .copyWith(color: theme.colorScheme.primary),
    //   unselectedLabelStyle: bottomWidget?.unselectedLabelStyle ??
    //       bottomFlex?.unselectedLabelStyle ??
    //       bottomBar.unselectedLabelStyle,
    //   showSelectedLabels: bottomWidget?.showSelectedLabels ??
    //       bottomFlex?.showSelectedLabels ??
    //       bottomBar.showSelectedLabels ??
    //       true,
    //   showUnselectedLabels: bottomWidget?.showUnselectedLabels ??
    //       bottomFlex?.showUnselectedLabels ??
    //       bottomBar.showUnselectedLabels ??
    //       true,
    //   type: bottomWidget?.type ??
    //       bottomFlex?.type ??
    //       bottomBar.type ??
    //       BottomNavigationBarType.fixed,
    // );
    //
    // // Get Flexfold default theme data
    // final FlexScaffoldThemeData defaultFlexTheme =
    //     const FlexScaffoldThemeData().withDefaults(context);
    //
    // // Merge the other sub-themes than the Bottom navigation bar with
    // // the default values, first merge the inherited Flexfold sub theme
    // // values and then the sub theme values passed in via widget.theme
    // final TextStyle effectiveUnselectedLabelStyle = defaultFlexTheme
    //     .labelTextStyle!
    //     .merge(flexTheme.labelTextStyle)
    //     .merge(widget.flexfoldTheme!.labelTextStyle);
    //
    // final TextStyle effectiveSelectedLabelStyle = defaultFlexTheme
    //     .selectedLabelTextStyle!
    //     .merge(flexTheme.selectedLabelTextStyle)
    //     .merge(widget.flexfoldTheme!.selectedLabelTextStyle);
    //
    // final IconThemeData effectiveUnselectedIconTheme = defaultFlexTheme
    //     .iconTheme!
    //     .merge(flexTheme.iconTheme)
    //     .merge(widget.flexfoldTheme!.iconTheme);
    //
    // final IconThemeData effectiveSelectedIconTheme = defaultFlexTheme
    //     .selectedIconTheme!
    //     .merge(flexTheme.selectedIconTheme)
    //     .merge(widget.flexfoldTheme!.selectedIconTheme);
    //
    // final TextStyle effectiveHeadingTextStyle = defaultFlexTheme
    //     .headingTextStyle!
    //     .merge(flexTheme.headingTextStyle)
    //     .merge(widget.flexfoldTheme!.headingTextStyle);
    //
    // // Merge the inherited Flexfold theme with the default Flexfold theme.
    // final FlexScaffoldThemeData flexThemeMerged =
    //     defaultFlexTheme.merge(flexTheme);
    //
    // // Then merge widget passed in theme, with the above merge theme.
    // final FlexScaffoldThemeData fullFlexTheme =
    //     flexThemeMerged.merge(widget.flexfoldTheme);

    // Then the fully merged Flexfold theme gets a copy of all the effective
    // effective sub themes it contains, meaning the bottomNavigationBarTheme
    // and all effective text styles and icon themes.
    // This creates a theme that has all the ambient Flexfold theme data
    // and defaults as fallback, in a single summarized merged theme.
    // final FlexScaffoldThemeData effectiveFlexTheme = fullFlexTheme.copyWith(
    //   bottomNavigationBarTheme: effectiveBottomTheme,
    //   labelTextStyle: effectiveUnselectedLabelStyle,
    //   selectedLabelTextStyle: effectiveSelectedLabelStyle,
    //   iconTheme: effectiveUnselectedIconTheme,
    //   selectedIconTheme: effectiveSelectedIconTheme,
    //   headingTextStyle: effectiveHeadingTextStyle,
    // );

    // // Then make an animated FlexfoldTheme of the final effective theme.
    // return Theme(
    //   data: theme.copyWith(extensions: ),
    //   child: Builder(builder: (BuildContext context) {
    //     // We a use builder to ensure we have the fully merged FlexfoldTheme
    //     // next up in the Widget tree, that now also has all the default
    //     // values. By doing this we do not have to apply any defaults again in
    //     // the entire Flexfold widget tree and its descendants. They are now
    //     // guaranteed to with 'FlexfoldTheme.of(context)' get a theme
    //     // that has been fully merged with provided values in the property
    //     // passing and inheritance priority order we defined.
    //     //
    //     // The only values that may still be null after this merge are:
    //     // * FlexfoldTheme.menuBackgroundColor
    //     // * FlexfoldTheme.sidebar.BackgroundColor
    //     // * FlexfoldTheme.bottomNavigationBarTheme.backgroundColor
    //     //
    //     // This makes accessing the correct theme result further down the
    //     // widget tree easier, since we can always get it like this now:
    //     final FlexScaffoldThemeData flexTheme = FlexScaffoldTheme.of(context);

    assert(
        !(flexTheme.bottomType == FlexfoldBottomBarType.custom &&
            widget.customBottomNavigator == null),
        'If bottom navigation type is custom, you have to provide a '
        'custom bottom navigator to FlexScaffold.custom.');

    // TODO(rydmike): When MediaQuery as InheritedModel lands use it.
    //   reference: https://github.com/flutter/flutter/pull/114459
    // Get media width, height, and safe area padding
    assert(debugCheckHasMediaQuery(context),
        'A valid build context is required for the MediaQuery.');
    final MediaQueryData mediaData = MediaQuery.of(context);
    final double leftPadding = mediaData.padding.left;
    final double rightPadding = mediaData.padding.right;
    final double startPadding = Directionality.of(context) == TextDirection.ltr
        ? leftPadding
        : rightPadding;
    _width = mediaData.size.width;
    final double height = mediaData.size.height;

    // Based on width and breakpoint limit, this is a phone sized layout.
    _isPhone = _width < flexTheme.breakpointRail!;
    // Based on height and breakpoint, this is a phone landscape layout.
    _isPhoneLandscape = height < flexTheme.breakpointDrawer!;
    // Based on width & breakpoint limit, this is a desktop sized layout.
    _isDesktop = (_width >= flexTheme.breakpointMenu!) && !_isPhoneLandscape;
    // This is only based on that we are not doing phone or desktop size.
    _isTablet = !_isPhone && !_isDesktop;

    // The menu will exist as a Drawer widget in the widget tree.
    _isMenuInDrawer = _isPhone || widget.menuHide || _isPhoneLandscape;
    // The menu is shown as a full sized menu before the body.
    _isMenuInMenu = _isDesktop && !widget.menuHide && !widget.menuPrefersRail;
    // The sidebar will exist in an end Drawer widget in the widget tree.
    _isSidebarInEndDrawer =
        (_width < flexTheme.breakpointSidebar! || _isSidebarHidden) &&
            widget.destinations[_selectedIndex].hasSidebar &&
            widget.sidebar != null;
    // The sidebar is shown as a widget after the body.
    _breakpointSidebar = flexTheme.breakpointSidebar!;
    _isSidebarInMenu = _width >= _breakpointSidebar &&
        !_isSidebarHidden &&
        widget.destinations[_selectedIndex].hasSidebar &&
        widget.sidebar != null;
    // The bottom navigation bar is visible.
    // Complex logic here, many config options leads to stuff like this.
    _isBottomBarVisible = !(widget.hideBottomBar || _scrollHiddenBottomBar) &&
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
    return _InheritedFlexScaffold(
      data: this,
      child: _FlexScaffoldModel(
        data: _data.copyWith(
          isMenuInDrawer: _isMenuInDrawer,
          isMenuHidden: _isMenuHidden,
          menuPrefersRail: _menuPrefersRail,
          //
          isSidebarInEndDrawer: _isSidebarInEndDrawer,
          isSidebarInMenu: _isSidebarInMenu,
          isSidebarHidden: _isSidebarHidden,
          //
          menuControlEnabled: widget.menuControlEnabled,
          sidebarControlEnabled: widget.sidebarControlEnabled,
          cycleViaDrawer: widget.cycleViaDrawer,
          //
          menuBelongsToBody: false, // TODO(rydmike): Add feature
          sidebarBelongsToBody: widget.sidebarBelongsToBody,
          //
          isBottomTarget: _isBottomTarget,
          isBottomBarVisible: _isBottomBarVisible,
          //
          selectedIndex: widget.selectedIndex,
          showBottomDestinationsInDrawer: _showBottomDestinationsInDrawer,
          //
          selectedDestination: _selectedDestination,
          onDestination: _onDestination,
        ),
        child: Row(
          children: <Widget>[
            //
            // Main menu, when the menu is shown as a fixed menu
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: flexTheme.menuWidth! + startPadding,
              ),
              child: Material(
                color: flexTheme.menuBackgroundColor,
                elevation: flexTheme.menuElevation!,
                child: widget.menu,
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
                        currentScreenWidth: _width,
                        backgroundColor: flexTheme.menuBackgroundColor,
                        elevation: flexTheme.drawerElevation,
                        width: flexTheme.drawerWidth! + startPadding,
                        child: widget.menu,
                      )
                    : null,
                //
                // The end drawer, ie tools menu when used as an end drawer.
                endDrawer: _isSidebarInEndDrawer
                    ? FlexDrawer(
                        currentScreenWidth: _width,
                        backgroundColor: flexTheme.sidebarBackgroundColor,
                        elevation: flexTheme.endDrawerElevation,
                        width: flexTheme.endDrawerWidth,
                        child: widget.sidebar,
                      )
                    : null,
                //
                // The bottom navigation bar
                bottomNavigationBar: FlexBottomBar(
                  customNavigationBar: widget.customBottomNavigator,
                  customNavigationBarHeight: widget.customNavigationBarHeight,
                ),
                //
                // Floating action button in its effective location.
                floatingActionButton:
                    widget.destinations[_selectedIndex].hasFloatingActionButton
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
                          child: widget.sidebar,
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
                constraints: BoxConstraints(maxWidth: flexTheme.sidebarWidth!),
                child: Material(
                  color: flexTheme.sidebarBackgroundColor,
                  elevation: flexTheme.sidebarElevation!,
                  child: widget.sidebar,
                ),
              ),
          ],
        ),
      ),
    );
    // }),
    // );
  }
}

/// Specifies a part of [FlexScaffoldState] to depend on.
///
/// [FlexScaffoldState] contains a large number of related properties.
/// Widgets frequently depend on only a few of these attributes. For example, a
/// widget that needs to rebuild when the [FlexScaffoldState] and its internal
/// [isMenuInDrawer] changes does not need to be notified when the
/// [isBottomTarget] changes. Specifying an aspect avoids unnecessary rebuilds.
enum _FlexScaffoldAspect {
  /// Specifies the aspect corresponding to [_FlexScaffoldData.isMenuInDrawer].
  isMenuInDrawer,

  /// Specifies the aspect corresponding to [_FlexScaffoldData.menuIsHidden].
  isMenuHidden,

  /// Specifies the aspect corresponding to [_FlexScaffoldData.menuPrefersRail].
  menuPrefersRail,

  /// Specifies the aspect corresponding to
  /// [_FlexScaffoldData.isSidebarInEndDrawer].
  isSidebarInEndDrawer,

  /// Specifies the aspect corresponding to [_FlexScaffoldData.isSidebarInMenu].
  isSidebarInMenu,

  /// Specifies the aspect corresponding to [_FlexScaffoldData.isSidebarHidden].
  isSidebarHidden,

  /// Specifies the aspect corresponding to
  /// [_FlexScaffoldData.menuControlEnabled].
  menuControlEnabled,

  /// Specifies the aspect corresponding to
  /// [_FlexScaffoldData.sidebarControlEnabled].
  sidebarControlEnabled,

  /// Specifies the aspect corresponding to
  /// [_FlexScaffoldData.cycleViaDrawer].
  cycleViaDrawer,

  /// Specifies the aspect corresponding to
  /// [_FlexScaffoldData.menuBelongsToBody].
  menuBelongsToBody,

  /// Specifies the aspect corresponding to
  /// [_FlexScaffoldData.sidebarBelongsToBody].
  sidebarBelongsToBody,

  /// Specifies the aspect corresponding to
  /// [_FlexScaffoldData.isBottomTarget].
  isBottomTarget,

  /// Specifies the aspect corresponding to
  /// [_FlexScaffoldData.isBottomBarVisible].
  isBottomBarVisible,

  /// Specifies the aspect corresponding to
  /// [_FlexScaffoldData.selectedIndex].
  selectedIndex,

  /// Specifies the aspect corresponding to
  /// [_FlexScaffoldData.showBottomDestinationsInDrawer].
  showBottomDestinationsInDrawer,

  /// Specifies the aspect corresponding to
  /// [_FlexScaffoldData.selectedDestination].
  selectedDestination,

  /// Specifies the aspect corresponding to
  /// [_FlexScaffoldData.onDestination].
  onDestination,
}

/// Defines [FlexScaffold] stateful data that we want to be able to uses
/// and rebuild to from individual property aspects of an Inherited model.
@immutable
class _FlexScaffoldData with Diagnosticable {
  const _FlexScaffoldData({
    this.isMenuInDrawer = false,
    this.isMenuHidden = false,
    this.menuPrefersRail = false,
    //
    this.isSidebarInEndDrawer = false,
    this.isSidebarInMenu = false,
    this.isSidebarHidden = false,
    //
    this.menuControlEnabled = true,
    this.sidebarControlEnabled = true,
    this.cycleViaDrawer = false,
    //
    this.menuBelongsToBody = false,
    this.sidebarBelongsToBody = false,
    //
    this.isBottomTarget = true,
    this.isBottomBarVisible = false,
    //
    this.selectedIndex = 0,
    this.showBottomDestinationsInDrawer = false,
    //
    this.selectedDestination = const GoFlexDestination(),
    this.onDestination = const GoFlexDestination(),
  });

  final bool isMenuInDrawer;
  final bool isMenuHidden;
  final bool menuPrefersRail;
  //
  final bool isSidebarInEndDrawer;
  final bool isSidebarInMenu;
  final bool isSidebarHidden;
  //
  final bool menuControlEnabled;
  final bool sidebarControlEnabled;
  final bool cycleViaDrawer;
  //
  final bool menuBelongsToBody;
  final bool sidebarBelongsToBody;
  //
  final int selectedIndex;
  final bool showBottomDestinationsInDrawer;
  //
  final bool isBottomTarget;
  final bool isBottomBarVisible;
  //
  final GoFlexDestination selectedDestination;
  final GoFlexDestination onDestination;

  /// Copy the object with one or more provided properties changed.
  _FlexScaffoldData copyWith({
    bool? isMenuInDrawer,
    bool? isMenuHidden,
    bool? menuPrefersRail,
    //
    bool? isSidebarInEndDrawer,
    bool? isSidebarInMenu,
    bool? isSidebarHidden,
    //
    bool? menuControlEnabled,
    bool? sidebarControlEnabled,
    bool? cycleViaDrawer,
    //
    bool? menuBelongsToBody,
    bool? sidebarBelongsToBody,
    //
    bool? isBottomTarget,
    bool? isBottomBarVisible,
    //
    int? selectedIndex,
    bool? showBottomDestinationsInDrawer,
    //
    GoFlexDestination? selectedDestination,
    GoFlexDestination? onDestination,
  }) {
    return _FlexScaffoldData(
      isMenuInDrawer: isMenuInDrawer ?? this.isMenuInDrawer,
      isMenuHidden: isMenuHidden ?? this.isMenuHidden,
      menuPrefersRail: menuPrefersRail ?? this.menuPrefersRail,
      //
      isSidebarInEndDrawer: isSidebarInEndDrawer ?? this.isSidebarInEndDrawer,
      isSidebarInMenu: isSidebarInMenu ?? this.isSidebarInMenu,
      isSidebarHidden: isSidebarHidden ?? this.isSidebarHidden,
      //
      menuControlEnabled: menuControlEnabled ?? this.menuControlEnabled,
      sidebarControlEnabled:
          sidebarControlEnabled ?? this.sidebarControlEnabled,
      cycleViaDrawer: cycleViaDrawer ?? this.cycleViaDrawer,
      //
      menuBelongsToBody: menuBelongsToBody ?? this.menuBelongsToBody,
      sidebarBelongsToBody: sidebarBelongsToBody ?? this.sidebarBelongsToBody,
      //
      isBottomTarget: isBottomTarget ?? this.isBottomTarget,
      isBottomBarVisible: isBottomBarVisible ?? this.isBottomBarVisible,
      //
      selectedIndex: selectedIndex ?? this.selectedIndex,
      showBottomDestinationsInDrawer:
          showBottomDestinationsInDrawer ?? this.showBottomDestinationsInDrawer,
      //
      selectedDestination: selectedDestination ?? this.selectedDestination,
      onDestination: onDestination ?? this.onDestination,
    );
  }

  /// Override the equality operator.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is _FlexScaffoldData &&
        other.isMenuInDrawer == isMenuInDrawer &&
        other.isMenuHidden == isMenuHidden &&
        other.menuPrefersRail == menuPrefersRail &&
        //
        other.isSidebarInEndDrawer == isSidebarInEndDrawer &&
        other.isSidebarInMenu == isSidebarInMenu &&
        other.isSidebarHidden == isSidebarHidden &&
        //
        other.menuControlEnabled == menuControlEnabled &&
        other.sidebarControlEnabled == sidebarControlEnabled &&
        other.cycleViaDrawer == cycleViaDrawer &&
        //
        other.menuBelongsToBody == menuBelongsToBody &&
        other.sidebarBelongsToBody == sidebarBelongsToBody &&
        //
        other.isBottomTarget == isBottomTarget &&
        other.isBottomBarVisible == isBottomBarVisible &&
        //
        other.selectedIndex == selectedIndex &&
        other.showBottomDestinationsInDrawer ==
            showBottomDestinationsInDrawer &&
        //
        other.selectedDestination == selectedDestination &&
        other.onDestination == onDestination;
  }

  /// Override for hashcode. Using Darts object hash.
  @override
  int get hashCode => Object.hash(
        isMenuInDrawer,
        isMenuHidden,
        menuPrefersRail,
        //
        isSidebarInEndDrawer,
        isSidebarInMenu,
        isSidebarHidden,
        //
        menuControlEnabled,
        sidebarControlEnabled,
        cycleViaDrawer,
        //
        menuBelongsToBody,
        sidebarBelongsToBody,
        //
        isBottomTarget,
        isBottomBarVisible,
        //
        selectedIndex,
        showBottomDestinationsInDrawer,
        //
        selectedDestination,
        onDestination,
      );

  /// Flutter debug properties override, includes toString.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isMenuInDrawer', isMenuInDrawer));
    properties.add(DiagnosticsProperty<bool>('menuIsHidden', isMenuHidden));
    properties
        .add(DiagnosticsProperty<bool>('menuPrefersRail', menuPrefersRail));
    //
    properties.add(DiagnosticsProperty<bool>(
        'isSidebarInEndDrawer', isSidebarInEndDrawer));
    properties
        .add(DiagnosticsProperty<bool>('isSidebarInMenu', isSidebarInMenu));
    properties
        .add(DiagnosticsProperty<bool>('isSidebarHidden', isSidebarHidden));
    //
    properties.add(
        DiagnosticsProperty<bool>('menuControlEnabled', menuControlEnabled));
    properties.add(DiagnosticsProperty<bool>(
        'sidebarControlEnabled', sidebarControlEnabled));
    properties.add(DiagnosticsProperty<bool>('cycleViaDrawer', cycleViaDrawer));
    //
    properties
        .add(DiagnosticsProperty<bool>('menuBelongsToBody', menuBelongsToBody));
    properties.add(DiagnosticsProperty<bool>(
        'sidebarBelongsToBody', sidebarBelongsToBody));
    //
    properties.add(DiagnosticsProperty<bool>('isBottomTarget', isBottomTarget));
    properties.add(
        DiagnosticsProperty<bool>('isBottomBarVisible', isBottomBarVisible));
    //
    properties.add(DiagnosticsProperty<int>('selectedIndex', selectedIndex));
    properties.add(DiagnosticsProperty<bool>(
        'showBottomDestinationsInDrawer', showBottomDestinationsInDrawer));
    //
    properties.add(DiagnosticsProperty<GoFlexDestination>(
        'selectedDestination', selectedDestination));
    properties.add(
        DiagnosticsProperty<GoFlexDestination>('onDestination', onDestination));
  }
}

/// FlexScaffold implementation of InheritedModel.
///
/// Used for to find the current FlexScaffold in the widget tree. This is useful
/// when reading FlexScaffold properties and using it methods from anywhere
/// in your app.
class _FlexScaffoldModel extends InheritedModel<_FlexScaffoldAspect> {
  /// You must pass through a child and your state.
  const _FlexScaffoldModel({
    required this.data,
    required super.child,
  });

  /// The FlexScaffoldStateData we need access to and only rebuild by aspect.
  final _FlexScaffoldData data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<_FlexScaffoldData>('data', data));
  }

  @override
  bool updateShouldNotify(_FlexScaffoldModel oldWidget) {
    // return false;
    final bool result = data != oldWidget.data;
    if (_kDebugMe) {
      debugPrint('_InheritedFlexScaffoldModel: updateShouldNotify: $result');
      debugPrint('oldWidget.data.menuIsHidden: ${oldWidget.data.isMenuHidden}');
      debugPrint('          data.menuIsHidden: ${data.isMenuHidden}');
    }
    return result;
  }

  @override
  bool updateShouldNotifyDependent(
      _FlexScaffoldModel oldWidget, Set<Object> dependencies) {
    final bool result = (data.isMenuInDrawer != oldWidget.data.isMenuInDrawer &&
            dependencies.contains(_FlexScaffoldAspect.isMenuInDrawer)) ||
        (data.isMenuHidden != oldWidget.data.isMenuHidden &&
            dependencies.contains(_FlexScaffoldAspect.isMenuHidden)) ||
        (data.menuPrefersRail != oldWidget.data.menuPrefersRail &&
            dependencies.contains(_FlexScaffoldAspect.menuPrefersRail)) ||
        //
        (data.isSidebarInEndDrawer != oldWidget.data.isSidebarInEndDrawer &&
            dependencies.contains(_FlexScaffoldAspect.isSidebarInEndDrawer)) ||
        (data.isSidebarInMenu != oldWidget.data.isSidebarInMenu &&
            dependencies.contains(_FlexScaffoldAspect.isSidebarInMenu)) ||
        (data.isSidebarHidden != oldWidget.data.isSidebarHidden &&
            dependencies.contains(_FlexScaffoldAspect.isSidebarHidden)) ||
        //
        (data.menuControlEnabled != oldWidget.data.menuControlEnabled &&
            dependencies.contains(_FlexScaffoldAspect.menuControlEnabled)) ||
        (data.sidebarControlEnabled != oldWidget.data.sidebarControlEnabled &&
            dependencies.contains(_FlexScaffoldAspect.sidebarControlEnabled)) ||
        (data.cycleViaDrawer != oldWidget.data.cycleViaDrawer &&
            dependencies.contains(_FlexScaffoldAspect.cycleViaDrawer)) ||
        //
        (data.menuBelongsToBody != oldWidget.data.menuBelongsToBody &&
            dependencies.contains(_FlexScaffoldAspect.menuBelongsToBody)) ||
        (data.sidebarBelongsToBody != oldWidget.data.sidebarBelongsToBody &&
            dependencies.contains(_FlexScaffoldAspect.sidebarBelongsToBody)) ||
        //
        (data.isBottomTarget != oldWidget.data.isBottomTarget &&
            dependencies.contains(_FlexScaffoldAspect.isBottomTarget)) ||
        (data.isBottomBarVisible != oldWidget.data.isBottomBarVisible &&
            dependencies.contains(_FlexScaffoldAspect.isBottomBarVisible)) ||
        //
        (data.selectedDestination != oldWidget.data.selectedDestination &&
            dependencies.contains(_FlexScaffoldAspect.selectedDestination)) ||
        (data.onDestination != oldWidget.data.onDestination &&
            dependencies.contains(_FlexScaffoldAspect.onDestination));
    if (_kDebugMe) {
      debugPrint('_InheritedFlexScaffoldModel: '
          'updateShouldNotifyDependent: $result');
    }
    return result;
  }
}

/// FlexScaffold implementation of InheritedWidget.
///
/// Used for to find the current FlexScaffold in the widget tree. This is useful
/// when reading FlexScaffold properties and using its methods from anywhere
/// in the the tree of its descendants.
class _InheritedFlexScaffold extends InheritedWidget {
  /// You must pass through a child and your state.
  const _InheritedFlexScaffold({
    required this.data,
    required super.child,
  });

  /// The entire [FlexScaffoldState] is the inherited widget.
  final FlexScaffoldState data;

  /// We never notify descendants of any changes in [FlexScaffoldState] data,
  /// this inherited widget can read property values in [FlexScaffoldState],
  /// but using its properties will not rebuild when the [FlexScaffoldState]
  /// changes.
  ///
  /// The primary use of this inherited widget is to enable access to
  /// methods in [FlexScaffoldState] to be able to control it.
  ///
  /// If you don't change some input properties in [FlexScaffold], like e.g.
  /// the icon button value, you can safely read their widget values.
  @override
  bool updateShouldNotify(_InheritedFlexScaffold oldWidget) {
    debugPrint('_InheritedFlexScaffold updateShouldNotify: ALWAYS FALSE');
    return false;
  }
}
