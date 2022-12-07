import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/widgets/app/maybe_tooltip.dart';
import '../../../../settings/controllers/pods_flexfold.dart';
import '../../../../theme/controllers/pods_theme.dart';

class TrailingThemeToggle extends ConsumerWidget {
  const TrailingThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final Color baseUnselectedColor =
        theme.colorScheme.onSurface.withOpacity(0.64);

    // TODO(rydmike): Check if we should use FlexfoldTheme instead of rail!
    final NavigationRailThemeData railTheme = theme.navigationRailTheme;
    final TextStyle txtStyle = theme.textTheme.bodyText1!
        .copyWith(color: baseUnselectedColor)
        .merge(railTheme.unselectedLabelTextStyle);

    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool isDrawerOpen = scaffold?.isDrawerOpen ?? false;
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return SafeArea(
      bottom: false,
      top: false,
      right: isRTL,
      left: !isRTL,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                if (isDrawerOpen) {
                  Navigator.of(context).pop();
                }
                if (isDark) {
                  ref.read(themeModeProvider.notifier).state = ThemeMode.light;
                } else {
                  ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                    child: MaybeTooltip(
                      tooltip: 'Toggle dark/light theme',
                      condition: ref.watch(useTooltipsPod),
                      child: Switch.adaptive(
                        value: isDark,
                        onChanged: (bool value) {
                          if (isDrawerOpen) {
                            Navigator.of(context).pop();
                          }
                          if (isDark) {
                            ref.read(themeModeProvider.notifier).state =
                                ThemeMode.light;
                          } else {
                            ref.read(themeModeProvider.notifier).state =
                                ThemeMode.dark;
                          }
                        },
                      ),
                    ),
                  ),
                  Text('Dark theme', style: txtStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
