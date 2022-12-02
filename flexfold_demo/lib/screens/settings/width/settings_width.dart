import 'package:flutter/material.dart';

import '../../../utils/app_insets.dart';
import '../../../widgets/wrappers/maybe_card.dart';
import 'menu_width_slider.dart';
import 'rail_width_slider.dart';
import 'sidebar_width_slider.dart';

class SettingsWidth extends StatelessWidget {
  const SettingsWidth({super.key});

  @override
  Widget build(BuildContext context) {
    // Draw content inside an extra card at this larger size
    final bool isDesktop =
        MediaQuery.of(context).size.width >= AppInsets.desktopSize;

    return MaybeCard(
      condition: isDesktop,
      child: Column(
        children: const <Widget>[
          MenuWidthSlider(),
          RailWidthSlider(),
          SidebarWidthSlider(),
        ],
      ),
    );
  }
}
