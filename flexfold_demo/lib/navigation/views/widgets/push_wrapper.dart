import 'package:flexfold/flexfold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/controllers/pods_flexfold.dart';
import '../../constants/destinations.dart';
import '../../controllers/current_route_provider.dart';
import '../../models/app_navigation_state.dart';
import 'directionality_wrapper.dart';

const bool _kDebugMe = kDebugMode && true;

class PushWrapper extends ConsumerWidget {
  const PushWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CurrentRoute appNav = ref.watch(currentRouteProvider);

    // Get the current modal destination details, we will use it's info in the
    // page header to display info on how we navigated to this page.
    final FlexDestinationTarget destination = appNav.pushedDestination;
    if (_kDebugMe) {
      debugPrint('PushWrapper: Destination = $destination');
    }
    // In case we are showing the screen as modal screen it will then be
    // shown by the root navigator that does not have our custom directionality
    // control and wrapper above it in the tree, so we add it here too.
    return DirectionalityWrapper(
      child: Scaffold(
        // When a main destination is being displayed as a modal route, we add
        // an AppBar, with same style as rest of app, with an implicit back
        // button that it will get since it was pushed.
        appBar: FlexAppBar.styled(
          context,
          title: Text(appDestinations[destination.index].label),
          gradient: ref.watch(appBarGradientPod),
          blurred: ref.watch(appBarBlurPod),
          opacity: ref.watch(appBarTransparentPod)
              ? ref.watch(appBarOpacityPod)
              : 1.0,
          hasBorderOnSurface: ref.watch(appBarBorderOnSurfacePod),
          hasBorder: ref.watch(appBarBorderPod),
          showScreenSize: ref.watch(appBarShowScreenSizePod),
          // TODO(rydmike): Experimental AppBar feature, keep or not?
          floatAppBar: ref.watch(appBarFloatPod),
          floatPadding: const EdgeInsetsDirectional.fromSTEB(3, 4, 3, 4),
          elevation: ref.watch(appBarFloatPod) ? 1 : 0,
          scrim: ref.watch(appBarScrimPod),
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
