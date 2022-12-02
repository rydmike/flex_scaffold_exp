import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods/pods_flexfold.dart';

// A scroll controller listener function that will hide the
// bottom navigation bar, if it is visible when we scroll down and show it
// again when we scroll up.
void hideBottomOnScroll(WidgetRef ref, ScrollController scrollController) {
  // Get the appOptions model via a context read.
  // final AppOptionsModel appOptions = context.read(appOptionsModel);
  // We have a toggle in the app settings model that allows user to turn ON/OFF
  // the hide on-scrolling feature, if it is OFF we just skip all this and do
  // nothing via default return at the end of the function.
  if (ref.read(hideBottomBarOnScrollPod)) {
    // Reverse direction is scrolling down, we hide it, if not hidden.
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      // if not already set to hidden, we set it to hidden.
      if (!ref.read(scrollHiddenBottomBarPod)) {
        ref.read(scrollHiddenBottomBarPod.notifier).state = true;
      }
    }
    // Forward direction is scrolling up, we show it, if not shown already.
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      // If it is hidden, we set it to not be hidden anymore.
      if (ref.read(scrollHiddenBottomBarPod)) {
        ref.read(scrollHiddenBottomBarPod.notifier).state = false;
      }
    }
  }
}
