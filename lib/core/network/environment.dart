import 'package:flutter/cupertino.dart';

enum AppEnvironment { dev, live }

class Environment {
  static AppEnvironment _env = AppEnvironment.dev;

  static void setEnvironment(AppEnvironment env) {
    _env = env;
  }

  static bool get isDev => _env == AppEnvironment.dev;
  static bool get isLive => _env == AppEnvironment.live;
}


extension MediaQueryValues on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  Orientation get orientation => MediaQuery.of(this).orientation;
}


extension SpaceExtension on num {
  /// Horizontal space (width)
  SizedBox get width => SizedBox(width: toDouble());

  /// Vertical space (height)
  SizedBox get height => SizedBox(height: toDouble());
}
