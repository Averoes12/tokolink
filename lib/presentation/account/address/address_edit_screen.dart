import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/presentation/widgets/label_widget.dart';

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
        title: Text('Edit Address'),
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
                        content: Text('Do you want to delete this address ?'),
                        actions: <Widget>[
                          FlatButton(onPressed: () {}, child: Text('No')),
                          FlatButton(onPressed: () {}, child: Text('Yes')),
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
                            LabelWidget(text: 'Full name'),
                            TextFormField(
                              enabled: true,
                              decoration: InputDecoration(hintText: 'Input full name.'),
                            ),
                            SizedBox(height: 10),
                            LabelWidget(text: 'Telephone number'),
                            TextFormField(
                              enabled: true,
                              decoration: InputDecoration(hintText: 'Input telephone number.'),
                            ),
                            SizedBox(height: 10),
                            LabelWidget(text: 'Address'),
                            TextFormField(
                              enabled: true,
                              maxLines: 4,
                              decoration: InputDecoration(hintText: 'Input address.'),
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
                              text: 'Set as primary',
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
                child: Text('Save'),
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
