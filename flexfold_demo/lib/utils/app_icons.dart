import 'package:flutter/material.dart';

/// Icons used in this application.
class AppIcons {
  // This class is not meant to be instantiated or extended. This constructor
  // prevents external instantiation and extension, plus it does not show up
  // in IDE code completion. We like static classes for constants because it
  // name spaces them and gives them a self documenting group and context that
  // they belong to.
  AppIcons._();
  // Icons for navigation destinations
  static const IconData home = Icons.home_outlined;
  static const IconData homeSelected = Icons.home;

  static const IconData info = Icons.info_outlined;
  static const IconData infoSelected = Icons.info;

  static const IconData settings = Icons.settings_outlined;
  static const IconData settingsSelected = Icons.settings;

  static const IconData theme = Icons.palette_outlined;
  static const IconData themeSelected = Icons.palette;

  static const IconData tabs = Icons.view_column_outlined;
  static const IconData tabsSelected = Icons.view_column;

  static const IconData slivers = Icons.label_outlined;
  static const IconData sliversSelected = Icons.label;

  static const IconData preview = Icons.phone_iphone_outlined;
  static const IconData previewSelected = Icons.tablet_mac_rounded;

  static const IconData help = Icons.help_outline;
  static const IconData helpSelected = Icons.help;

  static const IconData about = Icons.text_snippet_outlined;
  static const IconData aboutSelected = Icons.text_snippet;

  // The menu icons we decided to use in this demo app
  static const Widget menuIcon = Icon(Icons.menu);
  static const Widget menuIconExpand = Icon(Icons.last_page_outlined);
  static const Widget menuIconExpandHidden =
      RotatedBox(quarterTurns: 2, child: Icon(Icons.menu_open));
  static const Widget menuIconCollapse = Icon(Icons.first_page_outlined);

  static const Widget sidebarIcon = Icon(Icons.more_vert);
  static const Widget sidebarIconExpand = Icon(Icons.first_page_outlined);
  static const Widget sidebarIconExpandHidden = Icon(Icons.more_horiz);
  static const Widget sidebarIconCollapse = Icon(Icons.last_page_outlined);

  // Icons for platform selection dropdown. Used better logos from MDI Icons
  // here before, but decided to remove dependency on MDI Icons for
  // this demo https://pub.dev/packages/material_design_icons_flutter
  static const Widget logoAndroid = Icon(Icons.phone_android_rounded);
  static const Widget logoApple = Icon(Icons.phone_iphone_rounded);
  static const Widget logoMac = Icon(Icons.laptop_mac_rounded);
  static const Widget logoWindows = Icon(Icons.desktop_windows_rounded);
  static const Widget logoLinux = Icon(Icons.desktop_windows_sharp);
  static const Widget logoFuchsia = Icon(Icons.laptop_chromebook_rounded);
}
