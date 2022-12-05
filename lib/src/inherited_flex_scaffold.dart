import 'package:flutter/widgets.dart';

import 'flex_scaffold.dart';

/// FlexScaffold implementation of InheritedWidget.
///
/// Used for to find the current FlexScaffold in the widget tree. This is useful
/// when reading FlexScaffold properties and using it methods from anywhere
/// in your app.
class InheritedFlexScaffold extends InheritedWidget {
  /// Data is your entire state. In our case just 'User'
  final FlexScaffoldState data;

  /// You must pass through a child and your state.
  const InheritedFlexScaffold({
    super.key,
    required this.data,
    required super.child,
  });

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  // that rely on your state.
  @override
  bool updateShouldNotify(InheritedFlexScaffold oldWidget) {
    if (oldWidget.data.isMenuInDrawer != data.isMenuInDrawer ||
        oldWidget.data.menuPrefersRail != data.menuPrefersRail ||
        oldWidget.data.menuIsHidden != data.menuIsHidden ||
        oldWidget.data.sidebarIsHidden != data.sidebarIsHidden) {
      return true;
    }
    return true;
  }
}
