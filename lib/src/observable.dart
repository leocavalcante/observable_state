part of observable_state;

/// The interface for Observables, call [setState] with a [notify] parameter.
abstract class Observable<C> {
  /// This performs the [update] on the state then notifies about what change ([notify]) happened.
  void setState(void Function() update, {@required C notify}) {
    update();
    _notify(notify);
  }
}
