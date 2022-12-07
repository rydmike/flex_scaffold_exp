import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/pods_theme.dart';

class EnabledColorsSwitch extends ConsumerWidget {
  const EnabledColorsSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int usedColors = ref.watch(usedColorsPod);
    final List<bool> isSelected = <bool>[
      usedColors == 1,
      usedColors == 2,
      usedColors == 3,
      usedColors == 4,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(usedColorsPod.notifier).state = newIndex + 1;
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Prim\u{00AD}ary',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Prim\u{00AD}ary\nSecond\u{00AD}ary',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Prim\u{00AD}ary + variant\nSecond\u{00AD}ary',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Prim\u{00AD}ary + variant\nSecond\u{00AD}ary + variant',
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
