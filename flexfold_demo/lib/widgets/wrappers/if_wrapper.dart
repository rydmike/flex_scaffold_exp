import 'package:flutter/material.dart';

typedef IfWrapBuilder = Widget Function(BuildContext context, Widget child);

/// A builder that if the condition is true, will run its builder and the child
/// will be wrapped by the builder, if false it just returns the child.
///
/// A convenient way to wrap a widget with another built widget, but only if
/// the condition is true. It can save you from having to define a large widget,
/// assign it to a Widget itself wrapped with another widget.
///
/// Widget widgetA = WidgetX(...);
/// if (condition) widgetA = WidgetY(child: widgetA);
///
/// Becomes:
///
/// IfWrapper(condition: condition,
///   builder: (context, child) {
///     return WidgetY(child: child); },
///   child: child
/// );
class IfWrapper extends StatelessWidget {
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

  /// How to display the widget if [condition] is false;
  final IfWrapBuilder? ifFalse;

  /// The widget to be conditionally wrapped. This will be displayed alone
  /// if [condition] is false.
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
