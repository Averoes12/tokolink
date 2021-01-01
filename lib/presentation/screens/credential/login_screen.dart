import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/presentation/screens/widgets/label_widget.dart';
import 'package:tokolink/presentation/utils/mixins/has_form_key_mixin.dart';

import '../main_screen.dart';
import 'otp_screen.dart';

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
  bool _obscureText = true;
  
  _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
      ),
      body: Container(
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                    }
                  },
                  textColor: Colors.white,
                  child: Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
