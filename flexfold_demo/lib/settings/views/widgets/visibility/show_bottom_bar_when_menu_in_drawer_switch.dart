import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class ShowBottomBarWhenMenuInDrawerSwitch extends ConsumerWidget {
  const ShowBottomBarWhenMenuInDrawerSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text(
        'Show bottom navigation when menu is hidden',
      ),
      subtitle: const Text(
        'Normal responsive behavior is to only show bottom '
        'navigation when the width is below its breakpoint. '
        'With this setting ON it will be shown whenever the '
        'rail/menu is hidden. For this demo app, this is '
        'ON by default, but API default is OFF.',
      ),
      value: ref.watch(showBottomBarWhenMenuInDrawerPod),
      onChanged: (bool value) =>
          ref.read(showBottomBarWhenMenuInDrawerPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(showBottomBarWhenMenuInDrawer: '
          '${ref.watch(showBottomBarWhenMenuInDrawerPod)})',
    );
  }
}
