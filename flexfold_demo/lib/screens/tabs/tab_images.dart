import 'dart:math';

import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/app_navigation_state.dart';
import '../../navigation/app_routes.dart';
import '../../navigation/destinations.dart';
import '../../pods/pods_navigation.dart';
import '../../utils/app_images.dart';
import '../../utils/app_insets.dart';
import '../../utils/random_color.dart';
import '../../widgets/breakpoint/breakpoint.dart';
import '../../widgets/headers/page_header.dart';
import '../../widgets/headers/page_intro.dart';
import '../../widgets/svg/svg_asset_image_switcher.dart';
import '../hide_bottom_on_scroll.dart';
import '../page_body.dart';

// This tab screen is not using any of the view models, so it was left as a
// plain stateful widget instead of making it a HookWidget or
// StatefulHookWidget.
// Mostly to show how the scroll controller on and listener [hideBottomOnScroll]
// is used in such a case.
class TabImages extends ConsumerStatefulWidget {
  const TabImages({super.key});

  @override
  ConsumerState<TabImages> createState() => _TabImagesState();
}

class _TabImagesState extends ConsumerState<TabImages>
    with AutomaticKeepAliveClientMixin {
  late ScrollController scrollController;
  final int maxTiles = 500;
  late List<MaterialColor> imageColors;

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
    // Generate a random image color data list that we will build widgets from.
    // We generate this data list in the stateful widget's init class because
    // we want its colors to remain static as long as the page is not rebuilt.
    // So we will get a new random colored image list, but only every time
    // we rebuild the screen, not as we scroll it back and forth or rescale it,
    // that could be done too, but it feels a bit too random.
    imageColors = List<MaterialColor>.generate(
        maxTiles, (int index) => RandomColor().randomMaterialColor());
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
    // Get the current destination details, we will use it's info in the
    // page header to display info on how we navigated to this page.
    final FlexfoldDestinationData destination = appNav.destination;
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = appDestinations[destination.menuIndex].selectedIcon;
    final String heading = appDestinations[destination.menuIndex].label;

    return PageBody(
      // key: ValueKey<String>('${destination.route}${AppRoutes.tabsImages}'),
      controller: scrollController,
      child: BreakpointBuilder(
        type: BreakType.large,
        minColumnSize: 205,
        builder: (BuildContext context, Breakpoint breakpoint) {
          return CustomScrollView(
            // key:
            // ValueKey<String>('${destination.route}${AppRoutes.tabsImages}'),
            controller: scrollController,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsetsDirectional.only(
                    top: AppInsets.l, start: AppInsets.l, end: AppInsets.l),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      PageHeader(
                          icon: icon,
                          heading:
                              Text('$heading ${AppRoutes.tabsImagesLabel}'),
                          destination: destination),
                      const Divider(),
                      PageIntro(
                        introTop: const Text(
                          'Just because we can and for fun, let us show all '
                          'the beautiful Undraw SVG images used in this '
                          'demo app in a '
                          'grid and then randomly animate in a new one.\n'
                          '\n'
                          'Each image box that randomly display one of the '
                          'images has its own random wait duration before it '
                          'switches and also a random switch animation time.\n'
                          '\n'
                          'Each time the screen is built, each image box gets '
                          'a random colored border and a less saturated '
                          'version of it is calculated for dark mode. When you '
                          'switch to dark mode, it still has the same color '
                          "'hue based on the light theme's random color.\n"
                          '\n'
                          'Another feature is that every image is '
                          'color themed dynamically to match the color of its '
                          'border. This is done by changing a color text '
                          'string in the SVG file image data.\n',
                        ),
                        introBottom: const Text(
                          'This is not very useful feature as such, but a nice '
                          'looking and rather interesting stress '
                          'test for Flutter, especially for Web builds.\n'
                          '\n'
                          'We could make the grid of switching images '
                          'infinite, but this demo stops at 500 images in the '
                          'grid.\n',
                        ),
                        imageAssets: AppImages.route[AppRoutes.tabs]!.toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppInsets.l),
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
                        return RandomImageWidget(
                          imageColor: imageColors[index],
                          borderRadius: size.maxWidth / 25,
                          borderWidth: size.maxWidth / 45,
                        );
                      });
                    },
                    childCount: imageColors.length,
                  ),
                ),
              )
              //SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          );
        },
      ),
    );
  }
}

// Show a random image from the list of all the SVG images we have in our
// constant AppImages.allImages list.
// Not only will we randomly show an image from the list, the display time
// until we shift in a new image is randomized a bit as is the switch
// animation transition time.
// After a theme change the next shown random image will be themed in the color
// hue that is more suitable for the theme mode.
class RandomImageWidget extends StatelessWidget {
  const RandomImageWidget({
    super.key,
    required this.imageColor,
    this.borderRadius = 10.0,
    this.borderWidth = 10.0,
  });

  final MaterialColor imageColor;
  final double borderRadius;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final Random random = Random();

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
              ? imageColor[300]!.withAlpha(0x33)
              : imageColor[50]!.withAlpha(0xAA),
          border: Border.all(
              width: borderWidth,
              color: isLight ? imageColor[700]! : imageColor[400]!),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: SvgAssetImageSwitcher(
          assetNames: AppImages.allImages,
          color: isLight ? imageColor[700]! : imageColor[400]!,
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
          fit: BoxFit.contain,
          switchType: ImageSwitchType.random,
          showDuration: Duration(milliseconds: 2000 + random.nextInt(2000)),
          switchDuration: Duration(milliseconds: 200 + random.nextInt(250)),
        ),
      ),
    );
  }
}
