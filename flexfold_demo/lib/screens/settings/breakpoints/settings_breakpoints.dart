import 'package:flutter/material.dart';

import '../../../utils/app_insets.dart';
import '../../../widgets/wrappers/maybe_card.dart';
import 'breakpoint_drawer_slider.dart';
import 'breakpoint_menu_slider.dart';
import 'breakpoint_rail_slider.dart';
import 'breakpoint_sidebar_slider.dart';

class SettingsBreakpoints extends StatelessWidget {
  const SettingsBreakpoints({super.key});

  @override
  Widget build(BuildContext context) {
    // Place content inside an extra card at this larger size
    final bool isDesktop =
        MediaQuery.of(context).size.width >= AppInsets.desktopSize;
    return MaybeCard(
      condition: isDesktop,
      child: Column(
        children: const <Widget>[
          BreakpointDrawerSlider(),
          BreakpointRailSlider(),
          BreakpointMenuSlider(),
          BreakpointSidebarSlider(),
        ],
      ),
    );
  }
}
