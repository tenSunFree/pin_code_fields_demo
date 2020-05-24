import 'dart:async';
import 'dart:ui';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class HomePage extends StatefulWidget {
  final String phoneNumber;

  HomePage(this.phoneNumber);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQueryData.fromWindow(window).padding.top),
              buildBackIcon(),
              SizedBox(height: 8),
              buildEnterConfirmationCodeText(context),
              SizedBox(height: 8),
              buildConfirmationCodeSendingText(context),
              SizedBox(height: 32),
              buildPinCodeTextField(),
              buildConfirmationCodeErrorText(context),
              SizedBox(height: 24),
              buildResendText(context),
              buildFlareActor(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  Container buildBackIcon() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Icon(Icons.arrow_back, size: 28, color: Colors.black),
    );
  }

  SizedBox buildEnterConfirmationCodeText(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        "請輸入驗證碼",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  SizedBox buildConfirmationCodeSendingText(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        "驗證碼已發送至 ${widget.phoneNumber}",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey,
        ),
      ),
    );
  }

  Container buildPinCodeTextField() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: PinCodeTextField(
        length: 6,
        obsecureText: false,
        animationType: AnimationType.slide,
        pinTheme: PinTheme(
          activeColor: Colors.blue,
          borderWidth: 1,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: hasError ? Colors.red : Colors.white,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.blue.shade50,
        enableActiveFill: true,
        errorAnimationController: errorController,
        controller: textEditingController,
        beforeTextPaste: (text) {
          return true;
        },
        onChanged: (String value) {},
        onCompleted: (value) {
          if (value != "Aa1234") {
            errorController.add(ErrorAnimationType.shake);
            setState(() {
              hasError = true;
            });
          } else {
            setState(() {
              hasError = false;
              scaffoldKey.currentState.showSnackBar(
                SnackBar(
                    content: Text("輸入驗證碼正確"), duration: Duration(seconds: 2)),
              );
            });
          }
        },
      ),
    );
  }

  SizedBox buildConfirmationCodeErrorText(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        hasError ? "驗證碼輸入錯誤" : "",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          color: Colors.red,
        ),
      ),
    );
  }

  SizedBox buildResendText(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        "重新傳送驗證碼？",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          color: Colors.blue,
        ),
      ),
    );
  }

  Expanded buildFlareActor() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(96),
        child: FlareActor(
          "assets/loader.flr",
          animation: "{\"keyframes\":{\"nodes\":{\"995\":{\"framePosY",
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
      ),
      flex: 1,
    );
  }
}
