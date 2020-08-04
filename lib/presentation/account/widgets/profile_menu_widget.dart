import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/presentation/widgets/size_config.dart';

class ProfileMenuWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final size = SizeConfig.of(context);
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        leading: image,
        title: Text(
          name,
          style: TextStyle(
            fontSize: size.safeBlockHorizontal * 4,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Text(phone),
        onTap: onTap,
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
