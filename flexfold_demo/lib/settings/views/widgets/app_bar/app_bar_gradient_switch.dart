import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class AppBarGradientSwitch extends ConsumerWidget {
  const AppBarGradientSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text(
        'Gradient app bar',
      ),
      subtitle: const Text(
        'Use a gradient app bar. The gradient color is based on your app bar '
        'color. With the API you can change gradient direction, used '
        'in this demo on the menu and sidebar app bars.',
      ),
      value: ref.watch(appBarGradientPod),
      onChanged: (bool value) =>
          ref.read(appBarGradientPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(appBar: FlexfoldAppBar.styled(useGradients: '
          '${ref.watch(appBarGradientPod)}))\n\n'
          'Equivalent for Flexfold() properties menuAppBar and sidebarAppBar',
    );
  }
}
