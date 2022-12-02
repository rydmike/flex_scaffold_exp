import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_theme.dart';

class LightAppBarSwitch extends ConsumerWidget {
  const LightAppBarSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FlexAppBarStyle style = ref.watch(lightAppBarStylePod);
    final List<bool> isSelected = <bool>[
      style == FlexAppBarStyle.primary,
      style == FlexAppBarStyle.material,
      style == FlexAppBarStyle.surface,
      style == FlexAppBarStyle.background,
      style == FlexAppBarStyle.custom,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(lightAppBarStylePod.notifier).state =
            FlexAppBarStyle.values[newIndex];
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Prim\u{00AD}ary\ncolor',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'De\u{00AD}fault\nback\u{00AD}ground',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Brand\u{00AD}ed\nsurface',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Brand\u{00AD}ed\nback\u{00AD}ground',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Custom\ncolor',
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
