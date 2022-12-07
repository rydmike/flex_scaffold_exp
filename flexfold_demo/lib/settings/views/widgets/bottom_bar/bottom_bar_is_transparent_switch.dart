import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class BottomBarIsTransparentSwitch extends ConsumerWidget {
  const BottomBarIsTransparentSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Transparent bottom navigation bar'),
      subtitle: const Text(
        'Only useful if content extends behind the app bar.',
      ),
      value: ref.watch(bottomBarIsTransparentPod),
      onChanged: (bool value) =>
          ref.read(bottomBarIsTransparentPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'FlexfoldThemeData(bottomBarIsTransparent: '
          '${ref.watch(bottomBarIsTransparentPod)})',
    );
  }
}
