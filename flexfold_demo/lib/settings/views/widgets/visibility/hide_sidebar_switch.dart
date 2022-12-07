import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class HideSidebarSwitch extends ConsumerWidget {
  const HideSidebarSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Keep sidebar hidden'),
      subtitle: const Text(
        'Keep sidebar hidden in the end drawer, '
        "even when the sidebar's breakpoint is exceeded.",
      ),
      value: ref.watch(hideSidebarPod),
      onChanged: (bool value) =>
          ref.read(hideSidebarPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(hideSidebar: '
          '${ref.watch(hideSidebarPod)})',
    );
  }
}
