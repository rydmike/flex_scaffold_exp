import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

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
