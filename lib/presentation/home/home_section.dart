import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/presentation/home/widgets/banner_widget.dart';
import 'package:tokolink/presentation/home/widgets/category_widget.dart';
import 'package:tokolink/presentation/home/widgets/search_and_notification_widget.dart';
import 'package:tokolink/presentation/widgets/label_widget.dart';
import 'package:tokolink/presentation/widgets/size_config.dart';

import 'widgets/recent_product_widget.dart';

class HomeSection extends StatefulWidget {
  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  @override
  Widget build(BuildContext context) {
    final size = SizeConfig.of(context);

    return Container(
      margin: EdgeInsets.only(top: size.blockSizeVertical * 5),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SearchAndNotificationWidget(),
            SizedBox(height: 20),
            BannerWidget(),
            SizedBox(height: 20),
            CategoryWidget(),
            SizedBox(height: 20),
            LabelWidget(text: 'Produk Terbaru', bigger: true),
            SizedBox(height: 10),
            RecentProductWidget(),
          ],
        ),
      ),
    );
  }
}
