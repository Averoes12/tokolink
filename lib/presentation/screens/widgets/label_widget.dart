import 'package:flutter/material.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/presentation/utils/mixins/has_size_mixin.dart';

class LabelWidget extends StatefulWidget {
  final String text;
  final bool primary;
  final bool center;
  final bool bigger;

  const LabelWidget({
    Key key,
    @required this.text,
    this.primary = false,
    this.center = false,
    this.bigger = false,
  }) : super(key: key);

  @override
  _LabelWidgetState createState() => _LabelWidgetState();
}

class _LabelWidgetState extends State<LabelWidget> with HasSizeMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Text(
        widget.text,
        textAlign: widget.center ? TextAlign.center : TextAlign.left,
        style: TextStyle(
          fontSize: appSize.safeBlockHorizontal * (widget.bigger ? 5 : 4),
          fontWeight: FontWeight.w500,
          color: widget.primary ? ColorConfig.PRIMARY : ColorConfig.N4,
        ),
      ),
    );
  }
}
