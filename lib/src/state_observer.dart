part of observable_state;

/// An extension of a [State] with an [Observer].
/// It will already observe what is in [changes] and unobseve them on dispose.
abstract class StateObserver<T extends StatefulWidget, O extends Observable, C>
    extends State<T> with Observer<C> {
  /// A list of changes to observe.
  List<C> get changes => [];

  /// The state container from the [ObservableProvider] of this context.
  O get state => ObservableProvider.of<O>(context).state;

  @override
  void initState() {
    super.initState();
    changes.forEach(observe);
  }

  @override
  void notify() {
    setState(() {});
  }

  @override
  void dispose() {
    changes.forEach(unobserve);
    super.dispose();
  }
}
