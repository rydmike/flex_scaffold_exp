import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class SidebarControlEnabledSwitch extends ConsumerWidget {
  const SidebarControlEnabledSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text(
        'User sidebar control button',
      ),
      subtitle: const Text(
        'When enabled, users can use the end drawer menu button to '
        'hide and show the sidebar, if it is possible to do so '
        'based on canvas size and breakpoint constraints.',
      ),
      value: ref.watch(sidebarControlEnabledPod),
      onChanged: (bool value) =>
          ref.read(sidebarControlEnabledPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(sidebarControlEnabled: '
          '${ref.watch(sidebarControlEnabledPod)})',
    );
  }
}
