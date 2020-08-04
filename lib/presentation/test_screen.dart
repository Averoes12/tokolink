import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:tokolink/presentation/order/widgets/single_order_card_widget.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool keyboardOpen = false;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print(visible);
        setState(() => keyboardOpen = visible);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: SingleOrderCardWidget(
          goods: ['Oranges (10kg)', 'Cabbage (1kg), Beef (2ons), Chicken (1kg)'],
        ),
      ),
    );
  }
}

class TicketClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final radius = 10.0;
    final path = Path();
    path.arcToPoint(Offset(0, 30), radius: Radius.circular(radius));
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 30);
    path.arcToPoint(Offset(size.width, 0), radius: Radius.circular(radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}