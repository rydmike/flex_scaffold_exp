import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/app_navigation_state.dart';

// StateNotifierProvider for keeping track of the navigation state
// and current FlexfoldDestinationData.

final StateNotifierProvider<CurrentRouteStateNotifier, CurrentRoute>
    currentRouteProvider =
    StateNotifierProvider<CurrentRouteStateNotifier, CurrentRoute>(
  (StateNotifierProviderRef<CurrentRouteStateNotifier, CurrentRoute> ref) {
    return CurrentRouteStateNotifier();
  },
);
