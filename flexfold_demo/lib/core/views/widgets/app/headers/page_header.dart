import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';

// A page header widget that is used in this demo to show the value of the
// selected destination returned by Flexfold onDestination. Used only for
// demo purposes in the example application.
class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.icon,
    required this.heading,
    required this.destination,
  });

  final Widget icon;
  final Widget heading;
  final FlexTarget destination;

  @override
  Widget build(BuildContext context) {
    final Widget themedIcon = IconTheme(
      data: IconThemeData(
        size: 35,
        color: Theme.of(context).colorScheme.primary,
      ),
      child: icon,
    );
    final Widget styledLabel = DefaultTextStyle(
      style: Theme.of(context).textTheme.headlineMedium!,
      child: heading,
    );

    return Wrap(
      children: <Widget>[
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: themedIcon,
            ),
            SizedBox(
              width: 250,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: styledLabel,
              ),
            ),
          ],
        ),
        Wrap(
          children: <Widget>[
            SizedText('Route: ${destination.route}'),
            SizedText('Menu index: ${destination.index}'),
            SizedText('Bottom index: ${destination.bottomIndex}'),
            SizedText('Tapped: '
                '${destination.source.toString().dotTail.capitalize}'),
            SizedText(
                'Direction: ${destination.reverse ? 'Reverse' : 'Forward'}'),
            SizedText('Prefer push: ${destination.preferPush ? 'Yes' : 'No'}'),
          ],
        ),
      ],
    );
  }
}

class SizedText extends StatelessWidget {
  const SizedText(
    this.text, {
    super.key,
    this.maxWidth = 145,
  });

  final double maxWidth;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      child: Text(text, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
