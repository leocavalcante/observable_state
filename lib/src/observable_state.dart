part of observable_state;

abstract class ObservableState<T extends StatefulWidget, S, C> extends State<T>
    with Observer<S, C> {
  S get state => ObservableProvider.of<S>(context).state;

  @override
  void initState() {
    super.initState();
    changes.forEach(observe);
  }

  @override
  void notify() {
    print('Notify called');

    setState(() {});
  }

  @override
  void dispose() {
    changes.forEach(unobserve);
    super.dispose();
  }
}
