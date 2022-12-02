import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class BottomBarBlurSwitch extends ConsumerWidget {
  const BottomBarBlurSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Frosted glass blur effect'),
      subtitle: const Text(
        'Use iOS blur effect on none iOS bottom bars. '
        'Cupertino bottom navigation bar is always '
        'frosted glass blurred when transparent.',
      ),
      value: ref.watch(bottomBarBlurPod),
      onChanged: (bool value) =>
          ref.read(bottomBarBlurPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'FlexfoldThemeData(bottomBarBlur: '
          '${ref.watch(bottomBarBlurPod)})',
    );
  }
}
