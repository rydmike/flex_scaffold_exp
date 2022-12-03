import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_theme.dart';
import '../../../widgets/list_tiles/switch_list_tile_adaptive.dart';

@immutable
class ComputeDarkThemeSwitch extends ConsumerWidget {
  const ComputeDarkThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTileAdaptive(
      title: const Text('Compute dark scheme colors'),
      subtitle: const Text(
        'Dark scheme colors are computed from the light scheme, instead of '
        'using defined dark scheme colors. The image based dark scheme '
        'colors are always computed from image extracted colors for the '
        'light theme mode.',
      ),
      value: ref.watch(useToDarkMethodPod),
      onChanged: (bool value) {
        ref.read(useToDarkMethodPod.notifier).state = value;
      },

      // value: ref.watch(schemeIndexPod).state == 2
      //     ? true
      //     : ref.watch(useToDarkMethodPod).state,
      // onChanged: ref.watch(schemeIndexPod).state == 2
      //     ? null
      //     : (bool value) {
      //         ref.read(useToDarkMethodPod).state = value;
      //       },
    );
  }
}
