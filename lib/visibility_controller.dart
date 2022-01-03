import 'dart:async';

import 'package:flutter/cupertino.dart';

class visibility_controller extends ChangeNotifier {
  double visibility = 1.0;
  late Timer time;

  double get getvisibility {
    return visibility;
  }

  makeVisible() {
    visibility = 1.0;
    time.cancel();
    notifyListeners();
  }
  start() {
    print("Hello!");
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      time = timer;
      visibility -= 0.01;
      if(visibility.isNegative)
        {
          timer.cancel();
        }
      else
        {

        }
      notifyListeners();
    });
  }
  bool get isVisible {
    return visibility > 0.0 ? true : false;
  }
}