import 'package:flutter/material.dart';

import 'flex_scaffold.dart';
import 'flex_scaffold_constants.dart';
import 'flex_scaffold_theme.dart';

/// The menu button for the FlexScaffold menu, rail and drawer operation.
///
/// The button holds the logic for managing toggling the state of the menu
/// between hidden, rail and side menu and drawer.
///
/// It uses an IconButton under the hood, looks up proper behavior from
/// [FlexScaffold]'s inherited widget and model that must exist in the widget
/// tree above this context.
///
/// The icons can be customized directly in the button, but if not, it uses
/// those provided to the [FlexScaffold], or falls back to default icons.
class FlexMenuButton extends StatelessWidget {
  /// Default constructor
  const FlexMenuButton({
    super.key,
    this.icon,
    this.iconExpand,
    this.iconExpandHidden,
    this.iconCollapse,
    required this.onPressed,
  });

  /// A Widget used on the menu button when the menu is operated as a Drawer.
  ///
  /// Typically an [Icon] widget is used with the hamburger menu icon.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, it defaults to a widget
  /// with value [kFlexMenuIcon], the hamburger icon.
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? icon;

  /// A widget used on an opened drawer menu button when operating it will
  /// change it to a side menu.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [icon] was not
  /// defined, it defaults to a widget with value [kFlexMenuIconExpand].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? iconExpand;

  /// A widget used on the menu button when operating it will expand the
  /// menu to a rail or to a side menu.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [icon] was not
  /// defined, it defaults to a widget with value
  /// [kFlexMenuIconExpandHidden].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? iconExpandHidden;

  /// A widget used on the menu button when it is shown as a menu or rail,
  /// and operating it will collapse it to its next state, from menu to rail to
  /// hidden.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [icon] was not
  /// defined, it defaults to a widget with value [kFlexMenuIconCollapse].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? iconCollapse;

  /// The callback that is called when the menu button is tapped or otherwise
  /// activated.
  ///
  /// If this is set to null, the button will be disabled.
  ///
  /// This button has all logic built-in to do what it needs to operate
  /// the drawer/menu/rail in [FlexScaffold], as defined by its properties
  /// and theme. Typically you would only use this callback to disable the
  /// button, but if needed you can do some custom actions too. Normally that
  /// is however not needed.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool isDrawerOpen = scaffold?.isDrawerOpen ?? false;

    /// Depend on aspects of the FlexScaffold and only rebuild if they change.
    final bool menuIsHidden = FlexScaffold.isMenuHiddenOf(context);
    final bool menuPrefersRail = FlexScaffold.menuPrefersRailOf(context);
    final bool cycleViaDrawer = FlexScaffold.cycleViaDrawerOf(context);

    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double screenHeight = size.height;

    final FlexScaffoldTheme flexTheme = Theme.of(context)
            .extension<FlexScaffoldTheme>()
            ?.withDefaults(context) ??
        const FlexScaffoldTheme().withDefaults(context);
    final double breakpointDrawer = flexTheme.breakpointDrawer!;
    final double breakpointRail = flexTheme.breakpointRail!;
    final double breakpointMenu = flexTheme.breakpointMenu!;

    // Based on height and breakpoint, we are making a phone landscape layout.
    final bool isPhoneLandscape = screenHeight < breakpointDrawer;

    final bool canLockMenu = (width >= breakpointRail) && !isPhoneLandscape;
    final bool mustBeRail = width < breakpointMenu;

    // Reads the FlexScaffold state once, will not update if dependants change.
    // Use it to access FlexScaffold state modifying methods. You may also use
    // it to read widgets used as FlexScaffold action button icons, as long
    // as you don't modify them dynamically in the app.
    final FlexScaffoldState flexScaffold = FlexScaffold.use(context);
    // Set effective expand and collapse icons
    Widget effectiveMenuIcon =
        icon ?? flexScaffold.widget.menuIcon ?? kFlexMenuIcon;
    Widget effectiveMenuIconExpand = iconExpand ??
        flexScaffold.widget.menuIconExpand ??
        icon ??
        kFlexMenuIconExpand;
    Widget effectiveMenuIconExpandHidden = iconExpandHidden ??
        flexScaffold.widget.menuIconExpandHidden ??
        icon ??
        kFlexMenuIconExpandHidden;
    Widget effectiveMenuIconCollapse = iconCollapse ??
        flexScaffold.widget.menuIconCollapse ??
        icon ??
        kFlexMenuIconCollapse;
    // If directionality is RTL we rotate the icons 180 degrees, if directional
    // icons were used in a LTR design, the result should be fairly OK of this,
    // unless the APP was really designed with a RTL mindset, then we should
    // actually rotate them in LTR mode. Do we need an enum to toggle be able
    // to toggle this?
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
    // tooltip labels in FlexScaffoldTheme if other labels were not specified.
    String tooltip;
    Widget effectiveMenuButton;
    if (hasDrawer && !isDrawerOpen && (!canLockMenu || cycleViaDrawer)) {
      tooltip = flexTheme.menuOpenTooltip!;
      effectiveMenuButton = effectiveMenuIcon;
    } else if (hasDrawer && !isDrawerOpen && (canLockMenu || !cycleViaDrawer)) {
      tooltip = flexTheme.menuExpandHiddenTooltip!;
      effectiveMenuButton = effectiveMenuIconExpandHidden;
    } else if (hasDrawer && isDrawerOpen && !canLockMenu) {
      tooltip = flexTheme.menuCloseTooltip!;
      effectiveMenuButton = effectiveMenuIcon;
    } else if (menuIsHidden) {
      tooltip = flexTheme.menuExpandTooltip!;
      effectiveMenuButton = effectiveMenuIconExpand;
    } else {
      tooltip = flexTheme.menuCollapseTooltip!;
      effectiveMenuButton = effectiveMenuIconCollapse;
    }

    return IconButton(
      icon: effectiveMenuButton,
      tooltip: flexTheme.useTooltips! ? tooltip : null,
      onPressed: onPressed == null
          ? null
          : () {
              if (hasDrawer &&
                  !isDrawerOpen &&
                  (!canLockMenu || cycleViaDrawer)) {
                scaffold?.openDrawer();
              } else if (hasDrawer && isDrawerOpen && !canLockMenu) {
                Navigator.of(context).pop();
              } else if (menuIsHidden) {
                flexScaffold.setMenuIsRail(false);
                if (hasDrawer && isDrawerOpen) {
                  Navigator.of(context).pop();
                  // TODO(rydmike): Maybe improve this for the menu to close?
                  // This will give the correct time to allow the menu to close,
                  // after which we set hidden to false and it will animate open
                  // to appropriate lock position. Would be nice if we could
                  // (probably possible somehow) listen to and know when the
                  // Drawer has closed fully and open the locked menu/rail
                  // then, but this works too, but it is a bit of a hack.
                  Future<void>.delayed(kFlexFlutterDrawerDuration, () {
                    flexScaffold.setMenuIsHidden(false);
                  });
                } else {
                  flexScaffold.setMenuIsHidden(false);
                }
              } else {
                if (menuPrefersRail || mustBeRail) {
                  flexScaffold.setMenuIsHidden(true);
                } else {
                  flexScaffold.setMenuIsRail(true);
                }
              }
              // Call the onPressed.
              onPressed?.call();
            },
    );
  }
}
