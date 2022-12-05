import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods/pods_application.dart';
import '../pods/pods_theme.dart';

/// Wrap [child] with [Directionality] given, by context or forced by provider.
///
/// Also fixes DevicePreview.appBuilder conflicting [Brightness] compared to
/// platform brightness.
class DirectionalityWrapper extends ConsumerWidget {
  const DirectionalityWrapper({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Directionality(
      textDirection: ref.watch(appDirectionality) ?? Directionality.of(context),
      // DevicePreview.appBuilder contains brightness setting that can be in
      // conflict with the application's overall brightness that is defined by
      // the active MaterialApp's `theme` or `darkTheme` selected via
      // `themeMode`. To correct the situation we insert an extra builder
      // that overrides the theme brightness from DevicePreview with the
      // correct Brightness for the selected active themeMode and its
      // brightness.
      child: Builder(builder: (BuildContext context) {
        // Resolve which theme mode to use.
        final ThemeMode mode = ref.watch(themeModeProvider);
        final Brightness platformBrightness =
            MediaQuery.platformBrightnessOf(context);
        final bool useDarkTheme = mode == ThemeMode.dark ||
            (mode == ThemeMode.system && platformBrightness == Brightness.dark);
        return Theme(
          data: Theme.of(context).copyWith(
              brightness: useDarkTheme ? Brightness.dark : Brightness.light),
          // Home screen is a layout shell with a single FlexScaffold
          // using a nested navigator as its body. The screens used by
          // FlexScaffold normally only contain and change the part that goes
          // into the body of the scaffold, thus in tablet, desktop and web
          // views, only the body part uses the desired page transition
          // effect for each navigation mode.
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: FlexColorScheme.themedSystemNavigationBar(
              context,
              useDivider: false,
            ),
            child: child,
          ),
        );
      }),
    );
    // });
  }
}
