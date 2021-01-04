import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:http/http.dart' as http;
import 'package:tokolink/model/transaction.dart';
import 'package:tokolink/presentation/screens/order/widgets/single_order_card_widget.dart';
class OrderStoreScreen extends StatefulWidget {
  final int id;
  final String title;

  const OrderStoreScreen({
    Key key,
    this.id,
    this.title,
  }) : super(key: key);

  @override
  _OrderStoreScreenState createState() => _OrderStoreScreenState();
}

class _OrderStoreScreenState extends State<OrderStoreScreen> {
  String data;
  SharedPreferences prefs;
  Map<String, String> headers;
  List<Transaction> listTransaction = [];
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _getTransaction();
  }
  void  _getTransaction() async{
    setState(() {
      loading = true;
    });
    prefs = await SharedPreferences.getInstance();
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': prefs.getString('storeToken'),
    };
    var response = await http.get(GlobalConstant.BASE_URL+'/transaction/store', headers: headers);
    final data = jsonDecode(response.body);
    print(data);
    loading = false;
    if (response.statusCode != 200) {
      throw Exception(
          'Request failed with status ${response.statusCode}: ${response.body}');
    }else{
      setState(() {
        for (Map i in data['data']) {
          listTransaction.add(Transaction.fromJson(i));
        }

      });
      
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Pesanan'),
        centerTitle: true,
      ),
      body: (loading) ? Center(child:CircularProgressIndicator() ) : Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: listTransaction.length,
                itemBuilder: (context, i) {
                  return SingleOrderCardWidget(data:listTransaction[i], merchant: true,);
                }
              )
            ],
          )
        ),
      ),
    );
  }
}
