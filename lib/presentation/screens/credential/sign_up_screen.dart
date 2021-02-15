import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/global.dart';
import 'package:tokolink/localization/localization_const.dart';
import 'package:tokolink/presentation/screens/widgets/label_widget.dart';
import 'package:tokolink/presentation/utils/mixins/has_form_key_mixin.dart';
import 'package:http/http.dart' as http;
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
class CamelTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text[0]?.toUpperCase(),
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
  final bool _obscureText = true;
  bool _loading = false;
  // _toggle() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //   });
  // }

  void registerUser() async {
    setState(() {
      _loading = true;
    });
    final response = await http.post(GlobalConstant.BASE_URL+'/user/', body: {
      'username': _username,
      'name': _name,
      'phone': _phone,
      'email': _email,
      'password': _password,
      'repassword': _repassword
    });
    //final data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      setState(() {
        _loading = false;
      });
      await Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(phone: _phone)));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(getTranslated(context, 'sign_up')),
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
                LabelWidget(text: getTranslated(context, 'username')),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    LowerCaseTextFormatter()
                  ],
                  style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                  validator: (v) {
                    if (v.isEmpty) return getTranslated(context, 'empty_username');
                    return null;
                  },
                  onSaved: (v) => setState(() => _username = v),
                  decoration: InputDecoration(
                    hintText: getTranslated(context, 'username_hint'),
                    prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                  ),
                ),
                SizedBox(height: 10),
                LabelWidget(text: getTranslated(context, 'name')),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                  validator: (v) {
                    if (v.isEmpty) return getTranslated(context, 'empty_name');
                    return null;
                  },
                  onSaved: (v) => setState(() => _name = v),
                  decoration: InputDecoration(
                    hintText: getTranslated(context, 'name_hint'),
                    prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                  ),
                ),
                SizedBox(height: 10),
                LabelWidget(text: getTranslated(context, 'password')),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                  obscureText: _obscureText,
                  validator: (v) {
                    if (v.isEmpty) return getTranslated(context, 'empty_password');
                    return null;
                  },
                  onSaved: (v) => setState(() => _password = v),
                  decoration: InputDecoration(
                    hintText: getTranslated(context, 'password_hint'),
                    prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                  ),
                ),
                SizedBox(height: 10),
                LabelWidget(text: getTranslated(context, 're_type_password')),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                  obscureText: _obscureText,
                  validator: (v) {
                    if (v.isEmpty) return getTranslated(context, 'empty_re_type_password');
                    return null;
                  },
                  onSaved: (v) => setState(() => _repassword = v),
                  decoration: InputDecoration(
                    hintText: getTranslated(context, 're_type_password_hint'),
                    prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                  ),
                ),
                SizedBox(height: 10),
                LabelWidget(text: getTranslated(context, 'phone_number')),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                  validator: (v) {
                    if (v.isEmpty) return getTranslated(context, 'empty_number');
                    if (v.substring(0, 1) == '0' || v.length < 10 || v.length > 12) return getTranslated(context, 'err_format_number');
                    return null;
                  },
                  onSaved: (v) => setState(() => _phone = v),
                  decoration: InputDecoration(
                    prefixText: '+62 | ',
                    hintText: getTranslated(context, 'phone_number_hint'),
                    prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                  ),
                ),
                SizedBox(height: 10),
                LabelWidget(text: getTranslated(context, 'email')),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    LowerCaseTextFormatter()
                  ],
                  style: TextStyle(fontSize: 14, color: ColorConfig.PRIMARY),
                  validator: (v) {
                    if (v.isEmpty) return getTranslated(context, 'empty_email');
                    return null;
                  },
                  onSaved: (v) => setState(() => _email = v),
                  decoration: InputDecoration(
                    hintText: getTranslated(context, 'email_hint'),
                    prefixStyle: TextStyle(color: ColorConfig.PRIMARY),
                  ),
                ),
                SizedBox(height: 30),
                RaisedButton(
                  onPressed: () {
                    if(!_loading){
                      if (fk.currentState.validate()) {
                        save();
                        registerUser();
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(phone: _phone)));
                      }
                    }
                  },
                  textColor: Colors.white,
                  child: (_loading) ? Text(getTranslated(context, 'loading')): Text(getTranslated(context, 'btn_continue')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
