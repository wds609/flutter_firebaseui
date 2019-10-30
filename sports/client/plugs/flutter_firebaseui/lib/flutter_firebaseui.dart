import 'dart:async';

import 'package:flutter/services.dart';

class FlutterFirebaseui {
  static const MethodChannel _channel =
      const MethodChannel('flutter_firebaseui');

  static Future<String> logIn() async {
    final String result = await _channel.invokeMethod('logIn');
    return result;
  }
}
