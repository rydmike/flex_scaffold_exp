// ignore_for_file: comment_references
import 'package:flutter/material.dart';

import 'flex_scaffold.dart';
import 'flex_scaffold_constants.dart';
import 'flexfold_theme.dart';

const double _kLeadingWidth = kToolbarHeight;

/// The sidebar menu button used in a [FlexScaffold] and its [FlexSidebar].
///
/// The button holds the logic for managing toggling the state of the sidebar
/// menu between hidden in drawer and locked on screen.
class FlexSidebarButton extends StatelessWidget {
  /// Default constructor.
  const FlexSidebarButton({
    super.key,
    this.menuIcon,
    this.menuIconExpand,
    this.menuIconExpandHidden,
    this.menuIconCollapse,
    required this.onPressed,
  });

  // TODO(rydmike): Fix and update icon doc comments.

  /// A Widget used to open the menu, typically an [Icon] widget is used.
  ///
  /// The same icon will also be used on the AppBar when the menu or rail is
  /// hidden in a drawer. If no icon is provided it defaults to a widget with
  /// value [kFlexfoldSidebarIcon].
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

  /// The callback that is called when the button is tapped or otherwise
  /// activated.
  ///
  /// If this is set to null, the button will be disabled.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final FlexScaffoldState flexScaffold = FlexScaffold.of(context);

    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
    final bool isEndDrawerOpen = scaffold?.isEndDrawerOpen ?? false;

    final double width = MediaQuery.of(context).size.width;

    final FlexScaffoldThemeData theme = FlexScaffoldTheme.of(context);
    final double breakpointSidebar = theme.breakpointSidebar!;

    final bool canLockMenu = width >= breakpointSidebar;

    // Set effective expand and collapse icons
    Widget effectiveMenuIcon =
        menuIcon ?? flexScaffold.widget.sidebarIcon ?? kFlexfoldSidebarIcon;
    Widget effectiveMenuIconExpand = menuIconExpand ??
        flexScaffold.widget.sidebarIconExpand ??
        menuIcon ??
        kFlexfoldSidebarIconExpand;
    Widget effectiveMenuIconExpandHidden = menuIconExpandHidden ??
        flexScaffold.widget.sidebarIconExpandHidden ??
        menuIcon ??
        kFlexfoldSidebarIconExpandHidden;
    Widget effectiveMenuIconCollapse = menuIconCollapse ??
        flexScaffold.widget.sidebarIconCollapse ??
        menuIcon ??
        kFlexfoldSidebarIconCollapse;
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
    if (hasEndDrawer &&
        !isEndDrawerOpen &&
        (!canLockMenu || flexScaffold.widget.cycleViaDrawer)) {
      tooltip = theme.sidebarOpenTooltip!;
      effectiveMenuButton = effectiveMenuIcon;
    } else if (hasEndDrawer &&
        !isEndDrawerOpen &&
        (canLockMenu || !flexScaffold.widget.cycleViaDrawer)) {
      tooltip = theme.sidebarExpandHiddenTooltip!;
      effectiveMenuButton = effectiveMenuIconExpandHidden;
    } else if (hasEndDrawer && isEndDrawerOpen && !canLockMenu) {
      tooltip = theme.sidebarCloseTooltip!;
      effectiveMenuButton = effectiveMenuIcon;
    } else if (flexScaffold.sidebarIsHidden) {
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
              (!canLockMenu || flexScaffold.widget.cycleViaDrawer)) {
            Scaffold.of(context).openEndDrawer();
          } else if (hasEndDrawer && isEndDrawerOpen && !canLockMenu) {
            Navigator.of(context).pop();
          } else if (flexScaffold.sidebarIsHidden) {
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
                flexScaffold.hideSidebar(false);
              });
            } else {
              flexScaffold.hideSidebar(false);
            }
          } else {
            flexScaffold.hideSidebar(true);
          }
        },
      ),
    );
  }
}
