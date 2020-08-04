import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/styles.dart';
import 'package:tokolink/presentation/widgets/size_config.dart';

class SingleProductGrid extends StatelessWidget {
  final String name;
  final String size;
  final String price;
  final String id;
  final ImageProvider image;

  const SingleProductGrid({
    Key key,
    this.name = 'Produk Single',
    this.size = '100g',
    this.price = '10K',
    this.id,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeConfig = SizeConfig.of(context);
    return Container(
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
                if (image == null) return SvgPicture.asset('assets/img/mangga.svg', fit: BoxFit.fitWidth);
                return Image(image: image, fit: BoxFit.fitWidth);
              }),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(name, style: TextStyle(fontSize: sizeConfig.safeBlockHorizontal * 4, fontWeight: FontWeight.bold)),
                    Text(price, style: TextStyle(fontSize: sizeConfig.safeBlockHorizontal * 4, fontWeight: FontWeight.bold, color: ColorConfig.PRIMARY)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(size, style: TextStyle(fontSize: sizeConfig.safeBlockHorizontal * 3, fontWeight: FontWeight.bold, color: ColorConfig.N4)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
