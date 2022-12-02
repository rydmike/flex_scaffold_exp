import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/app_navigation_state.dart';

// StateNotifierProvider for keeping track of the navigation state
// and current FlexfoldDestinationData.

final StateNotifierProvider<AppNavigationStateNotifier, AppNavigation>
    navigationPod =
    StateNotifierProvider<AppNavigationStateNotifier, AppNavigation>(
  (StateNotifierProviderRef<AppNavigationStateNotifier, AppNavigation> ref) {
    return AppNavigationStateNotifier();
  },
);
