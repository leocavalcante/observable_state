import 'dart:async';

import 'package:observable_state/observable_state.dart';

enum Changes {
  increment,
  willAsyncIncrement,
  doneAsyncIncrement,
}

class Properties {
  int _counter;
  bool _loading;
}

class MyState extends Observable<MyState, Changes> with Properties {
  int get counter => _counter;
  bool get loading => _loading;

  Future initState() {
    return Future.delayed(
      const Duration(seconds: 5),
      () => setState(() => _counter = 42),
    );
  }

  void increment() {
    setState(() => _counter++, notify: Changes.increment);
  }

  Future<void> asyncIncrement() async {
    setState(() => _loading = true, notify: Changes.willAsyncIncrement);

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _counter += 1;
      _loading = false;
    }, notify: Changes.doneAsyncIncrement);
  }
}
