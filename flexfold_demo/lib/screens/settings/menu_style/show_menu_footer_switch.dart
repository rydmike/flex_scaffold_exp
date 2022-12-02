import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class ShowMenuFooterSwitch extends ConsumerWidget {
  const ShowMenuFooterSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Show menu footer widget'),
      subtitle: const Text(
        'This demo has a copyright notice as a footer widget.',
      ),
      value: ref.watch(showMenuFooterPod),
      onChanged: (bool value) =>
          ref.read(showMenuFooterPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: ref.watch(showMenuFooterPod)
          ? 'Flexfold(menuFooter: MyFooterWidget())'
          : 'Flexfold(menuFooter: null) or no assignment at all',
    );
  }
}
