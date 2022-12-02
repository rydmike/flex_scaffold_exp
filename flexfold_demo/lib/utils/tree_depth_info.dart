import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// Set to true to observe debug prints. In release mode this compile time
// const always evaluates to false, so in theory anything with only an
// if (_kDebugMe) {} should get tree shaken away in a release build.
const bool _kDebugMe = kDebugMode && true; // Set to false to disable totally.

// This function will debug print the current depth of the Widget tree
// Going over 590 widgets in Widget depth is a bad idea:
// See issue: https://github.com/flutter/flutter/issues/85026
// You can call this function from a widget's build context to get an idea
// of your Widget tree depth at the build context in question.
void treeDepthInfo(BuildContext context, [String place = '']) {
  if (_kDebugMe) {
    final Element element = context as Element;
    debugPrint('$place depth = ${element.depth}');
  }
}
