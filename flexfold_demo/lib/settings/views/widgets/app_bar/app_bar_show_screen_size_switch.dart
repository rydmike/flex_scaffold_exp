import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/list_tiles/switch_tile_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

@immutable
class AppBarShowScreenSizeSwitch extends ConsumerWidget {
  const AppBarShowScreenSizeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text(
        'Show canvas size',
      ),
      subtitle: const Text(
        'To assist with responsive app development, you can '
        'show current canvas size in the styled app bar. '
        'This is not a setting you want to enable '
        'for end users, but useful during development.',
      ),
      value: ref.watch(appBarShowScreenSizePod),
      onChanged: (bool value) =>
          ref.read(appBarShowScreenSizePod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod.notifier).state,
      tooltip: 'Flexfold(appBar: FlexfoldAppBar.styled(showScreenSize: '
          '${ref.watch(appBarShowScreenSizePod)}))',
    );
  }
}
