import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:tokolink/model/user.dart';
import 'package:tokolink/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:tokolink/presentation/screens/widgets/label_widget.dart';
import 'package:http/http.dart' as http;

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool keyboardOpen = false;
  bool checked = false;
  SharedPreferences prefs;
  Map<String, String> headers;
  User user;
  bool loading = false;
  bool _loading = false;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  void initState() {
    super.initState();
    keyboardVisibilityListener();
    getData();
  }

  void getData() async{
    setState(() {
      loading = true;
    });
    prefs = await SharedPreferences.getInstance();
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': prefs.getString('token'),
    };
    var response = await http.get(GlobalConstant.BASE_URL+'/user/detail', headers: headers);
    final data = jsonDecode(response.body);
    print(data);
    if (response.statusCode != 200) {
      throw Exception(
          'Request failed with status ${response.statusCode}: ${response.body}');
    }else{
      setState(() {
        loading = false;
        user = User.fromJson(data['data']);

        name.text = user.name;
        phone.text = user.phone;
        email.text = user.email;
      });
      
    }
  }

  void saveUser() async {
    setState(() {
      _loading = true;
    });
    prefs = await SharedPreferences.getInstance();
    headers = {
      'Accept': 'application/json',
      'Authorization': prefs.getString('token'),
    };
    final response = await http.post(GlobalConstant.BASE_URL+'/user/edit',  headers: headers, body: {
      'name': name.text,
      'phone': phone.text,
      'email': email.text,
    });
    //final data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      setState(() {
        _loading = false;
      });
      final snackBar = SnackBar(content: Text('Profil berhasil diperbarui'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      await prefs.setString('name', name.text);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: (loading) ? Center(child:CircularProgressIndicator()) : Container(
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
                            LabelWidget(text: 'Nama Lengkap'),
                            TextFormField(
                              controller: name,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                              validator: (v) {
                                if (v.isEmpty) return 'Nama harus diisi';
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Masukkan Nama Anda',
                                prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                              ),
                            ),
                            SizedBox(height: 10),
                            LabelWidget(text: 'Telephone Number'),
                            TextFormField(
                              controller: phone,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                              validator: (v) {
                                if (v.isEmpty) return 'Nomor diperlukan';
                                if (v.substring(0, 1) == '0' || v.length < 10 || v.length > 12) return 'Format nomer salah';
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixText: '+62 | ',
                                hintText: 'Phone number',
                                prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                              ),
                            ),
                            SizedBox(height: 10),
                            LabelWidget(text: 'Email'),
                            TextFormField(
                              controller: email,
                              keyboardType: TextInputType.text,
                              inputFormatters: [
                                LowerCaseTextFormatter()
                              ],
                              style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                              validator: (v) {
                                if (v.isEmpty) return 'Email harus diisi';
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Masukkan Email Anda',
                                prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Card(
                    //   child: Padding(
                    //     padding: EdgeInsets.all(10),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.stretch,
                    //       children: <Widget>[
                    //         LabelWidget(text: 'Gender'),
                    //         TextFormField(
                    //           enabled: true,
                    //           decoration: InputDecoration(hintText: 'Input gender.'),
                    //         ),
                    //         SizedBox(height: 10),
                    //         LabelWidget(text: 'Date Of Birth'),
                    //         TextFormField(
                    //           enabled: true,
                    //           decoration: InputDecoration(hintText: 'Input date of birth.'),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async{
                        prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                        await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OnBoardingScreen() ));
                      },
                      child:Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text('Sign Out', style: TextStyle(color: ColorConfig.PRIMARY)),
                            trailing: Icon(Icons.arrow_forward_ios, color: ColorConfig.PRIMARY),
                          ),
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
                onPressed: () {
                  saveUser();
                },
                textColor: Colors.white,
                child: Text( (_loading) ? 'Loading...' : 'Save'),
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
class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toLowerCase(),
      selection: newValue.selection,
    );
  }
}