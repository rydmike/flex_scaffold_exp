import 'package:flutter/material.dart';

import '../../utils/app_insets.dart';

/// Wrap the child with a Card if the condition is true, if
/// condition is false, just return the child.
///
/// The "Maybe" widgets are small simple pre-styled wrapper widgets, that
/// wrap a widget with specific pre-styled widget, that we may want to wrap
/// another widget with sometimes, but at other times not.
///
/// A typical use is eg this card widget, that just wraps the child with a
/// pre-styled card, it is used to wrap some content in a card at desktop size
/// but not at phone and tablet size where the extra wrapping looks bad.
class MaybeCard extends StatelessWidget {
  const MaybeCard({
    super.key,
    required this.condition,
    required this.child,
  });

  final bool condition;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: AppInsets.l),
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        child: child,
      );
    } else {
      // This material transparency gives uf hover effects on
      // all the controls inside it. The Card above gives them too.
      return Material(type: MaterialType.transparency, child: child);
    }
  }
}
