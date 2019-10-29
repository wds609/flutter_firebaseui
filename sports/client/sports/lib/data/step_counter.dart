import 'dart:async';

import 'package:pedometer/pedometer.dart';

class StepCounter {
  Pedometer _pedometer = new Pedometer();
  StreamSubscription<int> _subscription;

  void startListenStepCounter(void onData(int stepCountValue)) {
    _subscription =
        _pedometer.pedometerStream.listen(onData, cancelOnError: true);
  }

  void stopListening() {
    _subscription.cancel();
  }
}
