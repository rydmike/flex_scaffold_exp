import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class BorderOnDarkDrawerSwitch extends ConsumerWidget {
  const BorderOnDarkDrawerSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Side border on drawers in dark mode'),
      subtitle: const Text(
        'Side borders on drawers in dark mode are ON by default. '
        'In true black mode they are really needed. '
        'With the API you can change their color. There is also '
        'an API to enable side borders for light mode. '
        'It is OFF by default as it is normally not needed.',
      ),
      value: ref.watch(borderOnDarkDrawerPod),
      onChanged: (bool value) =>
          ref.read(borderOnDarkDrawerPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'FlexfoldThemeData(borderOnDrawerEdgeInDarkMode: '
          '${ref.watch(borderOnDarkDrawerPod)})',
    );
  }
}
