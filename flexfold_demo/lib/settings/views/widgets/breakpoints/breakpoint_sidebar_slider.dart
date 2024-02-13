import 'package:flex_scaffold/flex_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/maybe_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

class BreakpointSidebarSlider extends ConsumerWidget {
  const BreakpointSidebarSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Slider in a ListTile for sidebar visibility breakpoint.
    return ListTile(
      title: const Text('Show sidebar at width'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Default breakpoint API value is '
              '${kFlexBreakpointSidebar.toStringAsFixed(0)} dp.'),
          MaybeTooltip(
            condition: ref.watch(useTooltipsPod),
            tooltip: 'FlexfoldThemeData(breakpointSidebar: '
                '${ref.watch(breakpointSidebarPod).floor()})',
            child: Slider(
              min: kFlexBreakpointSidebarMin,
              max: kFlexBreakpointSidebarMax,
              divisions: (kFlexBreakpointSidebarMax - kFlexBreakpointSidebarMin)
                  .floor(),
              label: ref.watch(breakpointSidebarPod).floor().toString(),
              value: ref.watch(breakpointSidebarPod),
              onChanged: (double value) {
                ref.read(breakpointSidebarPod.notifier).state = value;
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
              ref.watch(breakpointSidebarPod).floor().toString(),
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
