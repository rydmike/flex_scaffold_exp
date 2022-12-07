import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class PreferRailSwitch extends ConsumerWidget {
  const PreferRailSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text(
        'Prefer rail over menu',
      ),
      subtitle: const Text(
        'Keep using the rail even when the show menu breakpoint '
        'is exceeded.',
      ),
      value: ref.watch(preferRailPod),
      onChanged: (bool value) => ref.read(preferRailPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(preferRail: '
          '${ref.watch(preferRailPod)})',
    );
  }
}
