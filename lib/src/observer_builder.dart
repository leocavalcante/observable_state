part of observable_state;

/// A fine-grained control for [StateObserver].
/// [ObserverBuilder] can be used for little pieces of your UI.
class ObserverBuilder<S extends Observable<C>, C> extends StatefulWidget {
  final List<C> changes;
  final ObservableWidgetBuilder<S> builder;

  const ObserverBuilder(
      {Key key, @required this.builder, this.changes = const []})
      : super(key: key);

  @override
  _ObserverBuilderState<S, C> createState() => _ObserverBuilderState<S, C>();
}

class _ObserverBuilderState<S extends Observable<C>, C>
    extends StateObserver<ObserverBuilder<S, C>, S, C> {
  @override
  List<C> get changes => widget.changes;

  @override
  Widget build(BuildContext context) => widget.builder(context, state);
}
