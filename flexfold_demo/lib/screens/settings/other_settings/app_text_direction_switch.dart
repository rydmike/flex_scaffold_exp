import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/app_text_direction.dart';
import '../../../pods/pods_application.dart';

class AppTextDirectionSwitch extends ConsumerWidget {
  const AppTextDirectionSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // treeDepthInfo(context, 'AppTextDirectionSwitch');
    final AppTextDirection type = ref.watch(appTextDirectionProvider);
    final List<bool> isSelected = <bool>[
      type == AppTextDirection.localeBased,
      type == AppTextDirection.ltr,
      type == AppTextDirection.rtl,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(appTextDirectionProvider.notifier).state =
            AppTextDirection.values[newIndex];
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Text direction\nusing device locale',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Text direction\nleft to right',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Text direction\nright to left',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
