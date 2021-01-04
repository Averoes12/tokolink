import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:tokolink/model/address.dart';
import 'package:tokolink/model/bank.dart';
import 'package:tokolink/model/shipping.dart';
import 'package:tokolink/model/transaction.dart';
import 'package:tokolink/presentation/screens/checkout/payment_screen.dart';
import 'package:tokolink/presentation/screens/widgets/dashed_divider.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';
import 'package:http/http.dart' as http;

class OrderDetailSection extends StatefulWidget {
  final Transaction transaction;

  const OrderDetailSection({
    Key key,
    this.transaction,
  }) : super(key: key);
  @override
  _OrderDetailSectionState createState() => _OrderDetailSectionState();
}

class _OrderDetailSectionState extends State<OrderDetailSection> with HasSizeMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var cart;
  int total = 0;
  int items;
  Address defaultAddress;
  int selectedIndex = 0;
  List<Shipping> shippings = [];
  List<Bank> banks = [];
  Bank selectedBank;
  int bankIndex = 0;
  List<Shipping> tmp = [];
  Shipping selectedShipping;
  Map<String, String> headers;
  Transaction transaction;
  List<DetailTransaction> detail = [];
  DetailTransaction dt;
  SharedPreferences prefs;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  DateFormat formatter;
  String formatted;
  var invoice;
  bool loading = false;
  @override
  void initState() {
    super.initState();
  }
  
  void getInvoice() async{
    setState(() {
      loading = true;
    });
    prefs = await SharedPreferences.getInstance();
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': prefs.getString('token'),
    };
    var response = await http.get(GlobalConstant.BASE_URL+'/transaction/invoice/'+widget.transaction.invoice, headers: headers);
    final data = jsonDecode(response.body);

    setState(() {
      loading = false;
      invoice = data['data'];
      var bank = <String, dynamic>{};
      bank['code'] = widget.transaction.payment;
      bank['name'] = widget.transaction.payment;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PaymentSection(fromorder: true, data: data['data'], bank: Bank.fromJson(bank))));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Order Detail'),
        centerTitle: true,
      ),
      body:  Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    status(),
                    SizedBox(height: 20),
                    cartWidget(),
                    SizedBox(height: 20),
                    address(),
                    SizedBox(height: 20),
                    payment(),
                    SizedBox(height: 20),
                    (widget.transaction.status == 'Menunggu pembayaran') ? RaisedButton(
                    onPressed: () {
                      getInvoice();
                    },
                    textColor: Colors.white,
                    child: (loading) ? Text('Loading...') : Text('Selesaikan Pembayaran'),
                  ) : Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
  Widget cartWidget(){
    return Container(
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
                Row(children: [
                  Image.asset('assets/icons/home.png'),
                  SizedBox(width: 10),
                  Text(
                    'Tokolink',
                    style: TextStyle(color: ColorConfig.PRIMARY),
                  )
                ]),
                SizedBox(height: 10),
                DashedDivider(),
                SizedBox(height: 10),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: widget.transaction.detail.length,
            itemBuilder: (context, i) {
              return Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(0.0, 2.0), //(x,y)
                      //blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.transaction.detail[i].product, style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Row(
                        children: <Widget>[
                          Text('Qty : ', style: TextStyle(color: Colors.grey)),
                          Text(
                            widget.transaction.detail[i].qty.toString(),
                            style: TextStyle(color:  ColorConfig.PRIMARY ),
                          ),
                        ],
                      ),
                      Text(formatCurrency.format( int.parse(widget.transaction.detail[i].price) ), style: TextStyle(color: Colors.grey)),
                    ]),
                  ],
                ),
              );
            }
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
                padding: EdgeInsets.only(left: 20, right: 20),
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
                        Text('Sub Total:'),
                        Text(
                          formatCurrency.format( int.parse(widget.transaction.subtotal) ),
                          style: TextStyle(
                            color: ColorConfig.PRIMARY,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Ongkos kirim:'),
                        Text(
                          formatCurrency.format( int.parse(widget.transaction.shipping) ),
                          style: TextStyle(
                            color: ColorConfig.PRIMARY,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total:'),
                        Text(
                          formatCurrency.format( int.parse(widget.transaction.total) ),
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
  Widget status(){
    formatter = DateFormat('E, d MMM y H:m');
    formatted = formatter.format(DateTime.parse(widget.transaction.createdAt));
    return  GestureDetector(
      onTap: () async{
      },
      child:Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                Image.asset('assets/icons/order.png'),
                SizedBox(width: 10),
                Text('Detail Pesanan', style: TextStyle(fontWeight: FontWeight.bold))
              ]),
              SizedBox(height: 10),
              DashedDivider(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Status Pesanan'),
                SizedBox(width: 10),
                Text(widget.transaction.status, style: TextStyle(fontWeight: FontWeight.bold, color: ColorConfig.PRIMARY))
              ]),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Tanggal pembelian'),
                SizedBox(width: 10),
                Text(formatted, style: TextStyle(fontWeight: FontWeight.bold))
              ])
            ]
          )
        ),
      )
    );
  }
  Widget address(){
    return  GestureDetector(
      onTap: () async{
      },
      child:Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                Image.asset('assets/icons/address.png'),
                SizedBox(width: 10),
                Text('Alamat Pengiriman', style: TextStyle(fontWeight: FontWeight.bold))
              ]),
              SizedBox(height: 10),
              DashedDivider(),
              SizedBox(height: 10),
              Row(children: [
                Text(widget.transaction.address.name, style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
              SizedBox(height: 5),
              Text(widget.transaction.address.phone),
              SizedBox(height: 5),
              Text(widget.transaction.address.address, style: TextStyle(color: Colors.grey)),
            ]
          )
        ),
      )
    );
  }

  Widget payment(){
    return  GestureDetector(
      onTap: () async{
          
      },
      child:Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                Image.asset('assets/icons/payment.png'),
                SizedBox(width: 10),
                Text('Pembayaran', style: TextStyle(fontWeight: FontWeight.bold))
              ]),
              SizedBox(height: 10),
              DashedDivider(),
              SizedBox(height: 20),
              Row(children: [
                Image.asset('assets/img/'+ widget.transaction.payment.toLowerCase() +'.png', height: 20),
                SizedBox(width: 10),
                Text(widget.transaction.payment, style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
            ]
          )
        ),
      )
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