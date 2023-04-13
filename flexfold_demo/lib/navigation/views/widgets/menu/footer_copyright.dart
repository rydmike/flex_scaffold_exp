import 'package:flutter/material.dart';

// A demo widget used as footer for the Flexfold menu
class FooterCopyright extends StatelessWidget {
  const FooterCopyright({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(9, 6, 8, 10),
        child: Row(
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 65),
              child: Text('© 2022', style: textTheme.bodySmall),
            ),
            Text('M.Rydstrom', style: textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
