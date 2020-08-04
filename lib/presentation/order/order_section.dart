import 'package:flutter/material.dart';
import 'package:tokolink/presentation/widgets/size_config.dart';

import 'widgets/single_order_card_widget.dart';

class OrderSection extends StatefulWidget {
  @override
  _OrderSectionState createState() => _OrderSectionState();
}

class _OrderSectionState extends State<OrderSection> {
  @override
  Widget build(BuildContext context) {
    final size = SizeConfig.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: size.blockSizeVertical * 6),
          Text('Order', textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
          SizedBox(height: size.blockSizeVertical * 2),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: <Widget>[
                  SingleOrderCardWidget(goods: ['Oranges (10kg)', 'Cabbage (1kg), Beef (2ons), Chicken (1kg)']),
                  SingleOrderCardWidget(goods: ['Oranges (10kg)', 'Cabbage (1kg), Beef (2ons), Chicken (1kg)']),
                  SingleOrderCardWidget(goods: ['Oranges (10kg)', 'Cabbage (1kg), Beef (2ons), Chicken (1kg)']),
                  SingleOrderCardWidget(goods: ['Oranges (10kg)', 'Cabbage (1kg), Beef (2ons), Chicken (1kg)']),
                  SingleOrderCardWidget(goods: ['Oranges (10kg)', 'Cabbage (1kg), Beef (2ons), Chicken (1kg)']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
