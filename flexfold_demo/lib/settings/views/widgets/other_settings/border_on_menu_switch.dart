import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class BorderOnMenuSwitch extends ConsumerWidget {
  const BorderOnMenuSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Border on menu and sidebar'),
      subtitle: const Text(
        'Draws a thin line between the menu, body and sidebar.',
      ),
      value: ref.watch(borderOnMenuPod),
      onChanged: (bool value) =>
          ref.read(borderOnMenuPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'FlexfoldThemeData(\n'
          '  borderOnMenu: ${ref.watch(borderOnMenuPod)},\n'
          '  borderOnSidebar: ${ref.watch(borderOnMenuPod)})',
    );
  }
}
