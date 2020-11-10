import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/styles.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String description;
  final String okText;

  const ConfirmationDialog({Key key, @required this.title, @required this.description, this.okText = 'Yes'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: StyleConfig.fullBoxBorder,
      ),
      backgroundColor: Colors.white,
      child: _buildDialog(context),
    );
  }

  Widget _buildDialog(BuildContext context) => Container(
        constraints: BoxConstraints(
          minHeight: 100,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(false),
                      borderRadius: StyleConfig.confirmLeftBoxBorder,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          border: Border(right: BorderSide(color: Colors.black12)),
                        ),
                        child: Center(child: Text('Cancel')),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(true),
                      borderRadius: StyleConfig.confirmRightBoxBorder,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                            child: Text(
                          okText,
                          style: TextStyle(color: ColorConfig.PRIMARY),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
