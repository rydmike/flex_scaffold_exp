import 'package:flex_scaffold/flex_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/maybe_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

class SidebarWidthSlider extends ConsumerWidget {
  const SidebarWidthSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Slider control in a ListTile for sidebar width.
    return ListTile(
      title: const Text('Sidebar width'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Default width is '
              '${kFlexSidebarWidth.toStringAsFixed(0)} dp.'),
          MaybeTooltip(
            condition: ref.watch(useTooltipsPod),
            tooltip: 'Flexfold(menuWidth: '
                '${ref.watch(sidebarWidthPod).floor()})',
            child: Slider(
              min: kFlexSidebarWidthMin,
              max: kFlexSidebarWidthMax,
              divisions: (kFlexSidebarWidthMax - kFlexSidebarWidthMin).floor(),
              label: ref.watch(sidebarWidthPod).floor().toString(),
              value: ref.watch(sidebarWidthPod),
              onChanged: (double value) {
                ref.read(sidebarWidthPod.notifier).state = value;
              },
            ),
          ),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsetsDirectional.only(end: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'Width',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              ref.watch(sidebarWidthPod).floor().toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
