import 'package:flutter/material.dart';

import 'flex_scaffold_constants.dart';
import 'flexfold_theme.dart';

const double _kLeadingWidth = kToolbarHeight;

/// The sidebar menu button for the Flexfold scaffold.
///
/// The button holds the logic for managing toggling the state of the sidebar
/// menu between hidden in drawer and locked on screen.
class FlexfoldSidebarButton extends StatelessWidget {
  /// Default constructor.
  const FlexfoldSidebarButton({
    super.key,
    this.menuIcon,
    this.menuIconExpand,
    this.menuIconExpandHidden,
    this.menuIconCollapse,
    this.cycleViaDrawer = true,
    this.isHidden = false,
    required this.setMenuHidden,
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
  /// If no icon is provided for [menuIcon] it defaults to a widget with value
  /// [kFlexfoldMenuIconExpand] otherwise toe
  final Widget? menuIconExpand;

  /// A widget used to expand the drawer to a menu when the rail/menu is
  /// hidden but may be expanded based on screen width and breakpoints.
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided for [menuIcon] it defaults to a widget with value
  /// [kFlexfoldMenuIconExpandHidden].
  final Widget? menuIconExpandHidden;

  /// A widget used to expand the drawer to a menu, typically an [Icon]
  /// widget is used.
  ///
  /// If no icon is provided for [menuIcon] it defaults to a widget with value
  /// [kFlexfoldMenuIconCollapse].
  final Widget? menuIconCollapse;

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

  /// The sidebar menu is hidden in a drawer.
  final bool isHidden;

  /// Callback to hide the sidebar menu.
  final ValueChanged<bool> setMenuHidden;

  @override
  Widget build(BuildContext context) {
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
    final bool isEndDrawerOpen = scaffold?.isEndDrawerOpen ?? false;
    final double width = MediaQuery.of(context).size.width;

    final FlexfoldThemeData theme = FlexfoldTheme.of(context);
    final double breakpointSidebar = theme.breakpointSidebar!;

    final bool canLockMenu = width >= breakpointSidebar;

    // Set effective expand and collapse icons
    Widget effectiveMenuIcon = menuIcon ?? kFlexfoldSidebarIcon;
    Widget effectiveMenuIconExpand =
        menuIconExpand ?? menuIcon ?? kFlexfoldSidebarIconExpand;
    Widget effectiveMenuIconExpandHidden =
        menuIconExpandHidden ?? menuIcon ?? kFlexfoldSidebarIconExpandHidden;
    Widget effectiveMenuIconCollapse =
        menuIconCollapse ?? menuIcon ?? kFlexfoldSidebarIconCollapse;
    // If directionality is RTL we rotate the icons 180 degrees, if directional
    // icons were used in a LTR design, the result should be fairly OK of this,
    // unless the APP was really designed with a RTL mindset, then we should
    // actually rotate them in LTR mode. Do we need an enum to toggle be able
    // to toggle this?
    // TODO(rydmike): Consider LTR rotate setting if icons selected for RTL
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
    if (hasEndDrawer && !isEndDrawerOpen && (!canLockMenu || cycleViaDrawer)) {
      tooltip = theme.sidebarOpenTooltip!;
      effectiveMenuButton = effectiveMenuIcon;
    } else if (hasEndDrawer &&
        !isEndDrawerOpen &&
        (canLockMenu || !cycleViaDrawer)) {
      tooltip = theme.sidebarExpandHiddenTooltip!;
      effectiveMenuButton = effectiveMenuIconExpandHidden;
    } else if (hasEndDrawer && isEndDrawerOpen && !canLockMenu) {
      tooltip = theme.sidebarCloseTooltip!;
      effectiveMenuButton = effectiveMenuIcon;
    } else if (isHidden) {
      tooltip = theme.sidebarExpandTooltip!;
      effectiveMenuButton = effectiveMenuIconExpand;
    } else {
      tooltip = theme.sidebarCollapseTooltip!;
      effectiveMenuButton = effectiveMenuIconCollapse;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: _kLeadingWidth),
      child: IconButton(
        icon: effectiveMenuButton,
        tooltip: theme.useTooltips! ? tooltip : null,
        onPressed: () {
          if (hasEndDrawer &&
              !isEndDrawerOpen &&
              (!canLockMenu || cycleViaDrawer)) {
            Scaffold.of(context).openEndDrawer();
          } else if (hasEndDrawer && isEndDrawerOpen && !canLockMenu) {
            Navigator.of(context).pop();
          } else if (isHidden) {
            if (hasEndDrawer && isEndDrawerOpen) {
              Navigator.of(context).pop();
              // TODO(rydmike): Improve this that waits for the menu to close.
              // This will give the correct time to allow the menu to close,
              // after which we set hidden to false and it will animate open to
              // appropriate lock position. Would be nice if we could (probably
              // possible somehow?) listen to and know when the Drawer has
              // closed fully and open the locked menu/rail then, but this
              // works too.
              Future<void>.delayed(kFlexfoldFlutterDrawerDuration, () {
                setMenuHidden(false);
              });
            } else {
              setMenuHidden(false);
            }
          } else {
            setMenuHidden(true);
          }
        },
      ),
    );
  }
}
