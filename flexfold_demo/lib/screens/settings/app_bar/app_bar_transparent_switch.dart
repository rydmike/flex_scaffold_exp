import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class AppBarTransparentSwitch extends ConsumerWidget {
  const AppBarTransparentSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text(
        'Transparent app bar',
      ),
      subtitle: const Text(
        'Useful when the content scrolls behind the app bar.',
      ),
      value: ref.watch(appBarTransparentPod),
      onChanged: (bool value) =>
          ref.read(appBarTransparentPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'This is NOT an API setting!\nIt is a demo app convenience '
          'toggle that will hide settings that require opacity and use '
          'opacity value 1.0 instead of the selected value in the slider. ',
    );
  }
}
