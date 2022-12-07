import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/const/app_images.dart';
import '../../../app/const/app_insets.dart';
import '../../../core/utils/hide_bottom_on_scroll.dart';
import '../../../core/views/widgets/app/headers/page_header.dart';
import '../../../core/views/widgets/app/headers/page_intro.dart';
import '../../../core/views/widgets/app/maybe_card.dart';
import '../../../core/views/widgets/universal/page_body.dart';
import '../../../navigation/constants/app_routes.dart';
import '../../../navigation/constants/destinations.dart';
import '../../../navigation/controllers/current_route_provider.dart';
import '../../../navigation/models/app_navigation_state.dart';
import '../../../settings/views/widgets/application_settings/modal_routes_switch.dart';

class TabModal extends ConsumerStatefulWidget {
  const TabModal({
    super.key,
  });

  @override
  ConsumerState<TabModal> createState() => _TabModalState();
}

class _TabModalState extends ConsumerState<TabModal>
    with AutomaticKeepAliveClientMixin {
  late ScrollController scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    scrollController =
        ScrollController(keepScrollOffset: true, initialScrollOffset: 0);
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
    // Must call super.
    super.build(context);
    final CurrentRoute appNav = ref.watch(currentRouteProvider);
    // Put some elements inside an extra card at this larger size
    final bool isDesktop =
        MediaQuery.of(context).size.width >= Sizes.desktopSize;
    // Get the current destination details, we will use it's info in the
    // page header to display info on how we navigated to this page.
    final FlexDestinationTarget destination = appNav.destination;
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = appDestinations[destination.index].selectedIcon;
    final String heading = appDestinations[destination.index].label;

    return PageBody(
      // key: ValueKey<String>('${destination.route}${AppRoutes.tabsModal}'),
      controller: scrollController,
      child: ListView(
        // key: ValueKey<String>('${destination.route}${AppRoutes.tabsModal}'),
        primary: false,
        controller: scrollController,
        padding: const EdgeInsets.only(top: Sizes.l),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: PageHeader(
              icon: icon,
              heading: Text('$heading ${AppRoutes.tabsModalLabel}'),
              destination: destination,
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: PageIntro(
              introTop: const Text(
                'When you have destinations in a bottom navigation bar and '
                'additional destinations in a drawer, you usually want the '
                'navigation to such additional destinations to be modal when '
                'you navigate to them and your canvas is phone sized that '
                'does not '
                'show all the destinations in a rail or side menu.\n'
                '\n'
                'With FlexScaffold you can use the source of the navigation to '
                'determine if you want push a full screen route on top of the '
                'FlexScaffold scaffold with only back option available or push '
                'a replacement named version of it, into the body part.\n'
                '\n'
                'FlexScaffold does not normally show bottom navigation '
                'bar destinations '
                'in the drawer during bottom bar navigation mode. '
                'However, if you '
                'navigate to a destination in bottom '
                'navigation mode that is not on the bottom navigation bar, '
                'then '
                'if you open the drawer again after this, you will find the '
                'bottom navigation bar destinations in the drawer.\n',
              ),
              introBottom: const Text(
                'This feature is required so you do not get stranded without '
                'a way back to bottom bar destinations in this '
                'navigation mode. Another and a better way to tackle this is '
                'to push the '
                'destinations that are only in the drawer in '
                'this navigation mode '
                'as new modal full screen on top of the entire FlexScaffold '
                'scaffold, with only back navigation option available. This '
                'is the normal and often preferred way of navigating '
                'from such extra drawer destinations on a phone.\n'
                '\n'
                'This example application '
                'has been designed to do so by default, by using the '
                '"use modal" '
                'info returned by the FlexfoldSelectedDestination '
                'information for such destinations, which are Preview, Help '
                'and About in this demo app.\n'
                '\n'
                'Even when using this capability, it is still potentially '
                'possible to get stranded. If you in rail or menu mode '
                'navigate to Preview, Help or About '
                'the destination should not be pushed as a full screen '
                'with only back option, preferably we should only get the '
                'destination content replaced into the body part of the app. '
                'This demo app works this way. '
                'However, in this mode if you then resize the canvas to enable '
                'bottom navigation mode, the Preview, Help and '
                'About views in this '
                'app do not know that they should change to '
                'full screen view with '
                'a back button, to take you back to last used bottom '
                'navigation destination. \n'
                '\n'
                'With FlexScaffold, navigation to the bottom '
                'navigation bar destinations, '
                'will also be possible in this scenario, since these '
                'destinations are now automatically available in the drawer.',
              ),
              imageAssets: AppImages.route[AppRoutes.tabs]!.toList(),
            ),
          ),
          const SizedBox(height: 20),
          MaybeCard(
            condition: isDesktop,
            child: const ModalRoutesSwitch(),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
