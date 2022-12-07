import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class ExtendBodySwitch extends ConsumerWidget {
  const ExtendBodySwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Scroll behind bottom navigation bar'),
      subtitle: const Text(
        'Turn ON to see content behind the bottom bar, if it is partially '
        'transparent or frosted glass blurred.',
      ),
      value: ref.watch(extendBodyPod),
      onChanged: (bool value) => ref.read(extendBodyPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(extendBody: ${ref.watch(extendBodyPod)})',
    );
  }
}
