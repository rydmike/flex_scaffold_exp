import 'package:flutter/material.dart';

import 'flex_app_bar.dart';
import 'flex_menu_button.dart';
import 'flex_scaffold.dart';
import 'flex_sidebar_button.dart';

/// An AppBar widget for the FlexScaffold used when the shell layout
/// uses an AppBar that is not part of the navigation transition.
///
/// This AppBar contains all the built in logic used by [FlexScaffold] to
/// operate its AppBar with potential sidebar and menu buttons that appears in
/// its different states.
///
/// It requires that a [FlexScaffold] exists higher up in the widget tree.
///
/// You can use this app bar widget to easily create app bars for
/// destinations that are not are not opened as a top level destination
/// within the [FlexScaffold] layout shell.
class FlexScaffoldAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  /// Default constructor.
  FlexScaffoldAppBar({
    super.key,
    this.appBar,
  }) : preferredSize = _PreferredAppBarSize(
            appBar?.toolbarHeight, appBar?.bottom?.preferredSize.height);

  /// The [FlexAppBar] that defines the resulting AppBar.
  final FlexAppBar? appBar;

  /// A size whose height is the sum of [AppBar.toolbarHeight] and the
  /// [AppBar.bottom] widget's preferred height.
  ///
  /// [Scaffold] uses this size to set its app bar's height.
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    // If no FlexfoldAppBar was given we make a default one.
    final FlexAppBar usedAppBar = appBar ?? const FlexAppBar();
    assert(
        usedAppBar.leading == null,
        'The main AppBar in FlexScaffold cannot have a leading widget '
        'just leave it as null, it will get one assigned automatically. You '
        'can assign it a custom icon widget separately, but its pressed event '
        'handler will be added by FlexScaffold.');

    // Reads the FlexScaffold state once, will not update if dependants change.
    // Use it to access FlexScaffold state modifying methods. You may also use
    // it to read widgets used as FlexScaffold action button icons, as long
    // as you don't modify them dynamically in the app.
    final FlexScaffoldState flexScaffold = FlexScaffold.use(context);

    /// Depend on aspects of the FlexScaffold and only rebuild if they change.
    final bool isMenuInDrawer = FlexScaffold.isMenuInDrawerOf(context);
    final bool isSidebarInEndDrawer =
        FlexScaffold.isSidebarInEndDrawerOf(context);
    final bool isSidebarInMenu = FlexScaffold.isSidebarInMenuOf(context);
    final bool isSidebarHidden = FlexScaffold.isSidebarHiddenOf(context);
    final bool sidebarControlEnabled =
        FlexScaffold.sidebarControlEnabledOf(context);
    final bool sidebarBelongsToBody =
        FlexScaffold.sidebarBelongsToBodyOf(context);

    // The destination AppBar has no title and transparent background.
    final bool noTitle =
        FlexScaffold.selectedDestinationOf(context).noAppBarTitle;

    // Convert the main FlexfoldAppBar data object to a real AppBar.
    Widget? title = usedAppBar.title;
    final Widget impliedTitle = Text(flexScaffold.currentImpliedTitle);
    if (!noTitle) {
      if (title == null && usedAppBar.automaticallyImplyTitle) {
        title = impliedTitle;
      } else if (usedAppBar.automaticallyImplyTitle && title != null) {
        // If the title was not null and we imply title in a styled FlexAppBar,
        // we will assume that if the title is a Row, that row only contains
        // the widget that shows screen size and we need to insert the implicit
        // title widget. We also need to check centering again.
        if (title is Row) {
          // Effective center title logic is from the Flutter app bar source, we
          // use same logic also for styled AppBar when screen size is shown.
          bool effectiveCenterTitle() {
            final ThemeData theme = Theme.of(context);
            final AppBarTheme appBarTheme = AppBarTheme.of(context);
            if (usedAppBar.centerTitle != null) return usedAppBar.centerTitle!;
            if (appBarTheme.centerTitle != null) {
              return appBarTheme.centerTitle!;
            }
            switch (theme.platform) {
              case TargetPlatform.android:
              case TargetPlatform.fuchsia:
              case TargetPlatform.linux:
              case TargetPlatform.windows:
                return false;
              case TargetPlatform.iOS:
              case TargetPlatform.macOS:
                return usedAppBar.actions == null ||
                    (usedAppBar.actions?.length ?? 0) < 2;
            }
          }

          if (effectiveCenterTitle()) {
            title = Row(children: <Widget>[
              const Spacer(),
              impliedTitle,
              Expanded(child: title),
            ]);
          } else {
            title = Row(
              children: <Widget>[impliedTitle, Expanded(child: title)],
            );
          }
        }
      }
    }
    return usedAppBar.toAppBar(
      automaticallyImplyLeading: false,
      // Only add the menu button on the main AppBar, if menu is in a Drawer.
      leading: isMenuInDrawer ? FlexMenuButton(onPressed: () {}) : null,
      // Overrides for destination without and app bar.
      title: noTitle ? null : title,
      backgroundColor: noTitle ? Colors.transparent : null,
      flexibleSpace: noTitle ? const SizedBox.shrink() : null,
      actions: <Widget>[
        // Insert any pre-existing actions AND
        // in order to not get a default shown end drawer button in the
        // appbar for the sidebar when it is shown as a drawer, we need to
        // insert an invisible widget into the actions list in case it is
        // empty, because if it is totally empty the framework will create
        // a default action button to show the menu, we do not want that.
        ...usedAppBar.actions ?? <Widget>[const SizedBox.shrink()],
        // Then insert the sidebar menu button, if so needed in current layout.
        if (isSidebarInEndDrawer ||
            (isSidebarInMenu &&
                sidebarControlEnabled &&
                (isSidebarHidden || sidebarBelongsToBody)))
          FlexSidebarButton(onPressed: () {}),
      ],
    );
  }
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
