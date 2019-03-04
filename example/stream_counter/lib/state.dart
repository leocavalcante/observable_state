import 'package:observable_state/observable_state.dart';
import 'package:rxdart/rxdart.dart' hide Observable;

enum Changes { increment }

class MyState extends Observable<Changes> {
  BehaviorSubject<int> _counter = BehaviorSubject<int>.seeded(0);
  BehaviorSubject<int> get counter => _counter;

  void increment() {
    _counter.add(_counter.value + 1);
  }
}
