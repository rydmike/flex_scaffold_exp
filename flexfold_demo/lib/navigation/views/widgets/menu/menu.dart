import 'package:flex_scaffold/flex_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/menu_alignment.dart';
import '../../../../core/views/widgets/app/animated_hide.dart';
import '../../../../settings/controllers/pods_flexfold.dart';
import 'footer_copyright.dart';
import 'leading_user_profile.dart';
import 'menu_logo.dart';
import 'trailing_theme_toggle.dart';

class Menu extends ConsumerWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MenuAlignment menuAlign = ref.watch(menuAlignmentPod);

    final AlignmentDirectional alignment = menuAlign == MenuAlignment.top
        ? AlignmentDirectional.topStart
        : menuAlign == MenuAlignment.center
            ? AlignmentDirectional.centerStart
            : AlignmentDirectional.bottomStart;
    return FlexMenu(
      // The app bar for the menu, we make it styled too, but you don't
      // have to.You might often at least want to provide a logo or
      // app name as title for the menu app bar.
      appBar: FlexAppBar.styled(
        context,
        // You can add your app logo or brand here.
        title: const MenuLogo(),
        gradient: false, //ref.watch(appBarGradientPod),
        // blurred: ref.watch(appBarBlurPod),
        opacity: 1,
        // ref.watch(appBarTransparentPod) ? ref.watch(appBarOpacityPod) : 1.0,
        hasBorderOnSurface: ref.watch(appBarBorderOnSurfacePod),
        hasBorder: ref.watch(appBarBorderPod),
        // Reverse the gradient compared to main app bar, it looks cool.
        reverseGradient: true,
        // A little trick, use the rail width and as menu bar's leading
        // widget width, then if you change width, icons remain aligned.
        leadingWidth: ref.watch(railWidthPod),
        // TODO(rydmike): Experimental AppBar feature, keep or not?
        // floatAppBar: ref.watch(appBarFloatPod),
        // floatPadding: const EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
        // // Elevation and scrim
        // elevation: ref.watch(appBarFloatPod) ? 2 : 0,
        scrim: ref.watch(appBarScrimPod),
      ),
      //
      // This is a widget that appears after them menu AppBar.
      // It sticks to the top and does not scroll.
      // Animated cross fade is used to remove it smoothly when its
      // presence is toggled on/off in the demo.
      header: AnimatedSwitchShowHide(
        show: ref.watch(showMenuHeaderPod),
        child: const UserProfile(),
      ),
      // This is a widget that appears before your menu destinations.
      // It scrolls with destinations and aligns with the,
      // Animated cross fade is used to remove it smoothly when its
      // presence is toggled on/off in the demo.
      leading: AnimatedSwitchShowHide(
        show: ref.watch(showMenuLeadingPod),
        child: const ListTile(
          leading: Icon(Icons.more_horiz),
          title: Text(' Leading widget'),
        ),
      ),
      // This is a widget that appears after your menu destinations.
      trailing: AnimatedSwitchShowHide(
        show: ref.watch(showMenuTrailingPod),
        child: const TrailingThemeToggle(),
      ),
      // This is a widget that appears at the bottom of your menu, as
      // a footer, it sticks to the bottom and does not scroll.
      // Using another way to hide/show the footer when toggled on/off,
      // this version just looked better here at the bottom.
      footer: AnimatedFadeShowHide(
        show: ref.watch(showMenuFooterPod),
        child: const FooterCopyright(),
      ),
      // Set the alignment of the menu.
      alignment: alignment,
    );
  }
}
