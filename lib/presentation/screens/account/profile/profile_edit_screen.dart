import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/presentation/screens/widgets/label_widget.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
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
        title: Text('Edit Profile'),
        centerTitle: true,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            LabelWidget(text: 'Gender'),
                            TextFormField(
                              enabled: true,
                              decoration: InputDecoration(hintText: 'Input gender.'),
                            ),
                            SizedBox(height: 10),
                            LabelWidget(text: 'Date Of Birth'),
                            TextFormField(
                              enabled: true,
                              decoration: InputDecoration(hintText: 'Input date of birth.'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text('Sign Out', style: TextStyle(color: ColorConfig.PRIMARY)),
                          trailing: Icon(Icons.arrow_forward_ios, color: ColorConfig.PRIMARY),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
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
