import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// import 'package:routemaster/routemaster.dart';

import '../../model/app_navigation_state.dart';
import '../../navigation/app_routes.dart';
import '../../navigation/destinations.dart';
import '../../pods/pods_application.dart';
import '../../pods/pods_navigation.dart';
import '../../utils/app_images.dart';
import '../../utils/app_insets.dart';
import '../../widgets/headers/page_header.dart';
import '../../widgets/svg/svg_asset_image_switcher.dart';
import '../../widgets/wrappers/if_wrapper.dart';
import '../../widgets/wrappers/plasma_background.dart';
import '../info/info_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static const String route = AppRoutes.home;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppNavigation appNav = ref.watch(navigationPod);
    final AppNavigationStateNotifier appNavNotify =
        ref.read(navigationPod.notifier);
    // Get the current destination details, we will use it's info in the page
    // header to display where we are and how we navigated to this page.
    final FlexfoldDestinationData destination = appNav.destination;
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = appDestinations[destination.menuIndex].selectedIcon;
    final Widget heading = Text(appDestinations[destination.menuIndex].label);

    // See settings_screen.dart for an explanation of these
    // padding values and why they are VERY handy and useful.
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    // Text theme for easy quick repeated reference.
    final TextTheme textTheme = Theme.of(context).textTheme;
    // The height is low, it is in phone landscape range, we will make some
    // changes to the layout and sizes based on that to make it all fit nicer.
    final bool isLow = MediaQuery.of(context).size.height < 560;
    final bool isSmall = MediaQuery.of(context).size.height < 650;

    // Sometimes for a small simple screen that needs different layouts
    // dividing things to parts that we place in different places is a
    // quick and simple approach.
    final Widget welcome = Text('Welcome to',
        style: isSmall ? textTheme.caption : textTheme.headline5);
    final Widget flexfold = Text('Flexfold',
        style: isSmall ? textTheme.headline5 : textTheme.headline3);
    final Widget whatIsFlexfold = Text(
      'What is Flexfold?',
      style: isSmall ? textTheme.subtitle1 : textTheme.headline5,
      textAlign: TextAlign.center,
    );
    final Widget noOneCanBeTold = Text(
      'No one can be told what the Flexfold is!\n'
      'Click on the image to experience it...',
      style: isSmall ? textTheme.caption : textTheme.bodyText1,
      textAlign: TextAlign.center,
    );

    return Scaffold(
      body: IfWrapper(
        condition: ref.watch(plasmaBackgroundPod),
        builder: (BuildContext context, Widget child) =>
            PlasmaBackground(child: child),
        child: GestureDetector(
          // We want to go to the info screen when any widget is tapped.
          onTap: () {
            // We are going to use the Info screen as a direct button link on
            // this screen, so we create its destination info from the route to
            // its screen and our const list of destinations.
            // In this case we want our navigation to the new screen to behave
            // the same as if we had tapped on its target from the rail.
            final FlexfoldDestinationData newDestination =
                FlexfoldDestinationData.fromRoute(
              InfoScreen.route,
              appDestinations,
              source: FlexfoldNavigationSource.rail,
            );
            // We update the FlexfoldModel with info about where we
            // are going, so it can update itself too, this will trigger a
            // navigation indication change on Flexfold menu as well and
            // our current destination info will be correct after the
            // manual navigation to a Flexfold destination from the
            // outside of Flexfold.
            appNavNotify.newDestination(newDestination);
            context.go(newDestination.route);
            // TODO(rydmike): Remove old Nav global root key navigator.
            // appNav.navKeyFlexfold.currentState!
            //     .pushReplacementNamed(newDestination.route);
          },
          child: Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: AppInsets.maxBodyWidth),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  AppInsets.l,
                  AppInsets.l + topPadding,
                  AppInsets.l,
                  AppInsets.l + bottomPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    PageHeader(
                        icon: icon, heading: heading, destination: destination),
                    const Divider(),
                    Expanded(
                      child: isLow
                          ? Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      const Spacer(),
                                      welcome,
                                      flexfold,
                                      const Spacer(),
                                      whatIsFlexfold,
                                      const SizedBox(height: 5),
                                      noOneCanBeTold,
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  child: FrontPageImages(),
                                )),
                              ],
                            )
                          : Column(
                              children: <Widget>[
                                const Spacer(),
                                welcome,
                                flexfold,
                                const Spacer(),
                                const Expanded(
                                    flex: 10,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 35,
                                        vertical: 20,
                                      ),
                                      child: FrontPageImages(),
                                    )),
                                const SizedBox(height: 20),
                                whatIsFlexfold,
                                const SizedBox(height: 10),
                                noOneCanBeTold,
                                const Spacer(),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FrontPageImages extends StatelessWidget {
  const FrontPageImages({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgAssetImageSwitcher(
      assetNames: AppImages.route[AppRoutes.home]!.toList(),
      color: Theme.of(context).colorScheme.primary,
      alignment: Alignment.center,
      padding: EdgeInsets.zero,
      fit: BoxFit.contain,
    );
  }
}
