import 'package:flutter/material.dart';

mixin HasFormKeyMixin<T extends StatefulWidget> on State<T> {
  GlobalKey<FormState> fk;

  @override
  void initState() {
    fk = GlobalKey<FormState>();
    super.initState();
  }

  void save() => fk.currentState?.save();

  bool validate() => fk.currentState?.validate();
}
