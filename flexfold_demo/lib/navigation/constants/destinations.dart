import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';

import '../../app/const/app_icons.dart';
import 'app_routes.dart';

// A list with all the destinations we want to use for the
// FlexScaffold in this application.
const List<FlexDestination> appDestinations = <FlexDestination>[
  FlexDestination(
    label: AppRoutes.homeLabel,
    route: AppRoutes.home,
    icon: Icon(AppIcons.home),
    selectedIcon: Icon(AppIcons.homeSelected),
  ),
  FlexDestination(
    label: AppRoutes.infoLabel,
    heading: Text('Energy'),
    route: AppRoutes.info,
    icon: Icon(AppIcons.info),
    selectedIcon: Icon(AppIcons.infoSelected),
    inBottomNavigation: true,
    dividerBefore: true,
  ),
  FlexDestination(
    label: AppRoutes.settingsLabel,
    route: AppRoutes.settings,
    icon: Icon(AppIcons.settings),
    selectedIcon: Icon(AppIcons.settingsSelected),
    hasFloatingActionButton: true,
    hasSidebar: true,
    inBottomNavigation: true,
  ),
  FlexDestination(
    label: AppRoutes.themeLabel,
    route: AppRoutes.theme,
    icon: Icon(AppIcons.theme),
    selectedIcon: Icon(AppIcons.themeSelected),
    hasFloatingActionButton: true,
    hasSidebar: true,
    inBottomNavigation: true,
  ),
  FlexDestination(
    label: AppRoutes.tabsLabel,
    route: AppRoutes.tabs,
    icon: Icon(AppIcons.tabs),
    selectedIcon: Icon(AppIcons.tabsSelected),
    hasSidebar: true,
    inBottomNavigation: true,
  ),
  FlexDestination(
    label: AppRoutes.sliversLabel,
    tooltip: 'Other tooltip on Slivers than the label',
    route: AppRoutes.slivers,
    icon: Icon(AppIcons.slivers),
    selectedIcon: Icon(AppIcons.sliversSelected),
    hasAppBar: false,
    hasSidebar: true,
    inBottomNavigation: true,
  ),
  FlexDestination(
    label: AppRoutes.previewLabel,
    route: AppRoutes.preview,
    icon: Icon(AppIcons.preview),
    selectedIcon: Icon(AppIcons.previewSelected),
    maybePush: true,
    dividerBefore: true,
  ),
  FlexDestination(
    label: AppRoutes.helpLabel,
    route: AppRoutes.help,
    icon: Icon(AppIcons.help),
    selectedIcon: Icon(AppIcons.helpSelected),
    maybePush: true,
  ),
  FlexDestination(
    label: AppRoutes.aboutLabel,
    tooltip: 'About has a longer tooltip than the label, for demo purposes',
    route: AppRoutes.about,
    icon: Icon(AppIcons.about),
    selectedIcon: Icon(AppIcons.aboutSelected),
    maybePush: true,
  ),
];

const GoFlexDestination goHome = GoFlexDestination(
  index: 0,
  bottomIndex: null,
  route: AppRoutes.home,
  icon: Icon(AppIcons.home),
  selectedIcon: Icon(AppIcons.homeSelected),
  label: AppRoutes.homeLabel,
  source: FlexNavigation.menu,
  reverse: true,
  preferPush: false,
);

const GoFlexDestination goFirstBottom = GoFlexDestination(
  index: 1,
  bottomIndex: 0,
  route: AppRoutes.info,
  icon: Icon(AppIcons.info),
  selectedIcon: Icon(AppIcons.infoSelected),
  label: AppRoutes.infoLabel,
  source: FlexNavigation.bottom,
  reverse: true,
  preferPush: false,
);
