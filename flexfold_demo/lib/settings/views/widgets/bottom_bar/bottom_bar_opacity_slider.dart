import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/maybe_tooltip.dart';
import '../../../controllers/pods_flexfold.dart';

class BottomBarOpacitySlider extends ConsumerWidget {
  const BottomBarOpacitySlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Slider for bottom bar opacity value in a ListTile.
    return ListTile(
      title: const Text('Bottom bar opacity'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MaybeTooltip(
            condition: ref.watch(useTooltipsPod),
            tooltip: 'FlexfoldThemeData(bottomBarOpacity: '
                '${ref.watch(bottomBarOpacityPod)})',
            child: Slider(
              min: 0,
              max: 100,
              divisions: 100,
              label: (ref.watch(bottomBarOpacityPod) * 100).floor().toString(),
              value: ref.watch(bottomBarOpacityPod) * 100,
              onChanged: (double value) {
                ref.read(bottomBarOpacityPod.notifier).state = value / 100;
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
              '%',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              (ref.watch(bottomBarOpacityPod) * 100).floor().toString(),
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
