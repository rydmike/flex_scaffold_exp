import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class UseCustomMenusSwitch extends ConsumerWidget {
  const UseCustomMenusSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Custom menu control icons'),
      subtitle: const Text(
        'You can customize the menu toggle icons used for each '
        'menu state. Tooltips for each next '
        'action can also be provided. Turn ON for an example. ',
      ),
      value: ref.watch(useCustomMenuIconsPod),
      onChanged: (bool value) =>
          ref.read(useCustomMenuIconsPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Assign your custom Icon widgets to Flexfold() properties:\n'
          'menuIcon, menuIconExpand, menuIconExpandHidden, '
          'menuIconCollapse, '
          'sidebarIcon, sidebarIconExpand, sidebarIconExpandHidden '
          'and sidebarIconCollapse',
    );
  }
}
