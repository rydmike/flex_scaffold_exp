import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../store/hive_store.dart';
import '../../store/key_store.dart';

const bool _kDebugMe = kDebugMode && true;

/// Provider observer used to store the state of selected Riverpod
/// providers and debugPrint changes to them in debug mode.
class AppProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<dynamic> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    // If it is a StateProvider we will save the value if...
    if (provider is StateProvider) {
      // If its new value is different from previous value AND
      // it is one that we have a named key for, we store it in Hive
      if (newValue != previousValue &&
          KeyStore.defaults.containsKey(provider.name)) {
        // Log the new value, but not in Release, just a debugPrint.
        if (_kDebugMe) {
          debugPrint('Store: ${provider.name ?? provider.runtimeType}\n'
              '  new value: $newValue\n'
              '  old value: $previousValue');
        }
        // Store the new state provider value to our Hive box.
        unawaited(hiveStore.put(provider.name, newValue));
      }
      // }
    }
  }
}
