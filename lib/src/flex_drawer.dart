import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'flex_scaffold_constants.dart';

// Set the _kDebugMe flag to true to observe debug prints in this file.
//
// In release mode this compile time constant always evaluate to false,
// so in theory anything behind an if (_kDebugMe) {} and the entire if
// statement as well, should get tree shaken away totally in a release build,
// by the Dart AOT compiler.
const bool _kDebugMe = kDebugMode && true;

/// A stateful wrapper for a [Drawer] that holds a width value in its local
/// state and pops away any open drawer if the parent changes the width.
class FlexDrawer extends StatefulWidget {
  /// Default const constructor.
  const FlexDrawer({
    super.key,
    required this.currentScreenWidth,
    this.elevation = 16.0,
    this.drawerWidth = kFlexfoldDrawerWidth,
    this.semanticLabel,
    this.backgroundColor,
    this.child,
  })  : assert(elevation >= 0.0, 'Elevation must be >= 0'),
        assert(
            drawerWidth >= kFlexfoldMenuWidthMin &&
                drawerWidth <= kFlexfoldMenuWidthMax,
            'The drawer width must be >= $kFlexfoldMenuWidthMin and '
            '<= $kFlexfoldMenuWidthMax');

  /// The width of the screen or canvas that the app is running on.
  ///
  /// The currentScreenWidth property can can be obtained with
  /// Theme.of(context).size.width obtained in the parent's build method
  /// or via constraints.maxWidth from a Layout builder. If the
  /// currentScreenWidth changes during the the lifecycle of the FlexfoldDrawer
  /// any open drawer is closed.
  final double currentScreenWidth;

  /// Material elevation of the Drawer.
  ///
  /// Controls the size of the shadow below the drawer. Defaults to 16, the
  /// correct material elevation for drawers. The value is always non-negative.
  final double elevation;

  /// The width of the Flexfold drawer when opened as a drawer.
  ///
  /// The standard material drawer always opens as 304dp wide. Flexfold drawer
  /// can have a defined width when opened. If value is wider than current
  /// canvas/screen it will fill the width of the screen.
  /// Default value is 304dp like a standard Drawer.
  final double drawerWidth;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the drawer is opened and closed.
  ///
  /// If this label is not provided, it will default to
  /// [MaterialLocalizations.drawerLabel].
  final String? semanticLabel;

  /// Background color of the Drawer
  final Color? backgroundColor;

  /// The widget below this widget in the tree.
  final Widget? child;

  @override
  State<FlexDrawer> createState() => _FlexDrawerState();
}

class _FlexDrawerState extends State<FlexDrawer> {
  late bool shouldCloseDrawer;

  @override
  void initState() {
    shouldCloseDrawer = false;
    super.initState();
  }

  @override
  void didUpdateWidget(FlexDrawer oldWidget) {
    if (widget.currentScreenWidth != oldWidget.currentScreenWidth) {
      // TODO(rydmike): Need to better solution for the Drawer removal handling.
      // If the screen WIDTH is being resized we need to close any open
      // drawer because keeping one open will be problematic when/if the width
      // changes beyond the breakpoint where the Drawer will be removed from the
      // widget tree entirely.
      // An alternative way would be to pass in the boolean value for the exact
      // condition when this happens and only then close it, and not right away
      // on any screen width change. On the other hand, there is no need to keep
      // the drawer open during screen resize, it might as well close elegantly.
      // ALSO if we pass in the boolean for the exact trigger when it should be
      // closed it will be too late, the drawer will have been removed from
      // the widget tree then already and then we solved nothing.
      // This "pop" on resize setup works mostly, BUT if we have the drawer
      // open 1dp (or even a few dp's) before the width breakpoint for when
      // the drawer will get deleted from the widget tree and resize very
      // quickly, then the element life cycle defunct error will occur anyway!
      // This happens because in one quick swoop we manage to both pass the
      // breakpoint when drawer is removed from the tree and do the first
      // detected width change. This is not a very common or even very likely
      // scenario, but possible.
      shouldCloseDrawer = true;
    }
    super.didUpdateWidget(oldWidget);
  }

  void onAfterBuild(BuildContext context) {
    setState(() {
      shouldCloseDrawer = false;
      final ScaffoldState? scaffold = Scaffold.maybeOf(context);
      final bool isDrawerOpen = scaffold?.isDrawerOpen ?? false;
      final bool isEndDrawerOpen = scaffold?.isEndDrawerOpen ?? false;
      // Have noticed some rare resize events when the Scaffold has been
      // removed and popping takes us out of the app, so on this frame we
      // check once more if there really is a drawer open and only then pop.
      // This post frame callback is only inserted when there was a drawer open,
      // but via rapid state changes when using eg DevicePreview it is seems
      // possible to get into a situation where it during the post frame existed
      // and was inserted to remove it, but when we come here it is no longer
      // present. This is an attempt to prevent this edge case.
      if (isDrawerOpen || isEndDrawerOpen) {
        Navigator.of(context).pop();
        if (_kDebugMe) debugPrint('onAfterBuild(): Open drawer got popped!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold already ensures that max one drawer can be open per time, thus
    // an OR term of if either one is open passed to the onAfterCallback plus
    // ONE pop in the callback, will take care of closing the one that was open.
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool isDrawerOpen = scaffold?.isDrawerOpen ?? false;
    final bool isEndDrawerOpen = scaffold?.isEndDrawerOpen ?? false;
    // Only insert the post frame callback on a build frame where it is needed.
    if ((isDrawerOpen || isEndDrawerOpen) && shouldCloseDrawer) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => onAfterBuild(context));
    }

    return SizedBox(
      width: widget.drawerWidth,
      child: Drawer(
        elevation: widget.elevation,
        child: Material(
          color: widget.backgroundColor,
          child: widget.child,
        ),
      ),
    );
  }
}
