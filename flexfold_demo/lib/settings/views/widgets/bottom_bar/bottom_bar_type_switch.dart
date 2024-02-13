import 'package:flex_scaffold/flex_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/pods_flexfold.dart';

class BottomBarTypeSwitch extends ConsumerWidget {
  const BottomBarTypeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // treeDepthInfo(context, 'BottomBarTypeSwitch');
    final FlexBottomType type = ref.watch(bottomBarTypePod);
    final List<bool> isSelected = <bool>[
      type == FlexBottomType.material2,
      type == FlexBottomType.material3,
      type == FlexBottomType.cupertino,
      type == FlexBottomType.adaptive,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(bottomBarTypePod.notifier).state =
            FlexBottomType.values[newIndex];
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Material 2',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Material 3',
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
