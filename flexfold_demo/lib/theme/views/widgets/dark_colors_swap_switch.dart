import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/widgets/app/list_tiles/switch_list_tile_adaptive.dart';
import '../../controllers/pods_theme.dart';

class DarkColorsSwapSwitch extends ConsumerWidget {
  const DarkColorsSwapSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTileAdaptive(
      title: const Text('Dark mode swap colors'),
      subtitle: const Text('Turn ON to swap primary and secondary colors'),
      value: ref.watch(darkSwapColorsPod),
      onChanged: (bool value) {
        ref.read(darkSwapColorsPod.notifier).state = value;
      },
    );
  }
}
