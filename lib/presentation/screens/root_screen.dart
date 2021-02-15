import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/infrastructure/constants/styles.dart';
import 'package:tokolink/localization/demo_localization.dart';
import 'package:tokolink/localization/localization_const.dart';
import 'package:tokolink/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:tokolink/presentation/utils/configs/app_size.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_RootScreenState>();
    state.setLocale(newLocale);
  }

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  SharedPreferences prefs;
  bool isLogin = false;
  Locale _locale;
  @override
  void initState() {
    _goHome();
    super.initState();
  }

  void _goHome() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      setState(() {
        isLogin = true;
      });
    }
  }

  setLocale(Locale locale){
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLocale().then((locale){
      setState(() {
        _locale = locale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tokolink',
      theme: StyleConfig.defaultStyle,
      builder: _materialBuilder,
      home: OnBoardingScreen(),
      locale: _locale,
      supportedLocales: [
        Locale('id', 'ID'),
        Locale('en', 'US')
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for(var supportedLocale in supportedLocales) {
          if(supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }

  Widget _materialBuilder(BuildContext context, Widget widget) => Navigator(
        onGenerateRoute: (context) => MaterialPageRoute(
          builder: (context) {
            final _mediaQueryData = MediaQuery.of(context);
            final _screenWidth = _mediaQueryData.size.width;
            final _screenHeight = _mediaQueryData.size.height;
            final _blockSizeHorizontal = _screenWidth / 100;
            final _blockSizeVertical = _screenHeight / 100;
            final _safeAreaHorizontal =
                _mediaQueryData.padding.left + _mediaQueryData.padding.right;
            final _safeAreaVertical =
                _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
            final _safeBlockHorizontal =
                (_screenWidth - _safeAreaHorizontal) / 100;
            final _safeBlockVertical =
                (_screenHeight - _safeAreaVertical) / 100;

            return AppSize(
              child: widget,
              mediaQueryData: _mediaQueryData,
              screenWidth: _screenWidth,
              screenHeight: _screenHeight,
              blockSizeHorizontal: _blockSizeHorizontal,
              blockSizeVertical: _blockSizeVertical,
              safeBlockHorizontal: _safeBlockHorizontal,
              safeBlockVertical: _safeBlockVertical,
              tabletMode: false,
            );
          },
        ),
      );
}
