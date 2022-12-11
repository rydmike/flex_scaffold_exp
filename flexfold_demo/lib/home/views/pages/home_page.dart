import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/const/app_images.dart';
import '../../../app/const/app_insets.dart';
import '../../../core/controllers/app_controllers.dart';
import '../../../core/views/widgets/app/headers/page_header.dart';
import '../../../core/views/widgets/app/if_wrapper.dart';
import '../../../core/views/widgets/app/plasma_background.dart';
import '../../../core/views/widgets/app/svg/svg_asset_image_switcher.dart';
import '../../../info/views/pages/info_page.dart';
import '../../../navigation/constants/app_routes.dart';
import '../../../navigation/constants/destinations.dart';
import '../../../navigation/controllers/current_route_provider.dart';
import '../../../navigation/models/app_navigation_state.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  static const String route = AppRoutes.home;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get to flex scaffold state from inherited widget.
    final FlexScaffoldState flexScaffold = FlexScaffold.of(context);
    //
    final CurrentRoute appNav = ref.watch(currentRouteProvider);
    // Get the current destination details, we will use it's info in the page
    // header to display where we are and how we navigated to this page.
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
    final Widget flexfold = Text('FlexScaffold',
        style: isSmall ? textTheme.headline5 : textTheme.headline3);
    final Widget whatIsFlexfold = Text(
      'What is FlexScaffold?',
      style: isSmall ? textTheme.subtitle1 : textTheme.headline5,
      textAlign: TextAlign.center,
    );
    final Widget noOneCanBeTold = Text(
      'No one can be told what the FlexScaffold is!\n'
      'Click on the image to experience it...',
      style: isSmall ? textTheme.caption : textTheme.bodyText1,
      textAlign: TextAlign.center,
    );

    return IfWrapper(
      condition: ref.watch(plasmaBackgroundProvider),
      builder: (BuildContext context, Widget child) =>
          PlasmaBackground(child: child),
      child: GestureDetector(
        // We want to go to the info screen when any widget is tapped.
        onTap: () {
          // We are going to use the Info screen as a direct button link on
          // this screen, so we create its destination info from the route.
          // In this case we want our navigation to the new screen to behave
          // the same as if we had tapped on its target from the rail.
          final FlexDestinationTarget destination = flexScaffold.fromRoute(
            InfoPage.route,
            source: FlexNavigation.rail,
          );
          // We update the FlexfoldModel with info about where we
          // are going, so it can update itself too, this will trigger a
          // navigation indication change on Flexfold menu as well and
          // our current destination info will be correct after the
          // manual navigation to a Flexfold destination from the
          // outside of Flexfold.
          ref.read(currentRouteProvider.notifier).setDestination(destination);
          context.go(destination.route);
        },
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Sizes.maxBodyWidth),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                Sizes.l,
                Sizes.l + topPadding,
                Sizes.l,
                Sizes.l + bottomPadding,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
