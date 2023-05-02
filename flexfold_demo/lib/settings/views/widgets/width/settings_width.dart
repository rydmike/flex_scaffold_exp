import 'package:flutter/material.dart';

import '../../../../app/const/app_insets.dart';
import '../../../../core/views/widgets/app/maybe_card.dart';
import 'menu_width_slider.dart';
import 'rail_width_slider.dart';
import 'sidebar_width_slider.dart';

class SettingsWidth extends StatelessWidget {
  const SettingsWidth({super.key});

  @override
  Widget build(BuildContext context) {
    // Draw content inside an extra card at this larger size
    final bool isDesktop =
        MediaQuery.of(context).size.width >= Sizes.desktopSize;

    return MaybeCard(
      condition: isDesktop,
      child: const Column(
        children: <Widget>[
          MenuWidthSlider(),
          RailWidthSlider(),
          SidebarWidthSlider(),
        ],
      ),
    );
  }
}
