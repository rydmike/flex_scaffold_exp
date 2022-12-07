import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/maybe_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

class RailWidthSlider extends ConsumerWidget {
  const RailWidthSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Slider control in a ListTile for rail width.
    return ListTile(
      title: const Text('Rail width'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('API default value is '
              '${kFlexfoldRailWidth.toStringAsFixed(0)} dp, '
              'same as default app bar menu icon width. '
              'In this demo the leading widget on the menu '
              'bar also uses the rail width as its width and this demo '
              'app uses 58 dp as default start value since it can fit '
              'an iOS switch better.'),
          MaybeTooltip(
            condition: ref.read(useTooltipsPod),
            tooltip: 'Flexfold(railWidth: ${ref.watch(railWidthPod).floor()})',
            child: Slider(
              min: kFlexfoldRailWidthMin,
              max: kFlexfoldRailWidthMax,
              divisions:
                  (kFlexfoldRailWidthMax - kFlexfoldRailWidthMin).floor(),
              label: ref.watch(railWidthPod).floor().toString(),
              value: ref.watch(railWidthPod),
              onChanged: (double value) {
                ref.read(railWidthPod.notifier).state = value;
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
              ref.watch(railWidthPod).floor().toString(),
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
