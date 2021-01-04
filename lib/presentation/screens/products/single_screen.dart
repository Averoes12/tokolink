import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/model/cart.dart';
import 'package:tokolink/model/product.dart';
import 'package:tokolink/presentation/screens/checkout/checkout_screen.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';
import 'package:intl/intl.dart';
import 'package:tokolink/presentation/screens/widgets/dashed_divider.dart';

class SingleScreen extends StatefulWidget {
  final Product product;
  const SingleScreen({Key key,this.product}) : super(key: key);
  @override
  _SingleScreenState createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> with HasSizeMixin {
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  final bool _loading = false;
  //var _product;
  //List<dynamic> _subCategory;
  int qty = 1;
  int subtotal = 0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final cart = Cart();
  @override
  void initState() {
    setState(() {
      subtotal = qty * int.parse(widget.product.price);
      Cart().remove();
    });
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Detail Product'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
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
                  
                ],
              ),
            )
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(height: 300),
                items: widget.product.images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white
                        ),
                        child: CachedNetworkImage(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          imageUrl: i,
                          progressIndicatorBuilder: (context, url, downloadProgress) => 
                                  CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        )
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                padding: EdgeInsets.only(left:20,right:20, top: 30),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15.0,
                          offset: Offset(0.0, 0.75)
                      )
                    ],
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.product.name ,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold
                    )),
                    SizedBox(height: 10),
                    Text(formatCurrency.format(int.parse(widget.product.price)),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorConfig.PRIMARY)),
                    SizedBox(height: 20),
                    DashedDivider(),
                    SizedBox(height: 30),
                    Text(
                      'Description',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold
                    )),
                    SizedBox(height: 10),
                    Html(
                      data: widget.product.description,
                      style: {
                          'p': Style(
                            color: Colors.grey[700]
                          ),
                        }
                    ),
                    SizedBox(height: 20),
                  ]
                ),
              )
            ]
          )
        ),
      ),
      bottomNavigationBar: Stack(
          children: [
            Container(
              height: 120.0,
              padding: EdgeInsets.only(left:20, right:20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if(qty > 1){
                                qty -= 1;
                                subtotal = qty * int.parse(widget.product.price);
                              }
                            });
                          },
                          child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/img/minus.svg',
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          qty.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              qty += 1;
                              subtotal = qty * int.parse(widget.product.price);
                            });
                          },
                          child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/img/plus.svg',
                                ),
                              )),
                        ),
                        
                      ],
                    ),
                    Text(formatCurrency.format(subtotal),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorConfig.PRIMARY))
                  ]),
                  SizedBox(height: 10),
                  RaisedButton(
                    onPressed: () => {
                      addToCart()
                    },
                    textColor: Colors.white,
                    child: Text('Belanja Sekarang'),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
    );
  }

  void addToCart(){
    int ind;
    ind = Cart().cart.cartItem.indexWhere((element) => element.productId == widget.product.idProduct);
    print(qty);
    if(ind != -1){
      Cart().addToCart(widget.product, Cart().cart.cartItem[ind].quantity + qty);
    }else{
      final snackBar = SnackBar(content: Text('Product has been added to cart'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Cart().addToCart(widget.product, qty);
    }
    
    final snackBar = SnackBar(content: Text('Product has been added to cart'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckoutSection() ));
  }
}
