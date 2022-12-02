import 'package:flutter/material.dart';

import '../../widgets/wrappers/maybe_tooltip.dart';

// This is simple wrapper of the SwitchListTile.adaptive widget, used to
// wrap it with a tooltip and show the provided tooltip if one is provided.
// and the application settings say we should show it.
//
// In this app this is used to show the Flexfold API property behind the
// toggle switch.
class SwitchTileTooltip extends StatelessWidget {
  const SwitchTileTooltip({
    super.key,
    required this.value,
    required this.onChanged,
    this.title,
    this.subtitle,
    this.tooltip,
    this.tooltipEnabled = false,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget? title;
  final Widget? subtitle;
  final String? tooltip;
  final bool tooltipEnabled;

  @override
  Widget build(BuildContext context) {
    return MaybeTooltip(
      condition: tooltipEnabled,
      tooltip: tooltip,
      child: SwitchListTile.adaptive(
        value: value,
        onChanged: onChanged,
        title: title,
        subtitle: subtitle,
      ),
    );
  }
}
