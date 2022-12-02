import 'package:google_fonts/google_fonts.dart';

/// Fonts assets used in this application,
class AppFonts {
  // This class is not meant to be instantiated or extended. This constructor
  // prevents external instantiation and extension, plus it does not show up
  // in IDE code completion. We like static classes for constants because it
  // name spaces them and gives them a self documenting group and context that
  // they belong to.
  AppFonts._();

  // We use usage specific terms like mainFont and logoFont in the code,
  // not actual font names. These names then refer to const strings containing
  // the actual used font name.
  static String mainFont = fontRoboto;
  static String logoFont = fontRubikMono;

  // We use Roboto as an asset so we can get it on all platforms to have the
  // same look. If we do not do this, then on some platforms we will instead
  // get a Roboto 'like' font as replacement font. In this app we want to make
  // sure we actually use Roboto on all platforms. So we provide it as a bundled
  // asset and also specify it in our theme explicitly via the mainFont.
  static String fontRoboto = GoogleFonts.roboto().fontFamily ?? 'Roboto';

  // This font is only used by the logo text.
  static String fontRubikMono =
      GoogleFonts.rubikMonoOne().fontFamily ?? 'Roboto';
}
