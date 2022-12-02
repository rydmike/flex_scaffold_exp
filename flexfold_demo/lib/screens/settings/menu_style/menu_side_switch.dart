import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';

class MenuSideSwitch extends ConsumerWidget {
  const MenuSideSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // treeDepthInfo(context, 'MenuSideSwitch');
    final FlexfoldMenuSide side = ref.watch(menuSidePod);
    final List<bool> isSelected = <bool>[
      side == FlexfoldMenuSide.start,
      side == FlexfoldMenuSide.end,
      side == FlexfoldMenuSide.top,
      side == FlexfoldMenuSide.float,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(menuSidePod.notifier).state =
            FlexfoldMenuSide.values[newIndex];
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'At screen\nstart side',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'At screen\nend side',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'At screen\ntop',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Free\nfloating',
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
