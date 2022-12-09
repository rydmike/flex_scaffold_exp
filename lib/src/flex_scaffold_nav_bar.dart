import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'flex_bottom_bar.dart';
import 'flex_scaffold.dart';
import 'flex_scaffold_constants.dart';
import 'flexfold_theme.dart';

// Set to true to observe debug prints. In release mode this compile time
// const always evaluate to false, so in theory anything with only an
// if (_kDebugMe) {} should get tree shaken away totally in a release build.
const bool _kDebugMe = kDebugMode && false;

/// A bottom bar wrapper used by [FlexScaffold] to use and operate the
/// default built in bottom navigation options in Flutter.
///
/// You can also use custom navigation bars and pre-made packages, by passing
/// them in using appropriate wrapper functionality.
class FlexScaffoldBottomBar extends StatelessWidget {
  /// Default constructor for [FlexScaffoldBottomBar].
  const FlexScaffoldBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Current platform and useMaterial3?
    final ThemeData theme = Theme.of(context);
    final TargetPlatform platform = theme.platform;
    final bool useMaterial3 = theme.useMaterial3;

    // Get the custom Flexfold theme, closest inherited one.
    final FlexScaffoldThemeData flexTheme = FlexScaffoldTheme.of(context);
    // Resolve the effective bottom bar type
    FlexfoldBottomBarType effectiveType =
        flexTheme.bottomBarType ?? FlexfoldBottomBarType.adaptive;
    if (effectiveType == FlexfoldBottomBarType.adaptive) {
      if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
        effectiveType = FlexfoldBottomBarType.cupertino;
      } else {
        effectiveType = useMaterial3
            ? FlexfoldBottomBarType.material3
            : FlexfoldBottomBarType.material2;
      }
    }
    if (_kDebugMe) {
      debugPrint('FlexScaffold: effectiveType = $effectiveType');
    }
    // The height of the bottom nav bars may differ, we need
    // to get the correct height for the effective bottom nav bar.
    // TODO(rydmike): Make this nice handle alwaysHide labels for NavigationBar.
    final double effectiveToolBarHeight =
        effectiveType == FlexfoldBottomBarType.material2
            ? kBottomNavigationBarHeight
            : effectiveType == FlexfoldBottomBarType.material3
                ? (NavigationBarTheme.of(context).height ??
                    kFlexfoldNavigationBarHeight)
                : kFlexfoldCupertinoTabBarHeight;

    final FlexScaffoldState flexScaffold = FlexScaffold.of(context);

    // If we are not at a destination that is defined to be a bottom target,
    // we are not inserting a bottom nav bar in the widget tree all
    return flexScaffold.isBottomTarget
        // TODO(rydmike): Investigate AnimatedSize usage instead.
        // This setup with the bottom bar in an animated container inside a
        // Wrap animate the size and it looks like the bottom bar slides
        // down and away when you do that in a Wrap.
        //
        // The effective height in the type of bottom bar also animate between
        // the different sizes the bottom bar has, so when the type is changed
        // if they have different sizes, which Material and Cupertino does, the
        // toggle between them is animated.
        // It is just cool bonus effect of this setup.
        ? AnimatedContainer(
            duration: flexTheme.bottomBarAnimationDuration!,
            curve: flexTheme.bottomBarAnimationCurve!,
            height:
                flexScaffold.isBottomBarVisible ? effectiveToolBarHeight : 0.0,
            child: Wrap(
              children: <Widget>[
                FlexBottomBar(
                  bottomBarType: effectiveType,
                  destinations: flexScaffold.bottomDestinations,
                  selectedIndex: flexScaffold.indexBottom.index,
                  onDestinationSelected: flexScaffold.navigateToBottomIndex,
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
