part of observable_state;

class ObservableModel<S, C> {
  void setState(void Function() update, {C notify}) {
    update();
    _Observatory.getInstance<S, C>().notify(notify);
  }
}
