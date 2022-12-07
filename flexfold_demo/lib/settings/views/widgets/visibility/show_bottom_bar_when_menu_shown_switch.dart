import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class ShowBottomBarWhenMenuShownSwitch extends ConsumerWidget {
  const ShowBottomBarWhenMenuShownSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Always show bottom navigation bar'),
      subtitle: const Text(
        'Show the bottom navigation bar also when the rail '
        'or menu is shown.\n'
        'CAUTION: Not recommended, it '
        'may be confusing. Used mostly for testing '
        'purposes, but it can also be useful as an '
        'accessibility feature.',
      ),
      value: ref.watch(showBottomBarWhenMenuShownPod),
      onChanged: (bool value) {
        ref.read(showBottomBarWhenMenuShownPod.notifier).state = value;
        ref.read(scrollHiddenBottomBarPod.notifier).state = false;
      },
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(showBottomBarWhenMenuShown: '
          '${ref.watch(showBottomBarWhenMenuShownPod)})',
    );
  }
}
