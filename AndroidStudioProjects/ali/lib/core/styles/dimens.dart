import 'dart:math' as math;
import 'package:flutter/material.dart';

class AppDimens {
  // ====== MediaQuery cache ======
  static late MediaQueryData _mq;
  static late Size _screenSize;
  static late double _w, _h;

  static late Orientation _orientation;
  static late EdgeInsets _viewInsets;   // الكيبورد
  static late EdgeInsets _viewPadding;  // الحواف الآمنة/النتش
  static late double _textScale;
  static late double _dpr;
  static late Brightness _platformBrightness;

  // نداء ضروري في build/داخليًا في كل صفحة/دايلوج مهم
  static void init(BuildContext context) {
    _mq = MediaQuery.of(context);
    _screenSize = _mq.size;
    _w = _screenSize.width;
    _h = _screenSize.height;

    _orientation = _mq.orientation;
    _viewInsets = _mq.viewInsets;
    _viewPadding = _mq.viewPadding;
    _textScale = _mq.textScaleFactor; // (في الإصدارات الأحدث يوجد TextScaler)
    _dpr = _mq.devicePixelRatio;
    _platformBrightness = _mq.platformBrightness;
  }

  // ====== Helpers عامة من MediaQuery ======
  static Size get screenSize => _screenSize;
  static double get screenWidth => _w;
  static double get screenHeight => _h;

  static Orientation get orientation => _orientation;
  static bool get isLandscape => _orientation == Orientation.landscape;
  static bool get isPortrait  => !isLandscape;

  static EdgeInsets get safePadding => _viewPadding;
  static double get safeTop    => _viewPadding.top;
  static double get safeBottom => _viewPadding.bottom;
  static double get safeLeft   => _viewPadding.left;
  static double get safeRight  => _viewPadding.right;

  static EdgeInsets get viewInsets => _viewInsets; // غالبًا الكيبورد
  static double get keyboardHeight => _viewInsets.bottom;
  static bool get isKeyboardOpen => keyboardHeight > 0;

  static double get textScale => _textScale;
  static double get dpr => _dpr;
  static Brightness get platformBrightness => _platformBrightness;

  static double vw(double percent) => _w * percent; // عرض نسبي (0..1)
  static double vh(double percent) => _h * percent; // ارتفاع نسبي (0..1)

  // أقصر ضلع → كشف تابلت/موبايل
  static double get shortestSide => math.min(_w, _h);
  static bool get isTablet => shortestSide >= 600;

  // ====== Scale أساسي (مبني على عرض 390 كمرجع) ======
  static double _clampDouble(double v, double min, double max) =>
      v < min ? min : (v > max ? max : v);

  static double get scale => _clampDouble(_w / 390.0, 0.85, 1.40);

  // ====== Spacing ======
  static double get spacingXSmall => 4 * scale;
  static double get spacingSmall  => 8 * scale;
  static double get spacingMedium => 16 * scale;
  static double get spacingLarge  => 24 * scale;
  static double get spacingXLarge => 32 * scale;

  // ====== Padding ======
  static double get paddingSmall  => 10 * scale;
  static double get paddingMedium => 16 * scale;
  static double get paddingLarge  => 24 * scale;

  // ====== Radius ======
  static double get radiusSmall  => 8 * scale;
  static double get radiusMedium => 12 * scale;
  static double get radiusLarge  => 16 * scale;
  static BorderRadius get cardRadius => BorderRadius.circular(radiusLarge);

  // ====== Icons / Avatars ======
  static double get iconSmall  => 18 * scale;
  static double get iconMedium => 22 * scale;
  static double get iconLarge  => 28 * scale;
  static double get avatarSize => 44 * scale;

  // ====== Controls ======
  static double get searchBarHeight =>
      _clampDouble(_h * 0.066, 48.0, 56.0); // 48..56 حسب ارتفاع الشاشة

  static double get buttonHeight => 48 * scale;
  static double get chipHeight   => 36 * scale;

  // ====== Elevation (ثابتة) ======
  static double get elevation0 => 0;
  static double get elevation1 => 1;
  static double get elevation2 => 2;
  static double get elevation4 => 4;

  // ====== أنماط مساعدة للاستجابة ======

  /// يختار قيمة حسب نقطة توقف العرض
  static T pick<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (_w >= 1200 && desktop != null) return desktop;
    if (_w >= 600  && tablet  != null) return tablet;
    return mobile;
  }

  /// حساب أعمدة Grid تقريبية حسب أقل عرض للعنصر
  static int gridColumns({double minTileWidth = 160, double spacing = 12}) {
    final usable = _w - safeLeft - safeRight;
    final cols = (usable / (minTileWidth + spacing)).floor();
    return math.max(1, cols);
  }

  /// تحويل قياس تصميم ثابت إلى قياس متكيّف
  static double s(double designValue) => designValue * scale;
}
