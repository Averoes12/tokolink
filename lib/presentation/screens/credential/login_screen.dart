import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:tokolink/presentation/screens/widgets/label_widget.dart';
import 'package:tokolink/presentation/utils/mixins/has_form_key_mixin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
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
class _LoginScreenState extends State<LoginScreen> with HasFormKeyMixin {
  String _username = '';
  String _password = '';
  final bool _obscureText = true;
  bool _loading = false;
  SharedPreferences prefs;
  // void _toggle() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //   });
  // }
  void login(context) async {
    setState(() {
      _loading = true;
    });
    final response = await http.post(GlobalConstant.BASE_URL+'/user/login', body: {
      'username': _username,
      'password': _password,
    });
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _loading = false;
      });
      prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['data']['token']).then((value) => {
        prefs.setString('name', data['data']['name']),
        if(data['data']['storeToken'] != null){
          prefs.setString('storeToken', data['data']['storeToken'])
        },
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()))
      });
      
    }else{
      setState(() {
        _loading = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red[900],
        content: Text(data['message']),
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) => Container(
          child: Form(
            key: fk,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 20),
                  Image.asset('assets/img/logo.png'),
                  SizedBox(height: 40),
                  LabelWidget(text: 'Username'),
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      LowerCaseTextFormatter()
                    ],
                    style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                    validator: (v) {
                      if (v.isEmpty) return 'Username harus diisi';
                      return null;
                    },
                    onSaved: (v) => setState(() => _username = v),
                    decoration: InputDecoration(
                      hintText: 'Masukkan Username Anda',
                      prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                    ),
                  ),
                  SizedBox(height: 10),
                  LabelWidget(text: 'Password'),
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                    obscureText: _obscureText,
                    validator: (v) {
                      if (v.isEmpty) return 'Password harus diisi';
                      return null;
                    },
                    onSaved: (v) => setState(() => _password = v),
                    decoration: InputDecoration(
                      hintText: 'Masukkan Password Anda',
                      prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                    ),
                  ),
                  SizedBox(height: 30),
                  RaisedButton(
                    onPressed: () {
                      if (fk.currentState.validate()) {
                        save();
                        login(context);
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                      }
                    },
                    textColor: Colors.white,
                    child: (_loading) ? Text('Loading...'): Text('Continue'),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
