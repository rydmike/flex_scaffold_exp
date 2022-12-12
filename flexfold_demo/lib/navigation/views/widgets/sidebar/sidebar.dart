import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/const/app_images.dart';
import '../../../../core/controllers/app_controllers.dart';
import '../../../../core/views/widgets/app/if_wrapper.dart';
import '../../../../core/views/widgets/app/plasma_background.dart';
import '../../../../core/views/widgets/app/svg/svg_asset_image_switcher.dart';
import '../../../controllers/current_route_provider.dart';

/// A widget used as example content for the Flexfold demo sidebar.
class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current destination details, we use the info in the
    // page header to display info on how we navigated to this page.
    final GoFlexDestination destination =
        ref.watch(currentRouteProvider).destination;
    final String screenName = destination.label;

    final ScrollController controller = ScrollController();

    // We can remove the plasma animation from the widget tree with the
    // if wrapper by toggling a switch.
    return IfWrapper(
      condition: ref.watch(plasmaBackgroundProvider),
      builder: (BuildContext context, Widget child) =>
          PlasmaBackground(child: child),
      child: Scrollbar(
        controller: controller,
        child: ListView(
          primary: false,
          controller: controller,
          key: const PageStorageKey<String>('Sidebar'),
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Text(
              'Sidebar for ${screenName.toLowerCase()}',
              style: Theme.of(context).textTheme.headline5,
            ),
            const Text(
              '\nThe sidebar can be used to hold less used content in an '
              'application. It could be a search filter, a list of picked or '
              'selected items, maybe even usage instructions and guides.\n'
              '\n'
              'When you define Flexfold destinations, you can define which '
              'destinations should have a sidebar, every destination does not '
              'have to have one. In this demo app only the Settings, Theme, '
              'Tabs and Slivers destinations have a sidebar, the other pages '
              'do not have one.\n',
            ),
            const Text(
              'The sidebar can of course contain any kind of widget. This '
              'example share the same content on all pages that have a side '
              'sidebar, but of course you can show whatever you like, just '
              'make sure that it fits nicely in the available width.\n'
              '\n'
              'Just for fun, here are some themed faster switching random '
              'Undraw images.',
            ),
            SvgAssetImageSwitcher(
              assetNames: AppImages.allImages,
              color: Theme.of(context).colorScheme.primary,
              showDuration: const Duration(milliseconds: 5000),
              switchDuration: const Duration(milliseconds: 450),
              alignment: Alignment.center,
              height: 250,
              width: 250,
              padding: const EdgeInsets.all(20),
              fit: BoxFit.contain,
              switchType: ImageSwitchType.random,
            ),
            const Divider(),
            Text(
              '\nFloating action buttons',
              style: Theme.of(context).textTheme.headline6,
            ),
            const Text(
                '\nFlexfold destinations can also be configured to use FABs. '
                'FAB usage can be defined per destination.\n '),
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.account_circle),
            ),
            const Text(
              '\nThis demo app does not expose any settings for '
              'the FABs, but the pages Setup and Theme have been '
              'configured to have and show Floating action buttons.\n'
              '\n'
              'With the API the FAB position can also be defined for each '
              'navigation mode separately, so that the FAB shows up as '
              'expected on the bottom right in phone bottom navigation mode '
              'and on the top in tablet and desktop mode or wherever you '
              'want it to be in each mode.\n'
              '\n'
              'On the todo list is to add some pre-configured FAB locations '
              'that will also place the FAB on the edge of the rail or menu.',
            ),
          ],
        ),
      ),
    );
  }
}
