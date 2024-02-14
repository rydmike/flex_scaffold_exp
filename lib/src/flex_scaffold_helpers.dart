import 'dart:math' as math;

import 'package:flutter/material.dart';

// These helper classes are NOT exported by the Flexfold library, they are
// only used as internal helper classes, functions and extensions.

/// Used to track the direction of a new index value in relation to its
/// previous value.
///
/// This information is useful for going forward or back in a navigation bar,
/// which can be used/ for different animation on forward and back from
/// current index.
class IndexTracker {
  int _index = 0;

  /// Returns the current index of the index tracker.
  int get index => _index;
  bool _reverse = false;

  /// Indicates whether we're going forward or backward in terms of the index
  /// we're changing. This can be used for the page transition directions.
  bool get reverse => _reverse;

  /// Set provided index as selected. Only one index can be selected,
  /// any other selected index will be set to unselected.
  void setIndex(int? value) {
    if ((value ?? 0) < _index) {
      _reverse = true;
    } else {
      _reverse = false;
    }
    _index = value ?? 0;
  }

  /// Returns true is the provided index is selected.
  bool isIndexSelected(int index) => _index == index;
}

/// Type definition for the builder function used by IfWrapper.
typedef IfWrapBuilder = Widget Function(BuildContext context, Widget child);

/// A builder that if the [condition] is true, will run its builder and the
/// child will be wrapped by the builder, if false it just returns the child.
///
/// A convenient way to wrap a widget with another widget, but only if
/// the condition is true. It can save you from having to define a large widget,
/// assign it to a Widget itself wrapped with another widget.
///
/// Widget widgetA = WidgetX(...);
/// if (condition) widgetA = WidgetY(child: widgetA);
///
/// Becomes:
/// IfWrapper(condition: condition,
///   builder: (context, child) {
///     return WidgetY(child: child) }
///   child: child
/// );
class IfWrapper extends StatelessWidget {
  /// Default constructor.
  const IfWrapper({
    super.key,
    required this.condition,
    required this.builder,
    required this.child,
    this.ifFalse,
  });

  /// if [condition] evaluates to true, the builder will be run and the child
  /// will be wrapped. If false, only the child is returned.
  final bool condition;

  /// How to display the widget if [condition] is true;
  final IfWrapBuilder builder;

  /// How to display the widget if [condition] is true;
  final IfWrapBuilder? ifFalse;

  /// The widget to be conditionally wrapped, it will be returned alone without
  /// the wrapping Widget if [condition] is false.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return builder(context, child);
    } else if (ifFalse != null) {
      return ifFalse!(context, child);
    } else {
      return child;
    }
  }
}

/// Wrap the [child] with a [Tooltip] if [condition] is true, if
/// [condition] is false, just return the [child].
///
/// Currently only uses the default constructor with just
/// a tooltip string as the only property in addition to the condition and child
/// to wrap with a tooltip if the condition is true.
/// The rest of the Tooltip properties will be modified and changed by any
/// Tooltip theme that is used by the application where Flexfold is used.
class MaybeTooltip extends StatelessWidget {
  /// Default constructor.
  const MaybeTooltip({
    super.key,
    this.condition = false,
    this.tooltip,
    required this.child,
  });

  /// Set to true of the tooltip wrapper should show a tooltip
  final bool condition;

  /// Tooltip message, if null or empty, there is no tooltip.
  final String? tooltip;

  /// The child to be wrapped in a potential tooltip.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (condition && tooltip != null && tooltip != '') {
      return Tooltip(
        message: tooltip ?? '',
        child: child,
      );
    } else {
      return child;
    }
  }
}

/// Extension methods that mimic some of TinyColor's functions
/// https://pub.dev/packages/tinycolor
/// Included functions from TinyColor re-implemented as color extension are:
/// * lighten (int)
/// * darken(int)
extension FlexScaffoldColorExtensions on Color {
  /// Like TinyColor's lighten function, it lightens the color with the
  /// given percentage amount.
  Color lighten([int amount = 10]) {
    // HSLColor returns saturation 1 for black, we want 0 to be able lighten
    // black color up along grey scale from black.
    final HSLColor hsl = this == const Color(0xFF000000)
        ? HSLColor.fromColor(this).withSaturation(0)
        : HSLColor.fromColor(this);
    return hsl
        .withLightness(math.min(1, math.max(0, hsl.lightness + amount / 100)))
        .toColor();
  }

  /// Like TinyColor's darken function, it darkens the color with the
  /// given percentage amount.
  Color darken([int amount = 10]) {
    final HSLColor hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness(math.min(1, math.max(0, hsl.lightness - amount / 100)))
        .toColor();
  }
}
