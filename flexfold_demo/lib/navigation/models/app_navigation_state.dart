import 'package:flexfold/flexfold.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Data class to hold current FlexScaffold destination route for top level and
// top level destination pushed on top in small device navigation.
@immutable
class CurrentRoute {
  const CurrentRoute({
    this.usePush = false,
    required this.destination,
    required this.pushedDestination,
    // required this.navKey,
  });

  /// Use push to put the destination as a route on top of other top level
  /// navigation destinations.
  final bool usePush;

  /// Current top level destination
  final GoFlexDestination destination;

  /// Current top level destination, but pushed on top in mobile/small views.
  final GoFlexDestination pushedDestination;

  CurrentRoute copyWith({
    bool? usePush,
    GoFlexDestination? destination,
    GoFlexDestination? pushedDestination,
  }) {
    return CurrentRoute(
      usePush: usePush ?? this.usePush,
      destination: destination ?? this.destination,
      pushedDestination: pushedDestination ?? this.pushedDestination,
    );
  }

  @override
  String toString() {
    return 'AppNavigation(useModalDestination: $usePush, '
        'destination: $destination, modalDestination: $pushedDestination';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CurrentRoute &&
        other.usePush == usePush &&
        other.destination == destination &&
        other.pushedDestination == pushedDestination;
  }

  @override
  int get hashCode {
    return usePush.hashCode ^ destination.hashCode ^ pushedDestination.hashCode;
  }
}

// StateNotifier for the immutable AppNavigation data.
class CurrentRouteStateNotifier extends StateNotifier<CurrentRoute> {
  CurrentRouteStateNotifier([CurrentRoute? appNavigation])
      : super(
          appNavigation ??
              const CurrentRoute(
                pushedDestination: GoFlexDestination(),
                destination: GoFlexDestination(),
              ),
        );

  void setDestination(GoFlexDestination value) {
    state = state.copyWith(destination: value, usePush: false);
  }

  void setModalDestination(GoFlexDestination value) {
    state = state.copyWith(pushedDestination: value, usePush: true);
  }
}
