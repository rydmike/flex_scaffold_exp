import 'package:flex_scaffold/flex_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/const/app_images.dart';
import '../../../app/const/app_insets.dart';
import '../../../core/utils/link_text_span.dart';
import '../../../core/views/widgets/app/animated_hide.dart';
import '../../../core/views/widgets/app/headers/page_header.dart';
import '../../../core/views/widgets/app/headers/page_intro.dart';
import '../../../core/views/widgets/app/svg/logo.dart';
import '../../../core/views/widgets/universal/page_body.dart';
import '../../../core/views/widgets/universal/theme_showcase.dart';
import '../../../navigation/constants/routes.dart';
import '../../../navigation/controllers/current_route_provider.dart';
import '../../../navigation/models/app_navigation_state.dart';
import '../../../settings/controllers/pods_flexfold.dart';
import '../../controllers/pods_theme.dart';
import '../widgets/compute_dark_theme_switch.dart';
import '../widgets/copy_to_custom.dart';
import '../widgets/dark_app_bar_switch.dart';
import '../widgets/dark_colors_swap_switch.dart';
import '../widgets/dark_level_slider.dart';
import '../widgets/enabled_colors_switch.dart';
import '../widgets/image_selector.dart';
import '../widgets/light_app_bar_switch.dart';
import '../widgets/light_colors_swap_switch.dart';
import '../widgets/surface_style_switch.dart';
import '../widgets/tab_bar_style_switch.dart';
import '../widgets/theme_color_scheme.dart';
import '../widgets/theme_colors.dart';
import '../widgets/theme_mode_switch.dart';
import '../widgets/theme_popup_menu.dart';
import '../widgets/theme_selector.dart';
import '../widgets/tooltip_style_switch.dart';

class ThemePage extends ConsumerStatefulWidget {
  const ThemePage({super.key});
  static const String route = Routes.theme;

  @override
  ConsumerState<ThemePage> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends ConsumerState<ThemePage>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController scrollController;
  late bool useHide;
  late ValueChanged<bool> hide;

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
  bool get wantKeepAlive => true;

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
    final FlexTarget destination = appNav.destination;
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = destination.selectedIcon;
    final Widget heading = Text(destination.label);
    // See setup_screen.dart [ConfigScreen] for an explanation of these
    // padding values and why they are VERY handy and useful.
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final bool isLight = theme.brightness == Brightness.light;
    final TextStyle linkStyle = theme.textTheme.bodyLarge!
        .copyWith(color: scheme.primary, fontWeight: FontWeight.bold);

    return PageBody(
      // key: ValueKey<String>(destination.route),
      controller: scrollController,
      child: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(
              top: Sizes.l + topPadding,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
                    child: PageHeader(
                        icon: icon, heading: heading, destination: destination),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
                    child: PageIntro(
                      introTop: Text.rich(
                        TextSpan(
                          text: 'The theming shown here '
                              'is done with a package called ',
                          children: <InlineSpan>[
                            LinkTextSpan(
                              style: linkStyle,
                              uri: Uri(
                                scheme: 'https',
                                host: 'pub.dev',
                                path: 'packages/flex_color_scheme',
                              ),
                              text: 'FlexColorScheme',
                            ),
                            const TextSpan(
                              text: '. This page shows the kind of '
                                  'theming it simplifies.\n'
                                  '\n'
                                  "FlexColorScheme uses Flutter's newer "
                                  '"ColorScheme based '
                                  'themes. Similarly to the ThemeData '
                                  'from factory, '
                                  'it also creates Themes from color '
                                  'schemes. It has two '
                                  'convenience factories, '
                                  'FlexColorScheme '
                                  'light and '
                                  'dark. It also addresses some '
                                  'theme gaps in the standard Theme '
                                  'from color scheme '
                                  'based theming.\n'
                                  '\n'
                                  'FlexColorScheme supports using '
                                  'Material and custom '
                                  'colored app bar themes in light and '
                                  'dark mode. Dark theme mode also '
                                  'support an even '
                                  'darker mode, called true black.\n'
                                  '\n'
                                  'You can blend primary color into '
                                  'surface colors '
                                  'with different strengths, to '
                                  'create color '
                                  'branded light and dark themes.\n',
                            ),
                          ],
                        ),
                      ),
                      introBottom: const Text(
                        'FlexColorScheme comes with 32 built-in '
                        'themes to get you started with theming '
                        'your app.\n\n'
                        'This demo uses the newer Flutter Material 2018 '
                        'typography, which creates a slightly different '
                        'look compared to the older 2014 standard, used '
                        'by default in Flutter.',
                      ),
                      imageAssets: AppImages.route[ThemePage.route]!.toList(),
                    ),
                  ),
                  const SizedBox(height: Sizes.m),
                  const Divider(),
                  //
                  // Heading for Theme Options
                  //
                  const SizedBox(height: Sizes.m),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
                    child: Text(
                      'Theme Options',
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.l),
                    child: Text(
                      'Try some FlexColorScheme built-in theme style '
                      'options.',
                    ),
                  ),
                  const SizedBox(height: Sizes.m),
                  // Settings for the theme, wrapped in a Card on Desktop
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: Sizes.m),
                      // Select app bar theme style.
                      const ListTile(
                        title: Text('Choose AppBar theme'),
                        subtitle: Text(
                          'Material design uses a primary colored '
                          'AppBar in light mode and a background '
                          'colored one in dark mode. With '
                          'FlexColorScheme you can use different '
                          'defaults for the AppBar and select if it '
                          'should use primary, default surface, '
                          'primary branded surface or a custom color. '
                          'This demo uses secondary variant color as '
                          'the custom, but it could be any color.',
                        ),
                      ),
                      const SizedBox(height: Sizes.s),
                      // App bar theme has different stored settings
                      // and defaults for light and dark theme mode.
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: Sizes.l),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            if (isLight)
                              const LightAppBarSwitch()
                            else
                              const DarkAppBarSwitch(),
                          ],
                        ),
                      ),
                      const SizedBox(height: Sizes.m),
                      // Tab bar theme segment control
                      const ListTile(
                        title: Text('Choose TabBar theme'),
                        subtitle: Text(
                          'Use a theme that works with where you '
                          'intend to use the TabBar. This demo uses '
                          'and needs Background style.',
                        ),
                      ),
                      const SizedBox(height: Sizes.s),
                      // AppBar style
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.l,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[TabBarStyleSwitch()],
                        ),
                      ),
                      const SizedBox(height: Sizes.m),
                      // Select tooltip style.
                      const TooltipStyleSwitch(),
                      // Select color scheme surface style.
                      const ListTile(
                        title: Text('Branded surface and background'),
                        subtitle: Text(
                          'Material design uses white and plain dark '
                          'surface colors. With the light, medium, '
                          'heavy and strong branding, you can blend '
                          'primary color into surface and background '
                          'colors with increasing strength. Use custom '
                          'to define surface colors manually.',
                        ),
                      ),
                      const SizedBox(height: Sizes.s),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.l),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SurfaceStyleSwitch(),
                          ],
                        ),
                      ),
                      // Copy surface colors to custom theme.
                      const ListTile(
                        title: Text('Copy current surface to '
                            'custom surface'),
                        subtitle: Text(
                          'The active scheme background, surface and '
                          'scaffold background colors will be copied '
                          'to the custom scheme surface colors.',
                        ),
                        trailing: CopySurfaceToCustom(),
                      ),
                      const SizedBox(height: Sizes.m),
                      // The Used colors in the ColorScheme selection
                      const ListTile(
                        title: Text('Select used ColorScheme colors'),
                        subtitle: Text(
                          'With Flutter ColorScheme you must define '
                          'all four main ColorScheme colors for both '
                          'light and dark theme. With '
                          'FlexColorScheme you can make a complete '
                          'ColorScheme with less or even just one '
                          'specified color. Unspecified colors are '
                          'then derived from specified ones.',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.l),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            EnabledColorsSwitch(),
                          ],
                        ),
                      ),
                      const SizedBox(height: Sizes.m),
                      // Copy the theme to the custom theme, to use it
                      const ListTile(
                        title: Text('Copy current color scheme to custom '
                            'scheme'),
                        subtitle: Text(
                          'Copy active color scheme to the custom '
                          'scheme and use it as a starting point for '
                          'your custom color scheme.',
                        ),
                        trailing: CopySchemeToCustom(),
                      ),
                      // Computed dark theme
                    ],
                  ),
                  const SizedBox(height: Sizes.m),
                  const Divider(),
                  //
                  // Heading for Theme mode schemes
                  //
                  const SizedBox(height: Sizes.m),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
                    child: Text('Theme Mode',
                        style: theme.textTheme.headlineSmall),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.l),
                    child: Text(
                      'Choose light or dark theme or system mode based '
                      'theme. You can also use a true black dark  '
                      'theme. Dark mode may optionally instead of '
                      'using pre-defined colors be computed from the '
                      'light theme mode colors.',
                    ),
                  ),
                  const SizedBox(height: Sizes.m),
                  // Theme mode selector, light, dark and system
                  const Padding(
                    padding: EdgeInsetsDirectional.only(end: Sizes.l),
                    child: ThemeModeSwitch(),
                  ),
                  const SizedBox(height: Sizes.m),
                  // Hiding the extra "Dark" options in light mode.
                  AnimatedSwitchShowHide(
                    show: !isLight,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: Sizes.m),
                        const ComputeDarkThemeSwitch(),
                        AnimatedSwitchShowHide(
                          show: ref.watch(useToDarkMethodPod) ||
                              ref.watch(schemeIndexPod) == 2,
                          child: const DarkLevelSlider(),
                        ),
                      ],
                    ),
                  ),
                  if (isLight)
                    const LightColorsSwapSwitch()
                  else
                    const DarkColorsSwapSwitch(),
                  const Divider(),
                  Wrap(
                    children: <Widget>[
                      Logo(
                        side: 150,
                        foregroundColor: scheme.primary,
                        backgroundColor: scheme.secondary,
                      ),
                      Logo(
                        side: 150,
                        foregroundColor: scheme.secondary,
                        backgroundColor: scheme.primary,
                      ),
                      Logo(
                        side: 150,
                        foregroundColor: theme.primaryColorLight,
                        backgroundColor: scheme.secondaryContainer,
                      ),
                      Logo(
                        side: 150,
                        foregroundColor: scheme.secondaryContainer,
                        backgroundColor: theme.primaryColorDark,
                      ),
                      Logo(
                        side: 150,
                        foregroundColor: scheme.primaryContainer,
                        backgroundColor: theme.primaryColorDark,
                      ),
                    ],
                  ),

                  const Divider(),
                  //
                  // Heading for Color scheme selection
                  //
                  const SizedBox(height: Sizes.m),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
                    child: Text('Choose Color Scheme',
                        style: theme.textTheme.headlineSmall),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.l),
                    child: Text(
                      'Use built in pre-defined ColorSchemes for your '
                      'themes. Copy and modify existing ones with '
                      'custom color scheme selection, or use prominent '
                      'colors extracted from images with the image '
                      'based color scheme selection.',
                    ),
                  ),

                  const ListTile(title: Text('Choose color scheme')),
                  const ThemeSelector(),
                  const ThemePopupMenu(),
                  const SizedBox(height: Sizes.m),
                  ListTile(
                    title: const Text('Image based ColorScheme'),
                    subtitle: ref.watch(schemeIndexPod) == 2
                        ? Text('Select image below. Tap again for '
                            'alternative scheme mix: '
                            '${ref.watch(imgUsedMixPod)}/8')
                        : const Text('Enabled when "Image based" scheme is '
                            'selected above (3rd option)'),
                  ),
                  const ImageSelector(),
                  const Divider(),
                  //
                  // Heading for Color scheme indicators
                  //
                  const SizedBox(height: Sizes.m),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
                    child: Text('ColorScheme',
                        style: theme.textTheme.headlineSmall),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.l),
                    child: Text(
                      'Selected color scheme is shown below. '
                      'With custom color scheme you can changed '
                      'enabled colors below. You can also modify '
                      'errorColor and select AppBar theme color '
                      'independently of the primaryColor. Custom '
                      'surface enables color selection of background, '
                      'surface and scaffoldBackground colors. The '
                      'onColors are always computed in this demo, but '
                      'FlexColorScheme API allows you to define them '
                      'as well.',
                    ),
                  ),
                ],
              ),
            ),
          ),
          //
          // Next we show the currently defined input ColorScheme.
          // Its widget will build a silver grid inside the custom
          // scroll view. You can also do it with a normal GridView
          // inside the above 'SliverChildListDelegate'. However,
          // then you must use shrinkWrap:true, which is inefficient
          // and with the responsive grid builder it sometimes creates
          // a small rounding gap making the grid view scroll within
          // in the list view, it just moves enough to create glow on
          // Android, it does not really move anywhere. This will then
          // prevent scrolling the overall view when you try
          // to scroll by touching items in the grid, because they
          // are trying to scroll within their own scroll region in the
          // overall list. By putting it all in slivers in the same
          // custom scroll view, we avoid this and also the performance
          // hit from a shrinkWrap.
          // ThemeColorScheme(breakpoint: breakpoint),
          const ThemeColorScheme(),
          //
          // Heading for Theme result
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                const SizedBox(height: Sizes.m),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
                  child:
                      Text('ThemeData', style: theme.textTheme.headlineSmall),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.l),
                  child: Text(
                    'Created ThemeData colors based on the ColorScheme '
                    'is shown below. '
                    'Color name and shade value is shown for Material '
                    'colors. A list of over 1600 color names is also '
                    'used to match colors to the closest color name on '
                    'the list. As you change color theme, the colors '
                    'and their names animate to their new values.',
                  ),
                ),
              ],
            ),
          ),
          //
          // Show the resulting theme colors
          // Again in a sliver grid.
          // ThemeColors(breakpoint: breakpoint),
          const ThemeColors(),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                //
                // TODO(rydmike): Make export theme feature.
                const SizedBox(height: Sizes.m),
                // const ListTile(
                //   title: Text('Export theme'),
                //   subtitle: Text(
                //     'Export the FlexColorScheme theme definition. '
                //     'You can copy paste the exported theme into your '
                //     'app.\n'
                //     'THIS FEATURE WILL BE ADDED LATER.',
                //   ),
                //   trailing: OutlineButton(
                //     onPressed: null,
                //     child: Text('Export theme'),
                //   ),
                // ),
                const Divider(),
                //
                // Theme showcase and custom color selection explanation
                const SizedBox(height: Sizes.m),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.l),
                  child: Text('Theme Showcase',
                      style: theme.textTheme.headlineSmall),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.l),
                  child:
                      Text('Common Material UI widgets using selected theme.'),
                ),
                //
                // Show how Material widgets look with the theme
                //
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.m),
                  child: ThemeShowcase(),
                ),
                SizedBox(height: Sizes.l + bottomPadding),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
