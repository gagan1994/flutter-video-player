import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;

  static double screenWidthWithPercentage(double percentage) {
    return _screenWidth * percentage / 100;
  }

  static double screenHeightWithPercentage(double percentage) {
    return _screenHeight * percentage / 100;
  }

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = _screenWidth / 100;
    blockSizeVertical = _screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (_screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (_screenHeight - _safeAreaVertical) / 100;
  }
}
