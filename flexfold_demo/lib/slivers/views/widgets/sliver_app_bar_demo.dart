import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flex_scaffold/flex_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/const/app_images.dart';
import '../../../core/views/widgets/app/svg/svg_asset_image_switcher.dart';
import '../../../navigation/constants/routes.dart';
import '../../../navigation/controllers/current_route_provider.dart';
import '../../../navigation/models/app_navigation_state.dart';
import '../../../settings/controllers/pods_flexfold.dart';

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
    final CurrentRoute appNav = ref.read(currentRouteProvider);

    // Get the current destination details, we will use its info in the
    // page header to display info on how we navigated to this page.
    final FlexTarget destination = appNav.destination;
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final String title = destination.label;

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

    // Needed for the height of the flexible space, we need to pass it to
    // gradient container to know how high to make it to fill the AppBar.
    final double height = const Size.fromHeight(kToolbarHeight).height +
        MediaQuery.of(context).padding.top;

    // We also need to create the leading action button if the FlexScaffold
    // menu is in a Drawer and do same for the end Drawer actions if
    // FlexScaffold sidebar is in an end drawer.
    // If we do not do this, we will not be able to open the menu and sidebar
    // again from a destination that uses a custom sliver app bar,
    // or a persistent custom header.
    // The FlexScaffold contains proper status info for this and inserting
    // the FlexMenuButton and FlexSidebarButton is simple.

    /// Listen to aspect of the FlexScaffold and only rebuild if they change.
    final bool isMenuInDrawer = FlexScaffold.isMenuInDrawerOf(context);
    final bool isSidebarInEndDrawer =
        FlexScaffold.isSidebarInEndDrawerOf(context);

    // Leading widget, includes open drawer action and effective tooltip
    Widget? leading;
    if (isMenuInDrawer) {
      leading = FlexMenuButton(
        onPressed: () {},
      );
    }
    if (leading != null) {
      leading = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: kToolbarHeight),
        child: leading,
      );
    }
    // Actions widget, includes open end drawer action and effective tooltip.
    Widget? actions = const SizedBox.shrink();
    if (isSidebarInEndDrawer) {
      actions = FlexSidebarButton(
        onPressed: () {},
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
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FlexAppBarStyling(
            color: appBarColor,
            endColor: endColor,
            opacity: opacity,
            blurred: useBlur,
            hasBorder: effectiveBottomBorder,
            borderColor: bottomBorderColor,
            height: height,
          ),
          FlexibleSpaceBar(
            title: Text(title, style: TextStyle(color: textColor)),
            centerTitle: false,
            stretchModes: const <StretchMode>[
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
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
                  assetNames: AppImages.route[Routes.slivers]!.toList(),
                  showDuration: const Duration(milliseconds: 3500),
                  color: theme.colorScheme.primary,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  fit: BoxFit.fitHeight,
                  switchType: ImageSwitchType.random,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
