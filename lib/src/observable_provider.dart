part of observable_state;

/// The [InheritedWidget] that provides an [Observable] for the tree on its context.
class ObservableProvider<O extends Observable> extends InheritedWidget {
  ObservableProvider({
    Key key,
    @required this.state,
    @required this.child,
  }) : super(key: key, child: child);

  /// The Observable State
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
