import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'flex_destination.dart';
import 'flex_scaffold.dart';
import 'flex_scaffold_constants.dart';
import 'flex_scaffold_helpers.dart';
import 'flex_scaffold_theme.dart';

// Set to true to observe debug prints. In release mode this compile time
// const always evaluate to false, so in theory anything with only an
// if (_debug) {} should get tree shaken away totally in a release build.
const bool _debug = kDebugMode && false;

/// A bottom bar wrapper used by [FlexScaffold] to use and operate the
/// default built-in and custom bottom navigation options in Flutter.
///
/// It can also use custom navigation bars and pre-made packages, by passing
/// it in using appropriate FlexScaffold features in its destinations, index and
/// on change callbacks.
///
/// See the example for how to use FlexScaffold with a few custom bottom
/// navigation bar packages.
class FlexBottomBar extends StatelessWidget {
  /// Default constructor for [FlexBottomBar].
  const FlexBottomBar({
    super.key,
    this.customNavigationBar,
    this.customNavigationBarHeight,
  });

  /// Optional custom bottom navigation.
  ///
  /// Used to provide custom made or package based bottom navigation bar.
  final Widget? customNavigationBar;

  /// The height of the custom navigation bar.
  ///
  /// If not provided it assumed to be same height as Material 2 bottom
  /// navigation bar height, which is [kBottomNavigationBarHeight].
  final double? customNavigationBarHeight;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TargetPlatform platform = theme.platform;
    final bool useMaterial3 = theme.useMaterial3;
    final FlexScaffoldTheme flexTheme =
        theme.extension<FlexScaffoldTheme>()?.withDefaults(context) ??
            const FlexScaffoldTheme().withDefaults(context);
    // Resolve the effective bottom bar type
    FlexBottomType effectiveType =
        flexTheme.bottomType ?? FlexBottomType.adaptive;
    if (effectiveType == FlexBottomType.adaptive) {
      if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
        effectiveType = FlexBottomType.cupertino;
      } else {
        effectiveType =
            useMaterial3 ? FlexBottomType.material3 : FlexBottomType.material2;
      }
    }
    if (_debug) {
      debugPrint('FlexScaffoldBottomBar: effectiveType = $effectiveType');
    }
    final bool useCustomBar =
        effectiveType == FlexBottomType.custom && customNavigationBar != null;
    // The height of the bottom nav bars may differ, we need
    // to get the correct height for the effective bottom nav bar.
    final double effectiveToolBarHeight = useCustomBar
        ? customNavigationBarHeight ?? kBottomNavigationBarHeight
        : effectiveType == FlexBottomType.material2
            ? kBottomNavigationBarHeight
            : effectiveType == FlexBottomType.material3
                ? (NavigationBarTheme.of(context).height ??
                    kFlexNavigationBarHeight)
                : kFlexCupertinoTabBarHeight;

    // Reads the FlexScaffold state once, will not update if dependants change.
    // Use it to access FlexScaffold state modifying methods. You may also use
    // it to read widgets used as FlexScaffold action button icons, as long
    // as you don't modify them dynamically in the app.
    final FlexScaffoldState flexScaffold = FlexScaffold.use(context);

    /// Depend on aspects of the FlexScaffold and only rebuild if they change.
    final bool isBottomTarget = FlexScaffold.isBottomTargetOf(context);
    final bool isBottomBarVisible = FlexScaffold.isBottomBarVisibleOf(context);

    // If we are not at a destination that is defined to be a bottom target,
    // we are not inserting a bottom nav bar in the widget tree all
    return isBottomTarget
        // This setup with an animated size, with a wrap inside the AnimatedSize
        // that contains the used bottom navigation bar looks like the bottom
        // bar slides down and away when you do that in a Wrap that goe to zero
        // height.
        //
        // The effective height in the type of bottom bar also animate between
        // the different sizes the bottom bar has, so when the type is changed
        // if they have different sizes, which Material and Cupertino does, the
        // toggle between them is animated.
        // It is just cool bonus effect of this setup.
        ? AnimatedSize(
            duration: flexTheme.bottomAnimationDuration!,
            curve: flexTheme.bottomAnimationCurve!,
            child: SizedBox(
              height: isBottomBarVisible ? effectiveToolBarHeight : 0.0,
              // TODO(rydmike): Review if TraversalGroup is needed here.
              child: FocusTraversalGroup(
                child: Wrap(
                  children: <Widget>[
                    if (customNavigationBar == null)
                      if (effectiveType == FlexBottomType.cupertino)
                        CupertinoBottomBar(
                          destinations: flexScaffold.bottomDestinations,
                          selectedIndex: flexScaffold.indexBottom.index,
                          onDestinationSelected: flexScaffold.setBottomIndex,
                        )
                      else if (effectiveType == FlexBottomType.material3)
                        Material3BottomBar(
                          destinations: flexScaffold.bottomDestinations,
                          selectedIndex: flexScaffold.indexBottom.index,
                          onDestinationSelected: flexScaffold.setBottomIndex,
                        )
                      else
                        Material2BottomBar(
                          destinations: flexScaffold.bottomDestinations,
                          selectedIndex: flexScaffold.indexBottom.index,
                          onDestinationSelected: flexScaffold.setBottomIndex,
                        )
                    else
                      customNavigationBar!,
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}

/// The Material style bottom navigation bar used by FlexScaffold.
///
/// The style of it is controlled by the FlexScaffoldTheme, its styling
/// properties goes a bit beyond the the standard, it has opacity and  blur
/// properties as well as top border property. The Material bottom navigation
/// bar can thus style wise be made to imitate a CupertinoBottomBar.
class Material2BottomBar extends StatelessWidget {
  /// Default constructor.
  const Material2BottomBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  })  : assert(destinations.length >= 2, 'Length must be 2 or higher'),
        assert(0 <= selectedIndex && selectedIndex < destinations.length,
            'Selected index must be: [0 ... length[ ');

  /// Defines the appearance of the button items that are arrayed within the
  /// drawer, rail, menu and bottom bar.
  ///
  /// The value must be a list of two or more [FlexDestination]
  /// values.
  final List<FlexDestination> destinations;

  /// The index into [destinations] for the current selected
  /// [FlexDestination].
  final int selectedIndex;

  /// Called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the FlexScaffold navigation needs to keep
  /// track of the index of the selected [FlexDestination] and call
  /// `setState` to rebuild the menu, drawer, rail or bottom bar
  /// with the new [selectedIndex].
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final FlexScaffoldTheme flexTheme = Theme.of(context)
            .extension<FlexScaffoldTheme>()
            ?.withDefaults(context) ??
        const FlexScaffoldTheme().withDefaults(context);
    // Get and compute effective background color
    final double opacity =
        flexTheme.bottomIsTransparent! ? flexTheme.bottomOpacity! : 1.0;
    final Color effectiveBackgroundColor = (flexTheme.bottomBackgroundColor ??
            theme.bottomNavigationBarTheme.backgroundColor ??
            flexTheme.menuBackgroundColor ??
            scheme.background)
        .withOpacity(opacity);

    // Check if the result of effectiveBackgroundColor is opaque
    final bool isOpaque = effectiveBackgroundColor.alpha == 0xFF;
    // Check if FlexScaffold tooltips should be shown.
    final bool useTooltips = flexTheme.useTooltips ?? false;

    // Effective elevation for the BottomNavigationBar.
    // May be null and fall via theme for bottom nav bar and then SDK defaults
    // which is 8 for the BottomNavigationBar
    final double? elevation = flexTheme.bottomElevation;

    return IfWrapper(
      // If the bottom bar is NOT fully opaque and bottom blur is enabled, then
      // wrap the Decoration with blur backdrop filter, otherwise we leave out
      // the blur filter, as it is a bit costly to render when not needed and
      // there is no transparency its effect cannot be seen.
      condition: !isOpaque && flexTheme.bottomBlur!,
      builder: (BuildContext context, Widget child) {
        return ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: child,
          ),
        );
      },
      child: DecoratedBox(
        // This decoration adds the effective color and top side border
        // to the Material BottomNavigationBar
        decoration: BoxDecoration(
          border: flexTheme.bottomTopBorder!
              ? Border(top: BorderSide(color: flexTheme.borderColor!))
              : const Border(),
          color: effectiveBackgroundColor,
        ),
        child: BottomNavigationBar(
          // The bottom is always fully transparent, the color
          // is added via the box decoration. This was needed in order
          // to be able to support a top side border on it.
          backgroundColor: Colors.transparent,
          elevation: elevation,
          currentIndex: selectedIndex,
          onTap: onDestinationSelected,
          items: <BottomNavigationBarItem>[
            for (final FlexDestination item in destinations)
              BottomNavigationBarItem(
                icon: item.icon,
                activeIcon: item.selectedIcon,
                label: item.label,
                tooltip: useTooltips &&
                        item.tooltip != item.label &&
                        item.tooltip != null
                    ? item.tooltip
                    : '',
                backgroundColor: Colors.transparent,
              ),
          ],
        ),
      ),
    );
  }
}

/// The Material style bottom navigation bar used by FlexScaffold.
///
/// The style of it is controlled by the FlexScaffoldTheme, its styling
/// properties goes a bit beyond the the standard. It has opacity and blur
/// properties as well as top border property. The Material bottom navigation
/// bar can thus style wise be made to imitate a CupertinoBottomBar.
class Material3BottomBar extends StatelessWidget {
  /// Default constructor.
  const Material3BottomBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  })  : assert(destinations.length >= 2, 'Length must be 2 or higher'),
        assert(0 <= selectedIndex && selectedIndex < destinations.length,
            'Selected index must be: [0 ... length[ ');

  /// Defines the appearance of the button items that are arrayed within the
  /// drawer, rail, menu and bottom bar.
  ///
  /// The value must be a list of two or more [FlexDestination]
  /// values.
  final List<FlexDestination> destinations;

  /// The index into [destinations] for the current selected
  /// [FlexDestination].
  final int selectedIndex;

  /// Called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the FlexScaffold navigation needs to keep
  /// track of the index of the selected [FlexDestination] and call
  /// `setState` to rebuild the menu, drawer, rail or bottom bar
  /// with the new [selectedIndex].
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final FlexScaffoldTheme flexTheme =
        theme.extension<FlexScaffoldTheme>()?.withDefaults(context) ??
            const FlexScaffoldTheme().withDefaults(context);

    // final bool useFlexTheme = flexTheme.navigationBarPreferSubTheme ?? false;

    // Get and compute effective background color
    final double opacity =
        flexTheme.bottomIsTransparent! ? flexTheme.bottomOpacity! : 1.0;
    final Color effectiveBackgroundColor = (flexTheme.bottomBackgroundColor ??
            theme.navigationBarTheme.backgroundColor ??
            flexTheme.menuBackgroundColor ??
            scheme.background)
        .withOpacity(opacity);

    // Check if the result of effectiveBackgroundColor is opaque
    final bool isOpaque = effectiveBackgroundColor.alpha == 0xFF;
    // Check if FlexScaffold tooltips should be shown.
    final bool useTooltips = flexTheme.useTooltips ?? false;

    // Effective elevation for the NavigationBar.
    // May be null and fall via theme for bottom nav bar and then SDK defaults
    // which is 3 for the NavigationBar in M3 and 0 in M2.
    final double? elevation = flexTheme.bottomElevation;

    return IfWrapper(
      // If the bottom bar is NOT fully opaque and bottom blur is enabled, then
      // wrap the Decoration with blur backdrop filter, otherwise we leave out
      // the blur filter, as it is costly to render when not needed and if
      // there is no transparency its effect cannot be seen.
      condition: !isOpaque && flexTheme.bottomBlur!,
      builder: (BuildContext context, Widget child) {
        return ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: child,
          ),
        );
      },
      child: DecoratedBox(
        // This decoration adds the effective color and top side border
        // to the Material BottomNavigationBar
        decoration: BoxDecoration(
          border: flexTheme.bottomTopBorder!
              ? Border(top: BorderSide(color: flexTheme.borderColor!))
              : const Border(),
          color: effectiveBackgroundColor,
        ),
        child: NavigationBar(
          // The bottom is always fully transparent, the color
          // is added via the box decoration. This was needed in order
          // to be able to support a top side border on it.
          backgroundColor: Colors.transparent,
          elevation: elevation,
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: <Widget>[
            for (final FlexDestination item in destinations)
              NavigationDestination(
                label: item.label,
                icon: item.icon,
                selectedIcon: item.selectedIcon,
                tooltip: useTooltips &&
                        item.tooltip != item.label &&
                        item.tooltip != null
                    ? item.tooltip
                    : '',
              )
          ],
        ),
      ),
    );
  }
}

/// The Cupertino style bottom navigation bar used by FlexScaffold.
///
/// The style of it is controlled by the FlexScaffoldTheme, styling of a
/// CupertinoTabBar is limited as it should look and work in very specific way.
/// It can be made transparent and when it is it always uses blur filter, the
/// usage of the top side border can also be controlled via the
/// [FlexScaffoldTheme].
class CupertinoBottomBar extends StatelessWidget {
  /// Default constructor.
  const CupertinoBottomBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  })  : assert(destinations.length >= 2,
            'There should be at least 2 destinations'),
        assert(
            0 <= selectedIndex && selectedIndex < destinations.length,
            'Selected index must equal or greater than 0, but less than '
            'the lengths of destinations.');

  /// Defines the appearance of the button items that are arrayed within the
  /// drawer, rail, menu and bottom bar.
  ///
  /// The value must be a list of two or more [FlexDestination]
  /// values.
  final List<FlexDestination> destinations;

  /// The index into [destinations] for the current selected
  /// [FlexDestination].
  final int selectedIndex;

  /// Called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the FlexScaffold navigation needs to keep
  /// track of the index of the selected [FlexDestination] and call
  /// `setState` to rebuild the menu, drawer, rail or bottom bar
  /// with the new [selectedIndex].
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final FlexScaffoldTheme flexTheme =
        theme.extension<FlexScaffoldTheme>()?.withDefaults(context) ??
            const FlexScaffoldTheme().withDefaults(context);

    // Get and compute effective background color
    final double opacity =
        flexTheme.bottomIsTransparent! ? flexTheme.bottomOpacity! : 1.0;
    final Color effectiveBackgroundColor = (flexTheme.bottomBackgroundColor ??
            flexTheme.menuBackgroundColor ??
            scheme.background)
        .withOpacity(opacity);

    // The FlexScaffold CupertinoTabBar does not support all theming or style
    // options in FlexScaffoldTheme. It is a cupertino tab bar but it will
    // will respond to any normal Cupertino theme applied to it and the
    // BottomNavigationBarItem will also follow standard themes.
    return CupertinoTabBar(
      items: <BottomNavigationBarItem>[
        for (final FlexDestination item in destinations)
          BottomNavigationBarItem(
            icon: item.icon,
            activeIcon: item.selectedIcon,
            label: item.label,
          ),
      ],
      currentIndex: selectedIndex,
      border: flexTheme.bottomTopBorder!
          ? Border(top: BorderSide(color: flexTheme.borderColor!))
          : const Border(),
      backgroundColor: effectiveBackgroundColor,
      onTap: onDestinationSelected,
    );
  }
}
