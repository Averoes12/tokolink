import 'package:flutter/material.dart';
import '../configs/app_size.dart';

mixin HasSizeMixin<T extends StatefulWidget> on State<T> {
  AppSize appSize;
  double screenWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appSize = AppSize.of(context);
    screenWidth = appSize.mediaQueryData.orientation == Orientation.landscape ? 50 : 100;
  }
}
