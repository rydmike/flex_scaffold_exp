import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_theme.dart';
import '../../../utils/app_insets.dart';

class ThemePopupMenu extends ConsumerWidget {
  const ThemePopupMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return PopupMenuButton<int>(
      padding: EdgeInsets.zero,
      onSelected: (int selected) {
        ref.read(schemeIndexPod.notifier).state = selected;
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<int>>[
          for (final FlexSchemeData scheme in ref.watch(schemesProvider))
            PopupMenuItem<int>(
              value: ref.watch(schemesProvider).indexOf(scheme),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(scheme.name),
                trailing: SizedBox(
                  width: 50,
                  child: FlexThemeModeOptionButton(
                    flexSchemeColor: isLight ? scheme.light : scheme.dark,
                    selected: true,
                    selectedBorder: BorderSide(
                      color:
                          isLight ? scheme.light.primary : scheme.dark.primary,
                      width: AppInsets.outlineThickness,
                    ),
                    // backgroundColor: colorScheme.background,
                    optionButtonPadding: const EdgeInsets.only(top: 3),
                    optionButtonMargin: const EdgeInsets.all(3),
                    optionButtonBorderRadius: 4,
                    width: 16,
                    height: 16,
                    padding: const EdgeInsets.all(2),
                    borderRadius: 2,
                  ),
                ),
              ),
            )
        ];
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: AppInsets.l),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text('${ref.watch(currentSchemePod).name} theme'),
                subtitle: Text(ref.watch(currentSchemePod).description),
              ),
            ),
            SizedBox(
              height: 68,
              child: FlexThemeModeOptionButton(
                flexSchemeColor: FlexSchemeColor(
                  primary: colorScheme.primary,
                  primaryContainer: colorScheme.primaryContainer,
                  secondary: colorScheme.secondary,
                  secondaryContainer: colorScheme.secondaryContainer,
                ),
                selected: true,
                optionButtonPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
