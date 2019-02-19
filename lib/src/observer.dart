part of observable_state;

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

abstract class Observer<C> {
  void observe(C change) {
    _observe(change, this);
  }

  void unobserve(C change) {
    _unobserve(change, this);
  }

  void notify();
}
