import 'package:flutter/material.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/styles.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';

class SingleNewsList extends StatefulWidget {
  final String author;
  final String date;
  final String title;
  final String shortDescription;
  final ImageProvider image;
  final VoidCallback onTap;

  const SingleNewsList({
    Key key,
    this.author = 'Author',
    this.date = '06/07/2020',
    this.title = 'Title of news',
    this.shortDescription = 'Short Description',
    this.onTap,
    this.image = const NetworkImage('https://placehold.it/500'),
  }) : super(key: key);

  @override
  _SingleNewsListState createState() => _SingleNewsListState();
}

class _SingleNewsListState extends State<SingleNewsList> with HasSizeMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 160,
        margin: EdgeInsets.only(bottom: 20),
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Positioned(
              right: 0,
              bottom: 0,
              child: Card(
                elevation: 5,
                margin: EdgeInsets.zero,
                child: Container(
                  padding: EdgeInsets.only(
                    left: appSize.blockSizeHorizontal * 15 + 10,
                    right: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  height: 140,
                  width: appSize.blockSizeHorizontal * 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.author,
                            style: TextStyle(
                              fontSize: appSize.safeBlockHorizontal * 3,
                              color: ColorConfig.PRIMARY,
                            ),
                          ),
                          Text(
                            widget.date,
                            style: TextStyle(fontSize: appSize.safeBlockHorizontal * 3),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.title,
                        style: TextStyle(fontSize: appSize.safeBlockHorizontal * 4),
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.shortDescription,
                        style: TextStyle(
                          fontSize: appSize.safeBlockHorizontal * 3,
                          color: ColorConfig.N3,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 140,
                width: appSize.blockSizeHorizontal * 25,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: StyleConfig.mainBoxBorder,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.topCenter,
                    image: NetworkImage('https://placehold.it/500'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
