import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/app_navigation_state.dart';
import '../../navigation/app_routes.dart';
import '../../navigation/destinations.dart';
import '../../pods/pods_application.dart';
import '../../pods/pods_flexfold.dart';
import '../../pods/pods_navigation.dart';
import '../../utils/app_images.dart';
import '../../utils/app_insets.dart';
import '../../widgets/headers/page_header.dart';
import '../../widgets/headers/page_intro.dart';
import '../page_body.dart';

class HelpScreen extends ConsumerWidget {
  const HelpScreen({super.key});
  static const String route = AppRoutes.help;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppNavigation appNav = ref.watch(navigationPod);
    // Get the current destination details, we will use it's info in the
    // page header to display info on how we navigated to this page.
    final FlexfoldDestinationData destination = appNav.useModalDestination
        ? appNav.modalDestination
        : appNav.destination;

    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = appDestinations[destination.menuIndex].selectedIcon;
    final Widget heading = Text(appDestinations[destination.menuIndex].label);

    // In case we are showing the screen as modal screen it will then be
    // shown by the root navigator that does not have our custom directionality
    // wrapper above it in the tree, so we just add it once more.
    return Directionality(
      textDirection: appTextDirection(context, ref),
      child: Scaffold(
        // key: const PageStorageKey<String>(route),

        // If a main destination is being displayed as a modal route, we add an
        // app bar, with same style as rest of app, with an implicit back button
        // that it will get since it was pushed on top of a base route.
        appBar: destination.useModal && ref.watch(useModalRoutesPod)
            ? FlexAppBar.styled(
                context,
                title: Text(appDestinations[destination.menuIndex].label),
                gradient: ref.watch(appBarGradientPod),
                blurred: ref.watch(appBarBlurPod),
                opacity: ref.watch(appBarTransparentPod)
                    ? ref.watch(appBarOpacityPod)
                    : 1.0,
                hasBorderOnSurface: ref.watch(appBarBorderOnSurfacePod),
                hasBorder: ref.watch(appBarBorderPod),
                showScreenSize: ref.watch(appBarShowScreenSizePod),
              ).toAppBar()
            // No app bar, the scaffold is being shown inside the layout screen
            : null,
        extendBody: ref.watch(extendBodyPod),
        extendBodyBehindAppBar: ref.watch(extendBodyBehindAppBarPod),
        body: Builder(builder: (BuildContext context) {
          // See settings_screen.dart for an explanation of these
          // padding values and why they are VERY handy and useful.
          final double topPadding = MediaQuery.of(context).padding.top;
          final double bottomPadding = MediaQuery.of(context).padding.bottom;
          //
          return PageBody(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                AppInsets.l,
                AppInsets.l + topPadding,
                AppInsets.l,
                AppInsets.l + bottomPadding,
              ),
              children: <Widget>[
                PageHeader(
                    icon: icon, heading: heading, destination: destination),
                const Divider(),
                PageIntro(
                  introTop: const Text(
                    'Flexfold is primarily intended for Flutter '
                    'applications that target Desktop and Web, but it is '
                    'also great for resizable apps on tablets and Chromebooks. '
                    'It also works great for switching between '
                    'portrait and landscape mode on phones and tablets, '
                    'offering different navigation modes on them too. '
                    'Flexfold is really useful when you make a single app that '
                    'needs to support layout and navigation on phones, '
                    'tablets, desktop and web, using the same code base.\n'
                    '\n'
                    'This Flexfold feature demonstration uses named '
                    'routing. You do not have to use named routes, but it '
                    'is recommended. Named routes are easy '
                    'with Flexfold and they also enable URL based routes if '
                    'you plan to release your Flutter app on the Web. '
                    'The "onDestinationSelected" callback provides not just a '
                    'menu index of the tapped destination, but a class with '
                    'the values that you see '
                    'in each page header in this demo.\n',
                  ),
                  introBottom: const Text(
                    "In addition to the tapped indexes, the destination's "
                    'named route is included as a return value in the class. '
                    'The "Tapped via" source, index change "Direction" are '
                    'also included. You can use this information to determine '
                    'how you want to navigate to the destination.\n'
                    '\n'
                    'This demo shows how the destination information can be '
                    'used to build '
                    'different page transitions depending on which menu you '
                    'navigate from. For example, from locked side menu there '
                    'is no page transition. This works well with Web '
                    'and desktop navigation. It is focused and quick, also '
                    'animation of large surfaces on desktop sizes can be '
                    'very distracting. At most a very quick and subtle fade '
                    'through could be used if some navigation animation is '
                    'desired. For this demo it was opted '
                    'to not have any animation for this navigation type.\n'
                    '\n'
                    'From a rail or a drawer '
                    'the FadeTrough transition from the Flutter Animations '
                    'packages is used. This works well in tablet mode or when '
                    'the direction of the navigation is uncertain. We can also '
                    'see that only the actual content of the page animates. '
                    'The rail, bottom bar, app bar and sidebar do not animate '
                    'and remain fixed.\n'
                    '\n'
                    'The bottom navigation uses a shared axis transition. '
                    'This creates a slight sideways motion as the '
                    'bottom destinations are clicked, without the same feeling '
                    'that they are a part of same view that sliding animations '
                    'imply, which would also suggest swiping navigation is '
                    'available. Swiping navigation is not available here, '
                    'since in this demo we consider the bottom navigation '
                    'destinations to be independent of each other.\n'
                    '\n'
                    'The purpose of these different page transition types are '
                    'to use transitions that fit the most likely used device '
                    'for the navigation type. This type of adaptive page '
                    'transition, is not a part of Flexfold. However, the '
                    '"onDestinationSelected" callback returns the information '
                    'needed to implement it, like this demo does.\n',
                  ),
                  imageAssets: AppImages.route[route]!.toList(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
