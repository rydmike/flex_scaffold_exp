import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/controllers/app_controllers.dart';
import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

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
      value: ref.watch(useModalRoutesProvider),
      onChanged: (bool value) =>
          ref.read(useModalRoutesProvider.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'This is a demo app feature, not a direct part of Flexfold',
    );
  }
}
