import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/pods_theme.dart';

class TabBarStyleSwitch extends ConsumerWidget {
  const TabBarStyleSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FlexTabBarStyle style = ref.watch(tabBarStylePod);
    final List<bool> isSelected = <bool>[
      style == FlexTabBarStyle.forAppBar,
      style == FlexTabBarStyle.forBackground,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(tabBarStylePod.notifier).state =
            FlexTabBarStyle.values[newIndex];
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'TabBar used\nin AppBar',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'TabBar used\non background',
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
