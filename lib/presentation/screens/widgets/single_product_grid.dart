import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/styles.dart';
import 'package:tokolink/model/product.dart';
import 'package:tokolink/presentation/screens/products/single_screen.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';
import 'package:intl/intl.dart';
class SingleProductGrid extends StatefulWidget {
  final String name;
  final String size;
  final String price;
  final String id;
  final ImageProvider image;
  final Product product;
  
  const SingleProductGrid({
    Key key,
    this.name = 'Produk Single',
    this.size = '100g',
    this.price = '10K',
    this.id,
    this.image,
    this.product,
  }) : super(key: key);

  @override
  _SingleProductGridState createState() => _SingleProductGridState();
}

class _SingleProductGridState extends State<SingleProductGrid> with HasSizeMixin {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SingleScreen(product: widget.product) ));
      },
      child: Container(
        child: Card(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: RaisedButton(
                      color: ColorConfig.RED,
                      textColor: ColorConfig.PRIMARY,
                      shape: RoundedRectangleBorder(
                        borderRadius: StyleConfig.mainBoxBorder,
                      ),
                      onPressed: () {},
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  if (widget.image == null) return Image.network('https://placehold.it/300', fit: BoxFit.fitWidth);
                  return Image(image: widget.image, fit: BoxFit.fitWidth);
                }),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(child: Text(widget.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(formatCurrency.format(int.parse(widget.price)), style: TextStyle(fontSize: appSize.safeBlockHorizontal * 3, fontWeight: FontWeight.bold, color: ColorConfig.PRIMARY)),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
