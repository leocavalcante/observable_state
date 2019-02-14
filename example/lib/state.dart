import 'dart:async';

import 'package:flutter/material.dart';
import 'package:observable_state/observable_state.dart';

class Props {
  int counter;
}

abstract class MyState<T extends StatefulWidget>
    extends ObservableState<T, Props> {
  int get counter => state.counter;
}

class Increment extends Mutation<Props> {
  @override
  FutureOr<void> mutate() => state.counter++;
}
