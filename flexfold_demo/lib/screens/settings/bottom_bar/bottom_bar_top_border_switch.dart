import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class BottomBarTopBorderSwitch extends ConsumerWidget {
  const BottomBarTopBorderSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Top border'),
      subtitle: const Text(
        'Use a border at the top edge of the bottom navigation bar.',
      ),
      value: ref.watch(bottomBarTopBorderPod),
      onChanged: (bool value) =>
          ref.read(bottomBarTopBorderPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'FlexfoldThemeData(bottomBarTopBorder: '
          '${ref.watch(bottomBarTopBorderPod)})',
    );
  }
}
