import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/app_navigation_state.dart';
import '../../navigation/app_routes.dart';
import '../../navigation/destinations.dart';
import '../../pods/pods_navigation.dart';
import '../../utils/app_images.dart';
import '../../utils/app_insets.dart';
import '../../utils/app_strings.dart';
import '../../widgets/headers/page_header.dart';
import '../../widgets/headers/page_intro.dart';
import '../../widgets/text/link_text_span.dart';
import '../page_body.dart';
import 'about_dialog.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});
  static const String route = AppRoutes.about;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppNavigation appNav = ref.watch(navigationPod);

    // Get the current destination details, we will use it's info in the
    // page header to display info on how we navigated to this page.
    final FlexfoldDestinationData destination = appNav.useModalDestination
        ? appNav.modalDestination
        : appNav.destination;

    // TODO(rydmike): Remove me totally
    // debugPrint('Destination: $destination');

    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = appDestinations[destination.menuIndex].selectedIcon;
    final Widget heading = Text(appDestinations[destination.menuIndex].label);

    final ThemeData themeData = Theme.of(context);
    final TextStyle linkStyle = themeData.textTheme.bodyText1!.copyWith(
        color: themeData.colorScheme.primary, fontWeight: FontWeight.bold);

    // // In case we are showing the screen as modal screen it will then be
    // // shown by the root navigator that does not have our custom directionality
    // // wrapper above it in the tree, so we just add it once more.
    // return Directionality(
    //   textDirection: appTextDirection(context, ref),
    //   child: Scaffold(
    //     // key: const PageStorageKey<String>(route),
    //
    //     // If a main destination is being displayed as a modal route, we add an
    //     // app bar, with same style as rest of app, with an implicit back button
    //     // that it will get since it was pushed on top of a base route.
    //     appBar: destination.useModal && ref.watch(useModalRoutesPod)
    //         ? FlexAppBar.styled(
    //             context,
    //             title: Text(appDestinations[destination.menuIndex].label),
    //             gradient: ref.watch(appBarGradientPod),
    //             blurred: ref.watch(appBarBlurPod),
    //             opacity: ref.watch(appBarTransparentPod)
    //                 ? ref.watch(appBarOpacityPod)
    //                 : 1.0,
    //             hasBorderOnSurface: ref.watch(appBarBorderOnSurfacePod),
    //             hasBorder: ref.watch(appBarBorderPod),
    //             showScreenSize: ref.watch(appBarShowScreenSizePod),
    //           ).toAppBar()
    //         // No app bar, the scaffold is being shown inside the layout screen
    //         : null,
    //     extendBody: ref.watch(extendBodyPod),
    //     extendBodyBehindAppBar: ref.watch(extendBodyBehindAppBarPod),
    //
    //     // If the body part is not shown as only a body in another Scaffold
    //     // we need an extra builder here to get the right top and bottom padding
    //     // values if we are extending body and/or extending body behind app bar.
    //     body: Builder(
    //       builder: (BuildContext context) {
    //         // See settings_screen.dart for an explanation of these
    //         // padding values and why they are VERY handy and useful.
    //
    //

    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return PageBody(
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          AppInsets.l,
          AppInsets.l + topPadding,
          AppInsets.l,
          AppInsets.l + bottomPadding,
        ),
        children: <Widget>[
          PageHeader(icon: icon, heading: heading, destination: destination),
          const Divider(),
          PageIntro(
            introTop: Text.rich(
              TextSpan(
                text: "This application's main purpose is to "
                    'demonstrate the Flexfold responsive scaffold '
                    'package and its core features.\n'
                    '\n'
                    'As one extra feature it also shows Flutter '
                    'application theming with ',
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
                    text: '. You can also use the theming feature '
                        'to design and test application themes based '
                        'on FlexColorScheme. Additionally the ',
                  ),
                  LinkTextSpan(
                    style: linkStyle,
                    uri: Uri(
                      scheme: 'https',
                      host: 'pub.dev',
                      path: 'packages/flex_color_picker',
                    ),
                    text: 'FlexColorPicker',
                  ),
                  const TextSpan(
                    text: ' is used to select colors '
                        'for custom theming on the Theme page. \n'
                        '\n'
                        'The used illustrations are courtesy of ',
                  ),
                  LinkTextSpan(
                    style: linkStyle,
                    uri: Uri(
                      scheme: 'https',
                      host: 'undraw.co',
                    ),
                    text: 'unDraw',
                  ),
                  const TextSpan(
                    text: '. In this demo the unDraw images are stored '
                        'as SVG assets delivered with the app and they '
                        'are color theme matched by adjusting a color '
                        'string in the SVG file. An animated switcher '
                        'widget and timer is used to change the '
                        'loosely topic related images on each page.\n',
                  ),
                ],
              ),
            ),
            introBottom: const Text(
              'Full responsive layout of the content body in this app '
              'is not part of the Flexfold demo and has not been paid '
              'too much attention to, but it has been verified to work '
              'well enough from normal phone sizes to large web and '
              'desktop canvas sizes. The content presentation is '
              'however not always optimally designed for phones, '
              'mostly because it contains a lot of text and '
              'explanations.',
            ),
            imageAssets: AppImages.route[route]!.toList(),
          ),
          const SizedBox(height: 20),
          Center(
            child: OutlinedButton(
              onPressed: () {
                showAppAboutDialog(context);
              },
              child: const Text('About Flexfold demo...'),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text('Version: ${AppStrings.version}\n',
                style: Theme.of(context).textTheme.subtitle1),
          ),
          Center(
            child: Text('${AppStrings.flutter}\n',
                style: Theme.of(context).textTheme.subtitle1),
          ),
          Center(
            child: Text('This is a pre-release feature demo!',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)),
          ),
          Center(
            child: Text(
                'Flexfold is not '
                'yet available on pub.dev',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)),
          ),
          Center(
            child: Text('Coming soon...',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    //       },
    //     ),
    //   ),
    // );
  }
}
