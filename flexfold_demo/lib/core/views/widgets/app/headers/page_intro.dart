import 'package:flutter/material.dart';

import '../svg/svg_asset_image_switcher.dart';

// A page intro class that uses a responsive layout to change the layout
// of the intro text and page related image(s) on a large canvas and phone
// sized layouts.
class PageIntro extends StatelessWidget {
  const PageIntro({
    super.key,
    this.introTop,
    this.introBottom,
    required this.imageAssets,
  });
  final Widget? introTop;
  final Widget? introBottom;
  final List<String> imageAssets;

  @override
  Widget build(BuildContext context) {
    final Widget styledIntroTop = DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyLarge!,
      child: introTop ?? const Text(''),
    );
    final Widget styledIntroBottom = DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyLarge!,
      child: introBottom ?? const Text(''),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints size) {
          if (size.maxWidth < 600) {
            // PHONE: Small canvas, layout out all in one column
            return Column(
              children: <Widget>[
                if (introTop != null) styledIntroTop,
                _imageSwitcher(context),
                if (introBottom != null) styledIntroBottom,
              ],
            );
          } else {
            // TABLET/DESKTOP: Larger canvas uses a column with a row in it
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (introTop != null)
                      Flexible(
                        flex: 3,
                        child: styledIntroTop,
                      ),
                    Flexible(flex: 2, child: _imageSwitcher(context)),
                  ],
                ),
                if (introBottom != null) styledIntroBottom,
              ],
            );
          }
        },
      ),
    );
  }

  Widget _imageSwitcher(BuildContext context) {
    return SvgAssetImageSwitcher(
      assetNames: imageAssets,
      color: Theme.of(context).colorScheme.primary,
      alignment: Alignment.center,
      height: 250,
      width: 250,
      padding: const EdgeInsets.all(20),
      fit: BoxFit.contain,
      switchType: ImageSwitchType.random,
    );
  }
}
