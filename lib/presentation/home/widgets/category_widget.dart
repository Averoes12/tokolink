import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/styles.dart';

class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categoryList(),
        ),
      ),
    );
  }

  List<Widget> categoryList() => List.generate(
        10,
        (index) => SingleCategoryWidget(
          image: Image.network('https://placehold.it/30'),
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
    this.backgroundColor: ColorConfig.PRIMARY,
    this.label: 'Category',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: backgroundColor,
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
