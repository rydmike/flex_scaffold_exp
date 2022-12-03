import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';

class BottomBarTypeSwitch extends ConsumerWidget {
  const BottomBarTypeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // treeDepthInfo(context, 'BottomBarTypeSwitch');
    final FlexfoldBottomBarType type = ref.watch(bottomBarTypePod);
    final List<bool> isSelected = <bool>[
      type == FlexfoldBottomBarType.material2,
      type == FlexfoldBottomBarType.material3,
      type == FlexfoldBottomBarType.cupertino,
      type == FlexfoldBottomBarType.adaptive,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(bottomBarTypePod.notifier).state =
            FlexfoldBottomBarType.values[newIndex];
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Material',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Material You',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Cupertino',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Adaptive',
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
