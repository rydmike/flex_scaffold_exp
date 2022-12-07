import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class CycleViaDrawerSwitch extends ConsumerWidget {
  const CycleViaDrawerSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text(
        'Cycle menus via drawer',
      ),
      subtitle: const Text(
        'When you toggle the menus they will cycle via the drawer even '
        'when the menu or rail can be opened based on breakpoint '
        'settings. Keep OFF to skip the step via the drawer.',
      ),
      value: ref.watch(cycleViaDrawerPod),
      onChanged: (bool value) =>
          ref.read(cycleViaDrawerPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(cycleViaDrawer: '
          '${ref.watch(cycleViaDrawerPod)})',
    );
  }
}
