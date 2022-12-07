import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations.dart';
import 'package:sa3_liquid/sa3_liquid.dart';

class PlasmaBackground extends StatelessWidget {
  const PlasmaBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final Color foregroundColor = isLight
        ? Theme.of(context).primaryColorLight.lighten(98)
        : Theme.of(context).primaryColorDark.darken(98);
    final Color backgroundColor = isLight
        ? Theme.of(context).primaryColorLight.lighten(15)
        : Theme.of(context).primaryColorDark.darken(25);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[foregroundColor, backgroundColor],
          stops: const <double>[0, 1],
        ),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: PlasmaRenderer(
        particles: 10,
        color: foregroundColor,
        size: 0.6,
        speed: 5.1,
        offset: 0,
        fps: 30,
        blendMode: BlendMode.hardLight,
        child: child,
      ),
    );
  }
}
