import 'package:flexfold/flexfold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/const/app_images.dart';
import '../../../app/const/app_insets.dart';
import '../../../app/const/app_strings.dart';
import '../../../core/utils/link_text_span.dart';
import '../../../core/views/widgets/app/headers/page_header.dart';
import '../../../core/views/widgets/app/headers/page_intro.dart';
import '../../../core/views/widgets/universal/page_body.dart';
import '../../../navigation/constants/routes.dart';
import '../../../navigation/controllers/current_route_provider.dart';
import '../../../navigation/models/app_navigation_state.dart';
import '../widgets/about_dialog.dart';

const bool _kDebugMe = kDebugMode && true;

class AboutPage extends ConsumerStatefulWidget {
  const AboutPage({super.key});
  static const String route = Routes.about;

  @override
  ConsumerState<AboutPage> createState() => _AboutScreenState();
}

class _AboutScreenState extends ConsumerState<AboutPage> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0,
      debugLabel: 'AboutScreenScrollController',
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
    final FlexTarget destination =
        appNav.usePush ? appNav.pushedDestination : appNav.destination;
    if (_kDebugMe) {
      debugPrint('AboutScreen: Destination = $destination');
    }
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = destination.selectedIcon;
    final Widget heading = Text(destination.label);

    final ThemeData themeData = Theme.of(context);
    final TextStyle linkStyle = themeData.textTheme.bodyText1!.copyWith(
        color: themeData.colorScheme.primary, fontWeight: FontWeight.bold);
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return PageBody(
      controller: scrollController,
      child: ListView(
        primary: false,
        controller: scrollController,
        padding: EdgeInsets.fromLTRB(
          Sizes.l,
          Sizes.l + topPadding,
          Sizes.l,
          Sizes.l + bottomPadding,
        ),
        children: <Widget>[
          PageHeader(icon: icon, heading: heading, destination: destination),
          const Divider(),
          PageIntro(
            introTop: Text.rich(
              TextSpan(
                text: "This application's main purpose is to "
                    'demonstrate the FlexScaffold responsive scaffold '
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
              'is not part of the FlexScaffold demo and has not been paid '
              'too much attention to, but it has been verified to work '
              'well enough from normal phone sizes to large web and '
              'desktop canvas sizes. The content presentation is '
              'however not always optimally designed for phones, '
              'mostly because it contains a lot of text and '
              'explanations.',
            ),
            imageAssets: AppImages.route[AboutPage.route]!.toList(),
          ),
          const SizedBox(height: 20),
          Center(
            child: OutlinedButton(
              onPressed: () {
                showAppAboutDialog(context);
              },
              child: const Text('About FlexScaffold demo...'),
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
                'FlexScaffold is not '
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
  }
}
