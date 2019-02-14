abstract class Observable<P> {
  static Map<Type, List<Observable>> _observables = {};

  static void notifyMutation<P>(Type mutationType, P state) {
    if (_observables[mutationType] != null) {
      _observables[mutationType].forEach((o) => o.notify(state));
    }
  }

  List<Type> get observing => [];

  void observe(Type mutationType) {
    if (_observables[mutationType] == null) {
      _observables[mutationType] = [];
    }

    _observables[mutationType].add(this);
  }

  void unobserve(Type mutationType) {
    _observables[mutationType].remove(this);
  }

  void notify(P state);
}
