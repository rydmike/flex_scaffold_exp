import 'package:flexfold/flexfold.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// import 'package:routemaster/routemaster.dart';

import '../model/app_navigation_state.dart';
import '../pods/pods_flexfold.dart';
import '../pods/pods_navigation.dart';
import '../utils/app_icons.dart';
import '../utils/app_tooltips.dart';
import '../widgets/dialogs/platform_alert_dialog.dart';
import '../widgets/menu/footer_copyright.dart';
import '../widgets/menu/leading_user_profile.dart';
import '../widgets/menu/menu_logo.dart';
import '../widgets/menu/sidebar.dart';
import '../widgets/menu/trailing_theme_toggle.dart';
import '../widgets/wrappers/animated_hide.dart';
import 'app_routes.dart';
import 'destinations.dart';

const bool _kDebugMe = kDebugMode && true;

// The LayoutShell returns a nested navigator and builds the FlexScaffold.
//
// In this demo app there is only one FlexScaffold that handles the
// layout of all the main destinations in the application. The FlexScaffold
// handles the bottom navigation bar, drawer and end drawer, rail and menu
// based on its FlexDestination configurations.
class LayoutShell extends ConsumerWidget {
  const LayoutShell({
    super.key,
    required this.body,
  });
  final Widget body;

  // This Flexfold demo app builds one single Flexfold scaffold
  // in a stateless widget using a ChangeNotifierProvider that holds
  // all the config values for the Flexfold and a few more design
  // and layout parameters. The destination targets do NOT have their
  // own Flexfold scaffold, only the BODY content area is swapped out
  // when user navigates to a new page using named routes.
  //
  // You can also make a setup that uses a complete own [Flexfold]
  // Scaffold for each destination and just rebuilds everything after
  // each navigation. Flutter is fast enough to handle this, but that
  // does not support using page transitions so that only the content
  // of the page animates and not also the menu, appbar, bottom bar and
  // sidebar. When using Flexfold on desktop and web you may not want
  // have transition effects on static menu parts, but you may want to
  // have a subtle transition on the content part. This setup shows how
  // you can accomplish this. If you use no page transitions at all on
  // web and desktop canvas sizes you can also use a simpler none nested
  // navigator version and give each destination its entire own Flexfold
  // scaffold.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CurrentRoute route = ref.watch(currentRouteProvider);

    final String goRouterPath = GoRouter.of(context).location;
    if (_kDebugMe) {
      debugPrint('LayoutShell: goRouterPath = $goRouterPath');
    }

    // We use the Flexfold menu highlight helper class to make
    // border shapes and let it adjust margins for the shapes.
    // It is possible to make totally custom highlight and hover
    // shapes and they don't even have to be the same.
    final TextDirection directionality = Directionality.of(context);

    // The style of the selected highlighted item.
    final FlexMenuIndicator menuSelected = FlexMenuIndicator(
      highlightType: ref.watch(menuHighlightTypePod),
      borderColor: Theme.of(context).primaryColor,
      highlightColor: Theme.of(context).colorScheme.primary.withAlpha(0x3d),
      height: ref.watch(menuHighlightHeightPod),
      borderRadius: ref.watch(menuHighlightHeightPod) / 6,
      directionality: directionality,
    );
    // The style of the item that is hovered on web and desktop.
    final FlexMenuIndicator menuHover = FlexMenuIndicator(
      highlightType: ref.watch(menuHighlightTypePod),
      borderColor: Colors.transparent,
      highlightColor: Colors.transparent,
      height: ref.watch(menuHighlightHeightPod),
      borderRadius: ref.watch(menuHighlightHeightPod) / 6,
      directionality: directionality,
    );

    // Make a FlexfoldThemeData object that we pass in to Flexfold to
    // configure its style and behavior. This demo uses a lot more
    // properties than one would typically use or allow users to adjust.
    // It is done so in order to demonstrate the features of Flexfold.
    final FlexScaffoldThemeData flexfoldTheme = FlexScaffoldThemeData(
      // TODO(rydmike): Uncomment to test background colors via properties.
      // menuBackgroundColor: isLight ? Color(0xFFE9EFEA) : Color(0xFF18231B),
      //     Theme.of(context).backgroundColor, //Colors.pink[100],
      // sidebarBackgroundColor: Colors.yellow[100],

      // Set if we start from top or bottom of screen
      menuStart: ref.watch(menuStartPod),
      // Set if we have the menu on start or end side of screen
      menuSide: ref.watch(menuSidePod),

      // Uncomment to see that menuElevation elevation works.
      // TODO(rydmike): This elevation does not work! Figure out why not.
      // Not going to using it in this demo even if it would work because
      // it is ugly (opinionated), but it should of course be a supported
      // feature.
      menuElevation: 0,
      // Uncomment to use sidebarElevation.
      // Not used in this demo because it is not so pretty (opinionated).
      sidebarElevation: 0,
      // We use same width value for the drawer and the menu in this demo,
      // but they can of course be different.
      menuWidth: ref.watch(menuWidthPod),
      drawerWidth: ref.watch(menuWidthPod),
      // Rail width
      railWidth: ref.watch(railWidthPod),
      // We use same width value for end drawer and sidebar in this demo,
      // but they can of course be different.
      sidebarWidth: ref.watch(sidebarWidthPod),
      endDrawerWidth: ref.watch(sidebarWidthPod),
      // Breakpoint settings
      breakpointDrawer: ref.watch(breakpointDrawerPod),
      breakpointRail: ref.watch(breakpointRailPod),
      breakpointMenu: ref.watch(breakpointMenuPod),
      breakpointSidebar: ref.watch(breakpointSidebarPod),
      // Border edge configurations
      borderOnMenu: ref.watch(borderOnMenuPod),
      borderOnSidebar: ref.watch(borderOnMenuPod),
      borderOnDarkDrawer: ref.watch(borderOnDarkDrawerPod),
      borderOnLightDrawer: false,
      // borderColor: Colors.green[400], // You can control the color too
      // Menu design and layout properties
      menuHighlightHeight: ref.watch(menuHighlightHeightPod),
      menuHighlightMargins: menuSelected.margins,
      menuHighlightShape: menuHover.shape(),
      menuSelectedShape: menuSelected.shape(),
      menuHighlightColor: menuSelected.highlight,
      // Individual animation durations are available, but for this
      // demo they all share the same setting.
      menuAnimationDuration:
          Duration(milliseconds: ref.watch(animationDurationPod)),
      sidebarAnimationDuration:
          Duration(milliseconds: ref.watch(animationDurationPod)),
      bottomBarAnimationDuration:
          Duration(milliseconds: ref.watch(animationDurationPod)),
      //
      // The animation curve for rail/menu, sidebar and bottom bar
      // can be set separately, but this demo uses the same setting for all.
      menuAnimationCurve: ref.watch(flexMenuCurveProvider),
      sidebarAnimationCurve: ref.watch(flexMenuCurveProvider),
      bottomBarAnimationCurve: ref.watch(flexMenuCurveProvider),
      //
      // Bottom navigation bar theme and additional visual properties for
      // the bottom navigation bar.
      bottomBarType: ref.watch(bottomBarTypePod),
      bottomBarIsTransparent: ref.watch(bottomBarIsTransparentPod),
      bottomBarBlur: ref.watch(bottomBarBlurPod),
      bottomBarOpacity: ref.watch(bottomBarOpacityPod),
      bottomBarTopBorder: ref.watch(bottomBarTopBorderPod),
      //
      // Tooltip settings
      useTooltips: ref.watch(useTooltipsPod),
      menuOpenTooltip: AppTooltips.openMenu,
      menuCloseTooltip: AppTooltips.closeMenu,
      menuExpandTooltip: AppTooltips.expandMenu,
      menuExpandHiddenTooltip: AppTooltips.expandHiddenMenu,
      menuCollapseTooltip: AppTooltips.collapseMenu,
      sidebarOpenTooltip: AppTooltips.openSidebar,
      sidebarCloseTooltip: AppTooltips.closeSidebar,
      sidebarExpandTooltip: AppTooltips.expandSidebar,
      sidebarExpandHiddenTooltip: AppTooltips.expandHiddenSidebar,
      sidebarCollapseTooltip: AppTooltips.collapseSidebar,
    );

    return WillPopScope(
      // If we try to pop the scope, we will do some custom back navigation.
      // If on a bottom bar destination and it is not the first one, then
      // back to first one. If on first one, or not on on bottom bar
      // destination, then we go back to "Home". If we were on "Home" and
      // used back on iOS or Android, we pop out of the app, on other
      // platforms, desktop and Web, we remain on home.
      //
      // TODO(rydmike): Maybe add ask about going "back" out of app on Web?
      onWillPop: () async {
        // Store the start destination.
        final FlexDestinationTarget startDestination = route.destination;
        // If we can pop, then we pop.
        if (Navigator.of(context).canPop()) {
          if (_kDebugMe) {
            debugPrint('LayoutScreen(): Back can pop, so we popped!');
          }
          Navigator.pop(context);
          return false;
        }
        // If we can no longer pop, then we test what to set as back route.
        // If bottom nav index is not null and not 0, then we will go back
        // to first item in bottom nav, but if it is null or 0, then
        // we will go to the Home screen.
        else {
          if (route.destination.bottomIndex != null &&
              route.destination.bottomIndex != 0) {
            // Set first bottom nav screen, "Info" as back destination.
            final FlexDestinationTarget backDestination =
                FlexDestinationTarget.fromRoute(
              AppRoutes.info,
              appDestinations,
              source: route.destination.source,
              reverse: route.destination.reverse,
              preferPush: false,
            );
            // Update the route with the selected back destination = Info
            ref
                .read(currentRouteProvider.notifier)
                .setDestination(backDestination);
            // Navigate to Info screen
            context.go(route.destination.route);
            // TODO(rydmike): Remove old Nav1 navigation.
            // The old navigation with my custom Nav1 nested navigator.
            // await
            // route.navKeyFlexfold.currentState!.pushReplacementNamed(
            //   route.currentDestination.route,
            //   arguments: backDestination,
            // );
          }
          // We go back to the "Home" screen
          else {
            // Set "Home" screen as back destination.
            final FlexDestinationTarget backDestination =
                FlexDestinationTarget.fromRoute(
              AppRoutes.home,
              appDestinations,
              source: route.destination.source,
              reverse: route.destination.reverse,
              preferPush: false,
            );
            // Update the route with the selected back destination = Home
            ref
                .read(currentRouteProvider.notifier)
                .setDestination(backDestination);
            // Navigate to home screen
            context.go(route.destination.route);
            // TODO(rydmike): Remove old Nav1 navigation.
            // The old navigation with my custom Nav1 nested navigator.
            // await
            // route.navKeyFlexfold.currentState!.pushReplacementNamed(
            //   route.currentDestination.route,
            //   arguments: backDestination,
            // );
          }
          // Current platform
          final TargetPlatform platform = Theme.of(context).platform;
          // If we pressed back on "Home" screen on an Android device or iOS
          // device, FROM the "Home" screen then we will pop out of scope,
          // but not on other platforms. The result should be that we
          // cannot "back" button out accidentally on the web version
          // to a previous Web page and loose the state of the SPA Web app.
          final bool popOutOfScope = startDestination.route == AppRoutes.home &&
              (platform == TargetPlatform.iOS ||
                  platform == TargetPlatform.android);
          return popOutOfScope;
        }
      },

      // Build the Flexfold scaffold.
      //
      // The is example is more complex than needed due to all the customizable
      // settings it demonstrates.
      child: FlexScaffold(
        //
        // First we assign the theme and style for the Flexfold that we
        // defined above. The theme contains the style, size and some less
        // frequently used settings.
        flexfoldTheme: flexfoldTheme,

        // The Flexfold appBar only takes a FlexfoldAppBar() data object.
        // Here we use the styled factory version of it, but the standard
        // version of it would work just fine too, then the only needed
        // property below would be the title. In this demo app we also
        // demonstrate how to use the styled appbar factory.
        appBar: FlexAppBar.styled(
          context,
          // TODO(rydmike): Add implicit title
          // We use our destination labels as headings for the app bar
          title: Text(appDestinations[route.destination.index].label),
          gradient: ref.watch(appBarGradientPod),
          blurred: ref.watch(appBarBlurPod),
          opacity: ref.watch(appBarTransparentPod)
              ? ref.watch(appBarOpacityPod)
              : 1.0,
          hasBorderOnSurface: ref.watch(appBarBorderOnSurfacePod),
          hasBorder: ref.watch(appBarBorderPod),
          showScreenSize: ref.watch(appBarShowScreenSizePod),
          // TODO(rydmike): Experimental AppBar feature, keep or not?
          floatAppBar: ref.watch(appBarFloatPod),
          floatPadding: const EdgeInsetsDirectional.fromSTEB(3, 4, 3, 4),
          elevation: ref.watch(appBarFloatPod) ? 1 : 0,
          scrim: ref.watch(appBarScrimPod),
          // The main app bar should never have a custom leading widget,
          // adding one will create a debug assert error, this would fail
          // with an assert error in debug mode:
          // leading:
          //   IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          //
          // The main appbar can have additional custom Actions, the action
          // that operates the sidebar toggle/menu will always be inserted
          // last in the actions list. This would OK to add:
          // actions: <Widget>[
          //   IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          // ],
        ),

        //
        // Supply the list of main navigation destinations the app has.
        destinations: appDestinations,
        //
        // Currently selected destination
        selectedIndex: route.destination.index,
        //
        // When destination is changed we get a FlexfoldSelectedDestination
        // object in a callback that we can use to control how we do
        // routing, which can vary based on if we navigated from bottom,
        // rail or menu and if we moved forward or backwards in the index.
        onDestination: (FlexDestinationTarget destination) async {
          // Set scroll hidden bottom bar to false, so that it is displayed
          // when we get to the new destination.
          ref.read(scrollHiddenBottomBarPod.notifier).state = false;
          // If destinations prefers pushed route, then do so:
          if (destination.preferPush) {
            if (_kDebugMe) {
              debugPrint('onDestination Push: ${destination.route}');
            }
            ref
                .read(currentRouteProvider.notifier)
                .setModalDestination(destination);
            context.push('${destination.route}_modal');
            // FlexScaffold.of(context).assumePushed();
            // This would be an alternative way to route to the modal
            // screens when we use one. This way does not use the package
            // nav2 router or named routes, it just builds a page route
            // and navigate with root navigator to pushed the
            //
            // await Navigator.of(context, rootNavigator: true).push(
            //   MaterialPageRoute<void>(
            //     builder: (BuildContext context) {
            //       if (destination.route == AppRoutes.help) {
            //         return const PushWrapper(child: HelpScreen());
            //       } else if (destination.route == AppRoutes.about) {
            //         return const PushWrapper(child: AboutScreen());
            //       } else {
            //         return const PushWrapper(child: PreviewScreen());
            //       }
            //     },
            //   ),
            // );

          } else {
            // Update the route with the selected destination.
            // This demo app uses the info in the current destination to
            // display info on how we navigated to the screen, so we
            // need to update the route with this info where we
            // navigated to show it and keep track where we are on the
            // main root nav as well.
            if (_kDebugMe) {
              debugPrint('onDestination Go: ${destination.route}');
            }
            ref.read(currentRouteProvider.notifier).setDestination(destination);
            context.go(destination.route);
          }
        },
        //
        // The app bar for the menu, we make it styled too, but you don't
        // have to.You might often at least want to provide a logo or
        // app name as title for the menu app bar.
        menuAppBar: FlexAppBar.styled(
          context,
          // You can add your app logo or brand here.
          title: const MenuLogo(),
          gradient: false, // ref.watch(gradientAppBarPod).state,
          opacity: 1,
          // ref.watch(transparentAppBarPod).state
          // ? ref.watch(appBarOpacityPod).state
          // : 1.0,
          blurred: false, // ref.watch(blurAppBarPod).state,
          hasBorderOnSurface: ref.watch(appBarBorderOnSurfacePod),
          hasBorder: ref.watch(appBarBorderPod),
          // Reverse the gradient compared to main app bar, it looks cool.
          // reverseGradient: true,
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
        // The menu icon used for the menu, drawer and rail toggle button.
        menuIcon: ref.watch(useCustomMenuIconsPod) ? AppIcons.menuIcon : null,
        menuIconExpand:
            ref.watch(useCustomMenuIconsPod) ? AppIcons.menuIconExpand : null,
        menuIconExpandHidden: ref.watch(useCustomMenuIconsPod)
            ? AppIcons.menuIconExpandHidden
            : null,
        menuIconCollapse:
            ref.watch(useCustomMenuIconsPod) ? AppIcons.menuIconCollapse : null,
        //
        // This is a widget that appears before your menu destinations.
        // Animated cross fade is used to remove it smoothly when its
        // presence is toggled on/off in the demo.
        menuLeading: AnimatedSwitchShowHide(
          show: ref.watch(showMenuLeadingPod),
          child: const LeadingUserProfile(),
        ),
        // This is a widget that appears after your menu destinations.
        menuTrailing: AnimatedSwitchShowHide(
          show: ref.watch(showMenuTrailingPod),
          child: const TrailingThemeToggle(),
        ),
        // This is a widget that appears at the bottom of your menu, as
        // a footer, it sticks to the bottom and does not scroll.
        // Using another way to hide/show the footer when toggled on/off,
        // this version just looked better here at the bottom.
        menuFooter: AnimatedFadeShowHide(
          show: ref.watch(showMenuFooterPod),
          child: const FooterCopyright(),
        ),
        //
        // If menu and sidebar toggles are enabled, user has manual control.
        menuControlEnabled: ref.watch(menuControlEnabledPod),
        sidebarControlEnabled: ref.watch(sidebarControlEnabledPod),
        //
        // Menu controls
        hideMenu: ref.watch(hideMenuPod),
        onHideMenu: (bool isHidden) {
          ref.read(hideMenuPod.notifier).state = isHidden;
          // If the menu is hidden, we make sure the bottom bar is not
          // scroll hidden when menu hides, this might happen if the
          // bottom bar was using always show it and it had been scroll
          // hidden, then when the menu is hidden, the bottom bar would not
          // show up until we scroll the page, therefore we set the
          // scroll control state to not be in scroll hide state.
          if (isHidden) {
            ref.read(scrollHiddenBottomBarPod.notifier).state = false;
          }
        },
        cycleViaDrawer: ref.watch(cycleViaDrawerPod),
        preferRail: ref.watch(preferRailPod),
        onPreferRail: (bool value) =>
            ref.read(preferRailPod.notifier).state = value,
        //
        // Combined sidebar menu and end drawer properties and its controls.
        // The sidebar only appears if a destination has specified that it
        // has a sidebar, even in those cases, if you do not
        // add a sidebar property it will not get one, it can be null too.
        // :
        // The icon used for the sidebar toggle button.
        sidebarIcon:
            ref.watch(useCustomMenuIconsPod) ? AppIcons.sidebarIcon : null,
        sidebarIconExpand: ref.watch(useCustomMenuIconsPod)
            ? AppIcons.sidebarIconExpand
            : null,
        sidebarIconExpandHidden: ref.watch(useCustomMenuIconsPod)
            ? AppIcons.sidebarIconExpandHidden
            : null,
        sidebarIconCollapse: ref.watch(useCustomMenuIconsPod)
            ? AppIcons.sidebarIconCollapse
            : null,
        //
        // The appbar for the sidebar. This appbar is only used
        // when the sidebar is shown in the end drawer or when the sidebar
        // is
        // locked on the screen is defined to not be a part of the body.
        // Here we use Flexfold styled version, for a plain normal style
        // appbar use FlexfoldAppBar. If not given or null a default one
        // will be created for destinations that has a sidebar.
        sidebarAppBar: FlexAppBar.styled(
          context,
          title: const Text('Sidebar title'),
          reverseGradient: true,
          gradient: ref.watch(appBarGradientPod),
          opacity: ref.watch(appBarTransparentPod)
              ? ref.watch(appBarOpacityPod)
              : 1.0,
          blurred: false, // ref.watch(blurAppBarPod).state,
          hasBorderOnSurface: ref.watch(appBarBorderOnSurfacePod),
          hasBorder: ref.watch(appBarBorderPod),
          // TODO(rydmike): Experimental AppBar feature, keep or not?
          // floatAppBar: ref.watch(appBarFloatPod),
          // floatPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 3, 0),
          // elevation: ref.watch(appBarFloatPod) ? 2 : 0,
          scrim: ref.watch(appBarScrimPod),
        ),
        // The actual content of the sidebar. Any Widget will do, but it
        // needs to fit into the its given narrow space, you can modify the
        // the widths to some extent.
        sidebar: const Sidebar(),
        // Setting to keep the sidebar hidden.
        hideSidebar: ref.watch(hideSidebarPod),
        // Callback that changes when sidebar is set to be hidden.
        onHideSidebar: (bool value) =>
            ref.read(hideSidebarPod.notifier).state = value,
        // Have sidebar as a part of the body or outside it, if false the
        // sidebar will be outside the Flutter Scaffold body like the menu
        // is. This looks better if a bottom navigation bar will be used
        // on large screens as the bottom navigation bar will then only
        // span the body part and not also the sidebar.
        sidebarBelongsToBody: ref.watch(sidebarBelongsToBodyPod),
        //
        // Bottom navigation bar controls
        scrollHiddenBottomBar: ref.watch(scrollHiddenBottomBarPod),
        hideBottomBar: ref.watch(hideBottomBarPod),
        showBottomBarWhenMenuInDrawer:
            ref.watch(showBottomBarWhenMenuInDrawerPod),
        showBottomBarWhenMenuShown: ref.watch(showBottomBarWhenMenuShownPod),
        bottomDestinationsInDrawer: ref.watch(bottomDestinationsInDrawerPod),
        //
        // If you provide a FAB here, it will only appear on a
        // [FlexfoldDestination] that has been defined to use a FAB.
        // For this demo the FAB does not do anything else than show a
        // dialog that tells which destination it was pressed in.
        // With a setup that uses a nested navigator as the body
        // of in the Flexfold, your onPressed function have to use the
        // destination information to handle different actions for
        // different destinations.
        floatingActionButton: FloatingActionButton(
          // There is only one FAB, but Flutter gets a bit confused with
          // the default hero tag being used unless we set it to null.
          // Maybe it caches the default tags for the different pages and
          // does
          // not know which one to restore? Still there is only one.
          // Setting FAB hero tag to null resolves the issue.
          heroTag: null,
          onPressed: () async {
            await PlatformAlertDialog(
              title: 'Floating Action Button (FAB)',
              content: 'You can define if a destination has a FAB '
                  'and where it appears on a phone, tablet and desktop. '
                  'This demo app only has FABs on the Settings and '
                  'Theme screens.\n\nThis is a FAB on the '
                  '${appDestinations[route.destination.index].label}'
                  ' screen.',
              defaultActionText: ' OK ',
            ).show(context, useRootNavigator: true);
          },
          child: const Icon(Icons.add),
        ),
        //
        // Use different FAB positions.
        floatingActionButtonLocationPhone:
            FloatingActionButtonLocation.endFloat,
        floatingActionButtonLocationTablet:
            FloatingActionButtonLocation.startFloat,
        floatingActionButtonLocationDesktop:
            FloatingActionButtonLocation.centerFloat,
        // Same properties as the ones available in the standard
        // Scaffold. They are included in this demo to show how they can be
        // used in an app to scroll behind the appbar and bottom bar.
        extendBody: ref.watch(extendBodyPod),
        extendBodyBehindAppBar: ref.watch(extendBodyBehindAppBarPod),
        //
        // The body is a GoRouter ShellRoute that only contains the body
        // part of the Scaffold, we even exclude the AppBar
        body: body,

        // TODO(rydmike): Remove old nested navigator
        // The body is a navigator that will create a page widget for the
        // named route we navigate to in the onDestinationSelected callback
        // event.
        //
        // To the generate route function we pass the tapped destination
        // data
        // that contains info about where we came from and the
        // direction. We use this info in the routing function to create
        // different page transitions based on where we navigated
        // from and if it was forward or reverse direction in the
        // destination list.
        // Navigator(
        //   key: route.navKeyFlexfold,
        //   onGenerateRoute: (RouteSettings settings) {
        //     if (_kDebugMe) {
        //       debugPrint(
        //           'LayoutScreen(): Flexfold Navigator '
        //           '** onGenerateRoute **');
        //       debugPrint(
        //           'LayoutScreen(): settings: '
        //           '${route.currentDestination}');
        //     }
        //     return router.generateRoute(settings);
        //   },
        //   initialRoute: AppRoutes.home,
        // ),
      ),
    );
  }
}
