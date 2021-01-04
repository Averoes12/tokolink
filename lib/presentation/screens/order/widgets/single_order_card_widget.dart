import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/model/transaction.dart';
import 'package:tokolink/presentation/screens/order/order_detail.dart';
import 'package:tokolink/presentation/screens/widgets/dashed_divider.dart';

class SingleOrderCardWidget extends StatelessWidget {
  final bool merchant;
  final String orderId;
  final String dateTime;
  final String status;
  final Transaction data;
  final int total;
  
  const SingleOrderCardWidget({
    Key key,
    this.merchant = false,
    this.orderId = '123412343',
    this.dateTime = '10/04/2020 - 10:20',
    this.status = 'Ordered',
    @required this.data,
    this.total = 100000,
  }) : super(key: key);

  void updateStatus(status,id){
    
  }
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
    DateFormat formatter = DateFormat('E, d MMM y H:m');
    String formatted = formatter.format(DateTime.parse(data.createdAt));
    var detail = [];
    for (var item in data.detail) {
      detail.add(item.product);
    }
    return  GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailSection(transaction: data)));
      },
      child:Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
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
                    data.store,
                    style: TextStyle(color: ColorConfig.PRIMARY),
                  ),
                  SizedBox(height: 10),
                  DashedDivider(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Order #'+data.idTransaction, style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(formatted, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text('Status : ', style: TextStyle(color: Colors.grey)),
                      Text(
                        data.status,
                        style: TextStyle(color: status == 'Ordered' ? ColorConfig.PRIMARY : ColorConfig.N2),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(detail.join(', ')),
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
                            formatCurrency.format( int.parse(data.total)),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: ColorConfig.PRIMARY,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      (merchant) ? confirmation() : Container(),
                      SizedBox(height: 10)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
  Widget confirmation(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlineButton(
          child: Text('Tolak Pesanan', style: TextStyle(fontSize: 12,color: ColorConfig.PRIMARY)),
          onPressed: (){
              // FlutterClipboard.copy(widget.data['amount'].toString()).then(( value ) async {
              //   final snackBar = SnackBar(content: Text('Jumlah pembayaran berhasil disalin'));
              //   _scaffoldKey.currentState.showSnackBar(snackBar);
              // });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: EdgeInsets.only(left:10,right:10),
          borderSide: BorderSide(color:ColorConfig.PRIMARY, style: BorderStyle.solid,width: 1),
        ),
        SizedBox(width: 10),
        OutlineButton(
          child: Text('Terima Pesanan', style: TextStyle(fontSize: 12,color: ColorConfig.PRIMARY)),
          onPressed: (){
              // FlutterClipboard.copy(widget.data['amount'].toString()).then(( value ) async {
              //   final snackBar = SnackBar(content: Text('Jumlah pembayaran berhasil disalin'));
              //   _scaffoldKey.currentState.showSnackBar(snackBar);
              // });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: EdgeInsets.only(left:10,right:10),
          borderSide: BorderSide(color:ColorConfig.PRIMARY, style: BorderStyle.solid,width: 1),
        )
      ],
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
