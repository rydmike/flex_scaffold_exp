import 'dart:math';

import 'package:flutter/foundation.dart' show clampDouble;
import 'package:flutter/material.dart';

import 'flex_app_bar.dart';
import 'flex_destination.dart';
import 'flex_menu_button.dart';
import 'flex_scaffold.dart';
import 'flex_scaffold_constants.dart';
import 'flex_scaffold_helpers.dart';
import 'flex_scaffold_theme.dart';

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
    this.alignment = AlignmentDirectional.topStart,
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
  /// The header widget is placed at the top of the menu, directly after the
  /// menu AppBar. It is is always attached to it and does not scroll, and is
  /// is not affected by the menu content alignment.
  ///
  /// , above the
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

  /// Alignment if the menu leading, menu items and menu trailing widgets.
  ///
  /// Alignment is directional and affected by LTR/RTL of context. The
  /// menu/rail selection option take up full width ot rail and menu, there
  /// is typically no difference in layout result between the different
  /// variants of top, center and bottom. However, the difference between e.g.
  /// [AlignmentDirectional.topStart], [AlignmentDirectional.topCenter] and
  /// [AlignmentDirectional.topEnd] may affect your heading, leading, trailing
  /// and footer placement depending on what their actual contents are.
  final AlignmentDirectional alignment;

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
    final EdgeInsets padding = MediaQuery.paddingOf(context);
    final double leftPadding = padding.left;
    final double rightPadding = padding.right;
    final double startPadding = Directionality.of(context) == TextDirection.ltr
        ? leftPadding
        : rightPadding;
    final Size size = MediaQuery.sizeOf(context);
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    final ThemeData theme = Theme.of(context);
    // Get effective FlexTheme:
    //  1. If one exist in Theme, use it, fill undefined props with default.
    //  2. If no FlexTheme in Theme, fallback to one with all default values.
    final FlexScaffoldTheme flexTheme =
        theme.extension<FlexScaffoldTheme>()?.withDefaults(context) ??
            const FlexScaffoldTheme().withDefaults(context);
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

    final Widget menu = _FlexMenu(
        appBar: widget.appBar,
        header: widget.header,
        leading: widget.leading,
        trailing: widget.trailing,
        footer: widget.footer,
        alignment: widget.alignment);

    // Build and return the menu items as they are if they are in the Drawer.
    if (isDrawer) {
      return menu;
      // Else set the width of to use for the TweenAnimationBuilder
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
      return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: width),
          duration: flexTheme.menuAnimationDuration!,
          curve: flexTheme.menuAnimationCurve!,
          builder: (BuildContext context, double width, Widget? child) {
            return SizedBox(
              // With this clamp we can also use overshooting Curves.
              width: clampDouble(width, 0.0, menuWidth),
              child: menu,
            );
          });
    }
  }
}

class _FlexMenu extends StatelessWidget {
  const _FlexMenu({
    this.appBar,
    this.header,
    this.leading,
    this.trailing,
    this.footer,
    required this.alignment,
  });

  final FlexAppBar? appBar;
  final Widget? header;
  final Widget? leading;
  final Widget? trailing;
  final Widget? footer;
  final AlignmentDirectional alignment;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.paddingOf(context);
    final double topPadding = padding.top;
    final double leftPadding = padding.left;
    final double rightPadding = padding.right;
    final double startPadding = Directionality.of(context) == TextDirection.ltr
        ? leftPadding
        : rightPadding;

    /// Depend on aspects of the FlexScaffold and only rebuild if they change.
    final bool canUseMenu = FlexScaffold.menuControlEnabledOf(context);
    final bool showBottomItemsInDrawer =
        FlexScaffold.showBottomDestinationsInDrawerOf(context);
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool isDrawerOpen = scaffold?.isDrawerOpen ?? false;
    final Size size = MediaQuery.sizeOf(context);
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    final ThemeData theme = Theme.of(context);
    final Color scaffoldColor = theme.scaffoldBackgroundColor;
    // Get effective FlexTheme:
    //  1. If one exist in Theme, use it, fill undefined props with default.
    //  2. If no FlexTheme in Theme, fallback to one with all default values.
    final FlexScaffoldTheme flexTheme =
        theme.extension<FlexScaffoldTheme>()?.withDefaults(context) ??
            const FlexScaffoldTheme().withDefaults(context);

    final double breakpointRail = flexTheme.breakpointRail!;
    // final double breakpointMenu = flexTheme.breakpointMenu!;
    final double breakpointDrawer = flexTheme.breakpointDrawer!;
    // final double railWidth = flexTheme.railWidth!;
    // final double menuWidth = flexTheme.menuWidth!;

    /// Depend on aspects of the FlexScaffold and only rebuild if they change.
    final bool menuIsHidden = FlexScaffold.isMenuHiddenOf(context);
    // final bool menuPrefersRail = FlexScaffold.menuPrefersRailOf(context);

    // Based on height and breakpoint, we are making a phone landscape layout.
    final bool isPhoneLandscape = screenHeight < breakpointDrawer;
    // True if the menu should be used as a drawer.
    final bool stayInDrawer =
        menuIsHidden || (screenWidth < breakpointRail) || isPhoneLandscape;
    // True if the menu is currently shown as a Drawer
    final bool isDrawer = stayInDrawer && hasDrawer && isDrawerOpen;

    // Reads the FlexScaffold state once, will not update if dependants change.
    // Use it to access FlexScaffold state modifying methods. You may also use
    // it to read widgets used as FlexScaffold action button icons, as long
    // as you don't modify them dynamically in the app.
    final FlexScaffoldState flexScaffold = FlexScaffold.use(context);
    final List<FlexDestination> destinations = flexScaffold.widget.destinations;

    /// Depend on aspect of the FlexScaffold, only rebuild if it changes.
    final int selectedIndex = FlexScaffold.selectedIndexOf(context);

    // Get effective icon and text themes
    final IconThemeData unselectedIconTheme = flexTheme.iconTheme!;
    final IconThemeData selectedIconTheme = flexTheme.selectedIconTheme!;
    final TextStyle unselectedLabelTextStyle = flexTheme.labelTextStyle!;
    final TextStyle selectedLabelTextStyle = flexTheme.selectedLabelTextStyle!;
    final TextStyle headingTextStyle = flexTheme.headingTextStyle!;

    // Determine if we should draw an edge border on the menu
    final bool borderOnMenu = flexTheme.borderOnMenu!;
    final bool borderOnDrawerEdgeInDarkMode = flexTheme.borderOnDarkDrawer!;
    final bool borderOnDrawerEdgeInLightMode = flexTheme.borderOnLightDrawer!;
    // Draw a border on drawer edge?
    final bool useDrawerBorderEdge = (theme.brightness == Brightness.dark &&
            borderOnDrawerEdgeInDarkMode) ||
        (theme.brightness == Brightness.light && borderOnDrawerEdgeInLightMode);
    final Color borderColor = flexTheme.borderColor!;

    // Get effective menu and rail width
    final double railWidth = flexTheme.railWidth! + startPadding;
    final double menuWidth = flexTheme.menuWidth! + startPadding;
    // TODO(rydmike): Review if TraversalGroup is needed here.
    return FocusTraversalGroup(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints size) {
          final Widget? railLeadingFiller =
              size.maxWidth == railWidth ? SizedBox(width: railWidth) : null;
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
                  // The Menu AppBar with menu action button and logo
                  Stack(
                    children: <Widget>[
                      // We put the appbar in Stack so we can put the Scaffold
                      // background color on a Container behind the AppBar so we
                      // get transparency against the scaffold background color
                      // and not the canvas color.
                      Container(
                        height: kToolbarHeight + topPadding,
                        color: scaffoldColor,
                      ),
                      appBar!.toAppBar(
                        automaticallyImplyLeading: false,
                        leading: canUseMenu || isDrawerOpen
                            ? FlexMenuButton(onPressed: () {})
                            : railLeadingFiller,
                        // Insert any existing actions
                        actions: (appBar?.actions != null)
                            ? <Widget>[...appBar!.actions!]
                            : <Widget>[const SizedBox.shrink()],
                      ),
                    ],
                  ),
                  // Menu content with:
                  //  - Heading widget
                  //  - Leading widget
                  //  - Menu items with: Divider, Header, Item, Divider
                  //  - Trailing widget
                  //  - Footer widget
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      border: borderOnMenu && !isDrawerOpen
                          ? BorderDirectional(
                              end: BorderSide(color: borderColor))
                          : null,
                    ),
                    width: size.maxWidth,
                    child: ClipRect(
                        child: OverflowBox(
                      alignment: AlignmentDirectional.topStart,
                      minWidth: 0,
                      maxWidth: menuWidth,
                      child: Column(
                        children: <Widget>[
                          if (header != null) header!,
                          Expanded(
                            child: _FooterLayout(
                              body: Align(
                                alignment: alignment,
                                // TODO(rydmike): Review TraversalGroup need.
                                child: FocusTraversalGroup(
                                  child: ListView(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    children: <Widget>[
                                      // Add the leading widget to the menu
                                      if (leading != null) leading!,
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
                                              if (isDrawerOpen) {
                                                Navigator.of(context).pop();
                                              }
                                              flexScaffold.setSelectedIndex(i);
                                            },
                                            flexTheme: flexTheme,
                                          ),
                                      //
                                      // Add the trailing widget to the menu
                                      if (trailing != null) trailing!,
                                    ],
                                  ),
                                ),
                              ),
                              // Add footer widget to menu
                              footer: footer,
                            ),
                          ),
                        ],
                        // )
                      ),
                    )),
                  )),
                ],
              ),
            ),
          );
        },
      ),
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
    required this.flexTheme,
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
  final FlexScaffoldTheme flexTheme;

  @override
  Widget build(BuildContext context) {
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
          if (destination.dividerBefore) menuDivider,
          if (destination.heading != null) heading,
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
          if (destination.dividerAfter) menuDivider,
        ],
      );
    }
  }
}

/// Lays out two widgets with one as main body and a footer widget that
/// always appears at the bottom.
///
/// Keeping it local to this file as it is not used or needed anywhere
/// else, but it is a generally useful widget too.
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
      delegate: _FooterLayoutDelegate(MediaQuery.viewInsetsOf(context)),
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
  void performLayout(final Size size) {
    // Add bottom insets to given size.
    final Size sized = Size(size.width, size.height + viewInsets.bottom);
    final Size footer =
        layoutChild(_FooterPart.footer, BoxConstraints.loose(sized));

    final BoxConstraints bodyConstraints = BoxConstraints.tightFor(
      height: sized.height - max(footer.height, viewInsets.bottom),
      width: sized.width,
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
