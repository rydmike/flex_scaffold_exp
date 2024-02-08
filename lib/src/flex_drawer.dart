import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'flex_scaffold_constants.dart';

// ignore_for_file: comment_references

// Set the _kDebugMe flag to true to observe debug prints in this file.
//
// In release mode this compile time constant always evaluate to false,
// so in theory anything behind an if (_kDebugMe) {} and the entire if
// statement as well, should get tree shaken away totally in a release build,
// by the Dart AOT compiler.
const bool _debug = kDebugMode && false;

/// A stateful wrapper for a [Drawer] used by [FlexScaffold].
///
/// The [FlexDrawer] keeps the screen width value in its local state and
/// pops away any open drawer if the screen width changes.
class FlexDrawer extends StatefulWidget {
  /// Creates a Material Design drawer used by the [FlexScaffold].
  ///
  /// Typically used in the [FlexScaffold.drawer] ot [FlexScaffold.drawer]
  /// property. It is a stateful wrapper for a [Drawer] that hold screen
  /// width value in its local state and pops away any open drawer if the
  /// screen width changes.
  ///
  /// The [elevation] must be non-negative.
  const FlexDrawer({
    super.key,
    required this.currentScreenWidth,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.width,
    this.semanticLabel,
    this.child,
  })  : assert(elevation == null || elevation >= 0.0,
            'Elevation must be >= 0 or null'),
        assert(
            width == null ||
                width >= kFlexMenuWidthMin && width <= kFlexMenuWidthMax,
            'The drawer width must be >= $kFlexMenuWidthMin and '
            '<= $kFlexMenuWidthMax or null');

  /// The width of the screen or canvas that the app is running on.
  ///
  /// The currentScreenWidth property can can be obtained with
  /// MediaQuery.of(context).size.width obtained in the parent's build method
  /// or via constraints.maxWidth from a Layout builder. If the
  /// currentScreenWidth changes during the the lifecycle of the FlexfoldDrawer
  /// any open drawer is closed automatically.
  ///
  /// This behaviour is needed to ensure that there is no open drawer that
  /// would be removed when the [FlexScaffold] removes the drawer from the
  /// widget tree when it is resized to a size where drawer content will be
  /// shown in a side rail or side menu.
  final double currentScreenWidth;

  /// Background color of the Drawer
  final Color? backgroundColor;

  /// Material elevation of the Drawer.
  ///
  /// Controls the size of the shadow below the drawer.
  ///
  /// Default depends on if Material2 or 3 is used.
  final double? elevation;

  /// The shape of the drawer.
  ///
  /// Defines the drawer's [Material.shape].
  ///
  /// If this is null, then [DrawerThemeData.shape] is used. If that
  /// is also null, then it falls back to [Material]'s default.
  final ShapeBorder? shape;

  /// The width of the Flexfold drawer when opened as a drawer.
  ///
  /// If this is null, then [DrawerThemeData.width] is used. If that is also
  /// null, then it falls back to the Material spec's default (304.0).
  final double? width;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the drawer is opened and closed.
  ///
  /// If this label is not provided, it will default to
  /// [MaterialLocalizations.drawerLabel].
  final String? semanticLabel;

  /// The widget to display in the Drawer.
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
      // TODO(rydmike): Need a better solution for the Drawer removal handling.
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
      // scenario, but possible, and quite easy to do if you know about it.
      shouldCloseDrawer = true;
    }
    super.didUpdateWidget(oldWidget);
  }

  void onAfterBuild(BuildContext context) {
    setState(() {
      shouldCloseDrawer = false;
      // Have noticed some rare resize events when the Scaffold has been
      // removed and popping takes us out of the app, so on this frame we check
      // once more if there really is a Drawer open still and only then pop.
      // This post frame callback is only inserted when there was a drawer open,
      // but via rapid state changes when using eg DevicePreview, it seems
      // possible to get into a situation where it during the build frame
      // existed and was inserted to be removed, but when we come here it is
      // no longer present. This extra check is an attempt to prevent that case.
      final ScaffoldState? scaffold = Scaffold.maybeOf(context);
      final bool isDrawerOpen = scaffold?.isDrawerOpen ?? false;
      final bool isEndDrawerOpen = scaffold?.isEndDrawerOpen ?? false;
      if (isDrawerOpen || isEndDrawerOpen) {
        if (_debug) debugPrint('onAfterBuild(): Open Drawer popped!');
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold already ensures that max one Drawer can be open per time, thus
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

    return Drawer(
      key: widget.key,
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      shape: widget.shape,
      width: widget.width,
      semanticLabel: widget.semanticLabel,
      child: widget.child,
      // TODO(rydmike): Removed this Material, before there was no bg color
      //   in Drawer, but it might not be needed anymore now, test it!
      // child: Material(
      //   color: widget.backgroundColor,
      //   child: widget.child,
      // ),
    );
  }
}
