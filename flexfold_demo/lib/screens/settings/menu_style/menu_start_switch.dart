import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';

class MenuStartSwitch extends ConsumerWidget {
  const MenuStartSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FlexfoldMenuStart style = ref.watch(menuStartPod);
    final List<bool> isSelected = <bool>[
      style == FlexfoldMenuStart.top,
      style == FlexfoldMenuStart.bottom,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(menuStartPod.notifier).state =
            FlexfoldMenuStart.values[newIndex];
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'From the\ntop',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'From the\nbottom',
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
