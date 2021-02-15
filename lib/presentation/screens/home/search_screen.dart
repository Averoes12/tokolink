import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/localization/localization_const.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with HasSizeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: appSize.blockSizeVertical * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: getTranslated(context, 'search_field_hint'),
              ),
            ),
            Expanded(
              child: Container(
                child: Center(child: Text(getTranslated(context, 'search_not_found'))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
