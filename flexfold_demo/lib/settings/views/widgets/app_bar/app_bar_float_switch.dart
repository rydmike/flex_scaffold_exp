import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class AppBarFloatSwitch extends ConsumerWidget {
  const AppBarFloatSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Use float app bar'),
      subtitle: const Text(
        'The app bar floats disconnected from the screen edges.',
      ),
      value: ref.watch(appBarFloatPod),
      onChanged: (bool value) =>
          ref.read(appBarFloatPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(appBar: FlexfoldAppBar.styled(floatAppBar: '
          '${ref.watch(appBarFloatPod)}))\n\n'
          'Equivalent for Flexfold() properties menuAppBar and sidebarAppBar',
    );
  }
}
