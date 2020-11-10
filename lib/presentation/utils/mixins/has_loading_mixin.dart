import 'package:flutter/widgets.dart';

mixin HasLoadingMixin<T extends StatefulWidget> on State<T> {
  bool loading;

  @override
  void initState() {
    loading = false;
    super.initState();
  }

  void loadingActive() => setState(() => loading = true);

  void loadingInactive() => setState(() => loading = false);
}
