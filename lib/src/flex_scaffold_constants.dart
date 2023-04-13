import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore_for_file: comment_references

/// Constants used as default values by FlexScaffold.

/// Pre-configured selected destination highlight indicator styles for the
/// rail and menu.
enum FlexIndicatorStyle {
  /// No highlight indicator of selected menu item.
  ///
  /// The selected item is only indicated by different style on text and
  /// and icon color of selected item.
  none,

  /// Entire row highlight indicator of elected menu item.
  row,

  /// Rounded box highlight indicator of selected menu item.
  box,

  /// Stadium highlight indicator of selected menu item.
  stadium,

  /// End stadium highlight indicator of selected menu item.
  endStadium,

  /// Vertical bar indicator before the selected menu item.
  startBar,

  /// Vertical bar indicator after the selected menu item.
  endBar
}

/// The style of bottom navigation bar that FlexScaffold Scaffold will use.
///
/// Currently only two styles have been implemented, but more may be added
/// in later versions.
///
/// The choice [FlexBottomType.adaptive] results in FlexScaffold using
/// a [CupertinoTabBar] navigation bar on iOs and MacOS and a
/// [BottomNavigationBar] or [NavigationBar] on all other platforms.
/// The choice of Material bottom navigation style depends on if
/// [ThemeData.useMaterial3], if true, [material3] is used, else [material2].
enum FlexBottomType {
  /// Use Material 2 style bottom navigation bar.
  material2,

  /// Use Material 3 style navigation bar.
  material3,

  /// Use Cupertino style bottom navigation bar.
  cupertino,

  /// Use Cupertino bottom navigation bar on iOS and macOS,
  /// Material style on others.
  ///
  /// The choice of Material bottom navigation style depends on if
  /// [ThemeData.useMaterial3], if true, [material3] is used, else [material2].
  adaptive,

  /// Use a custom bottom navigation bar.
  ///
  /// If used, you have to provide a [FlexScaffold.customNavigationBar].
  custom,
}

// TODO(rydmike): This feature is not yet implemented, under consideration.
/// Enum used to set if menu should be on the start or end side, if left or
/// right side is start or end, depends on current LTR RTL directionality.
///
/// Future version may also add totally different menu style, like top and
/// float. Where menu is at the top of the screen or free-floating.
enum FlexMenuSide {
  /// Menu is on start side of the screen.
  start,

  /// Menu is on end side of the screen.
  end,
}

/// A constant widget used as the default menu icon.
///
/// If you use using the default menu icon, then you can use this constant
/// also as the menu icon for e.g. a totally custom sliver appbar.
const Widget kFlexMenuIcon = Icon(Icons.menu);

/// A constant widget used as the default menu expand icon.
const Widget kFlexMenuIconExpand = kFlexMenuIcon;

/// A constant widget used as the default menu expand icon for a hidden menu.
const Widget kFlexMenuIconExpandHidden = kFlexMenuIcon;

/// A constant widget used as the default menu expand icon.
const Widget kFlexMenuIconCollapse = kFlexMenuIcon;

/// A constant widget used as the default sidebar menu icon.
const Widget kFlexSidebarIcon = Icon(Icons.more_vert);

/// A constant widget used as the default sidebar menu icon.
const Widget kFlexSidebarIconExpand = kFlexSidebarIcon;

/// A constant widget used as the default sidebar expand icon for a hidden
/// sidebar.
const Widget kFlexSidebarIconExpandHidden = kFlexSidebarIcon;

/// A constant widget used as the default sidebar menu icon.
const Widget kFlexSidebarIconCollapse = kFlexSidebarIcon;

/// Default height breakpoint value when we change from having only a
/// drawer to a rail. Below this screen height breakpoint we keep the
/// rail and menu in the drawer.
const double kFlexBreakpointDrawer = 550;

/// Minimum allowed height to keep rail in drawer.
const double kFlexBreakpointDrawerMin = 0;

/// Maximum allowed height to keep rail in drawer.
const double kFlexBreakpointDrawerMax = 800;

/// Default breakpoint value when we change from bottom navigation to rail.
const double kFlexBreakpointRail = 600;

/// Minimum allowed rail breakpoint value.
const double kFlexBreakpointRailMin = 200; //400.0;

/// Maximum allowed rail breakpoint value.
const double kFlexBreakpointRailMax = 910;

/// Default breakpoint value when we change from rail to menu.
const double kFlexBreakpointMenu = 1024;

/// Minimum allowed menu breakpoint value.
const double kFlexBreakpointMenuMin = 300;

/// Maximum allowed menu breakpoint value.
const double kFlexBreakpointMenuMax = 1500;

/// Default breakpoint value when sidebar becomes fixed on screen.
const double kFlexBreakpointSidebar = 1200;

/// Minimum allowed sidebar breakpoint value.
const double kFlexBreakpointSidebarMin = 750;

/// Maximum allowed sidebar breakpoint value.
const double kFlexBreakpointSidebarMax = 4096;

/// FlexScaffold menu width default value.
const double kFlexMenuWidth = 250;

/// FlexScaffold minimum allowed menu width.
const double kFlexMenuWidthMin = 200;

/// FlexScaffold maximum allowed menu width.
const double kFlexMenuWidthMax = 450;

/// FlexScaffold drawer width default value.
///
/// The 304dp default value is the same as the value by standard Drawer in
/// Flutter. It is a private constant so we cannot reference the value it uses.
const double kFlexDrawerWidth = 304;

/// FlexScaffold minimum allowed drawer width.
const double kFlexDrawerWidthMin = kFlexMenuWidthMin;

/// FlexScaffold maximum allowed drawer width.
const double kFlexDrawerWidthMax = kFlexMenuWidthMax;

/// FlexScaffold default icon width on the drawer, rail and menu.
///
/// Defaults to [kToolbarHeight] which is 56dp, which is the same width as
/// used for leading widget in an AppBar, so by default the icons will be
/// aligned with the AppBar's leading widget icon.
const double kFlexRailWidth = kToolbarHeight;

/// FlexScaffold minimum allowed Rail width.
///
/// The min value could be set to [kMinInteractiveDimension] which is 48dp, or
/// an alternative value is [kMinInteractiveDimensionCupertino] at 44dp, we
/// want to be able to cover both specs so we will allow the lower value.
const double kFlexRailWidthMin = kMinInteractiveDimensionCupertino;

/// FlexScaffold maximum allowed icon width.
///
/// The 70dp value is quite big already for most use cases.
/// Wider can be considered if really needed, feel free to make a change
/// request with some sensible rationale.
const double kFlexRailWidthMax = 70;

/// FlexScaffold sidebar width default value.
const double kFlexSidebarWidth = kFlexDrawerWidth;

/// FlexScaffold minimum allowed sidebar width.
const double kFlexSidebarWidthMin = kFlexMenuWidthMin;

/// FlexScaffold maximum allowed sidebar width.
const double kFlexSidebarWidthMax = kFlexMenuWidthMax;

/// The height of the menu highlighted and hover item.
const double kFlexIndicatorHeight = 50;

/// Minimum allowed height of the menu highlighted and hover item.
const double kFlexIndicatorHeightMin = kFlexRailWidthMin;

/// Maximum allowed height of the menu highlighted and hover item.
const double kFlexIndicatorHeightMax = kFlexRailWidthMax;

/// Margin in dp before the menu item highlighter.
const double kFlexIndicatorMarginStart = 0;

/// Margin in dp after the menu item highlighter.
const double kFlexIndicatorMarginEnd = 0;

/// Margin in dp above the menu item highlighter.
const double kFlexIndicatorMarginTop = 2;

/// Margin in dp below the menu item highlighter.
const double kFlexIndicatorMarginBottom = 2;

/// FlexScaffold Cupertino TabBar height.
///
/// The CupertinoTabBar is a PreferredSizedWidget with height of 50dp based
/// on iOS10 and later standard. There is no Flutter SDK global constant for
/// this, only a local const '_kTabBarHeight' with value 50 in the source.
/// We define our own const for it that we can use.
const double kFlexCupertinoTabBarHeight = 50;

/// FlexScaffold NavigationBar height when labels are always hidden.
///
/// The NavigationBar has different height when labels are always hidden or
/// shown, the defaults are just hard coded in Flutter SDK. We give them
/// our own FlexScaffold const values so we can tweak them in one place if
/// needed.
const double kFlexNavigationBarAlwaysHideHeight = 56;

/// FlexScaffold NavigationBar height when labels are always hidden.
///
/// The NavigationBar has different height when labels are always hidden or
/// shown, the defaults are just hard coded in Flutter SDK. We give them
/// our own FlexScaffold const values so we can tweak them in one place if
/// needed.
const double kFlexNavigationBarHeight = 74;

/// The duration for the standard show and hide drawer animation in
/// Flutter SDK.
///
/// This value only exist as a private constant in the SDK Drawer file.
/// We need the value as well to use it as a default wait value for the
/// drawer to close before we start animating the menu into place when it
/// is to be made fixed on the screen. This value should really only be modified
/// if for some reason the private constant used in the Drawer() class changes.
const Duration kFlexFlutterDrawerDuration = Duration(milliseconds: 246);

/// Default menu animation duration.
///
/// The default value of 246ms equals the hard coded duration for opening
/// a standard Drawer in Flutter. If we want another default for the menu
/// animation duration this value can be modified.
const Duration kFlexMenuAnimationDuration = Duration(milliseconds: 246);

/// Default menu animation curve.
const Cubic kFlexMenuAnimationCurve = Curves.easeInOut;

/// Default sidebar animation duration.
///
/// The default value of 246ms equals the hard coded duration for opening
/// a standard Drawer in Flutter. The value Flutter uses is a private
/// constant so we cannot reference the value it uses.
const Duration kFlexSidebarAnimationDuration = Duration(milliseconds: 246);

/// Default sidebar animation curve.
const Cubic kFlexSidebarAnimationCurve = Curves.easeInOut;

/// Default bottom navigation bar animation duration.
const Duration kFlexBottomAnimationDuration = Duration(milliseconds: 246);

/// Default bottom navigation bar animation curve.
const Cubic kFlexBottomAnimationCurve = Curves.easeInOut;
