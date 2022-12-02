import 'package:flutter/material.dart';

import 'flex_scaffold.dart';

/// Defines a [FlexfoldDestination] that represents a top level navigation
/// destination or view in the Flexfold scaffold.
///
/// The definitions are used
@immutable
class FlexfoldDestination {
  /// Creates a destination that is used by [FlexScaffold.destinations].
  ///
  /// The [icon] and [label] are required and may not be non-null.
  const FlexfoldDestination({
    this.module = 0,
    // Widget? icon,
    this.icon = const Icon(Icons.add_circle), // TODO(rydmike): change default?
    this.iconData = Icons.add_circle,
    Widget? selectedIcon,
    IconData? selectedIconData,
    this.label = 'Home',
    this.tooltip,
    this.heading,
    this.route = '/',
    this.maybeModal = false,
    this.alwaysModal = false,
    this.hasSidebar = false,
    this.hasFloatingActionButton = false,
    this.hasAppBar = true,
    this.inBottomBar = false,
    this.dividerBefore = false,
    this.dividerAfter = false,
  })  : // icon = icon ?? selectedIcon,
        selectedIcon = selectedIcon ?? icon,
        selectedIconData = selectedIconData ?? iconData;

  // TODO(rydmike): Implement modules!
  /// An optional module number for the destinations.
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
  /// The module number, defaults to 0.
  final int module;

  /// The icon widget for the icon used by the destination. Typically an
  /// [Icon] widget.
  ///
  /// To make the [FlexfoldDestination] more accessible, consider choosing an
  /// icon with a stroked and filled version, such as [Icons.cloud] and
  /// [Icons.cloud_queue]. The [IconData] should be set to the stroked version
  /// and [selectedIcon] to the filled version.
  final Widget icon;

  // TODO(rydmike): Determine if use Widget or IconData, for icon.
  /// IconData version of the above.
  ///
  /// Experimenting with the API still.
  final IconData iconData;

  /// An alternative icon displayed when this destination is selected.
  ///
  /// If this icon is not provided, the [FlexfoldDestination] will display
  /// [IconData] in both states. The size, color, and opacity of the
  /// [FlexScaffold.flexfoldTheme] will apply.
  final Widget selectedIcon;

  /// IconData version of the above.
  ///
  /// Experimenting with the API still.
  final IconData selectedIconData;

  /// The string label for the destination.
  ///
  /// This is a String label and not Widget title, because in master, dev and
  /// beta channels using Widget as the text label for the items in the
  /// BottomNavigationBarItems is being deprecated. We could still have used
  /// Widget title for the menu selections, but went with the lowest common
  /// property type.
  final String label;

  /// Tooltip description label for the destination.
  ///
  /// If provided it is used as a tooltip for the destination in all navigation
  /// modes. If not provided the label widget will be used as a tooltip but
  /// only in rail mode that does not show the label already.
  /// The tooltip string when not null is also used for semantics instead of
  /// the widget label.
  final String? tooltip;

  /// A heading for a group of destinations. Typically a [Text] widget.
  ///
  /// The heading appears above the destination, but after [dividerBefore]
  /// if there is one.
  final Widget? heading;

  /// A named route for the destination
  ///
  /// You can provide named route strings to destinations. You can use them
  /// to get named routes for your destination index and route with
  /// named routing to the destinations.
  final String route;

  /// If the destination should be opened as a modal screen when it is selected
  /// from the Drawer in Flexfold, set [maybeModal] to true.
  ///
  /// That a screen should be opened as a modal screen means it should be pushed
  /// on top of the Flexfold scaffold with a back or close button as only
  /// option to return back to the Flexfold scaffold screen. A screen that
  /// should always be pushed into the body content of the Flexfold scaffold
  /// should never set this to true. This almost always applies to destinations
  /// that are [inBottomBar]. For targets not [inBottomBar], the situation
  /// depends on desired UX. If the target when opened from the Drawer should
  /// open as a modal screen when selected from the Flexfold Drawer, then set
  /// [maybeModal] to true for the destination definition. If the destination
  /// should open in the body part of the Flexfold, then set [maybeModal] to
  /// false.
  ///
  /// Destinations where [maybeModal] is true, will only cause
  /// [FlexScaffold.onDestination] to return [FlexfoldDestinationData.useModal]
  /// set to true, when [maybeModal] is true and the destination was selected
  /// from the Drawer. For all other selections, from Rail, Menu and Bottom
  /// navigation bar, it will be returned as false.
  ///
  /// It is up to the application using Flexfold to actually implement the
  /// desired navigation behavior. This parameter is only used to define the
  /// design intent.
  ///
  /// Defaults to false.
  final bool maybeModal;

  /// If the destination should always be opened as a modal screen when it is
  /// selected in Flexfold, set [alwaysModal] to true.
  ///
  /// That a screen should be opened as a modal screen means it should be pushed
  /// on top of the Flexfold scaffold with a back or close button as only
  /// option to return back to the Flexfold scaffold screen. A screen that
  /// should always be pushed into the body content of the Flexfold scaffold
  /// should never set this to true. This almost always applies to destinations
  /// that are [inBottomBar]. For targets not [inBottomBar], the situation
  /// depends on desired UX. If the target when selected in Flexfold should
  /// open as a modal screen, then set [alwaysModal] to true for the
  /// destination definition. If the destination should open in the body part
  /// of the Flexfold, then keep [alwaysModal] false.
  ///
  /// Destinations where [alwaysModal] is true, will always cause
  /// [FlexScaffold.onDestination] to return [FlexfoldDestinationData.useModal]
  /// set to true, this happens regardless if the destination was clicked
  /// on from the Drawer, Rail, Menu or Bottom navigation bar.
  ///
  /// It is up to the application using Flexfold to actually implement the
  /// desired navigation behavior. This parameter is only used to define the
  /// design intent.
  ///
  /// Defaults to false.
  final bool alwaysModal;

  /// Destination is also used as a destination in the bottom navigation bar.
  ///
  /// By default destinations are visible in the drawer, rail and menu, but not
  /// in the bottom navigation bar, you have to explicitly define which
  /// destinations you want to have in the bottom bar, there should be 2...5,
  /// typically 3 or 4. It is possible the squeeze in 6 on modern large phones,
  /// but it is not recommended.
  final bool inBottomBar;

  /// This destination has a side bar. Defaults to false.
  final bool hasSidebar;

  /// This destination has a floating action button. Defaults to false.
  final bool hasFloatingActionButton;

  /// This destination has an app bar.
  ///
  /// Defaults to true.
  /// By default all destinations in Flexfold gets an app bar. If an app bar is
  /// not provided a default one is created. The default app bar only
  /// has the required menu button to operate the drawer and menu.
  /// In some situations you might not want have an appbar for a destination
  /// at all. For example if you want to use a sliver app bar or a custom
  /// persistent header, then you have to make that as a part of the
  /// destination's body and do not want any app bar provided by Flexfold.
  /// For such destinations set [hasAppBar] to false.
  final bool hasAppBar;

  /// In a rail or menu, draw a divider before the destination
  final bool dividerBefore;

  /// In a rail or menu, draw a divider after the destination
  final bool dividerAfter;

  /// Given a destination in a list of destinations, return its bottom
  /// navigation bar index.
  ///
  /// If the destination does not exist in the valid destinations, null will
  /// be returned to indicate that destination was not found in the bottom
  /// navigation bar. The destination could still exist in the destinations
  /// none bottom navigation part, null is a valid result of this function.
  static int? toBottomIndex(
      FlexfoldDestination destination, List<FlexfoldDestination> destinations) {
    assert(destinations.length >= 2, 'There must be at least 2 destinations.');

    // Check for valid target and destinations
    if (destinations.length < 2) {
      // Bad input, but let's return the 0 index to use first destination.
      return 0;
    }
    int countBottomIndex = 0;
    for (int i = 0; i < destinations.length; i++) {
      if (destinations[i].inBottomBar) {
        if (destination.route == destinations[i].route) {
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

  /// Given a destination in a list of destinations, return its menu index.
  ///
  /// If the destination is not found in the given destinations or the
  /// destinations input is invalid, this function always returns zero, which
  /// will correspond to the first destination in any list of destinations.
  static int toMenuIndex(
      FlexfoldDestination destination, List<FlexfoldDestination> destinations) {
    // Debug assertions for the inputs
    assert(destinations.length >= 2, 'There must be at least 2 destinations.');

    // Check for valid target and destinations
    if (destinations.length < 2) {
      // Bad input, but let's return the 0 index to use first option in any
      // destinations lists.
      return 0;
    }
    for (int i = 0; i < destinations.length; i++) {
      if (destination.route == destinations[i].route) return i;
    }
    // The destination was not found, we return 0 index to use first destination
    // in any valid destinations list.
    return 0;
  }

  /// Find a given route in a list of destinations and return the destination.
  /// If no route is found, the first destination is returned.
  static FlexfoldDestination forRoute(
      String route, List<FlexfoldDestination> destinations) {
    assert(destinations.length >= 2, 'There must be at least 2 destinations.');

    // Check for valid target and destinations
    if (destinations.length < 2) {
      // Bad input, but let's return the first one if destinations is not empty
      return destinations.isNotEmpty
          ? destinations[0]
          // If it was empty, then it was really bad we return a default
          // const destination, not very helpful, but call can check for it.
          : const FlexfoldDestination();
    }
    for (int i = 0; i < destinations.length; i++) {
      if (route == destinations[i].route) return destinations[i];
    }
    // We did not find the given route, in that case we navigate to
    // to the first destination. Case of bad input, bad output.
    return destinations[0];
  }
}

/// Describes the source of the last navigation action in a Flexfold scaffold.
///
/// The [FlexfoldNavigationSource.standard] and
/// [FlexfoldNavigationSource.custom] options can be assigned in code when
/// manually navigating via code to a Flexfold destination, e.g. via in app
/// links or actions that navigates to a Flexfold destination. The standard
/// and custom sources can then be used to make a different navigation
/// transition for such navigation. They have no other purpose than this,
/// typically the standard option could be used to indicate that the built in
/// default page transition is to be used and the router can use it for a
/// platform default page transition. But it can also if so desired be used for
/// another custom transition, this is up to the usage implementation in the
/// used routing of the application.
///
/// The other sources bottom, drawer, rail and menu are used to communicate
/// from where the last navigation was done inside from Flexfold menus.
/// Again it is up to the implementation of the routing to use this information
/// for different page transitions depending on the source.
enum FlexfoldNavigationSource {
  /// Navigation occurred because user clicked on bottom navigation bar item.
  bottom,

  /// Navigation occurred because user clicked on drawer item.
  drawer,

  /// Navigation occurred because user clicked on rail item.
  rail,

  /// Navigation occurred because user clicked on menu item.
  menu,

  /// Navigation occurred because it was done programmatically.
  ///
  /// Flexfold never sets this, but can be used for programmatic custom
  /// transitions.
  standard,

  /// Custom navigation event.
  ///
  /// Flexfold never sets this, but can be used for programmatic custom
  /// transitions.
  custom,
}

/// The properties contain detailed information about a target Flexfold
/// navigation destination. Returned by the [FlexScaffold.onDestination]
/// callback.
///
/// Returned properties are selected index from the menu/rail/drawer or
/// bottom index. The selected destination's named route,
/// which navigation mode was used to select the destination, did we move
/// forward or backwards in the index from previous selection.
///
/// This direction information can be used to create different page transitions
/// based on navigation direction.
///
/// There is a [useModal] flag which will only be true, if it would be
/// appropriate to display the target selected destination as a modal route
/// with a back button, instead of as a top level destination.
///
/// It is up to the used navigation implementation in an app using Flexfold
/// to implement the actual navigation and different transitions.
@immutable
class FlexfoldDestinationData {
  /// Default const constructor.
  const FlexfoldDestinationData({
    this.menuIndex = 0,
    this.bottomIndex = 0,
    this.route = '/',
    this.source = FlexfoldNavigationSource.rail,
    this.reverse = false,
    this.useModal = false,
  });

  /// Factory to create a [FlexfoldDestinationData] from a [route], with
  /// optional values for navigation source and reverse direction.
  ///
  /// The String [route] and [destinations] of type List<[FlexfoldDestination]>
  /// are required positional parameters.
  factory FlexfoldDestinationData.fromRoute(
    String route,
    List<FlexfoldDestination> destinations, {
    FlexfoldNavigationSource source = FlexfoldNavigationSource.custom,
    bool reverse = false,
    bool useModal = false,
  }) {
    assert(destinations.isNotEmpty, 'Destinations may not be empty');
    assert(destinations.length >= 2, 'Amount of destinations must be >= 2');

    // Get the destination
    final FlexfoldDestination destination = FlexfoldDestination.forRoute(
      route,
      destinations,
    );

    return FlexfoldDestinationData(
      menuIndex: FlexfoldDestination.toMenuIndex(destination, destinations),
      bottomIndex: FlexfoldDestination.toBottomIndex(destination, destinations),
      route: route,
      source: source,
      reverse: reverse,
      useModal: useModal,
    );
  }

  /// Menu, rail or drawer index of selected destination.
  final int menuIndex;

  /// The bottom navigation index of selected destination.
  ///
  /// It is null if a destination that only exists in the menu is selected.
  final int? bottomIndex;

  /// Named route of the selected destination.
  final String route;

  /// The navigator source that was used to select the destination.
  ///
  /// The value will correspond to the equivalent [FlexfoldNavigationSource]
  /// enum value. When you want to navigate manually in code to a destination
  /// you can set this value to the type you want to mimic, or you
  /// can also set it to [FlexfoldNavigationSource.custom] and build separate
  /// behavior for navigation that did not occur from within [FlexScaffold].
  final FlexfoldNavigationSource source;

  /// True if the current navigation occurred from a larger index value to a
  /// lower index value.
  ///
  /// When moving forward in the index direction it is false. You can use
  /// this value to build different transition effects depending on navigation
  /// direction. Typically used for different left/back and right/forward type
  /// of horizontal navigation transitions from a bottom navigation bar.
  ///
  /// Can also be used for an up/down type of transition for the rail or menu.
  final bool reverse;

  /// Is `True` when the user navigated from a drawer menu item that
  /// is never in the bottom navigation bar and navigation mode is
  /// bottom navigation bar and the destination's
  /// [FlexfoldDestination.maybeModal] property was set to be true (default).
  ///
  /// When [useModal] is true, it is an indication that it is appropriate
  /// from an usability viewpoint to push an entire new screen on top of the
  /// Flexfold scaffold, instead of navigating to a new Flexfold widget screen
  /// or just a body within the current Flexfold scaffold, depending on how
  /// the app navigation has been implemented.
  ///
  /// In a case where a user opens the drawer, and the bottom bar is used as
  /// the main navigation mode, it may often be more appropriate or at least a
  /// common practice on phones, to route to the destinations in
  /// the drawer as a new screen on top of the current one navigated to via
  /// the bottom navigation bar. User then gets back from that screen to the
  /// bottom navigation screen via the back button on the screen pushed on top
  /// of the bottom navigation screen in Flexfold. It is up to the developer
  /// using Flexfold to implement this push route instead of a
  /// replacement route.
  ///
  /// Even if a replacement route would be used, and the user is navigated to
  /// a destination in the drawer menu that does not have a bottom bar, Flexfold
  /// detects this and in such a case always also adds all the bottom navigation
  /// bar destinations to the drawer, so that there is a way to get back to the
  /// bottom destinations.
  ///
  /// Normally the bottom navigation bar destinations are not present in the
  /// drawer during bottom navigation mode, unless the
  /// [FlexScaffold.bottomDestinationsInDrawer] has been set to true, in which
  /// case bottom destinations are always also present in the drawer.
  final bool useModal;

  /// Copy properties to create a new object.
  FlexfoldDestinationData copyWith({
    int? menuIndex,
    int? bottomIndex,
    String? route,
    FlexfoldNavigationSource? source,
    bool? reverse,
    bool? useModal,
  }) {
    return FlexfoldDestinationData(
      menuIndex: menuIndex ?? this.menuIndex,
      bottomIndex: bottomIndex ?? this.bottomIndex,
      route: route ?? this.route,
      source: source ?? this.source,
      reverse: reverse ?? this.reverse,
      useModal: useModal ?? this.useModal,
    );
  }

  @override
  String toString() {
    return 'FlexfoldSelectedDestination(menuIndex: $menuIndex, '
        'bottomIndex: $bottomIndex, '
        'route: $route, '
        'source: $source, '
        'reverse: $reverse, '
        'useModal: $useModal)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlexfoldDestinationData &&
        other.menuIndex == menuIndex &&
        other.bottomIndex == bottomIndex &&
        other.route == route &&
        other.source == source &&
        other.reverse == reverse &&
        other.useModal == useModal;
  }

  @override
  int get hashCode {
    return menuIndex.hashCode ^
        bottomIndex.hashCode ^
        route.hashCode ^
        source.hashCode ^
        reverse.hashCode ^
        useModal.hashCode;
  }
}
