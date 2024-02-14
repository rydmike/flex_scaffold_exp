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
    this.noAppBar = false,
    this.noAppBarTitle = false,
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
  /// [FlexScaffold.onDestination] to return [FlexTarget.preferPush]
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
  /// [FlexScaffold.onDestination] to return [FlexTarget.preferPush]
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

  /// This destination has no [AppBar].
  ///
  /// By default all destinations in Flexfold gets an app bar. If an app bar is
  /// not provided a default one is created. The default app bar only
  /// has the required menu button to operate the drawer and menu.
  ///
  /// In some situations you might not want have an appbar for a destination
  /// at all. For example if you want to use a sliver app bar or a custom
  /// persistent header, then you have to make that as a part of the
  /// destination's body and do not want any app bar provided by FlexScaffold.
  /// For such destinations set [noAppBar] to false.
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
  /// Defaults to false.
  final bool noAppBar;

  /// This destination has an app bar that does not show its title
  /// and a transparent background.
  ///
  /// The leading and widget action widgets will still be shown.
  ///
  /// If [noAppBar] is false, this property has no effect.
  final bool noAppBarTitle;

  /// In a rail or menu, draw a divider before the destination
  final bool dividerBefore;

  /// In a rail or menu, draw a divider after the destination
  final bool dividerAfter;

  /// Override the equality operator.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is FlexDestination &&
        other.icon == icon &&
        other.selectedIcon == selectedIcon &&
        other.label == label &&
        other.tooltip == tooltip &&
        other.heading == heading &&
        other.route == route &&
        other.maybePush == maybePush &&
        other.alwaysPush == alwaysPush &&
        other.hasSidebar == hasSidebar &&
        other.hasFloatingActionButton == hasFloatingActionButton &&
        other.noAppBar == noAppBar &&
        other.noAppBarTitle == noAppBarTitle &&
        other.inBottomNavigation == inBottomNavigation &&
        other.dividerBefore == dividerBefore &&
        other.dividerAfter == dividerAfter;
  }

  /// Override for hashcode. Using Darts object hash.
  @override
  int get hashCode => Object.hash(
        icon,
        selectedIcon,
        label,
        tooltip,
        heading,
        route,
        maybePush,
        alwaysPush,
        hasSidebar,
        hasFloatingActionButton,
        noAppBar,
        noAppBarTitle,
        inBottomNavigation,
        dividerBefore,
        dividerAfter,
      );
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
