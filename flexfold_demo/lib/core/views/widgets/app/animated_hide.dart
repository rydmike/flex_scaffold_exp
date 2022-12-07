import 'package:flutter/material.dart';

/// This widget is good for using a boolean condition to show/hide the [child]
/// widget. It is a simple convenience wrapper for AnimatedSwitcher
/// where the Widget that it is Switched to is an invisible SizedBox.shrink()
/// effectively removing the child by animation to a zero sized widget instead.
class AnimatedSwitchShowHide extends StatelessWidget {
  const AnimatedSwitchShowHide({
    super.key,
    required this.show,
    this.duration = const Duration(milliseconds: 300),
    required this.child,
  });

  /// Set hide to true to remove the child with size transition.
  final bool show;

  /// The duration of the hide animation.
  final Duration duration;

  /// The widget to be conditionally hidden, when hide is true.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: child,
        );
      },
      child: show ? child : const SizedBox.shrink(),
    );
  }
}

/// This widget is good for using a boolean condition to fade the [child]
/// widget. It is a simple convenience wrapper for AnimatedFade
/// where the Widget that it is Faded to is an invisible SizedBox.shrink()
/// effectively removing the child by fading it to a zero sized widget instead.
class AnimatedFadeShowHide extends StatelessWidget {
  const AnimatedFadeShowHide({
    super.key,
    required this.show,
    this.duration = const Duration(milliseconds: 300),
    required this.child,
  });

  /// Set show to true to show child with size transition, false to hide it.
  final bool show;

  /// The duration of the show/hide animation.
  final Duration duration;

  /// The widget to be conditionally hidden, when hide is true.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: duration,
      firstChild: child,
      secondChild: const SizedBox.shrink(),
      crossFadeState:
          show ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
