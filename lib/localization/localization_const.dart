
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/localization/demo_localization.dart';

const String LANGUAGE_CODE = 'languageCode';

const String EN = 'en';
const String ID = 'id';

Future<Locale> setLocale(String languageCode) async {
  var _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
    var _prefs = await SharedPreferences.getInstance();
    var languageCode = _prefs.getString(LANGUAGE_CODE) ?? ID;
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

String translateStatus(BuildContext context, String status) {
  switch(status.toLowerCase()){
    case "menunggu pembayaran" :
      return getTranslated(context, 'order_waiting_payment');
      break;
    case "menunggu konfirmasi" :
      return getTranslated(context, 'order_waiting_confirm');
      break;
    case "pesanan diproses" :
      return getTranslated(context, 'order_processed');
      break;
    case "pesanan dikirim" :
      return getTranslated(context, 'order_shipped');
      break;
    case "pesanan dibatalkan" :
      return getTranslated(context, 'order_cancel');
      break;
    default :
      return status;
  }
}

String translateCategory(BuildContext context, String category){

  switch (category.toLowerCase()){
    case "makanan" :
      return getTranslated(context, 'cat_food');
      break;
    case "minuman" :
      return getTranslated(context, 'cat_beverage');
      break;
    case "perkakas" :
      return getTranslated(context, 'cat_tools');
      break;
    case "rumah tangga" :
      return getTranslated(context, 'cat_home');
      break;
    case "furniture" :
      return getTranslated(context, 'cat_furniture');
      break;
    default :
      return category;
  }
}
