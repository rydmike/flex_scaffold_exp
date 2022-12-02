import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/app_navigation_state.dart';
import '../pods/pods_application.dart';
import '../pods/pods_flexfold.dart';
import '../pods/pods_navigation.dart';
import 'destinations.dart';

class AppBarWrapper extends ConsumerWidget {
  const AppBarWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppNavigation appNav = ref.watch(navigationPod);

    // Get the current destination details, we will use it's info in the
    // page header to display info on how we navigated to this page.
    final FlexfoldDestinationData destination = appNav.destination;

    // TODO(rydmike): Remove me totally
    debugPrint('AppBarWrapper: Destination = $destination');

    // In case we are showing the screen as modal screen it will then be
    // shown by the root navigator that does not have our custom directionality
    // wrapper above it in the tree, so we just add it once more.
    return Directionality(
      textDirection: appTextDirection(context, ref),
      child: Scaffold(
        // key: const PageStorageKey<String>(route),

        // When a main destination is being displayed as a modal route, we add
        // an AppBar, with same style as rest of app, with an implicit back
        // button that it will get since it was pushed.
        appBar: FlexAppBar.styled(
          context,
          title: Text(appDestinations[destination.menuIndex].label),
          gradient: ref.watch(appBarGradientPod),
          blurred: ref.watch(appBarBlurPod),
          opacity: ref.watch(appBarTransparentPod)
              ? ref.watch(appBarOpacityPod)
              : 1.0,
          hasBorderOnSurface: ref.watch(appBarBorderOnSurfacePod),
          hasBorder: ref.watch(appBarBorderPod),
          showScreenSize: ref.watch(appBarShowScreenSizePod),
        ).toAppBar(),
        extendBody: ref.watch(extendBodyPod),
        extendBodyBehindAppBar: ref.watch(extendBodyBehindAppBarPod),

        // If the body part is not shown as only a body in another Scaffold
        // we need an extra builder here to get the right top and bottom padding
        // values if we are extending body and/or extending body behind app bar.
        body: Builder(
          builder: (BuildContext context) {
            return child;
          },
        ),
      ),
    );
  }
}
