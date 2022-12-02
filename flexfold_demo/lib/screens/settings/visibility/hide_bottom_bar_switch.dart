import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class HideBottomBarSwitch extends ConsumerWidget {
  const HideBottomBarSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text(
        'Keep bottom navigation bar hidden',
      ),
      subtitle: const Text(
        'Only use drawer, rail or menu and always keep the '
        'bottom navigation bar hidden.',
      ),
      value: ref.watch(hideBottomBarPod),
      onChanged: (bool value) =>
          ref.read(hideBottomBarPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(hideBottomBar: '
          '${ref.watch(hideBottomBarPod)})',
    );
  }
}
