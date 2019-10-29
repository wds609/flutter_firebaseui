import 'package:flutter/material.dart';
import 'package:sports/constant/constant.dart';
import 'package:sports/data/step_counter.dart';
import 'package:sports/utils/firebase_auth_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GamePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GamePageState();
  }
}

class _GamePageState extends State<GamePage> {
  StepCounter _stepCounter;
  int _currentStepCountValue;
  WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    FirebaseAuthUtils.showLogInPageIfNedd(context);
    _stepCounter = StepCounter();
    _stepCounter.startListenStepCounter((stepCountValue) {
      Fluttertoast.showToast(msg: "stepCountValue is $stepCountValue");
      _currentStepCountValue = stepCountValue;
      _callJsStepCount(_currentStepCountValue);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _stepCounter.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    return _createGamePage(context);
  }

  Widget _createGamePage(BuildContext context) {
    return Scaffold(
        appBar: _createAppBar(context),
        body: _createBody(context),);
  }

  Widget _createAppBar(BuildContext context) {
    return AppBar(
      title: Text("Sports"),
    );
  }

  Widget _createBody(BuildContext context) {
    return WebView(
      initialUrl: Constant.gameInitialUrl,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: _configJavascriptChannels(),
      onWebViewCreated: (control) {
        _webViewController = control;
      },
    );
  }

  Set<JavascriptChannel> _configJavascriptChannels() {
    Set<JavascriptChannel> channels = Set();
    _addStepCounterChannel(channels);
    return channels;
  }

  void _addStepCounterChannel(Set<JavascriptChannel> channels) {
    channels.add(JavascriptChannel(
        name: Constant.stepCounterChannelName,
        onMessageReceived: (JavascriptMessage jsMessage) {
          if (jsMessage.message == Constant.getStepCountMessage) {
            _callJsStepCount(_currentStepCountValue);
          }
        }));
  }

  void _callJsStepCount(int currentStepCountValue) {
    if (_webViewController != null) {
      _webViewController
          .evaluateJavascript('onGetStepCount("$currentStepCountValue")');
    }
  }
}
