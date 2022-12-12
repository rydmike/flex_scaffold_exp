import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/const/app_images.dart';
import '../../../app/const/app_insets.dart';
import '../../../core/utils/link_text_span.dart';
import '../../../core/views/widgets/app/headers/page_header.dart';
import '../../../core/views/widgets/app/headers/page_intro.dart';
import '../../../core/views/widgets/universal/page_body.dart';
import '../../../navigation/constants/routes.dart';
import '../../../navigation/controllers/current_route_provider.dart';
import '../../../navigation/models/app_navigation_state.dart';
import '../../../settings/controllers/pods_flexfold.dart';

class TabGuide extends ConsumerStatefulWidget {
  const TabGuide({super.key});

  @override
  ConsumerState<TabGuide> createState() => _TabGuideState();
}

class _TabGuideState extends ConsumerState<TabGuide>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController scrollController;
  late bool useHide;
  late ValueChanged<bool> hide;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    scrollController =
        ScrollController(keepScrollOffset: true, initialScrollOffset: 0);
    scrollController.addListener(
      () {
        FlexScaffold.hideBottomBarOnScroll(scrollController, hide, useHide);
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    useHide = ref.watch(hideBottomBarOnScrollPod);
    hide = FlexScaffold.of(context).scrollHideBottomBar;
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
    final ThemeData themeData = Theme.of(context);
    final TextStyle linkStyle = themeData.textTheme.bodyText1!.copyWith(
        color: themeData.colorScheme.primary, fontWeight: FontWeight.bold);
    // Get the current destination details, we will use it's info in the
    // page header to display info on how we navigated to this page.
    final GoFlexDestination destination = appNav.destination;
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = destination.selectedIcon;
    final Widget heading = Text(destination.label);

    return PageBody(
      // key: ValueKey<String>('${destination.route}${AppRoutes.tabsGuide}'),
      controller: scrollController,
      child: ListView(
        // key: ValueKey<String>('${destination.route}${AppRoutes.tabsGuide}'),
        primary: false,
        controller: scrollController,
        padding: const EdgeInsets.only(top: Sizes.l),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: PageHeader(
                icon: icon,
                heading: Text('$heading ${Routes.tabsGuideLabel}'),
                destination: destination),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
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
              imageAssets: AppImages.route[Routes.tabs]!.toList(),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
