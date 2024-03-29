import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/pods_theme.dart';

class DarkLevelSlider extends ConsumerWidget {
  const DarkLevelSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Slider(
        max: 100,
        divisions: 100,
        label: ref.watch(darkLevelPod).toString(),
        value: ref.watch(darkLevelPod).toDouble(),
        onChanged: (double value) {
          ref.read(darkLevelPod.notifier).state = value.floor();
        },
      ),
      trailing: Padding(
        padding: const EdgeInsetsDirectional.only(end: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'LEVEL',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '${ref.watch(darkLevelPod)} %',
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
