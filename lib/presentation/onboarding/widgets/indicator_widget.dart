import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';

class IndicatorWidget extends StatelessWidget {
  final int length;
  final int activeIndex;

  const IndicatorWidget({Key key, this.length, this.activeIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            length,
            (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: index == activeIndex ? ColorConfig.PRIMARY : ColorConfig.N3,
                    shape: BoxShape.circle,
                  ),
                )).toList(),
      ),
    );
  }
}
