import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/app_navigation_state.dart';
import '../../navigation/app_routes.dart';
import '../../navigation/destinations.dart';
import '../../pods/pods_flexfold.dart';
import '../../pods/pods_navigation.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_images.dart';
import '../../utils/app_tooltips.dart';
import '../../widgets/svg/svg_asset_image_switcher.dart';

/// Example implementation of a SliverAppBar that follows the effective
/// Flexfold app bar style.
///
/// A SliverAppBar is a part of the app body and not of an application's
/// scaffold.
///
/// At the moment the only support Flexfold provides for sliver app bars is that
/// it can provide destinations that don't use any app bars at all, allowing you
/// to build your own sliver app bar in a sliver.
///
/// Following all the styling, button and tooltip options that Flexfold provides
/// for its styled app bar can be a bit verbose. The example shows one way of
/// implementing it. Future versions of Flexfold might contain a helper class
/// to facilitate making SliverAppBars for it.
class SliverAppBarDemo extends ConsumerWidget {
  const SliverAppBarDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppNavigation appNav = ref.read(navigationPod);

    // Get the current destination details, we will use its info in the
    // page header to display info on how we navigated to this page.
    final FlexfoldDestinationData destination = appNav.destination;
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final String title = appDestinations[destination.menuIndex].label;

    // There is no pre-made sliver app bar in Flexfold (yet), you have to
    // make one yourself. You can make it however you like. In this demo we
    // want to follow the same settings as the rest of the demo app uses.
    final bool useGradients = ref.watch(appBarGradientPod);
    final bool useBlur = ref.watch(appBarBlurPod);
    final bool hasBottomBorder = ref.watch(appBarBorderPod);
    final bool hasBottomBorderOnBlackOrWhite =
        ref.watch(appBarBorderOnSurfacePod);

    // If transparent flag is false, we override any opacity value. This is a
    // convenience flag to turn off all opacity, makes using settings in the app
    // easier for the demo when you want to turn OFF opacity completely.
    final double opacity =
        ref.watch(appBarTransparentPod) ? ref.watch(appBarOpacityPod) : 1.0;

    final ThemeData theme = Theme.of(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final Color appBarColor = appBarTheme.backgroundColor ?? theme.primaryColor;

    final Color endColor = theme.brightness == Brightness.light
        ? appBarColor.lighten(useGradients ? 15 : 0)
        : appBarColor.darken(useGradients ? 15 : 0);

    final Color textColor =
        ThemeData.estimateBrightnessForColor(appBarColor) == Brightness.light
            ? const Color(0xBB000000)
            : Colors.white70;

    // Determine if we should draw a bottom border. Always if the
    // flag to use it is true OR if the flag to use it on dark, black or white
    // app bar is true and we have dark, black or white color in the app bar.
    final Color surfaceColor = theme.colorScheme.surface;
    final bool effectiveBottomBorder = hasBottomBorder ||
        (hasBottomBorderOnBlackOrWhite &&
            (appBarColor == Colors.black ||
                appBarColor == Colors.white ||
                appBarColor == surfaceColor ||
                endColor == Colors.black ||
                endColor == Colors.white ||
                endColor == surfaceColor));

    // User provided border color, if none use theme divider color, the demo app
    // always just uses the theme dividerColor, so that is all we have to get.
    final Color bottomBorderColor = theme.dividerColor;

    // We also need to create the leading action button if the scaffold
    // has a drawer and do same for the end drawer if it has an end drawer.
    // If we do not do this, we will not be able to open the menu and sidebar
    // again from a destination that uses a custom sliver app bar,
    // or a persistent custom header.
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;

    // Figure out the effective tooltip, including using the same material
    // localization in case we do not have a custom string. In this case
    // that will never happen, it is just there as a reminder of which one is
    // used. In the app we have no access to the Flexfold theme setting here,
    // but as for the other properties, we do have the value that controls it
    // via the provider.
    final String? effectiveMenuTooltip = ref.watch(useTooltipsPod)
        ? AppTooltips.openMenu
        // TODO(rydmike): Maybe put these back somehow
        // ??
        //     MaterialLocalizations.of(context).openAppDrawerTooltip
        : null;

    // Leading widget, including open drawer action and effective tooltip
    Widget? leading;
    if (hasDrawer) {
      leading = IconButton(
        icon: ref.watch(useCustomMenuIconsPod)
            ? AppIcons.menuIcon
            : kFlexfoldMenuIcon,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        tooltip: effectiveMenuTooltip,
      );
    }
    if (leading != null) {
      leading = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: kToolbarHeight),
        child: leading,
      );
    }

    // Effective tooltip for the sidebar
    final String? effectiveSidebarTooltip = ref.watch(useTooltipsPod)
        ? AppTooltips.openSidebar
        // TODO(rydmike): Maybe put these back somehow
        // ??
        //     MaterialLocalizations.of(context).showMenuTooltip
        : null;

    // Actions widget, including open end drawer action and effective tooltip.
    // NOTE: This does no recreate the feature to not toggle via the drawer,
    // doing so is currently not possible in the SliverAppBar that is not
    // managed by Flexfold.
    Widget actions = const SizedBox.shrink();
    if (hasEndDrawer) {
      actions = IconButton(
        icon: ref.watch(useCustomMenuIconsPod)
            ? AppIcons.sidebarIcon
            : kFlexfoldSidebarIcon,
        onPressed: () {
          Scaffold.of(context).openEndDrawer();
        },
        tooltip: effectiveSidebarTooltip,
      );
    }

    // TODO(rydmike): Maybe make a SilverAppBar helper for the release as well?
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      floating: true,
      snap: true,
      stretch: true,
      leading: leading,
      actions: <Widget>[actions],
      elevation: 0,
      collapsedHeight: kToolbarHeight,
      expandedHeight: 220,
      backgroundColor: Colors.transparent,
      stretchTriggerOffset: 220,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(title, style: TextStyle(color: textColor)),
        centerTitle: false,
        stretchModes: const <StretchMode>[
          StretchMode.zoomBackground,
          // StretchMode.fadeTitle,
          StretchMode.blurBackground,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FlexAppBarStyling(
              color: appBarColor,
              endColor: endColor,
              opacity: opacity,
              blurred: useBlur,
              hasBorder: effectiveBottomBorder,
              borderColor: bottomBorderColor,
              height: 220,
            ),
            SvgAssetImageSwitcher(
              assetNames: AppImages.route[AppRoutes.slivers]!.toList(),
              showDuration: const Duration(milliseconds: 3500),
              color: Theme.of(context).colorScheme.primary,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              fit: BoxFit.fitHeight,
              switchType: ImageSwitchType.random,
            ),
          ],
        ),
      ),
    );
  }
}
