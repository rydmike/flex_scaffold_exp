import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'flex_destination.dart';

// ignore_for_file: comment_references

// TODO(rydmike): Should also return active module index.

/// Contains detailed information about the target [FlexScaffold] navigation
/// destination being navigated to. This cdata is returned by the
/// [FlexScaffold.onDestination] callback.
///
/// Returned properties are selected index from the menu/rail/drawer or
/// bottom index. The selected destination's named route,
/// which navigation mode was used to select the destination, did we move
/// forward or backwards in the index from previous selection.
///
/// This direction information can be used to create different page transitions
/// based on navigation direction.
///
/// There is a [wantsFullPage] flag which will only be true, if it would be
/// appropriate to display the target selected destination as a modal route
/// pushed on top of other destinations, with a back button, instead of as a
/// top level destination. This might be a more appropriate design on phone
/// for some destinations only available via the Drawer menu.
///
/// When [wantsFullPage] is true, the target destinations
/// [FlexDestination.routePage] is returned in the [route] property, instead
/// of its [FlexDestination.route] property.
///
/// It is up to the used navigation implementation in an app using FlexScaffold
/// to implement the actual navigation and different transitions.
@immutable
class FlexTarget with Diagnosticable {
  /// Default const constructor.
  const FlexTarget({
    this.index = 0,
    this.bottomIndex = 0,
    this.route = '/',
    this.icon = const Icon(Icons.home),
    Widget? selectedIcon,
    this.label = 'Home',
    this.source = FlexNavigation.menu,
    this.reverse = false,
    this.wantsFullPage = false,
    this.noAppBar = false,
    this.noAppBarTitle = false,
  }) : selectedIcon = selectedIcon ?? icon;

  /// Menu, rail or drawer index of selected destination.
  final int index;

  /// The bottom navigation index of selected destination.
  ///
  /// It is null if a destination that only exists in the menu is selected.
  final int? bottomIndex;

  /// Named route of the selected destination.
  ///
  /// If the returned route
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
  /// [FlexDestination.maybeFullPage] property was set to be true (default).
  ///
  /// When [wantsFullPage] is true, it is an indication that it is appropriate
  /// from an usability viewpoint to push an entire new screen on top of the
  /// FlexScaffold scaffold, instead of navigating to a new FlexScaffold widget
  /// screen or just a body within the current FlexScaffold scaffold, depending
  /// on how the app navigation has been implemented.
  ///
  /// In a case where a user opens the drawer, and the bottom bar is used as
  /// the main navigation mode, it may often be more appropriate or at least a
  /// common practice on phones, to route to the destinations in
  /// the drawer as a new screen on top of the current one navigated to via
  /// the bottom navigation bar. User then gets back from that screen to the
  /// bottom navigation screen via the back button on the screen pushed on top
  /// of the bottom navigation screen in FlexScaffold. It is up to the developer
  /// using FlexScaffold to implement this push route instead of a
  /// replacement route.
  ///
  /// Even if a replacement route would be used, and the user is navigated to
  /// a destination in the drawer menu that does not have a bottom bar,
  /// FlexScaffold detects this and in such a case always also adds all the
  /// bottom navigation bar destinations to the drawer, so that there is a
  /// way to get back to the bottom destinations.
  ///
  /// Normally the bottom navigation bar destinations are not present in the
  /// drawer during bottom navigation mode, unless the
  /// [FlexScaffold.bottomDestinationsInDrawer] has been set to true, in which
  /// case bottom destinations are always also present in the drawer.
  final bool wantsFullPage;

  /// True, if the selected destination is defined to not use an AppBar at all.
  /// This is typically used for destinations that use sliver app bars where
  /// the app bar is part of the destination's body and not the FlexScaffold.
  final bool noAppBar;

  /// True, if this destination has an app bar that does not show its title
  /// and uses transparent background.
  ///
  /// The leading and widget action widgets will still be shown.
  final bool noAppBarTitle;

  /// Copy the object with one or more provided properties changed.
  FlexTarget copyWith({
    int? index,
    int? bottomIndex,
    String? route,
    Widget? icon,
    Widget? selectedIcon,
    String? label,
    FlexNavigation? source,
    bool? reverse,
    bool? wantsFullPage,
    bool? noAppBar,
    bool? noAppBarTitle,
  }) {
    return FlexTarget(
      index: index ?? this.index,
      bottomIndex: bottomIndex ?? this.bottomIndex,
      route: route ?? this.route,
      icon: icon ?? this.icon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      label: label ?? this.label,
      source: source ?? this.source,
      reverse: reverse ?? this.reverse,
      wantsFullPage: wantsFullPage ?? this.wantsFullPage,
      noAppBar: noAppBar ?? this.noAppBar,
      noAppBarTitle: noAppBarTitle ?? this.noAppBarTitle,
    );
  }

  /// Override the equality operator.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is FlexTarget &&
        other.index == index &&
        other.bottomIndex == bottomIndex &&
        other.route == route &&
        other.icon == icon &&
        other.selectedIcon == selectedIcon &&
        other.label == label &&
        other.source == source &&
        other.reverse == reverse &&
        other.wantsFullPage == wantsFullPage &&
        other.noAppBar == noAppBar &&
        other.noAppBarTitle == noAppBarTitle;
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
        wantsFullPage,
        noAppBar,
        noAppBarTitle,
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
    properties.add(DiagnosticsProperty<bool>('wantsFullPage', wantsFullPage));
    properties.add(DiagnosticsProperty<bool>('hasAppBar', noAppBar));
    properties
        .add(DiagnosticsProperty<bool>('removeAppBarTitle', noAppBarTitle));
  }
}
