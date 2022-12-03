import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_theme.dart';
import '../../../utils/app_insets.dart';
import '../../../widgets/list_tiles/switch_list_tile_adaptive.dart';

/// Draws selectors for Light, Dark and system theme mode using the current
/// FlexTheme's colors in the 3 way toggle widget.
class ThemeModeSwitch extends ConsumerWidget {
  const ThemeModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double width = MediaQuery.of(context).size.width;

    return FlexThemeModeSwitch(
      title: Row(children: <Widget>[
        const SizedBox(width: AppInsets.l),
        Expanded(
          child:
              Text('Theme mode', style: Theme.of(context).textTheme.subtitle1),
        ),
        if (isDark && width >= 460)
          SizedBox(
            width: 145,
            child: SwitchListTileAdaptive(
              subtitle: const Text('True\nblack'),
              value: ref.watch(darkIsTrueBlackPod),
              onChanged: (bool value) {
                ref.read(darkIsTrueBlackPod.notifier).state = value;
              },
            ),
          ),
      ]),
      themeMode: ref.watch(themeModePod),
      onThemeModeChanged: (ThemeMode themeMode) {
        ref.read(themeModePod.notifier).state = themeMode;
      },
      flexSchemeData: ref.watch(currentSchemePod),
      // Style the selected theme mode's label
      selectedLabelStyle: Theme.of(context).textTheme.caption!.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary),
    );
  }
}
