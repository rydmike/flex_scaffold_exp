import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../utils/app_insets.dart';
import '../../../widgets/wrappers/maybe_card.dart';
import '../../../widgets/wrappers/maybe_tooltip.dart';
import 'menu_highlight_height_slider.dart';
import 'menu_highlight_type_switch.dart';
import 'menu_side_switch.dart';
import 'menu_start_switch.dart';
import 'show_menu_footer_switch.dart';
import 'show_menu_leading_switch.dart';
import 'show_menu_trailing_switch.dart';

class SettingsMenu extends ConsumerWidget {
  const SettingsMenu({super.key});

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
          const ShowMenuLeadingSwitch(),
          const ShowMenuTrailingSwitch(),
          const ShowMenuFooterSwitch(),
          // ToggleButtons control for highlight style selection
          const ListTile(
            title: Text('Selected destination highlight'),
            subtitle: Text(
              'The selection indicator is a ShapeBorder and can be '
              'fully customized or just use one of these built in options.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MaybeTooltip(
              condition: ref.watch(useTooltipsPod),
              tooltip: 'See API guide for full details. The following '
                  'Flexfold() properties are used:\n'
                  'ShapeBorder menuHighlightShape, ShapeBorder '
                  'menuSelectedShape, '
                  'EdgeInsetsDirectional menuHighlightMargins, Color '
                  'menuHighlightColor.\n\n'
                  'There is a helper class FlexfoldMenuHighlight() that via '
                  'enum values (${ref.watch(menuHighlightTypePod)}) can '
                  'return the needed property values '
                  'for the example highlight styles in this demo.',
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppInsets.l,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[MenuHighlightTypeSwitch()],
                ),
              ),
            ),
          ),
          // Slider in a ListTile for menu highlight height.
          const MenuHighlightHeightSlider(),
          // ToggleButtons control for menu starting point
          const ListTile(
            title: Text('Menu start and direction'),
            subtitle: Text(
              'The menu and rail can also start from the bottom. This '
              'will also toggle the direction of the items and leading and '
              'trailing widgets position, but footer will remain at the '
              'very bottom if used. If you use the start from bottom you '
              'may need to adjust your destination content to match it.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MaybeTooltip(
              condition: ref.watch(useTooltipsPod),
              tooltip: 'Flexfold(menuStart: ${ref.watch(menuStartPod)})',
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppInsets.l,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[MenuStartSwitch()],
                ),
              ),
            ),
          ),
          // ToggleButtons control for Menu side selection
          const ListTile(
            title: Text('Menu side'),
            subtitle: Text('Where should the menu be located?'),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: MaybeTooltip(
              condition: ref.watch(useTooltipsPod),
              tooltip: 'Flexfold(menuSide: ${ref.watch(menuSidePod)})',
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppInsets.l,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[MenuSideSwitch()],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
