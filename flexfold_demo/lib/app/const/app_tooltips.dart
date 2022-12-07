/// The tooltips used on menu buttons.
class AppTooltips {
  // This class is not meant to be instantiated or extended. This constructor
  // prevents external instantiation and extension, plus it does not show up
  // in IDE code completion. We like static classes for constants because it
  // name spaces them and gives them a self documenting group and context that
  // they belong to.
  AppTooltips._();
  static const String openMenu = 'Open navigation drawer';
  static const String closeMenu = 'Close navigation drawer';
  static const String expandMenu = 'Show as fixed menu';
  static const String expandHiddenMenu = 'Show hidden menu';
  static const String collapseMenu = 'Collapse menu';

  static const String openSidebar = 'Open sidebar drawer';
  static const String closeSidebar = 'Close sidebar drawer';
  static const String expandSidebar = 'Show as fixed sidebar';
  static const String expandHiddenSidebar = 'Show hidden sidebar';
  static const String collapseSidebar = 'Hide sidebar';
}
