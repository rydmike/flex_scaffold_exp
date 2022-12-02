import 'package:flutter/material.dart';

import '../../../utils/app_insets.dart';
import '../../../widgets/wrappers/maybe_card.dart';
import 'cycle_via_drawer_switch.dart';
import 'menu_control_enabled_switch.dart';
import 'sidebar_control_enabled_switch.dart';
import 'use_custom_menu_icons_switch.dart';

class MenuControlSettings extends StatelessWidget {
  const MenuControlSettings({super.key});

  @override
  Widget build(BuildContext context) {
    // Place content inside an extra card at desktop size
    final bool isDesktop =
        MediaQuery.of(context).size.width >= AppInsets.desktopSize;

    return MaybeCard(
      condition: isDesktop,
      child: Column(
        children: const <Widget>[
          MenuControlEnabledSwitch(),
          SidebarControlEnabledSwitch(),
          Divider(),
          CycleViaDrawerSwitch(),
          UseCustomMenusSwitch(),
        ],
      ),
    );
  }
}
