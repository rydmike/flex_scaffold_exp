import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class BottomDestinationsInDrawerSwitch extends ConsumerWidget {
  const BottomDestinationsInDrawerSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Always include bottom destinations in the drawer'),
      subtitle: const Text(
        'When the drawer is opened in bottom navigation mode, '
        'also include the bottom destinations in it. '
        'By default they are excluded and only shown when '
        'needed to avoid being stranded. Normal usage and '
        'convention is to keep '
        'this OFF as it may be confusing. It can also '
        'be convenient, as it gives you two simultaneous '
        'ways to navigate.',
      ),
      value: ref.watch(bottomDestinationsInDrawerPod),
      onChanged: (bool value) =>
          ref.read(bottomDestinationsInDrawerPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(bottomDestinationsInDrawer: '
          '${ref.watch(bottomDestinationsInDrawerPod)})',
    );
  }
}
