import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/const/app_icons.dart';
import '../../../../core/controllers/app_controllers.dart';
import '../../../../preview/controller/device_provider.dart';

class PopupMenuPlatform extends ConsumerWidget {
  const PopupMenuPlatform({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String labelAndroid = 'Google Android';
    const String labelApple = 'Apple iOS';
    const String labelWindows = 'Microsoft Windows';
    const String labelMacOs = 'Apple MacOS';
    const String labelLinux = 'Linux';
    const String labelFuchsia = 'Google Fuchsia';

    const Map<TargetPlatform, PopupMenuItem<TargetPlatform>> platformItems =
        <TargetPlatform, PopupMenuItem<TargetPlatform>>{
      TargetPlatform.android: PopupMenuItem<TargetPlatform>(
        value: TargetPlatform.android,
        child: ListTile(
          leading: AppIcons.logoAndroid,
          title: Text(labelAndroid),
        ),
      ),
      TargetPlatform.iOS: PopupMenuItem<TargetPlatform>(
        value: TargetPlatform.iOS,
        child: ListTile(
          leading: AppIcons.logoApple,
          title: Text(labelApple),
        ),
      ),
      TargetPlatform.windows: PopupMenuItem<TargetPlatform>(
        value: TargetPlatform.windows,
        child: ListTile(
          leading: AppIcons.logoWindows,
          title: Text(labelWindows),
        ),
      ),
      TargetPlatform.macOS: PopupMenuItem<TargetPlatform>(
        value: TargetPlatform.macOS,
        child: ListTile(
          leading: AppIcons.logoMac,
          title: Text(labelMacOs),
        ),
      ),
      TargetPlatform.linux: PopupMenuItem<TargetPlatform>(
        value: TargetPlatform.linux,
        child: ListTile(
          leading: AppIcons.logoLinux,
          title: Text(labelLinux),
        ),
      ),
      TargetPlatform.fuchsia: PopupMenuItem<TargetPlatform>(
        value: TargetPlatform.fuchsia,
        child: ListTile(
          leading: AppIcons.logoFuchsia,
          title: Text(labelFuchsia),
        ),
      ),
    };

    const Map<TargetPlatform, String> platformString = <TargetPlatform, String>{
      TargetPlatform.android: labelAndroid,
      TargetPlatform.iOS: labelApple,
      TargetPlatform.windows: labelWindows,
      TargetPlatform.macOS: labelMacOs,
      TargetPlatform.linux: labelLinux,
      TargetPlatform.fuchsia: labelFuchsia,
    };

    const Map<TargetPlatform, Widget> platformIcon = <TargetPlatform, Widget>{
      TargetPlatform.android: AppIcons.logoAndroid,
      TargetPlatform.iOS: AppIcons.logoApple,
      TargetPlatform.windows: AppIcons.logoWindows,
      TargetPlatform.macOS: AppIcons.logoMac,
      TargetPlatform.linux: AppIcons.logoLinux,
      TargetPlatform.fuchsia: AppIcons.logoFuchsia,
    };

    String subtitle =
        'Current platform: ${platformString[ref.watch(platformProvider)]}';
    if (ref.watch(useDevicePreviewProvider)) {
      subtitle = 'Platform mechanics selection in the app is disabled in '
          'DevicePreview mode. The platform selection is controlled by '
          'DevicePreview';
    }
    return PopupMenuButton<TargetPlatform>(
      enabled: !ref.watch(useDevicePreviewProvider),
      padding: const EdgeInsets.all(10),
      onSelected: (TargetPlatform value) {
        subtitle = 'Current platform: ${platformString[value]}';
        ref.read(platformProvider.notifier).state = value;
      },
      itemBuilder: (BuildContext context) =>
          <PopupMenuItem<TargetPlatform>>[...platformItems.values],
      child: ListTile(
        trailing: platformIcon[ref.watch(platformProvider)],
        title: const Text('Select platform mechanics'),
        subtitle: Text(subtitle),
      ),
    );
  }
}
