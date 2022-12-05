/// The named routes and their labels (names).
class AppRoutes {
  /// Private constructor, only static members.
  AppRoutes._();
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

  // Sub routes and labels for the tabs on the tab screen
  static const String tabsGuide = 'guide';
  static const String tabsGuideLabel = 'Guide';

  static const String tabsAppbar = 'appbar';
  static const String tabsAppbarLabel = 'Appbar';

  static const String tabsImages = 'images';
  static const String tabsImagesLabel = 'Images';

  static const String tabsModal = 'modal';
  static const String tabsModalLabel = 'Modal';
}
