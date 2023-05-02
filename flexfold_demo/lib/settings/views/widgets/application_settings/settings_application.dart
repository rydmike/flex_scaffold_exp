import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/const/app_insets.dart';
import '../../../../core/views/widgets/app/maybe_card.dart';
import '../../../../core/views/widgets/app/maybe_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';
import '../other_settings/app_text_direction_switch.dart';
import 'modal_routes_switch.dart';
import 'plasma_background_switch.dart';
import 'popup_menu_platform.dart';
import 'use_tooltips_switch.dart';

class SettingsApplication extends ConsumerWidget {
  const SettingsApplication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Place content inside an extra card at desktop size
    final bool isDesktop =
        MediaQuery.of(context).size.width >= Sizes.desktopSize;

    return MaybeCard(
      condition: isDesktop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          // Use Tooltips
          const UseTooltipsSwitch(),
          // Fun plasma background animation effect on sidebars and home screen.
          const PlasmaBackgroundSwitch(),
          // Modal bottom navigation routes.
          const ModalRoutesSwitch(),
          // Platform popup selection button
          const PopupMenuPlatform(),
          // Toggle buttons for text direction selection
          const ListTile(
            title: Text('Application directionality'),
            subtitle: Text(
              'Select directionality LTR or RTL to see how the layout '
              'of the application changes. NOTE: In this demo the text '
              'will still be LTR in RTL, since it is in English, but app '
              'layout will change to RTL.',
            ),
          ),
          // We wrap the segment control that control Directionality in
          // always LTR mode, because when used as a toggle it is a
          // bit confusing if we do not, since the placement of the LTR
          // and RTL choices also switches when you switch mode. This way
          // the choice stay in place and the toggle function is more
          // logical.
          Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: MaybeTooltip(
                condition: ref.watch(useTooltipsPod),
                tooltip: 'FlexfoldThemeData(bottomBarType: '
                    '${ref.watch(bottomBarTypePod.notifier).state})',
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.l,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[AppTextDirectionSwitch()],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
