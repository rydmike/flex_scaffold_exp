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
  final FlexTarget destination;

  /// Current top level destination, but pushed on top in mobile/small views.
  final FlexTarget pushedDestination;

  CurrentRoute copyWith({
    bool? usePush,
    FlexTarget? destination,
    FlexTarget? pushedDestination,
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
                pushedDestination: FlexTarget(),
                destination: FlexTarget(),
              ),
        );

  void setDestination(FlexTarget value) {
    state = state.copyWith(destination: value, usePush: false);
  }

  void setModalDestination(FlexTarget value) {
    state = state.copyWith(pushedDestination: value, usePush: true);
  }
}
