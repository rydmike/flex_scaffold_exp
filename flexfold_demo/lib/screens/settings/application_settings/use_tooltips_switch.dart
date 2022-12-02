import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class UseTooltipsSwitch extends ConsumerWidget {
  const UseTooltipsSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Use tooltips'),
      subtitle: const Text(
        'Turn OFF all Flexfold tooltips and all the API '
        'tooltips on the controls in this demo.',
      ),
      value: ref.watch(useTooltipsPod),
      onChanged: (bool value) =>
          ref.read(useTooltipsPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(useTooltips: '
          '${ref.watch(useTooltipsPod)})',
    );
  }
}
