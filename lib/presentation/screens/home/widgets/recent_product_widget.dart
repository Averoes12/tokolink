import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokolink/application/product/product_bloc.dart';
import 'package:tokolink/presentation/screens/widgets/single_product_grid.dart';

class RecentProductWidget extends StatefulWidget {
  @override
  _RecentProductWidgetState createState() => _RecentProductWidgetState();
}

class _RecentProductWidgetState extends State<RecentProductWidget> {
  final _bloc = ProductBloc();

  @override
  void initState() {
    _bloc.add(GetProduct());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder(
        cubit: _bloc,
        builder: (context, state) {
          if (state is ProductLoaded) {
            return GridView(
              padding: EdgeInsets.only(bottom:30),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1 / 1.8, crossAxisSpacing: 20, mainAxisSpacing: 20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: state.products
                  .map<Widget>(
                    (e) => SingleProductGrid(
                      name: e.name,
                      image: NetworkImage(e.images.first),
                      price: e.price,
                      product: e,
                    ),
                  )
                  .toList(),
            );
          }
          return Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.grey.shade200,
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
        },
      ),
    );
  }
}
