import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/presentation/screens/widgets/dashed_divider.dart';

class SingleOrderCardWidget extends StatelessWidget {
  final String merchant;
  final String orderId;
  final String dateTime;
  final String status;
  final List<String> goods;
  final int total;

  const SingleOrderCardWidget({
    Key key,
    this.merchant = 'Merchant',
    this.orderId = '123412343',
    this.dateTime = '10/04/2020 - 10:20',
    this.status = 'Ordered',
    @required this.goods,
    this.total = 100000,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(0.0, 2.0), //(x,y)
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  merchant,
                  style: TextStyle(color: ColorConfig.PRIMARY),
                ),
                SizedBox(height: 10),
                DashedDivider(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Order #$orderId', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(dateTime, style: TextStyle(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text('Status : ', style: TextStyle(color: Colors.grey)),
                    Text(
                      status,
                      style: TextStyle(color: status == 'Ordered' ? ColorConfig.PRIMARY : ColorConfig.N2),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(goods.join(', ')),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  offset: Offset(0.0, 10.0), //(x,y)
                  blurRadius: 9.0,
                ),
              ],
            ),
            child: ClipPath(
              clipper: TicketClipPath(),
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 14),
                    DashedDivider(),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total:'),
                        Text(
                          total.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ColorConfig.PRIMARY,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        ],
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
