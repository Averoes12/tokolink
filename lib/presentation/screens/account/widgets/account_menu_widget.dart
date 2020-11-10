import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';

class AccountMenuWidget extends StatefulWidget {
  final Widget image;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const AccountMenuWidget({
    Key key,
    this.image,
    this.title = 'Title',
    this.subtitle = 'No subtitle',
    this.onTap,
  }) : super(key: key);

  @override
  _AccountMenuWidgetState createState() => _AccountMenuWidgetState();
}

class _AccountMenuWidgetState extends State<AccountMenuWidget> with HasSizeMixin {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      leading: widget.image,
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: appSize.safeBlockHorizontal * 4,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(widget.subtitle),
      onTap: widget.onTap,
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
