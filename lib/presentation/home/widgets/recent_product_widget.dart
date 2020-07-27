import 'package:flutter/material.dart';
import 'package:tokolink/presentation/widgets/single_product_grid.dart';

class RecentProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1 / 1.6, crossAxisSpacing: 20, mainAxisSpacing: 20),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          SingleProductGrid(),
          SingleProductGrid(),
          SingleProductGrid(),
          SingleProductGrid(),
          SingleProductGrid(),
          SingleProductGrid(),
          SingleProductGrid(),
          SingleProductGrid(),
        ],
      ),
    );
  }
}
