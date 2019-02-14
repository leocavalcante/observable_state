import 'dart:async';

import 'package:flutter/widgets.dart';

import 'mutation.dart';
import 'observable.dart';
import 'observable_provider.dart';

abstract class ObservableState<T extends StatefulWidget, P> extends State<T>
    with Observable<P> {
  P get state => ObservableProvider.of<P>(context).state;

  FutureOr<void> mutate(Mutation<P> mutation) async {
    mutation.context = context;
    await mutation.mutate();
    Observable.notifyMutation<P>(mutation.runtimeType, state);
  }

  @override
  void initState() {
    super.initState();
    observing.forEach(observe);
  }

  @override
  void notify(P _) {
    setState(() {});
  }

  @override
  void dispose() {
    observing.forEach(unobserve);
    super.dispose();
  }
}
