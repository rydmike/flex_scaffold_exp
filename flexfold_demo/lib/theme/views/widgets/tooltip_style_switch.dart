import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../settings/controllers/pods_flexfold.dart';
import '../../controllers/pods_theme.dart';

class TooltipStyleSwitch extends ConsumerWidget {
  const TooltipStyleSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text(
        'Tooltips theme - Light on light, dark '
        'on dark',
      ),
      subtitle: const Text(
        'Keep OFF to use Material design based theme mode inverted '
        'background.',
      ),
      value: ref.watch(tooltipsMatchBackgroundPod),
      onChanged: (bool value) {
        ref.read(tooltipsMatchBackgroundPod.notifier).state = value;
      },
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Demo tooltip on the style toggle.\n'
          'This is a two row tooltip demo.',
    );
  }
}
