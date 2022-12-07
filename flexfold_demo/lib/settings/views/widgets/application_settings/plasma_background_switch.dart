import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/controllers/app_controllers.dart';
import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class PlasmaBackgroundSwitch extends ConsumerWidget {
  const PlasmaBackgroundSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Plasma background'),
      subtitle: const Text(
        'Fun plasma animation on sidebars and home screen.',
      ),
      value: ref.watch(plasmaBackgroundProvider),
      onChanged: (bool value) =>
          ref.read(plasmaBackgroundProvider.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'This is just a fun demo effect. OFF by default',
    );
  }
}
