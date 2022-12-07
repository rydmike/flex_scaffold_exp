import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class ShowMenuTrailingSwitch extends ConsumerWidget {
  const ShowMenuTrailingSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Show menu trailing widget'),
      subtitle: const Text(
        'This demo has an extra theme switch as a trailing widget.',
      ),
      value: ref.watch(showMenuTrailingPod),
      onChanged: (bool value) =>
          ref.read(showMenuTrailingPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: ref.watch(showMenuTrailingPod)
          ? 'Flexfold(menuTrailing: MyTrailingWidget())'
          : 'Flexfold(menuTrailing: null) or no assignment at all',
    );
  }
}
