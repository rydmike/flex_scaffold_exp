import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class AppBarScrimSwitch extends ConsumerWidget {
  const AppBarScrimSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Use standard system scrim on app bar'),
      subtitle: const Text(
        'Turn OFF to remove the system scrim on Android status bar.',
      ),
      value: ref.watch(appBarScrimPod),
      onChanged: (bool value) =>
          ref.read(appBarScrimPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(appBar: FlexfoldAppBar.styled(scrim: '
          '${ref.watch(appBarScrimPod)}))\n\n'
          'Equivalent for Flexfold() properties menuAppBar and sidebarAppBar',
    );
  }
}
