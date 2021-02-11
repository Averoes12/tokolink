
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/localization/demo_localization.dart';

const String LANGUAGE_CODE = 'languageCode';

const String EN = 'en';
const String ID = 'id';

Future<Locale> setLocale(String languageCode) async {
  var _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, languageCode);
  print('SET PREFS LOCAL => ${languageCode}');
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
    var _prefs = await SharedPreferences.getInstance();
    var languageCode = _prefs.getString(LANGUAGE_CODE) ?? ID;
    print('Get Prefs Local => ${languageCode.toString()}');
    return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case EN :
      return Locale(EN, 'US');
      break;
    case ID :
      return Locale(ID, 'ID');
      break;
    default:
      return Locale(ID, 'ID');
  }
}

String getTranslated(BuildContext context, String key){
  return DemoLocalization.of(context).translate(key);
}