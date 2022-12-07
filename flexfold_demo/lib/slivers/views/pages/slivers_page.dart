import 'dart:math';

import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/const/app_images.dart';
import '../../../app/const/app_insets.dart';
import '../../../core/utils/breakpoint.dart';
import '../../../core/utils/hide_bottom_on_scroll.dart';
import '../../../core/utils/random_color.dart';
import '../../../core/views/widgets/app/headers/page_header.dart';
import '../../../core/views/widgets/app/headers/page_intro.dart';
import '../../../core/views/widgets/app/svg/svg_asset_image_switcher.dart';
import '../../../navigation/constants/app_routes.dart';
import '../../../navigation/constants/destinations.dart';
import '../../../navigation/controllers/current_route_provider.dart';
import '../../../navigation/models/app_navigation_state.dart';
import '../../../settings/controllers/pods_flexfold.dart';
import '../../../settings/views/widgets/other_settings/sidebar_belongs_to_body_switch.dart';
import '../../../settings/views/widgets/visibility/hide_bottom_bar_on_scroll_switch.dart';
import '../../../settings/views/widgets/visibility/show_bottom_bar_when_menu_shown_switch.dart';
import '../widgets/sliver_app_bar_demo.dart';

class SliversPage extends ConsumerStatefulWidget {
  const SliversPage({super.key});

  static const String route = AppRoutes.slivers;

  @override
  ConsumerState<SliversPage> createState() => _SliversScreenState();
}

class _SliversScreenState extends ConsumerState<SliversPage> {
  late ScrollController scrollController;

  // Image holder
  final int maxTiles = 500;
  late Random randomImage;
  late List<ImageData> pageImages;

  @override
  void initState() {
    super.initState();

    randomImage = Random();
    // Generate a random image data list that we will build widgets from.
    // We generate this data list in the stateful widget's init class because
    // we want it to remain static as long as the page is not rebuilt.
    // We will get a new random colored image list, but only every time
    // we visit the screen, not as we scroll it back and forth or rescale it,
    // that could be done too, but it feels a bit too random.
    pageImages = List<ImageData>.generate(
      maxTiles,
      (int index) {
        // Get a random image index to one of the images in the all images list
        final int randomIndex = randomImage.nextInt(AppImages.allImages.length);
        // Get the asset path for this index, just for easy access
        final String assetName = AppImages.allImages[randomIndex];
        // Make a random colored SVG image
        return ImageData(
          // Store the index to this random image so we can get from our assets
          assetName: assetName,
          // Make a title from asset path
          title: '#${index + 1} '
              '${assetName.substring(14, assetName.length - 4)}',
          // Random color for the light theme
          color: RandomColor().randomMaterialColor(),
        );
      },
    );
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
    final CurrentRoute appNav = ref.watch(currentRouteProvider);

    // Get the current destination details, we will use it's info in the
    // page header to display info on how we navigated to this page.
    final FlexDestinationTarget destination = appNav.destination;
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = appDestinations[destination.index].selectedIcon;
    final Widget heading = Text(appDestinations[destination.index].label);
    // See setup_screen.dart [ConfigScreen] for an explanation of these
    // padding values and why they are VERY handy and useful.
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return BreakpointBuilder(
      // Using the custom large breakpoint type, it will give us from 1 to 24
      // columns, starting with one on a watch and going uå to 24 on a
      // 4k screen. The breakpoint type material gives us Material
      // standard breakpoint, its breakpoints are not so useful on larger
      // than 1024dp wide media.
      type: BreakType.large,
      // A column interval of 1 would gives us the column count the
      // breakpoint provides, often the content is to wide to fit in such a
      // small column. We can the use columnInterval, eg 2 or 3, which will
      // only return half or a 3rd of the available columns at any given current
      // width.
      columnInterval: 3,
      // In this example we are not using that API, instead we use its
      // alternative way to return columns from a Breakpoint, by telling it what
      // the minimum column width is. As soon as another column of the
      // minimum width will fit, we get one more column returned. This
      // method increases amount of columns proportionally to the width.
      // The columnInterval property uses hand tuned breakpoints and counts
      // that will reduce the amount columns used in proportion to the
      // screen width, which often looks better. If you try this code you
      // can comment the line below and uncomment the columnInterval row,
      // to test the difference. You can use both properties at the same
      // time, if you do, then the method that has the lower column count
      // will be the value returned.
      // With minColumnSize, if the column space is lower than the min
      // value, one column will still be returned and content
      // will fill this width.
      // minColumnSize: 280,
      builder: (BuildContext context, Breakpoint breakpoint) {
        return Scrollbar(
          controller: scrollController,
          key: ValueKey<String>(destination.route),
          // key: const PageStorageKey<String>(SliversScreen.route),
          child: CustomScrollView(
            primary: false,
            key: ValueKey<String>(destination.route),
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              const SliverAppBarDemo(),
              SliverPadding(
                padding: EdgeInsetsDirectional.fromSTEB(breakpoint.gutters,
                    Sizes.l + topPadding, breakpoint.gutters, 0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      // We need to add back the padding we removed by
                      // allowing scrolling under the toolbar
                      PageHeader(
                          icon: icon,
                          heading: heading,
                          destination: destination),
                      const Divider(),
                      PageIntro(
                        introTop: Text(
                          'This page demonstrates how Flexfold can be '
                          'used with slivers and a sliver app bar. '
                          'A sliver app bar that stretches down is used and '
                          'the entire page content is a custom scroll view '
                          'with slivers.\n'
                          '\n'
                          'The content on all the other pages in this demo '
                          'app uses a web like '
                          'layout that constrains the width to a given maximum '
                          'width'
                          '(${Sizes.maxBodyWidth.toStringAsFixed(0)}dp '
                          'in this demo) and just adds '
                          'larger white space margins around the content after '
                          'that. In this screen the content width is not '
                          'constrained, it will widen as you increase the '
                          'width. '
                          'As you do so, the number of images per row will '
                          'also increase in steps. This is made with a '
                          'LayoutBuilder using the width and different '
                          'breakpoints '
                          'for more columns on a wider canvas.\n'
                          '\n'
                          'Hiding the bottom bar on scroll down is done with a '
                          'scroll controller listener and we just set '
                          "Flexfold's "
                          'scrollHiddenBottomBar to false when we '
                          'scroll down and back to true when we scroll up. '
                          'This causes the bottom bar to animate away '
                          'when we scroll down and back in on up. '
                          'Obviously you have to change to a screen size '
                          'where the bottom navigation is visible to see this. '
                          'Alternatively you can use the switch further below '
                          'and turn ON the "Always show bottom navigation bar" '
                          'switch to see this on larger screens too. '
                          'If you have '
                          'completely hidden the bottom navigation bar '
                          'you will '
                          'not find this control, go back to Settings screen '
                          'to enable it again.\n',
                        ),
                        introBottom: const Text(
                          'For the page content layout, there is a Breakpoint '
                          'class used to get suitable amount of '
                          'columns for the grid images. It can be used to '
                          'create different grid layouts all the way up to 4k '
                          'widths. This screen is a nice stress test '
                          'on a large '
                          'canvas. If you maximize the screen on a 4K display '
                          'and toggle the menu, the menu animation will cause '
                          'all the SVG images on the screen to be rescaled '
                          'and redrawn in every frame as the menu animates. '
                          'It is a good stress test of Flutter and it '
                          'actually works very well, much better than '
                          'resizing windows in Flutter does. Window resizing '
                          'and resulting redraws still need improvements in '
                          'Flutter.\n'
                          '\n'
                          'The Undraw images bundled with the app are used as '
                          'demo content in the grid. '
                          'Each image box that randomly display one of the '
                          'images, has its own random wait duration before it '
                          'switches, they also have a random switch animation '
                          'time. Each image box gets a '
                          'random colored border box, a less saturated '
                          'version of '
                          'the color is calculated for dark mode. Thus when '
                          'you switch to dark mode, it still has the same '
                          'color hue based on the '
                          "light theme's random color. "
                          'If you toggle the theme '
                          'using the side menu toggle, you can see the '
                          'difference. A nice detail is that each image is '
                          'using its border color as a color '
                          'theme of the image.\n'
                          '\n'
                          'There are only 30 different images that are '
                          'switched in randomly to each position in the grid. '
                          'This demo list stops at 500 items in the grid. '
                          'As such the page is not very useful, '
                          "but it's a nice looking "
                          'Flutter stress test, especially on the web.\n'
                          '\n'
                          'With this page you can also test and '
                          'see how Slivers '
                          'work when the sidebar is a part of Scaffold body or '
                          'outside it. It has bigger visual impact when '
                          'a bottom navigation bar is used on a large canvas '
                          'layout. Here we can use the toggle to always '
                          'show the bottom navigation bar to see '
                          'the difference. '
                          'The setting that shows the bottom bar when the '
                          'menu is manually hidden and sidebar remains pinned '
                          'visible, is probably a more real use case for '
                          'when the bottom navigation bar would be used '
                          'on a large canvas.\n',
                        ),
                        imageAssets:
                            AppImages.route[SliversPage.route]!.toList(),
                      ),
                      const SidebarBelongsToBodySwitch(),
                      if (!ref.watch(hideBottomBarPod))
                        const SizedBox(height: Sizes.l / 2),
                      if (!ref.watch(hideBottomBarPod))
                        const ShowBottomBarWhenMenuShownSwitch(),
                      if (!ref.watch(hideBottomBarPod))
                        const SizedBox(height: Sizes.l / 2),
                      if (!ref.watch(hideBottomBarPod))
                        const HideBottomBarOnScrollSwitch(),

                      const Divider(),
                      const SizedBox(height: Sizes.l / 2),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: breakpoint.gutters),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: breakpoint.columns,
                    mainAxisSpacing: breakpoint.gutters,
                    crossAxisSpacing: breakpoint.gutters,
                    childAspectRatio: 1.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext ctx, int index) {
                      return LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints size) {
                        return ImageWidget(
                          item: pageImages[index],
                          // We use width proportional border radius and
                          // border width around the widget, then it always
                          // scales and don't look out of proportion as the
                          // size grows/shrinks
                          borderRadius: size.maxWidth / 30,
                          borderWidth: size.maxHeight / 45,
                        );
                      });
                    },
                    childCount: pageImages.length,
                  ),
                ),
              ),
              // This sliver and the vertical space is added so that
              // we can scroll up higher than any toolbar at the bottom,
              // if there is one
              SliverPadding(
                padding:
                    EdgeInsets.only(bottom: breakpoint.gutters + bottomPadding),
              ),
            ],
          ),
        );
      },
    );
  }
}

// A small data holder to put in a list where we can store assetName a ready
// made string title and the color it should have in light and dark theme mode.
class ImageData {
  const ImageData({
    required this.assetName,
    required this.title,
    required this.color,
  });

  final String assetName;
  final String title;
  final MaterialColor color;
}

/// A class used to from [ImageData] construct and return an [ImageWidget]
/// that we display on this page in a grid layout.
///
/// The image widget has a border width and border radius property.
class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.item,
    this.borderRadius = 10.0,
    this.borderWidth = 10.0,
  });

  final ImageData item;
  final double borderRadius;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: isLight
              ? item.color[300]!.withAlpha(0x33)
              : item.color[50]!.withAlpha(0xAA),
          border: Border.all(
            width: borderWidth,
            color: isLight ? item.color[700]! : item.color[400]!,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(
              item.title,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
            Flexible(
              child: SvgAssetImageSwitcher(
                assetNames: AppImages.allImages,
                color: isLight ? item.color[700]! : item.color[400]!,
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                fit: BoxFit.contain,
                switchType: ImageSwitchType.random,
                showDuration:
                    Duration(milliseconds: 3000 + random.nextInt(2000)),
                switchDuration:
                    Duration(milliseconds: 200 + random.nextInt(250)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
