import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class AppBarBlurSwitch extends ConsumerWidget {
  const AppBarBlurSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Frosted glass blur effect'),
      subtitle: const Text(
        'Use iOS frosted glass blur effect on transparent app bars.',
      ),
      value: ref.watch(appBarBlurPod),
      onChanged: (bool value) => ref.read(appBarBlurPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(appBar: FlexfoldAppBar.styled(appBarBlur: '
          '${ref.watch(appBarBlurPod)}))\n\n'
          'Equivalent for Flexfold() properties menuAppBar and sidebarAppBar',
    );
  }
}
