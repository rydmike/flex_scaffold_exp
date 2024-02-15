import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/material.dart';

import 'flex_app_bar.dart';
import 'flex_scaffold.dart';
import 'flex_scaffold_theme.dart';
import 'flex_sidebar_button.dart';

/// A sidebar widget used by [FlexScaffold] that manages the animated
/// showing and hiding of the sidebar menu.
class FlexSidebar extends StatefulWidget {
  /// Default constructor
  const FlexSidebar({
    super.key,
    this.appBar,
    this.child,
  });

  /// The AppBar for the end drawer and sidebar.
  ///
  /// The side drawer has an appbar in it too. It always gets an automatic
  /// action button to control its appearance and hiding it. There is no
  /// automatic leading button action for it, but you can still create one
  /// manually as well as adding additional actions to it.
  final FlexAppBar? appBar;

  /// The child widget providing the content to the sidebar.
  ///
  /// It is up to the provider of the child to make sure it fits nicely
  /// with in the max width of the sidebar, both when it is used as end drawer
  /// or as a permanent sidebar with larger canvas width. Use a LayoutBuilder
  /// if needed to make it fit in both drawer width (304dp) and used
  /// sidebar width.
  final Widget? child;

  @override
  State<FlexSidebar> createState() => _FlexSidebarState();
}

class _FlexSidebarState extends State<FlexSidebar> {
  double width = 0;

  @override
  Widget build(BuildContext context) {
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
    final bool isEndDrawerOpen = scaffold?.isEndDrawerOpen ?? false;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final FlexScaffoldTheme flexTheme = Theme.of(context)
            .extension<FlexScaffoldTheme>()
            ?.withDefaults(context) ??
        const FlexScaffoldTheme().withDefaults(context);
    final double breakpointSidebar = flexTheme.breakpointSidebar!;
    final double sidebarWidth = flexTheme.sidebarWidth!;
    // Depend on aspects of the FlexScaffold and only rebuild if they change.
    final bool isSidebarHidden = FlexScaffold.isSidebarHiddenOf(context);
    final bool isInEndDrawer =
        (isSidebarHidden || screenWidth < breakpointSidebar) &&
            hasEndDrawer &&
            isEndDrawerOpen;
    if (isInEndDrawer) {
      return _SideBar(
        sidebarAppBar: widget.appBar,
        child: widget.child,
      );
    } else {
      if (screenWidth < breakpointSidebar || isSidebarHidden) {
        width = 0.0;
      } else {
        width = sidebarWidth;
      }
      return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: width),
          duration: flexTheme.sidebarAnimationDuration!,
          curve: flexTheme.sidebarAnimationCurve!,
          builder: (BuildContext context, double width, Widget? child) {
            return SizedBox(
              // With this clamp we can also use overshooting Curves.
              width: clampDouble(width, 0.0, sidebarWidth),
              child: _SideBar(
                sidebarAppBar: widget.appBar,
                child: widget.child,
              ),
            );
          });
    }
  }
}

class _SideBar extends StatelessWidget {
  const _SideBar({
    this.sidebarAppBar,
    this.child,
  });

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
    final double topPadding = MediaQuery.paddingOf(context).top;

    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool isEndDrawerOpen = scaffold?.isEndDrawerOpen ?? false;

    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final FlexScaffoldTheme flexTheme =
        theme.extension<FlexScaffoldTheme>()?.withDefaults(context) ??
            const FlexScaffoldTheme().withDefaults(context);

    final bool borderOnSidebar = flexTheme.borderOnSidebar!;
    final bool borderOnDrawerEdgeInDarkMode = flexTheme.borderOnDarkDrawer!;
    final bool borderOnDrawerEdgeInLightMode = flexTheme.borderOnLightDrawer!;
    final Color borderColor = flexTheme.borderColor!;
    final double sidebarWidth = flexTheme.sidebarWidth!;

    // Draw a border on sidebar edge?
    final bool useDrawerBorderEdge = (isDark && borderOnDrawerEdgeInDarkMode) ||
        (!isDark && borderOnDrawerEdgeInLightMode);

    /// Depend on aspects of the FlexScaffold and only rebuild if they change.
    final bool sidebarBelongsToBody =
        FlexScaffold.sidebarBelongsToBodyOf(context);
    final bool noAppBar = FlexScaffold.onDestinationOf(context).noAppBar;

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
            // The sidebar AppBar on top in a column
            //
            // Add SidebarAppBar if in end Drawer mode or Sidebar is a menu
            // and it does not belong to the body.
            if (isEndDrawerOpen || !sidebarBelongsToBody || noAppBar)
              _SidebarAppBar(sidebarAppBar: sidebarAppBar)
            // Else sidebar was not in drawer but does belong to the body
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
            // that can fill all available space left. We also add the
            // FlexScaffold theme configured border.
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
    // If no FlexfoldAppBar was given, we make a default one, we need it
    // for the control button, even if nothing else is used.
    final FlexAppBar flexAppBar = sidebarAppBar ?? const FlexAppBar();

    final double topPadding = MediaQuery.paddingOf(context).top;
    final ThemeData theme = Theme.of(context);
    final Color scaffoldColor = theme.scaffoldBackgroundColor;

    /// Depend on aspects of the FlexScaffold and only rebuild if they change.
    final bool sidebarControlEnabled =
        FlexScaffold.sidebarControlEnabledOf(context);

    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool isEndDrawerOpen = scaffold?.isEndDrawerOpen ?? false;

    return Stack(
      children: <Widget>[
        // We put the appbar in a Stack so we can put the scaffold background
        // color on a Container behind the AppBar so we get transparency against
        // the scaffold background color and not the canvas color.
        // TODO(rydmike): With new Drawer bg color, do I still need this?
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
            // In order to not get a default end drawer button in the
            // appbar for the sidebar, when it is shown as a drawer, we need
            // insert an invisible widget into the actions list in case it is
            // empty, because if it is totally empty the framework will create
            // a default action button to show the menu, we do not want that.
            ...flexAppBar.actions ?? <Widget>[const SizedBox.shrink()],
            // Then we insert the sidebar menu button last in the actions list
            if (sidebarControlEnabled || isEndDrawerOpen)
              FlexSidebarButton(onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
