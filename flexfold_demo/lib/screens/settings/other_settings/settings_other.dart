import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../utils/app_insets.dart';
import '../../../widgets/wrappers/maybe_card.dart';
import '../../../widgets/wrappers/maybe_tooltip.dart';
import '../application_settings/app_animation_curve_switch.dart';
import 'animation_duration_slider.dart';
import 'border_on_dark_drawer_switch.dart';
import 'border_on_menu_switch.dart';
import 'sidebar_belongs_to_body_switch.dart';

class SettingsOther extends ConsumerWidget {
  const SettingsOther({super.key});

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
          const BorderOnMenuSwitch(),
          const BorderOnDarkDrawerSwitch(),
          const SidebarBelongsToBodySwitch(),
          // ToggleButtons control for Bottom bar type selection
          const ListTile(
            title: Text('Menu animation type'),
            subtitle: Text(
              'With the API you can specify animation curves '
              'and durations separately for the menu, sidebar and '
              'bottom navigation bar. In this demo the settings are '
              'shared and limited to a few examples.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MaybeTooltip(
              condition: ref.watch(useTooltipsPod),
              tooltip: 'FlexfoldThemeData(\n'
                  '  menuAnimationCurve: ${appAnimationCurves(ref)},\n'
                  '  sidebarAnimationCurve: ${appAnimationCurves(ref)},\n'
                  '  bottomBarAnimationCurve: ${appAnimationCurves(ref)})',
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppInsets.l,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[AppAnimationCurveSwitch()],
                ),
              ),
            ),
          ),
          // Slider for menu animation time.
          const AnimationDurationSlider(),
        ],
      ),
    );
  }
}
