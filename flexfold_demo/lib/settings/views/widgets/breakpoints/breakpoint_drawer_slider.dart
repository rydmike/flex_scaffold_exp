import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/maybe_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

class BreakpointDrawerSlider extends ConsumerWidget {
  const BreakpointDrawerSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Slider in a ListTile to control when menu/rail is a drawer.
    return ListTile(
      title: const Text('Keep menu in drawer below height'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Default breakpoint API value is '
              '${kFlexfoldBreakpointDrawer.toStringAsFixed(0)} dp\n'
              'If you set this value to 0, you always get a rail on '
              'phones in landscape mode. With the default value it will '
              'be kept as a drawer, but you will still get a rail on '
              'tablets in portrait mode.'),
          MaybeTooltip(
            condition: ref.watch(useTooltipsPod),
            tooltip: 'FlexfoldThemeData(breakpointDrawer: '
                '${ref.watch(breakpointDrawerPod).floor()})',
            child: Slider(
              min: kFlexfoldBreakpointDrawerMin,
              max: kFlexfoldBreakpointDrawerMax,
              divisions:
                  (kFlexfoldBreakpointDrawerMax - kFlexfoldBreakpointDrawerMin)
                      .floor(),
              label: ref.watch(breakpointDrawerPod).floor().toString(),
              value: ref.watch(breakpointDrawerPod),
              onChanged: (double value) {
                ref.read(breakpointDrawerPod.notifier).state = value;
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
              'Height',
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              ref.watch(breakpointDrawerPod).floor().toString(),
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
