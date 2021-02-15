import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/localization/localization_const.dart';
import 'package:tokolink/presentation/screens/widgets/label_widget.dart';

class AddressEditScreen extends StatefulWidget {
  @override
  _AddressEditScreenState createState() => _AddressEditScreenState();
}

class _AddressEditScreenState extends State<AddressEditScreen> {
  bool keyboardOpen = false;
  bool checked = false;

  @override
  void initState() {
    super.initState();
    keyboardVisibilityListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'edit_address')),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: ColorConfig.PRIMARY,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Text(getTranslated(context, 'dialog_delete')),
                        actions: <Widget>[
                          FlatButton(onPressed: () {}, child: Text(getTranslated(context, 'no'))),
                          FlatButton(onPressed: () {}, child: Text(getTranslated(context, 'yes'))),
                        ],
                      ));
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            LabelWidget(text: getTranslated(context, 'full_name_profile')),
                            TextFormField(
                              enabled: true,
                              decoration: InputDecoration(hintText: getTranslated(context, 'full_name_hint')),
                            ),
                            SizedBox(height: 10),
                            LabelWidget(text: getTranslated(context, 'phone_number')),
                            TextFormField(
                              enabled: true,
                              decoration: InputDecoration(hintText: getTranslated(context, 'phone_number_hint')),
                            ),
                            SizedBox(height: 10),
                            LabelWidget(text: getTranslated(context, 'address')),
                            TextFormField(
                              enabled: true,
                              maxLines: 4,
                              decoration: InputDecoration(hintText: getTranslated(context, 'address_hint')),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            LabelWidget(
                              text: getTranslated(context, 'set_as_primary'),
                            ),
                            Checkbox(value: checked, onChanged: (v) => setState(() => checked = v)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !keyboardOpen,
              child: RaisedButton(
                onPressed: () {},
                textColor: Colors.white,
                child: Text(getTranslated(context, 'btn_save')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void keyboardVisibilityListener() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() => keyboardOpen = visible);
      },
    );
  }
}
