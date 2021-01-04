import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:http/http.dart' as http;
import 'package:tokolink/model/product.dart';
import 'package:tokolink/presentation/screens/widgets/dashed_divider.dart';
class ManageProductScreen extends StatefulWidget {
  final int id;
  final String title;

  const ManageProductScreen({
    Key key,
    this.id,
    this.title,
  }) : super(key: key);

  @override
  _ManageProductScreenState createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  String data;
  final List<Product> _product  = [];
  bool loading = false;
  SharedPreferences prefs;
  Map<String, String> headers;
  @override
  void initState() {
    super.initState();
    _getData();
  }
  void  _getData() async{
    setState(() {
      loading = true;
    });
    prefs = await SharedPreferences.getInstance();
    headers = {
      'Accept': 'application/json',
      'Authorization': prefs.getString('storeToken'),
    };
    var response = await http.get(GlobalConstant.BASE_URL+'/product/store/', headers: headers);
    final data = jsonDecode(response.body);
    setState(() {
      loading = false;
      for (Map i in data['data']) {
        _product.add(Product.fromJson(i));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Product'),
        centerTitle: true,
      ),
      body: (loading) ? Center(child:CircularProgressIndicator() ) : Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _product.length,
                      itemBuilder: (context, i) {
                        return singelProduct(_product[i]);
                      }
                    )
                  ]
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget singelProduct(Product product){
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          leading: CachedNetworkImage(
              imageUrl: product.images[0],
              height: 70,
              width: 70,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]),
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) => 
                      CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          title: Text(
            product.name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top:10),
            child: Text(formatCurrency.format(int.parse(product.price)), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorConfig.PRIMARY))),
          onTap: null,
        ),
        DashedDivider(),
      ],
    );
  }
}
