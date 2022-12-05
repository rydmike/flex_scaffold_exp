import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/app_text_direction.dart';
import '../store/hive_store.dart';
import '../store/key_store.dart';

// This file contains StateProviders that control app settings for:
// - Device preview usage
// - LTR/RTL text direction tests
// - Modal routes for Drawer routes that are not in bottom nav in phone view.
// - Animated plasma background for sidebar and home screen.
//
// StateProviders are really simple and convenient to use for settings that
// toggle and change values for application wide effects. They are easy to
// bake into controls and only the parts that really need to rebuild is built
// when the value is toggled.
//
// The StateProviders also have a name and default value in map.
// Hive and a ProviderObserver is used to store and persist the StateProvider
// whenever its value is changed, and the default value map gives us a way to
// reset the values to their default when so required.
//
// This setup is a bit tedious to setup due to the large number of
// StateProviders that is needed an app like this with many setting. Using
// a custom state object and StateNotifierProvider would be easier. However,
// with it you would have to use select filter if you want to rebuild controls
// based on individual property changes and to update persisted value only for
// the property that changed. The myriad of individual StateProviders gives
// us that desired feature automatically.

// A state provider to enable and disable DevicePreview.
// This provider is on purpose not persisted.
final StateProvider<bool> useDevicePreviewProvider =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return false;
});

// StateProvider for the platform. This one is currently not persisted on
// on purpose. We always want to get it reset to native platform when
// restarting. It is mostly available for debugging purposes.
final StateProvider<TargetPlatform> platformProvider =
    StateProvider<TargetPlatform>((StateProviderRef<TargetPlatform> ref) {
  return defaultTargetPlatform;
});

// TODO(rydmike): Maybe remove persistence from this one too?
// StateProvider for the custom text direction.
final StateProvider<AppTextDirection> appTextDirectionProvider =
    StateProvider<AppTextDirection>((StateProviderRef<AppTextDirection> ref) {
  return hiveStore.get(KeyStore.appTextDirection,
      defaultValue: KeyStore.defaults[KeyStore.appTextDirection]!
          as AppTextDirection) as AppTextDirection;
}, name: KeyStore.appTextDirection);

// A provider that returns the actual TextDirection from out wrapper enum
// that has a local based option as well.
//
// When local based is used, we will return null and we will use
// Directionality.of(context) as fallback for the app directionality.
final Provider<TextDirection?> appDirectionality = Provider<TextDirection?>(
  (ProviderRef<TextDirection?> ref) {
    switch (ref.watch(appTextDirectionProvider)) {
      case AppTextDirection.ltr:
        return TextDirection.ltr;
      case AppTextDirection.rtl:
        return TextDirection.rtl;
      case AppTextDirection.localeBased:
        return null;
    }
  },
  name: 'appDirectionalityProvider',
);

// StateProvider for using modal routes on non bottom bar destinations on
// phone sized canvas, ie navigation from Drawer.
final StateProvider<bool> useModalRoutesProvider =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.useModalRoutes,
          defaultValue: KeyStore.defaults[KeyStore.useModalRoutes]! as bool)
      as bool;
}, name: KeyStore.useModalRoutes);

// StateProvider for turning on Plasma background animation on sidebar and
// home screen. this is just a fun demo effect.
final StateProvider<bool> plasmaBackgroundProvider =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(KeyStore.plasmaBackground,
          defaultValue: KeyStore.defaults[KeyStore.plasmaBackground]! as bool)
      as bool;
}, name: KeyStore.plasmaBackground);
