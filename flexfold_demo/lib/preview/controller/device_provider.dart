// A state provider to enable and disable DevicePreview.
// This provider is on purpose not persisted.
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<bool> useDevicePreviewProvider =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return false;
});
