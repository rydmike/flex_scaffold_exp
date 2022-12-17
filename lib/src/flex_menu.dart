import 'dart:math';

import 'package:flutter/material.dart';

import 'flex_app_bar.dart';
import 'flex_destination.dart';
import 'flex_menu_button.dart';
import 'flex_scaffold.dart';
import 'flex_scaffold_constants.dart';
import 'flex_scaffold_helpers.dart';
import 'flex_theme_extension.dart';

// TODO(rydmike): Add built-in support for NavigationRail.
// TODO(rydmike): Consider having the icons a part of this widget?

/// The widget used by [FlexScaffold] to show the content used in the
/// rail, side menu and drawer.
///
/// It can have an AppBar, leading, trailer and footer widget.
///
/// By default it builds its own menu items from [FlexScaffold.destinations],
/// but it is possible to provide a custom menu as well. You might not need to
/// as the [FlexMenu] default menu is pretty configurable.
///
/// If you make a custom rail/menu or use a package for one you can use the
/// Flutter [NavigationRail] example as a guide for how to implement it.
class FlexMenu extends StatefulWidget {
  /// Default constructor
  const FlexMenu({
    super.key,
    this.appBar,
    this.header,
    this.leading,
    this.trailing,
    this.footer,
    //
    this.menuIcon,
    this.menuIconExpand,
    this.menuIconCollapse,
    this.menuIconExpandHidden,
  });

  /// An [AppBar] for the menu when used on the drawer, rail and side menu.
  ///
  /// The menu has an AppBar on top of it too. It always gets an automatic
  /// leading button to show and collapse it. You can also create actions for
  /// the menu app bar, but beware that there is not a lot of space and
  /// actions are not reachable in rail mode. There is also not so much
  /// space in the title, but you can fit a small brand/logo/app text on it.
  final FlexAppBar? appBar;

  // TODO(rydmike): Fix header document comment.
  /// A widget that appears below the menu AppBar but above the menu items.
  ///
  /// It is placed at the top of the menu, but after the menu bar, above the
  /// destinations. This could be an action button like a
  /// [FloatingActionButton], but may also other widgets like a user profile
  /// image button, company logo, etc. It needs to fit and look good both in
  /// rail and side menu mode. Use a layout builder to make an adaptive
  /// leading widget that fits both sizes if so required.
  ///
  /// The default value is null.
  final Widget? header;

  // TODO(rydmike): Fix leading document comment.
  /// A widget that appears below the menu AppBar but above the menu items.
  ///
  /// It is placed at the top of the menu, but after the menu bar, above the
  /// destinations. This could be an action button like a
  /// [FloatingActionButton], but may also other widgets like a user profile
  /// image button, company logo, etc. It needs to fit and look good both in
  /// rail and side menu mode. Use a layout builder to make an adaptive
  /// leading widget that fits both sizes if so required.
  ///
  /// The default value is null.
  final Widget? leading;

  /// Trailing menu widget is placed below the last [FlexDestination].
  ///
  /// It needs to fit and look good both in rail and side menu mode. Use a
  /// layout builder to make an adaptive trailing widget that fits both sizes.
  /// The trailing widget in the menu that is placed below the destinations.
  ///
  /// The default value is null.
  final Widget? trailing;

  /// A widget that appears at the bottom of the menu.
  ///
  /// This widget is glued to the bottom and does not scroll.
  ///
  /// The menu footer needs to fit and look good both in rail and side menu
  /// mode. Use a layout builder to make an adaptive footer widget that
  /// fits both sizes.
  final Widget? footer;

  /// A Widget used on the menu button when the menu is operated as a Drawer.
  ///
  /// Typically an [Icon] widget is used with the hamburger menu icon.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, it defaults to a widget
  /// with value [kFlexMenuIcon], the hamburger icon.
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? menuIcon;

  /// A widget used on an opened drawer menu button when operating it will
  /// change it to a side menu.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [menuIcon] was not
  /// defined, it defaults to a widget with value [kFlexMenuIconExpand].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? menuIconExpand;

  /// A widget used on the menu button when operating it will expand the
  /// menu to a rail or to a side menu.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [menuIcon] was not
  /// defined, it defaults to a widget with value
  /// [kFlexMenuIconExpandHidden].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? menuIconExpandHidden;

  /// A widget used on the menu button when it is shown as a menu or rail,
  /// and operating it will collapse it to its next state, from menu to rail to
  /// hidden.
  ///
  /// Typically an [Icon] widget is used.
  ///
  /// If no icon is provided and there was none given to same named property in
  /// a [FlexScaffold] higher up in the widget tree, and if [menuIcon] was not
  /// defined, it defaults to a widget with value [kFlexMenuIconCollapse].
  ///
  /// If you use icons with arrow directions, use icons with direction
  /// applicable for LTR. If the used locale direction is RTL, the icon
  /// will be rotated 180 degrees to work on reversed directionality.
  final Widget? menuIconCollapse;

  @override
  State<FlexMenu> createState() => _FlexMenuState();
}

class _FlexMenuState extends State<FlexMenu> {
  double width = 0;

  @override
  Widget build(BuildContext context) {
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool isDrawerOpen = scaffold?.isDrawerOpen ?? false;

    // TODO(rydmike): When MediaQuery as InheritedModel lands use it.
    //   reference: https://github.com/flutter/flutter/pull/114459
    final MediaQueryData mediaData = MediaQuery.of(context);
    final double topPadding = mediaData.padding.top;
    final double leftPadding = mediaData.padding.left;
    final double rightPadding = mediaData.padding.right;
    final double startPadding = Directionality.of(context) == TextDirection.ltr
        ? leftPadding
        : rightPadding;
    final double screenWidth = mediaData.size.width;
    final double screenHeight = mediaData.size.height;

    final ThemeData theme = Theme.of(context);
    // Get effective FlexTheme:
    //  1. If one exist in Theme, use it, fill undefined props with default.
    //  2. If no FlexTheme in Theme, fallback to one with all default values.
    final FlexTheme flexTheme =
        theme.extension<FlexTheme>()?.withDefaults(context) ??
            const FlexTheme().withDefaults(context);

    final double breakpointRail = flexTheme.breakpointRail!;
    final double breakpointMenu = flexTheme.breakpointMenu!;
    final double breakpointDrawer = flexTheme.breakpointDrawer!;
    final double railWidth = flexTheme.railWidth!;
    final double menuWidth = flexTheme.menuWidth!;

    /// Depend on aspects of the FlexScaffold and only rebuild if they change.
    final bool menuIsHidden = FlexScaffold.isMenuHiddenOf(context);
    final bool menuPrefersRail = FlexScaffold.menuPrefersRailOf(context);

    // Based on height and breakpoint, we are making a phone landscape layout.
    final bool isPhoneLandscape = screenHeight < breakpointDrawer;
    // True if the menu should be used as a drawer.
    final bool stayInDrawer =
        menuIsHidden || (screenWidth < breakpointRail) || isPhoneLandscape;
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
      } else if (screenWidth < breakpointMenu || menuPrefersRail) {
        width = railWidth + startPadding;
      } else {
        width = menuWidth + startPadding;
      }
      // Then build and return the menu items in the animated container width
      // the calculated width.
      return AnimatedContainer(
        // TODO(rydmike): Color flashes when changing themeMode. Figure out why!
        color: flexTheme.menuBackgroundColor,
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
    /// Depend on aspects of the FlexScaffold and only rebuild if they change.
    final bool canUseMenu = FlexScaffold.menuControlEnabledOf(context);
    final bool showBottomItemsInDrawer =
        FlexScaffold.showBottomDestinationsInDrawerOf(context);

    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool isDrawerOpen = scaffold?.isDrawerOpen ?? false;

    // Reads the FlexScaffold state once, will not update if dependants change.
    // Use it to access FlexScaffold state modifying methods. You may also use
    // it to read widgets used as FlexScaffold action button icons, as long
    // as you don't modify them dynamically in the app.
    final FlexScaffoldState flexScaffold = FlexScaffold.use(context);
    final List<FlexDestination> destinations = flexScaffold.widget.destinations;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        final ThemeData theme = Theme.of(context);
        final Color scaffoldColor = theme.scaffoldBackgroundColor;

        /// Depend on aspect of the FlexScaffold, only rebuild if it changes.
        final int selectedIndex = FlexScaffold.selectedIndexOf(context);

        final FlexTheme flexTheme =
            theme.extension<FlexTheme>()?.withDefaults(context) ??
                const FlexTheme().withDefaults(context);
        // Get effective icon and text themes
        final IconThemeData unselectedIconTheme = flexTheme.iconTheme!;
        final IconThemeData selectedIconTheme = flexTheme.selectedIconTheme!;
        final TextStyle unselectedLabelTextStyle = flexTheme.labelTextStyle!;
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
        final bool reversed = flexTheme.menuStart == FlexMenuStart.bottom;
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
                    // TODO(rydmike): Check if this is still needed.
                    // We put the appbar in Stack so we can put the Scaffold
                    // background color on a Container behind the AppBar so we
                    // get transparency against the scaffold background color
                    // and not the canvas color.
                    Container(
                      height: kToolbarHeight + topPadding,
                      color: scaffoldColor,
                    ),
                    widget.appBar!.toAppBar(
                      automaticallyImplyLeading: false,
                      leading: canUseMenu || isDrawerOpen
                          ? FlexMenuButton(onPressed: () {})
                          : railLeadingFiller,
                      // Insert any existing actions
                      actions: (widget.appBar?.actions != null)
                          ? <Widget>[...widget.appBar!.actions!]
                          : <Widget>[const SizedBox.shrink()],
                    ),
                  ],
                ),
                //
                // Build the Menu content with:
                //  - Heading widget
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
                        child: Column(
                          children: <Widget>[
                            if (widget.header != null) widget.header!,
                            Expanded(
                              child: _FooterLayout(
                                body: Align(
                                  alignment: Alignment.center,
                                  child: ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    children: <Widget>[
                                      //
                                      // Add the leading widget to the menu
                                      if (widget.leading != null)
                                        widget.leading!,
                                      //
                                      // The menu items
                                      for (int i = 0;
                                          i < destinations.length;
                                          i++)
                                        if ((destinations[i]
                                                    .inBottomNavigation &&
                                                showBottomItemsInDrawer) ||
                                            !destinations[i]
                                                .inBottomNavigation ||
                                            !isDrawer)
                                          _FlexMenuItem(
                                            destination: destinations[i],
                                            iconTheme: unselectedIconTheme,
                                            selectedIconTheme:
                                                selectedIconTheme,
                                            labelTextStyle:
                                                unselectedLabelTextStyle,
                                            selectedLabelTextStyle:
                                                selectedLabelTextStyle,
                                            headingTextStyle: headingTextStyle,
                                            isSelected: selectedIndex == i,
                                            width: size.maxWidth,
                                            startPadding: startPadding,
                                            autoFocus: selectedIndex == i,
                                            onTap: () {
                                              setState(() {
                                                if (isDrawerOpen) {
                                                  Navigator.of(context).pop();
                                                }
                                                flexScaffold
                                                    .setSelectedIndex(i);
                                              });
                                            },
                                          ),
                                      //
                                      // Add the trailing widget to the menu
                                      if (widget.leading != null)
                                        widget.trailing!,
                                    ],
                                  ),
                                ),
                                //
                                // This widget will appear as a fixed footer always
                                // at the bottom of the menu, like the menu's appbar
                                // it does not scroll.
                                footer: widget.footer,
                              ),
                            ),
                          ],
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
    final FlexTheme flexTheme =
        Theme.of(context).extension<FlexTheme>()?.withDefaults(context) ??
            const FlexTheme().withDefaults(context);

    // Get effective menu and rail width
    final double railWidth = flexTheme.railWidth!;
    final double menuWidth = flexTheme.menuWidth! + startPadding;

    final bool showToolTip =
        ((width < railWidth + 5) || destination.tooltip != null) &&
            flexTheme.useTooltips!;

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
    final Color borderColor = flexTheme.borderColor!;

    // Is menu list direction reversed and starting from the bottom?
    final bool reversed = flexTheme.menuStart == FlexMenuStart.bottom;

    // TODO(rydmike): Future enhancement, custom widget for the divider.
    // Make the divider widget
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
        flexTheme.menuIndicatorMargins!.start +
            flexTheme.menuIndicatorMargins!.end) {
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
            padding: flexTheme.menuIndicatorMargins!,
            child: Material(
              clipBehavior: Clip.antiAlias,
              shape: isSelected
                  ? flexTheme.menuSelectedShape
                  : flexTheme.menuShape,
              color: isSelected
                  ? flexTheme.menuSelectedColor
                  // The hover, focus, splash come from the InkWell below
                  : Colors.transparent,
              child: MaybeTooltip(
                condition: showToolTip,
                tooltip: destination.tooltip ?? destination.label,
                child: InkWell(
                  autofocus: autoFocus,
                  onTap: onTap,
                  focusColor: flexTheme.menuFocusColor,
                  hoverColor: flexTheme.menuHoverColor,
                  highlightColor: flexTheme.menuHighlightColor,
                  splashColor: flexTheme.menuSplashColor,
                  child: SizedBox(
                    height: flexTheme.menuIndicatorHeight,
                    width: width -
                        flexTheme.menuIndicatorMargins!.start -
                        flexTheme.menuIndicatorMargins!.end,
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
                                  flexTheme.menuIndicatorMargins!.start * 2,
                            ),
                            child: themedIcon,
                          ),
                          SizedBox(
                              width: flexTheme.menuIndicatorMargins!.start),
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
/// This private widget is courtesy of Rémi Rousselet found on Stack Overflow
/// https://stackoverflow.com/questions/54027270/how-to-create-a-scroll-view-with-fixed-footer-with-flutter?noredirect=1&lq=1
/// Modified it to use Widgets instead of Containers that was used in the
/// example. Keeping it local to this file as it is not used or needed anywhere
/// else, but it is good generally useful widget too.
class _FooterLayout extends StatelessWidget {
  const _FooterLayout({
    this.body,
    this.footer,
  });

  final Widget? body;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      // TODO(rydmike): When MediaQuery as InheritedModel lands use it.
      //   reference: https://github.com/flutter/flutter/pull/114459
      delegate: _FooterLayoutDelegate(MediaQuery.of(context).viewInsets),
      children: <Widget>[
        LayoutId(
          id: _FooterPart.body,
          child: body ?? const SizedBox.shrink(),
        ),
        LayoutId(
          id: _FooterPart.footer,
          child: footer ?? const SizedBox.shrink(),
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
