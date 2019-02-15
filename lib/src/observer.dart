part of observable_state;

class _Observatory<S, C> {
  static _Observatory _instance;

  static _Observatory<S, C> getInstance<S, C>() {
    if (_instance == null) {
      _instance = _Observatory<S, C>();
    }

    return _instance;
  }

  void observe(C change, Observer<S, C> observable) {
    if (getInstance<S, C>()._subject[change] == null) {
      getInstance<S, C>()._subject[change] = <Observer<S, C>>[];
    }

    getInstance<S, C>()._subject[change].add(observable);
  }

  void notify(C change) {
    if (change != null) {
      getInstance<S, C>()._subject[change]?.forEach((o) => o.notify());
    }
  }

  void unobserve(C change, Observer<S, C> observable) {
    getInstance<S, C>()._subject[change]?.remove(observable);
  }

  final Map<C, List<Observer<S, C>>> _subject = {};
}

abstract class Observer<S, C> {
  List<C> get subjects => [];

  void observe(C change) {
    _Observatory.getInstance<S, C>().observe(change, this);
  }

  void notify();

  void unobserve(C change) {
    _Observatory.getInstance<S, C>().unobserve(change, this);
  }
}
