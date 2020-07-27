import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/presentation/widgets/size_config.dart';

class SinglePageOnBoard extends StatelessWidget {
  final Widget image;
  final String title;
  final String description;
  final int type;

  const SinglePageOnBoard({
    Key key,
    @required this.image,
    @required this.title,
    @required this.description,
    this.type: 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = SizeConfig.of(context);
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Container(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: ornament(type),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              image,
              SizedBox(height: 40),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                description,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget ornament(int type) {
    if (type == 2) return Image.asset('assets/img/ornament_2.png');
    if (type == 3) return Image.asset('assets/img/ornament_3.png');
    return Image.asset('assets/img/ornament_1.png');
  }
}
