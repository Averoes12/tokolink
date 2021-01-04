import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final String img;

  const CustomDialogBox({Key key, this.title, this.descriptions, this.text, this.img}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  Widget contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20,top: 20, right: 20,bottom: 20
          ),
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (widget.img != null )? Image.asset(
                widget.img,
              ) : Container(),
              Text(widget.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text(widget.descriptions,style: TextStyle(fontSize: 14, color: Colors.grey[600]),textAlign: TextAlign.center,)
            ],
          ),
        ),
      ],
    );
  }
}