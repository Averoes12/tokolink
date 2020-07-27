import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/presentation/credential/sign_up_screen.dart';

import 'file:///C:/Users/wandy/Documents/Code/projects/faqih/tokolink/lib/presentation/onboarding/widgets/indicator_widget.dart';

import 'widgets/single_page_onboard.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController(initialPage: 0);
  int _currentPos;

  @override
  void initState() {
    _currentPos = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    image: Image.asset('assets/img/1.png'),
                  ),
                  SinglePageOnBoard(
                    type: 2,
                    title: 'Fast shipping',
                    description: 'Fast delivery is now simple and fast. Orders will be shipped quickly to you.',
                    image: Image.asset('assets/img/2.png'),
                  ),
                  SinglePageOnBoard(
                    type: 3,
                    title: 'Reflect and evaluate',
                    description: 'The enthusiasm to contribute ideas for customers, helping the service more and more developed.',
                    image: Image.asset('assets/img/3.png'),
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
                  SizedBox(height: 100),
                  RaisedButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen())),
                    textColor: Colors.white,
                    child: Text('Get Started'),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
