import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/presentation/widgets/size_config.dart';

class LabelWidget extends StatelessWidget {
  final String text;
  final bool primary;
  final bool center;
  final bool bigger;

  const LabelWidget({
    Key key,
    @required this.text,
    this.primary: false,
    this.center: false,
    this.bigger: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        textAlign: center ? TextAlign.center : TextAlign.left,
        style: TextStyle(
          fontSize: SizeConfig.of(context).safeBlockHorizontal * (bigger ? 5 : 4),
          fontWeight: FontWeight.w500,
          color: primary ? ColorConfig.PRIMARY : ColorConfig.N4,
        ),
      ),
    );
  }
}
