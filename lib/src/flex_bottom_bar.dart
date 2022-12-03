import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flex_scaffold_constants.dart';
import 'flexfold_destination.dart';
import 'flexfold_helpers.dart';
import 'flexfold_theme.dart';

/// Bottom navigation bar used by Flexfold in situations where it should use a
/// bottom navigation bar.
///
/// Currently the bottom navigation bar can be Material or Cupertino style, or
/// adaptive, which will use Cupertino on iOs and MacOS and Material on other
/// platforms.
@immutable
class FlexBottomBar extends StatelessWidget {
  /// Default constructor.
  const FlexBottomBar({
    super.key,
    this.bottomBarType = FlexfoldBottomBarType.adaptive,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  })  : assert(destinations.length >= 2,
            'There should be at least 2 destinations'),
        assert(
            0 <= selectedIndex && selectedIndex < destinations.length,
            'Selected index must equal or greater than 0, but less than '
            'the lengths of destinations.');

  /// The type of bottom navigation bar to use.
  ///
  /// Default to [FlexfoldBottomBarType.adaptive], which shows a
  /// [CupertinoTabBar] navigation bar on iOs and MacOS and a
  /// [BottomNavigationBar] on all other platforms.
  final FlexfoldBottomBarType bottomBarType;

  /// Defines the appearance of the button items that are arrayed within the
  /// drawer, rail, menu and bottom bar.
  ///
  /// The value must be a list of two or more [FlexfoldDestination] values.
  final List<FlexfoldDestination> destinations;

  /// The index into [destinations] for the current selected
  /// [FlexfoldDestination].
  final int selectedIndex;

  /// Called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the Flexfold navigation needs to keep
  /// track of the index of the selected [FlexfoldDestination] and call
  /// `setState` to rebuild the menu, drawer, rail or bottom bar
  /// with the new [selectedIndex].
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    if (bottomBarType == FlexfoldBottomBarType.cupertino) {
      return CupertinoBottomBar(
        destinations: destinations,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
      );
    }
    if (bottomBarType == FlexfoldBottomBarType.material3) {
      return MaterialYouBottomBar(
        destinations: destinations,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
      );
    } else {
      return MaterialBottomBar(
        destinations: destinations,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
      );
    }
  }
}

/// The Material style bottom navigation bar used by Flexfold.
///
/// The style of it is controlled by the FlexfoldTheme, its styling properties
/// goes a bit beyond the the standard because it has opacity and blur
/// properties as well as top border property. The Material bottom navigation
/// bar can thus style wise be made to imitate a CupertinoBottomBar.
class MaterialBottomBar extends StatefulWidget {
  /// Default constructor.
  const MaterialBottomBar({
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
  /// The value must be a list of two or more [FlexfoldDestination]
  /// values.
  final List<FlexfoldDestination> destinations;

  /// The index into [destinations] for the current selected
  /// [FlexfoldDestination].
  final int selectedIndex;

  /// Called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the Flexfold navigation needs to keep
  /// track of the index of the selected [FlexfoldDestination] and call
  /// `setState` to rebuild the menu, drawer, rail or bottom bar
  /// with the new [selectedIndex].
  final ValueChanged<int> onDestinationSelected;

  @override
  State<MaterialBottomBar> createState() => _MaterialBottomBarState();
}

class _MaterialBottomBarState extends State<MaterialBottomBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(MaterialBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the inherited FlexfoldTheme
    final FlexfoldThemeData flexTheme = FlexfoldTheme.of(context);
    // Get the active color scheme
    final ColorScheme scheme = Theme.of(context).colorScheme;

    // Get and compute effective background color
    final double opacity =
        flexTheme.bottomBarIsTransparent! ? flexTheme.bottomBarOpacity! : 1.0;
    final Color effectiveBackgroundColor = flexTheme
            .bottomNavigationBarTheme?.backgroundColor
            ?.withOpacity(opacity) ??
        scheme.background.withOpacity(opacity);

    // Check if the result of effectiveBackgroundColor is opaque
    final bool isOpaque = effectiveBackgroundColor.alpha == 0xFF;

    // TODO(rydmike): Review if these should be nullable or have fallback!

    // Get effective elevation for the bottom navigation bar
    final double? elevation = flexTheme.bottomNavigationBarTheme?.elevation;

    // Get effective bottom bar type for the bottom navigation bar
    final BottomNavigationBarType? type =
        flexTheme.bottomNavigationBarTheme?.type;

    // Get effective icons themes for the bottom navigation bar
    final IconThemeData? selectedIconTheme =
        flexTheme.bottomNavigationBarTheme?.selectedIconTheme;

    final IconThemeData? unselectedIconTheme =
        flexTheme.bottomNavigationBarTheme?.unselectedIconTheme;

    // Get effective item color for the bottom navigation bar
    final Color? selectedItemColor =
        flexTheme.bottomNavigationBarTheme?.selectedItemColor;

    // Get effective item color for the bottom navigation bar
    final Color? unselectedItemColor =
        flexTheme.bottomNavigationBarTheme?.unselectedItemColor;

    // Get effective text styles for the bottom navigation bar
    final TextStyle? selectedLabelStyle =
        flexTheme.bottomNavigationBarTheme?.selectedLabelStyle;

    final TextStyle? unselectedLabelStyle =
        flexTheme.bottomNavigationBarTheme?.unselectedLabelStyle;

    // Get effective values for showing the labels
    final bool? showSelectedLabels =
        flexTheme.bottomNavigationBarTheme?.showSelectedLabels;

    final bool? showUnselectedLabels =
        flexTheme.bottomNavigationBarTheme?.showUnselectedLabels;

    // Check if FlexScaffold tooltips should be shown.
    final bool useTooltips = flexTheme.useTooltips ?? true;

    return IfWrapper(
      // If the bottom bar is NOT fully opaque and bottom blur is enabled, then
      // wrap the Decoration with blur backdrop filter, otherwise we leave out
      // the blur filter, as it is a bit costly to render when not needed and
      // there is no transparency its effect cannot be seen.
      condition: !isOpaque && flexTheme.bottomBarBlur!,
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
          border: flexTheme.bottomBarTopBorder!
              ? Border(top: BorderSide(color: flexTheme.borderColor!))
              : const Border(),
          color: effectiveBackgroundColor,
        ),
        child: BottomNavigationBar(
          // The bottom navbar is always fully transparent, the color
          // is added via the box decoration. This was needed in order
          // to be able to support a top side border on it.
          backgroundColor: Colors.transparent,
          //
          items: <BottomNavigationBarItem>[
            for (FlexfoldDestination item in widget.destinations)
              BottomNavigationBarItem(
                icon: item.icon,
                activeIcon: item.selectedIcon,
                label: item.label,
                tooltip: useTooltips &&
                        item.tooltip != item.label &&
                        item.tooltip != null
                    ? item.tooltip
                    : '',
              ),
          ],
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
              widget.onDestinationSelected(_selectedIndex);
            });
          },
          currentIndex: widget.selectedIndex,

          elevation: elevation,
          type: type,

          selectedIconTheme: selectedIconTheme,
          unselectedIconTheme: unselectedIconTheme,

          selectedItemColor: selectedItemColor,
          unselectedItemColor: unselectedItemColor,

          selectedLabelStyle: selectedLabelStyle,
          unselectedLabelStyle: unselectedLabelStyle,

          showSelectedLabels: showSelectedLabels,
          showUnselectedLabels: showUnselectedLabels,
        ),
      ),
    );
  }
}

/// The Material style bottom navigation bar used by Flexfold.
///
/// The style of it is controlled by the FlexfoldTheme, its styling properties
/// goes a bit beyond the the standard because it has opacity and blur
/// properties as well as top border property. The Material bottom navigation
/// bar can thus style wise be made to imitate a CupertinoBottomBar.
class MaterialYouBottomBar extends StatefulWidget {
  /// Default constructor.
  const MaterialYouBottomBar({
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
  /// The value must be a list of two or more [FlexfoldDestination]
  /// values.
  final List<FlexfoldDestination> destinations;

  /// The index into [destinations] for the current selected
  /// [FlexfoldDestination].
  final int selectedIndex;

  /// Called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the Flexfold navigation needs to keep
  /// track of the index of the selected [FlexfoldDestination] and call
  /// `setState` to rebuild the menu, drawer, rail or bottom bar
  /// with the new [selectedIndex].
  final ValueChanged<int> onDestinationSelected;

  @override
  State<MaterialYouBottomBar> createState() => _MaterialYouBottomBarState();
}

class _MaterialYouBottomBarState extends State<MaterialYouBottomBar> {
  late int _selectedIndex;

  // /// Any widget in this list will have access to a
  // /// [NavigationBarDestinationInfo] inherited widget.
  // late final List<Widget> _destinations;
  //
  // void _buildDestinations() {
  //   // NavigationBar needed
  //   final ThemeData theme = Theme.of(context);
  //   final ColorScheme colorScheme = theme.colorScheme;
  //   final Animation<double> animation =
  //       NavigationBarDestinationInfo.of(context).selectedAnimation;
  //
  //   _destinations = <Widget>[
  //     for (FlexfoldDestination item in widget.destinations)
  //       NavigationBarDestinationBuilder(
  //         label: item.label,
  //         buildIcon: (BuildContext context) {
  //           final Widget selectedIconWidget = item.selectedIcon;
  //           final Widget unselectedIconWidget = item.icon;
  //
  //           return Stack(
  //             alignment: Alignment.center,
  //             children: <Widget>[
  //               NavigationBarIndicator(animation: animation),
  //               StatusTransitionWidgetBuilder(
  //                 animation: animation,
  //                 builder: (BuildContext context, Widget? child) {
  //                   return (animation.status == AnimationStatus.forward ||
  //                           animation.status == AnimationStatus.completed)
  //                       ? selectedIconWidget
  //                       : unselectedIconWidget;
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //         buildLabel: (BuildContext context) {
  //           return Padding(
  //             padding: const EdgeInsets.only(top: 4),
  //             child: ClampTextScaleFactor(
  //               // Don't scale labels of destinations, instead,
  //               // tooltip text will upscale.
  //               upperLimit: 1,
  //               child: Text(
  //                 item.label,
  //                 style: theme.textTheme.overline?.copyWith(
  //                   color: colorScheme.onSurface,
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       )
  //   ];
  // }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(MaterialYouBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _selectedIndex = widget.selectedIndex;
    }
  }

  @override
  void didChangeDependencies() {
    // TODO(rydmike): implement didChangeDependencies
    // _buildDestinations();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Get the inherited FlexfoldTheme
    final FlexfoldThemeData flexTheme = FlexfoldTheme.of(context);
    // Get the active color scheme
    final ColorScheme scheme = Theme.of(context).colorScheme;

    // Get and compute effective background color
    final double opacity =
        flexTheme.bottomBarIsTransparent! ? flexTheme.bottomBarOpacity! : 1.0;
    final Color effectiveBackgroundColor = flexTheme
            .bottomNavigationBarTheme?.backgroundColor
            ?.withOpacity(opacity) ??
        scheme.background.withOpacity(opacity);

    // Check if the result of effectiveBackgroundColor is opaque
    final bool isOpaque = effectiveBackgroundColor.alpha == 0xFF;

    // TODO(rydmike): Review if these should be nullable or have fallback!

    // Get effective elevation for the bottom navigation bar
    // final double elevation = flexTheme.bottomNavigationBarTheme?.elevation
    // ?? 0;

    // Check if FlexScaffold tooltips should be shown.
    final bool useTooltips = flexTheme.useTooltips ?? true;

    // // Get effective bottom bar type for the bottom navigation bar
    // final BottomNavigationBarType? type =
    //     flexTheme.bottomNavigationBarTheme?.type;
    //
    // // Get effective icons themes for the bottom navigation bar
    // final IconThemeData? selectedIconTheme =
    //     flexTheme.bottomNavigationBarTheme?.selectedIconTheme;
    //
    // final IconThemeData? unselectedIconTheme =
    //     flexTheme.bottomNavigationBarTheme?.unselectedIconTheme;
    //
    // Get effective item color for the bottom navigation bar
    final Color? selectedItemColor =
        flexTheme.bottomNavigationBarTheme?.selectedItemColor;

    // Get effective item color for the bottom navigation bar
    final Color? unselectedItemColor =
        flexTheme.bottomNavigationBarTheme?.unselectedItemColor;
    //
    // // Get effective text styles for the bottom navigation bar
    // final TextStyle? selectedLabelStyle =
    //     flexTheme.bottomNavigationBarTheme?.selectedLabelStyle;
    //
    // final TextStyle? unselectedLabelStyle =
    //     flexTheme.bottomNavigationBarTheme?.unselectedLabelStyle;
    //
    // // Get effective values for showing the labels
    // final bool? showSelectedLabels =
    //     flexTheme.bottomNavigationBarTheme?.showSelectedLabels;
    //
    // final bool? showUnselectedLabels =
    //     flexTheme.bottomNavigationBarTheme?.showUnselectedLabels;
    //
    // final bool useTooltips = flexTheme.useTooltips ?? true;

    // // NavigationBar needed
    // final ThemeData theme = Theme.of(context);
    // final ColorScheme colorScheme = theme.colorScheme;
    // final Animation<double> animation =
    //     NavigationBarDestinationInfo.of(context).selectedAnimation;

    return IfWrapper(
      // If the bottom bar is NOT fully opaque and bottom blur is enabled, then
      // wrap the Decoration with blur backdrop filter, otherwise we leave out
      // the blur filter, as it is a bit costly to render when not needed and
      // there is no transparency its effect cannot be seen.
      condition: !isOpaque && flexTheme.bottomBarBlur!,
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
          border: flexTheme.bottomBarTopBorder!
              ? Border(top: BorderSide(color: flexTheme.borderColor!))
              : const Border(),
          color: effectiveBackgroundColor,
        ),
        child: NavigationBar(
          // TODO(rydmike): Offer this via prop, and also for the rail menu!
          // type: type, // old one is in type!
          //labelBehavior: MrNavigationBarDestinationLabelBehavior.alwaysShow,
          // The bottom navbar is always fully transparent, the color
          // is added via the box decoration. This was needed in order
          // to be able to support a top side border on it.
          backgroundColor: Colors.transparent,
          // TODO(rydmike): Elevation does not exist in release
          // elevation: elevation,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
              widget.onDestinationSelected(_selectedIndex);
            });
          },
          selectedIndex: widget.selectedIndex,
          //
          destinations: <Widget>[
            for (FlexfoldDestination item in widget.destinations)
              NavigationDestination(
                label: item.label,
                icon: Theme(
                  data: Theme.of(context).copyWith(
                    iconTheme: IconThemeData(color: selectedItemColor),
                  ),
                  child: item.icon,
                ),
                selectedIcon: Theme(
                  data: Theme.of(context).copyWith(
                    iconTheme: IconThemeData(color: unselectedItemColor),
                  ),
                  child: item.selectedIcon,
                ),
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

/// The Cupertino style bottom navigation bar used by Flexfold.
///
/// The style of it is controlled by the FlexfoldTheme, styling of a
/// CupertinoTabBar is limited as it should look and work in very specific way.
/// It can be made transparent and when it is it always uses blur filter, the
/// usage of the top side border can also be controlled via the FlexfoldTheme.
class CupertinoBottomBar extends StatefulWidget {
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
  /// The value must be a list of two or more [FlexfoldDestination]
  /// values.
  final List<FlexfoldDestination> destinations;

  /// The index into [destinations] for the current selected
  /// [FlexfoldDestination].
  final int selectedIndex;

  /// Called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the Flexfold navigation needs to keep
  /// track of the index of the selected [FlexfoldDestination] and call
  /// `setState` to rebuild the menu, drawer, rail or bottom bar
  /// with the new [selectedIndex].
  final ValueChanged<int> onDestinationSelected;

  @override
  State<CupertinoBottomBar> createState() => _CupertinoBottomBarState();
}

class _CupertinoBottomBarState extends State<CupertinoBottomBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(CupertinoBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the inherited FlexfoldTheme
    final FlexfoldThemeData flexTheme = FlexfoldTheme.of(context);
    // Get the active color scheme
    final ColorScheme scheme = Theme.of(context).colorScheme;

    // Get and compute effective background color
    final double opacity =
        flexTheme.bottomBarIsTransparent! ? flexTheme.bottomBarOpacity! : 1.0;
    final Color effectiveBackgroundColor = flexTheme
            .bottomNavigationBarTheme?.backgroundColor
            ?.withOpacity(opacity) ??
        scheme.background.withOpacity(opacity);

    // The Flexfold CupertinoTabBar does not support all theming or style
    // options in FlexfoldTheme. It is a cupertino tab bar but it will
    // will respond to any normal Cupertino theme applied to it and the
    // BottomNavigationBarItem will also follow standard themes.
    return CupertinoTabBar(
      items: <BottomNavigationBarItem>[
        for (FlexfoldDestination item in widget.destinations)
          BottomNavigationBarItem(
            icon: item.icon,
            activeIcon: item.selectedIcon,
            label: item.label,
            // title: Text(item.label),
          ),
      ],
      currentIndex: widget.selectedIndex,
      border: flexTheme.bottomBarTopBorder!
          ? Border(top: BorderSide(color: flexTheme.borderColor!))
          : const Border(),
      backgroundColor: effectiveBackgroundColor,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
          widget.onDestinationSelected(_selectedIndex);
        });
      },
    );
  }
}
