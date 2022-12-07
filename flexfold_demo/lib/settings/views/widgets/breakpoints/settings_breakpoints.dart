import 'package:flutter/material.dart';

import '../../../../app/const/app_insets.dart';
import '../../../../core/views/widgets/app/maybe_card.dart';
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
        MediaQuery.of(context).size.width >= Sizes.desktopSize;
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
