
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalization {

  final Locale locale;

  DemoLocalization(this.locale);

  static DemoLocalization of(BuildContext context){
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  Map<String, String> _localizedValues;

  Future<void> load() async {
    var jsonStringValues = await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));

  }

  String translate(String key){
    return _localizedValues[key];
  }

  //static member to have simple access to delegate from Material App
  static const LocalizationsDelegate<DemoLocalization> delegate = _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalization> {

  const _DemoLocalizationsDelegate();
  
  @override
  bool isSupported(Locale locale) {
    return ['en', 'id'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
    var localization = DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<DemoLocalization> old) => false;

}