import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';

import '../utils/app_icons.dart';
import 'app_routes.dart';

// A list with all the destinations we want to use for the
// Flexfold scaffold in this demo application.
const List<FlexfoldDestination> appDestinations = <FlexfoldDestination>[
  FlexfoldDestination(
    label: AppRoutes.homeLabel,
    route: AppRoutes.home,
    iconData: AppIcons.home,
    selectedIconData: AppIcons.homeSelected,
    icon: Icon(AppIcons.home),
    selectedIcon: Icon(AppIcons.homeSelected),
    maybeModal: false,
  ),
  FlexfoldDestination(
    label: AppRoutes.infoLabel,
    route: AppRoutes.info,
    iconData: AppIcons.info,
    selectedIconData: AppIcons.infoSelected,
    icon: Icon(AppIcons.info),
    selectedIcon: Icon(AppIcons.infoSelected),
    inBottomBar: true,
    dividerBefore: true,
  ),
  FlexfoldDestination(
    label: AppRoutes.settingsLabel,
    route: AppRoutes.settings,
    iconData: AppIcons.settings,
    selectedIconData: AppIcons.settingsSelected,
    icon: Icon(AppIcons.settings),
    selectedIcon: Icon(AppIcons.settingsSelected),
    hasFloatingActionButton: true,
    hasSidebar: true,
    inBottomBar: true,
  ),
  FlexfoldDestination(
    label: AppRoutes.themeLabel,
    route: AppRoutes.theme,
    iconData: AppIcons.theme,
    selectedIconData: AppIcons.themeSelected,
    icon: Icon(AppIcons.theme),
    selectedIcon: Icon(AppIcons.themeSelected),
    hasFloatingActionButton: true,
    hasSidebar: true,
    inBottomBar: true,
  ),
  FlexfoldDestination(
    label: AppRoutes.tabsLabel,
    route: AppRoutes.tabs,
    iconData: AppIcons.tabs,
    selectedIconData: AppIcons.tabsSelected,
    icon: Icon(AppIcons.tabs),
    selectedIcon: Icon(AppIcons.tabsSelected),
    hasSidebar: true,
    inBottomBar: true,
  ),
  FlexfoldDestination(
    label: AppRoutes.sliversLabel,
    tooltip: 'Other tooltip on Slivers than the label',
    route: AppRoutes.slivers,
    iconData: AppIcons.slivers,
    selectedIconData: AppIcons.sliversSelected,
    icon: Icon(AppIcons.slivers),
    selectedIcon: Icon(AppIcons.sliversSelected),
    hasAppBar: false,
    hasSidebar: true,
    inBottomBar: true,
  ),
  FlexfoldDestination(
    label: AppRoutes.previewLabel,
    route: AppRoutes.preview,
    iconData: AppIcons.preview,
    selectedIconData: AppIcons.previewSelected,
    icon: Icon(AppIcons.preview),
    selectedIcon: Icon(AppIcons.previewSelected),
    maybeModal: true,
    dividerBefore: true,
  ),
  FlexfoldDestination(
    label: AppRoutes.helpLabel,
    route: AppRoutes.help,
    iconData: AppIcons.help,
    selectedIconData: AppIcons.helpSelected,
    icon: Icon(AppIcons.help),
    selectedIcon: Icon(AppIcons.helpSelected),
    maybeModal: true,
  ),
  FlexfoldDestination(
    label: AppRoutes.aboutLabel,
    tooltip: 'About has a longer tooltip than the label, for demo purposes',
    route: AppRoutes.about,
    iconData: AppIcons.about,
    selectedIconData: AppIcons.aboutSelected,
    icon: Icon(AppIcons.about),
    selectedIcon: Icon(AppIcons.aboutSelected),
    maybeModal: true,
  ),
];
