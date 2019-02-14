import 'package:flutter/material.dart';
import 'package:observable_state_example/service.dart';

class DI extends InheritedWidget {
  DI({
    @required this.service,
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  final Service service;

  static DI of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(DI);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
