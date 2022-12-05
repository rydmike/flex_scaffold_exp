import 'package:flexfold/flexfold.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  final FlexDestinationTarget destination;

  /// Current Flexfold modal destination
  final FlexDestinationTarget modalDestination;

  AppNavigation copyWith({
    bool? useModalDestination,
    FlexDestinationTarget? destination,
    FlexDestinationTarget? modalDestination,
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

// StateNotifier for the immutable AppNavigation data.
class AppNavigationStateNotifier extends StateNotifier<AppNavigation> {
  AppNavigationStateNotifier([AppNavigation? appNavigation])
      : super(
          appNavigation ??
              const AppNavigation(
                modalDestination: FlexDestinationTarget(),
                destination: FlexDestinationTarget(),
              ),
        );

  void setDestination(FlexDestinationTarget value) {
    state = state.copyWith(destination: value, useModalDestination: false);
  }

  void setModalDestination(FlexDestinationTarget value) {
    state = state.copyWith(modalDestination: value, useModalDestination: true);
  }
}
