import 'package:animations/animations.dart';
import 'package:flex_scaffold/flex_scaffold.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../about/views/pages/about_page.dart';
import '../../help/views/pages/help_page.dart';
import '../../home/views/pages/home_page.dart';
import '../../info/views/pages/info_page.dart';
import '../../preview/views/pages/preview_page.dart';
import '../../settings/views/pages/settings_page.dart';
import '../../slivers/views/pages/slivers_page.dart';
import '../../tabs/views/pages/tab_app_bar.dart';
import '../../tabs/views/pages/tab_guide.dart';
import '../../tabs/views/pages/tab_images.dart';
import '../../tabs/views/pages/tab_modal.dart';
import '../../tabs/views/pages/tabs_screen.dart';
import '../../theme/views/pages/theme_page.dart';
import '../constants/routes.dart';
import '../views/pages/navigation_shell.dart';
import '../views/widgets/push_wrapper.dart';

// Set to true to observe debug prints. In release mode this compile time
// const always evaluates to false, so in theory anything with only an
// if (_kDebugMe) {} should get tree shaken away in a release build.
const bool _debug = kDebugMode && false;

// This is a custom transition builder that uses the animations from the
// Google animations package combined with Flexfold info about navigation
// direction and tapped source (drawer, menu, rail, bottom bar) to build
// different transitions based on the source.
//
// For the bottom bar navigation also the direction information about the
// navigation (forward or reverse) could be used.
PageRouteBuilder<dynamic> adaptiveTransition(
  Widget screen,
  FlexTarget destination,
  RouteSettings settings,
  // bool fullScreen
) {
  //
  // Tapped on rail or drawer
  //
  // When we navigate via a rail or from the drawer, we do a fade through
  // page transition, this works well on all platforms and is an accepted
  // transition for unrelated and none directional navigation.
  // If we want we could do something else for drawer navigation, like
  // platform native, but the drawer can potentially also be used on a very
  // large canvas if the user chooses to do so. The platform default page
  // transition are not so nice on a very large canvas.
  if (destination.source == FlexNavigation.rail ||
      destination.source == FlexNavigation.drawer) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          child: screen,
        );
      },
    );
    //
    // Navigated via bottom bar.
    //
    // Currently doing a shared axis transition,
    // using the Flutter Animations package transition
    // but my problem with it is, I cannot go in reverse direction with it when
    // it used in a PageRouteBuilder, instead of a PageTransitionSwitcher.
    // Since there is no 'reverse' option in the PageRouteBuilder.
    // TODO(rydmike): Use other shared axis motion with both directions?
    // Doable by using different page route transitions for forward and
    // reverse.
    // TODO(rydmike): Maybe raise reverse issue about shared axis transition?
    // I like this shared axis transition, but no idea how to get it to go in
    // reverse direction when using it in a PageRouteBuilder, when using it in
    // a PageTransitionSwitcher it is a piece of cake, but here we need to
    // use the PageRouteBuilder and the reverse direction eludes me.
  } else if (destination.source == FlexNavigation.bottom) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          transitionType: SharedAxisTransitionType.horizontal,
          child: screen,
        );
      },
    );
  } else {
    //
    // Navigated via side menu or it is a custom transition.
    //
    // Custom transitions can be used for navigation within the app, not
    // originating via the Flexfold scaffold to setup a separate transitions
    // for them, here side menu and custom share the same transition.
    // For this type we route to a page without any transition.
    // This is suitable for desktop apps, in this demo app we use
    // this on Web too, but we could do a different page transitions in this
    // function when kIsWeb if so desired.
    return PageRouteBuilder<dynamic>(
      settings: settings,
      transitionDuration: Duration.zero,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return screen;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return child;
      },
    );
  }
}

class AppRouter {
  AppRouter._();

  // private navigators
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter go = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: Routes.home,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '${Routes.about}_modal',
        name: '${Routes.aboutLabel}_modal',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            NoTransitionPage<void>(
          key: state.pageKey,
          child: const PushWrapper(child: AboutPage()),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '${Routes.preview}_modal',
        name: '${Routes.previewLabel}_modal',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            NoTransitionPage<void>(
          key: state.pageKey,
          child: const PushWrapper(child: PreviewPage()),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '${Routes.help}_modal',
        name: '${Routes.helpLabel}_modal',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            NoTransitionPage<void>(
          key: state.pageKey,
          child: const PushWrapper(child: HelpPage()),
        ),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return
              // DirectionalityWrapper(child:
              NavigationShell(body: child
                  // ),
                  );
        },
        routes: <RouteBase>[
          GoRoute(
            path: Routes.home,
            name: Routes.homeLabel,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: const HomePage(),
              );
            },
          ),
          GoRoute(
            path: Routes.info,
            name: Routes.infoLabel,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                NoTransitionPage<void>(
              key: state.pageKey,
              child: const InfoPage(),
            ),
          ),
          GoRoute(
            path: Routes.settings,
            name: Routes.settingsLabel,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                NoTransitionPage<void>(
              key: state.pageKey,
              child: const SettingsPage(),
            ),
          ),
          GoRoute(
            path: Routes.theme,
            name: Routes.themeLabel,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                NoTransitionPage<void>(
              key: state.pageKey,
              child: const ThemePage(),
            ),
          ),
          GoRoute(
            path: Routes.tabs,
            name: Routes.tabsLabel,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                NoTransitionPage<void>(
              key: state.pageKey,
              child: const TabsScreen(),
            ),
            routes: <GoRoute>[
              GoRoute(
                path: Routes.tabsGuide,
                name: Routes.tabsGuideLabel,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    NoTransitionPage<void>(
                  key: state.pageKey,
                  child: const TabGuide(),
                ),
              ),
              GoRoute(
                path: Routes.tabsAppbar,
                name: Routes.tabsAppbarLabel,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    NoTransitionPage<void>(
                  key: state.pageKey,
                  child: const TabAppBar(),
                ),
              ),
              GoRoute(
                path: Routes.tabsImages,
                name: Routes.tabsImagesLabel,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    NoTransitionPage<void>(
                  key: state.pageKey,
                  child: const TabImages(),
                ),
              ),
              GoRoute(
                path: Routes.tabsModal,
                name: Routes.tabsModalLabel,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    MaterialPage<void>(
                  key: state.pageKey,
                  child: const TabModal(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: Routes.slivers,
            name: Routes.sliversLabel,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                NoTransitionPage<void>(
              key: state.pageKey,
              child: const SliversPage(),
            ),
          ),
          GoRoute(
            path: Routes.preview,
            name: Routes.previewLabel,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                NoTransitionPage<void>(
              key: state.pageKey,
              child: const PreviewPage(),
            ),
          ),
          GoRoute(
            path: Routes.help,
            name: Routes.helpLabel,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                NoTransitionPage<void>(
              key: state.pageKey,
              child: const HelpPage(),
            ),
          ),
          GoRoute(
            path: Routes.about,
            name: Routes.aboutLabel,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                NoTransitionPage<void>(
              key: state.pageKey,
              child: const AboutPage(),
            ),
          ),
          // errorPageBuilder: (BuildContext context, GoRouterState state) =>
          //     MaterialPage<void>(
          //   key: state.pageKey,
          //   child: const ErrorScreen(),
          // ),
        ],
      )
    ],

    // show the current router location as the user navigates page to page; note
    // that this is not required for nested navigation but it is useful to show
    // the location as it changes
    // navigatorBuilder: (BuildContext context, Widget? child) => BodyWrapper(
    //   body: child ?? const SizedBox.shrink(),
    // ),
  );
}
