import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/wrappers/maybe_tooltip.dart';

class BreakpointMenuSlider extends ConsumerWidget {
  const BreakpointMenuSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Slider in a ListTile for menu visibility breakpoint.
    return ListTile(
      title: const Text('Break from rail to side menu at width'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Default breakpoint API value is '
              '${kFlexfoldBreakpointMenu.toStringAsFixed(0)} dp.'),
          MaybeTooltip(
            condition: ref.watch(useTooltipsPod),
            tooltip: 'FlexfoldThemeData(breakpointMenu: '
                '${ref.watch(breakpointMenuPod).floor()})',
            child: Slider.adaptive(
              min: kFlexfoldBreakpointMenuMin,
              max: kFlexfoldBreakpointMenuMax,
              divisions:
                  (kFlexfoldBreakpointMenuMax - kFlexfoldBreakpointMenuMin)
                      .floor(),
              label: ref.watch(breakpointMenuPod).floor().toString(),
              value: ref.watch(breakpointMenuPod),
              onChanged: (double value) {
                ref.read(breakpointMenuPod.notifier).state = value;
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
              ref.watch(breakpointMenuPod).floor().toString(),
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
