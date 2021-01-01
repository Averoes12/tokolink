import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/presentation/screens/widgets/label_widget.dart';
import 'package:tokolink/presentation/utils/mixins/has_form_key_mixin.dart';

import 'otp_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
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
class _SignUpScreenState extends State<SignUpScreen> with HasFormKeyMixin {
  String _username = '';
  String _name = '';
  String _password = '';
  String _repassword = '';
  String _phone = '';
  String _email = '';
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
        title: Text('Sign Up'),
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
                LabelWidget(text: 'Nama'),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                  validator: (v) {
                    if (v.isEmpty) return 'Nama harus diisi';
                    return null;
                  },
                  onSaved: (v) => setState(() => _name = v),
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama Anda',
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
                SizedBox(height: 10),
                LabelWidget(text: 'Ulangi Password'),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                  obscureText: _obscureText,
                  validator: (v) {
                    if (v.isEmpty) return 'Ulangi Password harus diisi';
                    return null;
                  },
                  onSaved: (v) => setState(() => _repassword = v),
                  decoration: InputDecoration(
                    hintText: 'Masukkan Lagi Password Anda',
                    prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                  ),
                ),
                SizedBox(height: 10),
                LabelWidget(text: 'Telephone Number'),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                  validator: (v) {
                    if (v.isEmpty) return 'Nomor diperlukan';
                    if (v.substring(0, 1) == '0' || v.length < 10 || v.length > 12) return 'Format nomer salah';
                    return null;
                  },
                  onSaved: (v) => setState(() => _phone = v),
                  decoration: InputDecoration(
                    prefixText: '+62 | ',
                    hintText: 'Phone number',
                    prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                  ),
                ),
                SizedBox(height: 10),
                LabelWidget(text: 'Email'),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                  validator: (v) {
                    if (v.isEmpty) return 'Email harus diisi';
                    return null;
                  },
                  onSaved: (v) => setState(() => _email = v),
                  decoration: InputDecoration(
                    hintText: 'Masukkan Email Anda',
                    prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                  ),
                ),
                SizedBox(height: 30),
                RaisedButton(
                  onPressed: () {
                    if (fk.currentState.validate()) {
                      save();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(phone: _phone)));
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
