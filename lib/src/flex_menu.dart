import 'dart:math';

import 'package:flutter/material.dart';

import 'flex_app_bar.dart';
import 'flex_destination.dart';
import 'flex_menu_button.dart';
import 'flex_scaffold.dart';
import 'flex_scaffold_constants.dart';
import 'flex_scaffold_helpers.dart';
import 'flexfold_theme.dart';

/// Flexfold internal widget that manages the animated showing and hiding of
/// the menu and rail, plus building and managing its menu content.
class FlexMenu extends StatefulWidget {
  /// Default constructor
  const FlexMenu({
    super.key,
    // Destination properties for the menu, rail and bottom navbar
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    //
    this.menuToggleEnabled = true,
    //
    // Menu content properties
    this.menuIcon,
    this.menuIconExpand,
    this.menuIconExpandHidden,
    this.menuIconCollapse,
    this.menuAppBar,
    this.menuLeading,
    this.menuTrailing,
    this.menuFooter,
    //
    // Menu state properties and callbacks
    this.hideMenu = false,
    required this.onHideMenu,
    this.cycleViaDrawer = true,
    this.preferRail = false,
    required this.onPreferRail,
    //
    this.showBottomDestinationsInDrawer = true,
    //
  }) : assert(
            destinations.length >= 2, 'There must be at least 2 destinations.');

  /// Defines the appearance of the button items that are arrayed within the
  /// drawer, rail, menu and bottom bar.
  ///
  /// The value must be a list of two or more [FlexDestination] values.
  final List<FlexDestination> destinations;

  /// The index into [destinations] for the current selected
  /// [FlexDestination].
  final int selectedIndex;

  /// Called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the navigation rail needs to keep
  /// track of the index of the selected [FlexDestination] and call
  /// `setState` to rebuild the menu, drawer, rail or bottom bar
  /// with the new [selectedIndex].
  final ValueChanged<int> onDestinationSelected;

  /// The menu mode can be manually toggled by the user when true.
  ///
  /// If set to false, then the menu can only be opened when it is a drawer,
  /// it cannot be toggled between rail/menu and drawer manually when the
  /// breakpoint constraints would otherwise allow that. This means the user
  /// cannot hide the side menu or the rail, when rail or side navigation mode
  /// is triggered. You can still control it via the API, there just is no
  /// user control over.
  ///
  /// Defaults to true so users can toggle the menu and rail visibility as they
  /// prefer on a large canvas.
  final bool menuToggleEnabled;

  /// A Widget used to open the menu, typically an [Icon] widget is used.
  ///
  /// The same icon will also be used on the AppBar when the menu or rail is
  /// hidden in a drawer. If no icon is provided it defaults to a widget with
  /// value [kFlexfoldMenuIcon].
  final Widget? menuIcon;

  /// A widget used to expand the drawer to a menu from an opened drawer,
  /// typically an [Icon] widget is used.
  ///
  /// If no icon is provided it defaults to a widget with value
  /// [kFlexfoldMenuIconExpand].
  final Widget? menuIconExpand;

  /// A widget used to expand the drawer to a menu when the rail/menu is
  /// hidden but may be expanded based on screen width and breakpoints.
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided it defaults to a widget with value
  /// [kFlexfoldMenuIconExpandHidden].
  final Widget? menuIconExpandHidden;

  /// A widget used to expand the drawer to a menu, typically an [Icon]
  /// widget is used.
  ///
  /// If no icon is provided it defaults to a widget with value
  /// [kFlexfoldMenuIconCollapse].
  final Widget? menuIconCollapse;

  /// Appbar for the menu, which is in the drawer, rail and side menu.
  ///
  /// The menu has an appbar on top of it too. It always gets an automatic
  /// leading button to control its appearance and hiding it. You can even
  /// create actions for it, but beware that there is not a lot of space and it
  /// would not be available in rail mode. There is also not so much
  /// space in the title, but you can fit a small brand/logo there.
  final FlexAppBar? menuAppBar;

  /// A widget that appears below the menubar but above the menu items.
  ///
  /// It is placed at the top of the menu, but after the menu bar, above the
  /// [destinations].
  /// This could be an action button like a [FloatingActionButton], but may
  /// also be a non-button, such as a user profile image button, company logo,
  /// etc. It needs to fit and look good both in rail and side menu mode. Use a
  /// layout builder to make an adaptive leading widget that fits both sizes
  /// if so required.
  ///
  /// The default value is null.
  final Widget? menuLeading;

  /// Trailing menu widget is placed below the last [FlexDestination].
  ///
  /// It needs to fit and look good both in rail and side menu mode. Use a
  /// layout builder to make an adaptive trailing widget that fits both sizes.
  /// The trailing widget in the menu that is placed below the destinations.
  ///
  /// The default value is null.
  final Widget? menuTrailing;

  /// A widget that appears at the bottom of the menu. This widget is glued
  /// to the bottom and does not scroll, like the menubar.
  ///
  /// The menu footer needs to fit and look good both in rail and side menu
  /// mode. Use a layout builder to make an adaptive trailing widget that
  /// fits both sizes.
  final Widget? menuFooter;

  /// Keep main menu hidden in a drawer, even when its breakpoints are exceeded.
  final bool hideMenu;

  /// Callback that is called when hide menu changes.
  final ValueChanged<bool> onHideMenu;

  /// Cycle via drawer menu when opening a hidden menu.
  ///
  /// When the menu may be shown as locked on screen, as a rail or menu, and
  /// we expand it again, it first cycles via the drawer menu option if true.
  /// If set to false it skips the cycle via the drawer and expands it directly
  /// to a rail or side menu, depending on current screen width and if it is
  /// larger than the breakpoint for menu or not. If screen width is below rail
  /// breakpoint this setting has no effect, the only way to show the menu is
  /// as a drawer, so the drawer will be opened.
  final bool cycleViaDrawer;

  /// Prefer a rail menu when it is shown even if menu breakpoint is exceeded.
  final bool preferRail;

  /// Callback that is called when prefer rail changes.
  final ValueChanged<bool> onPreferRail;

  /// Set to true by [FlexScaffold] constructing the menu, when the bottom
  /// navigation bar destinations should also be included in the drawer.
  ///
  /// Becomes true when the [FlexScaffold.bottomDestinationsInDrawer] property
  /// is true AND current destination selection is not a bottom destination.
  final bool showBottomDestinationsInDrawer;

  @override
  State<FlexMenu> createState() => _FlexMenuState();
}

class _FlexMenuState extends State<FlexMenu> {
  // Local state
  late int selectedIndex;
  late double width;
  late bool hideMenu;
  late bool preferRail;

  @override
  void initState() {
    super.initState();
    // Initialize local state controls
    selectedIndex = widget.selectedIndex;
    width = 0.0;
    hideMenu = widget.hideMenu;
    preferRail = widget.preferRail;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(FlexMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
    if (oldWidget.hideMenu != widget.hideMenu) {
      hideMenu = widget.hideMenu;
    }
    if (oldWidget.preferRail != widget.preferRail) {
      preferRail = widget.preferRail;
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    // Get all the effective FlexfoldThemeData
    final FlexScaffoldThemeData flexTheme = FlexScaffoldTheme.of(context);

    // Get all the theme based behavior properties
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool isDrawerOpen = scaffold?.isDrawerOpen ?? false;

    assert(debugCheckHasMediaQuery(context), 'A build context is required.');
    final MediaQueryData mediaData = MediaQuery.of(context);
    final double topPadding = mediaData.padding.top;
    final double leftPadding = mediaData.padding.left;
    final double rightPadding = mediaData.padding.right;
    final double startPadding = Directionality.of(context) == TextDirection.ltr
        ? leftPadding
        : rightPadding;

    final double screenWidth = mediaData.size.width;
    final double screenHeight = mediaData.size.height;
    final double breakpointRail = flexTheme.breakpointRail!;
    final double breakpointMenu = flexTheme.breakpointMenu!;
    final double breakpointDrawer = flexTheme.breakpointDrawer!;

    final double railWidth = flexTheme.railWidth!;
    final double menuWidth = flexTheme.menuWidth!;

    // Based on height and breakpoint, we are making a phone landscape layout.
    final bool isPhoneLandscape = screenHeight < breakpointDrawer;
    // True if the menu should be used as a drawer.
    final bool stayInDrawer =
        hideMenu || (screenWidth < breakpointRail) || isPhoneLandscape;
    // True if the menu is currently shown as a Drawer
    final bool isDrawer = stayInDrawer && hasDrawer && isDrawerOpen;

    // Build and return the menu items as they are if they are in the Drawer.
    if (isDrawer) {
      return _buildMenuItems(
        context,
        isDrawerOpen,
        isDrawer,
        startPadding,
        topPadding,
      );
      // Else set the width of to use for the Animated Container
    } else {
      if (stayInDrawer) {
        width = 0.0;
      } else if (screenWidth < breakpointMenu || widget.preferRail) {
        width = railWidth + startPadding;
      } else {
        width = menuWidth + startPadding;
      }
      // Then build and return the menu items in the animated container width
      // the calculated width.
      return AnimatedContainer(
        // TODO(rydmike): Color flashes when changing themeMode. Figure out why!
        // color: flexTheme.menuBackgroundColor, // Colors.transparent,
        duration: flexTheme.menuAnimationDuration!,
        curve: flexTheme.menuAnimationCurve!,
        width: width,
        child: _buildMenuItems(
          context,
          isDrawerOpen,
          isDrawer,
          startPadding,
          topPadding,
        ),
      );
    }
  }

  Widget _buildMenuItems(
    BuildContext context,
    bool isDrawerOpen,
    bool isDrawer,
    double startPadding,
    double topPadding,
  ) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        final ThemeData theme = Theme.of(context);
        final Color scaffoldColor = theme.scaffoldBackgroundColor;

        // Get FlexfoldThemeData
        final FlexScaffoldThemeData flexTheme = FlexScaffoldTheme.of(context);
        // Get effective icon and text themes
        final IconThemeData unselectedIconTheme =
            flexTheme.unselectedIconTheme!;
        final IconThemeData selectedIconTheme = flexTheme.selectedIconTheme!;
        final TextStyle unselectedLabelTextStyle =
            flexTheme.unselectedLabelTextStyle!;
        final TextStyle selectedLabelTextStyle =
            flexTheme.selectedLabelTextStyle!;
        final TextStyle headingTextStyle = flexTheme.headingTextStyle!;

        // Determine if we should draw an edge border on the menu
        final bool borderOnMenu = flexTheme.borderOnMenu!;
        final bool borderOnDrawerEdgeInDarkMode = flexTheme.borderOnDarkDrawer!;
        final bool borderOnDrawerEdgeInLightMode =
            flexTheme.borderOnLightDrawer!;
        // Draw a border on drawer edge?
        final bool useDrawerBorderEdge = (theme.brightness == Brightness.dark &&
                borderOnDrawerEdgeInDarkMode) ||
            (theme.brightness == Brightness.light &&
                borderOnDrawerEdgeInLightMode);
        final Color borderColor = flexTheme.borderColor!;

        // Get effective menu and rail width
        final double railWidth = flexTheme.railWidth! + startPadding;
        final double menuWidth = flexTheme.menuWidth! + startPadding;

        // A filler widget for rail mode used to add empty space equal to the
        // rail width when we have disabled menu toggle control.
        final Widget? railLeadingFiller =
            size.maxWidth == railWidth ? SizedBox(width: railWidth) : null;

        // Is menu list direction reversed and starting from the bottom?
        final bool reversed = flexTheme.menuStart == FlexfoldMenuStart.bottom;
        //
        return OverflowBox(
          alignment: AlignmentDirectional.topStart,
          minWidth: 0,
          maxWidth: isDrawerOpen ? null : menuWidth,
          // Container used to draw an edge on the drawer in dark or light
          // mode, when so configured.
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: isDrawerOpen && useDrawerBorderEdge
                  ? BorderDirectional(end: BorderSide(color: borderColor))
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //
                // The Menu bar with menu action button and logo
                Stack(
                  children: <Widget>[
                    // We put the appbar in Stack so we can put the scaffold
                    // background color on a Container behind the AppBar so we
                    // get transparency against the scaffold background color
                    // and not the canvas color.
                    Container(
                      height: kToolbarHeight + topPadding,
                      color: scaffoldColor,
                    ),
                    widget.menuAppBar!.toAppBar(
                      automaticallyImplyLeading: false,
                      leading: widget.menuToggleEnabled
                          ? FlexMenuButton(
                              onPressed: () {},
                              menuIcon: widget.menuIcon,
                              menuIconExpand: widget.menuIconExpand,
                              menuIconExpandHidden: widget.menuIconExpandHidden,
                              menuIconCollapse: widget.menuIconCollapse,
                            )
                          : railLeadingFiller,
                      // Insert any existing actions
                      actions: (widget.menuAppBar?.actions != null)
                          ? <Widget>[
                              // TODO(rydmike): Is this always safe?
                              ...widget.menuAppBar!.actions!,
                            ]
                          : <Widget>[const SizedBox.shrink()],
                    ),
                  ],
                ),
                //
                // Build the Menu content with:
                //  - Leading widget
                //  - Menu items with: Divider, Header, Item, Divider
                //  - Trailing widget
                //  - Footer widget
                //
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    border: borderOnMenu && !isDrawerOpen
                        ? BorderDirectional(end: BorderSide(color: borderColor))
                        : null,
                  ),
                  width: size.maxWidth,
                  child: ClipRect(
                      child: OverflowBox(
                    alignment: AlignmentDirectional.topStart,
                    minWidth: 0,
                    maxWidth: menuWidth,
                    child: ScrollConfiguration(
                        // The menu can scroll, but all bounce and glow scroll
                        // effects are removed.
                        behavior: ScrollNoEdgeEffect(),
                        child: _FooterLayout(
                          body: ListView(
                            reverse: reversed,
                            padding: EdgeInsets.zero,
                            children: <Widget>[
                              //
                              // Add the leading widget to the menu
                              widget.menuLeading ?? const SizedBox.shrink(),
                              //
                              // The menu items
                              for (int i = 0;
                                  i < widget.destinations.length;
                                  i++)
                                if ((widget.destinations[i]
                                            .inBottomNavigation &&
                                        widget
                                            .showBottomDestinationsInDrawer) ||
                                    !widget
                                        .destinations[i].inBottomNavigation ||
                                    !isDrawer)
                                  _FlexMenuItem(
                                    destination: widget.destinations[i],
                                    iconTheme: unselectedIconTheme,
                                    selectedIconTheme: selectedIconTheme,
                                    labelTextStyle: unselectedLabelTextStyle,
                                    selectedLabelTextStyle:
                                        selectedLabelTextStyle,
                                    headingTextStyle: headingTextStyle,
                                    isSelected: widget.selectedIndex == i,
                                    width: size.maxWidth,
                                    startPadding: startPadding,
                                    autoFocus: widget.selectedIndex == i,
                                    onTap: () {
                                      setState(() {
                                        if (isDrawerOpen) {
                                          Navigator.of(context).pop();
                                        }
                                        selectedIndex = i;
                                        widget.onDestinationSelected(
                                            selectedIndex);
                                      });
                                    },
                                  ),
                              //
                              // Add the trailing widget to the menu
                              widget.menuTrailing ?? const SizedBox.shrink(),
                            ],
                          ),
                          //
                          // This widget will appear as a fixed footer always
                          // at the bottom of the menu, like the menu's appbar
                          // it does not scroll.
                          footer: widget.menuFooter ?? const SizedBox.shrink(),
                        )),
                  )),
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FlexMenuItem extends StatelessWidget {
  const _FlexMenuItem({
    required this.destination,
    this.isSelected = false,
    required this.iconTheme,
    this.selectedIconTheme,
    required this.labelTextStyle,
    this.selectedLabelTextStyle,
    required this.headingTextStyle,
    required this.onTap,
    required this.width,
    required this.startPadding,
    this.autoFocus = false,
  });
  final FlexDestination destination;
  final bool isSelected;
  final IconThemeData iconTheme;
  final IconThemeData? selectedIconTheme;
  final TextStyle labelTextStyle;
  final TextStyle? selectedLabelTextStyle;
  final TextStyle headingTextStyle;
  final VoidCallback onTap;
  final double width;
  final double startPadding;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    final FlexScaffoldThemeData theme = FlexScaffoldTheme.of(context);

    // Get effective menu and rail width
    final double railWidth = theme.railWidth!;
    final double menuWidth = theme.menuWidth! + startPadding;

    final bool showToolTip =
        ((width < railWidth + 5) || destination.tooltip != null) &&
            theme.useTooltips!;

    final Widget themedIcon = IconTheme(
      data: isSelected ? selectedIconTheme ?? iconTheme : iconTheme,
      child: isSelected ? destination.selectedIcon : destination.icon,
    );

    final Widget styledLabel = DefaultTextStyle(
      style: isSelected
          ? selectedLabelTextStyle ?? labelTextStyle
          : labelTextStyle,
      child: Text(destination.label),
    );

    final Widget styledHeading = DefaultTextStyle(
      style: headingTextStyle,
      child: destination.heading ?? const Text(''),
    );

    // Get the border color for borders
    final Color borderColor = theme.borderColor!;

    // Is menu list direction reversed and starting from the bottom?
    final bool reversed = theme.menuStart == FlexfoldMenuStart.bottom;

    // Make the divider widget
    // TODO(rydmike): Future enhancement, Widget for the divider.
    final Widget menuDivider = Divider(
      thickness: 1,
      height: 1,
      color: borderColor,
    );

    // Wrap the heading widget in correct padding
    final Widget heading = SizedBox(
      height: 34,
      child: width > railWidth + 5 + startPadding
          ? Padding(
              padding: EdgeInsetsDirectional.only(
                start: railWidth / 2 - 10 + startPadding,
                top: 10,
              ),
              child: styledHeading,
            )
          : null,
    );

    if (width <
        theme.menuHighlightMargins!.start + theme.menuHighlightMargins!.end) {
      return const SizedBox.shrink();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // The destination has dividers, so we add them, adjusting for
          // reversed order of the menu.
          if (destination.dividerBefore && !reversed) menuDivider,
          if (destination.dividerAfter && reversed) menuDivider,
          // The destination has a header before it, so we add it
          if (destination.heading != null && !reversed) heading,
          // Add the item details.
          Padding(
            padding: theme.menuHighlightMargins!,
            child: Material(
              clipBehavior: Clip.antiAlias,
              shape: isSelected
                  ? theme.menuSelectedShape
                  : theme.menuHighlightShape,
              // If the item is selected we will draw it with grey background
              // but using different style for dark and light theme.
              color: isSelected
                  // This selection highlight is the same alpha blend as the
                  // one used as default in ChipThemeData for a selected chip.
                  ? theme.menuHighlightColor
                  : Colors.transparent,
              child: MaybeTooltip(
                condition: showToolTip,
                tooltip: destination.tooltip ?? destination.label,
                child: InkWell(
                  autofocus: autoFocus,
                  onTap: onTap,
                  child: SizedBox(
                    height: theme.menuHighlightHeight,
                    width: width -
                        theme.menuHighlightMargins!.start -
                        theme.menuHighlightMargins!.end,
                    child: OverflowBox(
                      alignment: AlignmentDirectional.topStart,
                      minWidth: 0,
                      maxWidth: menuWidth,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: startPadding),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                              width: railWidth -
                                  theme.menuHighlightMargins!.start * 2,
                            ),
                            child: themedIcon,
                          ),
                          SizedBox(width: theme.menuHighlightMargins!.start),
                          if (width < railWidth + 10)
                            const SizedBox.shrink()
                          else
                            styledLabel
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // The destination has a header before it, in direction is reversed.
          if (destination.heading != null && reversed) heading,
          // The destination has dividers, so we add them, adjusting for
          // reversed order of the menu.
          if (destination.dividerBefore && reversed) menuDivider,
          if (destination.dividerAfter && !reversed) menuDivider,
        ],
      );
    }
  }
}

/// A footer layout class
///
/// This widget is courtesy of Rémi Rousselet found on Stack Overflow
/// https://stackoverflow.com/questions/54027270/how-to-create-a-scroll-view-with-fixed-footer-with-flutter?noredirect=1&lq=1
/// Modified it to use Widgets instead of Containers that was used in the
/// example, which was a bit limiting for no reason at all as far as I could
/// see. Keeping it local to this file as it is not used or needed anywhere
/// else,  but it is good generally useful widget too.
class _FooterLayout extends StatelessWidget {
  const _FooterLayout({
    required this.body,
    required this.footer,
  });

  final Widget body;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _FooterLayoutDelegate(MediaQuery.of(context).viewInsets),
      children: <Widget>[
        LayoutId(
          id: _FooterPart.body,
          child: body,
        ),
        LayoutId(
          id: _FooterPart.footer,
          child: footer,
        ),
      ],
    );
  }
}

enum _FooterPart { footer, body }

class _FooterLayoutDelegate extends MultiChildLayoutDelegate {
  _FooterLayoutDelegate(this.viewInsets);

  final EdgeInsets viewInsets;

  @override
  void performLayout(Size size) {
    // ignore: parameter_assignments
    size = Size(size.width, size.height + viewInsets.bottom);
    final Size footer =
        layoutChild(_FooterPart.footer, BoxConstraints.loose(size));

    final BoxConstraints bodyConstraints = BoxConstraints.tightFor(
      height: size.height - max(footer.height, viewInsets.bottom),
      width: size.width,
    );
    final Size body = layoutChild(_FooterPart.body, bodyConstraints);
    positionChild(_FooterPart.body, Offset.zero);
    positionChild(_FooterPart.footer, Offset(0, body.height));
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
