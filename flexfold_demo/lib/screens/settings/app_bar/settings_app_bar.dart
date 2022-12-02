import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../utils/app_insets.dart';
import '../../../widgets/wrappers/animated_hide.dart';
import '../../../widgets/wrappers/maybe_card.dart';
import 'app_bar_blur_switch.dart';
import 'app_bar_border_on_surface_switch.dart';
import 'app_bar_border_switch.dart';
import 'app_bar_float_switch.dart';
import 'app_bar_gradient_switch.dart';
import 'app_bar_opacity_slider.dart';
import 'app_bar_scrim_switch.dart';
import 'app_bar_show_screen_size_switch.dart';
import 'app_bar_transparent_switch.dart';
import 'extend_body_behind_app_bar_switch.dart';

class SettingsAppBar extends ConsumerWidget {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Place content inside an extra card at desktop size
    final bool isDesktop =
        MediaQuery.of(context).size.width >= AppInsets.desktopSize;
    return MaybeCard(
      condition: isDesktop,
      child: Column(
        children: <Widget>[
          const AppBarGradientSwitch(),
          const AppBarTransparentSwitch(),
          // Show the "Opacity" and "Frosted glass" settings
          // only when using transparent app bar.
          AnimatedSwitchShowHide(
            show: ref.watch(appBarTransparentPod),
            child: Column(
              children: const <Widget>[
                AppBarBlurSwitch(),
                AppBarOpacitySlider(),
              ],
            ),
          ),
          const ExtendBodyBehindAppBarSwitch(),
          const AppBarFloatSwitch(),
          const AppBarScrimSwitch(),
          const AppBarBorderOnSurfaceSwitch(),
          const AppBarBorderSwitch(),
          const AppBarShowScreenSizeSwitch(),
        ],
      ),
    );
  }
}
