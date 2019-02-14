import 'package:flutter/widgets.dart';

class ObservableProvider<T> extends InheritedWidget {
  ObservableProvider({
    Key key,
    @required this.child,
    @required this.state,
  }) : super(key: key, child: child);

  final Widget child;
  final T state;

  static _targetType<T>() => T;
  static ObservableProvider<T> of<T>(BuildContext context) => context
      .inheritFromWidgetOfExactType(_targetType<ObservableProvider<T>>());

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
