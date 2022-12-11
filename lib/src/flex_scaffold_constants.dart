import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Constants used as default values by the Flexfold scaffold.

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

/// The style of bottom navigation bar that Flexfold Scaffold will use.
///
/// Currently only two styles have been implemented, but more may be added
/// in later versions.
///
/// The choice [FlexfoldBottomBarType.adaptive] results in Flexfold using
/// a [CupertinoTabBar] navigation bar on iOs and MacOS and a
/// [BottomNavigationBar] or [NavigationBar] on all other platforms.
/// The choice of Material bottom navigation style depends on if
/// [ThemeData.useMaterial3], if true, [material3] is used, else [material2].
enum FlexfoldBottomBarType {
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
}

/// Enum used to set if menu items starts from the top or the bottom.
enum FlexfoldMenuStart {
  /// The menu starts from the bottom.
  top,

  /// The menu starts from the top.
  bottom,
}

// TODO(rydmike): This feature is not yet implemented, under consideration.
/// Enum used to set if menu should be on the start or end side, if left or
/// right side is start or end, depends on current LTR RTL directionality.
///
/// Future version may also add totally different menu style, like top and
/// float. Where menu is at the top of the screen or free-floating.
enum FlexfoldMenuSide {
  /// Menu is on start side of the screen.
  start,

  /// Menu is on end side of the screen.
  end,
}

/// A constant widget used as the default menu icon.
///
/// If you use using the default menu icon, then you can use this constant
/// also as the menu icon for e.g. a totally custom sliver appbar.
const Widget kFlexfoldMenuIcon = Icon(Icons.menu);

/// A constant widget used as the default menu expand icon.
const Widget kFlexfoldMenuIconExpand = kFlexfoldMenuIcon;

/// A constant widget used as the default menu expand icon for a hidden menu.
const Widget kFlexfoldMenuIconExpandHidden = kFlexfoldMenuIcon;

/// A constant widget used as the default menu expand icon.
const Widget kFlexfoldMenuIconCollapse = kFlexfoldMenuIcon;

/// A constant widget used as the default sidebar menu icon.
const Widget kFlexfoldSidebarIcon = Icon(Icons.more_vert);

/// A constant widget used as the default sidebar menu icon.
const Widget kFlexfoldSidebarIconExpand = kFlexfoldSidebarIcon;

/// A constant widget used as the default sidebar expand icon for a hidden
/// sidebar.
const Widget kFlexfoldSidebarIconExpandHidden = kFlexfoldSidebarIcon;

/// A constant widget used as the default sidebar menu icon.
const Widget kFlexfoldSidebarIconCollapse = kFlexfoldSidebarIcon;

/// Default height breakpoint value when we change from having only a
/// drawer to a rail. Below this screen height breakpoint we keep the
/// rail and menu in the drawer.
const double kFlexfoldBreakpointDrawer = 550;

/// Minimum allowed height to keep rail in drawer.
const double kFlexfoldBreakpointDrawerMin = 0;

/// Maximum allowed height to keep rail in drawer.
const double kFlexfoldBreakpointDrawerMax = 800;

/// Default breakpoint value when we change from bottom navigation to rail.
const double kFlexfoldBreakpointRail = 600;

/// Minimum allowed rail breakpoint value.
const double kFlexfoldBreakpointRailMin = 200; //400.0;

/// Maximum allowed rail breakpoint value.
const double kFlexfoldBreakpointRailMax = 910;

/// Default breakpoint value when we change from rail to menu.
const double kFlexfoldBreakpointMenu = 1024;

/// Minimum allowed menu breakpoint value.
const double kFlexfoldBreakpointMenuMin = 300;

/// Maximum allowed menu breakpoint value.
const double kFlexfoldBreakpointMenuMax = 1500;

/// Default breakpoint value when sidebar becomes fixed on screen.
const double kFlexfoldBreakpointSidebar = 1200;

/// Minimum allowed sidebar breakpoint value.
const double kFlexfoldBreakpointSidebarMin = 750;

/// Maximum allowed sidebar breakpoint value.
const double kFlexfoldBreakpointSidebarMax = 4096;

/// Flexfold menu width default value.
const double kFlexfoldMenuWidth = 250;

/// Flexfold minimum allowed menu width.
const double kFlexfoldMenuWidthMin = 200;

/// Flexfold maximum allowed menu width.
const double kFlexfoldMenuWidthMax = 450;

/// Flexfold drawer width default value.
///
/// The 304dp default value is the same as the value by standard Drawer in
/// Flutter. It is a private constant so we cannot reference the value it uses.
const double kFlexfoldDrawerWidth = 304;

/// Flexfold minimum allowed drawer width.
const double kFlexfoldDrawerWidthMin = kFlexfoldMenuWidthMin;

/// Flexfold maximum allowed drawer width.
const double kFlexfoldDrawerWidthMax = kFlexfoldMenuWidthMax;

/// Flexfold default icon width on the drawer, rail and menu.
///
/// Defaults to [kToolbarHeight] which is 56dp, which is the same width as
/// used for leading widget in an AppBar, so by default the icons will be
/// aligned with the AppBar's leading widget icon.
const double kFlexfoldRailWidth = kToolbarHeight;

/// Flexfold minimum allowed Rail width.
///
/// The min value could be set to [kMinInteractiveDimension] which is 48dp, or
/// an alternative value is [kMinInteractiveDimensionCupertino] at 44dp, we
/// want to be able to cover both specs so we will allow the lower value.
const double kFlexfoldRailWidthMin = kMinInteractiveDimensionCupertino;

/// Flexfold maximum allowed icon width.
///
/// The 70dp value is quite big already for most use cases.
/// Wider can be considered if really needed, feel free to make a change
/// request with some sensible rationale.
const double kFlexfoldRailWidthMax = 70;

/// Flexfold sidebar width default value.
const double kFlexfoldSidebarWidth = kFlexfoldDrawerWidth;

/// Flexfold minimum allowed sidebar width.
const double kFlexfoldSidebarWidthMin = kFlexfoldMenuWidthMin;

/// Flexfold maximum allowed sidebar width.
const double kFlexfoldSidebarWidthMax = kFlexfoldMenuWidthMax;

/// The height of the menu highlighted and hover item.
const double kFlexfoldHighlightHeight = 50;

/// Minimum allowed height of the menu highlighted and hover item.
const double kFlexfoldHighlightHeightMin = kFlexfoldRailWidthMin;

/// Maximum allowed height of the menu highlighted and hover item.
const double kFlexfoldHighlightHeightMax = kFlexfoldRailWidthMax;

/// Margin in dp before the menu item highlighter.
const double kFlexfoldHighlightMarginStart = 0;

/// Margin in dp after the menu item highlighter.
const double kFlexfoldHighlightMarginEnd = 0;

/// Margin in dp above the menu item highlighter.
const double kFlexfoldHighlightMarginTop = 2;

/// Margin in dp below the menu item highlighter.
const double kFlexfoldHighlightMarginBottom = 2;

/// Flexfold Cupertino TabBar height.
///
/// The CupertinoTabBar is a PreferredSizedWidget with height of 50dp based
/// on iOS10 and later standard. There is no Flutter SDK global constant for
/// this, only a local const '_kTabBarHeight' with value 50 in the source.
/// We define our own const for it that we can use.
const double kFlexfoldCupertinoTabBarHeight = 50;

/// Flexfold NavigationBar height when labels are always hidden.
///
/// The NavigationBar has different height when labels are always hidden or
/// shown, the defaults are just hard coded in Flutter SDK. We give them
/// our own Flexfold const values so we can tweak them in one place if needed.
const double kFlexfoldNavigationBarAlwaysHideHeight = 56;

/// Flexfold NavigationBar height when labels are always hidden.
///
/// The NavigationBar has different height when labels are always hidden or
/// shown, the defaults are just hard coded in Flutter SDK. We give them
/// our own Flexfold const values so we can tweak them in one place if needed.
const double kFlexfoldNavigationBarHeight = 74;

/// The duration for the standard show and hide drawer animation in
/// Flutter SDK.
///
/// This value only exist as a private constant in the SDK Drawer file.
/// We need the value as well to use it as a default wait value for the
/// drawer to close before we start animating the menu into place when it
/// is to be made fixed on the screen. This value should really only be modified
/// if for some reason the private constant used in the Drawer() class changes.
const Duration kFlexfoldFlutterDrawerDuration = Duration(milliseconds: 246);

/// Default menu animation duration.
///
/// The default value of 246ms equals the hard coded duration for opening
/// a standard Drawer in Flutter. If we want another default for the menu
/// animation duration this value can be modified.
const Duration kFlexfoldMenuAnimationDuration = Duration(milliseconds: 246);

/// Default menu animation curve.
const Cubic kFlexfoldMenuAnimationCurve = Curves.easeInOut;

/// Default sidebar animation duration.
///
/// The default value of 246ms equals the hard coded duration for opening
/// a standard Drawer in Flutter. The value Flutter uses is a private
/// constant so we cannot reference the value it uses.
const Duration kFlexfoldSidebarAnimationDuration = Duration(milliseconds: 246);

/// Default sidebar animation curve.
const Cubic kFlexfoldSidebarAnimationCurve = Curves.easeInOut;

/// Default bottom navigation bar animation duration.
const Duration kFlexfoldBottomAnimationDuration = Duration(milliseconds: 246);

/// Default bottom navigation bar animation curve.
const Cubic kFlexfoldBottomAnimationCurve = Curves.easeInOut;
