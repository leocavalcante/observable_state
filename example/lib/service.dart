import 'dart:async';

abstract class Service {
  FutureOr<int> getCounter();
}
