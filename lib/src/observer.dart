part of observable_state;

/// The Observer that will be notified about changes it are listening to.
abstract class Observer<C> {
  /// Start observing a [change].
  void observe(C change) {
    _observe(change, this);
  }

  /// Stop observing a [change].
  void unobserve(C change) {
    _unobserve(change, this);
  }

  /// The method that will be called when a change is notified.
  void notify();
}

final _observers = <dynamic, List<Observer>>{};

void _observe<C>(C change, Observer<C> observer) {
  if (!_observers.containsKey(change)) {
    _observers[change] = <Observer<C>>[];
  }

  _observers[change].add(observer);
}

void _unobserve<C>(C change, Observer<C> observer) {
  if (_observers.containsKey(change)) {
    _observers[change].remove(observer);
  }
}

void _notify<C>(C change) {
  if (_observers.containsKey(change)) {
    _observers[change].forEach((observer) => observer.notify());
  }
}
