import 'package:flutter/material.dart';

class AppDimens {
  static late Size _screenSize;
  static late double _w;
  static late double _h;

  static void init(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _w = _screenSize.width;
    _h = _screenSize.height;
  }

  static double get scale => (_w / 390).clamp(0.85, 1.4);

  static double get spacingXSmall => 4 * scale;
  static double get spacingSmall => 8 * scale;
  static double get spacingMedium => 16 * scale;
  static double get spacingLarge => 24 * scale;
  static double get spacingXLarge => 32 * scale;

  static double get paddingSmall => 10 * scale;
  static double get paddingMedium => 16 * scale;
  static double get paddingLarge => 24 * scale;

  static double get radiusSmall => 8 * scale;
  static double get radiusMedium => 12 * scale;
  static double get radiusLarge => 16 * scale;
  static BorderRadius get cardRadius => BorderRadius.circular(radiusLarge);

  static double get iconSmall => 18 * scale;
  static double get iconMedium => 22 * scale;
  static double get iconLarge => 28 * scale;
  static double get avatarSize => 44 * scale;

  static double get searchBarHeight => (_h * 0.066).clamp(48, 56).toDouble();
  static double get buttonHeight => 48 * scale;
  static double get chipHeight => 36 * scale;

  static double get elevation0 => 0;
  static double get elevation1 => 1;
  static double get elevation2 => 2;
  static double get elevation4 => 4;
}
