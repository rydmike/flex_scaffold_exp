import 'dart:async';
import 'dart:math' as math;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../app/const/app_images.dart';
import '../../../app/const/app_insets.dart';
import '../../../store/key_store.dart';
import '../../controllers/pods_theme.dart';

const bool _kDebugMe = kDebugMode && true;

const Color _kPlaceholderColor = Color(0x80404040);

const double _kWidthOfScrollItem = 290;
const double _kAspectRatio = 1.5;

/// Horizontal image selector of theme images offered by the Flexfold demo.
class ImageSelector extends ConsumerStatefulWidget {
  const ImageSelector({
    super.key,
  });

  @override
  ConsumerState<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends ConsumerState<ImageSelector> {
  late ScrollController scrollController;
  PaletteGenerator? paletteGenerator;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
        keepScrollOffset: true,
        initialScrollOffset:
            _kWidthOfScrollItem * ref.read(schemeImageIndexPod));
    unawaited(_updatePaletteGenerator());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _updatePaletteGenerator() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      AssetImage(AppImages.themeImages[ref.read(schemeImageIndexPod)]),
      size:
          const Size(_kWidthOfScrollItem, _kWidthOfScrollItem / _kAspectRatio),
      maximumColorCount: 19,
    );

    final int sameImageTapCount = ref.read(imgUsedMixPod);

    // Update custom color scheme color
    if (sameImageTapCount == 1) {
      ref.read(imgLightPrimaryPod.notifier).state = _ensureDarkColor(
          paletteGenerator?.darkVibrantColor?.color ??
              paletteGenerator?.darkMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimary]! as Color);

      ref.read(imgLightPrimaryVariantPod.notifier).state =
          paletteGenerator?.mutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimaryVariant]! as Color;

      ref.read(imgLightSecondaryPod.notifier).state =
          paletteGenerator?.vibrantColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondary]! as Color;

      ref.read(imgLightSecondaryVariantPod.notifier).state =
          paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.lightMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondaryVariant]! as Color;
    } else if (sameImageTapCount == 2) {
      ref.read(imgLightPrimaryPod.notifier).state = _ensureDarkColor(
          paletteGenerator?.mutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimary]! as Color);

      ref.read(imgLightPrimaryVariantPod.notifier).state =
          paletteGenerator?.darkMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimaryVariant]! as Color;

      ref.read(imgLightSecondaryPod.notifier).state =
          paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.vibrantColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondary]! as Color;

      ref.read(imgLightSecondaryVariantPod.notifier).state =
          paletteGenerator?.vibrantColor?.color ??
              paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.lightMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondaryVariant]! as Color;
    } else if (sameImageTapCount == 3) {
      ref.read(imgLightPrimaryPod.notifier).state = _ensureDarkColor(
          paletteGenerator?.mutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimary]! as Color);

      ref.read(imgLightPrimaryVariantPod.notifier).state =
          paletteGenerator?.darkMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimaryVariant]! as Color;

      ref.read(imgLightSecondaryPod.notifier).state =
          paletteGenerator?.vibrantColor?.color ??
              paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.lightMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondary]! as Color;

      ref.read(imgLightSecondaryVariantPod.notifier).state =
          paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.vibrantColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondaryVariant]! as Color;
    } else if (sameImageTapCount == 4) {
      ref.read(imgLightPrimaryPod.notifier).state = _ensureDarkColor(
          paletteGenerator?.darkMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimary]! as Color);

      ref.read(imgLightPrimaryVariantPod.notifier).state =
          paletteGenerator?.mutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimaryVariant]! as Color;

      ref.read(imgLightSecondaryPod.notifier).state =
          paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.vibrantColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondary]! as Color;

      ref.read(imgLightSecondaryVariantPod.notifier).state =
          paletteGenerator?.vibrantColor?.color ??
              paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.lightMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondaryVariant]! as Color;
    } else if (sameImageTapCount == 5) {
      ref.read(imgLightPrimaryPod.notifier).state = _ensureDarkColor(
          paletteGenerator?.vibrantColor?.color ??
              paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimary]! as Color);

      ref.read(imgLightPrimaryVariantPod.notifier).state =
          paletteGenerator?.darkVibrantColor?.color ??
              paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimaryVariant]! as Color;

      ref.read(imgLightSecondaryPod.notifier).state =
          paletteGenerator?.mutedColor?.color ??
              paletteGenerator?.darkMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondary]! as Color;

      ref.read(imgLightSecondaryVariantPod.notifier).state =
          paletteGenerator?.lightMutedColor?.color ??
              paletteGenerator?.darkMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondaryVariant]! as Color;
    } else if (sameImageTapCount == 6) {
      ref.read(imgLightPrimaryPod.notifier).state = _ensureDarkColor(
          paletteGenerator?.darkMutedColor?.color ??
              paletteGenerator?.mutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimary]! as Color);

      ref.read(imgLightPrimaryVariantPod.notifier).state =
          paletteGenerator?.lightMutedColor?.color ??
              paletteGenerator?.mutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimaryVariant]! as Color;

      ref.read(imgLightSecondaryPod.notifier).state =
          paletteGenerator?.vibrantColor?.color ??
              paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondary]! as Color;

      ref.read(imgLightSecondaryVariantPod.notifier).state =
          paletteGenerator?.darkVibrantColor?.color ??
              paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondaryVariant]! as Color;
    } else if (sameImageTapCount == 7) {
      ref.read(imgLightPrimaryPod.notifier).state = _ensureDarkColor(
          paletteGenerator?.darkVibrantColor?.color ??
              paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimary]! as Color);

      ref.read(imgLightPrimaryVariantPod.notifier).state =
          paletteGenerator?.vibrantColor?.color ??
              paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimaryVariant]! as Color;

      ref.read(imgLightSecondaryPod.notifier).state =
          paletteGenerator?.mutedColor?.color ??
              paletteGenerator?.lightMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondary]! as Color;

      ref.read(imgLightSecondaryVariantPod.notifier).state =
          paletteGenerator?.darkMutedColor?.color ??
              paletteGenerator?.lightMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondaryVariant]! as Color;
    } else {
      ref.read(imgLightPrimaryPod.notifier).state = _ensureDarkColor(
          paletteGenerator?.lightVibrantColor?.color ??
              paletteGenerator?.mutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimary]! as Color);

      ref.read(imgLightPrimaryVariantPod.notifier).state =
          paletteGenerator?.vibrantColor?.color ??
              paletteGenerator?.mutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightPrimaryVariant]! as Color;

      ref.read(imgLightSecondaryPod.notifier).state =
          paletteGenerator?.darkVibrantColor?.color ??
              paletteGenerator?.darkMutedColor?.color ??
              paletteGenerator?.lightMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondary]! as Color;

      ref.read(imgLightSecondaryVariantPod.notifier).state =
          paletteGenerator?.lightMutedColor?.color ??
              paletteGenerator?.darkMutedColor?.color ??
              paletteGenerator?.dominantColor?.color ??
              KeyStore.defaults[KeyStore.lightSecondaryVariant]! as Color;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool disableImageList = ref.watch(schemeIndexPod) != 2;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: _kWidthOfScrollItem / _kAspectRatio,
          child: Row(children: <Widget>[
            const SizedBox(width: Sizes.l),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                physics: disableImageList
                    ? const NeverScrollableScrollPhysics()
                    : const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: AppImages.themeImages.length,
                itemBuilder: (BuildContext context, int index) {
                  return ThemeImage(
                    index: index,
                    onSelect: () async {
                      setState(() {
                        scrollController.animateTo(_kWidthOfScrollItem * index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut);
                      });
                      if (ref.read(schemeImageIndexPod) == index) {
                        ref.read(imgUsedMixPod.notifier).state =
                            ref.read(imgUsedMixPod) + 1;
                      } else {
                        ref.read(schemeImageIndexPod.notifier).state = index;
                      }
                      if (ref.read(imgUsedMixPod) >= 9) {
                        ref.read(imgUsedMixPod.notifier).state = 1;
                      }
                      await _updatePaletteGenerator();
                    },
                    selected: ref.read(schemeImageIndexPod) == index,
                    disabled: disableImageList,
                  );
                },
              ),
            ),
            const SizedBox(width: Sizes.l),
          ]),
        ),
        // Wrap(children: [
        //   for (final Color color
        //       in paletteGenerator?.colors ?? <Color>[Color(0xFF000000)])
        //     PaletteSwatch(color: color)
        // ]),
        const SizedBox(height: Sizes.m),
        Wrap(children: <Widget>[
          const SizedBox(width: Sizes.l),
          const Text('Image colors: '),
          if (!disableImageList)
            PaletteSwatch(color: paletteGenerator?.lightVibrantColor?.color),
          if (!disableImageList)
            PaletteSwatch(color: paletteGenerator?.vibrantColor?.color),
          if (!disableImageList)
            PaletteSwatch(color: paletteGenerator?.darkVibrantColor?.color),
          if (!disableImageList)
            PaletteSwatch(color: paletteGenerator?.lightMutedColor?.color),
          if (!disableImageList)
            PaletteSwatch(color: paletteGenerator?.mutedColor?.color),
          if (!disableImageList)
            PaletteSwatch(color: paletteGenerator?.darkMutedColor?.color),
        ]),
        // PaletteSwatch(
        //    label: 'Dominant', color: paletteGenerator?.dominantColor?.color),
        // PaletteSwatch(
        //     label: 'Light Vibrant',
        //     color: paletteGenerator?.lightVibrantColor?.color),
        // PaletteSwatch(
        //     label: 'Vibrant', color: paletteGenerator?.vibrantColor?.color),
        // PaletteSwatch(
        //     label: 'Dark Vibrant',
        //     color: paletteGenerator?.darkVibrantColor?.color),
        // PaletteSwatch(
        //     label: 'Light Muted',
        //     color: paletteGenerator?.lightMutedColor?.color),
        // PaletteSwatch(
        //     label: 'Muted', color: paletteGenerator?.mutedColor?.color),
        // PaletteSwatch(
        //     label: 'Dark Muted',
        //     color: paletteGenerator?.darkMutedColor?.color),
      ],
    );
  }
}

class ThemeImage extends StatelessWidget {
  const ThemeImage({
    super.key,
    required this.index,
    this.onSelect,
    this.selected = false,
    this.disabled = false,
  });

  /// Index of the theme image.
  final int index;

  /// The image was clicked and selected.
  final VoidCallback? onSelect;

  /// The image is selected.
  final bool selected;

  /// The images are disabled.
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _kWidthOfScrollItem,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.s),
        child: Material(
          color: disabled ? Colors.black : Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.m),
            side: BorderSide(
              color: selected && !disabled
                  ? Theme.of(context).primaryColor.withOpacity(0.85)
                  : Theme.of(context).dividerColor,
              width: Sizes.m,
              style: BorderStyle.solid,
            ),
          ),
          child: InkWell(
            splashColor: disabled
                ? Colors.transparent
                : Theme.of(context).primaryColor.withOpacity(0.15),
            highlightColor: disabled
                ? Colors.transparent
                : Theme.of(context).primaryColor.withOpacity(0.1),
            hoverColor: disabled
                ? Colors.transparent
                : Theme.of(context).primaryColor.withOpacity(0.1),
            onTap: disabled ? null : onSelect,
            child: Ink.image(
              image: AssetImage(AppImages.themeImages[index]),
              colorFilter: disabled
                  ? const ColorFilter.matrix(<double>[
                      0.2126, 0.7152, 0.0722, 0, 0, // Greyscale filter
                      0.2126, 0.7152, 0.0722, 0, 0, // Greyscale filter
                      0.2126, 0.7152, 0.0722, 0, 0, // Greyscale filter
                      0, 0, 0, 1, 0, // Greyscale filter
                    ])
                  : null,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

/// A small square of color with an optional label.
@immutable
class PaletteSwatch extends StatelessWidget {
  /// Creates a PaletteSwatch.
  ///
  /// If the [PaletteColor] has property `isTargetColorFound` as `false`,
  /// then the swatch will show a placeholder instead, to indicate
  /// that there is no color.
  const PaletteSwatch({
    super.key,
    this.color,
    this.label,
  });

  /// The color of the swatch.
  final Color? color;

  /// The optional label to display next to the swatch.
  final String? label;

  @override
  Widget build(BuildContext context) {
    // Compute the "distance" of the color swatch and the background color
    // so that we can put a border around those color swatches that are too
    // close to the background's saturation and lightness. We ignore hue for
    // the comparison.
    final HSLColor hslColor = HSLColor.fromColor(color ?? Colors.transparent);
    final HSLColor backgroundAsHsl =
        HSLColor.fromColor(Theme.of(context).scaffoldBackgroundColor);
    final double colorDistance = math.sqrt(
        math.pow(hslColor.saturation - backgroundAsHsl.saturation, 2.0) +
            math.pow(hslColor.lightness - backgroundAsHsl.lightness, 2.0));

    Widget swatch = (color == null && label != null)
        ? const Placeholder(
            fallbackWidth: 34,
            fallbackHeight: 20,
            color: Color(0xff404040),
            strokeWidth: 2,
          )
        : (color == null && label == null)
            ? const SizedBox.shrink()
            : Container(
                decoration: BoxDecoration(
                    color: color,
                    border: Border.all(
                      width: 1,
                      color: _kPlaceholderColor,
                      style: colorDistance < 0.2
                          ? BorderStyle.solid
                          : BorderStyle.none,
                    )),
                width: Sizes.xl,
                height: Sizes.l,
              );

    if (label != null) {
      swatch = ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 130, minWidth: 130),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            swatch,
            const SizedBox(width: Sizes.s),
            Text(label!),
          ],
        ),
      );
    }
    return swatch;
  }
}

Color _ensureDarkColor(Color color) {
  if (ThemeData.estimateBrightnessForColor(color) == Brightness.light) {
    if (_kDebugMe) {
      debugPrint('Settings: _ensureDarkColor Darkened 25%');
    }
    return color.darken(25);
  } else {
    return color;
  }
}
