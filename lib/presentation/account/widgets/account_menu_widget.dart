import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/presentation/widgets/size_config.dart';

class AccountMenuWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final size = SizeConfig.of(context);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      leading: image,
      title: Text(
        title,
        style: TextStyle(
          fontSize: size.safeBlockHorizontal * 4,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(subtitle),
      onTap: onTap,
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
