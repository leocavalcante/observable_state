import 'package:observable_state/observable_state.dart';
import 'package:rxdart/rxdart.dart' hide Observable;

enum Changes { increment }

class MyState extends Observable<Changes> {
  final counter = BehaviorSubject<int>.seeded(0);

  void increment() {
    counter.add(counter.value + 1);
  }

  void dispose() {
    counter.close();
  }
}
