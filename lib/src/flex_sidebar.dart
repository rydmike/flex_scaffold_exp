import 'package:flutter/material.dart';

import 'flex_app_bar.dart';
import 'flex_scaffold.dart';
import 'flex_sidebar_button.dart';
import 'flexfold_theme.dart';

/// FlexScaffold widget that manages the animated showing and hiding of
/// the sidebar menu.
class FlexSidebar extends StatefulWidget {
  /// Default constructor
  const FlexSidebar({
    super.key,
    // this.sidebarToggleEnabled = true,
    required this.sidebarAppBar,
    // this.sidebarBelongsToBody = true,
    this.hasAppBar = true,
    this.child,
  });

  // /// The menu mode can be manually toggled by the user when true.
  // ///
  // /// If set to false, then the menu can only be opened when it is a drawer,
  // /// it cannot be toggled between rail/menu and drawer manually when the
  // /// breakpoint constraints would otherwise allow that. This means the user
  // /// cannot hide the side menu or the rail, when rail or side navigation mode
  // /// is triggered. You can still control it via the API, there just is no
  // /// user control over.
  // ///
  // /// Defaults to true so users can toggle the menu and rail visibility as they
  // /// prefer on a large canvas.
  // final bool sidebarToggleEnabled;

  /// The appbar for the sidebar.
  final FlexAppBar? sidebarAppBar;

  // /// When sidebar belongs to the body, it is a vertical end column made in a
  // /// row item after the body content.
  // ///
  // /// This is the default Material design based on the illustration here:
  // /// https://material.io/design/layout/responsive-layout-grid.html#ui-regions
  // /// Where the app bar stretches over the end drawer that is visible as a
  // /// sidebar. An alternative way to display the sidebar as a permanent fixture
  // /// is to have it at the same level as app bar, then the design has 3 vertical
  // /// columns in one row: menu, appbar with body in same column under it and the
  // /// sidebar. The difference is a bit nuanced, but you can use either way.
  // ///
  // ///
  // /// When you want to make a destination that uses a sliver app bar or
  // /// persisting headers as app bars, you might want to set
  // /// [sidebarBelongsToBody] to false in order to get sidebar that has a
  // /// menu button in all situations so that it can be toggled opened/closed.
  // /// If the open close toggle function is not need you can still make sliver
  // /// app bars with sidebarBelongsToBody set to true.
  // ///
  // /// By default the sidebar belongs to the body, [sidebarBelongsToBody] = true.
  // final bool sidebarBelongsToBody;

  /// This is false if the current destination has no app bar;
  ///
  /// When the active destination has no main app bar, this flag is passed in as
  /// false. It allows us to in such a case add an app bar to the side bar
  /// also when it is used as a fixed menu, normally when the the menu is a
  /// part of the scaffold body and there is an app bar for the body, there
  /// is no app bar on the side bar, because it would be a duplicate. However,
  /// if the main body has no app bar at all, not needed ot it is provided via
  /// a sliver, then the sidebar should have its own little app bar.
  final bool hasAppBar;

  /// The child widget inside the sidebar.
  ///
  /// It is up to the provider of the child to make sure it fits nicely
  /// with in the max width of the sidebar, both when it is used as end drawer
  /// or as a permanent sidebar at large canvas width. Use a LayoutBuilder
  /// if needed to make it fit in both drawer width (304dp) and used
  /// sidebar width.
  final Widget? child;

  @override
  State<FlexSidebar> createState() => _FlexSidebarState();
}

class _FlexSidebarState extends State<FlexSidebar> {
  // Local build state
  late double width;
  // late bool hideSidebar;

  @override
  void initState() {
    super.initState();
    width = 0.0;
    // hideSidebar = widget.hideSidebar;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(FlexSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (oldWidget.hideSidebar != widget.hideSidebar) {
    //   hideSidebar = widget.hideSidebar;
    // }
  }

  @override
  Widget build(BuildContext context) {
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
    final bool isEndDrawerOpen = scaffold?.isEndDrawerOpen ?? false;

    final double screenWidth = MediaQuery.of(context).size.width;

    final FlexScaffoldThemeData flexTheme = FlexScaffoldTheme.of(context);
    final double breakpointSidebar = flexTheme.breakpointSidebar!;
    final double sidebarWidth = flexTheme.sidebarWidth!;

    /// Listen to aspect of the FlexScaffold and only rebuild if they change.
    final bool isSidebarHidden = FlexScaffold.isSidebarHiddenOf(context);

    final bool isInEndDrawer =
        (isSidebarHidden || screenWidth < breakpointSidebar) &&
            hasEndDrawer &&
            isEndDrawerOpen;

    if (isInEndDrawer) {
      return _SideBar(
        hasAppBar: widget.hasAppBar,
        sidebarAppBar: widget.sidebarAppBar,
        child: widget.child,
      );
    } else {
      if (screenWidth < breakpointSidebar || isSidebarHidden) {
        width = 0.0;
      } else {
        width = sidebarWidth;
      }
      return AnimatedContainer(
        duration: flexTheme.sidebarAnimationDuration!,
        curve: flexTheme.sidebarAnimationCurve!,
        width: width,
        // TODO(rydmike): New size animation where we can clamp curve.
        // If you use an animation curve with negative overshoot there will
        // be a: "BoxConstraint has negative minimum width" error.
        // I tired clamping
        // this width to avoid it, but it did not help as this width does not
        // actually animate, that width value is inside the implicit animation
        // and we cannot really touch it
        // width: width.clamp(0.0, widget.sidebarWidth).toDouble(),
        // The best we can do is probably just to advise not to use curves
        // with negative overshoot.
        child: _SideBar(
          hasAppBar: widget.hasAppBar,
          sidebarAppBar: widget.sidebarAppBar,
          child: widget.child,
        ),
      );
    }
  }
}

class _SideBar extends StatelessWidget {
  const _SideBar({
    required this.hasAppBar,
    this.sidebarAppBar,
    this.child,
  });

  final bool hasAppBar;

  /// The appbar for the sideBar.
  final FlexAppBar? sidebarAppBar;

  /// The child widget inside the sidebar.
  ///
  /// It is up to the provider of the child to make sure it fits nicely
  /// with in the max width of the sidebar, both when it is used as end drawer
  /// or as a permanent sidebar at large canvas width. Use a LayoutBuilder
  /// if needed to make it fit in both drawer width (304dp) and used
  /// sidebar width.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool isEndDrawerOpen = scaffold?.isEndDrawerOpen ?? false;

    final FlexScaffoldThemeData flexTheme = FlexScaffoldTheme.of(context);
    // final double breakpointSidebar = theme.breakpointSidebar!;
    final bool borderOnSidebar = flexTheme.borderOnSidebar!;
    final bool borderOnDrawerEdgeInDarkMode = flexTheme.borderOnDarkDrawer!;
    final bool borderOnDrawerEdgeInLightMode = flexTheme.borderOnLightDrawer!;
    // Get the border color for borders
    final Color borderColor = flexTheme.borderColor!;
    // Get the sidebar width
    final double sidebarWidth = flexTheme.sidebarWidth!;

    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    // Draw a border on drawer edge?
    final bool useDrawerBorderEdge = (isDark && borderOnDrawerEdgeInDarkMode) ||
        (!isDark && borderOnDrawerEdgeInLightMode);

    // This only reads the FlexScaffold state once, it won't update.
    // We can also use it to access its state modifying methods.
    final FlexScaffoldState flexScaffold = FlexScaffold.use(context);

    return OverflowBox(
      alignment: AlignmentDirectional.topStart,
      minWidth: 0,
      maxWidth: isEndDrawerOpen ? null : sidebarWidth,
      // The Container is used to draw an edge on the drawer side facing the
      // body, this is used, when so configured in the Flexfold constructor.
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: isEndDrawerOpen && useDrawerBorderEdge
              ? BorderDirectional(start: BorderSide(color: borderColor))
              : null,
        ),
        child: Column(
          children: <Widget>[
            //
            // The sidebar appbar on top in a column
            //
            // Build a SidebarAppBar if in drawer mode or sidebar is a menu
            // and it does not belong to the body.
            if (isEndDrawerOpen ||
                !flexScaffold.widget.sidebarBelongsToBody ||
                !hasAppBar)
              _SidebarAppBar(sidebarAppBar: sidebarAppBar)
            // If sidebar was not in drawer but does belong to the body
            else
              // Then this container height and color will be behind the appbar
              // if we have the setting to draw behind it active, this
              // color will match the scaffold background color to
              // make it indistinguishable from the background so that we cannot
              // see that the sidebar also extend up and behind the appbar in
              // this mode, as we do not want to see that, it's not pretty.
              Container(
                height: topPadding,
                color: theme.scaffoldBackgroundColor,
              ),
            //
            // Put the side bar child below the app bar in an expanded widget
            // that can fill all available space left
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: borderOnSidebar && !isEndDrawerOpen
                      ? BorderDirectional(start: BorderSide(color: borderColor))
                      : null,
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The AppBar for the Sidebar when it is used.
class _SidebarAppBar extends StatelessWidget {
  const _SidebarAppBar({this.sidebarAppBar});

  /// The appbar for the sideBar is just a configuration data class for an
  /// actual appbar that will be built using a real AppBar widget.
  final FlexAppBar? sidebarAppBar;

  @override
  Widget build(BuildContext context) {
    // If no FlexfoldAppBar was given we make a default one
    final FlexAppBar flexAppBar = sidebarAppBar ?? const FlexAppBar();
    final double topPadding = MediaQuery.of(context).padding.top;
    final FlexScaffoldState flexScaffold = FlexScaffold.use(context);
    final ThemeData theme = Theme.of(context);
    final Color scaffoldColor = theme.scaffoldBackgroundColor;

    return Stack(
      children: <Widget>[
        // We put the appbar in a Stack so we can put the scaffold background
        // color on a Container behind the AppBar so we get transparency against
        // the scaffold background color and not the canvas color.
        Container(
          height: kToolbarHeight + topPadding,
          color: scaffoldColor,
        ),
        // Convert the FlexfoldAppBar data object to a real AppBar
        flexAppBar.toAppBar(
          // We never want an automatic leading widget, so we override it to
          // false, but if some leading Widget is explicitly passed in for the
          // sidebar appbar it will be kept intact, might not be a very often
          // used feature, but we can allow it.
          automaticallyImplyLeading: false,
          // Add the leading widget if there was one
          leading: flexAppBar.leading,
          actions: <Widget>[
            // Insert any pre-existing actions
            // In order to not get a default show end drawer button in the
            // appbar for the sidebar, when it is shown as a drawer, we need
            // insert an invisible widget into the actions list in case it is
            // empty, because if it is totally empty the framework will create
            // a default action button to show the menu, we do not want that.
            ...flexAppBar.actions ?? <Widget>[const SizedBox.shrink()],
            // Then we insert the sidebar menu button last in the actions list
            if (flexScaffold.widget.sidebarControlEnabled)
              FlexSidebarButton(
                onPressed: () {},
              ),
          ],
        ),
      ],
    );
  }
}
