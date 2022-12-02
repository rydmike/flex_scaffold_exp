import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class HideMenuSwitch extends ConsumerWidget {
  const HideMenuSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text(
        'Keep rail and menu hidden',
      ),
      subtitle: const Text(
        'Keep the rail and menu in the drawer, even '
        'when the breakpoints to show them are exceeded.',
      ),
      value: ref.watch(hideMenuPod),
      onChanged: (bool value) => ref.read(hideMenuPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(hideMenu: '
          '${ref.watch(hideMenuPod)})',
    );
  }
}
