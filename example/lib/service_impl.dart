import 'dart:async';

import 'package:observable_state_example/service.dart';

class ServiceImpl implements Service {
  @override
  FutureOr<int> getCounter() {
    return Future.delayed(const Duration(seconds: 5), () => 42);
  }
}
