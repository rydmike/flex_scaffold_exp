import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/controllers/pods_theme.dart';

// Define some extra custom colors, just as an example.
const Color kBluePicton = Color(0xFF3db5e0);
const Color kBlueSanMarino = Color(0xFF4f75b8);
const Color kBlueChatham = Color(0xFF174378);
const Color kBlueCatalina = Color(0xFF132b80);

/// A [ColorPicker] that shows a dialog, when a child, normally Material
/// is wrapped in an InkWell.
///
/// It uses a stateless color InkWell. Clicking on it allows the user to
/// change the color using a custom
/// [ColorPicker] package via a dialog. The indicator has an onChanged
/// callback that can be used to follow the changes of the color in the
/// dialog as user tries different colors. If the users closes the dialog
/// via cancel or barrier dismiss, the wasCancelled returns true.
/// This widget is stateless so it will be up to the user of this
/// widget to hold state and return the color to the state it had
/// when dialog was opened, if so desired.
///
/// This picker is implemented this way so that we can get the selected
/// color via a callback and use the received color to change the theme of
/// the application and allow it to rebuild the theme of the entire app and the
/// screens of the context that opened the dialog. Since the dialog is stateless
/// it can be kept open even though the app under it is being rebuilt.
class ColorPickerInkWell extends ConsumerWidget {
  const ColorPickerInkWell({
    super.key,
    required this.color,
    required this.onChanged,
    required this.wasCancelled,
    this.pickerSize = 40,
    this.enabled = false,
    required this.child,
  });

  final Color color;
  final ValueChanged<Color> onChanged;
  final ValueChanged<bool> wasCancelled;

  final double pickerSize;
  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<ColorPickerType, bool> pickersEnabled = <ColorPickerType, bool>{
      ColorPickerType.both: false,
      ColorPickerType.primary: true,
      ColorPickerType.accent: true,
      ColorPickerType.bw: false,
      ColorPickerType.custom: true,
      ColorPickerType.wheel: true,
    };

    final bool isLight = Theme.of(context).brightness == Brightness.light;

    // Make a custom color swatch to name map from custom colors and material
    // colors and custom colors in FlexColors, we add colors based on if
    // they are intended to be used with the active light/dark mode, so we
    // do not pollute it with theme colors that are not intended for nor very
    // useful in the active theme mode.
    final Map<ColorSwatch<Object>, String> customSwatches =
        <ColorSwatch<Object>, String>{
      // Creating material primary swatches with [ColorTools] is a shortcut
      // to make a Material primary swatch from a single color where the
      // provided color is used as the [500] color. The created swatch will not
      // be as balanced and nice as manually tuned swatch, but usable.
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.materialLightPrimary):
            'Purple primary',
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.materialLightPrimaryVariant):
            'Purple secondary',
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.materialLightPrimaryHc):
            'Blue primary high contrast',
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.materialLightPrimaryVariantHc):
            'Blue secondary high contrast',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.materialDarkPrimary):
            'Purple primary dark theme',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.materialDarkPrimaryHc):
            'Purple primary high contrast dark theme',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.materialDarkPrimaryVariantHc):
            'Purple primary variant high contrast dark theme',
      ColorTools.createPrimarySwatch(FlexColor.materialLightSecondary):
          'Teal secondary',
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.materialLightSecondaryVariant):
            'Teal secondary variant',
      ColorTools.createPrimarySwatch(FlexColor.materialLightSecondaryHc):
          'Teal secondary high contrast',
      //
      // Custom blue colors
      ColorTools.createPrimarySwatch(kBluePicton): 'Blue picton',
      if (!isLight)
        ColorTools.createPrimarySwatch(kBlueSanMarino): 'Blue SanMarino',
      ColorTools.createPrimarySwatch(kBlueChatham): 'Blue Chatham',
      if (isLight)
        ColorTools.createPrimarySwatch(kBlueCatalina): 'Blue Catalina',
      //
      // The Google Material red error colors
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.materialLightError):
            'Error light theme',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.materialDarkError):
            'Error dark theme',
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.materialLightErrorHc):
            'Error high contrast light theme',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.materialDarkErrorHc):
            'Error high contrast dark theme',
      //
      // Custom red colors
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.redWineLightPrimary): 'Merlot',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.redWineDarkPrimary):
            'Cranberry',
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.sakuraLightPrimary):
            'Cranberry',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.sakuraDarkPrimary): 'Melanie',
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.sakuraLightPrimaryVariant):
            'Cabaret',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.sakuraDarkPrimaryVariant):
            'Melanie',
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.sakuraLightSecondary):
            'Rose bud',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.sakuraDarkSecondary): 'Almond',
      //
      // Custom green colors
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.moneyLightPrimary):
            'Everglade',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.moneyDarkPrimary): 'Bay Leaf',
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.moneyLightSecondary): 'Pesto',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.moneyDarkSecondary):
            'Thistle green',
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.moneyLightSecondaryVariant):
            'Woodland',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.moneyDarkSecondaryVariant):
            'Gimblet',
      //
      // Custom orange colors
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.goldLightPrimary): 'Bourbon',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.goldDarkPrimary): 'Porsche',
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.goldLightPrimaryVariant):
            'Meteor',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.goldDarkPrimaryVariant):
            'Manhattan',
      if (isLight)
        ColorTools.createPrimarySwatch(FlexColor.goldLightSecondary): 'Rope',
      if (!isLight)
        ColorTools.createPrimarySwatch(FlexColor.goldDarkSecondary):
            'Copperfield',
    };

    return InkWell(
      // We want a bit more pronounced hover color for this case than normally.
      hoverColor: isLight ? const Color(0x50BCBCBC) : const Color(0x99555555),
      onTap: enabled
          ? () async {
              if (await ColorPicker(
                color: color,
                onColorChanged: onChanged,
                crossAxisAlignment: CrossAxisAlignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                enableShadesSelection: true,
                width: 35,
                height: 35,
                spacing: 3,
                runSpacing: 3,
                elevation: 0,
                hasBorder: false,
                borderRadius: 4,
                wheelDiameter: 175,
                wheelHasBorder: false,
                pickersEnabled: pickersEnabled,
                recentColors: ref.watch(dialogRecentColorsPod),
                maxRecentColors: 10,
                onRecentColorsChanged: (List<Color> colors) {
                  ref.read(dialogRecentColorsPod.notifier).state = colors;
                },
                title: Text('Select color',
                    style: Theme.of(context).textTheme.titleLarge),
                subheading: Text('Select color shade',
                    style: Theme.of(context).textTheme.bodyMedium),
                wheelSubheading: Text('Selected color and its shades',
                    style: Theme.of(context).textTheme.bodyMedium),
                recentColorsSubheading: Text('Recent colors',
                    style: Theme.of(context).textTheme.bodyMedium),
                showMaterialName: true,
                showColorName: true,
                showColorCode: true,
                customColorSwatchesAndNames: customSwatches,
                colorNameTextStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                materialNameTextStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                  longPressMenu: true,
                  editUsesParsedPaste: true,
                  copyButton: true,
                  pasteButton: true,
                ),
                actionButtons: const ColorPickerActionButtons(
                  closeButton: true,
                  okButton: true,
                  dialogActionButtons: false,
                ),
                showRecentColors: true,
              ).showPickerDialog(
                context,
                insetPadding: EdgeInsets.zero,
                barrierColor: Colors.black.withOpacity(0.01),
                constraints: const BoxConstraints(
                  minHeight: 500,
                  minWidth: 450,
                  maxWidth: 450,
                ),
              )) {
                wasCancelled(false);
              } else {
                wasCancelled(true);
              }
            }
          : null,
      child: child,
    );
  }
}
