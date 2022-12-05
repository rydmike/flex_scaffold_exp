import 'package:flutter/material.dart';

import 'flex_scaffold.dart';
import 'flex_scaffold_constants.dart';
import 'flexfold_theme.dart';

/// The menu button for the FlexScaffold menu, rail and drawer operation.
///
/// The button holds the logic for managing toggling the state of the menu
/// between hidden, rail and side menu.
///
/// I uses an IconButton under the hood, looks up proper behavior from
/// FlexScaffold.of(context) that must exist in the widget tree above this
/// context. The icons can be customized, but if not, it uses those provided
/// to the [FlexScaffold], or falls back to default icons.
class FlexScaffoldMenuButton extends StatelessWidget {
  /// Default constructor
  const FlexScaffoldMenuButton({
    super.key,
    this.menuIcon,
    this.menuIconExpand,
    this.menuIconExpandHidden,
    this.menuIconCollapse,
    required this.onPressed,
  });

  /// A Widget used to open the menu, typically an [Icon] widget is used.
  ///
  /// The same icon will also be used on the AppBar when the menu or rail is
  /// hidden in a drawer.
  ///
  /// If no icon is provided and there was none give to it in the FlexScaffold
  /// it defaults to a widget with value [kFlexfoldMenuIcon].
  final Widget? menuIcon;

  /// A widget used to expand the drawer to a menu from an opened drawer,
  /// typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none give to it in the FlexScaffold
  /// it defaults to a widget with value [kFlexfoldMenuIconExpand].
  final Widget? menuIconExpand;

  /// A widget used to expand the drawer to a menu when the rail/menu is
  /// hidden but may be expanded based on screen width and breakpoints.
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none give to it in the FlexScaffold
  /// it defaults to a widget with value [kFlexfoldMenuIconExpandHidden].
  final Widget? menuIconExpandHidden;

  /// A widget used to expand the drawer to a menu, typically an [Icon]
  /// widget is used.
  ///
  /// If no icon is provided and there was none give to it in the FlexScaffold
  /// it defaults to a widget with value [kFlexfoldMenuIconCollapse].
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
    Widget effectiveMenuIcon =
        menuIcon ?? flexScaffold.widget.menuIcon ?? kFlexfoldMenuIcon;
    Widget effectiveMenuIconExpand = menuIconExpand ??
        flexScaffold.widget.menuIconExpand ??
        menuIcon ??
        kFlexfoldMenuIconExpand;
    Widget effectiveMenuIconExpandHidden = menuIconExpandHidden ??
        flexScaffold.widget.menuIconExpandHidden ??
        menuIcon ??
        kFlexfoldMenuIconExpandHidden;
    Widget effectiveMenuIconCollapse = menuIconCollapse ??
        flexScaffold.widget.menuIconCollapse ??
        menuIcon ??
        kFlexfoldMenuIconCollapse;
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
    if (hasDrawer &&
        !isDrawerOpen &&
        (!canLockMenu || flexScaffold.widget.cycleViaDrawer)) {
      tooltip = theme.menuOpenTooltip!;
      effectiveMenuButton = effectiveMenuIcon;
    } else if (hasDrawer &&
        !isDrawerOpen &&
        (canLockMenu || !flexScaffold.widget.cycleViaDrawer)) {
      tooltip = theme.menuExpandHiddenTooltip!;
      effectiveMenuButton = effectiveMenuIconExpandHidden;
    } else if (hasDrawer && isDrawerOpen && !canLockMenu) {
      tooltip = theme.menuCloseTooltip!;
      effectiveMenuButton = effectiveMenuIcon;
    } else if (flexScaffold.menuIsHidden) {
      tooltip = theme.menuExpandTooltip!;
      effectiveMenuButton = effectiveMenuIconExpand;
    } else {
      tooltip = theme.menuCollapseTooltip!;
      effectiveMenuButton = effectiveMenuIconCollapse;
    }

    return IconButton(
      icon: effectiveMenuButton,
      tooltip: theme.useTooltips! ? tooltip : null,
      onPressed: onPressed == null
          ? null
          : () {
              if (hasDrawer &&
                  !isDrawerOpen &&
                  (!canLockMenu || flexScaffold.widget.cycleViaDrawer)) {
                scaffold?.openDrawer();
              } else if (hasDrawer && isDrawerOpen && !canLockMenu) {
                Navigator.of(context).pop();
              } else if (flexScaffold.menuIsHidden) {
                flexScaffold.setMenuPrefersRail(false);
                if (hasDrawer && isDrawerOpen) {
                  Navigator.of(context).pop();
                  // TODO(rydmike): Maybe improve this for the menu to close?
                  // This will give the correct time to allow the menu to close,
                  // after which we set hidden to false and it will animate open
                  // to appropriate lock position. Would be nice if we could
                  // (probably possible somehow) listen to and know when the
                  // Drawer has closed fully and open the locked menu/rail
                  // then, but this works too, but it is a bit of a hack.
                  Future<void>.delayed(kFlexfoldFlutterDrawerDuration, () {
                    flexScaffold.hideMenu(false);
                  });
                } else {
                  flexScaffold.hideMenu(false);
                }
              } else {
                if (flexScaffold.menuPrefersRail || mustBeRail) {
                  flexScaffold.hideMenu(true);
                } else {
                  flexScaffold.setMenuPrefersRail(true);
                }
              }
              // Call the onPressed.
              onPressed?.call();
            },
    );
  }
}
