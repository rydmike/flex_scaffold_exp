import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class ShowMenuLeadingSwitch extends ConsumerWidget {
  const ShowMenuLeadingSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Show menu leading widget'),
      subtitle: const Text(
        'This demo app has a mock-up user profile as a leading '
        'widget, showing it can be a complex widget. It is '
        'up to the implementation to make one that works '
        'OK in all modes.',
      ),
      value: ref.watch(showMenuLeadingPod),
      onChanged: (bool value) =>
          ref.read(showMenuLeadingPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: ref.watch(showMenuLeadingPod)
          ? 'Flexfold(menuLeading: MyLeadingWidget())'
          : 'Flexfold(menuLeading: null) or no assignment at all',
    );
  }
}
