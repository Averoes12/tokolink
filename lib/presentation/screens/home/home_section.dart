import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/localization/localization_const.dart';
import 'package:tokolink/presentation/screens/widgets/label_widget.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';

import 'widgets/banner_widget.dart';
import 'widgets/category_widget.dart';
import 'widgets/recent_product_widget.dart';
import 'widgets/search_and_notification_widget.dart';

class HomeSection extends StatefulWidget {
  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> with HasSizeMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: appSize.blockSizeVertical * 5),
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
            LabelWidget(text: getTranslated(context, 'latest_product'), bigger: true),
            SizedBox(height: 10),
            RecentProductWidget(),
          ],
        ),
      ),
    );
  }
}
