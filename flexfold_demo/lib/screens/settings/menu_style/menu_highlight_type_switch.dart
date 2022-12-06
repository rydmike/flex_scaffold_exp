import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_flexfold.dart';

class MenuHighlightTypeSwitch extends ConsumerWidget {
  const MenuHighlightTypeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FlexIndicatorStyle style = ref.watch(menuHighlightTypePod);
    final List<bool> isSelected = <bool>[
      style == FlexIndicatorStyle.none,
      style == FlexIndicatorStyle.row,
      style == FlexIndicatorStyle.box,
      style == FlexIndicatorStyle.stadium,
      style == FlexIndicatorStyle.endStadium,
      style == FlexIndicatorStyle.startBar,
      style == FlexIndicatorStyle.endBar,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(menuHighlightTypePod.notifier).state =
            FlexIndicatorStyle.values[newIndex];
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'None',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Row',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Box',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Sta\u{00AD}dium',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'End stadium',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Start bar',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'End bar',
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
