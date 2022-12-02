import 'package:flutter/material.dart';

import 'flex_scaffold_constants.dart';
import 'flexfold_theme.dart';

/// The menu button for the Flexfold scaffold.
///
/// The button holds the logic for managing toggling the state of the menu
/// between hidden, rail and side menu.
class FlexfoldMenuButton extends StatelessWidget {
  /// Default constructor
  const FlexfoldMenuButton({
    super.key,
    this.menuIcon,
    this.menuIconExpand,
    this.menuIconExpandHidden,
    this.menuIconCollapse,
    this.isHidden = false,
    this.cycleViaDrawer = true,
    this.isRail = false,
    required this.setMenuHidden,
    required this.setPreferRail,
  });

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

  /// The menu is hidden in a drawer.
  final bool isHidden;

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

  /// The menu is a rail.
  final bool isRail;

  /// Callback to hide the menu.
  final ValueChanged<bool> setMenuHidden;

  /// Callback to set that the menu should remain in rail state even if
  /// the defined breakpoint for switching to menu has been exceeded.
  final ValueChanged<bool> setPreferRail;

  @override
  Widget build(BuildContext context) {
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool isDrawerOpen = scaffold?.isDrawerOpen ?? false;

    final double width = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final FlexfoldThemeData theme = FlexfoldTheme.of(context);
    final double breakpointDrawer = theme.breakpointDrawer!;
    final double breakpointRail = theme.breakpointRail!;
    final double breakpointMenu = theme.breakpointMenu!;

    // Based on height and breakpoint, we are making a phone landscape layout.
    final bool isPhoneLandscape = screenHeight < breakpointDrawer;

    final bool canLockMenu = (width >= breakpointRail) && !isPhoneLandscape;
    final bool mustBeRail = width < breakpointMenu;

    // Set effective expand and collapse icons
    Widget effectiveMenuIcon = menuIcon ?? kFlexfoldMenuIcon;
    Widget effectiveMenuIconExpand =
        menuIconExpand ?? menuIcon ?? kFlexfoldMenuIconExpand;
    Widget effectiveMenuIconExpandHidden =
        menuIconExpandHidden ?? menuIcon ?? kFlexfoldMenuIconExpandHidden;
    Widget effectiveMenuIconCollapse =
        menuIconCollapse ?? menuIcon ?? kFlexfoldMenuIconCollapse;
    // If directionality is RTL we rotate the icons 180 degrees, if directional
    // icons were used in a LTR design, the result should be fairly OK of this,
    // unless the APP was really designed with a RTL mindset, then we should
    // actually rotate them in LTR mode. Do we need an enum to toggle be able
    // to toggle this?
    // TODO(rydmike): Consider LTR rotate for rotating if icons selected for RTL
    if (Directionality.of(context) == TextDirection.rtl) {
      effectiveMenuIcon = RotatedBox(quarterTurns: 2, child: effectiveMenuIcon);
      effectiveMenuIconExpand =
          RotatedBox(quarterTurns: 2, child: effectiveMenuIconExpand);
      effectiveMenuIconExpandHidden =
          RotatedBox(quarterTurns: 2, child: effectiveMenuIconExpandHidden);
      effectiveMenuIconCollapse =
          RotatedBox(quarterTurns: 2, child: effectiveMenuIconCollapse);
    }

    // Set the next action as a tooltip on the menu button. By default suitable
    // localization strings that were found in MaterialLocalizations are used as
    // tooltip labels in FlexfoldThemeData if other labels were not specified.
    String tooltip;
    Widget effectiveMenuButton;
    if (hasDrawer && !isDrawerOpen && (!canLockMenu || cycleViaDrawer)) {
      tooltip = theme.menuOpenTooltip!;
      effectiveMenuButton = effectiveMenuIcon;
    } else if (hasDrawer && !isDrawerOpen && (canLockMenu || !cycleViaDrawer)) {
      tooltip = theme.menuExpandHiddenTooltip!;
      effectiveMenuButton = effectiveMenuIconExpandHidden;
    } else if (hasDrawer && isDrawerOpen && !canLockMenu) {
      tooltip = theme.menuCloseTooltip!;
      effectiveMenuButton = effectiveMenuIcon;
    } else if (isHidden) {
      tooltip = theme.menuExpandTooltip!;
      effectiveMenuButton = effectiveMenuIconExpand;
    } else {
      tooltip = theme.menuCollapseTooltip!;
      effectiveMenuButton = effectiveMenuIconCollapse;
    }

    return IconButton(
      icon: effectiveMenuButton,
      tooltip: theme.useTooltips! ? tooltip : null,
      onPressed: () {
        if (hasDrawer && !isDrawerOpen && (!canLockMenu || cycleViaDrawer)) {
          Scaffold.of(context).openDrawer();
        } else if (hasDrawer && isDrawerOpen && !canLockMenu) {
          Navigator.of(context).pop();
        } else if (isHidden) {
          setPreferRail(false);
          if (hasDrawer && isDrawerOpen) {
            Navigator.of(context).pop();
            // TODO(rydmike): Maybe improve this delays for the menu to close?
            // This will give the correct time to allow the menu to close,
            // after which we set hidden to false and it will animate open to
            // appropriate lock position. Would be nice if we could (probably
            // possible somehow) listen to and know when the Drawer has closed
            // fully and open the locked menu/rail then, but this works too.
            Future<void>.delayed(kFlexfoldFlutterDrawerDuration, () {
              setMenuHidden(false);
            });
          } else {
            setMenuHidden(false);
          }
        } else {
          if (isRail || mustBeRail) {
            setMenuHidden(true);
          } else {
            setPreferRail(true);
          }
        }
      },
    );
  }
}
