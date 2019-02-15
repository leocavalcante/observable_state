part of observable_state;

abstract class StateObserver<T extends StatefulWidget, S, C> extends State<T>
    with Observer<S, C> {
  S get state => ObservableProvider.of<S>(context).state;

  @override
  void initState() {
    super.initState();
    subjects.forEach(observe);
  }

  @override
  void notify() {
    setState(() {});
  }

  @override
  void dispose() {
    subjects.forEach(unobserve);
    super.dispose();
  }
}
