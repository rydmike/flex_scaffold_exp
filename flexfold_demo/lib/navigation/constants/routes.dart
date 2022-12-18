import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';

import '../../app/const/app_icons.dart';

/// The named routes and their labels (names).
class Routes {
  /// Private constructor, only static members.
  Routes._();
  // Main routes and their labels
  static const String home = '/';
  static const String homeLabel = 'Home';

  static const String info = '/info';
  static const String infoLabel = 'Info';

  static const String settings = '/settings';
  static const String settingsLabel = 'Settings';

  static const String theme = '/theme';
  static const String themeLabel = 'Theme';

  static const String tabs = '/tabs';
  static const String tabsLabel = 'Tabs';

  static const String slivers = '/slivers';
  static const String sliversLabel = 'Slivers';

  static const String preview = '/preview';
  static const String previewLabel = 'Preview';

  static const String help = '/help';
  static const String helpLabel = 'Help';

  static const String about = '/about';
  static const String aboutLabel = 'About';

  // Sub routes and labels for the tabs on the tab screen.
  static const String tabsGuide = 'guide';
  static const String tabsGuideLabel = 'Guide';

  static const String tabsAppbar = 'appbar';
  static const String tabsAppbarLabel = 'Appbar';

  static const String tabsImages = 'images';
  static const String tabsImagesLabel = 'Images';

  static const String tabsModal = 'modal';
  static const String tabsModalLabel = 'Modal';

  // A list with all the destinations we want to use for the
  // FlexScaffold in this application.
  static const List<FlexDestination> destinations = <FlexDestination>[
    FlexDestination(
      label: Routes.homeLabel,
      route: Routes.home,
      icon: Icon(AppIcons.home),
      selectedIcon: Icon(AppIcons.homeSelected),
    ),
    FlexDestination(
      label: Routes.infoLabel,
      heading: Text('FlexScaffold'),
      route: Routes.info,
      icon: Icon(AppIcons.info),
      selectedIcon: Icon(AppIcons.infoSelected),
      inBottomNavigation: true,
      dividerBefore: true,
    ),
    FlexDestination(
      label: Routes.settingsLabel,
      route: Routes.settings,
      icon: Icon(AppIcons.settings),
      selectedIcon: Icon(AppIcons.settingsSelected),
      hasFloatingActionButton: true,
      hasSidebar: true,
      inBottomNavigation: true,
    ),
    FlexDestination(
      label: Routes.themeLabel,
      route: Routes.theme,
      icon: Icon(AppIcons.theme),
      selectedIcon: Icon(AppIcons.themeSelected),
      hasFloatingActionButton: true,
      hasSidebar: true,
      inBottomNavigation: true,
    ),
    FlexDestination(
      label: Routes.tabsLabel,
      route: Routes.tabs,
      icon: Icon(AppIcons.tabs),
      selectedIcon: Icon(AppIcons.tabsSelected),
      hasSidebar: true,
      inBottomNavigation: true,
    ),
    FlexDestination(
      label: Routes.sliversLabel,
      tooltip: 'Other tooltip on Slivers than the label',
      route: Routes.slivers,
      icon: Icon(AppIcons.slivers),
      selectedIcon: Icon(AppIcons.sliversSelected),
      hasAppBar: false,
      hasSidebar: true,
      inBottomNavigation: true,
    ),
    FlexDestination(
      label: Routes.previewLabel,
      route: Routes.preview,
      icon: Icon(AppIcons.preview),
      selectedIcon: Icon(AppIcons.previewSelected),
      maybePush: true,
      dividerBefore: true,
    ),
    FlexDestination(
      label: Routes.helpLabel,
      route: Routes.help,
      icon: Icon(AppIcons.help),
      selectedIcon: Icon(AppIcons.helpSelected),
      maybePush: true,
    ),
    FlexDestination(
      label: Routes.aboutLabel,
      tooltip: 'About has a longer tooltip than the label, for demo purposes',
      route: Routes.about,
      icon: Icon(AppIcons.about),
      selectedIcon: Icon(AppIcons.aboutSelected),
      maybePush: true,
    ),
  ];

  // A destination we can use to go home.
  static const FlexTarget goHome = FlexTarget(
    index: 0,
    bottomIndex: null,
    route: Routes.home,
    icon: Icon(AppIcons.home),
    selectedIcon: Icon(AppIcons.homeSelected),
    label: Routes.homeLabel,
    source: FlexNavigation.menu,
    reverse: true,
    preferPush: false,
  );

  // A destination we can use to go to first bottom destination.
  static const FlexTarget goFirstBottom = FlexTarget(
    index: 1,
    bottomIndex: 0,
    route: Routes.info,
    icon: Icon(AppIcons.info),
    selectedIcon: Icon(AppIcons.infoSelected),
    label: Routes.infoLabel,
    source: FlexNavigation.bottom,
    reverse: true,
    preferPush: false,
  );
}
