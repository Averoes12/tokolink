import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:tokolink/localization/localization_const.dart';
import 'package:tokolink/model/bank.dart';
import 'package:tokolink/presentation/screens/main_screen.dart';
import 'package:tokolink/presentation/screens/widgets/dashed_divider.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';
import 'package:http/http.dart' as http;

class PaymentSection extends StatefulWidget {

  final data;
  final Bank bank;
  final bool fromorder;
  const PaymentSection({
    Key key,
    this.data,
    this.bank,
    this.fromorder,
  }) : super(key: key);
  @override
  _PaymentSectionState createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> with HasSizeMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final formatCurrency =  NumberFormat.simpleCurrency(locale: 'id_ID');
  DateFormat formatter;
  String formatted;
  var instructions;
  @override
  void initState() {
    super.initState();
    _getBank(widget.bank.code);
  }
  void  _getBank(code) async{
    var response = await http.get(GlobalConstant.BASE_URL+'/transaction/instruction/'+code);
    final data = jsonDecode(response.body);
    print(data);
    if (response.statusCode != 200) {
      throw Exception(
          'Request failed with status ${response.statusCode}: ${response.body}');
    }else{
      setState(() {
        instructions = data['data'];
      });
      
    }
  }
  Future<bool> _onWillPop() async {
    if(widget.fromorder != null){
      print('back');
      Navigator.of(context).pop(true);
      return true;
    }else{
      print('pop');
      return Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _onWillPop(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(getTranslated(context, 'order_payment')),
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
                      cartWidget(),
                      (instructions != null) ? instruction() : Container()
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
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
                SizedBox(height: 30),
                payment(),
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
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Text('${getTranslated(context, 'payment_amount')} :'),
                        SizedBox(height: 10),
                        Text(formatCurrency.format( widget.data['amount'] ),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: ColorConfig.PRIMARY)),
                        SizedBox(height: 10),
                        OutlineButton(
                          child: Text(getTranslated(context, 'copy_amount'), style: TextStyle(fontSize: 12,color: ColorConfig.PRIMARY)),
                          onPressed: (){
                              FlutterClipboard.copy(widget.data['amount'].toString()).then(( value ) async {
                                final snackBar = SnackBar(content: Text(getTranslated(context, 'copy_amt_success')));
                                _scaffoldKey.currentState.showSnackBar(snackBar);
                              });
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          padding: EdgeInsets.only(left:10,right:10),
                          borderSide: BorderSide(color:ColorConfig.PRIMARY, style: BorderStyle.solid,width: 1),
                        ),
                        SizedBox(height: 20),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget payment(){
    formatter = DateFormat('E, d MMM y H:m');
    formatted = formatter.format(DateTime.parse(widget.data['expiry_date']));
    var ind = widget.data['available_banks'].indexWhere((element) => element['bank_code'] == widget.bank.code);
    print(ind);
    return Column(
      children: [
        Text('${getTranslated(context, 'payment_before')}:'),
        SizedBox(height: 10),
        Text(formatted,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 25),
        Text('${getTranslated(context, 'va_number')} :'),
        SizedBox(height: 10),
        Image.asset('assets/img/'+ widget.bank.code.toLowerCase() +'.png', height: 30),
        SizedBox(height: 10),
        Text(widget.data['available_banks'][ind]['bank_account_number'],style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 10),
        OutlineButton(
          child: Text(getTranslated(context, 'copy_account_number'), style: TextStyle(fontSize: 12,color: ColorConfig.PRIMARY)),
          onPressed: (){
              FlutterClipboard.copy(widget.data['available_banks'][ind]['bank_account_number'].toString()).then(( value ) async {
                final snackBar = SnackBar(content: Text(getTranslated(context, 'copy_acc_number_success')));
                _scaffoldKey.currentState.showSnackBar(snackBar);
              });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: EdgeInsets.only(left:10,right:10),
          borderSide: BorderSide(color:ColorConfig.PRIMARY, style: BorderStyle.solid,width: 1),
        ),
      ],
    );
  }
  Widget instruction(){
    return  GestureDetector(
      onTap: (){
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
                Text(getTranslated(context, 'payment_method'), style: TextStyle(fontWeight: FontWeight.bold))
              ]),
              SizedBox(height: 10),
              DashedDivider(),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: instructions.length,
                itemBuilder: (context, i) {
                  return ExpandablePanel(
                    header: Container(
                        padding: EdgeInsets.only(top:15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(instructions[i]['name'] +' '+ instructions[i]['code']),
                            SizedBox(height: 10),
                            DashedDivider()
                          ],  
                        ),
                    ),
                    expanded: Container(
                      child: Html(
                        data: instructions[i]['text'],
                        style: {
                            'div': Style(
                              color: Colors.grey[700],
                              lineHeight: 2
                            ),
                          }
                      ),
                      padding: EdgeInsets.only(top:10,left:10,bottom:10),
                    ),
                    tapHeaderToExpand: true,
                  );
                }
              )
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