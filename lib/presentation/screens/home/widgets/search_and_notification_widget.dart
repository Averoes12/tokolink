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

  var langCode;
  void _changeLanguage(Language language) async {
    var _locale = await setLocale(language.languageCode);
    RootScreen.setLocale(context, _locale);
  }

  @override
  void didChangeDependencies() {
    getLocale().then((value){
      setState(() {
        langCode = value.languageCode.toUpperCase();
      });
    });
    super.didChangeDependencies();
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
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              IconButton(
                  icon: Icon(Icons.language),
                  color: ColorConfig.N4,
                  onPressed: (){
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => _languageSelect(context, Language.languageList())
                    ).then((value) => _changeLanguage(value));
                  }
              ),
              Text(langCode)
            ],
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

Widget _languageSelect(context, List<Language> language){
        return Container(
          child: Wrap(
            children:
            language.map((e) =>
              ListTile(
                title: Text(e.name),
                onTap: (){
                  Navigator.pop(context, e);
                },
              )
            ).toList()
          ),
        );
}