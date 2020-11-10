import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';

class ProfileMenuWidget extends StatefulWidget {
  final Widget image;
  final String name;
  final String phone;
  final VoidCallback onTap;

  const ProfileMenuWidget({
    Key key,
    this.image,
    this.name = 'Username',
    this.phone = 'No phone',
    this.onTap,
  }) : super(key: key);

  @override
  _ProfileMenuWidgetState createState() => _ProfileMenuWidgetState();
}

class _ProfileMenuWidgetState extends State<ProfileMenuWidget> with HasSizeMixin {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        leading: widget.image,
        title: Text(
          widget.name,
          style: TextStyle(
            fontSize: appSize.safeBlockHorizontal * 4,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(widget.phone),
        onTap: widget.onTap,
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
