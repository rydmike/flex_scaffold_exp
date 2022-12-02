import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/list_tiles/switch_tile_tooltip.dart';

@immutable
class SidebarBelongsToBodySwitch extends ConsumerWidget {
  const SidebarBelongsToBodySwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Sidebar belongs to the body'),
      subtitle: const Text(
        'The Material guide shows the sidebar as a '
        'part of the scaffold body. Turn ON this setting '
        'to follow the guide. Flexfold defaults to having it outside '
        'the body, like the side menu and rail. The setting '
        'affects if a bottom bar covers the sidebar or not and also '
        'impacts standard FAB locations when the sidebar is visible.',
      ),
      value: ref.watch(sidebarBelongsToBodyPod),
      onChanged: (bool value) =>
          ref.read(sidebarBelongsToBodyPod.notifier).state = value,
      tooltipEnabled: ref.watch(useTooltipsPod),
      tooltip: 'Flexfold(sidebarBelongsToBody: '
          '${ref.watch(sidebarBelongsToBodyPod)})',
    );
  }
}
