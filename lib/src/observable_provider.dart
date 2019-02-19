part of observable_state;

class ObservableProvider<O extends Observable> extends InheritedWidget {
  ObservableProvider({
    Key key,
    @required this.state,
    @required this.child,
  }) : super(key: key, child: child);

  final O state;
  final Widget child;

  static _targetType<T>() => T;

  static ObservableProvider<O> of<O extends Observable>(BuildContext context) {
    return context
        .inheritFromWidgetOfExactType(_targetType<ObservableProvider<O>>());
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
