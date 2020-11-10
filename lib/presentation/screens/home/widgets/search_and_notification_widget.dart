import 'package:flutter/material.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';

import '../search_screen.dart';

class SearchAndNotificationWidget extends StatelessWidget {
  final bool hasNotification;

  const SearchAndNotificationWidget({Key key, this.hasNotification = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen())),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search'),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              print('notifikasi');
            },
            icon: Icon(
              hasNotification ? Icons.notifications_active : Icons.notifications,
              size: 30,
              color: ColorConfig.N4,
            ),
          ),
        ],
      ),
    );
  }
}
