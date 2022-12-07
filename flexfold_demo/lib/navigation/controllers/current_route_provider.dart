import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_navigation_state.dart';

/// StateNotifierProvider for keeping track of the current navigation route.
final StateNotifierProvider<CurrentRouteStateNotifier, CurrentRoute>
    currentRouteProvider =
    StateNotifierProvider<CurrentRouteStateNotifier, CurrentRoute>(
  (StateNotifierProviderRef<CurrentRouteStateNotifier, CurrentRoute> ref) {
    return CurrentRouteStateNotifier();
  },
);
