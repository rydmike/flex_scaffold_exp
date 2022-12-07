import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class MenuControlEnabledSwitch extends ConsumerWidget {
  const MenuControlEnabledSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text(
        'Enable manual menu toggle control',
      ),
      subtitle: const Text(
        'When enabled, users can use the drawer menu button to '
        'hide and show the rail and side menu, if it is possible '
        'to do so based on canvas size and breakpoint constraints.',
      ),
      value: ref.watch(menuControlEnabledPod),
      onChanged: (bool value) =>
          ref.read(menuControlEnabledPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(menuControlEnabled: '
          '${ref.watch(menuControlEnabledPod)})',
    );
  }
}
