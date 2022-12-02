import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/app_navigation_state.dart';
import '../../navigation/app_routes.dart';
import '../../navigation/destinations.dart';
import '../../pods/pods_navigation.dart';
import '../../utils/app_images.dart';
import '../../utils/app_insets.dart';
import '../../widgets/headers/page_header.dart';
import '../../widgets/headers/page_intro.dart';
import '../../widgets/text/link_text_span.dart';
import '../hide_bottom_on_scroll.dart';
import '../page_body.dart';

class TabGuide extends ConsumerStatefulWidget {
  const TabGuide({super.key});

  @override
  ConsumerState<TabGuide> createState() => _TabGuideState();
}

class _TabGuideState extends ConsumerState<TabGuide>
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
    final AppNavigation appNav = ref.watch(navigationPod);
    final ThemeData themeData = Theme.of(context);
    final TextStyle linkStyle = themeData.textTheme.bodyText1!.copyWith(
        color: themeData.colorScheme.primary, fontWeight: FontWeight.bold);
    // Get the current destination details, we will use it's info in the
    // page header to display info on how we navigated to this page.
    final FlexfoldDestinationData destination = appNav.destination;
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = appDestinations[destination.menuIndex].selectedIcon;
    final String heading = appDestinations[destination.menuIndex].label;

    return PageBody(
      // key: ValueKey<String>('${destination.route}${AppRoutes.tabsGuide}'),
      controller: scrollController,
      child: ListView(
        // key: ValueKey<String>('${destination.route}${AppRoutes.tabsGuide}'),
        controller: scrollController,
        padding: const EdgeInsets.only(top: AppInsets.l),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppInsets.l),
            child: PageHeader(
                icon: icon,
                heading: Text('$heading ${AppRoutes.tabsGuideLabel}'),
                destination: destination),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppInsets.l),
            child: PageIntro(
              introTop: Text.rich(
                TextSpan(
                  text: 'This page demonstrates how the bottom navigation bar, '
                      'rail and menu work together with tab bar views.\n'
                      '\n'
                      'The Material design guide cautions against using a tab '
                      'bar together with a bottom navigation bar, as it may be '
                      'confusing. The exact used caution is:\n'
                      '\n'
                      '"Combining bottom navigation and tabs may cause '
                      'confusion, as their relationship to the content may '
                      'be unclear. Tabs share a common subject, whereas '
                      'bottom navigation destinations '
                      'are top-level and disconnected from each other."\n'
                      '\n'
                      'This is a valid point, still on the very same page the '
                      'guide presents an app using both at the same time ',
                  children: <InlineSpan>[
                    LinkTextSpan(
                      style: linkStyle,
                      uri: Uri(
                        scheme: 'https',
                        host: 'material.io',
                        path: 'components/bottom-navigation#behavior',
                      ),
                      text: 'here.',
                    ),
                    const TextSpan(
                      text: '\n\n'
                          'Despite it being advised against, it is clearly '
                          'something that is used frequently. '
                          'Twitter and Spotify are examples of well known '
                          'Android apps '
                          'that combine bottom navigation with top tab '
                          'bar views, on '
                          'some of their bottom navigation destinations. '
                          'We can conclude that regardless of the sensible '
                          'caution, it is still a fairly common design.\n',
                    ),
                  ],
                ),
              ),
              introBottom: const Text(
                'When the view switches to a rail or side menu, the tab view '
                'is an excellent choice and works really well for related '
                'views for the active destination. This page demonstrates '
                'this when you '
                'use a larger canvas that switches to rail or menu view.\n'
                '\n'
                'In this example the tab bar is not '
                'anchored to bottom part of the app bar, it is in the '
                'top part of the body. The side bar is also present on '
                'this screen so we can see how it works with a tab bar view '
                'as well.',
              ),
              imageAssets: AppImages.route[AppRoutes.tabs]!.toList(),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
