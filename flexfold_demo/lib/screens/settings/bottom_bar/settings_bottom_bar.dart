import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../utils/app_insets.dart';
import '../../../widgets/wrappers/animated_hide.dart';
import '../../../widgets/wrappers/maybe_card.dart';
import '../../../widgets/wrappers/maybe_tooltip.dart';
import 'bottom_bar_blur_switch.dart';
import 'bottom_bar_is_transparent_switch.dart';
import 'bottom_bar_opacity_slider.dart';
import 'bottom_bar_top_border_switch.dart';
import 'bottom_bar_type_switch.dart';
import 'extend_body_switch.dart';

class SettingsBottomBar extends ConsumerWidget {
  const SettingsBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Place content inside an extra card at this larger size
    final bool isDesktop =
        MediaQuery.of(context).size.width >= AppInsets.desktopSize;

    return MaybeCard(
      condition: isDesktop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ToggleButtons control for Bottom bar type selection
          const ListTile(
            title: Text('Navigation bar style'),
            subtitle: Text(
              'Adaptive uses Cupertino on iOS/MacOS and '
              'Material on other platforms.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MaybeTooltip(
              condition: ref.watch(useTooltipsPod),
              tooltip: 'FlexfoldThemeData(bottomBarType: '
                  '${ref.watch(bottomBarTypePod)})',
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppInsets.l,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[BottomBarTypeSwitch()],
                ),
              ),
            ),
          ),
          const BottomBarIsTransparentSwitch(),
          // Hide the "Opacity" and "Frosted glass" settings
          // when transparent bottom is OFF, as those settings have
          // no impact then.
          AnimatedSwitchShowHide(
            show: ref.watch(bottomBarIsTransparentPod),
            child: const BottomNavBarOpacityControls(),
          ),
          // Scroll behind bottom navigation bar toggle.
          const ExtendBodySwitch(),
          // Top side border on the bottom bat.
          const BottomBarTopBorderSwitch(),
        ],
      ),
    );
  }
}

class BottomNavBarOpacityControls extends StatelessWidget {
  const BottomNavBarOpacityControls({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        // Frosted glass effect
        BottomBarBlurSwitch(),
        // Slider for bottom bar opacity value in a ListTile.
        BottomBarOpacitySlider(),
      ],
    );
  }
}
