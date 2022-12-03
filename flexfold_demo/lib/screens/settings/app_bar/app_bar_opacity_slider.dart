import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';
import '../../../widgets/wrappers/maybe_tooltip.dart';

class AppBarOpacitySlider extends ConsumerWidget {
  const AppBarOpacitySlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Slider for AppBar opacity value in a ListTile.
    return ListTile(
      title: const Text('App bar opacity'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MaybeTooltip(
            condition: ref.watch(useTooltipsPod),
            tooltip: 'Flexfold(appBar: FlexfoldAppBar.styled(appBarOpacity: '
                '${ref.watch(appBarOpacityPod)}))\n\n'
                'Equivalent for Flexfold() properties menuAppBar '
                'and sidebarAppBar',
            child: Slider(
              min: 0,
              max: 100,
              divisions: 100,
              label: (ref.watch(appBarOpacityPod) * 100).floor().toString(),
              value: ref.watch(appBarOpacityPod) * 100,
              onChanged: (double value) {
                ref.read(appBarOpacityPod.notifier).state = value / 100;
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
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              (ref.watch(appBarOpacityPod) * 100).floor().toString(),
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
