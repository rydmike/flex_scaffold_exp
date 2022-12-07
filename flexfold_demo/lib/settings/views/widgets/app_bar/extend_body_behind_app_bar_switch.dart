import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class ExtendBodyBehindAppBarSwitch extends ConsumerWidget {
  const ExtendBodyBehindAppBarSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Scroll behind the app bar'),
      subtitle: const Text(
        'When enabled and combined with a transparent app '
        'bar, you can see content scroll behind it.',
      ),
      value: ref.watch(extendBodyBehindAppBarPod),
      onChanged: (bool value) =>
          ref.read(extendBodyBehindAppBarPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(extendBody: ${ref.watch(extendBodyBehindAppBarPod)})',
    );
  }
}
