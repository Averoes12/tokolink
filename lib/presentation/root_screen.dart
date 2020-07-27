import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/infrastructure/constants/styles.dart';
import 'package:tokolink/presentation/onboarding/onboarding_screen.dart';

import 'widgets/size_config.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tokolink',
      theme: StyleConfig.defaultStyle,
      builder: materialAppBuilder,
      home: OnBoardingScreen(),
    );
  }

  Widget materialAppBuilder(BuildContext context, Widget widget) {
    return Navigator(
      onGenerateRoute: (context) => MaterialPageRoute(
        builder: (context) {
          MediaQueryData _mediaQueryData = MediaQuery.of(context);
          double _screenWidth = _mediaQueryData.size.width;
          double _screenHeight = _mediaQueryData.size.height;
          double _blockSizeHorizontal = _screenWidth / 100;
          double _blockSizeVertical = _screenHeight / 100;
          double _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
          double _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
          double _safeBlockHorizontal = (_screenWidth - _safeAreaHorizontal) / 100;
          double _safeBlockVertical = (_screenHeight - _safeAreaVertical) / 100;

          return SizeConfig(
            child: widget,
            mediaQueryData: _mediaQueryData,
            screenWidth: _screenWidth,
            screenHeight: _screenHeight,
            blockSizeHorizontal: _blockSizeHorizontal,
            blockSizeVertical: _blockSizeVertical,
            safeBlockHorizontal: _safeBlockHorizontal,
            safeBlockVertical: _safeBlockVertical,
          );
        },
      ),
    );
  }
}
