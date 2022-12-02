/// AppInsets represents the sizes used in this app, usually multiple of 2 in a
/// gradually increasing way, like 2, 4, 8, 16, 32, 64, ...
class AppInsets {
  // This class is not meant to be instantiated or extended. This constructor
  // prevents external instantiation and extension, plus it does not show up
  // in IDE code completion. We like static classes for constants because it
  // name spaces them and gives them a self documenting group and context that
  // they belong to.
  AppInsets._();
  static const double xs = 2;
  static const double s = 4;
  static const double m = 8;
  static const double l = 16;
  static const double xl = 32;
  static const double xxl = 64;

  static const double buttonRadius = 50;
  static const double outlineThickness = 1.5;

  // The max dp width used for layout content on the screen in the available
  // body area. Wider content gets growing side padding, kind of like on most
  // web pages when they are used on super wide screen. Just a design used for
  // this demo app, that works pretty well in used examples.
  static const double maxBodyWidth = 1000;

  // Breakpoint in dp for when we consider the width to be a desktop and change
  // layout style for some content elements, mostly ListTile's get wrapped
  // in an extra Card container in this demo app.
  // NOTE: This is just for some content in the Flexfold demo app and has
  // nothing to do with the breakpoints Flexfold uses for its layout.
  static const double desktopSize = 1024;
}
