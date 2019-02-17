part of observable_state;

abstract class Observable<S, C> {
  void setState(void Function() update, {@required C notify}) {
    update();
    _Observatory.getInstance<S, C>().notify(notify);
  }
}
