import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/presentation/news/widgets/single_news_list.dart';
import 'package:tokolink/presentation/widgets/size_config.dart';

class NewsSection extends StatefulWidget {
  @override
  _NewsSectionState createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  @override
  Widget build(BuildContext context) {
    final size = SizeConfig.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: size.blockSizeVertical * 6),
          Text('News', textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
          SizedBox(height: size.blockSizeVertical * 2),
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
