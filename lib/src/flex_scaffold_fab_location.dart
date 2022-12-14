import 'package:flutter/material.dart';

/// Custom FAB location
class StartFloatFabLocation extends StandardFabLocation
    with FabStartOffsetX, FabTopOffsetY {
  /// Create a FAB for FAB start top position
  const StartFloatFabLocation();

  @override
  String toString() => 'FloatingActionButtonLocation.startTop';
}
