import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/pods_theme.dart';
import 'surface_mode_widgets.dart';

class SurfaceStyleSwitch extends ConsumerWidget {
  const SurfaceStyleSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SurfaceModeToggleButtons(
      mode: ref.watch(surfaceStylePod),
      onChanged: (FlexSurfaceMode value) {
        ref.read(surfaceStylePod.notifier).state = value;
      },
    );
  }
}
