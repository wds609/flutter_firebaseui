import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sports/utils/firebase_auth_utils.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String _phoneNumber;
  String _verificationId;
  String _smsCode;

  @override
  Widget build(BuildContext context) {
    return _createLoginPage(context);
  }

  Widget _createLoginPage(BuildContext context) {
    return IntrinsicWidth(
      stepWidth: 56.0,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Phone number quick login",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
                decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: TextStyle(fontSize: 16, color: Colors.black54),
                    suffix: OutlineButton(
                        onPressed: () {
                          FirebaseAuthUtils.getVerificationCode(_phoneNumber,
                              onSuccess: (verificationId) =>
                                  _verificationId = verificationId,
                              onFail: (exception) {});
                        },
                        child: Text(
                          "Get code",
                          style: TextStyle(fontSize: 15, color: Colors.black26),
                        ),
                        shape: StadiumBorder()),
                    focusedBorder: UnderlineInputBorder()),
                cursorColor: Colors.redAccent,
                keyboardType: TextInputType.phone,
                onChanged: (String text) {
                  _phoneNumber = text;
                }),
            Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Verification Code",
                        labelStyle:
                            TextStyle(fontSize: 16, color: Colors.black54),
                        focusedBorder: UnderlineInputBorder()),
                    cursorColor: Colors.redAccent,
                    keyboardType: TextInputType.number,
                    onChanged: (String text) {
                      _smsCode = text;
                    })),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: RaisedButton(
                onPressed: () {
                  FirebaseAuthUtils.signIn(_verificationId, _smsCode,
                      onSuccess: (AuthResult result) {
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(msg: "Login Success!");
                  }, onError: (error) {
                    Fluttertoast.showToast(msg: "Login Failed!");
                  });
                },
                child: Text("Login"),
                shape: StadiumBorder(),
                color: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
