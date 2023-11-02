import 'package:flutter/material.dart';

import 'flex_scaffold.dart';
import 'flex_scaffold_constants.dart';
import 'flex_scaffold_theme.dart';

// ignore_for_file: comment_references

const double _kLeadingWidth = kToolbarHeight;

/// The sidebar menu button used in a [FlexScaffold] and its [FlexSidebar].
///
/// The button holds the logic for managing toggling the state of the sidebar
/// menu between hidden in drawer and locked on screen.
class FlexSidebarButton extends StatelessWidget {
  /// Default constructor.
  const FlexSidebarButton({
    super.key,
    this.icon,
    this.iconExpand,
    this.iconExpandHidden,
    this.iconCollapse,
    required this.onPressed,
  });

  /// A Widget used on the sidebar button when the sidebar is operated as an
  /// end Drawer.
  ///
  /// Typically an [Icon] widget is used with the hamburger menu icon.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, it defaults to a widget
  /// with value [kFlexSidebarIcon], the hamburger icon.
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? icon;

  /// A widget used on an opened end drawer sidebar button when operating it
  /// will change it to a fixed sidebar.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [icon] was not
  /// defined, it defaults to a widget with value [kFlexSidebarIconExpand].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? iconExpand;

  /// A widget used on the sidebar button when operating it will expand the
  /// hidden sidebar to a fixed side menu.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [icon] was not
  /// defined, it defaults to a widget with value
  /// [kFlexSidebarIconExpandHidden].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? iconExpandHidden;

  /// A widget used on the sidebar button when it is shown as a fixed sidebar,
  /// and operating it will collapse it to its hidden state.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [icon] was not
  /// defined, it defaults to a widget with value
  /// [kFlexSidebarIconCollapse].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? iconCollapse;

  /// The callback that is called when the sidebar button is tapped or otherwise
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
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
    final bool isEndDrawerOpen = scaffold?.isEndDrawerOpen ?? false;

    // This only reads the FlexScaffold state once, it won't update.
    // We can also use it to access its state modifying methods.
    final FlexScaffoldState flexScaffold = FlexScaffold.use(context);

    // Listen to aspect of the FlexScaffold and only rebuild if it changes.
    final bool isSidebarHidden = FlexScaffold.isSidebarHiddenOf(context);

    // Rebuild if media width changes.
    final double width = MediaQuery.sizeOf(context).width;

    final FlexScaffoldTheme flexTheme = Theme.of(context)
            .extension<FlexScaffoldTheme>()
            ?.withDefaults(context) ??
        const FlexScaffoldTheme().withDefaults(context);

    final double breakpointSidebar = flexTheme.breakpointSidebar!;
    final bool canLockMenu = width >= breakpointSidebar;

    // Set effective expand and collapse icons
    Widget effectiveMenuIcon =
        icon ?? flexScaffold.widget.sidebarIcon ?? kFlexSidebarIcon;
    Widget effectiveMenuIconExpand = iconExpand ??
        flexScaffold.widget.sidebarIconExpand ??
        icon ??
        kFlexSidebarIconExpand;
    Widget effectiveMenuIconExpandHidden = iconExpandHidden ??
        flexScaffold.widget.sidebarIconExpandHidden ??
        icon ??
        kFlexSidebarIconExpandHidden;
    Widget effectiveMenuIconCollapse = iconCollapse ??
        flexScaffold.widget.sidebarIconCollapse ??
        icon ??
        kFlexSidebarIconCollapse;
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
    // tooltip labels in FlexfoldThemeData if other labels were not specified.
    String tooltip;
    Widget effectiveMenuButton;
    if (hasEndDrawer &&
        !isEndDrawerOpen &&
        (!canLockMenu || flexScaffold.widget.cycleViaDrawer)) {
      tooltip = flexTheme.sidebarOpenTooltip!;
      effectiveMenuButton = effectiveMenuIcon;
    } else if (hasEndDrawer &&
        !isEndDrawerOpen &&
        (canLockMenu || !flexScaffold.widget.cycleViaDrawer)) {
      tooltip = flexTheme.sidebarExpandHiddenTooltip!;
      effectiveMenuButton = effectiveMenuIconExpandHidden;
    } else if (hasEndDrawer && isEndDrawerOpen && !canLockMenu) {
      tooltip = flexTheme.sidebarCloseTooltip!;
      effectiveMenuButton = effectiveMenuIcon;
    } else if (isSidebarHidden) {
      tooltip = flexTheme.sidebarExpandTooltip!;
      effectiveMenuButton = effectiveMenuIconExpand;
    } else {
      tooltip = flexTheme.sidebarCollapseTooltip!;
      effectiveMenuButton = effectiveMenuIconCollapse;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: _kLeadingWidth),
      child: IconButton(
        icon: effectiveMenuButton,
        tooltip: flexTheme.useTooltips! ? tooltip : null,
        onPressed: () {
          if (hasEndDrawer &&
              !isEndDrawerOpen &&
              (!canLockMenu || flexScaffold.widget.cycleViaDrawer)) {
            scaffold!.openEndDrawer();
          } else if (hasEndDrawer && isEndDrawerOpen && !canLockMenu) {
            Navigator.of(context).pop();
          } else if (isSidebarHidden) {
            if (hasEndDrawer && isEndDrawerOpen) {
              Navigator.of(context).pop();
              // TODO(rydmike): Improve this, that waits for the menu to close.
              // This will give the correct time to allow the menu to close,
              // after which we set hidden to false and it will animate open to
              // appropriate lock position. Would be nice if we could (probably
              // possible somehow?) listen to and know when the end Drawer has
              // closed fully and open the locked sidebar then, but this
              // works too.
              Future<void>.delayed(kFlexFlutterDrawerDuration, () {
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
