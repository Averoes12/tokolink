import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/presentation/screens/credential/login_screen.dart';
import 'package:tokolink/presentation/screens/credential/sign_up_screen.dart';
import 'package:tokolink/presentation/screens/main_screen.dart';

import 'widgets/indicator_widget.dart';
import 'widgets/single_page_onboard.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController(initialPage: 0);
  int _currentPos;
  SharedPreferences prefs ;

  @override
  void initState() {
    _currentPos = 0;
    super.initState();
  }
  void _goHome() async{
    prefs = await SharedPreferences.getInstance();
    if(prefs.getString('token') != null){
      await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    _goHome();
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (pos) => setState(() => _currentPos = pos),
                children: <Widget>[
                  SinglePageOnBoard(
                    title: 'Order fast',
                    description: 'Choosing fresh and delicious food right at home, simply select and order.',
                    image: SvgPicture.asset('assets/img/1.svg'),
                  ),
                  SinglePageOnBoard(
                    type: 2,
                    title: 'Fast shipping',
                    description: 'Fast delivery is now simple and fast. Orders will be shipped quickly to you.',
                    image: SvgPicture.asset('assets/img/2.svg'),
                  ),
                  SinglePageOnBoard(
                    type: 3,
                    title: 'Reflect and evaluate',
                    description: 'The enthusiasm to contribute ideas for customers, helping the service more and more developed.',
                    image: SvgPicture.asset('assets/img/3.svg'),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  IndicatorWidget(length: 3, activeIndex: _currentPos),
                  SizedBox(height: 80),
                  RaisedButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen())),
                    textColor: Colors.white,
                    child: Text('LOGIN'),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen())),
                    textColor: Colors.white,
                    child: Text('DAFTAR'),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
