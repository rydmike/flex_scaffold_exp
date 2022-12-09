import 'package:flutter/material.dart';

import 'flex_app_bar.dart';
import 'flex_menu_button.dart';
import 'flex_scaffold.dart';
import 'flex_sidebar_button.dart';

/// An AppBar widget for the FlexScaffold used when the shell layout
/// creates AppBar's not part of the navigation transition.
///
/// This AppBar contains all the built in logic used by [FlexScaffold] to
/// operate it AppBar with potential sidebar and menu buttons that appears in
/// it different states.
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
    final FlexScaffoldState flexScaffold = FlexScaffold.of(context);
    assert(
        usedAppBar.leading == null,
        'The main AppBar in FlexScaffold cannot have a leading widget '
        'just leave it as null, it will get one assigned automatically. You '
        'can assign it a custom icon widget separately, but its pressed event '
        'handler will be added by FlexScaffold.');

    // Convert the main FlexfoldAppBar data object to a real AppBar.
    Widget? title = usedAppBar.title;
    final Widget impliedTitle = Text(flexScaffold.currentImpliedTitle);
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
    return usedAppBar.toAppBar(
      automaticallyImplyLeading: false,
      // Only add the menu button on the main AppBar, if menu is in a Drawer.
      leading:
          flexScaffold.isMenuInDrawer ? FlexMenuButton(onPressed: () {}) : null,
      title: title,
      actions: <Widget>[
        // Insert any pre-existing actions AND
        // in order to not get a default shown end drawer button in the
        // appbar for the sidebar when it is shown as a drawer, we need to
        // insert an invisible widget into the actions list in case it is
        // empty, because if it is totally empty the framework will create
        // a default action button to show the menu, we do not want that.
        ...usedAppBar.actions ?? <Widget>[const SizedBox.shrink()],
        // Then insert the sidebar menu button, if so needed in current layout.
        if (flexScaffold.isSidebarInEndDrawer ||
            (flexScaffold.isSidebarInMenu &&
                flexScaffold.widget.sidebarBelongsToBody &&
                flexScaffold.widget.sidebarControlEnabled))
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