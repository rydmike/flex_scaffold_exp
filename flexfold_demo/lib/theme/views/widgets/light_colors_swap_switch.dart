import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/widgets/app/list_tiles/switch_list_tile_adaptive.dart';
import '../../controllers/pods_theme.dart';

class LightColorsSwapSwitch extends ConsumerWidget {
  const LightColorsSwapSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTileAdaptive(
      title: const Text('Light mode swap colors'),
      subtitle: const Text('Turn ON to swap primary and secondary colors'),
      value: ref.watch(lightSwapColorsPod),
      onChanged: (bool value) {
        ref.read(lightSwapColorsPod.notifier).state = value;
      },
    );
  }
}
