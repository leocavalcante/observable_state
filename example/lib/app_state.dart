import 'package:example/routes.dart';
import 'package:observable_state/observable_state.dart';

enum Changes {
  increment,
}

class AppState extends Observable<AppState, Changes> {
  int _counter = 0;
  int get counter => _counter;

  String _initialRoute;
  String get initialRoute => _initialRoute;

  Future<void> initState() async {
    await Future.delayed(const Duration(seconds: 5));
    _initialRoute = routeNameHome;
  }

  void increment() {
    setState(() => _counter++, notify: Changes.increment);
  }
}
