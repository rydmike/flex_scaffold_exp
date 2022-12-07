import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flexfold/flexfold.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../core/models/app_animation_curve.dart';
import '../core/models/app_text_direction.dart';

// Hive box name, used for the Hive box that stores all settings.
const String kHiveBox = 'flexfold_demo_store';

// A ref to the used Hive box store, it must be opened before used, which it
// will be since we open it once at the start of the app and don't close it
// anywhere in this color Flexfold demo app.
final Box<dynamic> hiveStore = Hive.box<dynamic>(kHiveBox);

// Register all custom Hive data adapters.
void registerHiveAdapters() {
  Hive.registerAdapter(ThemeModeAdapter());
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(FlexSurfaceModeAdapter());
  Hive.registerAdapter(FlexTabBarStyleAdapter());
  Hive.registerAdapter(FlexAppBarStyleAdapter());
  Hive.registerAdapter(AppTextDirectionAdapter());
  Hive.registerAdapter(FlexfoldHighlightTypeAdapter());
  Hive.registerAdapter(TargetPlatformAdapter());
  Hive.registerAdapter(FlexfoldMenuStartAdapter());
  Hive.registerAdapter(FlexfoldMenuSideAdapter());
  Hive.registerAdapter(FlexfoldBottomBarTypeAdapter());
  Hive.registerAdapter(AppAnimationCurveAdapter());
}

// A Hive data type adapter for enum ThemeMode.
class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  ThemeMode read(BinaryReader reader) {
    final int index = reader.readInt();
    return ThemeMode.values[index];
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 150;
}

// A Hive data type adapter for class Color.
class ColorAdapter extends TypeAdapter<Color> {
  @override
  Color read(BinaryReader reader) {
    final int value = reader.readInt();
    return Color(value);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeInt(obj.value);
  }

  @override
  int get typeId => 151;
}

// A Hive data type adapter for enum FlexSurfaceMode.
class FlexSurfaceModeAdapter extends TypeAdapter<FlexSurfaceMode> {
  @override
  FlexSurfaceMode read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexSurfaceMode.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexSurfaceMode obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 152;
}

// A Hive data type adapter for enum FlexTabBarStyle.
class FlexTabBarStyleAdapter extends TypeAdapter<FlexTabBarStyle> {
  @override
  FlexTabBarStyle read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexTabBarStyle.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexTabBarStyle obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 153;
}

// A Hive data type adapter for enum FlexAppBarStyle.
class FlexAppBarStyleAdapter extends TypeAdapter<FlexAppBarStyle> {
  @override
  FlexAppBarStyle read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexAppBarStyle.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexAppBarStyle obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 154;
}

// A Hive data type adapter for enum CustomTextDirection.
class AppTextDirectionAdapter extends TypeAdapter<AppTextDirection> {
  @override
  AppTextDirection read(BinaryReader reader) {
    final int index = reader.readInt();
    return AppTextDirection.values[index];
  }

  @override
  void write(BinaryWriter writer, AppTextDirection obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 155;
}

// A Hive data type adapter for enum TargetPlatform.
class TargetPlatformAdapter extends TypeAdapter<TargetPlatform> {
  @override
  TargetPlatform read(BinaryReader reader) {
    final int index = reader.readInt();
    return TargetPlatform.values[index];
  }

  @override
  void write(BinaryWriter writer, TargetPlatform obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 156;
}

// A Hive data type adapter for enum FlexfoldHighlightType.
class FlexfoldHighlightTypeAdapter extends TypeAdapter<FlexIndicatorStyle> {
  @override
  FlexIndicatorStyle read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexIndicatorStyle.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexIndicatorStyle obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 157;
}

// A Hive data type adapter for enum FlexfoldMenuStart.
class FlexfoldMenuStartAdapter extends TypeAdapter<FlexfoldMenuStart> {
  @override
  FlexfoldMenuStart read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexfoldMenuStart.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexfoldMenuStart obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 158;
}

// A Hive data type adapter for enum FlexfoldMenuSide.
class FlexfoldMenuSideAdapter extends TypeAdapter<FlexfoldMenuSide> {
  @override
  FlexfoldMenuSide read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexfoldMenuSide.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexfoldMenuSide obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 159;
}

// A Hive data type adapter for enum FlexfoldBottomBarType.
class FlexfoldBottomBarTypeAdapter extends TypeAdapter<FlexfoldBottomBarType> {
  @override
  FlexfoldBottomBarType read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexfoldBottomBarType.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexfoldBottomBarType obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 160;
}

// A Hive data type adapter for enum AppTextDirection.
class AppAnimationCurveAdapter extends TypeAdapter<AppAnimationCurve> {
  @override
  AppAnimationCurve read(BinaryReader reader) {
    final int index = reader.readInt();
    return AppAnimationCurve.values[index];
  }

  @override
  void write(BinaryWriter writer, AppAnimationCurve obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 161;
}
