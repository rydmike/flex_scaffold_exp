import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'flex_scaffold.dart';

// ignore_for_file: comment_references

// TODO(rydmike): Add tap only command, only work with side item.
// TODO(rydmike): Add toggle tap only command, only work with side item.

/// Defines a [FlexDestination] that represents a top level navigation
/// destination in the FlexScaffold.
///
/// The definitions are used
@immutable
class FlexDestination {
  /// Creates a destination that is used by [FlexScaffold.destinations].
  ///
  /// The [icon] and [label] are required and may not be non-null.
  const FlexDestination({
    this.icon = const Icon(Icons.home),
    Widget? selectedIcon,
    this.label = 'Home',
    this.tooltip,
    this.heading,
    this.route = '/',
    this.maybePush = false,
    this.alwaysPush = false,
    this.hasSidebar = false,
    this.hasFloatingActionButton = false,
    this.hasAppBar = true,
    this.inBottomNavigation = false,
    this.dividerBefore = false,
    this.dividerAfter = false,
  }) : selectedIcon = selectedIcon ?? icon;

  /// The icon widget for the icon used by the destination. Typically an
  /// [Icon] widget.
  ///
  /// To make the [FlexDestination] more accessible, consider choosing an
  /// icon with a stroked and filled version, such as [Icons.cloud] and
  /// [Icons.cloud_queue]. The [IconData] should be set to the stroked version
  /// and [selectedIcon] to the filled version.
  ///
  /// To modify size, color and opacity use [FlexScaffoldThemeData] and its
  /// [iconTheme] property.
  final Widget icon;

  /// An alternative icon displayed when this destination is selected.
  ///
  /// If this icon is not provided, the [FlexDestination] will display
  /// [icon] in both states.
  ///
  /// To modify size, color and opacity use [FlexScaffoldThemeData] and its
  /// [selectedIconTheme] property.
  final Widget selectedIcon;

  /// The string label for the destination.
  ///
  /// This is a String label and not Widget title. Flutter has moved from using
  /// widgets for navigation labels to string text, same is done here.
  ///
  /// To label style [FlexScaffoldThemeData] and its
  /// [labelTextStyle] and [selectedLabelTextStyle] property.
  final String label;

  /// Tooltip description label for the destination.
  ///
  /// If provided it is used as a tooltip for the destination in all navigation
  /// modes. If not provided, the label text will be used as a tooltip but
  /// only in rail mode that does not show the label already.
  ///
  /// The tooltip string when not null is also used for semantics instead of
  /// the widget label, otherwise the label is uses.
  final String? tooltip;

  /// A heading for a group of destinations. Typically a [Text] widget.
  ///
  /// The heading appears above the destination, but after [dividerBefore]
  /// if there is one.
  final Widget? heading;

  /// A named route for the destination. Typically a path segment.
  ///
  /// You can provide named route strings to destinations. You can use them
  /// to get named routes for your destination index and route with
  /// named routing to the destinations.
  final String route;

  /// If the destination should be opened as a modal screen pushed on top of
  /// the top level destinations when it is selected from the Drawer in phone
  /// sized media, set [maybePush] to true.
  ///
  /// That a screen should be opened as a modal screen means it should be pushed
  /// on top of the other screens with a back button as only option to return
  /// back to the FlexScaffold screens.
  ///
  /// A screen that is always pushed into the body content of the FlexScaffold
  /// should never set this to true. This almost always applies to destinations
  /// that are [inBottomNavigation]. For targets not [inBottomNavigation],
  /// the situation depends on desired UX. If the target when opened from the
  /// Drawer should open as a modal screen when selected from the FlexScaffold
  /// Drawer, then set [maybePush] to true for the destination definition. If
  /// the destination should open in the body part of the FlexScaffold Drawer
  /// navigation on phone size, then set [maybePush] to false.
  ///
  /// Destinations where [maybePush] is true, will only cause
  /// [FlexScaffold.onDestination] to return [FlexDestinationTarget.preferPush]
  /// set to true, when [maybePush] is true and the destination was selected
  /// from the Drawer and media size is phone determined to be phone sized.
  /// For all other selections, from Rail, Menu and Bottom navigation bar,
  /// it will be returned as false.
  ///
  /// It is up to the application using FlexScaffold to actually implement the
  /// desired navigation behavior. This parameter is only used to define the
  /// design intent.
  ///
  /// Defaults to false.
  final bool maybePush;

  /// If the destination should always be opened as a modal screen when it is
  /// selected in Flexfold, set [alwaysPush] to true.
  ///
  /// That a screen should be opened as a modal screen means it should be pushed
  /// on top of the Flexfold scaffold with a back or close button as only
  /// option to return back to the Flexfold scaffold screen.
  ///
  /// A screen that is always pushed into the body content of the FlexScaffold
  /// should never set this to true. This almost always applies to destinations
  /// that are [inBottomNavigation]. For targets not [inBottomNavigation], the
  /// situation depends on desired UX. If the target when selected in
  /// FlexScaffold should open as a modal screen, then set [alwaysPush] to
  /// true for the destination definition. If the destination should open in
  /// the body part of the Flexfold, then keep [alwaysPush] false.
  ///
  /// Destinations where [alwaysPush] is true, will always cause
  /// [FlexScaffold.onDestination] to return [FlexDestinationTarget.preferPush]
  /// set to true, this happens regardless if the destination was clicked
  /// on from the Drawer, Rail, Menu or Bottom navigation bar.
  ///
  /// It is up to the application using Flexfold to actually implement the
  /// desired navigation behavior. This parameter is only used to define the
  /// design intent.
  ///
  /// Defaults to false.
  final bool alwaysPush;

  /// Destination is also used as a destination in the bottom navigation bar.
  ///
  /// By default destinations are visible in the Drawer, Rail and Menu, but not
  /// in the bottom navigation bar, you have to explicitly define which
  /// destinations you want to have in the bottom bar, there should be 2 to 5,
  /// typically 3 or 4. It is possible the squeeze in 6 on modern large phones,
  /// but it is not recommended.
  final bool inBottomNavigation;

  /// This destination has a side bar.
  ///
  /// Defaults to false.
  final bool hasSidebar;

  /// This destination has a floating action button. Defaults to false.
  final bool hasFloatingActionButton;

  /// This destination has an AppBar.
  ///
  /// By default all destinations in Flexfold gets an app bar. If an app bar is
  /// not provided a default one is created. The default app bar only
  /// has the required menu button to operate the drawer and menu.
  ///
  /// In some situations you might not want have an appbar for a destination
  /// at all. For example if you want to use a sliver app bar or a custom
  /// persistent header, then you have to make that as a part of the
  /// destination's body and do not want any app bar provided by FlexScaffold.
  /// For such destinations set [hasAppBar] to false.
  ///
  /// Only AppBar's provided by the FlexScaffold can be a part of the layout
  /// shell that does not change or transition when you navigate to a new
  /// destination. You can always keep the AppBar as part of the elements that
  /// are included in destination navigated to, as you would on a typical
  /// mobile UI where the entire screen changes. With FlexScaffold this is
  /// typically not the intent and we only want transitions on the content that
  /// is changed. Bottom bar stays put, but content transitions. With
  /// FlexScaffold and using its AppBar, you get this effect on the AppBar as
  /// well. You can however set this to false, and include the AppBar in the
  /// destination as well. If you do so, you will have to provide required
  /// actions to operate the drawers manually. The examples and docs
  /// show you how to do this.
  ///
  /// Defaults to true.
  final bool hasAppBar;

  /// In a rail or menu, draw a divider before the destination
  final bool dividerBefore;

  /// In a rail or menu, draw a divider after the destination
  final bool dividerAfter;

//   /// Given a destination in a list of destinations, return its bottom
//   /// navigation bar index.
//   ///
//   /// If the destination does not exist in the valid destinations, null will
//   /// be returned to indicate that destination was not found in the bottom
//   /// navigation bar. The destination could still exist in the destinations
//   /// none bottom navigation part, null is a valid result of this function.
//   static int? toBottomIndex(
//       FlexDestination destination, List<FlexDestination> destinations) {
//     assert(destinations.length >= 2, 'There must be at least 2 destinations.');
//
//     // Check for valid target and destinations
//     if (destinations.length < 2) {
//       // Bad input, but let's return the 0 index to use first destination.
//       return 0;
//     }
//     int countBottomIndex = 0;
//     for (int i = 0; i < destinations.length; i++) {
//       if (destinations[i].inBottomNavigation) {
//         if (destination.route == destinations[i].route) {
//           return countBottomIndex;
//         }
//         countBottomIndex++;
//       }
//     }
//     // There was no match for bottom index, it could still be a destination
//     // that is only available in the rail or menu.
//     // Null is a valid result of this function!
//     // ignore: avoid_returning_null
//     return null;
//   }
//
//   /// Given a destination in a list of destinations, return its menu index.
//   ///
//   /// If the destination is not found in the given destinations or the
//   /// destinations input is invalid, this function always returns zero, which
//   /// will correspond to the first destination in any list of destinations.
//   static int toMenuIndex(
//       FlexDestination destination, List<FlexDestination> destinations) {
//     // Debug assertions for the inputs
//     assert(destinations.length >= 2, 'There must be at least 2 destinations.');
//
//     // Check for valid target and destinations
//     if (destinations.length < 2) {
//       // Bad input, but let's return the 0 index to use first option in any
//       // destinations lists.
//       return 0;
//     }
//     for (int i = 0; i < destinations.length; i++) {
//       if (destination.route == destinations[i].route) return i;
//     }
//     // The destination was not found, we return 0 index to use first destination
//     // in any valid destinations list.
//     return 0;
//   }
//
//   /// Find a given route in a list of destinations and return the destination.
//   /// If no route is found, the first destination is returned.
//   static FlexDestination forRoute(
//       String route, List<FlexDestination> destinations) {
//     assert(destinations.length >= 2, 'There must be at least 2 destinations.');
//
//     // Check for valid target and destinations
//     if (destinations.length < 2) {
//       // Bad input, but let's return the first one if destinations is not empty
//       return destinations.isNotEmpty
//           ? destinations[0]
//           // If it was empty, then it was really bad we return a default
//           // const destination, not very helpful, but call can check for it.
//           : const FlexDestination();
//     }
//     for (int i = 0; i < destinations.length; i++) {
//       if (route == destinations[i].route) return destinations[i];
//     }
//     // We did not find the given route, in that case we navigate to
//     // to the first destination. Case of bad input, bad output.
//     return destinations[0];
//   }
}

/// Describes the source of the last navigation action in a FlexScaffold.
///
/// The [FlexNavigation.code] and
/// [FlexNavigation.custom] options can be assigned in code when
/// manually navigating via code to a Flexfold destination, e.g. via in app
/// links or actions that navigates to a Flexfold destination. The code
/// and custom sources can then be used to make a different navigation
/// transition for such navigation. They have no other purpose than this.
/// Typically, the code option could be used to indicate that the built-in
/// default page transition is to be used and the router can use it for a
/// platform default page transition. It can also be used for another custom
/// transition, this is up to the usage implementation in the used routing of
/// the application.
///
/// The other sources bottom, drawer, rail and menu are used to communicate
/// from where the last navigation was done inside from FlexScaffold menus.
/// It is up to the implementation of the routing to use this information
/// for different page transitions depending on the source.
enum FlexNavigation {
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
  code,

  /// Custom navigation event.
  ///
  /// Flexfold never sets this, but can be used for programmatic and custom
  /// transitions.
  custom,
}

// TODO(rydmike): Should also return active module index.
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
/// There is a [preferPush] flag which will only be true, if it would be
/// appropriate to display the target selected destination as a modal route
/// pushed on top of other destinations, with a back button, instead of as a
/// top level destination. This might be a more appropriate design on phone
/// for some destinations only available via the Drawer menu.
///
/// It is up to the used navigation implementation in an app using Flexfold
/// to implement the actual navigation and different transitions.
@immutable
class FlexDestinationTarget with Diagnosticable {
  /// Default const constructor.
  const FlexDestinationTarget({
    this.index = 0,
    this.bottomIndex = 0,
    this.route = '/',
    this.icon = const Icon(Icons.home),
    Widget? selectedIcon,
    this.label = 'Home',
    this.source = FlexNavigation.rail,
    this.reverse = false,
    this.preferPush = false,
  }) : selectedIcon = selectedIcon ?? icon;

  /// Menu, rail or drawer index of selected destination.
  final int index;

  /// The bottom navigation index of selected destination.
  ///
  /// It is null if a destination that only exists in the menu is selected.
  final int? bottomIndex;

  /// Named route of the selected destination.
  final String route;

  /// The icon widget for the icon used by the selected destination.
  final Widget icon;

  /// The alternative icon displayed used this destination when it is selected.
  ///
  /// If this icon is not defined in the destination, it is same as [icon].
  final Widget selectedIcon;

  /// The label of the selected destination.
  final String label;

  /// The navigator source that was used to select the destination.
  ///
  /// The value will correspond to the equivalent [FlexNavigation]
  /// enum value. When you want to navigate manually in code to a destination
  /// you can set this value to the type you want to mimic, or you
  /// can also set it to [FlexNavigation.custom] and build separate
  /// behavior for navigation that did not occur from within [FlexScaffold].
  final FlexNavigation source;

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

  /// Is `True` when the user navigated from a Drawer menu item that
  /// is never in the bottom navigation bar and navigation mode is
  /// bottom navigation bar and the destination's
  /// [FlexDestination.maybePush] property was set to be true (default).
  ///
  /// When [preferPush] is true, it is an indication that it is appropriate
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
  final bool preferPush;

  /// Copy the object with one or more provided properties changed.
  FlexDestinationTarget copyWith({
    int? index,
    int? bottomIndex,
    String? route,
    Widget? icon,
    Widget? selectedIcon,
    String? label,
    FlexNavigation? source,
    bool? reverse,
    bool? preferPush,
  }) {
    return FlexDestinationTarget(
      index: index ?? this.index,
      bottomIndex: bottomIndex ?? this.bottomIndex,
      route: route ?? this.route,
      icon: icon ?? this.icon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      label: label ?? this.label,
      source: source ?? this.source,
      reverse: reverse ?? this.reverse,
      preferPush: preferPush ?? this.preferPush,
    );
  }

  /// Override the equality operator.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is FlexDestinationTarget &&
        other.index == index &&
        other.bottomIndex == bottomIndex &&
        other.route == route &&
        other.icon == icon &&
        other.selectedIcon == selectedIcon &&
        other.label == label &&
        other.source == source &&
        other.reverse == reverse &&
        other.preferPush == preferPush;
  }

  /// Override for hashcode. Using Darts object hash.
  @override
  int get hashCode => Object.hash(
        index,
        bottomIndex,
        route,
        icon,
        selectedIcon,
        label,
        source,
        reverse,
        preferPush,
      );

  /// Flutter debug properties override, includes toString.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<int>('index', index));
    properties.add(DiagnosticsProperty<int>('bottomIndex', bottomIndex));
    properties.add(DiagnosticsProperty<String>('route', route));
    properties.add(DiagnosticsProperty<Widget>('icon', icon));
    properties.add(DiagnosticsProperty<Widget>('selectedIcon', selectedIcon));
    properties.add(DiagnosticsProperty<String>('label', label));
    properties.add(EnumProperty<FlexNavigation>('source', source));
    properties.add(DiagnosticsProperty<bool>('reverse', reverse));
    properties.add(DiagnosticsProperty<bool>('preferPush', preferPush));
  }
}
