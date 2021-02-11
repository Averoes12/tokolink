import 'package:flutter/material.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/localization/languages.dart';
import 'package:tokolink/localization/localization_const.dart';
import 'package:tokolink/presentation/screens/home/search_screen.dart';
import 'package:tokolink/presentation/screens/root_screen.dart';


class SearchAndNotificationWidget extends StatefulWidget {
  final bool hasNotification;

  const SearchAndNotificationWidget({Key key, this.hasNotification = false}) : super(key: key);

  @override
  _SearchAndNotificationWidgetState createState() => _SearchAndNotificationWidgetState();
}

class _SearchAndNotificationWidgetState extends State<SearchAndNotificationWidget> {

  void _changeLanguage(Language language) async {
    var _locale = await setLocale(language.languageCode);
    RootScreen.setLocale(context, _locale);
    print('Lang => ${language.languageCode}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen())),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: getTranslated(context, 'search_field_hint')),
              ),
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton(
              onChanged: (Language language) {
                print('Language => ${language.languageCode}');
                _changeLanguage(language);
              },
              underline: SizedBox(),
              icon: Icon(Icons.language),
              items: Language.languageList()
                .map<DropdownMenuItem<Language>>((e) => DropdownMenuItem<Language>(
                    value: e,
                    child: Text(e.name)
                )
              ).toList(),
            ),
          ),
          IconButton(
            onPressed: () {
              print('notifikasi');
            },
            icon: Icon(
              widget.hasNotification ? Icons.notifications_active : Icons.notifications,
              size: 30,
              color: ColorConfig.N4,
            ),
          ),
        ],
      ),
    );
  }
}
