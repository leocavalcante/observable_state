part of observable_state;

/// The interface for Observables, call [setState] with a [notify] parameter.
abstract class Observable<C> {
  final _observers = <C, List<Observer<C>>>{};

  /// This performs the [update] on the state then notifies about what change ([notify]) happened.
  void setState(void Function() update, {@required C notify}) {
    update();
    _notify(notify);
  }

  /// Start observing a [change].
  void observe(C change, Observer observer) {
    if (!_observers.containsKey(change)) {
      _observers[change] = [];
    }

    _observers[change].add(observer);
  }

  /// Stop observing a [change].
  void unobserve(C change, Observer<C> observer) {
    if (_observers.containsKey(change)) {
      _observers[change].remove(observer);
    }
  }

  /// Notify [Observer]s about a [change].
  void _notify(C change) {
    if (_observers.containsKey(change)) {
      _observers[change].forEach((observer) => observer.notify(change));
    }
  }
}
