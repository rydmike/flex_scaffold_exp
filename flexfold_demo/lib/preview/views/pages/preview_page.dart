import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/const/app_images.dart';
import '../../../app/const/app_insets.dart';
import '../../../core/utils/hide_bottom_on_scroll.dart';
import '../../../core/utils/link_text_span.dart';
import '../../../core/views/widgets/app/headers/page_header.dart';
import '../../../core/views/widgets/app/headers/page_intro.dart';
import '../../../core/views/widgets/universal/page_body.dart';
import '../../../navigation/constants/app_routes.dart';
import '../../../navigation/constants/destinations.dart';
import '../../../navigation/controllers/current_route_provider.dart';
import '../../../navigation/models/app_navigation_state.dart';
import '../../controller/device_provider.dart';

class PreviewPage extends ConsumerStatefulWidget {
  const PreviewPage({super.key});
  static const String route = AppRoutes.preview;

  @override
  ConsumerState<PreviewPage> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends ConsumerState<PreviewPage> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0,
      debugLabel: 'PreviewScreenScrollController',
    );
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
    // TODO(rydmike): If this works, put it else where as rad too
    final CurrentRoute appNav = ref.read(currentRouteProvider);

    // Get the current destination details, we will use it's info in the
    // page header to display info on how we navigated to this page.
    final FlexDestinationTarget destination =
        appNav.usePush ? appNav.pushedDestination : appNav.destination;
    // We also use the current destination to find the destination
    // icon and label for the destination, we use them in the page header
    // as well to show the icon and label of the destination on the page.
    final Widget icon = appDestinations[destination.index].selectedIcon;
    final Widget heading = Text(appDestinations[destination.index].label);

    final ThemeData themeData = Theme.of(context);
    final TextStyle linkStyle = themeData.textTheme.bodyText1!.copyWith(
        color: themeData.colorScheme.primary, fontWeight: FontWeight.bold);

    // See settings_page.dart for an explanation of these
    // padding values and why they are VERY handy and useful.
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    // In case we are showing the screen as modal screen it will then be
    // shown by the root navigator that does not have our custom directionality
    // wrapper above it in the tree, so we just add it once more.
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
                text: 'You can enable a feature called DevicePreview '
                    'in this demo. '
                    'When enabled, it wraps the entire '
                    'application in a frame that simulate how the '
                    'application looks when used on different '
                    'mobile devices, even if it is still running in '
                    'a Web browser or as a desktop app.\n'
                    '\n'
                    'You can use the DevicePreview as a way to test '
                    'and verify how your Flexfold settings look, work '
                    'and impact navigation on different devices.\n\n',
                children: <InlineSpan>[
                  LinkTextSpan(
                    text: 'DevicePreview',
                    style: linkStyle,
                    uri: Uri(
                      scheme: 'https',
                      host: 'pub.dev',
                      path: 'packages/device_preview',
                    ),
                  ),
                  const TextSpan(
                      text: ' is a Flutter package '
                          'made by '),
                  LinkTextSpan(
                    text: 'Aloïs Deniel',
                    style: linkStyle,
                    uri: Uri(
                      scheme: 'https',
                      host: 'twitter.com',
                      path: 'aloisdeniel',
                    ),
                  ),
                ],
              ),
            ),
            introBottom: const Text(
              'Below you can enable DevicePreview on demand at '
              'runtime, just select device preview below and give '
              'it a try.',
            ),
            imageAssets: AppImages.route[PreviewPage.route]!.toList(),
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(
                flex: 20,
                child: SelectPreview(
                  header: 'Native view',
                  selected: !ref.watch(useDevicePreviewProvider),
                  onSelect: () {
                    ref.read(useDevicePreviewProvider.notifier).state = false;
                    // ref
                    //     .read(navigationPod.notifier)
                    //     .useModalDestination(false);
                    // TODO(rydmike): Where to go?
                    // context.go(AppRoutes.root);
                  },
                  image: const AssetImage(AppImages.noDevice),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 20,
                child: SelectPreview(
                  header: 'Device preview',
                  selected: ref.watch(useDevicePreviewProvider),
                  onSelect: () {
                    ref.read(useDevicePreviewProvider.notifier).state = true;
                  },
                  image: const AssetImage(AppImages.asDevice),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Setting up DevicePreview in a Flutter app is simple. '
            'The "main.dart" code '
            'snippet below from this application, '
            'show one example of how enabling it from within the app '
            'can be done when using Riverpod '
            'and HookWidget. It is very simple and it looks quite '
            'elegant. Clicking on the images above just toggles the '
            'state of the StateProvider useDevicePreviewProvider.\n'
            '\n'
            'DevicePreview comes with its own built in ON/OFF toggle '
            'too, but it leaves an always visible row at the bottom '
            'of the app, where you can see and use the toggle switch '
            'at all times. This is fine and even convenient for dev '
            'and test mode, but in app you may also '
            'to hide it totally when it is not being used.\n'
            '\n'
            'The implementation below uses the above fancy in app '
            'image toggle instead to completely disable and remove '
            'the DevicePreview when it is not used.\n',
            style: themeData.textTheme.bodyText1,
          ),
          const MainDartExample(),
        ],
      ),
    );
  }
}

class SelectPreview extends StatelessWidget {
  const SelectPreview({
    super.key,
    required this.header,
    this.selected = false,
    required this.onSelect,
    required this.image,
  });

  final String header;
  final bool selected;
  final VoidCallback onSelect;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      // Using a border proportional to image size, looks nice in this case.
      final double borderWidth = constraints.maxWidth * 0.03;
      final double borderRadius = constraints.maxWidth * 0.05;
      return Material(
        elevation: 0.5,
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: selected
                ? Theme.of(context).primaryColor.withOpacity(0.8)
                : Theme.of(context).dividerColor,
            width: borderWidth,
            style: BorderStyle.solid,
          ),
        ),
        child: InkWell(
            splashColor: Theme.of(context).primaryColor.withOpacity(0.15),
            highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
            hoverColor: Theme.of(context).primaryColor.withOpacity(0.1),
            onTap: onSelect,
            child: Stack(children: <Widget>[
              Ink.image(
                  image: image,
                  width: constraints.maxWidth,
                  height: constraints.maxWidth,
                  fit: BoxFit.contain),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: GridTileBar(
                  title: Text(
                    header,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                  ),
                  backgroundColor: Colors.black.withOpacity(0.6),
                ),
                // GridTile(),
              ),
            ])),
      );
    });
  }
}

class MainDartExample extends StatelessWidget {
  const MainDartExample({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double borderWidth = constraints.maxWidth * 0.03 / 2;
      final double borderRadius = constraints.maxWidth * 0.05 / 2;
      return Material(
        elevation: 0.5,
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: Theme.of(context).dividerColor,
            width: borderWidth,
            style: BorderStyle.solid,
          ),
        ),
        child: Image.asset(AppImages.mainDart),
      );
    });
  }
}
