import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class AppBarBorderSwitch extends ConsumerWidget {
  const AppBarBorderSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Border on the app bar'),
      subtitle: const Text(
        'Always use a border at bottom edge or around the float app bar. '
        'With the API you can also modify the border color, it defaults '
        'to the divider theme color.',
      ),
      value: ref.watch(appBarBorderPod),
      onChanged: (bool value) =>
          ref.read(appBarBorderPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(appBar: FlexfoldAppBar.styled(hasBorder: '
          '${ref.watch(appBarBorderPod)}))\n\n'
          'Equivalent for Flexfold() properties menuAppBar '
          'and sidebarAppBar',
    );
  }
}
