import 'package:flexfold/flexfold.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier for the immutable AppNavigation data.
class AppNavigationStateNotifier extends StateNotifier<AppNavigation> {
  AppNavigationStateNotifier([AppNavigation? appNavigation])
      : super(
          appNavigation ??
              const AppNavigation(
                modalDestination: FlexfoldDestinationData(),
                destination: FlexfoldDestinationData(),
              ),
        );

  void newDestination(FlexfoldDestinationData value) {
    state = state.copyWith(destination: value);
  }

  void newModalDestination(FlexfoldDestinationData value) {
    state = state.copyWith(modalDestination: value);
  }

  void useModalDestination(bool value) {
    state = state.copyWith(useModalDestination: value);
  }
}

// Data class to hold current Flexfold destination and navigation key.
@immutable
class AppNavigation {
  const AppNavigation({
    this.useModalDestination = false,
    required this.destination,
    required this.modalDestination,
    // required this.navKey,
  });

  /// Use the modal destination?
  final bool useModalDestination;

  /// Current Flexfold destination
  final FlexfoldDestinationData destination;

  /// Current Flexfold modal destination
  final FlexfoldDestinationData modalDestination;

  AppNavigation copyWith({
    bool? useModalDestination,
    FlexfoldDestinationData? destination,
    FlexfoldDestinationData? modalDestination,
    GlobalKey<NavigatorState>? navKey,
  }) {
    return AppNavigation(
      useModalDestination: useModalDestination ?? this.useModalDestination,
      destination: destination ?? this.destination,
      modalDestination: modalDestination ?? this.modalDestination,
    );
  }

  @override
  String toString() {
    return 'AppNavigation(useModalDestination: $useModalDestination, '
        'destination: $destination, modalDestination: $modalDestination';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppNavigation &&
        other.useModalDestination == useModalDestination &&
        other.destination == destination &&
        other.modalDestination == modalDestination;
  }

  @override
  int get hashCode {
    return useModalDestination.hashCode ^
        destination.hashCode ^
        modalDestination.hashCode;
  }
}
