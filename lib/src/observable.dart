part of observable_state;

abstract class Observable<C> {
  void setState(void Function() update, {@required C notify}) {
    update();
    _notify(notify);
  }
}
