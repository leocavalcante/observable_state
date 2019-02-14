import 'dart:async';

import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';

class MyProps {
  int counter = 0;
}

abstract class MyState<T extends StatefulWidget>
    extends ObservableState<T, MyProps> {
  int get counter => state.counter;
}

class Increment extends Mutation<MyProps> {
  @override
  FutureOr<void> mutate() => state.counter++;
}
