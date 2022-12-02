import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class AppBarBorderOnSurfaceSwitch extends ConsumerWidget {
  const AppBarBorderOnSurfaceSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Border on dark and white app bars'),
      subtitle: const Text(
        'If the app bar is dark or white, a border will be drawn '
        'at its bottom edge or around it if float app bar. You can set '
        'it separately for the app bar on the menu, '
        'body and sidebar.',
      ),
      value: ref.watch(appBarBorderOnSurfacePod),
      onChanged: (bool value) =>
          ref.read(appBarBorderOnSurfacePod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(appBar: '
          'FlexfoldAppBar.styled(hasBorderOnSurface: '
          '${ref.watch(appBarBorderOnSurfacePod)}))\n\n'
          'Equivalent for Flexfold() properties menuAppBar and sidebarAppBar',
    );
  }
}
