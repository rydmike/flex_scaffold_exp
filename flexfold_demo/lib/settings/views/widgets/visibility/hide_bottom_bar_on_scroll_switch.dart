import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class HideBottomBarOnScrollSwitch extends ConsumerWidget {
  const HideBottomBarOnScrollSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Hide bottom navigation bar when scrolling'),
      subtitle: const Text(
        'When you scroll down, the bottom navigation bar '
        'will be hidden. When you scroll '
        'up a bit, it is shown again.',
      ),
      value: ref.watch(hideBottomBarOnScrollPod),
      onChanged: (bool isHidden) {
        ref.read(hideBottomBarOnScrollPod.notifier).state = isHidden;
        // If hide bottom bar switch was turned OFF, we also set the
        // scrollHideBottomBarPod to false, so bottom bar shows up
        // again if it was scroll hidden on this screen.
        if (!isHidden) {
          ref.read(scrollHiddenBottomBarPod.notifier).state = false;
        }
      },
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip:
          'Use a ScrollController, add a listener function, and in it set\n'
          'Flexfold(scrollHideBottomBar: true) when scrolling down and\n'
          'Flexfold(scrollHideBottomBar: false) when scrolling up, this\n'
          'will hide and show the bottom navigation bar when scrolling.',
    );
  }
}
