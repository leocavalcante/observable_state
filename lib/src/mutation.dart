import 'dart:async';

import 'package:flutter/widgets.dart';

import 'observable_provider.dart';

abstract class Mutation<T> {
  BuildContext context;

  T get state {
    assert(
        context != null, 'Can not get the Observable state of a null context');
    return ObservableProvider.of<T>(context).state;
  }

  FutureOr<void> mutate();
}
