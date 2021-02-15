import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokolink/application/category/category_bloc.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/styles.dart';
import 'package:tokolink/localization/localization_const.dart';
import 'package:tokolink/presentation/screens/products/product_screen.dart';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final _bloc = CategoryBloc();

  @override
  void initState() {
    _bloc.add(GetCategory());
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder(
          cubit: _bloc,
          builder: (context, state) {
            if (state is CategoryLoaded) {
              return Row(
                children: state.payload
                    .map<Widget>(
                      (e) => SingleCategoryWidget(
                        // image: Image.network(
                        //   e.image,
                        //   fit: BoxFit.fill,
                        // ),
                        image: CachedNetworkImage(
                            imageUrl: e.image,
                            progressIndicatorBuilder: (context, url, downloadProgress) => 
                                    CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(name: e.name ,idCat : e.idCategory )));
                        },
                        label: translateCategory(context, e.name),
                      ),
                    )
                    .toList(),
              );
            }
            return Shimmer.fromColors(
              child: Row(
                children: categoryListLoading(),
              ),
              baseColor: Colors.grey,
              highlightColor: Colors.grey.shade200,
            );
          },
        ),
      ),
    );
  }

  List<Widget> categoryListLoading() => List.generate(
        10,
        (index) => SingleCategoryWidget(
          image: Container(),
          onTap: () {},
        ),
      ).toList();
}

class SingleCategoryWidget extends StatelessWidget {
  final Widget image;
  final VoidCallback onTap;
  final Color backgroundColor;
  final String label;

  const SingleCategoryWidget({
    Key key,
    @required this.image,
    @required this.onTap,
    this.backgroundColor = ColorConfig.PRIMARY,
    this.label = 'Category',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: image is Container ? backgroundColor : Colors.transparent,
                borderRadius: StyleConfig.mainBoxBorder,
              ),
              child: Center(
                child: image,
              ),
            ),
            SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
