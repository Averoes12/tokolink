import 'package:flutter/material.dart';

mixin HasScaffoldKeyMixin<T extends StatefulWidget> on State<T> {
  GlobalKey<ScaffoldState> sk;

  @override
  void initState() {
    sk = GlobalKey<ScaffoldState>();
    super.initState();
  }

  void showSnackBar(String text) => sk.currentState?.showSnackBar(SnackBar(content: Text(text)));
}
