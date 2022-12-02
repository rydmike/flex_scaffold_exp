import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods_theme.dart';
import '../../../utils/app_insets.dart';

const double _kWidthOfScrollItem = 74;

/// Horizontal theme selector of themes offered by the FlexThemes.
///
/// This example uses a StatefulWidget and passed in index of current
/// selected theme. The index are just the based on order of the themes in
/// the enum FlexTheme as FlexTheme.values with selected index.
class ThemeSelector extends ConsumerStatefulWidget {
  const ThemeSelector({
    super.key,
  });

  @override
  ConsumerState<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends ConsumerState<ThemeSelector> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
        keepScrollOffset: true,
        initialScrollOffset: _kWidthOfScrollItem * ref.read(schemeIndexPod));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: Row(children: <Widget>[
        const SizedBox(width: AppInsets.l),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: ref.read(schemesProvider).length,
            itemBuilder: (BuildContext context, int index) {
              final bool isLight =
                  Theme.of(context).brightness == Brightness.light;
              return FlexThemeModeOptionButton(
                onSelect: () async {
                  setState(() {
                    scrollController.animateTo(_kWidthOfScrollItem * index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut);
                  });
                  ref.read(schemeIndexPod.notifier).state = index;
                },
                selected: ref.read(schemeIndexPod.notifier).state == index,
                backgroundColor: Theme.of(context).colorScheme.surface,
                flexSchemeColor: isLight
                    ? ref.read(schemesProvider)[index].light
                    : ref.read(schemesProvider)[index].dark,
              );
            },
          ),
        ),
        const SizedBox(width: AppInsets.l),
      ]),
    );
  }
}
