import 'package:flutter/material.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/presentation/credential/otp_screen.dart';
import 'package:tokolink/presentation/widgets/label_widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fk = GlobalKey<FormState>();
  String _phone = '';

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
          key: _fk,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 20),
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
                SizedBox(height: 30),
                RaisedButton(
                  onPressed: () {
                    if (_fk.currentState.validate()) {
                      _fk.currentState.save();
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
