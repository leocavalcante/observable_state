part of observable_state;

/// The Observer that will be notified about changes it are listening to.
abstract class Observer<C> {
  /// The method that will be called when a change is notified.
  void notify(C change);
}
