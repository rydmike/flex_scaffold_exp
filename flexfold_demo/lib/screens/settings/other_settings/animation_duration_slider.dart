import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/wrappers/maybe_tooltip.dart';

class AnimationDurationSlider extends ConsumerWidget {
  const AnimationDurationSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Slider for menu animation time in a ListTile.
    return ListTile(
      title: const Text('Menu animation duration'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Default API value is 246 ms, this matches '
              'the Material Drawer animation time.'),
          MaybeTooltip(
            condition: ref.watch(useTooltipsPod),
            tooltip: 'FlexfoldThemeData(\n'
                '  menuAnimationDuration: Duration(milliseconds: '
                '${ref.watch(animationDurationPod)}),\n'
                '  sidebarAnimationDuration: Duration(milliseconds: '
                '${ref.watch(animationDurationPod)}),\n'
                '  bottomBarAnimationDuration: Duration(milliseconds: '
                '${ref.watch(animationDurationPod)}))',
            child: Slider.adaptive(
              min: 0,
              max: 1500,
              divisions: 500,
              label: ref.watch(animationDurationPod).toString(),
              value: ref.watch(animationDurationPod).toDouble(),
              onChanged: (double value) {
                ref.read(animationDurationPod.notifier).state = value.floor();
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
              'ms',
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              ref.watch(animationDurationPod).toString(),
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
