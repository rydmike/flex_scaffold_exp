import 'package:flex_scaffold/flex_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../settings/controllers/pods_flexfold.dart';
import 'sidebar_content.dart';

/// Example of [FlexSidebar] with a styled [FlexAppBar] and own content widget.
class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlexSidebar(
      // The appbar for the sidebar. This appbar is only used
      // when the sidebar is shown in the end drawer or when the sidebar
      // is
      // locked on the screen is defined to not be a part of the body.
      // Here we use Flexfold styled version, for a plain normal style
      // appbar use FlexfoldAppBar. If not given or null a default one
      // will be created for destinations that has a sidebar.
      appBar: FlexAppBar.styled(
        context,
        title: const Text('Sidebar title'),
        reverseGradient: true,
        gradient: ref.watch(appBarGradientPod),
        opacity:
            ref.watch(appBarTransparentPod) ? ref.watch(appBarOpacityPod) : 1.0,
        blurred: false, // ref.watch(blurAppBarPod).state,
        hasBorderOnSurface: ref.watch(appBarBorderOnSurfacePod),
        hasBorder: ref.watch(appBarBorderPod),
        // TODO(rydmike): Experimental AppBar feature, keep or not?
        // floatAppBar: ref.watch(appBarFloatPod),
        // floatPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 3, 0),
        // elevation: ref.watch(appBarFloatPod) ? 2 : 0,
        scrim: ref.watch(appBarScrimPod),
      ),
      child: const SidebarContent(),
    );
  }
}
