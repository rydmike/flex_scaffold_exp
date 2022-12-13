import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/const/app_images.dart';
import '../../../app/const/app_insets.dart';
import '../../../core/views/widgets/app/headers/page_header.dart';
import '../../../core/views/widgets/app/headers/page_intro.dart';
import '../../../core/views/widgets/universal/page_body.dart';
import '../../../navigation/constants/routes.dart';
import '../../../navigation/controllers/current_route_provider.dart';
import '../../../navigation/models/app_navigation_state.dart';
import '../../../settings/controllers/pods_flexfold.dart';
import '../../../settings/views/widgets/app_bar/settings_app_bar.dart';

class TabAppBar extends ConsumerStatefulWidget {
  const TabAppBar({
    super.key,
  });

  @override
  ConsumerState<TabAppBar> createState() => _TabAppBarState();
}

class _TabAppBarState extends ConsumerState<TabAppBar>
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
    hide = FlexScaffold.use(context).scrollHideBottomBar;
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
    // Get the current destination details, we will use it's info in the
    // page header to display info on how we navigated to this page.
    final GoFlexDestination destination = appNav.destination;
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = destination.selectedIcon;
    final String heading = destination.label;

    return PageBody(
      // key: ValueKey<String>('${destination.route}${AppRoutes.tabsAppbar}'),
      controller: scrollController,
      child: ListView(
        // key: ValueKey<String>('${destination.route}${AppRoutes.tabsAppbar}'),
        primary: false,
        controller: scrollController,
        padding: const EdgeInsets.only(top: Sizes.l),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: PageHeader(
              icon: icon,
              heading: Text('$heading ${Routes.tabsAppbarLabel}'),
              destination: destination,
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: PageIntro(
              introTop: const Text(
                'This demo shows how you can make app bars more interesting by '
                'introducing a gradient, together with optional transparency '
                'that increases gradually.\n'
                '\n'
                'The reason for the gradient is just to make the app bar '
                'more dynamic and interesting. Whereas the gradient '
                'transparency is used to display content behind the '
                'app bar, as content scrolls below it.\n'
                '\n'
                'A transparent gradient that is fully opaque at the start '
                'of the app bar and increases in transparency towards the end, '
                'ensures that the title is always legible and keeps the effect '
                'subtle. A gradient and transparent app bar is still a '
                'matter of opinion and you can turn them off, as well as the '
                "scrolling behind the app bar or don't use the optional "
                'styled app bar constructor at all.\n',
              ),
              introBottom: const Text(
                'With FlexScaffold it is easy to include a gradient '
                'transparent AppBar. There is a styled AppBar '
                'factory to help make app bars like the one you '
                'see in this demo. '
                'When you combine the gradient transparent app bar with a '
                'white app bar theme, you get a Material themed app bar '
                'that resembles common iOS style app bars a bit. If you want '
                'to go full iOS style, then use the frosted glass blur style '
                'on a Material app bar as well. The frosted glass style '
                'is ON by default in this demo, but feel free to '
                'experiment with different settings.\n'
                '\n'
                'This page uses a vertical scroll view that stops '
                'just before the tab bar, so you will not see the scroll '
                'behind app bar effect on this particular page. It is however '
                'visible on all other pages in this demo app.\n'
                '\n'
                'The Settings page already contains the app bar settings '
                'below. '
                'This page just explains in a bit more detail how the app bar  '
                'made with the styled factory can be useful. There is also a '
                'feature that shows the current canvas size in the app bar. '
                'You can use it to verify that your responsive layouts '
                'work as designed during development.\n',
              ),
              imageAssets: AppImages.route[Routes.tabs]!.toList(),
            ),
          ),

          // APPBAR CONTROLS
          // ***************************************************
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text('Styled app bar settings',
                style: Theme.of(context).textTheme.headline5),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text(
              'FlexScaffold app bars can be made with an optional '
              'FlexAppBar.styled constructor to create gradient and '
              'partially transparent app bars. '
              'When you use transparency on the app bar you '
              'normally also enable scrolling behind the app bar, '
              'which is based on the standard Scaffold '
              '"extendBodyBehindAppBar" property.',
            ),
          ),
          const SizedBox(height: Sizes.l / 2),
          const SettingsAppBar(),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
