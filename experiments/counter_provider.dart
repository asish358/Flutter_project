import 'package:flutter/foundation.dart';

class CounterProvider extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    if (count > 0) {
      count--;
      notifyListeners();
    }
  }

  void reset() {
    count = 0;
    notifyListeners();
  }
}
