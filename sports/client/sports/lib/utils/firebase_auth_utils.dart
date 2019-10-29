import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports/pages/login_page.dart';

class FirebaseAuthUtils {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static void getVerificationCode(String phoneNumber,
      {void onSuccess(String verificationId),
      void onFail(AuthException exception)}) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) {},
        verificationFailed: (AuthException exception) {
          onFail(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          onSuccess(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  static void signIn(String verificationId, String smsCode,
      {void onSuccess(AuthResult result), void onError(error)}) {
    var credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    _firebaseAuth
        .signInWithCredential(credential)
        .then((value) => onSuccess(value))
        .catchError((error) => onError(error));
  }

  static void showLogInPageIfNedd(BuildContext context) async {
    var currentUser = await _firebaseAuth.currentUser();
    if (currentUser == null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Dialog(
                child: LoginPage(),
              ));
    }
  }
}
