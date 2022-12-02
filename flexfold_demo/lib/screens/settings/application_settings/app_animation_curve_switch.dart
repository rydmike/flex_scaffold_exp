import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/app_animation_curve.dart';
import '../../../pods/pods_flexfold.dart';

class AppAnimationCurveSwitch extends ConsumerWidget {
  const AppAnimationCurveSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // treeDepthInfo(context, 'AppAnimationCurveSwitch');
    final AppAnimationCurve animCurve = ref.watch(animationCurvePod);
    final List<bool> isSelected = <bool>[
      animCurve == AppAnimationCurve.linear,
      animCurve == AppAnimationCurve.easeInOut,
      animCurve == AppAnimationCurve.easeInOutQuart,
      animCurve == AppAnimationCurve.easeInOutExpo,
      animCurve == AppAnimationCurve.bounceOut,
    ];

    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        ref.read(animationCurvePod.notifier).state =
            AppAnimationCurve.values[newIndex];
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Line\u{00AD}ar',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Ease In Out',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Ease In Out Quart',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Ease In Out Expo',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Text(
            'Bounce out',
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
