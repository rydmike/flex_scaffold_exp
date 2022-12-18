import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/menu_alignment.dart';
import '../../../controllers/pods_flexfold.dart';

class MenuAlignmentSwitch extends ConsumerWidget {
  const MenuAlignmentSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MenuAlignment style = ref.watch(menuAlignmentPod);
    final List<bool> isSelected = <bool>[
      style == MenuAlignment.top,
      style == MenuAlignment.center,
      style == MenuAlignment.bottom,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(menuAlignmentPod.notifier).state =
            MenuAlignment.values[newIndex];
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Menu\nat top',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Centered\nmenu',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Menu at\nbottom',
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
