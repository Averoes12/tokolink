import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:tokolink/infrastructure/constants/colors.dart';
import 'package:tokolink/infrastructure/constants/styles.dart';
import 'package:tokolink/presentation/screens/main_screen.dart';
import 'package:tokolink/presentation/screens/widgets/label_widget.dart';

class OTPScreen extends StatefulWidget {
  final String phone;

  const OTPScreen({Key key, @required this.phone}) : super(key: key);
  
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController controller = TextEditingController();
  int pinLength = 4;
  bool hasError = false;

  CountdownTimerController countController;
  @override
  void initState() {
    super.initState();
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
    countController = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  onEnd() {
    print('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 20),
                    LabelWidget(text: 'Enter the verification code sent via'),
                    LabelWidget(text: '(+62) ${widget.phone}', primary: true),
                    SizedBox(height: 20),
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: PinCodeTextField(
                        autofocus: true,
                        pinBoxWidth: 50,
                        pinBoxHeight: 50,
                        controller: controller,
                        hideCharacter: false,
                        highlight: true,
                        highlightColor: ColorConfig.PRIMARY,
                        defaultBorderColor: ColorConfig.N3,
                        hasTextBorderColor: ColorConfig.N1,
                        maxLength: pinLength,
                        hasError: hasError,
                        maskCharacter: '😎',
                        onTextChanged: (text) {
                          setState(() {
                            hasError = false;
                          });
                        },
                        onDone: (text) {
                          print('DONE $text');
                          print('DONE CONTROLLER ${controller.text}');
                        },
                        wrapAlignment: WrapAlignment.spaceAround,
                        pinBoxDecoration: StyleConfig.defaultPinBoxDecoration,
                        pinTextStyle: TextStyle(fontSize: 20.0, color: ColorConfig.ACCENT),
                        pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                        pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                        highlightPinBoxColor: ColorConfig.N2,
                        highlightAnimationBeginColor: Colors.black,
                        highlightAnimationEndColor: Colors.white12,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 40),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
                      },
                      textColor: Colors.white,
                      child: Text('Continue'),
                    ),
                    SizedBox(height: 30),
                    CountdownTimer(
                      controller: countController,
                      widgetBuilder: (_, CurrentRemainingTime time) {
                        if (time == null) {
                          return FlatButton(
                            onPressed: () {},
                            textColor: ColorConfig.PRIMARY,
                            child: Text('Resend verification code?'),
                          );
                        }
                        return LabelWidget(
                          text: 'Request a new verification code in 00:${time.sec} ',
                          center: true,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
