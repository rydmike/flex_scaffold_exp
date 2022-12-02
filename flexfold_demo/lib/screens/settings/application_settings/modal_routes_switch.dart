import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_application.dart';
import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class ModalRoutesSwitch extends ConsumerWidget {
  const ModalRoutesSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Use modal routes for phone sized drawer destinations'),
      subtitle: const Text(
        'If bottom navigation is used and there are extra drawer destinations, '
        'when ON they will be modal destinations.',
      ),
      value: ref.watch(useModalRoutesPod),
      onChanged: (bool value) =>
          ref.read(useModalRoutesPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'This is a demo app feature, not a direct part of Flexfold',
    );
  }
}
