import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import '../../widgets/text/link_text_span.dart';
import '../../widgets/wrappers/if_wrapper.dart';

/// This [showAppAboutDialog] function is based on the [AboutDialog] example
/// that exist(ed) in the Flutter Gallery App.
void showAppAboutDialog(BuildContext context) {
  final ThemeData themeData = Theme.of(context);
  final bool isLight = themeData.brightness == Brightness.light;
  final TextStyle aboutTextStyle = themeData.textTheme.bodyText1!;
  final TextStyle redTextStyle = themeData.textTheme.bodyText1!.copyWith(
      color: Theme.of(context).errorColor, fontWeight: FontWeight.bold);

  final TextStyle linkStyle =
      themeData.textTheme.bodyText1!.copyWith(color: themeData.primaryColor);

  // The asset image that shows a Flexfold layout, is in grey scale
  // with some ColorFiltered parameters we can try to colorize the grey scale
  // image based on active theme colors and theme mode.
  final Color color = isLight
      ? themeData.primaryColor.lighten(15)
      : themeData.primaryColor.darken(10);
  final BlendMode blend = isLight ? BlendMode.softLight : BlendMode.modulate;

  showAboutDialog(
    context: context,
    applicationName: AppStrings.appName,
    applicationVersion: AppStrings.version,

    // If we are not on web platform wrap the image in color filter, but
    // if on web we just use the grey scale image since ColorFilter is not
    // supported with the Flutter web API yet. (12.9.2020)
    // TODO(rydmike): Remove IfWrapper when ColorFiltered is supported on Web.
    applicationIcon: IfWrapper(
      condition: !kIsWeb,
      builder: (BuildContext context, Widget child) {
        // This color filter makes the grey Flexfold demo image/icon follow
        // primary color a theme, well a bit anyway.
        return ColorFiltered(
          colorFilter: ColorFilter.mode(color, blend),
          child: child,
        );
      },
      child: const Image(
        width: 80,
        height: 90,
        fit: BoxFit.contain,
        image: AssetImage(AppImages.flexfold),
      ),
    ),
    applicationLegalese:
        '${AppStrings.copyright} ${AppStrings.author} ${AppStrings.license}',
    useRootNavigator: true,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                style: aboutTextStyle,
                text: 'Flexfold demo shows the features '
                    'of the responsive Flexfold scaffold package. '
                    'Find out more on ',
              ),
              LinkTextSpan(
                style: linkStyle,
                uri: Uri(
                  scheme: 'https',
                  host: 'pub.dev',
                ),
                text: 'pub.dev',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '. It contains documentation and link to the source '
                    'of this demo application.\n\n',
              ),
              TextSpan(
                style: redTextStyle,
                text: 'This is a pre-release demo, the Flexfold package is not '
                    'yet available on pub.dev, coming soon...\n\n',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
