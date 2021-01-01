import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:tokolink/infrastructure/constants/styles.dart';
import 'package:tokolink/model/product.dart';
import 'package:tokolink/presentation/screens/widgets/label_widget.dart';
import 'package:tokolink/presentation/screens/widgets/single_product_grid.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  final String idCat;
  final String name;

  const ProductScreen({Key key, @required this.idCat, @required this.name}) : super(key: key);
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with HasSizeMixin {
  bool _loading = false;
  var _product;
  List<dynamic> _subCategory;
  @override
  void initState() {
    getSubCategory();
    getProduct();
    super.initState();
  }
  void getProduct() async {
    setState(() {
      _loading = true;
    });
    final response = await http.get(GlobalConstant.BASE_URL+'/product/cat/'+widget.idCat);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _loading = false;
        _product = data['data'];
      });
    }else{
      setState(() {
        _loading = false;
      });
    }
  }
  void getSubCategory() async {
    final response = await http.get(GlobalConstant.BASE_URL+'/category/index/'+widget.idCat);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _subCategory = data['data']['child'];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: 
          
          (_loading) ?
            Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey.shade200,
              child: GridView(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1 / 1.6, crossAxisSpacing: 20, mainAxisSpacing: 20),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  SingleProductGrid(price: '0'),
                  SingleProductGrid(price: '0'),
                  SingleProductGrid(price: '0'),
                  SingleProductGrid(price: '0'),
                  SingleProductGrid(price: '0'),
                  SingleProductGrid(price: '0'),
                  SingleProductGrid(price: '0'),
                  SingleProductGrid(price: '0'),
                ],
              ),
            )
          : (_product != null) ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  for ( var i in _subCategory ) _cate(i) 
                ]
              ),
              SizedBox(height: 20),
              GridView(
                padding: EdgeInsets.only(bottom:30),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1 / 1.8, crossAxisSpacing: 20, mainAxisSpacing: 20),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children:  List.generate(
                _product.length,
                (index) =>
                  SingleProductGrid(
                    name: _product[index]['name'],
                    image: NetworkImage(_product[index]['images'][0]),
                    price: _product[index]['price'],
                    product: Product.fromJson(_product[index]) ,
                  )
                ),
              ),
            ]
          ) : 
          Padding(
            padding: EdgeInsets.only(top:150,left:20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, //Center Column contents vertically,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/img/empty.svg'),
                Text('No data available')
              ]
            ) 
            ),
        ),
      )
    );
  }


  _cate(cat){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorConfig.PRIMARY)
      ),
      padding: EdgeInsets.only(top:10,bottom:10, right: 10, left: 10),
      margin: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(name: cat['name'] ,idCat : cat['id_category'] )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              cat['name'],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
