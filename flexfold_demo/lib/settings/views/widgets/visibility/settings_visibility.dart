import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/const/app_insets.dart';
import '../../../../core/views/widgets/app/animated_hide.dart';
import '../../../../core/views/widgets/app/maybe_card.dart';
import '../../../controllers/pods_flexfold.dart';
import 'bottom_destinations_in_drawer_switch.dart';
import 'hide_bottom_bar_on_scroll_switch.dart';
import 'hide_bottom_bar_switch.dart';
import 'hide_menu_switch.dart';
import 'hide_sidebar_switch.dart';
import 'prefer_rail_switch.dart';
import 'show_bottom_bar_when_menu_in_drawer_switch.dart';
import 'show_bottom_bar_when_menu_shown_switch.dart';

class SettingsVisibility extends ConsumerWidget {
  const SettingsVisibility({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Draw content inside an extra card at this larger size
    final bool isDesktop =
        MediaQuery.of(context).size.width >= Sizes.desktopSize;

    return MaybeCard(
      condition: isDesktop,
      child: Column(
        children: <Widget>[
          const HideMenuSwitch(),
          const PreferRailSwitch(),
          const HideSidebarSwitch(),
          const HideBottomBarSwitch(),
          AnimatedSwitchShowHide(
            show: !ref.watch(hideBottomBarPod),
            child: const VisibleBottomBarControls(),
          ),
        ],
      ),
    );
  }
}

// All the settings for the bottom navigation bar controls, they are only
// shown when the bottom navigation bar is not set to be hidden in all
// navigation modes.
class VisibleBottomBarControls extends StatelessWidget {
  const VisibleBottomBarControls({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Divider(),
        HideBottomBarOnScrollSwitch(),
        ShowBottomBarWhenMenuInDrawerSwitch(),
        ShowBottomBarWhenMenuShownSwitch(),
        BottomDestinationsInDrawerSwitch(),
      ],
    );
  }
}
