import 'package:device_preview/device_preview.dart';
// import 'package:device_preview/plugins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

// import 'package:routemaster/routemaster.dart';

import 'navigation/app_router.dart';
import 'pods/pods_application.dart';
import 'pods/pods_observer.dart';
import 'pods/pods_theme.dart';
import 'store/hive_store.dart';
import 'utils/app_data_dir/app_data_dir.dart';
import 'utils/app_scroll_behavior.dart';
import 'utils/app_strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Register custom data Hive adapters.
  registerHiveAdapters();
  // Get platform compatible storage folder for the Hive box,
  // this setup should work on all Flutter platforms.
  final String appDataDir = await getAppDataDir();
  Hive.init(appDataDir);
  // Open the Hive box, we just keep it open all the time in this demo app.
  await Hive.openBox<dynamic>(kHiveBox);
  // Routemaster.setPathUrlStrategy();
  runApp(
    // const Directionality(
    //   textDirection: TextDirection.ltr,
    //   child:
    const ScopeWrapper(),
    // ),
  );
}

class ScopeWrapper extends StatelessWidget {
  const ScopeWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: <ProviderObserver>[PodsObserver()],
      child: const Directionality(
        textDirection: TextDirection.ltr,
        child: DeviceWrapper(),
        // child: DemoApp(),
      ),
    );
  }
}

class DeviceWrapper extends ConsumerWidget {
  const DeviceWrapper({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: DevicePreview(
            enabled: ref.watch(useDevicePreviewPod),
            storage: DevicePreviewStorage.none(),
            // plugins: const <DevicePreviewPlugin>[
            //   ScreenshotPlugin(),
            // ],
            // style: DevicePreviewStyle(
            //   toolBar: DevicePreviewToolBarStyle.light(
            //     position: DevicePreviewToolBarPosition.bottom,
            //     buttonsVisibility:
            //         const DevicePreviewButtonsVisibilityStyleData(
            //       darkMode: false,
            //       language: false,
            //       settings: false,
            //       toggleKeyboard: true,
            //       toggleFrame: false,
            //       accessibility: false,
            //       togglePreview: false,
            //     ),
            //   ),
            //   background: const BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: <Color>[Color(0xFFf5f7fa), Color(0xFFc3cfe2)],
            //     ),
            //   ),
            // ),
            isToolbarVisible: true,
            builder: (_) => const DemoApp(),
          ),
        ),
      ],
    );
  }
}

/// Title observer that updates the app's title when the route changes
/// This shows in a browser tab's title.
// TODO(rydmike): See how to do this in GoRouter!
// class TitleObserver extends RoutemasterObserver {
//   @override
//   void didChangeRoute(RouteData routeData, Page<dynamic> page) {
//     if (page.name != null) {
//       SystemChrome.setApplicationSwitcherDescription(
//         ApplicationSwitcherDescription(
//           label: page.name,
//           //TODO(rydmike): What if browser is in dark mode?
//           primaryColor: 0xFF00FF00,
//         ),
//       );
//     }
//   }
// }

class DemoApp extends ConsumerWidget {
  const DemoApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      scrollBehavior: AppScrollBehavior(),
      routerConfig: AppRouter.go,
      themeMode: ref.watch(themeModePod),
      theme: ref.watch(lightThemePod),
      darkTheme: ref.watch(darkThemePod),
    );
  }
}

// COMMENTED Router master implementation
//
// class DemoApp extends ConsumerWidget {
//   const DemoApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return MaterialApp.router(
//       title: AppStrings.appName,
//       debugShowCheckedModeBanner: false,
//       scrollBehavior: AppScrollBehavior(),
//       routeInformationParser: const RoutemasterParser(),
//       routerDelegate: RoutemasterDelegate(
//         observers: <RoutemasterObserver>[TitleObserver()],
//         routesBuilder: (BuildContext context) => routeMap(),
//       ),
//       themeMode: ref.watch(themeModePod),
//       theme: ref.watch(lightThemePod),
//       darkTheme: ref.watch(darkThemePod),
//     );
//   }
// }

//
// builder: DevicePreview.appBuilder,
// locale: DevicePreview.locale(context),

// TODO(rydmike): Router master change
// return MaterialApp(

// The root navigator is used by dialogs, for named and unnamed
// full screen modal routes used by Flexfold, as well as other none
// Flexfold managed destinations that we want to show on top of
// destinations managed by the Flexfold scaffold.
// TODO(rydmike): Router master change
// onGenerateRoute: router.generateRoute,
// The themeModel has a directionality settings

// TODO(rydmike): Router master change
// home: Directionality(
//   textDirection: themeModel.textDirection(context),
//   // DevicePreview.appBuilder contains brightness setting that can be in
//   // conflict with the application's overall brightness that is defined by
//   // the active MaterialApp's `theme` or `darkTheme` selected via
//   // `themeMode`. To correct the situation we insert an extra builder
//   // that overrides the theme brightness from DevicePreview with the
//   // correct Brightness for the selected active themeMode and its
//   // brightness.
//   child: Builder(builder: (BuildContext context) {
//     // Resolve which theme to use based on brightness and high contrast.
//     final ThemeMode mode = themeModel.themeMode;
//     final Brightness platformBrightness =
//         MediaQuery.platformBrightnessOf(context);
//     final bool useDarkTheme = mode == ThemeMode.dark ||
//         (mode == ThemeMode.system &&
//             platformBrightness == ui.Brightness.dark);
//     return Theme(
//         data: Theme.of(context).copyWith(
//             brightness:
//                 useDarkTheme ? Brightness.dark : Brightness.light),
//         // Home screen is a layout shell with a single Flexfold scaffold
//         // using a nested navigator as its body. The screens used by
//         // Flexfold normally only contain and change the part that goes
//         // into the body of the scaffold, thus in tablet, desktop and web
//         // views, only the body part uses the desired page transition
//         // effect for each navigation mode.
//         child: AnnotatedRegion<SystemUiOverlayStyle>(
//             value: FlexColorScheme.themedSystemNavigationBar(
//               context,
//               useDivider: false,
//             ),
//             child: const LayoutShell()));
//   }),
// ),
