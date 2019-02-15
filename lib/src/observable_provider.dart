part of observable_state;

class ObservableProvider<S> extends InheritedWidget {
  ObservableProvider(
    this.state, {
    Key key,
    @required this.child,
  }) : super(key: key, child: child);

  final S state;
  final Widget child;

  static _targetType<T>() => T;
  static ObservableProvider<T> of<T>(BuildContext context) => context
      .inheritFromWidgetOfExactType(_targetType<ObservableProvider<T>>());

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
