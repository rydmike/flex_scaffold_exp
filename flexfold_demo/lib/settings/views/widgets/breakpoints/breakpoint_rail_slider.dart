import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/maybe_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

class BreakpointRailSlider extends ConsumerWidget {
  const BreakpointRailSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Slider in a ListTile for rail breakpoint control.
    return ListTile(
      title: const Text('Break from bottom navigation bar to rail at width'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Default breakpoint API value is '
              '${kFlexBreakpointRail.toStringAsFixed(0)} dp.'),
          MaybeTooltip(
            condition: ref.watch(useTooltipsPod),
            tooltip: 'FlexfoldThemeData(breakpointRail: '
                '${ref.watch(breakpointRailPod).floor()})',
            child: Slider(
              min: kFlexBreakpointRailMin,
              max: kFlexBreakpointRailMax,
              divisions:
                  (kFlexBreakpointRailMax - kFlexBreakpointRailMin).floor(),
              label: ref.watch(breakpointRailPod).floor().toString(),
              value: ref.watch(breakpointRailPod),
              onChanged: (double value) {
                ref.read(breakpointRailPod.notifier).state = value;
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
              ref.watch(breakpointRailPod).floor().toString(),
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
