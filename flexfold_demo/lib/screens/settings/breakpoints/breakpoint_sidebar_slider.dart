import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/wrappers/maybe_tooltip.dart';

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
              '${kFlexfoldBreakpointSidebar.toStringAsFixed(0)} dp.'),
          MaybeTooltip(
            condition: ref.watch(useTooltipsPod),
            tooltip: 'FlexfoldThemeData(breakpointSidebar: '
                '${ref.watch(breakpointSidebarPod).floor()})',
            child: Slider.adaptive(
              min: kFlexfoldBreakpointSidebarMin,
              max: kFlexfoldBreakpointSidebarMax,
              divisions: (kFlexfoldBreakpointSidebarMax -
                      kFlexfoldBreakpointSidebarMin)
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
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              ref.watch(breakpointSidebarPod).floor().toString(),
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
