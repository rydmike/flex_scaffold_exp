import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/maybe_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

class MenuHighlightHeightSlider extends ConsumerWidget {
  const MenuHighlightHeightSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Slider in a ListTile to control when menu/rail is a drawer.
    return ListTile(
      title: const Text('Menu selection highlight height'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Default value is '
              '${kFlexfoldHighlightHeight.toStringAsFixed(0)} '
              'dp.'),
          MaybeTooltip(
            condition: ref.watch(useTooltipsPod),
            tooltip: 'Flexfold(menuHighlightHeight: '
                '${ref.watch(menuHighlightHeightPod).floor()})',
            child: Slider(
              min: kFlexfoldHighlightHeightMin,
              max: kFlexfoldHighlightHeightMax,
              divisions:
                  (kFlexfoldHighlightHeightMax - kFlexfoldHighlightHeightMin)
                      .floor(),
              label: ref.watch(menuHighlightHeightPod).floor().toString(),
              value: ref.watch(menuHighlightHeightPod),
              onChanged: (double value) {
                ref.read(menuHighlightHeightPod.notifier).state = value;
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
              ref.watch(menuHighlightHeightPod).floor().toString(),
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
