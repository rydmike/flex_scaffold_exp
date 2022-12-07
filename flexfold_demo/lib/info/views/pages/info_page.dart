import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/const/app_images.dart';
import '../../../app/const/app_insets.dart';
import '../../../core/utils/hide_bottom_on_scroll.dart';
import '../../../core/views/widgets/app/headers/page_header.dart';
import '../../../core/views/widgets/app/headers/page_intro.dart';
import '../../../core/views/widgets/universal/page_body.dart';
import '../../../navigation/constants/app_routes.dart';
import '../../../navigation/constants/destinations.dart';
import '../../../navigation/controllers/current_route_provider.dart';
// import 'package:routemaster/routemaster.dart';

import '../../../navigation/models/app_navigation_state.dart';
import '../../../settings/controllers/pods_flexfold.dart';
import '../../../settings/views/pages/settings_page.dart';

class InfoPage extends ConsumerStatefulWidget {
  const InfoPage({super.key});
  static const String route = AppRoutes.info;

  @override
  ConsumerState<InfoPage> createState() => _InfoScreenState();
}

class _InfoScreenState extends ConsumerState<InfoPage> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0,
      debugLabel: 'InfoScreenScrollController',
    );
    scrollController.addListener(
      () {
        hideBottomOnScroll(ref, scrollController);
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CurrentRoute appNav = ref.watch(currentRouteProvider);
    final CurrentRouteStateNotifier appNavNotify =
        ref.read(currentRouteProvider.notifier);

    // Get the current destination details, we will use it's info in the
    // page header to display info on how we navigated to this page.
    final FlexDestinationTarget destination = appNav.destination;
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = appDestinations[destination.index].selectedIcon;
    final Widget heading = Text(appDestinations[destination.index].label);

    // See settings_page.dart for an explanation of these
    // padding values and why they are VERY handy and useful.
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return PageBody(
      controller: scrollController,
      child: ListView(
        primary: false,
        controller: scrollController,
        padding: EdgeInsets.fromLTRB(
          Sizes.l,
          Sizes.l + topPadding,
          Sizes.l,
          Sizes.l + bottomPadding,
        ),
        children: <Widget>[
          PageHeader(icon: icon, heading: heading, destination: destination),
          const Divider(),
          PageIntro(
            introTop: const Text(
              'Flexfold is a smooth responsive scaffold package for '
              'Flutter. This application demonstrates its core features.\n'
              '\n'
              'The responsive navigation modes automatically '
              'change from bottom navigation bar, to rail and to side '
              'menu as the canvas size grows. The smooth part is that '
              'the switches from one mode to another are animated.\n'
              '\n'
              'On a large canvas the user can control the desired navigation '
              'mode with the menu button and toggle the side menu from '
              'being hidden in a drawer, to a rail and to be fully visible '
              'as a side menu. You change navigation mode by clicking on the '
              'menu button. The menu button only toggles the menu style '
              'between allowed navigation modes based on current canvas '
              'size and defined navigation mode breakpoint constraints.\n',
            ),
            introBottom: const Text(
              'The breakpoints for when the navigation mode changes, can '
              'be adjusted. The defaults work well enough for most '
              'use cases.\n'
              '\n'
              'To keep the rail as slim as possible, navigation '
              'destination labels only appear as tooltips '
              'in rail mode. This results in a slim un-intrusive icon '
              'only rail, that is suitable for tablets in portrait mode '
              'and if so desired it can also be used in landscape mode '
              'on phones or even portrait mode on large phones in some '
              'use cases.\n'
              '\n'
              'The end drawer can also become a permanent fixture on a wide '
              'enough canvas as a sidebar. The sidebar entrance is also '
              'animated. '
              "The sidebar's visibility can also "
              'be toggled with its menu button.\n'
              '\n'
              'The width of the rail, side menu and the sidebar can all be '
              'individually adjusted. \n'
              '\n'
              'In this demo you can play with the settings and observe '
              'Flexfold in action. The Flexfold API has a few more '
              'features than those demonstrated here.\n'
              '\n'
              'You will find the key settings on the Settings page, but '
              'there are some usage hints on other pages in this demo '
              'as well.',
            ),
            imageAssets: AppImages.route[AppRoutes.info]!.toList(),
          ),
          const SizedBox(height: 20),
          Center(
            child: OutlinedButton(
              onPressed: () {
                // We are going to use the configure screen as a direct button
                // link on this screen so we will creates its destination info
                // from the route to its screen and our const list of
                // destinations.
                // In this case we want our navigation to the new screen to
                // behave the same as if we had tapped on its target from
                // the rail.
                final FlexDestinationTarget newDestination =
                    FlexDestinationTarget.fromRoute(
                  SettingsPage.route,
                  appDestinations,
                  source: FlexNavigation.rail,
                );
                // We update the FlexfoldModel with info about where we
                // are going, so it can update itself too, this will trigger a
                // navigation indication change on the Flexfold as well and
                // all our current destination info will be correct too.
                appNavNotify.setDestination(newDestination);
                // Make sure our bottom navigation bar is not hidden.
                ref.read(scrollHiddenBottomBarPod.notifier).state = false;
                // Actually navigate to the target route.
                context.go(newDestination.route);
              },
              child: const Text('Read more...'),
            ),
          ),
        ],
      ),
    );
  }
}
