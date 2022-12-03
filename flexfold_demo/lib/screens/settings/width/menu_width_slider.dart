import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/wrappers/maybe_tooltip.dart';

class MenuWidthSlider extends ConsumerWidget {
  const MenuWidthSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Slider control in a ListTile for menu width
    return ListTile(
      title: const Text('Menu width'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Default width is '
              '${kFlexfoldMenuWidth.toStringAsFixed(0)} dp.'),
          MaybeTooltip(
            condition: ref.read(useTooltipsPod),
            tooltip: 'Flexfold(menuWidth: ${ref.watch(menuWidthPod).floor()})',
            child: Slider(
              min: kFlexfoldMenuWidthMin,
              max: kFlexfoldMenuWidthMax,
              divisions:
                  (kFlexfoldMenuWidthMax - kFlexfoldMenuWidthMin).floor(),
              label: ref.watch(menuWidthPod).floor().toString(),
              value: ref.watch(menuWidthPod),
              onChanged: (double value) {
                ref.read(menuWidthPod.notifier).state = value;
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
              ref.watch(menuWidthPod).floor().toString(),
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
