import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:tokolink/model/transaction.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';
import 'package:http/http.dart' as http;
import 'widgets/single_order_card_widget.dart';

class OrderSection extends StatefulWidget {
  @override
  _OrderSectionState createState() => _OrderSectionState();
}
class _OrderSectionState extends State<OrderSection> with HasSizeMixin {
  SharedPreferences prefs;
  Map<String, String> headers;
  List<Transaction> listTransaction = [];
  bool loading = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
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
      'Authorization': prefs.getString('token'),
    };
    var response = await http.get(GlobalConstant.BASE_URL+'/transaction', headers: headers);
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

  void _onRefresh() async{
    // monitor network fetch
    await _getTransaction();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return (loading) ? Center(child:CircularProgressIndicator() ):
    SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child:Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: appSize.blockSizeVertical * 6),
            Text('Order', textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
            SizedBox(height: 0),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: listTransaction.length,
                      itemBuilder: (context, i) {
                        return SingleOrderCardWidget(data:listTransaction[i]);
                      }
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
