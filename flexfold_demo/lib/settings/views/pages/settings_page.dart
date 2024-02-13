import 'package:flex_scaffold/flex_scaffold.dart';
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
import '../../controllers/pods_flexfold.dart';
import '../widgets/app_bar/settings_app_bar.dart';
import '../widgets/application_settings/settings_application.dart';
import '../widgets/bottom_bar/settings_bottom_bar.dart';
import '../widgets/breakpoints/settings_breakpoints.dart';
import '../widgets/menu_controls/menu_control_settings.dart';
import '../widgets/menu_style/settings_menu.dart';
import '../widgets/other_settings/settings_other.dart';
import '../widgets/visibility/settings_visibility.dart';
import '../widgets/width/settings_width.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});
  static const String route = Routes.settings;

  @override
  ConsumerState<SettingsPage> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsPage> {
  late final ScrollController scrollController;
  late bool useHide;
  late ValueChanged<bool> hide;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0,
      debugLabel: 'SettingsScreenScrollController',
    );
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
    final CurrentRoute appNav = ref.watch(currentRouteProvider);

    // Get the current destination details, we will use it's info in the
    // page header to display info on how we navigated to this page.
    final FlexTarget destination = appNav.destination;
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = destination.selectedIcon;
    final Widget heading = Text(destination.label);

    // Frequently used text style on this page, so let's store a ref to it.
    final TextStyle headline5 = Theme.of(context).textTheme.headlineSmall!;

    // We need to add top and bottom padding back if we are using the
    // [extendBody] property behind bottom navigation bar and also the
    // [extendBodyBehindAppBar] flag. The media queries below gives us the
    // correct spacing we need to add as padding above our first and below
    // our last widget in order to not have the first one appear under the
    // appbar or the last one to remain bellow the bottom bar when we scroll up.
    // These extra padding insets also work correctly when we have no
    // [extend...] properties true, so they are perfect for all cases.
    // The bottom one even works when the bottom navigation bar is hidden by the
    // Flexfold as the value of the bottom padding goes to 0 then.
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return PageBody(
      controller: scrollController,
      child: ListView(
        primary: false,
        controller: scrollController,
        padding: EdgeInsets.only(
          top: Sizes.l + topPadding,
          bottom: Sizes.l + bottomPadding + kToolbarHeight,
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: PageHeader(
                icon: icon, heading: heading, destination: destination),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: PageIntro(
              introTop: const Text(
                'FlexScaffold offers a large number of responsive behaviors '
                'that you can adjust via its API or allow users to '
                'modify via settings, like in this demo.\n'
                '\n'
                'In addition to the responsive settings there are '
                'style settings that are easy to adjust '
                'to create a personalized look.\n'
                '\n'
                'The navigation mode changes are animated to create a '
                'smooth transition from bottom, to rail and side menu. '
                'The animation durations and curves can be adjusted.\n'
                '\n'
                'Width of the rail, locked menu and sidebar can also be '
                'changed, within given limitations.\n',
              ),
              introBottom: const Text(
                'A toggle function to show and hide the menu is built in to '
                'the menu button. It can be used to hide the side menu or '
                'rail, to make more space available for app '
                'content. On a desktop sized canvas you can hide the menu '
                'completely or make it a rail. '
                'A similar toggle control is also available for the '
                'optional sidebar.\n'
                '\n'
                'The tooltips on the settings below show the FlexScaffold '
                'API used and its current value based on the control '
                'setting. You can turn '
                'OFF the tooltips under Other settings. The purpose of these '
                'API tooltips is to function as an interactive reference '
                'guide to the FlexScaffold API.',
              ),
              imageAssets: AppImages.route[SettingsPage.route]!.toList(),
            ),
          ),
          const Divider(),

          // MENU TOGGLE ENABLE CONTROLS
          // ***************************************************
          const SizedBox(height: Sizes.l / 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text(
              'Menu controls',
              style: headline5,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text(
              'Toggle the menu and sidebar visibility '
              'by clicking on the menu buttons. The menu '
              'buttons only toggle the menu and sidebar between possible '
              'states based on current canvas size and '
              'breakpoint constraints.\n'
              '\n'
              'If you do not want users to be able '
              'to manually toggle the rail and menu modes or show and hide '
              'the sidebar, then you can disable the toggle controls. When '
              'they are disabled, the menu modes are locked to the mode '
              'given by current canvas size, the breakpoints and other '
              'menu visibility constraints you set.',
            ),
          ),
          const SizedBox(height: Sizes.l / 2),
          const MenuControlSettings(),
          const Divider(),

          // VISIBILITY CONTROLS
          // ***************************************************
          const SizedBox(height: Sizes.l / 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text(
              'Visibility',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text(
              'You can control the visibility of the rail, side '
              'menu and side bar via the API properties shown below. These '
              'controls are available also when you have disabled end user '
              'manual navigation mode control.',
            ),
          ),
          const SizedBox(height: Sizes.l / 2),
          const SettingsVisibility(),
          const Divider(),

          // BREAKPOINT CONTROLS
          // ***************************************************
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text('Breakpoints', style: headline5),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text(
              'You can modify the breakpoint for when the switch between '
              'each navigation type occurs. The breakpoints also function as '
              'constraints for available navigation modes when users '
              'manually toggle between them. '
              'The current screen width and height is shown in the app bar '
              'in this demo, you can use it to observe that changes occur '
              'at set breakpoints.\n'
              '\n'
              'The default breakpoint values work well for most '
              'devices and applications, but you can also adjust them '
              'via properties in FlexfoldThemeData. This demo allows you '
              'to adjust the breakpoints interactively to try the layout '
              'with other values.',
            ),
          ),
          const SizedBox(height: Sizes.l / 2),
          const SettingsBreakpoints(),
          const Divider(),

          // WIDTH CONTROLS
          // ***************************************************
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text('Width settings', style: headline5),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text('You can modify the width of the menu and sidebar. In '
                'this demo the menu and its drawer, likewise the '
                'sidebar and its end drawer, share the same width for '
                'simplicity of this demo. With the API you can set '
                'the width of their pinned to screen mode, '
                'separately from their drawer widths.'),
          ),
          const SizedBox(height: Sizes.l / 2),
          const SettingsWidth(),
          const Divider(),

          // MENU STYLE CONTROLS
          // ***************************************************
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text('Menu', style: headline5),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text(
              'The menu has its own app bar locked to the top, when '
              'expanded from Rail to Menu you can often fit a company '
              'logo or app name in it. '
              'Below the menu app bar there is a leading widget '
              'before the actual menu destinations, that are '
              'followed by a trailing widget and finally a footer that '
              'sticks to the bottom of the menu.\n'
              '\n'
              'You do not have to use leading, '
              'trailing and footer widgets, but they are available if '
              'you need them. The menu app bar and the menu footer do not '
              'scroll, but the rest of the menu widgets will scroll if '
              'the items do not fit vertically.\n'
              '\n'
              'A FlexfoldDestination class is used to define navigation '
              'destinations. You can define if a destination is included '
              'in the bottom navigation mode or not. For the menu you can '
              'define if there is a divider '
              'before or after each destination and if it has a '
              'heading. Does '
              'the destination have a FAB? Maybe a sidebar too? '
              'The configuration is very similar to Flutter NavigationRail '
              'destinations, but with a few more properties. FlexScaffold '
              'also has a custom theme FlexThemeData, used to style the '
              'FlexScaffold and define values for less used properties.',
            ),
          ),
          const SizedBox(height: Sizes.l / 2),
          const SettingsMenu(),
          const Divider(),

          // BOTTOM NAVIGATION CONTROLS
          // ***************************************************
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text('Bottom navigation bar', style: headline5),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text(
              'You can choose between using a Material or Cupertino bottom '
              'navigation bar. The choice can also be platform adaptive. '
              'Other bottom navigation bar styles may be added in future '
              'versions. The Material bottom navigator uses standard Flutter '
              'theming and properties, it also supports transparency '
              'and Cupertino style frosted glass blur.',
            ),
          ),
          const SizedBox(height: Sizes.l / 2),
          const SettingsBottomBar(),
          const Divider(),

          // APPBAR CONTROLS
          // ***************************************************
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text('App bar', style: headline5),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text(
              'FlexScaffold app bars can be constructed with an optional '
              'styled constructor to make a gradient and partially '
              'transparent app bar. When using app bar transparency you '
              'also want to enable scrolling behind it.',
            ),
          ),
          const SizedBox(height: Sizes.l / 2),
          const SettingsAppBar(),
          const Divider(),

          // OTHER CONTROLS
          // ***************************************************
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text('Other settings', style: headline5),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text(
              'Edge borders can give your app a more defined boxed '
              'look, but you may not need them with themes that blend '
              'in primary color into the surface colors. With the API you '
              'can also change the edge borders '
              'color. By default they use the divider theme color.',
            ),
          ),
          const SizedBox(height: Sizes.l / 2),
          const SettingsOther(),
          const Divider(),

          // FLUTTER CONTROLS
          // ***************************************************
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text('Application settings', style: headline5),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.l),
            child: Text(
              'These settings are not FlexScaffold settings, they are demo app '
              'related. They show how you can enrich your app with a few '
              'settings that can be helpful during development and testing '
              'and for user experience.\n'
              '\n'
              'Tooltips are nice, but can get in the way when '
              'you know the app. FlexScaffold allows your app to '
              'turn off its tooltips. Why not give users this '
              'choice for all other tooltips in your app too?\n'
              '\n'
              'Platform mechanics change how the '
              'user interface behaves. You can make text editing and '
              'scrolling on an Android device behave like on an Apple device '
              'and wise versa. Normally you would leave this at the used '
              'platform value, but if you for example prefer using iOS '
              'scrolling physics on Android, feel free to switch. Changing '
              'this setting is mostly useful for testing.\n'
              '\n'
              'Normally the device locale would change the LTR and RTL text '
              'direction and layout of the program. This simple demo uses '
              'no locale, but it can wrap itself with a given '
              'Directionality. You can use this to test and verify how the '
              'layout of FlexScaffold also changes with RTL directionality.',
            ),
          ),
          const SizedBox(height: Sizes.l / 2),
          const SettingsApplication(),
        ],
      ),
    );
  }
}
