import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class ShowMenuHeaderSwitch extends ConsumerWidget {
  const ShowMenuHeaderSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Show menu header widget'),
      subtitle: const Text(
        'This demo app has a mock-up user profile as a header '
        'widget, showing it can be a complex widget. It is '
        'up to the implementation to make one that works '
        'OK in all modes.',
      ),
      value: ref.watch(showMenuHeaderPod),
      onChanged: (bool value) =>
          ref.read(showMenuHeaderPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: ref.watch(showMenuHeaderPod)
          ? 'Flexfold(menuHeader: MyHeaderWidget())'
          : 'Flexfold(menuHeader: null) or no assignment at all',
    );
  }
}
