part of observable_state;

class _Observers<S, C> {
  static _Observers _instance;

  static _Observers<S, C> getInstance<S, C>() {
    if (_instance == null) {
      _instance = _Observers<S, C>();
    }

    return _instance;
  }

  void observe(C change, Observer<S, C> observable) {
    if (getInstance<S, C>().observables[change] == null) {
      getInstance<S, C>().observables[change] = <Observer<S, C>>[];
    }

    getInstance<S, C>().observables[change].add(observable);
  }

  void notify(C change) {
    if (change != null) {
      getInstance<S, C>().observables[change]?.forEach((o) => o.notify());
    }
  }

  void unobserve(C change, Observer<S, C> observable) {
    getInstance<S, C>().observables[change]?.remove(observable);
  }

  final Map<C, List<Observer<S, C>>> observables = {};
}

abstract class Observer<S, C> {
  List<C> get changes => [];

  void observe(C change) {
    _Observers.getInstance<S, C>().observe(change, this);
  }

  void notify();

  void unobserve(C change) {
    _Observers.getInstance<S, C>().unobserve(change, this);
  }
}
