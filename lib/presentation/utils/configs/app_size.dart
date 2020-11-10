import 'package:flutter/material.dart';

class AppSize extends InheritedWidget {
  final MediaQueryData mediaQueryData;
  final double screenWidth;
  final double screenHeight;
  final double blockSizeHorizontal;
  final double blockSizeVertical;
  final double safeBlockHorizontal;
  final double safeBlockVertical;
  final bool tabletMode;
  @override
  final Widget child;

  AppSize({
    this.mediaQueryData,
    this.screenWidth,
    this.screenHeight,
    this.blockSizeHorizontal,
    this.blockSizeVertical,
    this.safeBlockHorizontal,
    this.safeBlockVertical,
    this.tabletMode,
    @required this.child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppSize of(BuildContext context) => context.dependOnInheritedWidgetOfExactType();
}
