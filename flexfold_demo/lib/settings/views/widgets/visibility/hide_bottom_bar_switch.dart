import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

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
