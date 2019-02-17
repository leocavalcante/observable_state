import 'package:observable_state/observable_state.dart';

enum Changes {
  increment,
}

class MyState extends Observable<MyState, Changes> {
  MyState({int counter = 0}) : _counter = counter;

  int _counter;
  int get counter => _counter;

  void increment() {
    setState(() => _counter++, notify: Changes.increment);
  }
}
