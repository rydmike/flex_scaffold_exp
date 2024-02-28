/// App constant strings used in the Flexfold demo application. Just for
/// a few labels and strings we may want to change easily. This is not for
/// any translation purposes.
class AppStrings {
  // This class is not meant to be instantiated or extended. This constructor
  // prevents external instantiation and extension, plus it does not show up
  // in IDE code completion. We like static classes for constants because it
  // name spaces them and gives them a self documenting group and context that
  // they belong to.
  AppStrings._();
  static const String appName = 'FlexScaffold Demo';
  static const String version = '0.0.10';
  static const String flutter = 'Built with channel Stable, 3.19.1, CanvasKit';
  static const String copyright = '© 2024';
  static const String author = 'Mike Rydstrom';
  static const String license = 'BSD 3-Clause License';

  static const String flex = 'Flex';
  static const String fold = 'Fold';

  // The max dp width used for layout content on the screen in the available
  // body area. Wider content gets growing side padding, kind of like on most
  // web pages when they are used on super wide screen. Just a design used for
  // this demo app, that works pretty well in this use case.
  static const double maxBodyWidth = 1000;

  // Edge padding for page content on the screen. A better looking result
  // can be obtained if this increases in steps depending on canvas size.
  // Keeping it fairly tight now, but not too small, it is a compromise for
  // both phone and larger media.
  static const double edgePadding = 14;

  // Breakpoint in dp for when we consider the width to be a desktop and change
  // layout style for some content elements, mostly ListTile's get wrapped
  // in an extra Card container in this demo app.
  // NOTE: This is just for some content in the Flexfold demo app and has
  // nothing to do with the breakpoints Flexfold uses for its layout.
  static const double desktopSize = 1024;

  // Misc strings for the demo app.
  static const String user = 'Mike Rydstrom';
  static const String company = 'Rydmike Ltd';
}
