import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/localization/localization_const.dart';

import 'account/account_section.dart';
import 'home/home_section.dart';
import 'news/news_section.dart';
import 'order/order_section.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Global keys
  final _sk = GlobalKey<ScaffoldState>();

  // States
  bool keyboardOpen = false;
  int navPosition = NavigationPos.HOME.index;
  SharedPreferences prefs;
  bool isStore = false;

  @override
  void initState() {
    super.initState();
    keyboardVisibilityListener();
    _goHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sk,
      floatingActionButton: buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        currentIndex: navPosition,
        backgroundColor: ColorConfig.N1,
        type: BottomNavigationBarType.fixed,
        onTap: (pos) => setState(() => navPosition = pos),
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/home_1.svg'), activeIcon: SvgPicture.asset('assets/icons/home.svg'), label: getTranslated(context, 'home')),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/news_1.svg'), activeIcon: SvgPicture.asset('assets/icons/news.svg'), label: getTranslated(context, 'news')),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/order_1.svg'), activeIcon: SvgPicture.asset('assets/icons/order.svg'), label: getTranslated(context, 'order')),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/account_1.svg'), activeIcon: SvgPicture.asset('assets/icons/account.svg'), label: getTranslated(context, 'account')),
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildFAB() {
    if (!isStore) return SizedBox();
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: ColorConfig.N1,
      onPressed: () {},
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorConfig.PRIMARY,
        ),
        child: Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
  void _goHome() async{
    prefs = await SharedPreferences.getInstance();
    if(prefs.getString('storeToken') != null){
      setState(() {
        isStore = true;
      });
    }
  }
  void keyboardVisibilityListener() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() => keyboardOpen = visible);
      },
    );
  }

  Widget buildBody() {
    return IndexedStack(
      index: navPosition,
      children: <Widget>[
        HomeSection(),
        NewsSection(),
        OrderSection(),
        AccountSection(),
      ],
    );
  }
}

enum NavigationPos {
  HOME,
  NEWS,
  ORDER,
  ACCOUNT,
}
