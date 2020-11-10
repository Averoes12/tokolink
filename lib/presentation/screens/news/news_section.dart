import 'package:flutter/material.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';

import 'widgets/single_news_list.dart';

class NewsSection extends StatefulWidget {
  @override
  _NewsSectionState createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> with HasSizeMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: appSize.blockSizeVertical * 6),
          Text('News', textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
          SizedBox(height: appSize.blockSizeVertical * 2),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  SingleNewsList(),
                  SingleNewsList(),
                  SingleNewsList(),
                  SingleNewsList(),
                  SingleNewsList(),
                  SingleNewsList(),
                  SingleNewsList(),
                  SingleNewsList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
