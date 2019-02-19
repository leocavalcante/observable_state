part of observable_state;

abstract class StateObserver<T extends StatefulWidget, O extends Observable, C>
    extends State<T> with Observer<C> {
  List<C> get changes => [];
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
