import 'package:flutter/material.dart';

class SizeConfig extends InheritedWidget {
  final MediaQueryData mediaQueryData;
  final double screenWidth;
  final double screenHeight;
  final double blockSizeHorizontal;
  final double blockSizeVertical;
  final double safeBlockHorizontal;
  final double safeBlockVertical;
  final Widget child;

  SizeConfig({
    this.mediaQueryData,
    this.screenWidth,
    this.screenHeight,
    this.blockSizeHorizontal,
    this.blockSizeVertical,
    this.safeBlockHorizontal,
    this.safeBlockVertical,
    @required this.child,
  });

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SizeConfig of(BuildContext context) => context.dependOnInheritedWidgetOfExactType();
}
